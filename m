Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A61EC5AC80
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C668060AC0;
	Fri,  7 Aug 2026 19:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jreh1m8z0QEQ; Fri,  7 Aug 2026 19:17:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2A3860AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786130233;
	bh=upS70HhQev/+ud/cIL5MTNwaENzQ2pO91d7xn4VvJSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hu+ccDXsDAIW70GAfrl/HXkkq2zLjRnBxH638R7ucY2aD2qUPJRYWYIjhDb83yjsD
	 kT8vg9Px7nRrgmE24IKmMI45qzI0QDyENU+vQfZn2SAvbD75JN1wr6/TPPUoF6+cIq
	 WBFCra56DfvggOz5gCeOSPNIuWwrL5u65VQb/w0AoW4kxVIanMG3aGjBX63NzeUj7q
	 2u0pWuJl9ldMB8vlWk8dfRbp0kdbDcH13kCe8P6YuhMemrdcIRBNoEwvBUz9NzFeaK
	 fN1Cf20mp0+6XGsL6SknQJVOvxpihMC9prexWC/dRTxwokXrY2BqLhYOdpZMHgAG6o
	 ocGvkYuu0I0sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2A3860AAE;
	Fri,  7 Aug 2026 19:17:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 545B01AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51F9D812E4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A91BBzUyyLMY for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 391F8812CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 391F8812CC
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 391F8812CC
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ebd88be784so2500123a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786130229; x=1786735029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=upS70HhQev/+ud/cIL5MTNwaENzQ2pO91d7xn4VvJSc=;
 b=ddyBaB1IUDsWVOswf64HBj2TOous38eRVqmwDZa/MzTMOHE4GjkHjQ/N8/DdqF/cz/
 rdCu4U0P4rytyYKNwIOjvMBN430+5gbZcE1f5awl+cEkAygaim+WNYEC7oAeH4DLPAEn
 aiB1OWmZBE5maGVpqjr2SUhuaVJh0K3YSWpJophT6xCTvPn+gvcYON8HGrrA8sUaN/pd
 hFXUJlMtBAzoAM1s7GbSrHlGhK/lUu6qtra9OT9qVCLOe2LjvBfmY10efmKkRX38s4eF
 v0MopoCVY3iUlhOGBb7ewMq5kfIfpkndRZotHJp6D6ujgbxszrKEffuq9zkHkVYf0ADC
 8zcA==
X-Gm-Message-State: AOJu0YxIhAwCF7d5pKuQ71Q59O9+35krR37A4NeXF4Ri+fAlUpMbqT+H
 lVGCogVYHatr6r+UmV2zZXcEcCHV673AW2E6LqD1mFSqQidDID4S+zL1YpsEvIx4mMs=
X-Gm-Gg: AR+sD10ly6Y5ZQaMx31+eFkwnnkYWV3E0/qFxgQ0crk+aYXqF7IeyFygbYr2dWbZGbX
 u2NFTWDzZrasaDFMpfp28AETuMp2RHV4gODPkK6FbLJOe5RJ4zBdwOMIGFcyBJCwR6zata99GJH
 5d7x1rYBmmCJc7yPdaG7A1+vO05mp6oFgHHBIYUH7ivf6SUDyttln7iCLHgpJbPXZwmP1vrK98h
 HHBcrXwbMpu3e9KLTubItbBxF4jVE6iIfPEPFqyOn0aaZho0kZyXAUzr0OSkZxtIh/y8bqEqexy
 9Qtfjn3lfPeyqT97W2veZrMOpLmD1C0CqsbxPnRsBP/iwSamMb9DRVssDmptKpvHu6Lu+j1rAsj
 8PRUCVjDcRJLJPYjSMmL/VNJcMtrzzd6wbmA8D1yRf4FfLd6flNM2DEuEsCCe3HW8PYKn2BfVpN
 hltvi7P4k7Zp19W+JPdYO8+j/YDsxK1Ln7gz4ZAYHcuHmwGZzKKgYQF2Gb+amSdvqd
X-Received: by 2002:a05:6830:82d3:b0:7e9:d4b5:8004 with SMTP id
 46e09a7af769-7f34dd45ff1mr7694549a34.5.1786130229252; 
 Fri, 07 Aug 2026 12:17:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5acbcbsm1875251a34.11.2026.08.07.12.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:17:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 14:16:30 -0500
Subject: [PATCH v2 2/4] pinctrl: mediatek: remove PINCONF conditional
 compilation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pinctrl-kconfig-cleanup-v2-2-509a8f833181@baylibre.com>
References: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
In-Reply-To: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5MWQoUKeEWZ9nckOUw1ysJUsbbOjwK+P5a9ncyLMFq8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdi8dA8USn8Gn9FA9FFuoUuQmsCnd7XVg/9SjL
 wRiwoPkzx2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYvHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7l4H/3Zg9hFTaFY0Dgu6KEx6dWuOmp9Y4seOH1IQdZo
 1/BbamqeEpyheKHjbCw621xt8ys48h7X2nHMMq/xIJPMLk4owpLyBLpZBGaVAYnq8xI9Apn7Dvk
 IVzCpreyPPcWic4l6+yXj4fERPk9eko1zaRYKx8YHFWh3n54FhDSFxiICGUOj3q6WBSBAaCshlk
 MtkFGozJPA3AXcm388PgMn3Pfgy5ALIZ3Rh9aPd6AlxXg5ZyabFa3B354sdP3mxNIaSl8Yj3/DC
 plJCXbkvL/QaWNJGjGhmmktbLgombW3I6/HBD5WWXLnFExjel75ermw1KIFPXm9R8njOtgSdcFz
 mq78=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786130229; x=1786735029;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=upS70HhQev/+ud/cIL5MTNwaENzQ2pO91d7xn4VvJSc=;
 b=Wzhm9uMU4ryQvOjIdRw3RcensT/N8klglnQQd6QHbzGNJ8unQrlPcpWf93fF0O3vRZ
 wG9o8dlrIb3kNHPb9NlQupb7b2oXsvmbPbfbp3Igz3ML1KKsXHmnZ6Slua+YkvrEPvHL
 zs7GgcdxGpoILbjCNZRE8PDdZ6VCx9MYi7J/I7f84B+8OGQkEKTRgStv1O5C0YeExGGW
 N9XInmEsyf+NSUUb77rBKUdPHK37iEs2XxwbWVsA7QhiFRJrPwMrV5YCRONwjNq4alKL
 jM5hWk1u7S+XJUYyTSP2klTIDhUXPJfwN9Lz4RpS53mJ1M88ULq/CYeJqMsMs41m7m89
 f/Gw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Wzhm9uMU
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
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  6 ------
 2 files changed, 19 deletions(-)

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
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index bd17964090a..1f97f3cd7b0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -198,14 +198,12 @@ struct mtk_function_desc {
  */
 struct mtk_io_type_desc {
 	const char *name;
-#if CONFIG_IS_ENABLED(PINCONF)
 	/* Specific pinconfig operations */
 	int (*bias_set)(struct udevice *dev, u32 pin, bool disable,
 			bool pullup, u32 val);
 	int (*drive_set)(struct udevice *dev, u32 pin, u32 arg);
 	int (*input_enable)(struct udevice *dev, u32 pin, u32 arg);
 	int (*get_pinconf)(struct udevice *dev, u32 pin, char *buf, size_t size);
-#endif
 };
 
 /* struct mtk_pin_soc - the structure that holds SoC-specific data */
@@ -247,8 +245,6 @@ int mtk_pinctrl_common_bind(struct udevice *dev);
 int mtk_pinctrl_common_probe(struct udevice *dev,
 			     const struct mtk_pinctrl_soc *soc);
 
-#if CONFIG_IS_ENABLED(PINCONF)
-
 int mtk_pinconf_bias_set_pu_pd(struct udevice *dev, u32 pin, bool disable,
 			       bool pullup, u32 val);
 int mtk_pinconf_bias_set_pullen_pullsel(struct udevice *dev, u32 pin,
@@ -268,6 +264,4 @@ int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size);
 int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size);
 int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size);
 
-#endif
-
 #endif /* __PINCTRL_MEDIATEK_H__ */

-- 
2.43.0

