Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4FBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AAF889E2;
	Tue, 30 Apr 2024 01:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V4dwC2SW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12CF889B7; Tue, 30 Apr 2024 01:04:17 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBAC4889CF
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78f02c96c52so369966085a.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431855; x=1715036655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wOurO5AxcGuTg7KDB06fLMvv8DBXHGNToFELECJAbQ=;
 b=V4dwC2SWllUxo/GQNXQgDikwwOuPtD2QPEUX1Ebn2zasZPhUmfMU9gNmoKJ6YP17wg
 tWQsgoo84MPp2JDV79C4XQJVkfqpOTbSJVRAW9hvK3nY30O5XdK//VyeOkCEIBPGpamy
 0B/CDbc0t4Ot0u1w9/z+463xJ9Q6zclLpVwuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431855; x=1715036655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wOurO5AxcGuTg7KDB06fLMvv8DBXHGNToFELECJAbQ=;
 b=Y0LKgzqZ5X/pSL2tQP0cdNWko2Hj2w/k3zZlHeg5rQZMrXvPg6EiAqq8jGU6TlHHPe
 sHT4TkigG35Hlo+Nfpm6w7xKGYLIwFpzuIWNFI1IVYyz9whdgiAUX2Bm2FHxLXLclge0
 l2dDvNfddQy0OYsN8AgqnHuxhY+1ssrei1IZmCooO/z3sT8HsNqz9Ixw5uc5Sj+PbMk7
 mK6YYkVwMAT6YBst2iTMBMiKhHFMnchSzgj5OsIw2wGzpedv+6M9SA4mvYOzE8ytQdIE
 3H5DrVEIshTsNXlzXFXMsTvyzTiRWhu9iF1k665j5WbHXr3Ip4brBj9hIw8pozAAcCAw
 AJ+A==
X-Gm-Message-State: AOJu0YwowJ0yMyVvzfvFBcjDHOyzIY7gIR/xklsBSiYZlX9bHBeRH+iR
 ktvydY5xacei/hPzHdtPwDot7lobzmzBsNiJkdVTM2xf0O1XS8YIrhyeWDvx9RM=
X-Google-Smtp-Source: AGHT+IHIClnElNZmIjYud1VbYahgqSzYCmv6lHF6E3FWyczQiGqyB7Mm6s+1aMGWNaVSylQ3tDCLLQ==
X-Received: by 2002:ae9:f30b:0:b0:790:f5b4:1a48 with SMTP id
 p11-20020ae9f30b000000b00790f5b41a48mr4934957qkg.12.1714431854725; 
 Mon, 29 Apr 2024 16:04:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240426154423.10547-1-afd@ti.com>
References: <20240426154423.10547-1-afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am62ax: Fix typo in ROM data macro name
Message-Id: <171443185342.1749944.10065287907451286138.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:13 -0600
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

On Fri, 26 Apr 2024 10:44:23 -0500, Andrew Davis wrote:

> s/ENTENDED/EXTENDED
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


