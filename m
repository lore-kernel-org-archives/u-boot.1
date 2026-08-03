Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65035C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3088E606D9;
	Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 74rMxrSAjPZD; Mon,  3 Aug 2026 20:57:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BB53606A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790669;
	bh=+t5NqGAgY0qxZ1YOzaZ1Jjx+hzpe08Zm2eTAslE2KXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HvuNKCtXtPysik3JYQrMADobZU5RouedXF6abAkMUCPtU02Ji5deZHRm/EUENRP5Z
	 6F3Drb8tdKsMnrLqCFriITXGJFFxTg9VITcw1gP6vAR7F+oYqjglUmjPp9xlpM5XnV
	 Co47O+Fit1HV3Lm0fWxxmYRDHNHrgpNKrDcyhA8/JspfzCT0FO8L9z3pM65hN+hjnq
	 F9SWVTebqd84RdaI2dO4nExevxkj+RHwbjIzKXu51SJyWFzPqNZJP0NWYLIZ/9SRfO
	 UIHR8r8QxkoBocpg8b1XJ5IhD0nLIpSwoTVsfg3rdp01gHmY6jFcBrIxJU6refSUi5
	 iXQGU7D80xDVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BB53606A8;
	Mon,  3 Aug 2026 20:57:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41DCC194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34159606A8
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Be7W4icLp-MH for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 68DED6069B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68DED6069B
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68DED6069B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:46 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ebd88be784so2452179a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790665; x=1786395465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+t5NqGAgY0qxZ1YOzaZ1Jjx+hzpe08Zm2eTAslE2KXc=;
 b=ez/JQ6HwStjAZQ9zTI+16txmVLso1K5vg7BrGFm+hQyTMphbueo5eoUjSlgndAR2bB
 9POv//NrfWysbR6O7RwIZsu8AbBjKSZ8+vU1OLwP/HTAGvDbmmUN5Rn343xz026yQwZz
 kXV6xBxQmX9ic4d3k47nuFR3uvKQk0F+PxdMocAVaMqyxaYqW5pM0UwmmLayqK93K4Os
 0MLF/CrfGjHAR1r6DBTbm7hakkoYfHSiBP7V32JN7AalUqugx5y6X949VeSBCA34n3sq
 C8sLzZXHmQ2n+AZst/2ayxU7zwREtPrRIs5GW9tEQm2Y0Cc5bQ6WKRUSEZeynbM6Kiv1
 hcDg==
X-Gm-Message-State: AOJu0YxL8z0/rS8tMPfc2511JCUucb/Ka8zsJ6fmCDDXx6uqK9ME14rM
 EVgiH5JNSxfYmQv9aJEhKJ76ldFhs+LdqCYRdjLTcd5wJ3qjmcUG0z16EI33bv3+RrtECQukWFN
 k/NErO0U=
X-Gm-Gg: AR+sD12C9PmCS5tJmaAAw0V+EcoUzUmxTWnMWmo2NxGPgmzEiKE548KLumNIv6GIEks
 W4QhBjAd1ZLUQzjwpMIAuCOsRIM6TlMD/ZNC+J6rKbzaaYyGPnQg0+Qp+o7U9H+rzWG5AHoF0B5
 KQOZGh9cwSDrWbuKbG9AADrYuaywzqpFcq+MvAhtvbgTDv7CND1YrFbKsVprGjaDCr/kV6G9Nw8
 3p2s7cwSOPCctbI1IuoHDkqjijzsNerJmFnDACa6mRhcA6J2sHqVWAfO4Vnx23ndWXYYoc3SdWd
 W3hOzAnS3/MU6c1bDUUBN4rws+72ANlXeA7vTZEWyfPuCYhqA3DozXHQSOIg40EAsY0uj43n0fA
 ZfLhz8IUsiyYTA4NzlXT2z1rCJz6RTPA8azRrTCEbI5cutS1ce035UjzuEai3O2QP83UqzMTyWx
 bOrgX8xO2hx46OpaTouqKARgzniDj/nKb/dxwaGVMhAcqQT7IkLzxtbexxzN1QU6kGLa19Xwz1Y
 Q==
X-Received: by 2002:a05:6830:3498:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7f196c0a081mr19488253a34.7.1785790665318; 
 Mon, 03 Aug 2026 13:57:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f0d6a68sm8421452a34.19.2026.08.03.13.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:57:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 15:57:05 -0500
Subject: [PATCH 2/4] pinctrl: mediatek: remove PINCONF conditional compilation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-pinctrl-kconfig-cleanup-v1-2-fef1ff69d1cc@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8gq4QWIMnxibujRG167PNREA8BRNHS392MSbrepz+kg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcQCyHQBYBwcmqAOvZzFcd+l5LtX6E1n0Gx6qL
 bHnr8uQJ+6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEAshYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfzUH/iA841n8J0EuySmCLs7KLJsfqzdeYnJftEjSIXv
 Fe++LFHAYjN5403V1oZFh+187WM6FLch5hmNit7sQkv7sUVK23LCyQO22I8t9GvF/dPCcYwEY1w
 k3j/KiG1DnW/V63Y1wpXBgia+1Isjoqy87CL3I4RS4BUcwovd7cMn5LTHnWP8cu9QayeISQQetu
 6Gee7FIflCWVE528LthrHlDoEmA5kGce8TJKiEXUQ+YFTWD+rSlsTEZYUv7cJe1ZBBTCWoDff1i
 E+F9pjZiU4qjzvWFYmZB+GvVPLJ9NYSERLbhmWjxSC9lVTN7P9jgJlVMgXDnsBbjqw2MqpKywji
 3JrE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790665; x=1786395465;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+t5NqGAgY0qxZ1YOzaZ1Jjx+hzpe08Zm2eTAslE2KXc=;
 b=NPFY6AibQ0ZKykpqpnhzvABQ50nBYJzAjH9RnVviE8hfqZqLZoZd8G5F97usRJUKeK
 Xysomn1lXNK3pE353YNpUq8YgHi+032j0R34EQFZt+BAfUOOs1W6MCJFmZREM+dOKo7c
 meT3/XixBQwYYDoDhxzwK0mjyuwyJrSFEkMW0XtjRUhaJAvqqOlsEKtibCNv5ilWXZMY
 X8Csxv+eVjqnnW5OeeV02+6bYalxQDs09HLMEXknN3b8bGiH0FQIDBvAnQe6iZVsM7Gm
 b9ggKVgZrl/J1CxTF3QAFuyauXcBg6vIXK1ZajH79sJImMvza2Rv8sH9VvDN2RmpoU0j
 PoTw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NPFY6Aib
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

Remove #if conditionals that checked if PINCONF was enabled. The Kconfig
now selects PINCONF, so it will always be enabled and we don't need the
checks anymore.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 01f67f09407..0b8234e167f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -19,7 +19,6 @@
 
 #include "pinctrl-mtk-common.h"
 
-#if CONFIG_IS_ENABLED(PINCONF)
 /**
  * struct mtk_drive_desc - the structure that holds the information
  *			    of the driving current
@@ -45,7 +44,6 @@ static const struct mtk_drive_desc mtk_drive[] = {
 	[DRV_GRP3] = { 2, 8, 2, 2 },
 	[DRV_GRP4] = { 2, 16, 2, 1 },
 };
-#endif
 
 static const char *mtk_pinctrl_dummy_name = "_dummy";
 
@@ -223,7 +221,6 @@ static int mtk_hw_get_value(struct udevice *dev, int pin, int field,
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(PINCONF)
 static int mtk_get_pin_io_type(struct udevice *dev, int pin,
 			       struct mtk_io_type_desc *io_type)
 {
@@ -265,12 +262,6 @@ static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
 
 	return pos;
 }
-#else
-static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
-{
-	return 0;
-}
-#endif
 
 static int mtk_get_groups_count(struct udevice *dev)
 {
@@ -378,7 +369,6 @@ static int mtk_pinmux_group_set(struct udevice *dev,
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(PINCONF)
 static const struct pinconf_param mtk_conf_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
@@ -757,7 +747,6 @@ int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t s
 
 	return pos + scnprintf(buf + pos, size - pos, " RSEL:%d", rsel);
 }
-#endif
 
 static int mtk_pinctrl_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
 {
@@ -779,12 +768,10 @@ const struct pinctrl_ops mtk_pinctrl_ops = {
 	.get_function_name = mtk_get_function_name,
 	.pinmux_set = mtk_pinmux_set,
 	.pinmux_group_set = mtk_pinmux_group_set,
-#if CONFIG_IS_ENABLED(PINCONF)
 	.pinconf_num_params = ARRAY_SIZE(mtk_conf_params),
 	.pinconf_params = mtk_conf_params,
 	.pinconf_set = mtk_pinconf_set,
 	.pinconf_group_set = mtk_pinconf_group_set,
-#endif
 	.set_state = pinctrl_generic_set_state,
 	.pinmux_property_set = mtk_pinctrl_pinmux_property_set,
 };

-- 
2.43.0

