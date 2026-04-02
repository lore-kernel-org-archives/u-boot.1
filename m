Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246F81112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 01:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E7A839DF;
	Thu,  2 Apr 2026 03:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N26LVmi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7023483CE3; Thu,  2 Apr 2026 03:31:20 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C8C80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 03:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66bd32f5592so46281a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 18:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775093478; x=1775698278; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpSX1eoMe+FuZ7BNzP3cyHF7AUUDh4Eo7rHL6N3XgpE=;
 b=N26LVmi9MYt0i5Zsd7GgJR74QKZ1izyFLHmVQzwmmzIemN6ssHYJcQ6vqiRhVjrAFJ
 6Jk1ssbKnG8KUqwHqWd3Nj3sEMzOYMdzmMtPxyczzBWZeqkTJr5qNxrZleuGU7v5JRji
 GiVXD1PvvW7b+7P/k7Vy3MarHgjRfFIUEgc8WtgiNIm3WniVuZZliK9LdlEQ32UThTY2
 L1X02cdetwEIqvTJV3ffoggWMfNXYwKsax45GnbgNA7eSujQeAURkMALAOT4CUXgV0Fh
 3bud+WFRap4oBEe+DgL4dKAbtLD6FgrpxikBKh7gGwsI4m6rXJs5f+MvR4Bbfp5pO7ZR
 eMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775093478; x=1775698278;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dpSX1eoMe+FuZ7BNzP3cyHF7AUUDh4Eo7rHL6N3XgpE=;
 b=IGe2xXehdExpKrL7WkUa2aq/BG6OhGJWrScq8mk/lldVtmbJQWvxG4SZHvkbL2YZAK
 uOieFqX2w2nWkJy6bYgRl9Oo+8kTos/3UfcVs4TfNA6dvVtCbdmlJfd+R94Yc8ea2bKW
 XKkpcGne/ejyY5SnXIKikH2PycyksUobT0xjusiRBs+aQHri2MtfCV+OT1Vi51rptto8
 JfBOUT6rNfTsAjaMAQLwI0nZWF8IFXdRS5euVKKkTis2kLTKthkeToPNvHjqfNU/V3Wi
 99Tl64k0uSeGFTmDRFkc+f14fu+sr3iS7KT6eomHNOdGsi8x2ZpdBJQZeRM0v1FYMRLr
 9lOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz8yxl564Qd+DldWwIhTfIhj7Huo8d/BR8X0jVglf4gcP9JzQEBSjho2++p4+StdWfKY1Sj8E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy85JPI+r3vrwJVEjHdwiVzUdXiz3BbNDjDTmHXBrdtJQcYuFQ1
 s2f2Yqp3HsyBe+axe9wbGkGJg1l1OZWWqGwfvHcQWNMdpaMTeXH7azh1
X-Gm-Gg: ATEYQzyjKXHdeOia7y8ATmJY54flQ9nshkVitjUbTQcqQbjbbdcph6bSG+wLm5+XkfO
 cQzJNsKZgUe5uUZa+jJ9YCOsJSlBsdCd41GCDvbY/hnz7rswmkgYrSv5PmEQcvnW812+Cyb6XMW
 RrV0uiHblwllIsTM6kGFNPzUiOowMiFncQSTLlzYX/AjPPvPpt99z8hd+AdiblfRSGVloUwwjXp
 /9eAGWlSFJUSN8YZRizrc2LDem6nxlKAK18Jk4LarJafNW+pcxayGjJGi4OC49+TsbIBbsvvvwv
 c9NUAaNiHQnLTouv1oRA52n284/nPj3sKOLI/PBLQQvxi8LkWb6O+cDIMA7xU9YAyTC2pNxV9R4
 VIgzaiW62liC8Va65ONlj4HHMj4X07Zh0etXOaGpyTmRZhMgJXhWiA0A4XiV0JP7vzl8Hdyldsn
 mZIG7yZaz6iZ/kU9gYqOTMUHrUxrVPcL/wgl97pzN7G+I7x+ivLMJvXgiuFqjD4yf4wZeMPVSR
X-Received: by 2002:a17:907:9451:b0:b9b:1963:2ff2 with SMTP id
 a640c23a62f3a-b9c1334ed91mr158477866b.0.1775093477607; 
 Wed, 01 Apr 2026 18:31:17 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cff0a1esm36262966b.43.2026.04.01.18.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 18:31:16 -0700 (PDT)
Message-ID: <1e443ab0-129b-42db-b224-253ba8a2f80f@gmail.com>
Date: Thu, 2 Apr 2026 03:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 0/2] Add Rockchip USBPHY DM driver
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

The Rockchip SoCs with an USB node and compatible = "snps,dwc2" can be HOST or OTG
while the PHY driver is hard coded and initiated in the board.c file.
Above construction is not very U-boot DM alike.
This is an attempt to decouple the USBPHY into a DM driver.

Tested on RK3066.
Feedback request for RK3188 and RK3288.

On older Rockchip SOCs an usbphy DT node is placed under a SYSCOM node.

grf: grf@20008000 {
	usbphy: usbphy {

		usbphy0: usb-phy@17c {
		};

		usbphy1: usb-phy@188 {
		};
	};
};

PROBLEM:
The usbphy node does not show up in the DM tree to be found by the
generic_phy_get_by_index() function. Only by manual transfer to the DT root
is gets detected.

REQUEST:
A little bit of help from the U-boot FDT and DM experts.
Locking/bind a driver in the DM model that is not in DT root.
Is this solvable with current DM stack?

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 nop           1  [ + ]   rockchip_usbphy       |-- usbphy
 phy           0  [ + ]   rockchip_usbphy_port  |   |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usbphy_port  |   `-- usb-phy@188

Johan Jonker (2):
  phy: rockchip: add phy-rockchip-usb2.c
  usb: phy: remove rockchip_usb2_phy.c

 arch/arm/dts/rk3066a-u-boot.dtsi         |  29 ++
 arch/arm/dts/rk3188-u-boot.dtsi          |  29 ++
 arch/arm/dts/rk3288-u-boot.dtsi          |  40 +++
 arch/arm/mach-rockchip/board.c           |  28 --
 configs/chromebit_mickey_defconfig       |   2 +-
 configs/chromebook_jerry_defconfig       |   2 +-
 configs/chromebook_minnie_defconfig      |   2 +-
 configs/chromebook_speedy_defconfig      |   2 +-
 configs/evb-rk3288-rk808_defconfig       |   2 +-
 configs/firefly-rk3288_defconfig         |   4 +-
 configs/miqi-rk3288_defconfig            |   4 +-
 configs/mk808_defconfig                  |   2 +-
 configs/phycore-rk3288_defconfig         |   3 +-
 configs/popmetal-rk3288_defconfig        |   3 +-
 configs/rock-pi-n8-rk3288_defconfig      |   2 +-
 configs/rock2_defconfig                  |   3 +-
 configs/rock_defconfig                   |   3 +-
 configs/tinker-rk3288_defconfig          |   4 +-
 configs/tinker-s-rk3288_defconfig        |   4 +-
 configs/vyasa-rk3288_defconfig           |   2 +-
 drivers/phy/rockchip/Kconfig             |  28 +-
 drivers/phy/rockchip/Makefile            |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c | 379 +++++++++++++++++++++++
 drivers/usb/phy/Kconfig                  |   3 -
 drivers/usb/phy/Makefile                 |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c      | 113 -------
 include/usb/dwc2_udc.h                   |   1 -
 27 files changed, 522 insertions(+), 178 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

--
2.39.5

