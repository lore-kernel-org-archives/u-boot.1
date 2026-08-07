Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAB1C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D4AF8130E;
	Fri,  7 Aug 2026 19:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DRw_WoKYc2w3; Fri,  7 Aug 2026 19:17:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA06F812E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786130235;
	bh=yNehjvMYDGG59+BLSeg3Z615PPz4mo0zh9pn02s05a0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2kchi39HFOZWGN+DyXsUC05uzbkotUZ0sQwzbTCdBlD3zjNKwo/50RD+naG3Oqag
	 EdZr/q04t/6EXKmNln3iwX6rQLGvAKTncQlc/PbVZdr/2T6qiHz7Lnw5Niv1Y58LTN
	 9sFHezKbZjo1c3JFPpHdZX2TShR6qvVvbzz/xAA1DxcnnvbUtl+kXrUjwDXrIjrNE3
	 x2ii4f0oEV7UnX4fvwJCamR4435R9ShuYqS721ZldpG1H7ml3O9mGIGwKQgg3erO9S
	 US398eTf2CJRmFsYU4e4gMY7svOtO6245vA2dwLZ6A6uxaoCg+Kmab3muBIkeskJXw
	 FjBrTK9IlI3PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA06F812E4;
	Fri,  7 Aug 2026 19:17:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CB072F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12207812E1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMHm2AEEwIoj for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:17:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E66A812D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E66A812D8
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E66A812D8
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so2225747a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786130230; x=1786735030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yNehjvMYDGG59+BLSeg3Z615PPz4mo0zh9pn02s05a0=;
 b=g0LPbLqaShKf5Z+kBV20KtDsyyV9HgXHm3mANmqaixBEuxsQvW6jE1Bdc0IWWehtBN
 jKKv5ke1o75P4VEAktsQXeu77sP6Icz4iXDW1yzOBH/9WfySyGyzqi6GSPm/bV0FR4Ae
 SOl60JlvGvtyyVj8PYM4f6Srlw0Te8ZhM3a7f305J1nFFnxucuwXJq+qPQ12IdZt1N7I
 chLclA5EbQ/rADv77dO5lfYV9aBbu7ObeENdS6DiUAbcBQUxLv2NEGmIJ7ruZbA571wr
 sSj0Avn6tpy6ifgqiqG0saseUrcpJZajfmYaxnUA6VL4S6ciKe9H114NvfWwPWfCwWf4
 cLSg==
X-Gm-Message-State: AOJu0YxGGd1okDxfhu2G3STiTiPZVXVxHg6CnT4x2jcwrcL3ftnSNqx5
 qFlhWwA9yw4iXLlcgH/eF7S0xOM0F6SWlIoy8D9bTsYCsnkeSrLmSg6PjJAtoMGkGJg=
X-Gm-Gg: AR+sD12tEJetL//rlHpS52AS5MTT5x7WJzDn4r5pHcPB4lf3j30FT/6T7+EzgX/r4NZ
 HNCNFSTsI92UQxRvcgMPUOBSHSo906olD+PTXgq580YbrZjf3kpA0CY/JXHXEG2ICiVA/j70pD5
 4zvtO6z6RmDZCL/TMS9b7sulXVKcemeetiti6dRrSpvbS9u/WT0FCDm8WZRWWbeVrxh+sgW8S6m
 cpMMbYWxZvSRXQVBYGowdsZdV4eWwrEzJVX1hVMVW+FqPpVv2GNGr2Tc1RL1kVZ2kP5G6wd1+qn
 TS5ukGszXvcsPxnxn6ODxTeklJfEhvogaCU2FUxZ+qwtAGJT5U8WxZn1M3B2cJOpV0mJ+zesXZf
 bmSE8Cl8NKdoXfZbed+WGwgD2H7s8eXR0ldLF76LYG2SVNrxCrMqKbUeIPaDrrxQP0peSfk48K0
 RWb706vOxmLClrlVGNcgPhCjuDJcSNE6DMiEqndk6LEzTE7EOEQubFzTD9omeXOjvm
X-Received: by 2002:a05:6830:3889:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-7f1e5e1e5c9mr15992455a34.11.1786130230309; 
 Fri, 07 Aug 2026 12:17:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5acbcbsm1875251a34.11.2026.08.07.12.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:17:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 14:16:31 -0500
Subject: [PATCH v2 3/4] pinctrl: mediatek: simplify Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pinctrl-kconfig-cleanup-v2-3-509a8f833181@baylibre.com>
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
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4509; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7KvVcPRPE+7BIXGayHOa5VmYzND/kMkf4iwtyrzbhPc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdi8jLGwQTi9PgulYiYXCj971tN+Xh0WOHnMv2
 uX9VdwH6zeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYvIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJgAH/Rrby6X2ZIeiEImXn8Euma/BFICWt+Ty8b+twrC
 0w6N/PtSJEiguqQp/A9ZsYOqaUuRMlRzTokSijClJEYbERaNoqDJAB1c3u3OYpj1IXLR7T1UYQD
 nLEz0kpqkMjM6F+8oRnbk7nBaaiyiPhKwjLjz3bEcs9ulmXDLoHCv8QaGjtvOm0aSDrvx9kfDv6
 quCf7JK0q73MdKR4bSU/RVBV4rZ3QQeudFEwZq+oStiSTRTCl1/TT9xT0Rm9dXXwOEQ9U7ELZB3
 UhVDevV3s9Bim/ZaTmKrGuV9rMAoySKhtb9ySxiKRYMXkexr7OAd7fOBXCOrGyiBFcis5hpAV0Y
 ziXg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786130230; x=1786735030;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNehjvMYDGG59+BLSeg3Z615PPz4mo0zh9pn02s05a0=;
 b=Z7TnRCNsL2QDMMLQpu7aac9BkBgl65ZELyv1A6Sn68wYpQijSc1KCFsIT157dwhArL
 oAIJ8hco0UE3FaNGIuJPIumB8V13Dnmm3RWL7F0+5VUdWCX+Y+UlxBbIM6hsfmij/I7P
 +3g/eU/HO3zq9VKvqOOwMJUpJkVAMhmhqbQQpVnw7O8K8J1MncG1hHH6i0PaAkcldAwL
 i/0HxXMlIlQGXsfJvl5DA9ZAn4X5rAaXaBl//uPVsfd3FVNjZBTS3ywuiPOCyPoKu0dR
 ZRzxFPeUsaKCUUkixL7uzQ/3Okw1v6FUz4dJejtMyN8UiwQj+yuZf8XYMS6Moh9vnxfa
 PpBA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z7TnRCNs
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

Change the MediaTek pinctrl Kconfig to just have a single option for
all targets. This will simplify adding new targets and SPL support in
the future.

There is only one MediaTek target that does not have a pinctrl driver.
All other targets enable it by default so the configs don't have to
explicitly set it in addition to just enabling PINCTRL.

In the Makefile, we can use the target config symbol to automatically
select the correct driver. And the config selector on the common file
was redundant since we already have the same in the parent Makefile,
so it is dropped. Targets are also sorted while we are touching this.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Closes: https://lore.kernel.org/u-boot/fba47ca8-7cf7-446a-9242-54c50087cf3c@cherry.de/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig  | 61 +++------------------------------------
 drivers/pinctrl/mediatek/Makefile | 30 +++++++++----------
 2 files changed, 19 insertions(+), 72 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 42c7c8b8c80..46e35cbfe6c 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,66 +1,13 @@
 if ARCH_MEDIATEK
 
 config PINCTRL_MTK
+	bool "MediaTek pinctrl driver"
 	depends on PINCTRL_GENERIC
+	default y if !TARGET_MT8183
 	select PINCONF
 	select REGMAP
 	select SYSCON
-	bool
-
-config PINCTRL_MT7622
-	bool "MT7622 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7623
-	bool "MT7623 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7629
-	bool "MT7629 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7981
-	bool "MT7981 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7986
-	bool "MT7986 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7987
-	bool "MT7987 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7988
-	bool "MT7988 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8188
-	bool "MT8188 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8195
-	bool "MT8195 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8189
-	bool "MT8189 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8365
-	bool "MT8365 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8512
-	bool "MT8512 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8516
-	bool "MT8516 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8518
-	bool "MT8518 SoC pinctrl driver"
-	select PINCTRL_MTK
+	help
+	  Enable MediaTek pinctrl support.
 
 endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index f90c74314f4..f367db5c575 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
 # Core
-obj-$(CONFIG_PINCTRL_MTK) += pinctrl-mtk-common.o
+obj-y += pinctrl-mtk-common.o
 
 # SoC Drivers
-obj-$(CONFIG_PINCTRL_MT7622) += pinctrl-mt7622.o
-obj-$(CONFIG_PINCTRL_MT7623) += pinctrl-mt7623.o
-obj-$(CONFIG_PINCTRL_MT7629) += pinctrl-mt7629.o
-obj-$(CONFIG_PINCTRL_MT7981) += pinctrl-mt7981.o
-obj-$(CONFIG_PINCTRL_MT7986) += pinctrl-mt7986.o
-obj-$(CONFIG_PINCTRL_MT7987) += pinctrl-mt7987.o
-obj-$(CONFIG_PINCTRL_MT7988) += pinctrl-mt7988.o
-obj-$(CONFIG_PINCTRL_MT8188) += pinctrl-mt8188.o
-obj-$(CONFIG_PINCTRL_MT8195) += pinctrl-mt8195.o
-obj-$(CONFIG_PINCTRL_MT8189) += pinctrl-mt8189.o
-obj-$(CONFIG_PINCTRL_MT8365) += pinctrl-mt8365.o
-obj-$(CONFIG_PINCTRL_MT8512) += pinctrl-mt8512.o
-obj-$(CONFIG_PINCTRL_MT8516) += pinctrl-mt8516.o
-obj-$(CONFIG_PINCTRL_MT8518) += pinctrl-mt8518.o
+obj-$(CONFIG_TARGET_MT7622) += pinctrl-mt7622.o
+obj-$(CONFIG_TARGET_MT7623) += pinctrl-mt7623.o
+obj-$(CONFIG_TARGET_MT7629) += pinctrl-mt7629.o
+obj-$(CONFIG_TARGET_MT7981) += pinctrl-mt7981.o
+obj-$(CONFIG_TARGET_MT7986) += pinctrl-mt7986.o
+obj-$(CONFIG_TARGET_MT7987) += pinctrl-mt7987.o
+obj-$(CONFIG_TARGET_MT7988) += pinctrl-mt7988.o
+obj-$(CONFIG_TARGET_MT8188) += pinctrl-mt8188.o
+obj-$(CONFIG_TARGET_MT8189) += pinctrl-mt8189.o
+obj-$(CONFIG_TARGET_MT8195) += pinctrl-mt8195.o
+obj-$(CONFIG_TARGET_MT8365) += pinctrl-mt8365.o
+obj-$(CONFIG_TARGET_MT8512) += pinctrl-mt8512.o
+obj-$(CONFIG_TARGET_MT8516) += pinctrl-mt8516.o
+obj-$(CONFIG_TARGET_MT8518) += pinctrl-mt8518.o

-- 
2.43.0

