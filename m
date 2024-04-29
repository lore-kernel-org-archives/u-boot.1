Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E11C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CD5889BB;
	Tue, 30 Apr 2024 01:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sBeQNTSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBCB889BE; Tue, 30 Apr 2024 01:04:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99BB888966
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ea1f98f3b9so2151083a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431844; x=1715036644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bho1BjaSPrx63tRwqaE+zdhKVx9uPjFfEsjMnlib8yE=;
 b=sBeQNTSf2BQ4juKAKlhWzzLNAijvbub0aAW3lJ2Jn1BT009a4aN2+UNS/EkWN9ZJz0
 ph3JLwSWIZDDEBcklCUfzO7XCldRFKvsCfwz8ox5ZpBjlZ3SZ+Fowes3CO9Ch3eTFLkT
 YE4y0YWQQeDCXz/uWy0It09rjhXZSPZQRGpeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431844; x=1715036644;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bho1BjaSPrx63tRwqaE+zdhKVx9uPjFfEsjMnlib8yE=;
 b=dPuLJDfnCQn7q45lEfrLODwaKR+vCqRifXPMoI28SQWe8Vjfj9HRC+2KZ9y7yx1Di+
 6LKJ6/p5Pw+DBLFVhJ5o2bfOR25I9y5AGRvoUFqj4couN7ceBGJT1KW3SbPUMr42IAtQ
 J1g9BrofkFo/a/t+E9EtsyQWb1VnLrYF/t0TtJrHV8miM8/RwfC+O4N6kF5IFEnH4+LO
 YC0btM0muwcEa4+d3M7+vh1YsArLB/ybUonFgTwGHYOW1/w5kE17kX6vBSV7U4B6aplm
 EjAA/1PPlgOtTUoEQ7Jz13qTVIyJNHCWXcbiFuqlFV0tGAsSdOPjPyf4E6KLSEIvm+PP
 WBGg==
X-Gm-Message-State: AOJu0YxbvuxetoPdMnk74STEPgwumA1DOijI3N8t7ptYAOr4zgeNafBa
 VrGn4TaHNKkzbJDUwWutDHjdAGYXE5vZILHe810XpfDVTWAS9zFK/EMQZt88pdY=
X-Google-Smtp-Source: AGHT+IGEQ2Bsn2U1A6cgmt1YvUJHKCrX6iEmtQshRftTwj3F5s/2xsKmlsi6Px0VvoNIDF7lQCay0w==
X-Received: by 2002:a05:6830:1296:b0:6ee:1742:4d25 with SMTP id
 z22-20020a056830129600b006ee17424d25mr1131957otp.12.1714431844293; 
 Mon, 29 Apr 2024 16:04:04 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: marcel.ziswiler@toradex.com, nm@ti.com, francesco.dolcini@toradex.com, 
 rogerq@kernel.org, stefan.eichenberger@toradex.com, 
 andrejs.cainikovs@toradex.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240417083921.13367-1-eichest@gmail.com>
References: <20240417083921.13367-1-eichest@gmail.com>
Subject: Re: [PATCH v1] arm: dts: verdin-am62: use gpio-hog for sleep moci
Message-Id: <171443184295.1749944.17897928843529701392.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:02 -0600
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

On Wed, 17 Apr 2024 10:39:21 +0200, Stefan Eichenberger wrote:

> In Linux, we allow sleep moci to be turned off when the carrier board
> supports it and the system is in suspend. In U-Boot, however, we want
> the sleep moci to be always on. So we use a gpio hog and disable the
> regulator. This change is necessary because we switched to upstream
> device tree files with commit c07bba7a2c7e ("verdin-am62: move verdin
> am62 to OF_UPSTREAM"). A recent upstream patch removes the gpio hog from
> the Linux device tree, so we need to add it to the u-boot dtsi. The
> following patch will remove the gpio hog from the Linux device tree:
> https://lore.kernel.org/linux-devicetree/20240301084901.16656-1-eichest@gmail.com/
> The U-Boot patch can be applied without it and will not break the build.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


