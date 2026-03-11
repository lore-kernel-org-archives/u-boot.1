Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0662DFD88D4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E72B8409A;
	Wed, 11 Mar 2026 01:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ksIh/X7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E6584020; Wed, 11 Mar 2026 01:17:51 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A200183FDC
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d749f99691so1535657a34.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188268; x=1773793068;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=82SwtGQ5GHkSM67wD8bDlqdHpk+S8pP+vBp6XxN/6PI=;
 b=ksIh/X7ZfE00Jw2NaYJ+AcHdTEHnESwsRmJZ737Gq8TNSCmEjBiw9H5rWQPKmYACbG
 rbDtwUA3XtOM40T3WV4AiG03FeNn8RTYLEqz7ORr7pAtwtoZRDmiEp8jjfmVaZerAgy9
 /i2iQ1Gc9bwtEnE5q3n3WF7lNE7JQ8kvDdo9SgOCaXiw/U+nHopapaS0bVUbbO4vBP5I
 BZikh7aTlY0qudh2vYvth8zv3IbhLdVVHp2mQOVzPR3MXBwt7HI8cVrtmSXzPuUN7sih
 R1+XhMdf27TNJT9cvju57hUyhb42A54KMbJKAzeA0qMIG3r0/Svr0s7w6Qc74p5sh1zO
 9NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188268; x=1773793068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=82SwtGQ5GHkSM67wD8bDlqdHpk+S8pP+vBp6XxN/6PI=;
 b=hhiHha3L169mXLjNabCgNHF3D2/BjHFVBqHkN5+pCUc6/wUVAEkzK4fmu1yI7L0i5G
 B/a1X0Evat4Ds+2D9RkjwE80UcS5ytK+jQSZVwng/DEj58RgHwb7fjk0xiZlfvpFHqGN
 GaZw0o2DdpZbPBBWWbgCY77fFpMvPvk+BGo2OAhQ4sFtmL5C9RrWfP+eXPpsuOcDbB6G
 KTryYR27iefIVyMEULrzEL6c9MVDmAKugwdc4Ui7DhYlsELoz9M6ZWj8b6seJXV7jbAt
 8MFYbZu0jT0GF5W4z27iBIYp9Lg8YikKB86HxQGV9B33pSnoX5ki2uLJFQI932LiOB3F
 cOUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Ij7dymxseBysn4DoZOgDNlmeqOJlgK1E/7jK8R3XRB8J3HqfB0e3IGZb9FySQQk/irV4gjk=@lists.denx.de
X-Gm-Message-State: AOJu0YwRjyDzxE1k0GRvFENFTr43CpJCXbqjhPPrwvPaYb+5s8CdxBzi
 DfJLkbIhxX/er1gO7QHRZtQNw0KAnz74SJbRjtvyaErXSEAN/sHsXO37e2CfhBjHjZc=
X-Gm-Gg: ATEYQzxuALXVyccsTbB9EIekMkZEfhu4Rkj9sPb3IvTVfQw+XXt6aqT/3bxyBesWAVb
 Tz/OYI2COc5uP2ng/4DrEzXTR6U7BzTIye2fYTM8McTWF2DL0aDLnV2TSk0d7e7R0hVkgaZAaDb
 zDTbVjlX+zPNULjxywZeEqWjGGWqWtQo9nYsKL4BJ4oUjbovjXmJGmeZ6A9PVJ1SPHW9YCtMWGp
 32POB+RLxzOwKpPZkwVCP1ZlVHWho7NCDCC+PR/j1cqhCQ38hAoI8IxP0xzF9p6FaAxj6ev/TR5
 ia03bhI1OBNscBkT59MDkmge/kuplfvvfWZ5QjGpDFow2gQUOpl1LuuMptJdZ/sZifZEQ+Dn8l2
 T7VmCGwd75e0JMLTqj+mluniEpNAZum8ogOEh7bMAjNjmjG15ldc6ZqbGa8dvQY0Nf98aSvAY+i
 xbhammBljGqFq3duaxD2455AyPZmBp
X-Received: by 2002:a05:6830:34a8:b0:7d7:5b78:ef31 with SMTP id
 46e09a7af769-7d76a690e0dmr653744a34.12.1773188268361; 
 Tue, 10 Mar 2026 17:17:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 19:16:55 -0500
Subject: [PATCH v2 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IQNKpCJGNHqi39Rjo9d72dnAYKEtmvjrwAmyYsWd0Q0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLSfpiQ8RrdjCm8S7JErzvkbino/74Igd66bN
 DZDfOJwbqqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0nxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmKcH/0fDbF860ZmkU3sNJQ3/2SFdm9bh69b/Lro60Lg
 flP6BcbO6jjcR+/LrAXu2PIiL+rNeyDUpWToesxcc1hV7X5A8KA2G1P9733oDaVZlfuC8N5jt6G
 CUiDAPOjw8T0VWzo2arl+kG/aIAyH6y/n6apxgSmmGzd6NFS/fPiJLQ+hfMB1b0OxizgZSN8Zj8
 j8dG3JgZYsSh3/ypNXTs56tVg7GPvHbQNYuzWVte6JPpv/kmh9y9uP8hlCQfRD5R0oNkGrlft/L
 dBFrgHICGV+Ms46UCsXlP0bl9UCKGP7kOtZD1U8ZvPg06CHFPxN1O/CkVT+RbVLH0h8tYDNZ9+Z
 glDw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add basic defconfigs for Genio 520 and 720 EVKs.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  7 +++++++
 configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++++++++
 configs/mt8371_genio_520_evk_defconfig |  4 ++++
 configs/mt8391_genio_720_evk_defconfig |  4 ++++
 4 files changed, 49 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 446a9e8e53c..4f371592059 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,3 +1,10 @@
+MT8189/MT8371/MT8391 EVK
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	configs/mt8189.config
+F:	configs/mt8371_genio_520_evk_defconfig
+F:	configs/mt8391_genio_720_evk_defconfig
+
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
diff --git a/configs/mt8189.config b/configs/mt8189.config
new file mode 100644
index 00000000000..966d05d1a03
--- /dev/null
+++ b/configs/mt8189.config
@@ -0,0 +1,34 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8189=y
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CLK=y
+# CONFIG_MMC_QUIRKS is not set
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8189=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
diff --git a/configs/mt8371_genio_520_evk_defconfig b/configs/mt8371_genio_520_evk_defconfig
new file mode 100644
index 00000000000..9a5e68e48ee
--- /dev/null
+++ b/configs/mt8371_genio_520_evk_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk"
+CONFIG_DEFAULT_FDT_FILE="mt8371-genio-520-evk"
diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_genio_720_evk_defconfig
new file mode 100644
index 00000000000..3fcd08be50a
--- /dev/null
+++ b/configs/mt8391_genio_720_evk_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk"
+CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk"

-- 
2.43.0

