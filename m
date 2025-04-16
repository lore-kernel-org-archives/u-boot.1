Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64DC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9337E82F2B;
	Wed, 16 Apr 2025 16:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k22F7Rm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D86CA82F3B; Wed, 16 Apr 2025 16:10:58 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F4F82CE7
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso3587710fac.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812655; x=1745417455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyEoBWVUJdYsRsmm/rOiXPPprK0ji+C8SL+NVfU4H3o=;
 b=k22F7Rm+OPDKc3+TgGYI3kwqvto5CmAX/JAymnsQ0nyzcEGqS/YerLyCBpvyUlMdpf
 Ll5qT2IjWbtRbt+arberjaSIz8Xgb9Z/84od2GyyHreDneHeEGZ/dexB5sGiLY48zn5/
 uZezw167Ig2tkOKZM8VS9fE8DOpdyPIZmhzvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812655; x=1745417455;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyEoBWVUJdYsRsmm/rOiXPPprK0ji+C8SL+NVfU4H3o=;
 b=RBRl22/NhYiPl3+mOK9kOlLOQ3COKL5kXEh/2yi/mJTKOOSthWVM4rFs5Gh6DGa8aT
 L7C4Ly0GI3+uw9+D/Za77UN7c2uZQt7JUa0OImgGV8su+GpgeJeBgIUHEeU0ilYGR/PB
 D2058QfSvpO0NusdnLSPvIE+6kOaOR10UOYu7A1O+qvCLdcAy02cEIVWiidcNhUvRrOk
 4XrrJiYWEoy9BuFc/ElNdRWM8M8G2DHW9KY1cKimaxz+QD9G39LJP5WxuT8f1hzukXyy
 bnN2pcK4zhCpY6zvqYcgvvbAxKn2DyAMd9h1PlAyLdxvXd1BHiaZ6fWFSixlsXCGjuHa
 Vxkg==
X-Gm-Message-State: AOJu0YzqaDz701Ju7BnfCg8oZMWdevdZg8YJOVQz0SazHFcxLIAt9ey6
 pu5VM0zIjL/X8WsCSb17lHtucw1pPR6CxCs+lJi8m9y8BHVkMwaR6zc7mdl62ck=
X-Gm-Gg: ASbGnctiV59OncWa21+dZa0U9LPHZRbdWi+wZ3YEs4BH4eZdZ4veHw0bdci3YXeygW/
 KHtLg79/DnoOTHwniAYWhy2LpX88m0r+HznLOuNpf5q/T/GWeBAo53uzuIDIflN/C1ts+t1D/tu
 n3uSclS1ebJ3AU2zi5Wuf4geYkvLGtIm2J2B7SsBuBPePHOjbUvTA9VgPvZZIYKSuB04SdPSLY+
 4XSpN8RbBKPPQXQADiK7H5eMLk4J5/uqv/N/n/eju5TXqwF+46NhrzTqZTa9jI3tDz4pX1stPvQ
 5Hng53zjurP3aRRDYTf3n2ZTYdCj+GuptdPgBKuYYqa8AyrqVkcUGhluJ1tTW7XsEsTHtWLNnJn
 WSR+1ky4zV7U=
X-Google-Smtp-Source: AGHT+IGhO2iXMvSn9qh/lRhWr24OpgvHHo8d1YO/Kdq1AtKjbnvik8zHwJy46BuAb9yFBJ+JCPZRbQ==
X-Received: by 2002:a05:6871:9c02:b0:2c2:371a:2b4e with SMTP id
 586e51a60fabf-2d4d2d60206mr1184882fac.32.1744812655125; 
 Wed, 16 Apr 2025 07:10:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>
In-Reply-To: <20250409-r5-eth-fix-v1-1-9b73667f304f@ti.com>
References: <20250409-r5-eth-fix-v1-1-9b73667f304f@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am62ax: fix MCU_CLKOUT0 parent clock mux
Message-Id: <174481265445.2150978.9160991725777966367.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:54 -0600
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

On Wed, 09 Apr 2025 13:25:00 -0500, Bryan Brattlof wrote:

> Much like what was fixed on the AM62x and AM62Px platforms[0]. The
> CU_CLKOUT0 has two (25mhz and 50mhz) mux options however the clock
> structure incorrectly duplicated the first 50mhz option twice. Fix this
> for the AM62A platforms so the 25mhz option is selectable.
> 
> [0] https://lore.kernel.org/all/20250408161211.3165588-1-parth105105@gmail.com/
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: am62ax: fix MCU_CLKOUT0 parent clock mux
      commit: 203e5f3f02caf113b5df11fe680c8503d671bf1d
-- 
Tom


