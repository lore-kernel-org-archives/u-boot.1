Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8442AD31A02
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 03:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9AE802C1;
	Wed, 14 Jan 2026 04:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2HApDFbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF6D802C1; Wed, 14 Jan 2026 00:26:06 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DE38004F
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7545310b8so4616247a34.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768346762; x=1768951562;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2CL60i0V7NXFShA1VR+3pgB29kHX5MZxI4Zge1qzBtA=;
 b=2HApDFbecrko39AYlVA4YV0mEVl/U3hceEt2wolJaCOv2aL5Q/WKYsigmzx1g9AUrX
 H3OZSmLVN1T2tUbYDU5hwqzTBxAtDQ92RsMDt9FjKQi99QOulbG17WSxtnP8PHENor7O
 G0EIe7ESE0SjHcnLnZWAYsU3tZru+nO0PqOAT09YlvQEOxjBpgai8UyKTiv02JC0Pqvw
 K2gKJZC4Be9PdIo//gbIa16D8syBKgOD5/rDDx6ae2UZtUBFIB8FT9tXRPCIXmB0E681
 ALiJgYCBdGTJxelYApHru47yqwmSERnoZvkw0YVa2VMvboEaGbOcLjZOJ87qgwm3vl3D
 e3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768346762; x=1768951562;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CL60i0V7NXFShA1VR+3pgB29kHX5MZxI4Zge1qzBtA=;
 b=AC+tDk4gx4eEaP1085vAUsl8gr3AdCJ1T8s/FxonN6gXwMhVpovqKViP1XwxwZL4mG
 MijmmxQ7sCbM+wNEw9mNqjLDX36tNxVIfW+bYOfwC7XKC4pWNt6cUw5JQb+2hb1Qss8B
 Ze9dw5C0Re7w7HoA1YBmWWVM4G0Rk+TlZoCKVRIGDK1syUmlnYEHQ37Gb1+nhnr0A1Qw
 UPrVPrwF5X1nVjdaRN/uHEGCiIEWoNhLH1UAmtlWc5ONW5ay9PghwEyapAGSqaJsxqqy
 TiEkyzyQqEeYWrhhnzlfRHUDTnSwv1GGxjOQAhlyVYFPoAiEBZHluHXHE66XoCywCzY7
 Jb0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRLPqOfjXYw2PzkmwdkHuF0MmLmFfAmj/A/X7d8UNMqFefuDUt3Bk7hRPk9YXnrOhTN1t2GHk=@lists.denx.de
X-Gm-Message-State: AOJu0YxC95cKgdixnNZNXjQ3E2U3IAeKpLhtJ3s/m4Kon9XSgiKiXFpk
 KD7zT7jgke6cfqUsPcP3w1T0tCBpJVMczcE8vKu84AqaJ9jd+tySuSK64b8F7EX9HwI=
X-Gm-Gg: AY/fxX6Zg0UiDiLgtqPjA44vMwtV8c+Tj5Y+/X78qI530zwxg0o/fn2Y2aGshVq4pxZ
 DL3xqBAHhWpuy8mBfiG63BlA2Na1vHp4+o/6LF3WD6qy8hDU6OZr8nGO893hcsTyCuM202vGGf2
 0l4frIsw/t0+evWLtF7HaDXBfkDkV6rGz/4PUHrOz5HOz1u4naPCjUhlK3nYE7DiWIs/mB7IUkx
 tgwVqTxfNoPQfbxhnCvAPMZBouRcpDzJ1ZzHjQuo7wmrR+A92xcibmR+WmFazy0lAZWa0Bq2ZjF
 jttBeDg6x0E2DPIqLrNhF/PK2nIZ9KAx8oTECmJTCN0HC/ZafFjFYhWR8w5FToozzqiDVh8bKCL
 am7gVibjL88LuTbBpCebM0FbP9futiPobtco7QdpApbmAj8TNEC0wGpLEd6FUocNx6czpSI9EMZ
 X6UvWSG0EbWJoZXJ8=
X-Received: by 2002:a05:6830:4ac5:b0:7c7:51e4:1360 with SMTP id
 46e09a7af769-7cfc8a5bc7cmr549150a34.13.1768346762393; 
 Tue, 13 Jan 2026 15:26:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2f58:e1e3:bd08:f09e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ee990sm17017766a34.30.2026.01.13.15.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:26:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Jan 2026 17:25:52 -0600
Subject: [PATCH] pinctrl: mediatek: set array size for reg_cals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-pinctrl-mtk-fix-reg-calc-size-v1-1-3846c53fe010@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gZav+BVxEWtUYNaJS0iine3u
 HwwzAOehMlDkzwgdLLn3UXoNAE7GzcR8hANmcoqpXWOBzsbZMUtLDjyhUITWrNa9HwTqtH0dan
 7uqgKiI9DKEb/v+3e9wNppaFlbwAAAA==
X-Change-ID: 20260113-pinctrl-mtk-fix-reg-calc-size-0fab751b7464
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8216; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EVODopPcQRf7x0AXBXJxyBpkeehp+XDVjHf75QMiOK0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpZtSCimm9VLp9tM8BeA42nEsxNuIGj4+9un+Ht
 hoPRLYYu/iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWbUghYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZOkH/0OpVkexcZ50BZZHqQKkr66qpsTn7qQGKiFgeJD
 SDGjyec4uvb9E3xJBu8wmji8FJMhIAGlcOCuqfo9K1PvsFU7fr7AqtBJxMUKdFgRp2EDOLkyiwh
 k9MKH3Snh1cgCNmXXMZJNpHr6DjQQSEeY9dS6lWMpsEyk/C8rjvoiPQSFHFUHOTWeOL7qJ5C838
 BboSs2FHbvQkfpF8MQg+XgZ4daaDCPDpJ5dPE/8s5nyP8GzEUEptyb0j5kgzp1/5e3ZTa4l/tu2
 hwNpQUo4BUIEkPzilS+BYg+nmPCivuppn8gVPVtCkRqRK+HGIBEwgQ3fyEmKNb+ve1Ijo5+lDKw
 dTzQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 14 Jan 2026 04:16:18 +0100
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

Set the size of the reg_cals arrays to PINCTRL_PIN_REG_MAX to in all
affected mediatek pinctrl drivers. This is needed to avoid potential
out-of-bounds accesses when they is used in mtk_hw_pin_field_get().
All array members need to be initialized since the code loops from 0
to PINCTRL_PIN_REG_MAX - 1. mt7622_reg_cals was already defined this
way, but the others were not.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7623.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7629.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7987.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7988.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8512.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8516.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8518.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index 55e49a790e4..e9678cebd3c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -388,7 +388,7 @@ static const struct mtk_pin_field_calc mt7623_pin_r0_range[] = {
 	PIN_FIELD16(261, 261, 0x140, 0x10, 10, 1),
 };
 
-static const struct mtk_pin_reg_calc mt7623_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7623_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7623_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7623_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7623_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7629.c b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
index 3b82423c145..d67220dc2f7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7629.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
@@ -80,7 +80,7 @@ static const struct mtk_pin_field_calc mt7629_pin_drv_range[] = {
 	PIN_FIELD(70, 78, 0x7600, 0x10, 0, 4),
 };
 
-static const struct mtk_pin_reg_calc mt7629_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7629_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7629_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7629_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7629_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 13c3dc143cb..0d48994bd89 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -494,7 +494,7 @@ static const struct mtk_pin_field_calc mt7981_pin_r1_range[] = {
 	PIN_FIELD_BASE(39, 39, 3, 0x40, 0x10, 1, 1),
 };
 
-static const struct mtk_pin_reg_calc mt7981_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7981_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7981_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7981_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7981_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index bf8cd037535..61ce2ec8ac1 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -415,7 +415,7 @@ static const struct mtk_pin_field_calc mt7986_pin_r1_range[] = {
 	PIN_FIELD_BASE(66, 68, IOCFG_LB_BASE, 0x60, 0x10, 2, 1),
 };
 
-static const struct mtk_pin_reg_calc mt7986_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7986_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7986_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7986_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7986_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7987.c b/drivers/pinctrl/mediatek/pinctrl-mt7987.c
index db672d26798..92b43cf3b55 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7987.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7987.c
@@ -386,7 +386,7 @@ static const struct mtk_pin_field_calc mt7987_pin_r1_range[] = {
 	PIN_FIELD_BASE(49, 49, IOCFG_TL_BASE, 0x50, 0x10, 8, 1),
 };
 
-static const struct mtk_pin_reg_calc mt7987_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7987_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7987_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7987_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7987_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7988.c b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
index 639e2415c63..74655493414 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7988.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
@@ -606,7 +606,7 @@ static const struct mtk_pin_field_calc mt7988_pin_r1_range[] = {
 	PIN_FIELD_BASE(83, 83, IOCFG_TR_BASE, 0x90, 0x10, 15, 1),
 };
 
-static const struct mtk_pin_reg_calc mt7988_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt7988_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7988_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7988_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt7988_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 0eae85b0078..2e291501584 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -223,7 +223,7 @@ static const struct mtk_pin_field_calc mt8365_pin_drv_range[] = {
 	PIN_FIELD_DRV(136, 144, 0x770, 24),
 };
 
-static const struct mtk_pin_reg_calc mt8365_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt8365_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE]    = MTK_RANGE(mt8365_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR]     = MTK_RANGE(mt8365_pin_dir_range),
 	[PINCTRL_PIN_REG_DI]      = MTK_RANGE(mt8365_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8512.c b/drivers/pinctrl/mediatek/pinctrl-mt8512.c
index 5a8dd4ddd40..4fb15815d86 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8512.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8512.c
@@ -178,7 +178,7 @@ static const struct mtk_pin_field_calc mt8512_pin_drv_range[] = {
 	PIN_FIELDS(112, 115, 0x760, 0x10, 16, 4),
 };
 
-static const struct mtk_pin_reg_calc mt8512_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt8512_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8512_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8512_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8512_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 9c25066fc2d..09d71d45c89 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -184,7 +184,7 @@ static const struct mtk_pin_field_calc mt8516_pin_drv_range[] = {
 	PIN_FIELD(117, 120, 0xd70, 0x10, 0, 4),
 };
 
-static const struct mtk_pin_reg_calc mt8516_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt8516_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8516_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8516_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8516_pin_di_range),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8518.c b/drivers/pinctrl/mediatek/pinctrl-mt8518.c
index 333184a6bb2..0367e739e8e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8518.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8518.c
@@ -205,7 +205,7 @@ static const struct mtk_pin_field_calc mt8518_pin_drv_range[] = {
 	PIN_FIELD(116, 119, 0xd60, 0x10, 4, 4),
 };
 
-static const struct mtk_pin_reg_calc mt8518_reg_cals[] = {
+static const struct mtk_pin_reg_calc mt8518_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8518_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8518_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8518_pin_di_range),

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260113-pinctrl-mtk-fix-reg-calc-size-0fab751b7464

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

