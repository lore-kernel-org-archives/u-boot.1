Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A78C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDF681F59;
	Mon, 31 Mar 2025 15:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uDW6K9be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8A981E47; Mon, 31 Mar 2025 15:46:28 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047BF81F54
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c14235af3so2829453a34.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428783; x=1744033583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch96O7luNleVkvn3oELHkjvDSrcpl7frpflHBgtsNQc=;
 b=uDW6K9beTpOp4eWFYtOWf2r8YkbYYGwlTor1wDIiHu3ZRkINOkZmP5Hq/e0C1qm5Lv
 cCfaicKJ76y6aLAywZ5X23a1zGLrp5gDfA2Lys45eJ5Sk+CWM2DeOMe1n+oL3aqU2vvo
 F4TohkIe47BwOXh5gao03aQfVbmnc5DVKM424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428783; x=1744033583;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ch96O7luNleVkvn3oELHkjvDSrcpl7frpflHBgtsNQc=;
 b=kS8Upz5XwVlmN/5MvbiK8Hk4j7S4MWgcK+dIA0ZLcmsfYRhx/gJP8cuGLlvXkBHWlP
 a+5r0TbXEBz/s+k/iihLT9Ok7bW01Dne5bi2DYYAXNYHszXr65LTbaJ25bb0nCmqtZn7
 VO8RdZIsDXJj8hcbVe9IobnLtGOakZbGSsbp1y0DVllwfq1Ux18Wi9fJvVAKyITslIM7
 MQYp6fQGqj/a/eq2inb7qU6Fi1XhdCLJuFhm02mDQ8aK92zZ+TxFrtW80MLI8fxJ1QLr
 gzqYVEuqYLZTydhJ3sMi38ehBggAGoKRLJCFAfczEhRmguUxkZkwIIdZ2jCv9gPMzdHh
 HQAg==
X-Gm-Message-State: AOJu0YyCLBQaehSMv1jBMj+9T7TdTTjg4moqY0qXhBUjoFmj1AK6dJa0
 Rk/5RfHQMk8SmxziADh197k8WglZpr/SP9hmPPsgpGqR/08EUrK6eV4M5nw4Ejs=
X-Gm-Gg: ASbGnctOmxn1YIC19eEd18objutRM6isxJs8oEKz9TOzkHkUHWImGsBu+zzzEPG0E2k
 +2wdRKmSOWnTovEspvZtM7hJ/jMQXhz+UDaImXFgzFwZ+TMuGum2VrYSsxa3bPbn7MUj3H1mkg/
 FLsgdj68/gr8ZTzVsbYOg1jcQmqRKiL5RTr6CHK+e+EPXXuPciePOGO6zpa3nBaMGLFhUrWHV8K
 qnWTlZksqK0ySyZnkbCggeFazhL9pXM4ErGpivVwGMm1pgrb7zn4OExTd2vuAGUjmgyqJmTxxD7
 tLiOp+jabLk0ZMl2y0c1g9QJ9ykFBkH405jb9L1WEj3+SG8hPZgB9CEo9h/1R9QN5z3KFOMKidv
 WrvxX
X-Google-Smtp-Source: AGHT+IHktjIKaBOITfI+lcEViU+hdOTeqlFxztpvuExRwzzodAzXut/Xt0BIqgUMEFMGLS8puEFtew==
X-Received: by 2002:a05:6830:2113:b0:72b:843c:ecf with SMTP id
 46e09a7af769-72c63817971mr6192583a34.20.1743428783101; 
 Mon, 31 Mar 2025 06:46:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250311093546.3371193-1-anshuld@ti.com>
References: <20250311093546.3371193-1-anshuld@ti.com>
Subject: Re: [PATCH v3] spl: return header size to spl_load in os boot
Message-Id: <174342878230.1318045.5895330169068354045.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:22 -0600
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

On Tue, 11 Mar 2025 15:05:45 +0530, Anshul Dalal wrote:

> During linux build process the header size is computed including the BSS
> whereas it's removed when creating the uncompressed image. Therefore the
> size of the uncompressed image on filesystem will be smaller than the
> size specified in the header.
> 
> This causes issues when loading the kernel image from the SPL (as in
> falcon boot) with spl_load since it compares the read file size from the
> FS to the header size form the image. Which leads to the following check
> in `include/spl_load.h` failing to -EIO when loading kernel image:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: return header size to spl_load in os boot
      commit: fd2bccec19d399b4a445009b3d514d2419cfbc95
-- 
Tom


