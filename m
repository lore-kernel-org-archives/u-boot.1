Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148A4CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 18:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521998490D;
	Thu,  7 May 2026 20:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIBWAeez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AD984A75; Thu,  7 May 2026 20:34:52 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB39848FD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bc32563f82cso17549766b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778178890; x=1778783690; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cuvOCmEZ6oADLjvKowFaVd5QMID7LpAtsqqvdnDfA4=;
 b=kIBWAeezzrNmNjc4Ryx4LZResJE/7cvFSRqa3MLn9PBG4ecJSbOMRWM+SXio/w+Akn
 GMrIdoA4UzhXL2PF6HQrh9K7sGVnlv4cHVI9O6Eun7PXVHHfO0AnFMOWawyZIqLK1vuf
 JyUYv8jz5kJW2yA1jujZ1vBtRVHgGWp/2wgv4tKWyOxPxCF1/6866kqaUuMyq7H7UpQg
 pAP+5BPOCa5uiEJS1Dokz/HTpoEN/wPvPUvVExXWoFYu1qowjAg8E8kZe05t6Wbn9AdN
 i19ZZ8EI+TBWxG6eVOqHFac9/Wfh7nojoOEwQeUoFp69mK55mYVAjvFTiWcJecBFdFTH
 HXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778178890; x=1778783690;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+cuvOCmEZ6oADLjvKowFaVd5QMID7LpAtsqqvdnDfA4=;
 b=tA9iBOP/jtVXVQ6Er5gI9Zt39CpqWIlInwB0b/w2V04iRa04OedBSWGzQLTjqR7zf6
 EyIrn8286Tds3T16T5hULKlJDVacbHEBspZ2B18B0ou63HPKAPIfbX4K3Z+rn3cCUqRz
 NoFmGR+KTAdI1Y/8I4jq3xlWCCwSMXl+LaKZ9NhGHd0JpQWQqk+QGHUknyVREOV+TvJR
 Y1u5vVmgMYhK7d4/2igRKhJ0Gj8ElaGK0dW7pChywFG+LXSOpfSckeq1ZTwYMyC4QlRB
 hecfmxM7+W9sjqdfLrQ1bAAL+eOls78c/AqrKvFjysJlHMORNJDwmoBcnzfILx/sOX24
 fwzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ahuZ6brddF36B9Ey6JCK1n0Zq7nn7NhId8JKY7SrfDGp5hl46WXBE72b1U1W5Z2MpxJTwyik=@lists.denx.de
X-Gm-Message-State: AOJu0YwuqLuXeh5U4JAVLSj6zF4mWofbVi3LqeocCvygGTr4fZCzAi3J
 rA88osDtkJBO9r8WDZXtBNpz7TujGZdTQFmsd8vmQ7IwXgXcbK7bPiD9jEVfKA==
X-Gm-Gg: AeBDiesMYZUKPGNtNNmeNPlaUF2+Y8coZOK/u9LewXge8/arlxAaWlwW1S+DSwwGquq
 gYzqbI1IMYwZQK5+35TFzBgWXlwDlKlrbgz/mXpd1+M8po6yUwZjMfp6zc3egqo8B1Bpnfm8bdc
 3sW1hKOPgRXWi+U7/2L6kJVlQpIuhpD72PhzEAHDfq21OJeEw4Hu9Oe4h1hK37kYXPudyLX8rVk
 mZ3Ar9Olcg4VlsqLZPdjitvABoYtCgTTZOFZhmya3L53JeqghvnaBbFHYRy7JgDlNs8KOw6QOCX
 cXXXFW149JWudAxbdQmldmPFSdbxYiSDnazpun+TxKQbYgdKPKTNR1TFtE1YxmvuyzfyalzeHwZ
 Y1qf7nVz+QDFu+vgMdJ4jJcpgVkWyv8XrH8SzUfJg6Erdnmo2Pocl/jkawBQ907rVEHewxTQj+l
 9MaDSgAOa/12h6AUa5rU1hoR0lv1qvbQOqHDp2ex/SaoPmFGWg2fcFqz+3Au/5mhbJwyttm+XE
X-Received: by 2002:a17:907:c19:b0:b9c:fc84:942 with SMTP id
 a640c23a62f3a-bc56cb2d6bfmr203299866b.8.1778178889579; 
 Thu, 07 May 2026 11:34:49 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bca583d53f5sm15184366b.55.2026.05.07.11.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:34:48 -0700 (PDT)
Message-ID: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
Date: Thu, 7 May 2026 20:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/5] rockchip: Switch remaining boards to upstream
 devicetree
To: kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, andy.yan@rock-chips.com, u-boot@lists.denx.de,
 quentin.schulz@cherry.de
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

Changed V2:
remove rk322x.dtsi
removal in a separate patch
remove README links
remove pinctrl include

Johan Jonker (5):
  rockchip: Switch rk3128 boards to upstream devicetree
  rockchip: Switch rk3229 boards to upstream devicetree
  rockchip: Remove rk3368-sheep board
  rockchip: Switch rk3368 boards to upstream devicetree
  rockchip: pinctrl: use include from dts/upstream

 arch/arm/dts/Makefile                   |   11 -
 arch/arm/dts/rk3128-evb.dts             |   99 --
 arch/arm/dts/rk3128.dtsi                |  780 --------------
 arch/arm/dts/rk3229-evb.dts             |  256 -----
 arch/arm/dts/rk3229.dtsi                |   52 -
 arch/arm/dts/rk322x.dtsi                | 1293 -----------------------
 arch/arm/dts/rk3368-geekbox.dts         |  281 -----
 arch/arm/dts/rk3368-px5-evb.dts         |  277 -----
 arch/arm/dts/rk3368-sheep-u-boot.dtsi   |   35 -
 arch/arm/dts/rk3368-sheep.dts           |  286 -----
 arch/arm/dts/rk3368-u-boot.dtsi         |    4 +
 arch/arm/dts/rk3368.dtsi                | 1218 ---------------------
 arch/arm/mach-rockchip/Kconfig          |    3 +
 arch/arm/mach-rockchip/rk3368/Kconfig   |    7 -
 board/geekbuying/geekbox/README         |    1 -
 board/rockchip/evb_px5/README           |    1 -
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
 include/dt-bindings/clock/rk3228-cru.h  |  287 -----
 include/dt-bindings/pinctrl/rockchip.h  |   60 --
 30 files changed, 13 insertions(+), 5334 deletions(-)
 delete mode 100644 arch/arm/dts/rk3128-evb.dts
 delete mode 100644 arch/arm/dts/rk3128.dtsi
 delete mode 100644 arch/arm/dts/rk3229-evb.dts
 delete mode 100644 arch/arm/dts/rk3229.dtsi
 delete mode 100644 arch/arm/dts/rk322x.dtsi
 delete mode 100644 arch/arm/dts/rk3368-geekbox.dts
 delete mode 100644 arch/arm/dts/rk3368-px5-evb.dts
 delete mode 100644 arch/arm/dts/rk3368-sheep-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3368-sheep.dts
 delete mode 100644 arch/arm/dts/rk3368.dtsi
 delete mode 100644 board/geekbuying/geekbox/README
 delete mode 100644 board/rockchip/evb_px5/README
 delete mode 100644 board/rockchip/sheep_rk3368/Kconfig
 delete mode 100644 board/rockchip/sheep_rk3368/MAINTAINERS
 delete mode 100644 board/rockchip/sheep_rk3368/README
 delete mode 100644 configs/sheep-rk3368_defconfig
 delete mode 100644 include/configs/sheep_rk3368.h
 delete mode 100644 include/dt-bindings/clock/rk3128-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3228-cru.h
 delete mode 100644 include/dt-bindings/pinctrl/rockchip.h

--
2.39.5

