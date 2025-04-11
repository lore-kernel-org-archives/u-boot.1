Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA00C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE8A840B1;
	Fri, 11 Apr 2025 16:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPfpPFwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD2D84105; Fri, 11 Apr 2025 16:49:01 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E8B840E0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso665198b6e.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382937; x=1744987737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sLOwBreJwP6CE2tOAXaZ7Yo7D3UM1c9YaY+HY/aPqq0=;
 b=jPfpPFwA89/a15mBL2HDKiNTAHjA7bRVVsKsdVrinSYQ6qrx3paYw7sN75Wp4LodD4
 BJLFmvufTAzoz133KSzunQhnZMYL656xaLqxtJADpSEI5aXVCXX/P1GxJCrfdASthudK
 Yp1zotYSduLXXL+hwPGLLCMZMvbgyuGXlGJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382937; x=1744987737;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLOwBreJwP6CE2tOAXaZ7Yo7D3UM1c9YaY+HY/aPqq0=;
 b=NafwBHrKDFCUIRuQEcyah1OJjpQiiCOzmqSEvZVJqu8L9FkNjiqf59hHNRap8lJxr8
 fLy6xs8ivn24WRdFzKgWJkAzM+BFRuyO36MuscmYj7Llgisl7nf8W+4Yij/VwcsFojkz
 xSPofSZNb3hPFcZRa/ky/kqwZYG4kyTNemAU1FHpi0LJUZvLJOxm1Q/WSx8Vz7rF4Zfa
 vYFYJJXC8Qeyw+jDZlhpsRhiSfHwrYnsLymr/JB0NG1BZoZVCcZArwZgL+kroFGDXwhx
 eYS8GCKWnb2HE65YGjitc0Tq07LhjkrWZgNpB9JxE2GCJswScbofEytvkVbaGKQoawFE
 wOYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUVPFegMCF9hEPl9vmnZZpxMRtKAQ4BsLZstyZB3YtLJD6TWj8lUWIEalfm/lEJGYD+T3htw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw+MFaDM+8B4MrOuBuHCybjL+6glZnWOwOhxmII9vx5TsArCpb
 MJLsCf8Yh08gDrTaJig0fTMA5U/9o9hThqLssyLFLztbq7p+/7+CQ0YZU3PA88A=
X-Gm-Gg: ASbGncv3KKh36/EXA4ognkpV/CCruQBBOVZwB1d8HeIxfSLhrfsxXTC55MbnUeaHhMq
 gCIewGkceo2wQE1yPpS7cu31lU5uS9UDsVicxCWcOG5zrRGcuW0yU7QW1rCx0dpx2UJbEi0dv/z
 VUjnhhSdIrFx89ynyylRJb5noIDkol+TeALs55ViwZ3VsPQ8PiXuplNsaPw9YwQO+1K+DytQU/O
 UAbk3rSapGp1pyCHS6QSvjDxgAVB3aVlKv6P2+kk3/B/IM9rROCVmT01KM0Mea50SyOrTp20758
 yjbznm2v6IZR7xtUNv+5zgRQrY7ypGx9dyre5BUuKbcaSJbbrh50Y8jfTP15alNuJkvWiv0kj4l
 p
X-Google-Smtp-Source: AGHT+IHlHLGxXG5UndYsosfkUpfNTLUWkmJ4otQY54R4ElkezFBWOkg7RDaYSnAS4qjGgEC780AMVQ==
X-Received: by 2002:a05:6808:3095:b0:3f7:da57:3952 with SMTP id
 5614622812f47-40085073da7mr1816331b6e.21.1744382937328; 
 Fri, 11 Apr 2025 07:48:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639db05sm954732b6e.33.2025.04.11.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:48:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <bf6a90e864b713db41bf788797554649eeaa0732.1743290511.git.daniel@makrotopia.org>
References: <bf6a90e864b713db41bf788797554649eeaa0732.1743290511.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2 1/2] image-fit-sig: skip in tools build if key is
 missing
Message-Id: <174438293616.3201192.12985264013894145833.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 08:48:56 -0600
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

On Sat, 29 Mar 2025 23:23:51 +0000, Daniel Golle wrote:

> Skip signature verification in case no public key was given in order to
> allow using fit_check_sign also to validate uImage.FIT images without
> signatures. Guarded by USE_HOSTCC macro the behavior on target is
> unchanged.
> 
> 

Applied to u-boot/master, thanks!

[1/2] image-fit-sig: skip in tools build if key is missing
      commit: 40dcd5088b7f64ee2841c233c8ab82ce9c188d73
[2/2] tools/fit_check_sign: make key optional
      commit: 9c79c8fe70da7cd05fa4c242197f14122f245d81
-- 
Tom


