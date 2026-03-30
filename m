Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87011061B1E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF6484073;
	Mon, 30 Mar 2026 22:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UHiQ8DNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C1B8406D; Mon, 30 Mar 2026 22:43:15 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7040E84035
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so4245130a34.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903392; x=1775508192;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IS58oGlI3K4E9yn6RW3fuRXWIgigGLgxVWReu6yRXc0=;
 b=UHiQ8DNSDGWDqBUhw3sCIG+KSVa1RlKlz/0VLN+Kv++hCQpnCgCogUsY5KIUjqScTf
 W28ycJSCstde9sTWzOXW165rysmJ0JUamOOuLJBZ5LAfWfUo/pyjczIMM6LJTLGwzapE
 6yDZObEHQIgD5aGLQvKzwl+PDFInzxruIQ17fFdygvQHLvmw2y7YVTckKV6AvSJ9ARnM
 QyuvvHnVe6K30y1C6X/cWAbDAgZ8VaULP3U7LYH2K7Rma9Nxa15vZh0ZCphp0g195T3j
 kNZbxeWmQMhoq90sx6vemIXuKdDhyOSHMM8WQM56KmWRtyOEMQEGko0idlv1ZurMw83L
 BPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903392; x=1775508192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IS58oGlI3K4E9yn6RW3fuRXWIgigGLgxVWReu6yRXc0=;
 b=nCfRbr3xDlkQngGiWf06mnooNVzroWTLQrRnU0BYNG9ccBlWp19Fholv++3c29brx3
 efm0DcrXGzNBEUJgwwc7Ul6ngB/9wTjRw2QAuR8k1EVmMoRT/zCpW5XdoenapW/BPlc0
 FDi9mxmD03CSM+rtgtd0rtkLuKu3/KiIe/GN2iu2mDWS9IYeA73DJrvnxSEPJUywx6d9
 WHnycgBxjBwE6A0Ew3oEsirx5XRoqEpGC8h0LdPkLdMCIGkq+znD1DKuSJJ5r8sm7Nng
 wabncO6ef88++cdDg8Sab/Tx48rcXGHGRlawBlHwzld8JNFnuDiqsO8IVGqRxw4P70Lg
 oVCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX5xBKy8IOnmthdhGNVQ3K4DML0ADAq8D5eWuLM2XsEPcibX0RGokqcCOx3vCzPex8otqRPI4=@lists.denx.de
X-Gm-Message-State: AOJu0YyuWLuAAwv6kNzjC+29KtWpX4aTP5Lbd2IlE03pawtJr9rmLQEd
 zEcTzwJ7MQY0PdSRGQfv9V1SU82hoiaD1ukMyhGGq5XCK+lKKgj8bwr08ts0j7rPPco=
X-Gm-Gg: ATEYQzzplyoJPBbZNrM8Fu7pjCbZmvY9B+hHK123aeS1DrUhZNr4I/ACSjvmlOtG2b+
 KvlQykBngo49s4VUrjWZOQrlk2yTkurK7pOQvpmva53qZUfAv5YtZVWbW8k5eFvA1oqXCa88viW
 310IQW/vDzlb2GrLxDVGOshB3LlyI41cGBgcgp85IdcjKSqa4jmI9wV3hLNmc9Gh7p001Snis8f
 KgxDT5v2UZFKhi08fc01+hRwqCja7SBYIhfqK2Fn1ym6bVHN4mGPr9WzJt2etB2HRiLwcON2yYU
 RQA6vMtQFVc5Y1qR9Ld1ffEvVe19yNtnQKSRWGOG6o7rP5bYvHKuDT/1nTXLTOixCP9+1mJhyun
 Blot7O0SwY/zgEfBZ0oqwbttSV7hm7AFV/kbAjqP89ZMq6WrO7+o6LuvXObd2ft0ibNCyPCw2D2
 hA0j/LZTCg4x/y1wGROOd9TeeaAx28
X-Received: by 2002:a05:6830:82e7:b0:7d7:f638:7a03 with SMTP id
 46e09a7af769-7d9fad504d3mr8513679a34.10.1774903392019; 
 Mon, 30 Mar 2026 13:43:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:18 -0500
Subject: [PATCH 6/6] config: mediatek: add UFS defconfigs for Genio 520/720
 EVKs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-6-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=twhUtTDi6hY2gcwVO4uUmjnzlRwECi9CaxxFX2N8xgE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuBSSMSCUqIQtIUCMggRtizfcSupz3GDrvdhN
 7c7MeYNTVuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgUhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaaYH/2vqcgDCkx+YVzPIeDxweCWXug27HzChZHA7JHP
 bKH6Td98qkrKLPgy8inkR1GTaiF9FxwUxHEjY2BOOyJzhgiAiLWbHJ+uexLMdi/AAzjFJuutJn0
 FYTkpXovTJWKh4+UuBYutB/+YKONjI28FKOI1w0jdzoJ6WCOWtyJ24axAU1W6ZM+jUlYO4iy6FV
 WQhUe1rQguE032HSBoN2k47szznyYrjcGu8W5kHGNqbgSKQwC+B2YYlQXYsLtbDmO38Y2PLqeP0
 a0Rx+mWhP15hLlLmg7Wcdbleg8NISWO11pcjeqEuUdIeil8WVoJWBnXJjHGsIsP0dNvBjWMtZzy
 qZg8=
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

Add variants of the Genio 520/720 EVK defconfigs for UFS boot. These
have a different devicetree when the boot DIP switches/jumpers on the
EVK are set for UFS instead of eMMC. These also enable UFS and related
drivers that aren't enabled in the eMMC defconfigs since UFS is
disconnected in that case.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS                 | 3 +++
 configs/mt8189-ufs.config                  | 8 ++++++++
 configs/mt8371_genio_520_evk_ufs_defconfig | 4 ++++
 configs/mt8391_genio_720_evk_ufs_defconfig | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index b0fbffd26ea..37ca35b4dd4 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -5,9 +5,12 @@ F:	arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8371-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8371-genio-common-ufs.dtso
 F:	arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+F:	configs/mt8189-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_520_evk_defconfig
+F:	configs/mt8371_genio_520_evk_ufs_defconfig
 F:	configs/mt8391_genio_720_evk_defconfig
+F:	configs/mt8391_genio_720_evk_ufs_defconfig
 
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
diff --git a/configs/mt8189-ufs.config b/configs/mt8189-ufs.config
new file mode 100644
index 00000000000..8a7afb95b1b
--- /dev/null
+++ b/configs/mt8189-ufs.config
@@ -0,0 +1,8 @@
+#include <configs/mt8189.config>
+
+CONFIG_PHY=y
+CONFIG_PHY_MTK_UFS=y
+CONFIG_SCSI=y
+CONFIG_UFS=y
+CONFIG_UFS_MEDIATEK=y
+CONFIG_CMD_UFS=y
diff --git a/configs/mt8371_genio_520_evk_ufs_defconfig b/configs/mt8371_genio_520_evk_ufs_defconfig
new file mode 100644
index 00000000000..a0b365a86a2
--- /dev/null
+++ b/configs/mt8371_genio_520_evk_ufs_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189-ufs.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk-ufs"
+CONFIG_DEFAULT_FDT_FILE="mt8371-genio-520-evk-ufs"
diff --git a/configs/mt8391_genio_720_evk_ufs_defconfig b/configs/mt8391_genio_720_evk_ufs_defconfig
new file mode 100644
index 00000000000..f1de9d5fa1e
--- /dev/null
+++ b/configs/mt8391_genio_720_evk_ufs_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189-ufs.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk-ufs"
+CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk-ufs"

-- 
2.43.0

