Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D33710FCAEA
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 21:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E213F8407E;
	Wed,  1 Apr 2026 23:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t2phflAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263D480517; Wed,  1 Apr 2026 23:54:23 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A53E84056
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 23:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d1872504cbso188177a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775080460; x=1775685260;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e116WbGMDiUP/yovEmXxtWKUYHKO93PR5QEsqzoFKUQ=;
 b=t2phflAq1Qaqe0o0/dC1//LWeK66eaW4e+ZQvpqL8TVkN60v2k6rqEvMgUA0m9Nrzo
 nsD5gH6MPVW+ox8I/tRLIyZu+1gMz52NibU7JqoXBWTQnSJQzTq/Y0NT1FJpXmiZY8c/
 85Lc0Mr0WfJH/V6+jk1Lxld51AYVLzp0JWHrs8JFBZE08796rROOo+UOXh/ssFeKPHx6
 nkwhTyJ2JkxlnTFZjqMl3XWNT5Dnm4Q1ff2cKFTGQ/MO47yeWufQ+0PO4EQ07SworT84
 ktQvzdzyfB1zcNZ1LnuPzyzVBWJBaK1kVzS0B4W/IPxEfxMlXrJT8g5ymaCi7CHqB/pV
 5OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775080460; x=1775685260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e116WbGMDiUP/yovEmXxtWKUYHKO93PR5QEsqzoFKUQ=;
 b=FGcaM+K6l3Y8Qkj6uruA3TRIPhfRc9R28Tt5otSZlKaTgIm73sR9vihFKtBdI7DbuA
 oUHkTDsTS/4xiODhgCaK62HjbByA4FNnkYx8yWi2NmUzg/KkRxAzAWgd7S4It2hIUznz
 bCgCXvdHJPy9CCXcaHaFXBcdJbI/V4VNq5BzeTNpOPF8WnVBCFTmfDwamNP2qU8aGe8k
 p0lvE1B8EXxRWL9ZB+zPSVoizSBZP9oC/IRciF9lv4AekbpbHTJW3uG1Gv1LrNhLYSRL
 Wpva+8MMTcxj3ARUjpxERmv72Rlz1F8uPyQTipG4t9t+OWEmQ1GSP3XLiZX3Pz4rYOoU
 dqIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwb0IX5IRHsTnzXLSjpJVIOTVvw62FGavBH9p/m0sV3KlM8Xi+QmkkMtsvwyfy8DToDyuzz4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzn5ffRfvE0rrn+rnD3K9SXNLx3Alh7mxX9sHknsG4JTuUZi7u
 ooWNwEMUNSfflZY37ca4RqCrAM4lXEqRtdTdQnRLbbdWqTEeKlP1mpKWmKgjhQ6LeOM=
X-Gm-Gg: ATEYQzxeZpY63lnqZnkKrtaJN/FyhtQBTJh8W+KT0umckyEwQELIPE72fPvjZQmMh5U
 JPGKYsJ9g1ppqtiYp4ubnZqwjM28gZvWdTx1hwaklOdasBqkr/Hp84zKy4Nwg2TP4XjZv9kxwOG
 dp7ot7DCzXaYKKX+Yyfi/Rbtbk7n9d0AfPb1Y2tKoLy7TQhnTGjJH8bKRG1JTRq+cve1LW/+R5v
 YwurD3ShoYYy5shru2ofTyuqxCj5AdYPcuI2znh6GO3I7EXGH6X6PdR+uRS/zMxO5/q8qicU+Pj
 P2trOkNCIc2GlcMXpFuUOxdHl5vqfq3HBNiGYfcL+xegNltp7rsgH0MwpM1c4PNIji3I4JQyGGP
 fSm8cLk2RgCF/LhL1Xa1s5bn1Il2a4BTEEtvdfCgYLAhE1fKy4k2h0xRCmHiiJxUamdx+d3Zuzv
 s0CbIHis/Nd0Nv0RE3fp/8CbRSFmBk
X-Received: by 2002:a05:6830:33e8:b0:7d7:4eaa:8b82 with SMTP id
 46e09a7af769-7dbabd17ff9mr8829a34.17.1775080459769; 
 Wed, 01 Apr 2026 14:54:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:57c4:ef89:4ac4:d6d9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba7184e14sm743492a34.11.2026.04.01.14.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 14:54:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 01 Apr 2026 16:53:47 -0500
Subject: [PATCH 3/3] configs: mediatek: mt8189: enable USB support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-mtk-mt8189-usb-v1-3-a4bf951aa8ad@baylibre.com>
References: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
In-Reply-To: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mvRKrAkjnmWYN7+8MwJtYwT3ILJtTlJKlFKJ69anA5E=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpzZP/MXFAaunbLWOAG24fC4WvPFqwDa9uRbC5M
 g+nqKzUdmKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCac2T/xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AN/8IAJs/8SnB6LIPBkhKGlblUP89oLl6c4bDLwULepS
 Z/5QJ20UxeAmuz8qRef0KvRzHokJsIYRad+URh7PWoi2xghAZyGXdStnYfnQH+1cLiOVPyE0L0V
 to3S8BBNmj0NQleZ786i+mq9op5kdS6/oOJybz1/rU4XS+OOJDNADC1400CUy2sxfSgDD3bXXsu
 7F0R4i1/HYUpPYAZS14aB/pC5QDcEWjHWR+IFU4NTL9fHh6Au03nMnDhCwIOo1YBKYgZ8rjoKWA
 AVzHrjVgNL32kb97IVL+gcboMvJRNquydDJJS+eWjKnX3tn41AaN8V2SPplIR7y0zK4L5FVWCg8
 mHMg=
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

Add config options required for USB support on TARGET_MT8189.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 0c158cd9430..74edd0169ea 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -16,21 +16,29 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_XSPHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8189=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6359=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.43.0

