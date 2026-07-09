Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6DAC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2939D84A8F;
	Thu,  9 Jul 2026 15:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="DRmkNw7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D0684A3E; Thu,  9 Jul 2026 14:58:08 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D0F84AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so10203265e9.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601885; x=1784206685; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4M7Y6QoiDmYaokkyO537D1/trYHBcHnzouYNIFahmYA=;
 b=DRmkNw7eg5Yr4VFnS/MWTlB4ClwWsdCBJqHFUdPxCOlJjrcntQJsbmthHq0MtrAkvs
 ykL26U0Na6BjVxF9L8s5H8ykEEw3LKGfIwoxXCHXjJrg86VA5hIXBouTTvYLH8lj0H/b
 AIPFIWp6NERCtN4Vg9YTnoo7RVC42qrz6wsuNxWiT3eNdLNPymD9KQsNk7wLpcv0h561
 rJb+DW3zMu1Em9ty51F9N/UZeMrHbkkLBMuxA5P/NMwCnOHgJhj4V4wjfi6pM2jvwJxf
 6+ppZpnEITay2Zt4GlLhY+DOmT+QHYyuTX7NSlJh0/gKpNYG2HLDreW5L9CbzIxWpgK/
 jPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601885; x=1784206685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4M7Y6QoiDmYaokkyO537D1/trYHBcHnzouYNIFahmYA=;
 b=jvyhsMhGH20/M/jH2ofNwNbnDA3s2g3fdYoummbyddxn+bkG0743XRXILiQ+/S/oMP
 XntxLcgdeQ+4EHJUmoH7YRbdaD6fophX4NBPKCJjosUA0pvQ4J1OA2Hj2lKteiVwbTcy
 oap6Yh3Tydm5lxf073amZ0pGFTlexJnvGP/h7LJ7hcxDI/JqaUX8eA9RFWILyBlzWAyV
 92aJSQs1evNCT0ffor7OzdQoJMQu08gcV04iJcKqdZotsXR2dNiqam15OlcVdIuSgLxK
 ogKbDLTcskF6Xw2BDIdBWwqc25kOODnf9DtHCnvmi+shyqrpj8W+EypIx1hDqZkcQ7vR
 3TOA==
X-Gm-Message-State: AOJu0YxpMyvsXgCFO2X3luI1ce0UXMZsRqc7F7Dh+XSdXNeO0SNGUpCr
 5rg5XAO8Rg3Ebfm41UIbaZIpwlS76b0TUcitt6fYKL/OEsdJfjsWuZQzfHRdWWfpFc0=
X-Gm-Gg: AfdE7cm4xKlrQisWkowB7EtGVr55SSXNsz61IN99kWtBg30mH7L4tRn0hgM/ITZGgTY
 Uqb9eMVTStwENTWHk3dtb3+0urpTWugaJvYZJVXiwQNZJatYWrQTuR7R1LO5vgx3Lqdv9NS80lV
 NYz0NMGWb2ivf8MqFnh/wFmiuH0OMZig7cGPYLm9S/yEUOCTEDNRBThWizHePkowlT6qJ7MO94g
 K/eL2A4Tk6X4j0KGJwN3Q5zhRt8XPgTcFs92wdpzX/i964QO9L2SylOChr9vsNS4NUkH2LkK1Dj
 3CMe7pedG3g1a2hL2c0hbLaIPpr9pNTp0wjaLLNFx8x7aQlZxoPuCLsOSN9ZHBFFK2EM82cxgst
 49buBvgDq6AXHcFAmmM5mUzuJRhMbSyne4LLdb54Oxc6Zhi2OWcDw1VYWktsqDwm2Zbgcwhzype
 h3rhy1TWFN4e1uQPzMPBpQ+Bd5FG9nNovhVjQwWJhZHZPIFYN/uYS2Z0LvH5I9/LCrcSyAX+IQD
 tBk8XRR9fQ6PzcfukfFVkm9ISkeF5HFtwwTg0L33LtO/VpN72zWw1RcyS3Ms7P+JeUv5SU=
X-Received: by 2002:a05:600c:1c1d:b0:493:a893:1200 with SMTP id
 5b1f17b1804b1-493e6894a6cmr70134795e9.5.1783601884687; 
 Thu, 09 Jul 2026 05:58:04 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:04 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:08 +0200
Subject: [PATCH v2 02/14] configs: mediatek: drop unused
 CONFIG_MTK_POWER_DOMAIN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-2-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

The MT7981, MT7986, MT7987 and MT7988 SoCs do not have a scpsys power
domain block: none of their device trees carry a "mediatek,*-scpsys"
compatible, so the driver never binds and enabling CONFIG_MTK_POWER_DOMAIN
only builds dead code.

Note: the MT7987 and MT7988 device trees do carry a
"mediatek,mt79xx-power-controller" compatible on their topmisc syscon,
but no U-Boot driver binds it and no node consumes power-domains, so
the symbols are unused there as well.

Remove the unused symbols (CONFIG_MTK_POWER_DOMAIN and
CONFIG_POWER_DOMAIN) from these defconfigs.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt7981_emmc_rfb_defconfig    | 2 --
 configs/mt7981_rfb_defconfig         | 2 --
 configs/mt7981_sd_rfb_defconfig      | 2 --
 configs/mt7986_rfb_defconfig         | 2 --
 configs/mt7986a_bpir3_emmc_defconfig | 2 --
 configs/mt7986a_bpir3_sd_defconfig   | 2 --
 configs/mt7987_emmc_rfb_defconfig    | 2 --
 configs/mt7987_rfb_defconfig         | 2 --
 configs/mt7987_sd_rfb_defconfig      | 2 --
 configs/mt7988_rfb_defconfig         | 2 --
 configs/mt7988_sd_rfb_defconfig      | 2 --
 11 files changed, 22 deletions(-)

diff --git a/configs/mt7981_emmc_rfb_defconfig b/configs/mt7981_emmc_rfb_defconfig
index e5f193b7233..75e7140bdfa 100644
--- a/configs/mt7981_emmc_rfb_defconfig
+++ b/configs/mt7981_emmc_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7981=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
index bf361bc3ccc..6322af51b18 100644
--- a/configs/mt7981_rfb_defconfig
+++ b/configs/mt7981_rfb_defconfig
@@ -54,8 +54,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7981=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7981_sd_rfb_defconfig b/configs/mt7981_sd_rfb_defconfig
index f77d80f3a0a..de05e2486a0 100644
--- a/configs/mt7981_sd_rfb_defconfig
+++ b/configs/mt7981_sd_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7981=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
index 2cbed019147..87fbe677624 100644
--- a/configs/mt7986_rfb_defconfig
+++ b/configs/mt7986_rfb_defconfig
@@ -54,8 +54,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7986=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7986a_bpir3_emmc_defconfig b/configs/mt7986a_bpir3_emmc_defconfig
index 80962adb43a..92459ad9fe2 100644
--- a/configs/mt7986a_bpir3_emmc_defconfig
+++ b/configs/mt7986a_bpir3_emmc_defconfig
@@ -52,8 +52,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7986=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986a_bpir3_sd_defconfig b/configs/mt7986a_bpir3_sd_defconfig
index 0b91b275500..2c88255e69d 100644
--- a/configs/mt7986a_bpir3_sd_defconfig
+++ b/configs/mt7986a_bpir3_sd_defconfig
@@ -52,8 +52,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7986=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_emmc_rfb_defconfig b/configs/mt7987_emmc_rfb_defconfig
index 11673f9a1f2..00d7e5a610a 100644
--- a/configs/mt7987_emmc_rfb_defconfig
+++ b/configs/mt7987_emmc_rfb_defconfig
@@ -77,8 +77,6 @@ CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7987=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_rfb_defconfig b/configs/mt7987_rfb_defconfig
index fd2c67de4f8..0b353c6cf01 100644
--- a/configs/mt7987_rfb_defconfig
+++ b/configs/mt7987_rfb_defconfig
@@ -72,8 +72,6 @@ CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7987=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_sd_rfb_defconfig b/configs/mt7987_sd_rfb_defconfig
index b8e01475b22..30ff09365da 100644
--- a/configs/mt7987_sd_rfb_defconfig
+++ b/configs/mt7987_sd_rfb_defconfig
@@ -77,8 +77,6 @@ CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7987=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7988_rfb_defconfig b/configs/mt7988_rfb_defconfig
index 8230628312d..375df418ce0 100644
--- a/configs/mt7988_rfb_defconfig
+++ b/configs/mt7988_rfb_defconfig
@@ -67,8 +67,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7988=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y
diff --git a/configs/mt7988_sd_rfb_defconfig b/configs/mt7988_sd_rfb_defconfig
index db3ca7801f9..aafbed7bea5 100644
--- a/configs/mt7988_sd_rfb_defconfig
+++ b/configs/mt7988_sd_rfb_defconfig
@@ -55,8 +55,6 @@ CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7988=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y

-- 
2.54.0

