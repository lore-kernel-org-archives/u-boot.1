Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A798C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E251780C31;
	Mon,  3 Aug 2026 20:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1-1gjA86bqF; Mon,  3 Aug 2026 20:57:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC73D80C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790672;
	bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iVVf7ZrlTPLHy6jVmgpyKZeLnify+sZOlx8BsuvqBvEczDMHN3LrOFTmf6bvCevxC
	 ePkX3VFOmXyBtl6FYr3SCAhOAyQ11s3Dp61f62vcCPwuXpKFIoOlIhx+MCkDJJzgcR
	 QMlpNrJePgMId9DnZEegexCCaku0FhUx5Gxk5gZKwA0MQ4c3V3mTJPE/99O+kItJzO
	 Bbb4fLHskzTYXfDf+Ot62ZPLwHVXe8v9WbyRohjFDqCMXc8dbg56MDnK3hUy6If/Zm
	 TofgKADZpiiXHke3UCPYpHktRS9Fzf+Ju7c1SjDEwzroJV2Xs3xLWR2ySp9ary7AVd
	 AXXj1gp04eftA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC73D80C0D;
	Mon,  3 Aug 2026 20:57:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C1628F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37F6D4010D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rl3AYoahQgM for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1B333400AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B333400AF
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B333400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so3443852a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790668; x=1786395468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
 b=JWTTcdHhA2Gibs0fIoo51wLvZ/LjRNCldLHD5ZaR+teklM9hI8jdF/y0NeUlziyaGE
 wqEGwwtc0Ib5yEBf9craPIOJA98ImTTcvMM/3ZZsiaHqoir1002Ysf3tMncXjwcgj0c5
 Nh+Q4Cvao++fBAgWpGtiI0n7sDxOfX3FEE2CjgQ7eWl2y4y2sbbIJ0cOGCy6Qq2npypv
 v9GESjqpHFuRgJeYi6pwDZAvsdz9Kimv98xM+LHrOkuNIBB+G2QS+TI5ZwSNi6WArcL6
 cNuV4SAmjQHNuwfQgEikRk8rQVMRotZJcfuEUdi4/p6XhlbhBPI5Nrw0BVZdAReiL4sa
 gtzw==
X-Gm-Message-State: AOJu0Yzca9+0pjLQSCVDlVRxEpN8YG5OIsoCOzrEsayUgY6oDwTTobYf
 0oVwwFronLsfY/1vdMBpuj140ryjoBbhtu5BlmvlKXqtWJ5v6MkgdXESycC2pNQ0NHIiXV5/LUn
 NUhpUwww=
X-Gm-Gg: AR+sD10GZ6loBk1h6Oh/ntKhy+xOaZDgpIQrVkHYfgd0mk/vPN1N2rp6w3fOX9coitc
 OKiJ8fqP3PwuoQvVucBwUIl3jNZyYNtRIb6DujJm03Qvtv7hq4kdWRVKUNjVaVeYphTdpu1EtkM
 ldAiyuaqePZMFs4ZY+fbid7UIcR7W6kbh1/kUSG8F3XpnMaszayHNaO+OVFlMU+9S7abTQZOqf0
 d3binpWJc0bcveyi4IJ71NmoVFhpkuNcI/LurBMqbyXB+logayMP+aEf4+BBjN/NYQvKSz3GWAp
 kYMH/wn0Z7n3dhDy5dxFtsYwtvIUPWJ8oJD4LjiSP2u2pilXvRq+qHKuBuyn+Bb0XqqV3oGte60
 VNhNVy+wuXf5+U3Uaaa/7wzmswnqEbNYwldxcJjVOueVCkSiJdRBNgoby8lN5TCe8IvzYkwAoXJ
 HoVYt3WyxXuJNymU/ssil8aTOq9OYnffHnY8mpL71PRKv/r7Z01kzm8L40G23cJY0=
X-Received: by 2002:a05:6830:67d4:b0:7ea:b8c:4198 with SMTP id
 46e09a7af769-7f196ca46b7mr21496564a34.8.1785790667937; 
 Mon, 03 Aug 2026 13:57:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f0d6a68sm8421452a34.19.2026.08.03.13.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:57:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 15:57:07 -0500
Subject: [PATCH 4/4] configs: mediatek: drop no longer needed PINCTRL options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-pinctrl-kconfig-cleanup-v1-4-fef1ff69d1cc@baylibre.com>
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10367;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=TwB84B0HvPxB++AvGkex2aad6snoxP50gK09TPFD81Q=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcQC/ZrtlOXfAZgiGvm3pTUjmq1ANizqn0ccgd
 YHMazyClpOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEAvxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVjgH/14iLhMcnp3XFHTprk3chaL+Ids7RQzomEwNUi+
 xqY1Zobx/xepHL3wGfHH7gmT+WmXwuPHOY9Dzath+Cmtp6KLBBJGrnxP7Zmfg2M2HGMGiem8eCb
 +4Q0+B1dPh9hjdbtpqejpYNG3awTpiFYfyGtu2PkxMu0FBCoeDtACEtvD34ldw4jBxK7IlHUnyX
 ldd1dRckEwKiZxDLiUZLN2sNk1qnOUcD+11UkJi+YoJDNMZE/ceZ76D4cOBcX9SPDsx2xvSSQiI
 /N1gwScj47SLu4VeSPCncEls5GXCAfzJYrsgSYTHA3//6N3o3Wsy5F43pdVIxi6/n1Sae8z8/L+
 lzhc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790668; x=1786395468;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
 b=e87o/J7PIeVU46nFwReZYbK9mPRqnq9tOd4i+BojwGJBboL+1p97gNfTh6c99sIsPy
 /bvOK8S5xZzjxWnA7N+rr4ftnMLIz4AxNQylGo+F3RAA6QRIC9OdSmasvUqMvvHTiu9L
 ES+LjxATwtxd9wbY6H9BJ5iZJF9enGQQ6PmxYiuEhGMoZZPC+emIO0shD+Dc0atY70DS
 TsxaeKgYLGPYB2zCOv6e3Vk6Z5QO+p6TsAri5eqtKnVe+EPMMbWGeKYQe1ks+skkCOIC
 zhoZEA/tdbSHGYmGXL4WfgqjWCe9NXHiFjOsFHM8E5VSxD/ucxdLyeLWQ5q+DFtdQeNW
 1hGw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=e87o/J7P
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Drop CONFIG_PINCONF and CONFIG_PINCTRL_<SoC> from all MediaTek defconfig
files. The former is always selected now and the latter no longer
exists.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt7622_rfb_defconfig               | 2 --
 configs/mt7623a_unielec_u7623_02_defconfig | 2 --
 configs/mt7623n_bpir2_defconfig            | 2 --
 configs/mt7629_rfb_defconfig               | 2 --
 configs/mt7981_emmc_rfb_defconfig          | 2 --
 configs/mt7981_rfb_defconfig               | 2 --
 configs/mt7981_sd_rfb_defconfig            | 2 --
 configs/mt7986_rfb_defconfig               | 2 --
 configs/mt7986a_bpir3_emmc_defconfig       | 2 --
 configs/mt7986a_bpir3_sd_defconfig         | 2 --
 configs/mt7987_emmc_rfb_defconfig          | 2 --
 configs/mt7987_rfb_defconfig               | 2 --
 configs/mt7987_sd_rfb_defconfig            | 2 --
 configs/mt7988_rfb_defconfig               | 2 --
 configs/mt7988_sd_rfb_defconfig            | 2 --
 configs/mt8188.config                      | 2 --
 configs/mt8189.config                      | 2 --
 configs/mt8195.config                      | 2 --
 configs/mt8365_evk_defconfig               | 2 --
 configs/mt8512_bm1_emmc_defconfig          | 2 --
 configs/mt8516_pumpkin_defconfig           | 2 --
 configs/mt8518_ap1_emmc_defconfig          | 1 -
 22 files changed, 43 deletions(-)

diff --git a/configs/mt7622_rfb_defconfig b/configs/mt7622_rfb_defconfig
index 10df7847a4b..d35bed49afa 100644
--- a/configs/mt7622_rfb_defconfig
+++ b/configs/mt7622_rfb_defconfig
@@ -48,8 +48,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PCIE_MEDIATEK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7622=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_RAM=y
diff --git a/configs/mt7623a_unielec_u7623_02_defconfig b/configs/mt7623a_unielec_u7623_02_defconfig
index 77473e2731f..13fe8766b98 100644
--- a/configs/mt7623a_unielec_u7623_02_defconfig
+++ b/configs/mt7623a_unielec_u7623_02_defconfig
@@ -46,8 +46,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index aacaf5380fa..13fd033b2f7 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -48,8 +48,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index 91da684939a..4b2412cc571 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -80,8 +80,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7629=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt7981_emmc_rfb_defconfig b/configs/mt7981_emmc_rfb_defconfig
index 75e7140bdfa..3c24da09505 100644
--- a/configs/mt7981_emmc_rfb_defconfig
+++ b/configs/mt7981_emmc_rfb_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
index 6322af51b18..e57637b9e01 100644
--- a/configs/mt7981_rfb_defconfig
+++ b/configs/mt7981_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7981_sd_rfb_defconfig b/configs/mt7981_sd_rfb_defconfig
index de05e2486a0..a3702dc83fd 100644
--- a/configs/mt7981_sd_rfb_defconfig
+++ b/configs/mt7981_sd_rfb_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
index 87fbe677624..519022a8da6 100644
--- a/configs/mt7986_rfb_defconfig
+++ b/configs/mt7986_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7986a_bpir3_emmc_defconfig b/configs/mt7986a_bpir3_emmc_defconfig
index 92459ad9fe2..fd255ab8719 100644
--- a/configs/mt7986a_bpir3_emmc_defconfig
+++ b/configs/mt7986a_bpir3_emmc_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986a_bpir3_sd_defconfig b/configs/mt7986a_bpir3_sd_defconfig
index 2c88255e69d..b3826dad560 100644
--- a/configs/mt7986a_bpir3_sd_defconfig
+++ b/configs/mt7986a_bpir3_sd_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_emmc_rfb_defconfig b/configs/mt7987_emmc_rfb_defconfig
index 00d7e5a610a..59a1aadb713 100644
--- a/configs/mt7987_emmc_rfb_defconfig
+++ b/configs/mt7987_emmc_rfb_defconfig
@@ -75,8 +75,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_rfb_defconfig b/configs/mt7987_rfb_defconfig
index 0b353c6cf01..9e9ad69e50b 100644
--- a/configs/mt7987_rfb_defconfig
+++ b/configs/mt7987_rfb_defconfig
@@ -70,8 +70,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_sd_rfb_defconfig b/configs/mt7987_sd_rfb_defconfig
index 30ff09365da..5c50dfef072 100644
--- a/configs/mt7987_sd_rfb_defconfig
+++ b/configs/mt7987_sd_rfb_defconfig
@@ -75,8 +75,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7988_rfb_defconfig b/configs/mt7988_rfb_defconfig
index 375df418ce0..3d74f09f436 100644
--- a/configs/mt7988_rfb_defconfig
+++ b/configs/mt7988_rfb_defconfig
@@ -65,8 +65,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7988=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y
diff --git a/configs/mt7988_sd_rfb_defconfig b/configs/mt7988_sd_rfb_defconfig
index aafbed7bea5..955e6e63d42 100644
--- a/configs/mt7988_sd_rfb_defconfig
+++ b/configs/mt7988_sd_rfb_defconfig
@@ -53,8 +53,6 @@ CONFIG_MTD_SPI_NAND=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7988=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y
diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..c6785476d9a 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -17,8 +17,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8188=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
diff --git a/configs/mt8189.config b/configs/mt8189.config
index ab56c90a17c..7c37c37a199 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -35,8 +35,6 @@ CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8189=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8195.config b/configs/mt8195.config
index 03f57d46708..c12ff93e3eb 100644
--- a/configs/mt8195.config
+++ b/configs/mt8195.config
@@ -17,8 +17,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8195=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 5db8418e36f..b3dcc5cc5b4 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -22,8 +22,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8365=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8512_bm1_emmc_defconfig b/configs/mt8512_bm1_emmc_defconfig
index c7ac0df39f5..7f0f866e282 100644
--- a/configs/mt8512_bm1_emmc_defconfig
+++ b/configs/mt8512_bm1_emmc_defconfig
@@ -38,8 +38,6 @@ CONFIG_MMC_MTK=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8512=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
diff --git a/configs/mt8516_pumpkin_defconfig b/configs/mt8516_pumpkin_defconfig
index 72ff8c79153..80184898930 100644
--- a/configs/mt8516_pumpkin_defconfig
+++ b/configs/mt8516_pumpkin_defconfig
@@ -70,8 +70,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8516=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt8518_ap1_emmc_defconfig b/configs/mt8518_ap1_emmc_defconfig
index 2722e107dc7..fa4b88b24ad 100644
--- a/configs/mt8518_ap1_emmc_defconfig
+++ b/configs/mt8518_ap1_emmc_defconfig
@@ -32,7 +32,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MT8518=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y

-- 
2.43.0

