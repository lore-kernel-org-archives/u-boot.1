Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61461098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69B283FED;
	Fri, 20 Mar 2026 15:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JCB1OVS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A88A83FF9; Fri, 20 Mar 2026 15:35:47 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE4683FC5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6634197cd98so217645a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017345; x=1774622145; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N22LYZ+yto0xXnQu6D7FeAryH9ddGoaU1033Y3MB9Es=;
 b=JCB1OVS5j2R9KnVzb82oCOOqn/NV40Yli9bgQonNAnzi2J7FwWTTlEunSGfnSFCqkQ
 edVOx2DoqYGR+5UtJLoSapPqJIH3FYeP9+yxvSBK1B/pS9LHB1fDYHtr78nm7qgQLRwy
 ZycUArMY88plfbZ+uEv3jjQ5wGy7BOvm4TFyKiPUM/bAhmCcbA4Sed+TiTeV9En1PIGk
 gvC8e7S4V77Kdzg2LavwT9NwcpcUBdxDa/p9BCmFGgiBBUCtMjmsvMO13aFtOJNmzz4t
 e0eBX/MZ/YV6CW957Llf5J+kkQdxT92c5OgHpWC3bOrtn8RDS/inPTufAiGoda1rIkL6
 ao6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017345; x=1774622145;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N22LYZ+yto0xXnQu6D7FeAryH9ddGoaU1033Y3MB9Es=;
 b=rrwFJw7ATllXUkq8jiJ9y8J8AFXIAOVNH4CMzFniSVWNMIKVfe4XX30t5Ujq/esxVQ
 luBOPBuWO0cKaaMqBLTQf50HpQ7FgtNEurdXNzWGY+zjFvjOUYYrigUNEwtFGWliKuYI
 J5dxW0mig6SZLPLDM7IR3CQ7Yx3VTcnTWnQB3qGGXmNssCwQgmxMG+BfP4QIvojY6wXy
 vrFvSfsgZLUYOXjV4FUBjvK9Y8Rk95PoQkQ+mZqjdyC28PywZwbqvh6Er3ckc3GGmdsd
 k9zDKJkZrJN5IFFHmpG4nWJJlSr97ybdKjoselYAnZvHCiXQbHFxrbcc8aQDA9yrpG2u
 dC8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqag6UXj8oE9yQsNSNBMgR9ThQ0Tn/eVeXIzTHlBhVk0MqS+j8lmlVY701U3sEvbkARAG5msM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8jg54Dgg7bCozU3CrZGtnR0RzlmYg+ls/eY3O9A2qlXY16kGO
 PNH60uQfjJYn394tGTyQdBIZwOhyyACn/uFxuT+Uenzi2r0epit2G2XCh6TT5Q==
X-Gm-Gg: ATEYQzzYiADXyycFUAx8HWqeZaTvhr0MvBLsbO8TJLBfn/hZ1YYhxhFHOKjrp3W30yA
 EafPnt50WHPZr9QlgR+6KguIFVcPWW1nsz4SRWkrw2uoNLj+ommbqb+23TWqVKXkkCGrpIdmlGA
 srkCCPfRidtyWR1cvtToV6MKQqK7ZXVr/4DyUDITifX8DD6h8Zx9W2u+vFIp9qGoB0gzcN0XV6w
 dZKes5VktTUMbAj8cnjatU2MqJdZlMMzH+I5mIkhDNcFULmRKIGEtiIfVtL64gxqO681zkb+gTu
 Szbqk+gHJECIsMqq1DdhdUB/4ThA3RHPT6LEkLeS5A9U5W2phBhhAYLNJHj40zSNnrsy5yr9cng
 IC8LPQ7FRpTlOgNHHIzyi3uHsevmMFXlpqiawIAB3C03eEiK7z16eEIZMrctt1qnjS3enJNfEqj
 NwxfHxCn6WVFg3g9WyDclAezpbpxYtXfe1N+rbskhng6GJm6YprQdwIpnTfCxnUw==
X-Received: by 2002:a17:907:868b:b0:b97:d398:7f41 with SMTP id
 a640c23a62f3a-b982f0b3214mr102281166b.2.1774017344395; 
 Fri, 20 Mar 2026 07:35:44 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43a65sm168059566b.7.2026.03.20.07.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 07:35:43 -0700 (PDT)
Message-ID: <0ca86716-5e46-4f16-a579-d04dbeaa15d3@gmail.com>
Date: Fri, 20 Mar 2026 15:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/3] rockchip: Switch remaining boards to upstream
 devicetree
To: andy.yan@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Switch remaining boards to upstream devicetree.
Remove rk3368-sheep board due to lack of upstream support.

Johan Jonker (3):
  rockchip: Switch rk3128 boards to upstream devicetree
  rockchip: Switch rk3229 boards to upstream devicetree
  rockchip: Switch rk3368 boards to upstream devicetree

 arch/arm/dts/Makefile                   |   11 -
 arch/arm/dts/rk3128-evb.dts             |   99 --
 arch/arm/dts/rk3128.dtsi                |  780 ---------------
 arch/arm/dts/rk3229-evb.dts             |  256 -----
 arch/arm/dts/rk3229.dtsi                |   52 -
 arch/arm/dts/rk3368-geekbox.dts         |  281 ------
 arch/arm/dts/rk3368-px5-evb.dts         |  277 ------
 arch/arm/dts/rk3368-sheep-u-boot.dtsi   |   35 -
 arch/arm/dts/rk3368-sheep.dts           |  286 ------
 arch/arm/dts/rk3368-u-boot.dtsi         |    4 +
 arch/arm/dts/rk3368.dtsi                | 1218 -----------------------
 arch/arm/mach-rockchip/Kconfig          |    3 +
 arch/arm/mach-rockchip/rk3368/Kconfig   |    7 -
 board/rockchip/evb_rk3229/MAINTAINERS   |    1 -
 board/rockchip/sheep_rk3368/Kconfig     |   12 -
 board/rockchip/sheep_rk3368/MAINTAINERS |    6 -
 board/rockchip/sheep_rk3368/README      |   44 -
 configs/evb-px5_defconfig               |    2 +-
 configs/evb-rk3128_defconfig            |    4 +-
 configs/evb-rk3229_defconfig            |    4 +-
 configs/geekbox_defconfig               |    2 +-
 configs/sheep-rk3368_defconfig          |   32 -
 doc/board/rockchip/rockchip.rst         |    1 -
 include/configs/sheep_rk3368.h          |   15 -
 include/dt-bindings/clock/rk3128-cru.h  |  273 -----
 include/dt-bindings/clock/rk3228-cru.h  |  287 ------
 26 files changed, 13 insertions(+), 3979 deletions(-)
 delete mode 100644 arch/arm/dts/rk3128-evb.dts
 delete mode 100644 arch/arm/dts/rk3128.dtsi
 delete mode 100644 arch/arm/dts/rk3229-evb.dts
 delete mode 100644 arch/arm/dts/rk3229.dtsi
 delete mode 100644 arch/arm/dts/rk3368-geekbox.dts
 delete mode 100644 arch/arm/dts/rk3368-px5-evb.dts
 delete mode 100644 arch/arm/dts/rk3368-sheep-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3368-sheep.dts
 delete mode 100644 arch/arm/dts/rk3368.dtsi
 delete mode 100644 board/rockchip/sheep_rk3368/Kconfig
 delete mode 100644 board/rockchip/sheep_rk3368/MAINTAINERS
 delete mode 100644 board/rockchip/sheep_rk3368/README
 delete mode 100644 configs/sheep-rk3368_defconfig
 delete mode 100644 include/configs/sheep_rk3368.h
 delete mode 100644 include/dt-bindings/clock/rk3128-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3228-cru.h

--
2.39.5

