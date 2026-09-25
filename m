Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50303C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05F6281309;
	Fri, 25 Sep 2026 13:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nmhF2BbgvMvr; Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0707381304
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343638;
	b=oiXC+odwhQph/dJHwNv8HkdNOjdN+lVamwJkMGrhY74x7rTC6tTL1QpnWJyEaGsG9tr3
	 e0KqCV3qjSbvGdRNoSNbSYtlFje/zBpRtijBB0g/U7Jre3nwbvFF32/JN5L0Hh4vwqYjd
	 JCOfyQO5Qv1uGblI5Sdu0JhLCyUUO5zVDfywvqDXvS0s52rdveDUt22rWp0CmKweugVji
	 PPThacHLyILa42lxUW+qLOA6WNycvskshd1JDepxdoreC7edqGpZluY20l1Lmp8xqdT5t
	 5wFJGNvvtKGIRFYcvQNii96WxA3btGNZxddD1zk9og+NkSEfblArASQK0yMNS85aAnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343638;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nJs9Ct8nxE1YQkd8Eper9P6y71SgX1nDZNIB/G0w9FM=;
	b=ohxkDsX2cnJR36lDURseINmgyHC6LzB5R5fr+iNIydWj0YZXxf3LmdV73yFIL0Zg1LLu
	 Ws5+imzVpKRROAznTAbgEZVJ/q+QafxrNMbjAaIR2AuVGLS2L0zTGbqrPWGFHYSPywkhS
	 tFKz7IzOI+Ydi9LMq5sRj51WXROCZHNHvvJEXvMvtQ95jrmGG8KVU0U8s8soIbuN8J3L1
	 1ZJZZUWi/Sua6gQ79NeugEbx9/gNbgFXsuCDNnZfpk697Y8Gm9vyGa3/HJDmp/RBIu75+
	 wVP8gV/CpQK8DuDksF1c2LSeNM2K7xHXAn/Lzrxp309FoX6WMtpe0Q2EIrFoNZJrRFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343638;
	bh=nJs9Ct8nxE1YQkd8Eper9P6y71SgX1nDZNIB/G0w9FM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ep6hrNdKBNZtrID1QkATJtZbgObotECJNXa+G+v+HFaxeIfDbfJQntMw7F0YJK6BG
	 scgAzQIFECAV5NgbkA16E1vwtbDt4YSB9DVnRChTh7HTVPgRknXONPnlfQgOOgEPqB
	 A1KJqHQwsbqneKexOW9Tnp2qp+204a4FqXvKr/3rKY8ejlPvhsKx3BaRAHSFVUf1Js
	 /TL6htuzg25cnfAm+9poNeOa9IrKuO/k85VZD3P4RvxJyilrDUpFSt3i5mMC9Q1ZB8
	 qxn4vtlcnqFFvFAHIwEDANeZ6FRZtGkXbYEIOi+wg9uO/NoIgh3eqzOiqUmulWJSm+
	 XRpuREVXexB7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0707381304;
	Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66EE8355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5823F40AC8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oK_M-VUJ_wXH for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1652A40A6B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343633;
 b=DeKSZ64GBe/g5izsZFvPO2RzcsfIPvLkPANebyxzQMmEwqX+ZiZtH2YgZ7FoEh9lQXR2
 Z3YaHtHpC3BAp0VlhfiT+W5E/R037SkLRBWym9daf6s8YF5nE5mV7gL/URXJ+ohfRZxkd
 IRh6Ngje58DvFU6iRvTLwAs5jZ+36ZWGLLf6orSYbnAbvlPzEwZ7Xvzk+kWKdY/dC53mz
 fqFKsSyeEJ5FqbvSwKxVBxNlYzB1z8p+iUJXyADDT6e6GmnI4qg0FEk1xajEIJhaUHojN
 mwXEfTveGy6OKXMvqJilYLvBg8Qt0QCU1O5SbQR3A+LIXck7bd+9IZrkzwitovDfR7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nJs9Ct8nxE1YQkd8Eper9P6y71SgX1nDZNIB/G0w9FM=;
 b=LQcJAM2NyoUU8Rp6gbm+pc6QTFjsnj+gxTEnbjJUtoG5k35xy0yn78gttYL6DCssWtG7
 xWsch82WuxxVbjsa1hZquhk/rtEKzs7wJzCpR6eZbeWWz+3ZsQHr9A87b+IIjGs61GWkl
 paBAHH2i7gKOnST2NcaoxON0tuBl56+LBYaU6sjqKW42RU4FRqDXw5Lo6GQH75wdafuBl
 x/b1vVqanZh0a9gbdwhIw30iT8ATJi3GvVf4ZaJ4J3EQzuzrzMGCIKySKO9v9pApzQmmX
 hvvRrtNC0+XyalRaAF/Y9H3oLR+phvoDM6HALSTGCgJITNqbsGDm9dVUi9XvUDlEPGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DMVG50de; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DMVG50de
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1652A40A6B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:32 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b2522so792529f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343630; x=1790948430;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nJs9Ct8nxE1YQkd8Eper9P6y71SgX1nDZNIB/G0w9FM=;
 b=DMVG50deRVdP0NBlWasWEsPQQ5MTEXaIqjAZ63rRlcujDy0e+j2znuIN4PtV9++s6N
 pubUdbVc1XlG0vj1P/WK6WI34wy/YU5nqkUHG0Az0uLekmq2KTuCA6SOu3gK+we7dIkW
 m90oKGwzPY5n4cxKcCUa3AwpxJhQvs6FwVFOb4UY02/4eOMbhBlWqWWVB2mgks1WrMse
 MG3C+O1FMwOeiYS1enirJx5SehG4a2qeUiMOxtU3EWDOd8ggy2tE9g/HCWlPtbSyLRDj
 3WVmYyjuu98L1qgK4hpQr9byhgNWEucyOnMujZEBBCcvcTEX4tcM5FnVxEdi0tAAeEAu
 2tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343630; x=1790948430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nJs9Ct8nxE1YQkd8Eper9P6y71SgX1nDZNIB/G0w9FM=;
 b=hT9c5hO/uGmpcnfzRX7gFh8UBQSrYhddjUyRS3A2kSLzVwIoYKcBlZA1lUjxVvitmM
 zwK3qBfwKQl8HBl27Z5YpD1Ibs876oLAZ/hKiGIuo8Dpp+1kXZ6IBmeIEyBOdRQe8JYT
 2OZhksjBw6ldxUl/SFQ80VOz/6dtzS3GIgbrUJXtIA0g1RYqE0klGe+jU0UGHLFhRd2U
 4tVcUKt3P+G4Ean3WvprLRPDe4Nfy0es9qQ3rZKSbzvEDxiPhx8YEzj/gICmYtNcA0WE
 MNQ+WwC3TFJk6tYPyfiF1oQ6raKHcBAKgTJ7Fz8RUCqe11oa3+naiWu74HPidLCmUuUf
 nvFw==
X-Gm-Message-State: AFuF++mxzpqBzoEi3MmrcMxyX9q3Wiw5rotK7Zsu2Pcc7dC4awM2kxq0
 X75vcQCXxLTlNx5adGwxuJCc7F6P3L5Lbggs0tTNkRVZeiLG8odZgIjn1/3TDzVC2O4=
X-Gm-Gg: AYBFou0hWY8bViFljxGO1IoC7bb6nXZhkhklCaXpuLIAWF7H47wpXRJ70lRxVewBvjs
 yv8BJKyyxfsAqu1BjlOQX5BmpXF5H8EYhYOpLLNrMwQ20HGVBQg009Dm10s+1wCl9XprwfROjwh
 mOJ0ArDh1L9cnxZEpNx/a9F1yA7OpDjmOJ2ejSh0AMfq5L3I31KJst75ILgkJmfiYLy1RfDOjtg
 w6zhB4e18qboMo1nhpyOKqn58h1zl/m6oBjUSg0R1PzSoxlcvdhxUmv3tGUMzzzrG9QsvwO4Ewo
 vIqrT0/QKieCGl/Lp3+gRwBA631ZNwkZ717Ed4shzXaM6wLp9Q65jfOW8bCoWp6pWuPeyaXv6Yr
 y4FbGfew/yeZZk/VwmSqLy7WiFlG05J5DjIvvihVS1z8vk6DpmzxNncVGGK1whc4WW3PGrJZ0w3
 sDCMszlld5K9hk6HHCn448GpJFhiOGgMUsiCHaiKel9TWDiSgCNFmtZ81sLk6n5S3Waealb0fEG
 8du8QhXXys2sSVPHDX8kASrhm3p39uxuseLsibIitRNqBBu+fqlVQXruM6zq+kztKXZHWb7/V9W
 hjTO2MhpcSygcI7dFmx7KMluBMylvw/tmfpufSSD4D6mJWIZo0+b0A4=
X-Received: by 2002:a05:6000:71a:b0:487:c3e:8df8 with SMTP id
 ffacd0b85a97d-488716b6caemr10375092f8f.5.1790343630289; 
 Fri, 25 Sep 2026 06:40:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:00 +0200
Subject: [PATCH v6 02/12] memory: mediatek: add SMI larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-2-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
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

The SMI local arbiters (larbs) gate a multimedia subsystem's access to
DRAM. On the MT8188 the display data path feeds through the VDO1 larbs
(larb2 and larb3), whose clocks must be ungated for the HDMI pipeline to
reach the framebuffer.

There is no dedicated SMI larb driver upstream, as Linux handles the
larbs through its SMI/IOMMU framework (drivers/memory/mtk-smi.c). Add a
minimal U-Boot driver that ungates the clocks of one larb, and export
mtk_smi_larb_enable() and mtk_smi_larb_disable() so that the DMA master
behind a larb can tie it to its own lifetime.

The larbs are not video devices: they serve every multimedia master
(display, video codec, camera, MDP), so the driver lives in
drivers/memory with its own Kconfig symbol rather than being built as
part of one master's driver. Every "mediatek,mt8188-smi-larb" node
binds, which is cheap, and a larb is only probed once a master asks
for it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Kconfig        | 10 +++++
 drivers/memory/Makefile       |  1 +
 drivers/memory/mtk-smi-larb.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 include/mtk_smi.h             | 37 ++++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 5f029fd3e70..52b0104e2f0 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -20,6 +20,16 @@ config ATMEL_EBI
 	  driver. Doesn't provide an access to EBI controller. Select
 	  this option to enable the NAND flash controller driver
 
+config MTK_SMI_LARB
+	bool "MediaTek SMI local arbiter driver"
+	depends on ARCH_MEDIATEK && DM
+	select MEMORY
+	help
+	  This driver ungates the clocks of the SMI local arbiters (larb)
+	  found on MediaTek SoCs. A larb gates the access of one multimedia
+	  subsystem (display, video codec, camera, MDP) to DRAM, so the larb
+	  feeding a DMA master must be ungated before that master can run.
+
 config SANDBOX_MEMORY
 	bool "Enable Sandbox Memory Controller driver"
 	depends on SANDBOX && MEMORY
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d5f5b073672..ee7bd9a9ea1 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,6 +1,7 @@
 
 obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
+obj-$(CONFIG_MTK_SMI_LARB) += mtk-smi-larb.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
diff --git a/drivers/memory/mtk-smi-larb.c b/drivers/memory/mtk-smi-larb.c
new file mode 100644
index 00000000000..b90f5cc135f
--- /dev/null
+++ b/drivers/memory/mtk-smi-larb.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek SMI local arbiter (larb) driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <mtk_smi.h>
+
+/**
+ * struct mtk_smi_larb_priv - private data of an SMI larb
+ * @clk_bulk: clocks of the larb
+ * @enable_count: number of DMA masters that enabled the larb
+ *
+ * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
+ * handles them as part of its SMI/IOMMU framework (drivers/memory/mtk-smi.c);
+ * U-Boot has no such framework, so this minimal driver only ungates the larb
+ * clocks on behalf of the DMA master sitting behind it.
+ */
+struct mtk_smi_larb_priv {
+	struct clk_bulk clk_bulk;
+	unsigned int enable_count;
+};
+
+int mtk_smi_larb_enable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* several DMA masters can sit behind the same larb */
+	if (priv->enable_count++)
+		return 0;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		priv->enable_count--;
+	}
+
+	return ret;
+}
+
+int mtk_smi_larb_disable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->enable_count)
+		return -EINVAL;
+
+	if (--priv->enable_count)
+		return 0;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_smi_larb_probe(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+
+	return ret;
+}
+
+static const struct udevice_id mtk_smi_larb_ids[] = {
+	{ .compatible = "mediatek,mt8188-smi-larb" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_smi_larb) = {
+	.name	   = "mtk_smi_larb",
+	.id	   = UCLASS_MEMORY,
+	.of_match  = mtk_smi_larb_ids,
+	.probe	   = mtk_smi_larb_probe,
+	.priv_auto = sizeof(struct mtk_smi_larb_priv),
+};
diff --git a/include/mtk_smi.h b/include/mtk_smi.h
new file mode 100644
index 00000000000..b0166b37538
--- /dev/null
+++ b/include/mtk_smi.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek SMI local arbiter (larb) API
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_SMI_H
+#define _MTK_SMI_H
+
+struct udevice;
+
+/**
+ * mtk_smi_larb_enable() - ungate an SMI local arbiter
+ * @dev: larb device
+ *
+ * Enable the clocks of the larb so that the DMA master behind it can reach
+ * DRAM. Calls are refcounted, so several masters can share one larb.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_smi_larb_enable(struct udevice *dev);
+
+/**
+ * mtk_smi_larb_disable() - gate an SMI local arbiter
+ * @dev: larb device
+ *
+ * Drop one reference taken by mtk_smi_larb_enable(), and disable the larb
+ * clocks when it was the last one.
+ *
+ * Return: 0 on success, -EINVAL if the larb is not enabled, or another
+ * negative error code
+ */
+int mtk_smi_larb_disable(struct udevice *dev);
+
+#endif /* _MTK_SMI_H */

-- 
2.55.0

