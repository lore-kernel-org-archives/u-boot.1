Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F56E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FB683D9C;
	Mon,  9 Feb 2026 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TeUPMn/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3F68388D; Mon,  9 Feb 2026 19:24:10 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE41580325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40945a682b5so1789066fac.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661446; x=1771266246;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uU9kXeq7wEHBqwm25Z76mCemjhr0LpM0JwzYuAUfr6w=;
 b=TeUPMn/4yZrtNDm+c0TUS1qRGEBlCn3ZwDcTYPjB9G/KPvi7Rha2V3nws6zGSEmArC
 /+fTM6t6ziQl/QG47Kl2e1o14aatEE09HC7TlpO3ArNt7pwLviO2Kcqic/NO8xlDu7tQ
 5z8tMA3MLlZPAGwwC/G0QRPNBZLRfzflcUUc/+z4CQEFXDmuu+2/6JzRwz5990zD3kl4
 JBFZ7x07QmplmUg+8YnYNdvFgy6Xd93cBO0jUL/UpqQ6YlIdD4WgTnYi0pL6BN/CWpX4
 bfLbJ+7+B4N2HxwZDlzOYyoaoVN252IwR6o04R1pNUu4iEUniv7macZqDJLE5W2WvViv
 ndZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661446; x=1771266246;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uU9kXeq7wEHBqwm25Z76mCemjhr0LpM0JwzYuAUfr6w=;
 b=jAPXLb0uS2AKVdgXfZLmYYn/Y+PWmbSU5aDO0JUcY+yEMxAr/gjibifN1jupprOJLz
 pEbAG9OJaF2yWK0o/E6uy1PNCHaANp28CzejjiWKGHnaIK6obIOs7YlHQ07WHTwoUZ2g
 VhMVdVuK16Z87Sz2W3faZx8iTFAByzDfNjpLtPst4B4P5l1mjghbBBp9l4A5aAbQrico
 DCkFPvsKMlYMfxKq8am69y+ffCno+w+Q5NAsyU7hY05veeZB9j0Nyk9hyG1SHSbjIhP9
 mnB/bGLMR0vrLOmJxyxAYx7Kz6duisRSXauZ/DCu7T7FnPmHkeFu3atnRVFHy81q7bJv
 57Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5tWF+CaGnsw9X/PqxYkpZrSq96Bv+wbXrIyy7uXw++dsi3I+jNpLtHGSB/Y7c9qpHzVaWhxo=@lists.denx.de
X-Gm-Message-State: AOJu0YzjK2GDdEny/CgLFFpcjkFnxKXj7WvUdSJWZxu8dtYQPtpF1Dak
 vSyKXoLmLQYz7BiIs519p0VIPBnn8qfrgQRxnpsoPRrOED7WiTAB1SzePTBOkMbAk/M=
X-Gm-Gg: AZuq6aLf9bbUsv1H/X/xAFXlGrbFpHIARExOxkMx9gTnkMLA/qf8fx/fGBX7WRlgfju
 25cDAy+SGnxSsncXtrul8y/hyZ8P+4AR8TErU9gvHO5/sPD+Bizkofz/ShAjCQX7SxiNN4y1uZD
 uSwDBfGE5xxT5L7tHqGhMkEyPAyujXowj/0UZd7JTp1ECyc1S+1Ff5GX46k0oqSRiPbMkPxnqUq
 v4om1nvtJMuKijLVwPmzmpacRLh0+Q0RvpYZBgDaU1Tee8yhfMW6Iy/Z6BZwxFro1GE3+z9PAJI
 5h5A1kOfT5xkYaf2xRgHr7aOhhMFYN7huvXfntk7PTKBRStZteOJuWHh+WsrLb4L2SBfSbVpHBC
 dDvYqppKcMhB+FgKvdMVjBJT/EsEvURCTY9dFC689WV9VBYVfPCpT70pPkMstNfD6vuqa1Ku0RC
 d1fFHC6uuMK+ykOSE=
X-Received: by 2002:a05:6870:b2c8:b0:404:590:59dc with SMTP id
 586e51a60fabf-40a96ec5d32mr6849693fac.33.1770661446103; 
 Mon, 09 Feb 2026 10:24:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99359eb4sm7993335fac.9.2026.02.09.10.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:24:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 12:23:18 -0600
Subject: [PATCH 4/4] board: mediatek: Add Genio 720 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mt8391-initial-support-v1-4-b23ab9d0b9bc@baylibre.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mhD/QCf9e/8ga0f+cV2+10MYBoahsUUrwoaRFRy014M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpiiY4D3/54KmKogUJ4qrEZGC/zkNyV0Lv2H+56
 grA2A/M43OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYomOBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnMsH/37QgBjcs/TzmftmTSLeKcqQRJLZA37zpIc0L6y
 ZHYzD3hfVwH/B52b7iqcoof+5l6YgNXaXd9tu8gVjWF+JEcjca9U2wNgIqcdzQLAk6qmrO6ZMRj
 Uj/Kx5cF3O55/WFMHJSA2V+LXENoJLcTo/0HCYRyog6uS7DHdJZSPUsBBsJuo3t/yM813ZM87Um
 PoultyOjC9lDz+Bx6dZQXxjaNVo8+HZdfLIC2UaJARu/3TNhAbIW43j0UFc7lLNDSZc+skpFeqd
 SbEjF+XL1JuuImDOekvW3w9aKz0X6qROmLN3r+7n+Z/bTi2PtGZS3x0PXfBZ7mM+bGwDE5PZ4Qy
 f6h8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:39:13 +0100
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

Add a basic defconfig for Genio 720 EVK, which is based on MT8391 SoC.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  5 +++++
 configs/mt8391_genio_720_evk_defconfig | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5d19892e26b..5b7f01a2ac1 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -8,3 +8,8 @@ M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8390_evk_defconfig
+
+MT8391 EVK
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	configs/mt8391_genio_720_evk_defconfig
diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_genio_720_evk_defconfig
new file mode 100644
index 00000000000..07e7bebd0ad
--- /dev/null
+++ b/configs/mt8391_genio_720_evk_defconfig
@@ -0,0 +1,28 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk"
+CONFIG_TARGET_MT8189=y
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CLK=y
+# CONFIG_MMC_QUIRKS is not set
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8391=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.43.0

