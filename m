Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592ECE88D66
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 11:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B10683B48;
	Sat,  4 Apr 2026 13:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZso0Lna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB93583642; Sat,  4 Apr 2026 13:20:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9001283642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 13:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b97fee3787eso34031366b.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775301604; x=1775906404; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSXzAHY4mcZ3emHB4+Af9sJL/rwFmf4HKJh8o9U/rgU=;
 b=FZso0LnaB2RpORe/8UjCaw0PQQv8CKvtwRyGwNbpPDxJHeq3w5ba94SzS/H+/hgQ8l
 CG4kUDWQLqdZqUJE2ztfQF7fiMbMCXYaUWrDA1Q09weyFyCr3DRmW+9p1vjjZqqoXJQM
 2VCdwA1fTk04/WoCHVVwQtMN52ESkZu66H4zQay09XSG6X1kL5dcTqln4v4aEYJaQ7U2
 pcB6FDuropoJKxd57hCk3f8STMKC3Yk3NFzovNV4hjP0yGCnAzMl4KQoDMwrSDpMSeY5
 5dUrCiC4J8/Akxs+sP/MwgEeTbI3GzIdLpN/DVNVlxUhomLLiVwNtH/p1MS4InhRNMP1
 S+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775301604; x=1775906404;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YSXzAHY4mcZ3emHB4+Af9sJL/rwFmf4HKJh8o9U/rgU=;
 b=DzlKOhiRNv2xwKLIzRl+bNnxN74I7pZc8dauNAzhfSNTRly/CTCjKWNeQxhajXHMUw
 FmwaQWeInE0CmoPJKc+DZH3VIrqyq4ItyS41JzVYhFqSBA1oZ1EJVoaADH9BXcbeiaCy
 hOkMjv77pkl0llNw25xNmy+2awxDRGB5Rz5mRkhpEZCnesTLSGxYm+kUmq1/gxeDDIY+
 2OzomQftgRcIMvQRBLcOm2k3hdv/OdBVQoPrPZQLZ2Jy3uSF7f6c/HAsa491Y5q61xEq
 7Qnsx0ELaFLj+zHAElK9ERamcXUItovsqDeTxnhWSkggp5Y7rI9kBvXCqTKTQm8PVPp4
 5btA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlQ1lwNC+4Ga179W8QLlmmTa7GcbFIMei86z1ohQOTnN53S9y9Y8+fgTzENa11Gf13SFKORAY=@lists.denx.de
X-Gm-Message-State: AOJu0YxhbQFCSLx4GI9k+iz1Z2fEK2PKkxDHYyNEDexfznYe+KrT1RrK
 XgtCxPktEwY35t1eybc6HJy9qYwUPoMfQEtLlcZl1+KPaUGlyZ76a3fh
X-Gm-Gg: AeBDiet4uZSlMBgsnqAf5mZuByDgqgaM1rnDFlzfqNcb6P1+1TtIES9GaNf+O8hYhaC
 A8edN581e4XXgmWRudlKMhTW8oS6b2+dOB1P1LXgfh1PQAyHDd67eDqN50PALt0V2x0wVD1/N9U
 +uGSKXhUyOhcs+psC5PqgeBK3Cx1UBXGH+D48hN9U1qofuKERPfszKbziWrCjIi13z7PQ9qBdPT
 4sKICG2DmOznANJTa+hiHBJKgBmZY6yCF2Q1R+z4d7jqZ83mm1yLSEnFLv+GCq1iObEZfnmi5M9
 18lYJKaXHUdQgcdGlDl1VhTZBef6EfIlOv19uvGGfPS9v7oMUSpW/PDd+4u5TQVilFUDjwhHS5J
 wvxZLRQaqfIl/uPXJOPzAkL6oZ4RiD0bfXdv/33tgeAyz9jw6Jh61sappRSl/g3Qf5mZ8qDIi1E
 TVz8UcgFDvdiOFsb3JEtDF/jw3ObwwAN1hwJ/RDi1F/aJWIlw69e6jCFBUZzxs+g==
X-Received: by 2002:a17:907:608d:b0:b87:1e1:e562 with SMTP id
 a640c23a62f3a-b9c679b704emr148865766b.8.1775301603597; 
 Sat, 04 Apr 2026 04:20:03 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cec6c11sm292564566b.30.2026.04.04.04.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 04:20:02 -0700 (PDT)
Message-ID: <a3aaa5dc-b959-4301-8d35-f295a019823a@gmail.com>
Date: Sat, 4 Apr 2026 13:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/2] Add Rockchip USBPHY DM driver
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

The Rockchip SoCs with an USB node and compatible = "snps,dwc2" can be
HOST or OTG while the PHY driver is hard coded and initiated in the
board.c file. Above construction is not very U-boot DM alike.
This is an attempt to decouple the USBPHY into a DM driver.

On older Rockchip SOCs an usbphy DT node is placed under a SYSCOM node.

grf: grf@20008000 {
	usbphy: usbphy {

		usbphy0: usb-phy@17c {
		};

		usbphy1: usb-phy@188 {
		};
	};
};

The usbphy node does not show up in the DM tree to be found by the
generic_phy_get_by_index() function. Only by manual transfer to the DT root
is gets detected.

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 nop           1  [ + ]   rockchip_usbphy       |-- usbphy
 phy           0  [ + ]   rockchip_usbphy_port  |   |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usbphy_port  |   `-- usb-phy@188

Changed V2:

Add grf function that binds the usbphy driver to the grf syscom driver.

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 syscon        9  [ + ]   rk3066_syscon         |-- grf@20008000
 nop           0  [ + ]   rockchip_usbphy       |   `-- usbphy
 phy           0  [ + ]   rockchip_usbphy_port  |       |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usbphy_port  |       `-- usb-phy@188

Johan Jonker (2):
  phy: rockchip: add phy-rockchip-usb2.c
  usb: phy: remove rockchip_usb2_phy.c

 arch/arm/mach-rockchip/board.c                |  28 --
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  26 ++
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  26 ++
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |  26 ++
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/evb-rk3288-rk808_defconfig            |   2 +-
 configs/firefly-rk3288_defconfig              |   4 +-
 configs/miqi-rk3288_defconfig                 |   4 +-
 configs/mk808_defconfig                       |   2 +-
 configs/phycore-rk3288_defconfig              |   3 +-
 configs/popmetal-rk3288_defconfig             |   3 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   3 +-
 configs/rock_defconfig                        |   3 +-
 configs/tinker-rk3288_defconfig               |   4 +-
 configs/tinker-s-rk3288_defconfig             |   4 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 drivers/phy/rockchip/Kconfig                  |  28 +-
 drivers/phy/rockchip/Makefile                 |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c      | 371 ++++++++++++++++++
 drivers/usb/phy/Kconfig                       |   3 -
 drivers/usb/phy/Makefile                      |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c           | 113 ------
 include/usb/dwc2_udc.h                        |   1 -
 27 files changed, 494 insertions(+), 178 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

--
2.39.5

