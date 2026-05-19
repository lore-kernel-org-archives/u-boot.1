Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F23CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A5684659;
	Tue, 19 May 2026 15:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="JhkDCR9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45920846CA; Tue, 19 May 2026 15:01:13 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D0E843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195660; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZpJmfay4IBQqfpZgbCHnRrLSfg3wTzkEnNP3TKXRk0T/WNMYS3aojO2PhsvmXsrbI7pueu9U1ozGGwNT1WFoZJd1bSWQ0FjDNnB/M8imvarcPzS/KNJPBEdCTO31qSVgPd7Vsfr5E9o5kWW0WIrDB1eP2mKCYa6M5DUnCgBxFYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195660;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5SpY5uRVcZxW8XX5/vLug4Kqn+z1z475hdrB4mEj1P8=; 
 b=iJZulXrz2LJ3jHvmaAbe26zrG4IHplMc9EioAqyozRwgCYLz6Oq1J959iPbCr+cw2di6BrHlaED4IaFRo2ikKn0j8eOMdEk3fG3AJItX7vHt6+yuLWLJAlSiqD7DD2d1Cv1gdsLmzksJcVLs4sJrZp1ixvpQr12bby1nWq/bGd8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195660; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=5SpY5uRVcZxW8XX5/vLug4Kqn+z1z475hdrB4mEj1P8=;
 b=JhkDCR9kjxVJY2Y5OZ5ZQhb3KwULcbUJNDmPA2x2u9XyZEjA+S3+VhDJ7i8S752D
 9x7/n/+/8hC3I9tS7v0op7RoYXmk6+Ew1gfnWBLLz07piCJl9yCINFCAYdKsSr8ZXS2
 GBxeir4FIG6Yq7fmQUx/igdet9sbKC9ldI2NSLto=
Received: by mx.zohomail.com with SMTPS id 1779195657232366.39103542836176;
 Tue, 19 May 2026 06:00:57 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/5] sunxi: a523: add gmac1 support
Date: Tue, 19 May 2026 20:58:27 +0800
Message-Id: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NL3UTTVN303MRkQ10Lw0QTM4NE40RToxQloPqCotS0zAqwWdGxtbU
 Abb1HP1sAAAA=
X-Change-ID: 20260519-a5e-gmac1-81a460a3a52d
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=1690;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=Jt59ltSky+hTVDh8l1rC9yPJg1RF+IZtrrqgJvozBsk=;
 b=2TCgTMTlneGuYdY2B2iyw1vGq+q20IwY4tnJfJUkEJOc3ECZTGinpOGKEFjRDFCvcN2agep2w
 Q83dtCtA0W3CYxk96nIPDOShn3ZExcFLe2DKeWvAuGtbmfKsz907vQ0
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

This adds gmac1 controller support for the Allwinner sun55i
(A523/A527/T527) platform. Unlike the gmac0 controller which uses the
older sun8i-emac IP, gmac1 utilizes the Synopsys DesignWare Ethernet QOS
IP block.

In addition to porting the DWC_ETH_QOS_SUNXI driver from upstream Linux,
this series also introduces support for relevant dependencies, including
clocks, pinctrl, and syscon required to make the controller fully
functional.

This was tested on the Radxa Cubie A5E board, and the relevant options
are enabled as well.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Junhui Liu (5):
      net: dwc_eth_qos: add support for sun55i platform
      arm: mach-sunxi: add syscon driver for system-control nodes
      pinctrl: sunxi: a523: add gmac1 support
      clk: sunxi: a523: add MBUS_EMAC1 clock gate
      configs: radxa-cubie-a5e: enable the gmac1 controller

 arch/arm/mach-sunxi/Kconfig           |   7 +
 arch/arm/mach-sunxi/Makefile          |   1 +
 arch/arm/mach-sunxi/syscon.c          |  28 ++++
 configs/radxa-cubie-a5e_defconfig     |   6 +
 drivers/clk/sunxi/clk_a523.c          |   1 +
 drivers/net/Kconfig                   |   9 ++
 drivers/net/Makefile                  |   1 +
 drivers/net/dwc_eth_qos.c             |   6 +
 drivers/net/dwc_eth_qos.h             |   1 +
 drivers/net/dwc_eth_qos_sunxi.c       | 254 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |   3 +-
 11 files changed, 316 insertions(+), 1 deletion(-)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260519-a5e-gmac1-81a460a3a52d

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

