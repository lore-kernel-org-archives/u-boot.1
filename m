Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860B5C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 22:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D87983E42;
	Fri, 11 Apr 2025 00:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qCgE+ewO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1990E83EF5; Fri, 11 Apr 2025 00:16:11 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FFC83E0E
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 00:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2d0920ce388so336670fac.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744323368; x=1744928168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW59k3f9x3rRCqShgg/gWTOj84HBqtsZy3cC5SiFM+k=;
 b=qCgE+ewOnVzYZrS7Y+5ZKHLsbuQ5ZssZNjypWt/YgxtPVWlqz+umiVkcaaEyxi7gWV
 mCghmvJo3JEA2Ws/gHs5aJP9hy+qw/fLxEJlCXX3UqNM4oiCaDIRX0xQyMlw4B+eGv3c
 WVX/NbYJU67SA+Xapinf+KBkS2CBopZ40RRj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744323368; x=1744928168;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW59k3f9x3rRCqShgg/gWTOj84HBqtsZy3cC5SiFM+k=;
 b=YNCcnWdrGoUvV3fFzveLH+mT4waHHGaLUOuqOgz6KiZXpiF1XQrTyhk2ZjFU9GZoNd
 CTMTvdBH/Uhtlbsirme0PF8GMCxctvSJ9GT2PCGWS/sKFuIcWKyV7c+Do178TirU+2qD
 phh9GtqCfGaTA9sUoK+VHfH0mFWqEtfkrErT7dUa4+QJpC5ukdNdRiiUwhG7xJyq++DQ
 gZiZF3kpFObSYvPtGrfS7IOS5EPD6cfpE8BrtS0/Cgv/wfQ44zYR36XaSFhbLnX2yS57
 z9yu1Dkfm0oq5G47TQ41dGgeF6KhV847nTMcUf+yXVk98TWOmn9s1kg6HPGBvOEsqEsj
 xDvQ==
X-Gm-Message-State: AOJu0Yy81paYew0JWQa5HWIYihhQYdeNFO2W07pWJW6ShahHwFHTzAZz
 EZVGjMBxca7/I/m79e1xL/WbUeMkTBD89QsvZubo9qY/HnWyblbVjf8yjTTkerD70pSi+uXj0Sx
 AV2A=
X-Gm-Gg: ASbGncuhchruqkqrV4kV56B3HMzKMOv5vyeq1FcCjYAkDmnPq72OI+aK/6m4akfqFAc
 0tYUa5G+k5jpPlUci1hlkTzlPsB8I66rXH6vg/ZuWZyRbbJQsj5LPeZ4/A7SbGpWg13E201VJ2B
 mE/7pHYSJ1MWTDJw3Dx9K4jT3HVXlEYFkf0eKiqmJYesYHJEV/kTwApHWuF3ohxgpmqcCDKGnYZ
 S+8LrFdsqqaZY34b0rkDkW8FqAb/jeM40FqmegOBm2Cgai0cvPNueZf0RTWIJ33ZaJBz4sQ8QkD
 qJgLKCyQdULW0v8+ZWcGBLu9iRrP7Mlkb40MsV0iisg2tdFZkh30wVDriEasiv0fnHZcLH0x9RZ
 Q
X-Google-Smtp-Source: AGHT+IGGMaYO79Kmf6tZFMjCmAglG9glj5i+nQLx2p1mSaD0AHfwhh3Ge+u2w8/Tp9r2ZhWtrJ78xw==
X-Received: by 2002:a05:6871:7a8a:b0:2c7:6f57:3645 with SMTP id
 586e51a60fabf-2d0d5d873ddmr236147fac.18.1744323367824; 
 Thu, 10 Apr 2025 15:16:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096961127sm838499fac.20.2025.04.10.15.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:16:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: ggiordano@phytec.com, d.schultz@phytec.de, afd@ti.com, n-francis@ti.com, 
 nmorrisson@phytec.com, vigneshr@ti.com, s-k6@ti.com, dannenberg@ti.com, 
 bb@ti.com
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/8] *** Add Ethernet boot support for AM62Ax +
 phyCORE-AM62 SoMs ***
Message-Id: <174432336646.3115550.1533797962594566957.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 16:16:06 -0600
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

On Tue, 25 Mar 2025 04:58:16 +0100, Wadim Egorov wrote:

> Add general ethernet boot support for AM62Ax SoC.
> Some of the work is based on TI's downstream u-boot patches found in
> [1], patches touching code in mach-k3 and *.yaml board config files.
> 
> Also, provide defconfigs and device tree changes for phyCORE-AM62x and
> phyCORE-AM62Ax to support booting via ethernet.
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] arm: dts: k3-am625-phyboard-lyra-rdk: Add boot phase tag to phy_gmii_sel
      commit: a936352f9e00206016badaaa217f034dde7b00a2
[2/8] configs: Add phycore_am62x_r5_ethboot_defconfig
      commit: 1acffb571149879094012bb69f54da2c958d552a
[3/8] configs: phycore_am62x_a53_defconfig: Update for ethernet boot
      commit: 93d22aca3d3266f759c0f293e96e210ca3fec663
[4/8] arch: arm: dts: k3-am62a7-phyboard-lyra-rdk-u-boot: Disable Ethernet2
      commit: 77183dfbbcfa466c9a7a646f9f9468f6276e94e3
[5/8] arch: arm: mach-k3: am62a7: Probe CPSW NUSS in board_init_f()
      commit: 2dec0fc59c55aa78ff737d3238cac6cc968348c5
[6/8] arch: arm: mach-k3: r5: am62ax: Update SoC auto-gen data to enable CPSW boot
      commit: a0f73e847d17302751ad358bf387700b08fa5e98
[7/8] board: phytec: phycore_am62ax: Share ethernet resources with boot r5 core
      commit: 5327b62c12cf0a1393481fb2f402806bad6dc280
[8/8] configs: Add phycore_am62ax_r5_ethboot_defconfig
      commit: e41c21acced75002f54240c277e46ee585af2cf9
-- 
Tom


