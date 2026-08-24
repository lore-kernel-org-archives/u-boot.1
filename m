Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A09C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D66B40649;
	Mon, 24 Aug 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUJLGVZw-zMy; Mon, 24 Aug 2026 08:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561527;
	bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=APcu1vaSDhUzZ+GNEnmtspUUm/bYfyb4cixg8jiu3VpRlnzHphPiNJO7gtS7P3vmj
	 /aRMxSwRJAgk9dtn9bbxWNyROfnaTG9spqZyD9+0mCuvB3mrn8LOS94A/sruTe5FOR
	 HGIECfblHdSlRE6XnXEqjgMWkB5dqUbCEuSzUh//vOs49tnry0pNje2h03q7DZWzxh
	 zVR4+1SQQGVz4Jlmv17qLuFSxbJE+dTQ8UJVRVm1UxHG18DlQRq++9Okyo2gcUWqSF
	 YE3pfT98PGW5WBGiIpXGQ+f7zHCXoxrvN3yheTLYWKT1caMTCkI0b6ogJE5tTBF2Iy
	 ZUdxt48i9ZEjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9680E406ED;
	Mon, 24 Aug 2026 08:52:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77D863AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DF4380E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tppuf7iGrz_T for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=zdhC5u5q
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6ED8D80DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:05 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so35614725ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561525; x=1788166325;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=zdhC5u5qrfTtcfuQK01qI1G+o3XNNb5JxFretnjSv7jTbM5cb3n11NBx0O23S38jLN
 rfB2uWpGij6H0oW3hmK1lHH613z3QiYUE6093o4nEP0JmAtZ8W8bEKhp4jHXRo6iBRg4
 p0K2SDQ3lGZ+x9lP6VTPl1VSEULJDC4rBdVEd881uATkGFtk0fntzJ6NQwu91bIuaOkD
 +q+jzqKrvlLfprHUrh/ivtBNHzLCIkp7b5yZ+CEMITdvdUSGtNTP0nG1Vl/WfZ5h5ytw
 DNt1xjlOd6bOHpuuta1Y3s4DSTTLJvrFB0Y1VcSbALYilrE3wtsIlLQ/Hctp2sp4K2/h
 XpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561525; x=1788166325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=tBy3Wran93Lv3dL3xIs8tqFsIsi1UnYWUgSwnFHFSxPGYEwC+ckrXU2VrIt2UokLS5
 tmsmit50AVblFhkHkIjlgRucmcT7EjDepdCQnBbLMa7TW6z7MijGVaJg20C0KWnupTeU
 2GgTv8rfmkBlgSmOiICACsZWsLVf2B2wAxjvZtwDEzodSQMLsls1HkE+xW4mHD/GJaRp
 0yUV1otZlFB9yGR3ad5EUi+uO2xNpYHZBLAV/5H5vo8yYWU/yxeMa3YSp90hQD6QkJUk
 stbZh+c5tSaF4P19V24GN908yFOYKn+JJQprcyKJVRbKnNFRG3xasNSsyG7y056M0ibJ
 JOEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpExRolv819tOLRt1f2dyxUeyC6KXyTJVmpwOsT1gJn/nD1AfPUCsjrDBX82bIoAQuSnGiF/r4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kcOnP4G5+7s5Cu0h6Vr7OUz1CHsR1dRbkG0oeojqwKg1UeFBiE
 pZsmS3ISLFJEYJAHweZslIiRoTquF4SM8HiQO68PJGfslrlUgBUu+XFS6cgJi9kQsyA=
X-Gm-Gg: AR+sD12cUXnOnteBR366VTyQEvO90egruxEX7qOgwyX4lUfGkQIGEh45T97HnHPt145
 338z7UjTlrAuTGtNyLy+ix+H4osDa90JLAKjmu6GczIva1uPZXWwnh1Qmyaap6H2f3BBpNWg7LD
 6QdlNEF+PtHmcY1D8MpRSFQ72U5swoW9wqsKDWhhwDSz5l337hV3n25Su/R4bLtFW+k7i76v1s1
 xfq5xIQzp+yASKoKLGE57jXNB0Iye/WdQPeuJwPyeuKj362tmzVeKIbFa8GbkkMwwuEUJyc72Gp
 +ntTh/npC/ieZztD+soFUInWmIFgIxkviONM7tnBx5+9jzBqSNhPKF0I5tXCR1fXdMs/M9hhnsY
 E16erKBhTblpv+vQhYzhrCHl6zgTjZ6sOMMRnk4KKw/Dvi1qoHzLWPDtEETxRJAd1rFMGzKK8/Z
 TaSaL4xgMYYiLnFY7ICGbh8BJHi3L5v9vUGzfytp7nSpAom+VzgJeiQ+GP0BTsFbTj/PcFsZ9CX
 4tAP6KrffwmtelzsROkXNcaDgh7ZD4EHNNiNjGJ204wvegKfO+lxCVV/gdpEuhmMDfDfbkGSTqM
 8J3Y3sY62r7p+yfQl+7rEvzKoQ==
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2d64ada8eb8mr485523465ad.2.1787561524729; 
 Mon, 24 Aug 2026 01:52:04 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:04 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:47 +0800
Subject: [PATCH v10 12/17] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-12-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with internal pull-up support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#
Link: https://patch.msgid.link/20260520130624.1763487-1-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 85e4c5733cd7efa39f10d7200095c016ce4a2815 ]

(cherry picked from commit 9f9e7116bf6057433905f05a6ea06dd17a4b41c4)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 4aef287353ca..0d809e4ad3b1 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -19,6 +19,8 @@
 		serial0 = &uart0;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -218,7 +220,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -384,3 +386,21 @@
 		reset-gpios = <&gpio K1_GPIO(123) GPIO_ACTIVE_LOW>; /* HUB_RST */
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4_3v3>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

