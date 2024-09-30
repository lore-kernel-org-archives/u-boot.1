Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6712CE8374
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 16:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3039B88F94;
	Mon, 30 Sep 2024 18:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qxi2RY1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472DD88CF1; Mon, 30 Sep 2024 18:31:12 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CBC88F9F
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb2e5d0104so34165946d6.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727713867; x=1728318667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNiw0vK3iLZChBCLvImBSIOuBA+SOQVmEM6qzBNY0WE=;
 b=Qxi2RY1vR5rtI7j7yAJ1kmZZZZxwBC/gD7SVF17c3Bn7xyw2sWDpsuE+Re7Ar/Su0T
 lHH2jA1Q/0Y1HUEf6lbtnybRRCbG+0wEWb3+0uD1DXCX+eVdSLYbTl2+IddTM2DcZ21r
 NDZH3YBTAj6fau/KVyVcqPksIr64tAJe6bMsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727713867; x=1728318667;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNiw0vK3iLZChBCLvImBSIOuBA+SOQVmEM6qzBNY0WE=;
 b=AFCxsygoETo6lgBFcNI3LiJSbNxVmdSVgwwhS/dG5oWm0SbeLxYMFyqwBSuSJDnLiH
 i0Fg94/jC9AfN+LhKJgC3eQlkoWaCVkvJN5AUSZEZnReRHRCApLG2NCqaWYeI0znZ1Bu
 ElWNV3n/5gh0dNFUtF5rFiPD9NdTp5m+Yuq3kPDDjxlLmxwIHifiDd98VBScBJJV/H4A
 ztbsnCyvgRJDxNaG7m2YXKtWwTFLCDUgaH66JIRgR4dqs4nSuxdkE7D6XJrynkJGtvch
 43NQC2b/xSdMSa5z6duCRhRpE6O4wZkTg/G4lWkWiw+NUxoSL+zRlsjO27adYCM19bsU
 NvFQ==
X-Gm-Message-State: AOJu0Yy8BygyIYWMNeSpvbKGnJYlnpqLBMYXgweMSqnBs11+E4C9FGi1
 0q+mwAId+ab8Up0+Or3huQyhV0hlK1IElnvhGElOuv4tCh6qMdF8RkvsNp8YeuI=
X-Google-Smtp-Source: AGHT+IFBg1iBDd484I1UXPFq3f677bxEi/CONi90YDPKBLPXL4xGHJm1QhkzBiXxjxdS2ZJ+WFIB/w==
X-Received: by 2002:a05:6214:3bc9:b0:6cb:53c3:dc3a with SMTP id
 6a1803df08f44-6cb53c3e2f8mr112697726d6.32.1727713867307; 
 Mon, 30 Sep 2024 09:31:07 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b60fbf0sm41520376d6.37.2024.09.30.09.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 09:31:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: lukma@denx.de, mkorpershoek@baylibre.com, marex@denx.de, 
 rogerq@kernel.org, vigneshr@ti.com, jjhiblot@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20240930093407.2998969-1-s-vadapalli@ti.com>
References: <20240930093407.2998969-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] usb: gadget: cdns3: Fix missing cache operations for
 non-zero Endpoints
Message-Id: <172771386586.2406900.1428916275116433506.b4-ty@konsulko.com>
Date: Mon, 30 Sep 2024 10:31:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 30 Sep 2024 15:04:07 +0530, Siddharth Vadapalli wrote:

> Transfer initiation and completion for the non-zero Endpoints are
> handled by cdns3_ep_run_transfer() and cdns3_transfer_completed()
> respectively.
> 
> Failing to flush the cache associated with the TRB Pool within
> cdns3_ep_run_transfer() results in the transfers never being initiated.
> Similarly, failing to invalidate the cache associated with the TRB pool
> within cdns3_transfer_completed() results in the transfers never being
> completed.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


