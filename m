Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B8C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D3A84A30;
	Wed,  8 Jul 2026 19:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RHzLXceL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1620684A0B; Wed,  8 Jul 2026 15:07:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0461F849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so5026745e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516027; x=1784120827; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4M7Y6QoiDmYaokkyO537D1/trYHBcHnzouYNIFahmYA=;
 b=RHzLXceLIBvQmwl7w41uW0+rks03D2H4hBztJ4TmloOGKG9gCNJesaoTF3J4ctWdlj
 LD8imW1NzTQZJRzPeOEYenUpN+9cZFwzIc+XZe4WDxKUzDM6GAMjW6T/8VstrbpH9GLJ
 JzTB2pTbxn17+gWrLJHrys3eALJucO/d8tsZLGGb59XImzTbySyIdBnmN63uX1Wey1i9
 mTsCSRcbP4MJUVZ65JTeB8YbI+S85mf1p2gyREKpg6ubptXyrKHHnHyOmt2oMXkogIFX
 3HOxCoRpTDOr89WCydzwyaoJvNHESWKN2sydyEKNJmdgoVyQnZDr6e95yZTKHG4bYN+A
 YFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516027; x=1784120827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4M7Y6QoiDmYaokkyO537D1/trYHBcHnzouYNIFahmYA=;
 b=QQQQRIL6DCBFtPflur+WxVH7gkQY73N5rnZRvs8D5r8cwFdxyCUhXSsk6BSU/wl1aR
 zsVv+zZg1m8iqdDb+b6FCFtQLNoeGUMwvDEUKKNnIw5/n70ePWr2Uizw5LEUoCp6Qkcl
 5gBIUsVK3HMvtd+w/DKPZHwDJIu/kV94NZ2sFBhvCj3orztPY+jemgl75NlM0g5HjMUs
 UbN+eh3cWf2gtgm55IZzuqn04Hu0oNDSBbF4i4vnpUqkQEhhxtIP7b/W/eyYtl/BVNQd
 g3mn5GhNwLm9CKTjmlc0X+O5SmoY7dq7b3SsFedz6KVEvplpPPCok5Ckd7Io5iS+3Qst
 +nMw==
X-Gm-Message-State: AOJu0YwEW6sXO+JVKcviwd6yn0SnfesZUe6X7pwwZuKH2PAQ53S431W8
 3BRr0+J9kYOINZgRFaYw8mu/AKex6nXl5T8+PBxlr40UGzk6MK2Ic5WusOuJMpSOORw=
X-Gm-Gg: AfdE7cl/IkOHxdOtFxMqiUI2YurCpUqnJ9jbxyQfEZP5gj/u571q7vdzr4XWQjMKgZj
 mydhAh8QEnju7+6Q7ukWpdlmokGRmUZeKeFC1mfE8uFDJWgreUP93PpUd+NpCupMZlTJFVmyeTI
 omWtfhQxw2mZuj3+Mpc88DCEw6TWwyxxkvf8PVpJRH8JOCUEtRx3nsd4+78eIct4DxCDCsSNRTA
 THXvU9yJN6B2c67u46Je8EuLQkotFcUYlQEzkuRPKFEziG/8OpSIV1dBMe4LN8UV02BAs8U6iJ9
 6sVBrbLmv1W3UUgcC5j3gR/rD9G+TYF0YHvqt9q4s7vGMdL9rD12YcDvnTBLjIrdlhST3q6hkAn
 STh5mqfa13T28xhNqol9cfTmGEvh90Ck6suSCkw0BS/E+oAuXPaNdd1P1dlZYg2YodM5d5KcTOg
 eLmaRzQBXbE//E+d/vsLi899B9tg+tMTBgAEDA3p2sT1e2NrCO0Izhj+X+sd/T14oej3HvYG571
 tKSBxip2pj+b2/BIZu+dvCM5pDpeFS4CwkLt1wT78U1THOTtJdSb5bKGIf+2NkSnem4n8A=
X-Received: by 2002:a05:600c:638d:b0:493:df5d:6ca6 with SMTP id
 5b1f17b1804b1-493e68c41d7mr22325245e9.25.1783516027268; 
 Wed, 08 Jul 2026 06:07:07 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:06 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:08 +0200
Subject: [PATCH 02/12] configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-2-0e930b4f714e@baylibre.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
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
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

