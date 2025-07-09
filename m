Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DE1C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E6B834EC;
	Wed,  9 Jul 2025 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gFuCqqtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E0C83510; Wed,  9 Jul 2025 16:22:05 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFD9834EC
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-401c43671ecso5273b6e.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070921; x=1752675721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/Z2HSn+cNGPLJp53MCrTAB2upcnOp5uZVTGDPlBhN4=;
 b=gFuCqqtKTwnzSnxe+NzyMz0zPk2SkWkWffoC2IzOuciW64Rt559ck+xzHAS85UZnMz
 ULaL2B3dbBnuVQIt7R9IB0GuicxKiSe8okQgofBfHLxVY3oIoc8UJfp5lz0O67T+T6xh
 oCKFF5UJLumhv4qvXeBla0dZ9r5GrxcwCgZ2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070921; x=1752675721;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/Z2HSn+cNGPLJp53MCrTAB2upcnOp5uZVTGDPlBhN4=;
 b=wKGukJqzPxrT5vc9K+Qp/h0yY7KB9R3gqON1rf5aMYv7UY4Sik7M13efn2ZU/IeIjS
 uwCsZjFrJgD+UBFyGQpeFCUw/xhGc5qqiXRTycVsjHgpfhZuRw2OQ+cXCk3Y+OxT/iDk
 lVSaMuNqOI1v5mhb3u7pDSwY7bupulVDuOhchuveoHqTFKdXfqbKcVUEKZl3k1MIov8g
 gNLs72rTPtVmJIVGY+LXRjldzXgxLyfRXTVXKDO259qtsSdLqMkue0/mEkWXcVKOZfhR
 RX+EiZGRWYcpVSCuMHkE3oXHhDinXhNp1B2O/0A/UnLomP663CI9dwbrny12jiPArTHY
 2JsQ==
X-Gm-Message-State: AOJu0YwxZhTUpgt1WrK0pjM1nab79RAr0hESWxxuVOl3JPCtJow4FwqR
 eU0S8O1gVHaBEvNdVLj6W93qndpiLACYWD/xMSoa326yMwHHnu4Lx4e6cxk8yP+8XbE=
X-Gm-Gg: ASbGncv5NIXPSrproFQs9SzWUF+93vR6EYz4ijZrKXOPHQR6MXE7flt9LgPn2TNxbtk
 c4ftDmb6oIPlAP4z8mhFOIz9KWr9OBa+D0IQdI4i7zrPxWnCGerep0eIvsO/LiNp35TxH/r19lT
 4UbkJHRSgg/nyb0hzguFjHduW/B9T5n6rPoUhJ2NvLASTNlGCdqiA42dLuurPY9mqV/bOZc+tTK
 j2wHQHW2bKULjI+INtmTgBd6siKCT2RxMGs4vyDVqLFZ/BIfEwGEyGq0fDVudt8wlWPJtHei8R/
 gPhmVo4SVzfb4EiFYl8lYiypgHAGXEr4M+B6RQCHfcSeyLiDiRFu06TQLKFCiUt7v/HTvKPPWZx
 vg26uMvnDJV28RkH98Nk=
X-Google-Smtp-Source: AGHT+IG+imRO82FFQ0nt2Llg0aeW0ej232mQz4j/2jdd+Ciif330LCmSAcAJ7AKZoh7Kh4CMmi1vfA==
X-Received: by 2002:a05:6808:4496:b0:40d:173:b1e1 with SMTP id
 5614622812f47-41146a61cfamr5426435b6e.4.1752070921454; 
 Wed, 09 Jul 2025 07:22:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: rfried.dev@gmail.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, danishanwar@ti.com, s-vadapalli@ti.com
In-Reply-To: <20250627055546.3706770-1-h-salunke@ti.com>
References: <20250627055546.3706770-1-h-salunke@ti.com>
Subject: Re: [PATCH] pci_endpoint: pci_cdns_ti_ep: Fix the include path for
 header file
Message-Id: <175207092045.1813324.795512029357777701.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 27 Jun 2025 11:25:46 +0530, Hrushikesh Salunke wrote:

> The commit under fixes tag includes "pcie-cadence.h" using angle
> brackets. Since the header file is not in standard include path change
> it to double quotes to ensure proper inclusion and avoid build issues,
> especially on older compilers.
> 
> 

Applied to u-boot/master, thanks!

[1/1] pci_endpoint: pci_cdns_ti_ep: Fix the include path for header file
      commit: 61a3e1b043068abc26fa2c72ac4d420c61dc1cd5
-- 
Tom


