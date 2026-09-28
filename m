Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9EEC9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4441D80BCE;
	Mon, 28 Sep 2026 09:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Yb_22K2WWtT; Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4506B80971
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587061;
	b=fZy+pNlanrprM3VV/PoA58+8/SseBbyPkPiHRpNu5iZip3wewaNGxFE7jwuRIW9v+tfs
	 rV4TfC2ohX2zRh/dwp1XK7I51YDlHyN4AhhbhwIXIlzM7725eQGA0rztLAzExmtaxLiut
	 37yTeypQu9X8+l7pVDxa4LUsGoUxJRObYfX0UPqVKh63yO/KpSOxebcmTT4cSTFVgEygJ
	 IAF1nzK3udGpqGKROtpnkhb3zo86bfDFb55zsg3e95xvfNsHADsCMD2qVSgsGTIkf7QOv
	 4FwtVZ8qOCQLgyHnf4vTLxbkgbV9Iy1wcYK1L+cIBKdOL2nwkwvjUuAw9ydJzpZQURQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wZuHWFEEpg2gVQoFe/MwlVw4vHot1GbOE3XBl51sp5o=;
	b=X6O3QF7qF3ZB+Nx42jolQg3ZzXSxoFjikta0JNn9INEqSCJcaZJiQX7EHyfvWBxXQexZ
	 jC+oOEVADn0ix/9iuPPHBZ1yFyzO8+mJ5JszryiY7ZtZVB0qbIWEatTrJTHVZ0dVvvcI7
	 v6J05x5YHhOoGnGHypHwpWwma7ccbWDxeOty3iURG/4jOtigdhWET9Eh/+WcDlkT277nd
	 eXysfYtCv4bsN2hBbessO6k8Hz8YIodX0W26u2+xEAxbyTcuUux9SjJeijl0HldbUnk1h
	 EJfYWHXGBFb8qirTQ8pa7sD/DENHtHSSqjR2NW28rdYDn3nHCEUCoVlQNje9jYf4HqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587061;
	bh=wZuHWFEEpg2gVQoFe/MwlVw4vHot1GbOE3XBl51sp5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDFMUUrXNaAZ07xLUrK6qON/auwIa/MRaMIBjjmielyrZqu9xHWolpEm0xLAd5RFI
	 ovj5wq7MYRcMMwLIQXtCMh142QfLnCrwtiHwlOik7kfVKKEE+eREWXUOdq0572uw6M
	 umJsv3uD4k8LYNxIWQYs4D01DVWJfmpM155bLpywQ0b6AycJrE8ReumTtQKvw0U9Qf
	 iReQVyqQNkQnIto7cIlnm+jKj9JAjh2dEG9E3edz9WnswON9XWw2wfPDsT52n6cTwO
	 YHZT9eX/sJjXI+YDMol4FGCfdE5RBuvGMAGWYSnHeUg/QQVYQE0apLi3xl7QWEvNey
	 6ZFRL1cVizLtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4506B80971;
	Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2431924E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A2F64019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dhDq8hVoPGuf for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C6F7840198
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587058;
 b=J9nkGlvtD36m6z602HqyYBStpfhNLKLhoKzmI7II4xy+bVzPeTjDGiBOSGE7dnzp1aI8
 /xaztzf6XiKWZjksOX0AxPfynMaMeJrmx/DzjoZ2u8s9AfcycoJvvY6IOa2jsYYO7lwF4
 WbhD6diDsdbfmDFboDQIye1cImH5E9+mTncOsQ1x6ENhVk0y3ULr9Y/1zpKn1CeJx9KHt
 f5sUp3Jo5YTS06SYdVq0pMwdL0B7Fx+lBirYjByxSFV0V3yBMYLA6wJeUK/3qr+rxbZF/
 6KvYqKoKH3kZHxc1YfrQiKfAjOmDN/I7eEfa/dokAin7Q8u77UPdnnd8EduSb5SLA5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587058;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=wZuHWFEEpg2gVQoFe/MwlVw4vHot1GbOE3XBl51sp5o=;
 b=fudQtLX+BVmVVvVB/SJhOxIa1/1NGg13wzNedIpTtgJhQK6ugIvfajlZHSoBsBP3rQmk
 BjCqiYAJvnMz85R++q/ts4yv4LdmVIOEqCg/0++gGXmSAsWIlVrX2xlnTsHR5Ir+MZ+dk
 ulbV/cIG3G8H56B+xC+G1x+SsFGY2/Vad3uriaRqCR1GiAItkDwu7e5Kl4LUqXLO2s8WT
 fkCVqOxgLAsbX6g+YK/v7XjzaNTjkWOvGVW6aGkhcPneKn1wk6iEl65EpkGQTmhySwKI4
 uPeNXLtViKVkiPSz9zy6K+XGWfdvKxNJ9ouPKBKjcVAyNZdNMJl89l7Eaf00Ax+T5qA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CPxOH5bZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CPxOH5bZ
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6F7840198
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:37 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-488615e6cfcso1931078f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587055; x=1791191855;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZuHWFEEpg2gVQoFe/MwlVw4vHot1GbOE3XBl51sp5o=;
 b=CPxOH5bZI7g6EklX56p7GFFvcs8GsGL3qFCrfdMhDrBB6SZ0K8znxF0QalHaNYkmRJ
 XFE8E6BvaIz3AxV9gRoWTEo1lxGEwvl79u9MEwq3kQqmWWySDcWwzS34G14ydc8mmUcH
 pWR7pMwvpevar7x7TNPQokADz7o5s2DPGO/pmBFQOfgzQHI4Ko/IWFnNgwl284a3bLin
 mbJ6JUaslffOmHUS8lQtw99Q0thzApENE/XJ7TkKvIV/+yAqtBDXH1thCCQZ4Qswk11I
 +u40NFie94A/u6/FW/jt39EpTJlBet5VPZ7E5ZCPCkopE7dal+8uszXjkQKChgR/HhQg
 9eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587055; x=1791191855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZuHWFEEpg2gVQoFe/MwlVw4vHot1GbOE3XBl51sp5o=;
 b=ldCf+N/LdQGkFRZzmNoBSSzOXOSCWXraayvo8DTe2m+817fBQ0Vl8H0KaT95WulUup
 mI20v0WBVGPSzH/N/jU2x6yqJtaOxLCbzSAoXRbsSDYgyc+31JFn0ZTu4r4ibp4Ssp7Y
 RdtGoKqy72XClGMTjT19hE5qX7dGPTXuSuvTfPr1nQh/U93wlc49u1KqMariuAHfEe/v
 b3WmgHEGXJiYmb9hzjfy0KlNNTQ7nZwXH5fufkwy9DnaF44KBGT6s+3HQ7u3jqKfjgyB
 W9ycRnMLsZ8E2vwPdVbVjClqrnx/UGjNYixNhs0OTXu9tGoLCPMQA6d7M+tblrg/1t49
 b5Ig==
X-Gm-Message-State: AFq9FYLS7HALzI7tm8ZArajlJyxqVAbJ4f2GnnTmcQXB6PI1M2c2r4Ta
 /xekxX3EIvl05rg69BzdVrEeRgP87n9pDUIblx4JOt/VdaawaXTl3Fxsz39gxOdFV9I=
X-Gm-Gg: AYBFou2hhqjQOiXDxD5pTieWJfXTTRnryfQIlVOwtB/4Piq0AUIXah+GbAdqk06RXyo
 9W/ZbI3tHklOtqfX00Tl0TZ0c4wfKE0wg7EjWn7OpSVmmrrL1A9tniY5NCBO9GqNl7MmRbaTyRy
 R/Agb0WLY+sEqyLZ1M7UTUAeii58hzi00WK9Tlcap4Uk7nEUoPubceTtWMpWRkTPTFrW2FAL01z
 4v9p90zKyO6WhLgMYAwumw4QfRs3WCfCXQu4qZGcaQkgmV8886nwfrC1RAJzWILA3ApFw5CX0eN
 r2wh6Nxxzm2Y5ovqSYuR9Ih5GfvC+lOIbLYqWCgA44acPd2YV+K4CB3pRh3WTmkj6Yd6s/4AGvo
 tM7uZiBaUuC1iG+Tbb9u29XNJAC2HKKtFKpfrxZvjQqkzfmPEvfyqA+nArBDh7liARAqafsagxS
 tTgocBxFqM4W64W0IDgpxF0Ag9dwJQqdcY+kEXkHEuKI7a02j4peWkORFbQZwdSXFRHhwYt7sMZ
 jM3ozAueBsNF+PhswWTxFREOvVW/O9uAZtUtgSG5r78lOL+U0vJqSt/reKXcV6PmMXXT2ykwk+Z
 S8n+vCL5xBQgw13yWOLzrS8VloZOOQYN3uhpyGX6qwxDztgdLAPfWsNg2flgxMdvqg==
X-Received: by 2002:a05:6000:4b19:b0:488:8882:d504 with SMTP id
 ffacd0b85a97d-4888882d749mr11651358f8f.10.1790587055232; 
 Mon, 28 Sep 2026 02:17:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:37 +0200
Subject: [PATCH v7 02/12] memory: mediatek: add SMI larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-2-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
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
 drivers/memory/Kconfig   |  9 +++++
 drivers/memory/Makefile  |  1 +
 drivers/memory/mtk-smi.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/mtk_smi.h        | 37 ++++++++++++++++++++
 4 files changed, 136 insertions(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 5f029fd3e70..a3b7c722070 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -20,6 +20,15 @@ config ATMEL_EBI
 	  driver. Doesn't provide an access to EBI controller. Select
 	  this option to enable the NAND flash controller driver
 
+config MTK_SMI
+	bool "MediaTek SoC Memory Controller driver"
+	depends on ARCH_MEDIATEK && DM
+	select MEMORY
+	help
+	  This driver is for the Memory Controller module in MediaTek SoCs,
+	  mainly help enable/disable iommu and control the power domain and
+	  clocks for each local arbiter.
+
 config SANDBOX_MEMORY
 	bool "Enable Sandbox Memory Controller driver"
 	depends on SANDBOX && MEMORY
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d5f5b073672..f33d8acd5b2 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,6 +1,7 @@
 
 obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
+obj-$(CONFIG_MTK_SMI) += mtk-smi.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
new file mode 100644
index 00000000000..b90f5cc135f
--- /dev/null
+++ b/drivers/memory/mtk-smi.c
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

