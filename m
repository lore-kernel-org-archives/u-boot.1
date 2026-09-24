Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF3BC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87CD881E09;
	Thu, 24 Sep 2026 16:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DSQP8fDm2_T0; Thu, 24 Sep 2026 16:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4FF4C81E19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266387;
	b=fZ5P1t5U2ZEPfdi/qsQsjehss8vWrHuR30h2M2x9ktpkO0TLAMFtRYK+xt0XKDMk6PDU
	 yzZUGIWMgdYL9FhoPJkLsAN+vsaLFCVENby+wVioL1iGZthSJC0O6RDtopS5fausRc4xx
	 CKdTg9jWc3mBCvmqWVyNWXezpI74UMTU7xXUHj5VqK1E2tKF5RbgcVb5hmtKkiikbJr4z
	 MOyRiqjDiJN9TPMEse8hhXvFzXxxOJTDbngp3RqdZd9ImWnN7CXU3InAK37dsvzht6lfX
	 uAtEC6iTgV7DLeZ/U2OtPcowvcq9jr/6A4LHxfvUHAadmrFLoMp0r+YRiQaSrBl7b3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XTN2iKHWWiPT27uKOQt3QRk3xnPi4joypH7po99VN4E=;
	b=kEZ+J9hS8/XpPKuVtkyCUymSN5JClK+JKEDfIGDLH18JLltm8UKUgAzNk8dd92S55ubc
	 bUfr4oXrKf058TsYhYtBhdensfTB+ajRN3nt1wj1aIbHwyl8Et5tFAMM6HYuFGfoj+w6s
	 h6yuEOIvf7cAlGDxcEGEVefQ4EHXXDJQf4eETYeDbmCyX7aPceaj9ooZw6dY0HmaMOuuZ
	 f27CJClvycNu22rFKhudwNQ63YJx8t68WmAu9BHK/Siq7g69+F99Cm4oJZ3bSdMelsaTr
	 5BYNogd5PQ6Yyj6XLRKmp25ZuJ+q2cDgmlZeTOLqkmeFSh+rIm64eIjITKgZCcPKFSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266387;
	bh=XTN2iKHWWiPT27uKOQt3QRk3xnPi4joypH7po99VN4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G8xNwQyw39XQTX6z/NWq8AGXtZSDVwh1dBc9+fxol0kASooU6QEs7NsckhKKL+mzm
	 K6P9X3SC8qCsLlcKCd8EHM7VKKFpJPLibWIlDTv7jZ7wjOqw14nYwgWKiwysYcMO1b
	 MUJRWYQtons5KGgzwaMlyWjDEYIHMAmXQCnorap4lS2o4SqB07ACz+rmJtmOHT2LYD
	 E7hyrcriap2pdqc3ydPxk+YiZqEoHwstB+TkGQaxwjsq5yJ2EZW4/IkqSFJw4hgX6/
	 iBsO3BHggTuh3mtzPmczIZLzLhjWsPoNHd902OPRmSZ0ZRqe/uuhENFa9QuAadvC+b
	 WMDZXyxGhnVHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FF4C81E19;
	Thu, 24 Sep 2026 16:13:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43FA513B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35AC66077A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kltFRnNIZMIB for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B0D426062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266380;
 b=kZnnyIOyHzj+3/ZK2820+f3uA6zjwpFwGpOLFb1ao563SPO4k/yCFXo33/5WOvjrt3R0
 HerejwwjGJCD/L9eKXE33ADXh2U5gOOeLLpGTgUdSgnATu6LAc8d/Oy0yanv9J0zt8jwz
 Hwj4ZBJph5G9SORG/N0DDFCZRR7u1ENNoN9eOZB83f4Wj6zydNqM+//P36U0MTPBAls2d
 wCoMXJSWoSPbfh2dYD0d7gOgN40mDbUq9SFYdOzagdjBk8TKsH4N05g9KDAG8V3Xxmi3o
 vVAcaERbEUP+IkXjIbYzSHaN4sj5O/KaueekZSjZOysL9HhB6v0yQEMMna6dhjGmiuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266380;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=XTN2iKHWWiPT27uKOQt3QRk3xnPi4joypH7po99VN4E=;
 b=LNvBH8a8fSsBidsnQX3qHCEvS2dWyAKUTtMGinDdHzle0ugeWbXxX7eTxm1dAYZKIyF5
 fj6eHuwxG7EF1kPu3vdkOUSdMDd6UUr1hFp5nEJC4voYWh3THB41pF79Z1pW9pWtkR7Ek
 VdLNw+9mLvLxif3yO+3VY9VXZ1HzDiB8O4/IZ9rG7CxGy9xQWKV1eriUHxN3JzMkj0nLp
 sn9BnpVW6+2WLWl4s4BklxIVWucSyhBukmYPDPaSCIENPGW+rix9EfQq0rOzwxizW9rnp
 i7wDsn7jrA/lk0XujXZCacLQle7MPw4p4VB6pXJ9DavV+PoP5YFHKuj7fy/M88WzklQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=KlqwjLKQ; 
 arc=none smtp.remote-ip=148.251.105.195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.251.105.195;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=KlqwjLKQ
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0D426062C
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265772;
 bh=Hwlc3vv+S3Sb6PS3UZj9s4qv5MY/8zuk09f9lLef/BA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KlqwjLKQb/U5qxUl/l9kX4R35xv7li1AhoWQgdyyjDtnZzUTK1TGf2yLpD18oOPhR
 M+I2QqbfqZzy0UoB5E272gQdnly4Fd5Agn71CkskjVlsWkSd1x8lmp8EJ+L880yTho
 otHc4ao1YsrQgV2BinMfwjmvzZTgJz7HS030EaEoKQdJ9saLzUJzrj8+VAC/gg6rK2
 UHwlKEDOr7Hcl8npp587a4Jx9tI1mbtdAjkZKuDqmIF9cCUjWebqiOzbjVhHqxbtBY
 7UWxCZR59HJrgIaXptnIJhP1tsCZN0p3QEld/BMQPOSSwxYzXUGqkAEjDqzHIElbIw
 S0+gn2aMwIOjQ==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 48D9D17E03B6;
 Thu, 24 Sep 2026 18:02:51 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 24 Sep 2026 18:02:49 +0200
Subject: [PATCH 1/3] drivers: spmi: add new driver for MediaTek's SPMI PMIF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mt8196-spmi-v1-1-dd2263403691@collabora.com>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
In-Reply-To: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Guodong Xu <guodong@riscstar.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13481;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=Hwlc3vv+S3Sb6PS3UZj9s4qv5MY/8zuk09f9lLef/BA=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUmpebxvr3138h89BQrzAj9+7RRXdI2KqfJFv
 ZWRu5CGj5WJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJqQAKCRDT67WWa7mR
 lsuUD/9y+FGD2tpan7MdMpMp9qeK1C+QnfmER0tHRpp3kUiSGpahKv3UhgflU9gII4wQo+u9kyw
 5uaCtxPQisfSa005gRr+TQCcAoWaJ7hknUb7OX/c0KLtWOP+Uxlm2KDaart+AM8SnSQzYjCtba/
 2/gZFo/fxjZ9qC4Nxa0hAzFh7ohRomYzmC4xDABFDpgY+AIEMAxx3LKcubbSOshOHCvpPKkuuf3
 Sbwiox63oRhwKr7ioY56HoSgGRqH63JkE/Z3kGS0KnTv/2W30Tm6spcIaQ01SqlbvzZ/zW3x46N
 LMs1/IYu4r+iy9gaS1qw7HwZ4huWLTuJAEuSMgHjFopFkSB6ZOynwc6+ejLQunN0sV1elnGWATP
 unx/dLpEE1PCuIWf1KJhIfawxWonqoIPcHbdzLp67vvWlDhZee5xh+KemcNAUnZpK+NiKms3Z0b
 FTjtPijBSuC6OUg+JLFKb34X2M0uxAWEjg+NhD63L9FuOzTbTRwc0AKtIUCSAaQhmVMf0xk42MT
 yO8NQ1OdYTDcByUQg4LIe+7h2J/KnjYSaeyWbh6Xo8xKtEEGkhoCZmmu0OUTrWXAnnESQK3JKCI
 SHY7HRucwLe6XO7KnZQUaZZauvdaceWP1TC8kE/4tjXrrZHTupWZB10/YY79ORPHyCsC2y0oWhh
 wYwbKPkaNdm/s1A==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

This driver (ported from the Linux kernel) implements 1-byte wide read
and write operations for the SPMI-PMIF bus found on MediaTek SoCs. It
currently supports MT8195 and MT8196.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 drivers/spmi/Kconfig         |   7 +
 drivers/spmi/Makefile        |   1 +
 drivers/spmi/spmi-mtk-pmif.c | 462 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+)

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index f8972371150..cab82e83c24 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -27,6 +27,13 @@ config SPL_SPMI_MSM
 	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs
 	  in SPL.
 
+config SPMI_MTK_PMIF
+	bool "Support MediaTek SPMI-PMIF bus"
+	depends on SPMI
+	help
+	  Support SPMI bus implementation found on MediaTek SoCs. This
+	  driver currently support the MT8195 and MT8196 SoCs.
+
 config SPMI_SANDBOX
 	bool "Support for Sandbox SPMI bus"
 	depends on SPMI
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 8cb93c820e0..016a8e6b734 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
 obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
+obj-$(CONFIG_SPMI_MTK_PMIF) += spmi-mtk-pmif.o
 obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o
diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
new file mode 100644
index 00000000000..0bc8309b447
--- /dev/null
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2025-2026 Collabora Ltd
+ * Authors: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *          Arnaud Ferraris <arnaud.ferraris@collabora.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <malloc.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/time.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/devres.h>
+#include <inttypes.h>
+#include <spmi/spmi.h>
+
+#define SWINF_IDLE	0x00
+#define SWINF_WFVLDCLR	0x06
+
+#define GET_SWINF(x)	(((x) >> 1) & 0x7)
+
+#define PMIF_CMD_REG_0		0
+#define PMIF_CMD_REG		1
+#define PMIF_CMD_EXT_REG	2
+#define PMIF_CMD_EXT_REG_LONG	3
+
+#define PMIF_DELAY_US   2
+#define PMIF_TIMEOUT_US (10 * 1000)
+
+#define PMIF_CHAN_OFFSET 0x5
+
+#define PMIF_MAX_BUSES	2
+#define PMIF_MAX_CLKS	3
+
+#define SPMI_OP_ST_BUSY 1
+
+struct ch_reg {
+	u32 ch_sta;
+	u32 wdata;
+	u32 rdata;
+	u32 ch_send;
+	u32 ch_rdy;
+};
+
+struct pmif_data {
+	const u32	*regs;
+	const u32	*spmimst_regs;
+	u32	soc_chan;
+	u8	spmi_ver;
+	u32	num_spmi_buses;
+};
+
+struct pmif_bus {
+	void __iomem	*base;
+	void __iomem	*spmimst_base;
+	struct pmif *arb;
+	struct clk_bulk clks;
+};
+
+struct pmif {
+	struct pmif_bus bus[PMIF_MAX_BUSES];
+	struct ch_reg	chan;
+	const struct pmif_data *data;
+};
+
+enum pmif_regs {
+	PMIF_INIT_DONE,
+	PMIF_INF_EN,
+	PMIF_ARB_EN,
+	PMIF_CMDISSUE_EN,
+	PMIF_TIMER_CTRL,
+	PMIF_SPI_MODE_CTRL,
+	PMIF_IRQ_EVENT_EN_0,
+	PMIF_IRQ_FLAG_0,
+	PMIF_IRQ_CLR_0,
+	PMIF_IRQ_EVENT_EN_1,
+	PMIF_IRQ_FLAG_1,
+	PMIF_IRQ_CLR_1,
+	PMIF_IRQ_EVENT_EN_2,
+	PMIF_IRQ_FLAG_2,
+	PMIF_IRQ_CLR_2,
+	PMIF_IRQ_EVENT_EN_3,
+	PMIF_IRQ_FLAG_3,
+	PMIF_IRQ_CLR_3,
+	PMIF_IRQ_EVENT_EN_4,
+	PMIF_IRQ_FLAG_4,
+	PMIF_IRQ_CLR_4,
+	PMIF_WDT_EVENT_EN_0,
+	PMIF_WDT_FLAG_0,
+	PMIF_WDT_EVENT_EN_1,
+	PMIF_WDT_FLAG_1,
+	PMIF_SWINF_0_STA,
+	PMIF_SWINF_0_WDATA_31_0,
+	PMIF_SWINF_0_RDATA_31_0,
+	PMIF_SWINF_0_ACC,
+	PMIF_SWINF_0_VLD_CLR,
+	PMIF_SWINF_1_STA,
+	PMIF_SWINF_1_WDATA_31_0,
+	PMIF_SWINF_1_RDATA_31_0,
+	PMIF_SWINF_1_ACC,
+	PMIF_SWINF_1_VLD_CLR,
+	PMIF_SWINF_2_STA,
+	PMIF_SWINF_2_WDATA_31_0,
+	PMIF_SWINF_2_RDATA_31_0,
+	PMIF_SWINF_2_ACC,
+	PMIF_SWINF_2_VLD_CLR,
+	PMIF_SWINF_3_STA,
+	PMIF_SWINF_3_WDATA_31_0,
+	PMIF_SWINF_3_RDATA_31_0,
+	PMIF_SWINF_3_ACC,
+	PMIF_SWINF_3_VLD_CLR,
+};
+
+static const u32 mt8195_regs[] = {
+	[PMIF_INIT_DONE] = 0x0000,
+	[PMIF_INF_EN] = 0x0024,
+	[PMIF_ARB_EN] = 0x0150,
+	[PMIF_CMDISSUE_EN] = 0x03B8,
+	[PMIF_TIMER_CTRL] = 0x03E4,
+	[PMIF_SPI_MODE_CTRL] = 0x0408,
+	[PMIF_IRQ_EVENT_EN_0] = 0x0420,
+	[PMIF_IRQ_FLAG_0] = 0x0428,
+	[PMIF_IRQ_CLR_0] = 0x042C,
+	[PMIF_IRQ_EVENT_EN_1] = 0x0430,
+	[PMIF_IRQ_FLAG_1] = 0x0438,
+	[PMIF_IRQ_CLR_1] = 0x043C,
+	[PMIF_IRQ_EVENT_EN_2] = 0x0440,
+	[PMIF_IRQ_FLAG_2] = 0x0448,
+	[PMIF_IRQ_CLR_2] = 0x044C,
+	[PMIF_IRQ_EVENT_EN_3] = 0x0450,
+	[PMIF_IRQ_FLAG_3] = 0x0458,
+	[PMIF_IRQ_CLR_3] = 0x045C,
+	[PMIF_IRQ_EVENT_EN_4] = 0x0460,
+	[PMIF_IRQ_FLAG_4] = 0x0468,
+	[PMIF_IRQ_CLR_4] = 0x046C,
+	[PMIF_WDT_EVENT_EN_0] = 0x0474,
+	[PMIF_WDT_FLAG_0] = 0x0478,
+	[PMIF_WDT_EVENT_EN_1] = 0x047C,
+	[PMIF_WDT_FLAG_1] = 0x0480,
+	[PMIF_SWINF_0_ACC] = 0x0800,
+	[PMIF_SWINF_0_WDATA_31_0] = 0x0804,
+	[PMIF_SWINF_0_RDATA_31_0] = 0x0814,
+	[PMIF_SWINF_0_VLD_CLR] = 0x0824,
+	[PMIF_SWINF_0_STA] = 0x0828,
+	[PMIF_SWINF_1_ACC] = 0x0840,
+	[PMIF_SWINF_1_WDATA_31_0] = 0x0844,
+	[PMIF_SWINF_1_RDATA_31_0] = 0x0854,
+	[PMIF_SWINF_1_VLD_CLR] = 0x0864,
+	[PMIF_SWINF_1_STA] = 0x0868,
+	[PMIF_SWINF_2_ACC] = 0x0880,
+	[PMIF_SWINF_2_WDATA_31_0] = 0x0884,
+	[PMIF_SWINF_2_RDATA_31_0] = 0x0894,
+	[PMIF_SWINF_2_VLD_CLR] = 0x08A4,
+	[PMIF_SWINF_2_STA] = 0x08A8,
+	[PMIF_SWINF_3_ACC] = 0x08C0,
+	[PMIF_SWINF_3_WDATA_31_0] = 0x08C4,
+	[PMIF_SWINF_3_RDATA_31_0] = 0x08D4,
+	[PMIF_SWINF_3_VLD_CLR] = 0x08E4,
+	[PMIF_SWINF_3_STA] = 0x08E8,
+};
+
+enum spmi_regs {
+	SPMI_OP_ST_CTRL,
+	SPMI_GRP_ID_EN,
+	SPMI_OP_ST_STA,
+	SPMI_MST_SAMPL,
+	SPMI_MST_REQ_EN,
+	SPMI_REC_CTRL,
+	SPMI_REC0,
+	SPMI_REC1,
+	SPMI_REC2,
+	SPMI_REC3,
+	SPMI_REC4,
+	SPMI_MST_DBG,
+
+	/* MT8195 spmi regs */
+	SPMI_MST_RCS_CTRL,
+	SPMI_SLV_3_0_EINT,
+	SPMI_SLV_7_4_EINT,
+	SPMI_SLV_B_8_EINT,
+	SPMI_SLV_F_C_EINT,
+	SPMI_REC_CMD_DEC,
+	SPMI_DEC_DBG,
+};
+
+static const u32 mt8195_spmi_regs[] = {
+	[SPMI_OP_ST_CTRL] = 0x0000,
+	[SPMI_GRP_ID_EN] = 0x0004,
+	[SPMI_OP_ST_STA] = 0x0008,
+	[SPMI_MST_SAMPL] = 0x000C,
+	[SPMI_MST_REQ_EN] = 0x0010,
+	[SPMI_MST_RCS_CTRL] = 0x0014,
+	[SPMI_SLV_3_0_EINT] = 0x0020,
+	[SPMI_SLV_7_4_EINT] = 0x0024,
+	[SPMI_SLV_B_8_EINT] = 0x0028,
+	[SPMI_SLV_F_C_EINT] = 0x002C,
+	[SPMI_REC_CTRL] = 0x0040,
+	[SPMI_REC0] = 0x0044,
+	[SPMI_REC1] = 0x0048,
+	[SPMI_REC2] = 0x004C,
+	[SPMI_REC3] = 0x0050,
+	[SPMI_REC4] = 0x0054,
+	[SPMI_REC_CMD_DEC] = 0x005C,
+	[SPMI_DEC_DBG] = 0x00F8,
+	[SPMI_MST_DBG] = 0x00FC,
+};
+
+static u32 pmif_readl(struct pmif *arb, struct pmif_bus *pbus, enum pmif_regs reg)
+{
+	return readl(pbus->base + arb->data->regs[reg]);
+}
+
+static void pmif_writel(struct pmif *arb, struct pmif_bus *pbus,
+			u32 val, enum pmif_regs reg)
+{
+	writel(val, pbus->base + arb->data->regs[reg]);
+}
+
+static bool pmif_is_fsm_vldclr(struct pmif *arb, struct pmif_bus *pbus)
+{
+	u32 reg_rdata;
+
+	reg_rdata = pmif_readl(arb, pbus, arb->chan.ch_sta);
+
+	return GET_SWINF(reg_rdata) == SWINF_WFVLDCLR;
+}
+
+static int pmif_spmi_read(struct udevice *dev, int sid, int pid, int reg)
+{
+	struct pmif_bus *pbus = dev_get_priv(dev);
+	struct pmif *arb = pbus->arb;
+	struct ch_reg *inf_reg;
+	int ret, data;
+	u32 cmd;
+
+	/* Check for argument validation. */
+	if (sid & ~0xf) {
+		dev_err(dev, "exceed the max slv id\n");
+		return -EINVAL;
+	}
+
+	/* Wait for Software Interface FSM state to be IDLE. */
+	inf_reg = &arb->chan;
+	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
+				       data, GET_SWINF(data) == SWINF_IDLE,
+				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		/* set channel ready if the data has transferred */
+		if (pmif_is_fsm_vldclr(arb, pbus))
+			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+		dev_err(dev, "failed to wait for SWINF_IDLE\n");
+		return ret;
+	}
+
+	/* Send the command. */
+	cmd = (PMIF_CMD_EXT_REG_LONG << 30) | (sid << 24) | reg;
+	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
+
+	/*
+	 * Wait for Software Interface FSM state to be WFVLDCLR,
+	 * read the data and clear the valid flag.
+	 */
+	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
+				       data, GET_SWINF(data) == SWINF_WFVLDCLR,
+				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dev, "failed to wait for SWINF_WFVLDCLR\n");
+		return ret;
+	}
+
+	data = (int)pmif_readl(arb, pbus, inf_reg->rdata);
+	pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+
+	return data;
+}
+
+static int pmif_spmi_write(struct udevice *dev, int sid, int pid, int reg, u8 val)
+{
+	struct pmif_bus *pbus = dev_get_priv(dev);
+	struct pmif *arb = pbus->arb;
+	struct ch_reg *inf_reg;
+	int ret;
+	u32 data, cmd;
+
+	/* Check for argument validation. */
+	if (unlikely(sid & ~0xf)) {
+		dev_err(dev, "exceed the max slv id\n");
+		return -EINVAL;
+	}
+
+	/* Wait for Software Interface FSM state to be IDLE. */
+	inf_reg = &arb->chan;
+	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
+				       data, GET_SWINF(data) == SWINF_IDLE,
+				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		/* set channel ready if the data has transferred */
+		if (pmif_is_fsm_vldclr(arb, pbus))
+			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+		dev_err(dev, "failed to wait for SWINF_IDLE\n");
+		return ret;
+	}
+
+	pmif_writel(arb, pbus, (u32)val, inf_reg->wdata);
+
+	/* Send the command. */
+	cmd = (PMIF_CMD_EXT_REG_LONG << 30) | BIT(29) | (sid << 24) | reg;
+	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
+
+	return 0;
+}
+
+static const struct pmif_data mt8195_pmif_arb = {
+	.regs = mt8195_regs,
+	.spmimst_regs = mt8195_spmi_regs,
+	.soc_chan = 2,
+};
+
+static const struct pmif_data mt8196_pmif_arb = {
+	.regs = mt8195_regs,
+	.spmimst_regs = mt8195_spmi_regs,
+	.soc_chan = 2,
+	.spmi_ver = 2,
+	.num_spmi_buses = 2,
+};
+
+static int mtk_spmi_probe(struct udevice *dev)
+{
+	struct pmif_bus *pbus = dev_get_priv(dev);
+	int ret;
+
+	if (!pbus) {
+		dev_info(dev, "Not probing a non-bus spmi device\n");
+		return 0;
+	}
+
+	pbus->base = devfdt_remap_addr_name(dev, "pmif");
+	if (IS_ERR(pbus->base))
+		return PTR_ERR(pbus->base);
+
+	pbus->spmimst_base = devfdt_remap_addr_name(dev, "spmimst");
+	if (IS_ERR(pbus->spmimst_base))
+		return PTR_ERR(pbus->spmimst_base);
+
+	ret = clk_get_bulk(dev, &pbus->clks);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&pbus->clks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id mtk_spmi_match_table[] = {
+	{
+		.compatible = "mediatek,mt8195-spmi",
+		.data = (unsigned long)&mt8195_pmif_arb,
+	}, {
+		.compatible = "mediatek,mt8196-spmi",
+		.data = (unsigned long)&mt8196_pmif_arb,
+	}, {
+		/* sentinel */
+	},
+};
+
+static int mtk_spmi_bind(struct udevice *dev)
+{
+	struct pmif_data *drv_data = (struct pmif_data *)dev_get_driver_data(dev);
+	ofnode child, node = dev_ofnode(dev);
+	int ret = 0;
+
+	if (!drv_data) {
+		dev_err(dev, "Cannot get drv_data\n");
+		return -EINVAL;
+	}
+
+	if (ofnode_name_eq(node, "spmi")) {
+		struct pmif_bus *bus = devm_kzalloc(dev, sizeof(struct pmif_bus), GFP_KERNEL);
+
+		if (!bus)
+			return -ENOMEM;
+		bus->arb = dev_get_plat(dev->parent);
+		dev_set_priv(dev, bus);
+	} else {
+		struct pmif *arb;
+		u32 chan_offset;
+
+		arb = devm_kzalloc(dev, sizeof(struct pmif), GFP_KERNEL);
+		if (!arb)
+			return -ENOMEM;
+		dev_set_plat(dev, arb);
+
+		arb->data = drv_data;
+		chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
+		arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
+		arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
+		arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
+		arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
+		arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
+
+		if (arb->data->num_spmi_buses) {
+			ofnode_for_each_subnode(child, node) {
+				if (!ofnode_name_eq(child, "spmi"))
+					continue;
+
+				/* Bind the subnode to this driver */
+				ret = device_bind_with_driver_data(dev, dev->driver,
+								   ofnode_get_name(child),
+								   dev->driver_data,
+								   child,
+								   NULL);
+				if (ret == -ENODEV)
+					printf("Driver '%s' refuses to bind\n",
+					       dev->driver->name);
+
+				if (ret)
+					printf("Error binding driver '%s': %d\n",
+					       dev->driver->name, ret);
+			}
+		} else {
+			struct pmif_bus *bus = devm_kzalloc(dev,
+							    sizeof(struct pmif_bus),
+							    GFP_KERNEL);
+
+			if (!bus)
+				return -ENOMEM;
+			bus->arb = arb;
+			dev_set_priv(dev, bus);
+		}
+	}
+
+	return 0;
+}
+
+struct dm_spmi_ops mtk_spmi_ops = {
+	.read = pmif_spmi_read,
+	.write = pmif_spmi_write,
+};
+
+U_BOOT_DRIVER(mtk_spmi_driver) = {
+	.name = "spmi-mtk",
+	.id = UCLASS_SPMI,
+	.ops = &mtk_spmi_ops,
+	.bind = mtk_spmi_bind,
+	.probe = mtk_spmi_probe,
+	.of_match = mtk_spmi_match_table,
+};

-- 
2.53.0

