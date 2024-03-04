Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F8C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E2987FA0;
	Mon,  4 Mar 2024 16:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jjll+dTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABFF87FB1; Mon,  4 Mar 2024 16:26:26 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF1586FCE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-68fcedcf8aaso21673586d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709565983; x=1710170783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=35sEnZaYe9k37qXQ098/xjPOwYcqYJvuzBPQsvvqBc8=;
 b=Jjll+dTIHHp/WgmGQhBjpvM7a3tAdXKy0NuYRFYUclRqfuwIAIxG8Ge6eyHQgdJVBE
 dn2wdbsiW4SC5+qs9jRO0QqKFHFoMfGPaAjnF6JiFrZeC9Y3Pfa75tHlRxQJ0wb/sqVH
 RrsU4zkvS9q3FhsXxsQUUxtZ54QGYkcVLDJfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709565983; x=1710170783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35sEnZaYe9k37qXQ098/xjPOwYcqYJvuzBPQsvvqBc8=;
 b=oyWb7KIOy3KQ7Hq3HHTdsI7ZKF23RSCDbf/jM4COJ7cYgEuTZfjFJAhrbwQKr3md9n
 yIrm7tHYdhHnSIEHO+YfIqoMvr9wtw1PTrKbRF9lpHfUJ+ogYjVpEBrlBRvFbSGlspNi
 M/Fe8wsSMvn26nllivlnv/NhwLO3pcdLqqYq+T4p12hAVs3aLvPvcd4066+VbsPjVPoO
 47p8By/Z1UtZMbZaIYG1aIOshLloul5J70owUY0VbSBspV9l7v7jmIeiLd2PPIZYAyve
 a89jjG0gV0L+zDaTQI9rJoTrXtcejYi4rIS/X87FW+5ochcpEcimJ8ZuV1QRKVtE8+AJ
 rk+g==
X-Gm-Message-State: AOJu0Yz6N67qduZiupHHj9tl2lD55FiC4V0HrV3m5u+NDUt9FhQZJCcC
 j0xFPW4CyE2R8/ZEQzuR+FBAj+vfZXOMnleSBRaCZSamfpkdl4CWFHUdzIuuJNrRGxCkVGKz7ky
 A
X-Google-Smtp-Source: AGHT+IEfjt7uen+Irp5RADETytP9ehSFHeXHES47ph8cgiBwjRXd7f8lY6VYJIhdgOthZ/Peq1CsZg==
X-Received: by 2002:a0c:fcd0:0:b0:690:4e5a:7255 with SMTP id
 i16-20020a0cfcd0000000b006904e5a7255mr10064632qvq.14.1709565978886; 
 Mon, 04 Mar 2024 07:26:18 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 oh2-20020a056214438200b0068f572af88esm5185280qvb.75.2024.03.04.07.26.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] boards: Remove empty BOARD_SPECIFIC_OPTIONS
Date: Mon,  4 Mar 2024 10:26:17 -0500
Message-Id: <20240304152617.1993764-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While there are currently uses for a stanza of "config BOARD_SPECIFIC_OPTIONS"
followed by "def_bool y" and a series of select/imply statements, having
this option set followed by nothing else doesn't provide anything.
Remove these stanzas.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/anbernic/rgxx3_rk3566/Kconfig           |  3 ---
 board/chipspark/popmetal_rk3288/Kconfig       |  3 ---
 board/edgeble/neural-compute-module-6/Kconfig |  3 ---
 board/elgin/elgin_rv1108/Kconfig              |  3 ---
 board/firefly/firefly-rk3288/Kconfig          |  3 ---
 board/firefly/firefly-rk3308/Kconfig          |  3 ---
 board/firefly/roc-pc-rk3399/Kconfig           |  3 ---
 board/friendlyelec/nanopc-t6-rk3588/Kconfig   |  3 ---
 board/geekbuying/geekbox/Kconfig              |  3 ---
 board/google/gru/Kconfig                      |  6 ------
 board/google/veyron/Kconfig                   | 12 ------------
 board/hardkernel/odroid_go2/Kconfig           |  3 ---
 board/hardkernel/odroid_m1/Kconfig            |  3 ---
 board/mqmaker/miqi_rk3288/Kconfig             |  3 ---
 board/phytec/phycore_rk3288/Kconfig           |  3 ---
 board/pine64/pinebook-pro-rk3399/Kconfig      |  3 ---
 board/pine64/pinephone-pro-rk3399/Kconfig     |  3 ---
 board/pine64/quartz64_rk3566/Kconfig          |  3 ---
 board/pine64/quartzpro64-rk3588/Kconfig       |  3 ---
 board/pine64/rockpro64_rk3399/Kconfig         |  3 ---
 board/radxa/rock/Kconfig                      |  3 ---
 board/radxa/rock2/Kconfig                     |  3 ---
 board/radxa/rock5a-rk3588s/Kconfig            |  3 ---
 board/radxa/rock5b-rk3588/Kconfig             |  3 ---
 board/rikomagic/mk808/Kconfig                 |  3 ---
 board/rockchip/evb_px30/Kconfig               |  3 ---
 board/rockchip/evb_px5/Kconfig                |  3 ---
 board/rockchip/evb_rk3036/Kconfig             |  3 ---
 board/rockchip/evb_rk3128/Kconfig             |  3 ---
 board/rockchip/evb_rk3229/Kconfig             |  3 ---
 board/rockchip/evb_rk3288/Kconfig             |  3 ---
 board/rockchip/evb_rk3308/Kconfig             |  3 ---
 board/rockchip/evb_rk3328/Kconfig             |  3 ---
 board/rockchip/evb_rk3399/Kconfig             |  3 ---
 board/rockchip/evb_rk3568/Kconfig             |  3 ---
 board/rockchip/evb_rk3588/Kconfig             |  3 ---
 board/rockchip/evb_rv1108/Kconfig             |  3 ---
 board/rockchip/kylin_rk3036/Kconfig           |  3 ---
 board/rockchip/sheep_rk3368/Kconfig           |  3 ---
 board/rockchip/tinker_rk3288/Kconfig          |  3 ---
 board/theobroma-systems/lion_rk3368/Kconfig   |  3 ---
 board/turing/turing-rk1-rk3588/Kconfig        |  3 ---
 board/vamrs/rock960_rk3399/Kconfig            |  3 ---
 43 files changed, 141 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/Kconfig b/board/anbernic/rgxx3_rk3566/Kconfig
index 6743a28a2f5d..b5ee67c16b7d 100644
--- a/board/anbernic/rgxx3_rk3566/Kconfig
+++ b/board/anbernic/rgxx3_rk3566/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "anbernic-rgxx3-rk3566"
 
-config BOARD_SPECIFIC_OPTIONS
-	def_bool y
-
 endif
diff --git a/board/chipspark/popmetal_rk3288/Kconfig b/board/chipspark/popmetal_rk3288/Kconfig
index a5f404306a83..22228aecdeab 100644
--- a/board/chipspark/popmetal_rk3288/Kconfig
+++ b/board/chipspark/popmetal_rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "popmetal_rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/edgeble/neural-compute-module-6/Kconfig b/board/edgeble/neural-compute-module-6/Kconfig
index c445454ddedd..05de14f93c89 100644
--- a/board/edgeble/neural-compute-module-6/Kconfig
+++ b/board/edgeble/neural-compute-module-6/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "neural-compute-module-6"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/elgin/elgin_rv1108/Kconfig b/board/elgin/elgin_rv1108/Kconfig
index be9243164aaf..e942e133aa04 100644
--- a/board/elgin/elgin_rv1108/Kconfig
+++ b/board/elgin/elgin_rv1108/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "elgin_rv1108"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/firefly/firefly-rk3288/Kconfig b/board/firefly/firefly-rk3288/Kconfig
index 1c2bca86824d..ed1c9fcb643e 100644
--- a/board/firefly/firefly-rk3288/Kconfig
+++ b/board/firefly/firefly-rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "firefly-rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/firefly/firefly-rk3308/Kconfig b/board/firefly/firefly-rk3308/Kconfig
index 80b1ad85a2e4..fd6b981c4f7e 100644
--- a/board/firefly/firefly-rk3308/Kconfig
+++ b/board/firefly/firefly-rk3308/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "firefly_rk3308"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/firefly/roc-pc-rk3399/Kconfig b/board/firefly/roc-pc-rk3399/Kconfig
index 720fbbb5fa3e..c211e9d3c796 100644
--- a/board/firefly/roc-pc-rk3399/Kconfig
+++ b/board/firefly/roc-pc-rk3399/Kconfig
@@ -9,8 +9,5 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
         default "roc-pc-rk3399"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-        def_bool y
-
 endif
 
diff --git a/board/friendlyelec/nanopc-t6-rk3588/Kconfig b/board/friendlyelec/nanopc-t6-rk3588/Kconfig
index 032ef486108c..e86a94c59095 100644
--- a/board/friendlyelec/nanopc-t6-rk3588/Kconfig
+++ b/board/friendlyelec/nanopc-t6-rk3588/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "nanopc-t6-rk3588"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/geekbuying/geekbox/Kconfig b/board/geekbuying/geekbox/Kconfig
index 41aa8fbe03d6..ac5aedf46ad2 100644
--- a/board/geekbuying/geekbox/Kconfig
+++ b/board/geekbuying/geekbox/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "geekbox"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/google/gru/Kconfig b/board/google/gru/Kconfig
index 1455e1481dc2..c84ebaf3cc1e 100644
--- a/board/google/gru/Kconfig
+++ b/board/google/gru/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "gru"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
 
 if TARGET_CHROMEBOOK_KEVIN
@@ -25,7 +22,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "gru"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/google/veyron/Kconfig b/board/google/veyron/Kconfig
index 7f55d78dacbd..e24a2aeee04b 100644
--- a/board/google/veyron/Kconfig
+++ b/board/google/veyron/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "veyron"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
 
 if TARGET_CHROMEBIT_MICKEY
@@ -25,9 +22,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "veyron"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
 
 if TARGET_CHROMEBOOK_MINNIE
@@ -41,9 +35,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "veyron"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
 
 if TARGET_CHROMEBOOK_SPEEDY
@@ -57,7 +48,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "veyron"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
index cf3f7c91d92b..82988dffb3cb 100644
--- a/board/hardkernel/odroid_go2/Kconfig
+++ b/board/hardkernel/odroid_go2/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "odroid_go2"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/hardkernel/odroid_m1/Kconfig b/board/hardkernel/odroid_m1/Kconfig
index 999c4944a83b..0217c91d7b71 100644
--- a/board/hardkernel/odroid_m1/Kconfig
+++ b/board/hardkernel/odroid_m1/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "odroid_m1"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/mqmaker/miqi_rk3288/Kconfig b/board/mqmaker/miqi_rk3288/Kconfig
index 232a11209070..bb687c973fb3 100644
--- a/board/mqmaker/miqi_rk3288/Kconfig
+++ b/board/mqmaker/miqi_rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "miqi_rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/phytec/phycore_rk3288/Kconfig b/board/phytec/phycore_rk3288/Kconfig
index 57cd8e26ed71..09753ef238fc 100644
--- a/board/phytec/phycore_rk3288/Kconfig
+++ b/board/phytec/phycore_rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "phycore_rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/pine64/pinebook-pro-rk3399/Kconfig b/board/pine64/pinebook-pro-rk3399/Kconfig
index 3bb7ca448e46..3eedbcdd49d4 100644
--- a/board/pine64/pinebook-pro-rk3399/Kconfig
+++ b/board/pine64/pinebook-pro-rk3399/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "pinebook-pro-rk3399"
 
-config BOARD_SPECIFIC_OPTIONS
-	def_bool y
-
 endif
diff --git a/board/pine64/pinephone-pro-rk3399/Kconfig b/board/pine64/pinephone-pro-rk3399/Kconfig
index 13d6465ae6e6..5f207df6dea1 100644
--- a/board/pine64/pinephone-pro-rk3399/Kconfig
+++ b/board/pine64/pinephone-pro-rk3399/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "pinephone-pro-rk3399"
 
-config BOARD_SPECIFIC_OPTIONS
-	def_bool y
-
 endif
diff --git a/board/pine64/quartz64_rk3566/Kconfig b/board/pine64/quartz64_rk3566/Kconfig
index 3de1d8f7a993..104b7a1598e1 100644
--- a/board/pine64/quartz64_rk3566/Kconfig
+++ b/board/pine64/quartz64_rk3566/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "quartz64_rk3566"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/pine64/quartzpro64-rk3588/Kconfig b/board/pine64/quartzpro64-rk3588/Kconfig
index 96aa7921d32d..4147240e4e42 100644
--- a/board/pine64/quartzpro64-rk3588/Kconfig
+++ b/board/pine64/quartzpro64-rk3588/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "quartzpro64-rk3588"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/pine64/rockpro64_rk3399/Kconfig b/board/pine64/rockpro64_rk3399/Kconfig
index 3353f1fd0958..93aab57de686 100644
--- a/board/pine64/rockpro64_rk3399/Kconfig
+++ b/board/pine64/rockpro64_rk3399/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rockpro64_rk3399"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/radxa/rock/Kconfig b/board/radxa/rock/Kconfig
index 855b9b6954ac..c9c4576f2647 100644
--- a/board/radxa/rock/Kconfig
+++ b/board/radxa/rock/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/radxa/rock2/Kconfig b/board/radxa/rock2/Kconfig
index c2ff9e996321..82ecabac5a1d 100644
--- a/board/radxa/rock2/Kconfig
+++ b/board/radxa/rock2/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock2"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/radxa/rock5a-rk3588s/Kconfig b/board/radxa/rock5a-rk3588s/Kconfig
index 2d7fc85df4fe..82013adf013b 100644
--- a/board/radxa/rock5a-rk3588s/Kconfig
+++ b/board/radxa/rock5a-rk3588s/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock5a-rk3588s"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk3588/Kconfig
index 8f1444649afe..41dfe2402b12 100644
--- a/board/radxa/rock5b-rk3588/Kconfig
+++ b/board/radxa/rock5b-rk3588/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock5b-rk3588"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rikomagic/mk808/Kconfig b/board/rikomagic/mk808/Kconfig
index 4abad7e75002..61c27d2b4d83 100644
--- a/board/rikomagic/mk808/Kconfig
+++ b/board/rikomagic/mk808/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "mk808"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_px30/Kconfig b/board/rockchip/evb_px30/Kconfig
index 0042c8e4db15..03ed8088ca6d 100644
--- a/board/rockchip/evb_px30/Kconfig
+++ b/board/rockchip/evb_px30/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_px30"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_px5/Kconfig b/board/rockchip/evb_px5/Kconfig
index 9a04ee7e616c..7a42b4a21b1f 100644
--- a/board/rockchip/evb_px5/Kconfig
+++ b/board/rockchip/evb_px5/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_px5"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3036/Kconfig b/board/rockchip/evb_rk3036/Kconfig
index ef45f6292523..4abe8cff33ac 100644
--- a/board/rockchip/evb_rk3036/Kconfig
+++ b/board/rockchip/evb_rk3036/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3036"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3128/Kconfig b/board/rockchip/evb_rk3128/Kconfig
index 5b3095ade992..c36691cc8c5e 100644
--- a/board/rockchip/evb_rk3128/Kconfig
+++ b/board/rockchip/evb_rk3128/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3128"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3229/Kconfig b/board/rockchip/evb_rk3229/Kconfig
index 361dcb186036..f5862d5678c8 100644
--- a/board/rockchip/evb_rk3229/Kconfig
+++ b/board/rockchip/evb_rk3229/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3229"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3288/Kconfig b/board/rockchip/evb_rk3288/Kconfig
index 8ab07f41fa6a..0707486d2a80 100644
--- a/board/rockchip/evb_rk3288/Kconfig
+++ b/board/rockchip/evb_rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3308/Kconfig b/board/rockchip/evb_rk3308/Kconfig
index 0074429cb6d8..b12d7f8d73aa 100644
--- a/board/rockchip/evb_rk3308/Kconfig
+++ b/board/rockchip/evb_rk3308/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3308"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3328/Kconfig b/board/rockchip/evb_rk3328/Kconfig
index ef446b49dda9..1e084bdcd395 100644
--- a/board/rockchip/evb_rk3328/Kconfig
+++ b/board/rockchip/evb_rk3328/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3328"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3399/Kconfig b/board/rockchip/evb_rk3399/Kconfig
index 412b81cbee90..597b0a68b5b8 100644
--- a/board/rockchip/evb_rk3399/Kconfig
+++ b/board/rockchip/evb_rk3399/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3399"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3568/Kconfig b/board/rockchip/evb_rk3568/Kconfig
index f3d3a7e11122..ab710c58d3b5 100644
--- a/board/rockchip/evb_rk3568/Kconfig
+++ b/board/rockchip/evb_rk3568/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3568"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rk3588/Kconfig b/board/rockchip/evb_rk3588/Kconfig
index d38efe61d83c..5e15d2e9ccee 100644
--- a/board/rockchip/evb_rk3588/Kconfig
+++ b/board/rockchip/evb_rk3588/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rk3588"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/evb_rv1108/Kconfig b/board/rockchip/evb_rv1108/Kconfig
index 4a76e0b9fa98..91afefd8b79b 100644
--- a/board/rockchip/evb_rv1108/Kconfig
+++ b/board/rockchip/evb_rv1108/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "evb_rv1108"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/kylin_rk3036/Kconfig b/board/rockchip/kylin_rk3036/Kconfig
index 8d35b4e62bd6..debffe15c78e 100644
--- a/board/rockchip/kylin_rk3036/Kconfig
+++ b/board/rockchip/kylin_rk3036/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "kylin_rk3036"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/sheep_rk3368/Kconfig b/board/rockchip/sheep_rk3368/Kconfig
index d39b5e8b1aae..321bf814859a 100644
--- a/board/rockchip/sheep_rk3368/Kconfig
+++ b/board/rockchip/sheep_rk3368/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "sheep_rk3368"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/rockchip/tinker_rk3288/Kconfig b/board/rockchip/tinker_rk3288/Kconfig
index bca6c37bc949..04a9f1405a4d 100644
--- a/board/rockchip/tinker_rk3288/Kconfig
+++ b/board/rockchip/tinker_rk3288/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "tinker_rk3288"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/theobroma-systems/lion_rk3368/Kconfig b/board/theobroma-systems/lion_rk3368/Kconfig
index fddbf826df12..537a2e7d9af4 100644
--- a/board/theobroma-systems/lion_rk3368/Kconfig
+++ b/board/theobroma-systems/lion_rk3368/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "lion_rk3368"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 config ENV_SIZE
 	default 0x2000
 
diff --git a/board/turing/turing-rk1-rk3588/Kconfig b/board/turing/turing-rk1-rk3588/Kconfig
index 4c6cd6af3430..0def6e0d7cd8 100644
--- a/board/turing/turing-rk1-rk3588/Kconfig
+++ b/board/turing/turing-rk1-rk3588/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "turing-rk1-rk3588"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
diff --git a/board/vamrs/rock960_rk3399/Kconfig b/board/vamrs/rock960_rk3399/Kconfig
index cacc53f37802..0c052c6fec45 100644
--- a/board/vamrs/rock960_rk3399/Kconfig
+++ b/board/vamrs/rock960_rk3399/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock960_rk3399"
 
-config BOARD_SPECIFIC_OPTIONS # dummy
-	def_bool y
-
 endif
-- 
2.34.1

