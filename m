Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47782606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W24ZkOLD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILcqBR4c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A695B40919;
	Fri, 27 Nov 2026 18:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poKrWoEU3Vxo; Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EABE440D08
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804157;
	b=o0inkqldV9ExWaVq/mk2bLqlGLvqrlKEtJMJ+PoWnvPAzo9l+Ti75Hd2WoXDnOvcJXuY
	 ksspmTtoJmcnE9ei6qSb1w192H/K2TXG1HAt68gFU1mTZhWsiGcS9eLgwklQhdTWZFxmf
	 +Msx2Nq4ir33GAfEVP+kaezDt6n0WtpDekSWBjt5IXUyNRzWg8UIPDcXgBpeOi5MsKoUp
	 dxSLLQWzcmyscI5fSWpzUFgFtRlIwbMFssXSv4umV7NRPHbKidUPUuURlpPhaX87S4Uu4
	 s5x8YA01n/G8brrD7KmjnqD2SH/oN47m5lah0CddgG/+iMM+VgQZNJuyFlLn0fNGz2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZM2AjwuQdYxcsG9IvdwkdxAEx8NsdipqHrq/p2j2Xas=;
	b=aXXdXH+B3PmE5Eakwohgpn2FjSC1ye7jSM3dXZXxqsXzEeHp46O8DCQEoIdFBvj9g6aE
	 BBfav2zUFTvHzUlHzoNrsCFin1Ym0IZ5a34VI5YkQRImGx+n8UbKaeEl9GTCkV+mNk1DP
	 btId97vQI4ESIhjqgTV8mwzz3WNsPfRBAAgs/UKDUA9PHu4nS5LyvFOIXUIQUvyLddpXK
	 ljxiol1SB0IfTfna/bBmfGZTCOQf/SREzkyvZiyH/eflUEQlR4gd3I3VMmLtgf9kkIiur
	 9VKq8lSegELYeTdIBT7T+f+ZZ0QWmtjY0BK+hVVayRygKB3DnT69opjC+vy5EwS3Qow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILcqBR4c;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804157;
	bh=ZM2AjwuQdYxcsG9IvdwkdxAEx8NsdipqHrq/p2j2Xas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W24ZkOLDga7JqaNLGtLxyStEKOpya5wjsMALZFESZwS2+MjCIzHjehTMlZposSrNw
	 3kJlP/AUkHiKt0BJwINWVwC+9IGgGvmVfYuQZ/vDYfFCxljinUpOYSP52tIvddy5i3
	 DKgJxY70d2ap5uEf6iDgVLQTmlYmxePG1qA1mOODmHbdJfUjyBl02vOqGSRRrF7Ae4
	 AqETaNeaPLa85Ts7r9dS+NC9aF7G8PD586WCjE1bSEuSJOsazkQ0n1ZHGgbVixk/BE
	 KGGgw1Nr/CrGvccsNBPAcOjxZwysCe8qttKIqIAHdbiTF/AheJH3IT5qriULvngk5c
	 B91PZRHZw26GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EABE440D08;
	Fri, 27 Nov 2026 18:29:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DEFC373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B42640AD9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP3gL7xNCaEg for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D01B440AD7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ILcqBR4c
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D01B440AD7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:11 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so80723045e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804150; x=1796408950;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZM2AjwuQdYxcsG9IvdwkdxAEx8NsdipqHrq/p2j2Xas=;
 b=ILcqBR4ctLLg6OsqVnNR19KEIGChdMjElCoiujE0QBfpiNZqAbm3GeJpBlQgM3dbWo
 sxinHsdrjtLOtaY1dk4LoB6qHMBYhhjewZ92EhHlPfQxXnUvLl3T7r22+nw49+irs9+j
 KmIiNbGu8aXtE4HXLhJVUTTTKAnXWJ7cu6PMDhaOK4dPekc7uenhIOjZFLYix7DkpjlZ
 ipjSfnMO0OJxMdiEwoxXhxJFODift04pBwq01D3vhSNGQ/DTMQq+G72OpAB1/d72Dala
 F4/VAIy0YD7gG/btjp5z29vgdTLVvHmmmGiSSHmiGnMeFIoE0m7ixpgnpVVayURaqn/K
 waDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804150; x=1796408950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZM2AjwuQdYxcsG9IvdwkdxAEx8NsdipqHrq/p2j2Xas=;
 b=tlPty9fMDTaY4lNujNPmOuCqejXWp2RQJbMMUzD+fC7i2GswpVbrwdPRl6v0Yu7PxG
 J/cq/qItKNq3WehvDS62g7enxLGFEs2257qOYRAzpuiOOYFgiPEi4+nMl2ITfL4q52VC
 0yjqHK67ppaJJlXp1+Iv8fIBhFI5aoyjwOz2qYMoZGzymmhJhp871ZehNoKlQfLrgZuw
 YJHLPmNPkrLYj1stetN5fSX7hv5f6wy2hiuuWmlZvLmbhUPdZSlh8wTPowRY9OJQ8380
 +/vpKPtmO/tYOXEGoGdTQuM6LWKLY9qVtGBYNqdhbl2tQOsuaD67KtWMwhYf+4MPsJHD
 1NNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFgPfcErw7zNBhuOLZRtxZ1suw+ql6YQDQFyYkL2IPkoL+ZTDP/Yo3T2e4ZU5aRx3A2AJ+evqo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++NGWvHAIR3A4+4WSPqgHoAZlFFP7rLOzEDLcAzG393gwO4mQ7
 /edvrPO4jVcCHbzss3BPItd4j+zOn9ok73S0r3bb/wI9EN7GmvRCdzRr
X-Gm-Gg: AZFdTZcpEjXc1Xw8Wias09ae76azihTPOLRtQ5MSyV70UcdQj+jtFk5KbEShhwuu8IF
 QGq/KHg8ANm5mdUzQxekhhZ4+fsU3VPf1UAAlyrcY2GCtLOvpleM/eYcfdzytRo6HBsxPO9l95U
 OSHOmT2mmQypYU9y0OCeytpWdYclq0m5kY3qoZgh5GW1EYL9TsNihN6pDOExYvWWHLEHA8W91e5
 qKB6Ir5Cn9ShMfH8hc7RSJ11q1aEDzAjX9+PPje2LnXAaLiNr4gJdoxXH3GSA+kPoNg9dmJdb+2
 qWrsD9gJ0JzJM2qvDbHS8qTnAOWFHgW71E4sACaTr8lbWXIL12WK2allxBlIxdXsynax7/O8hQH
 wwfqVz/3dw2Y5B743Oq9IKF1Z71NSW1v1gokGb8qubJkntf/IuXGStBQExZqvHKNCgsDQPrTBDh
 jYglQkHwmBM5ts2ViXQu8jn9t6qSTgIbnrKOUojDLytgfqUZtPQtQht0mbAVq3eJOVrNb5b76OX
 Mb1kdPLAfvTzXh+ZQpT1L2RvudaLoo0o+31UVX6MMH9VlmBbJ8MjnWAf5M2p8NlZxGNSEwXrap2
 fX8V38KP8KMcjWrujRoWlFrTiSulvrYy8C4=
X-Received: by 2002:a05:600c:4e8e:b0:4ba:59fa:510e with SMTP id
 5b1f17b1804b1-4bb8893014dmr522277045e9.23.1795804149600; 
 Fri, 27 Nov 2026 10:29:09 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:09 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 2/8] clk: imx: add a clock driver for the VF610
Date: Fri, 27 Nov 2026 19:28:59 +0100
Message-ID: <20261127182905.2836449-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The Vybrid has no clock driver, so its drivers cannot take their clocks
from the device tree, and ehci-vf sets the clock bits of its port by
hand.

Add one after the Linux driver, with the clock tree up to the clocks of
the devices U-Boot drives: the oscillators, the PLLs and their PFDs, the
system and bus clocks, the USB, ENET, UART, I2C, DSPI, eSDHC and NFC
blocks, the watchdog, the PIT, OCOTP, SNVS and CAAM. Like Linux it
takes the PLLs out of bypass.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/clk/imx/Kconfig     |   9 +
 drivers/clk/imx/Makefile    |   1 +
 drivers/clk/imx/clk-vf610.c | 465 ++++++++++++++++++++++++++++++++++++
 3 files changed, 475 insertions(+)
 create mode 100644 drivers/clk/imx/clk-vf610.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 644ab162af4..9800c0b56f0 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -29,6 +29,15 @@ config CLK_IMX8
 	help
 	  This enables support clock driver for i.MX8 platforms.
 
+config CLK_VF610
+	bool "Clock support for Vybrid VF610"
+	depends on ARCH_VF610
+	select CLK
+	select CLK_CCF
+	help
+	  This enables the clock driver of the Vybrid VF5xx/VF6xx, with the
+	  PLLs, the bus clocks and the clocks of the devices U-Boot drives.
+
 config SPL_CLK_IMX8MM
 	bool "SPL clock support for i.MX8MM"
 	depends on ARCH_IMX8M && SPL
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index a825ed9988f..b86ade03289 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_$(PHASE_)CLK_IMXRT1020) += clk-imxrt1020.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1050) += clk-imxrt1050.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1170) += clk-imxrt1170.o
 obj-$(CONFIG_CLK_IMX95_BLKCTRL) += clk-imx95-blkctrl.o
+obj-$(CONFIG_$(PHASE_)CLK_VF610) += clk-vf610.o
diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
new file mode 100644
index 00000000000..6c8ffc84f5d
--- /dev/null
+++ b/drivers/clk/imx/clk-vf610.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Clocks of the Vybrid VF5xx/VF6xx, after the Linux driver: the PLLs, the
+ * bus clocks and the clocks of the devices U-Boot drives.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <log.h>
+#include <asm/io.h>
+#include <dm/ofnode.h>
+#include <dt-bindings/clock/vf610-clock.h>
+#include <linux/clk-provider.h>
+
+#include "clk.h"
+
+#define VF610_CLK_END		196
+
+#define CCM_CCSR		0x08
+#define CCM_CACRR		0x0c
+#define CCM_CSCMR1		0x10
+#define CCM_CSCDR1		0x14
+#define CCM_CSCDR2		0x18
+#define CCM_CSCDR3		0x1c
+#define CCM_CSCMR2		0x20
+#define CCM_CCGR0		0x40
+#define CCM_CCGRx(x)		(CCM_CCGR0 + (x) * 4)
+#define CCM_CCGRx_CGn(n)	((n) * 2)
+
+#define PFD_PLL1_BASE		0x2b0
+#define PFD_PLL2_BASE		0x100
+#define PFD_PLL3_BASE		0xf0
+#define PLL1_CTRL		0x270
+#define PLL2_CTRL		0x30
+#define PLL3_CTRL		0x10
+#define PLL4_CTRL		0x70
+#define PLL5_CTRL		0xe0
+#define PLL6_CTRL		0xa0
+#define PLL7_CTRL		0x20
+
+static const char * const fast_sels[] = { "firc", "fxosc", };
+static const char * const slow_sels[] = { "sirc_32k", "sxosc", };
+static const char * const pll1_sels[] = { "pll1_sys", "pll1_pfd1",
+	"pll1_pfd2", "pll1_pfd3", "pll1_pfd4", };
+static const char * const pll2_sels[] = { "pll2_bus", "pll2_pfd1",
+	"pll2_pfd2", "pll2_pfd3", "pll2_pfd4", };
+static const char * const pll_bypass_src_sels[] = { "fast_clk_sel",
+	"lvds1_in", };
+static const char * const pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
+static const char * const pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
+static const char * const pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
+static const char * const pll4_bypass_sels[] = { "pll4", "pll4_bypass_src", };
+static const char * const pll5_bypass_sels[] = { "pll5", "pll5_bypass_src", };
+static const char * const pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
+static const char * const pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
+static const char * const sys_sels[] = { "fast_clk_sel", "slow_clk_sel",
+	"pll2_pfd_sel", "pll2_bus", "pll1_pfd_sel", "pll3_usb_otg", };
+static const char * const ddr_sels[] = { "pll2_pfd2", "sys_sel", };
+static const char * const rmii_sels[] = { "enet_ext", "audio_ext",
+	"enet_50m", "enet_25m", };
+static const char * const enet_ts_sels[] = { "enet_ext", "fxosc",
+	"audio_ext", "usb", "enet_ts", "enet_25m", "enet_50m", };
+static const char * const nfc_sels[] = { "platform_bus", "pll1_pfd1",
+	"pll3_pfd1", "pll3_pfd3", };
+static const char * const esdhc_sels[] = { "pll3_usb_otg", "pll3_pfd3",
+	"pll1_pfd3", "platform_bus", };
+
+static int vf610_clk_request(struct clk *clk)
+{
+	if (clk->id >= VF610_CLK_END) {
+		printf("%s: Invalid clk ID #%lu\n", __func__, clk->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct clk_ops vf610_clk_ops = {
+	.request = vf610_clk_request,
+	.set_rate = ccf_clk_set_rate,
+	.get_rate = ccf_clk_get_rate,
+	.enable = ccf_clk_enable,
+	.disable = ccf_clk_disable,
+};
+
+static int vf610_clk_fixed(struct udevice *dev, ulong id, const char *name)
+{
+	struct clk osc;
+	int ret;
+
+	ret = clk_get_by_name(dev, name, &osc);
+	if (ret)
+		return ret;
+
+	clk_dm(id, dev_get_clk_ptr(osc.dev));
+
+	return 0;
+}
+
+static int vf610_clk_probe(struct udevice *dev)
+{
+	void __iomem *ccm, *anatop;
+	struct clk *mux, *pll;
+	fdt_addr_t addr;
+	int i, ret;
+
+	ccm = dev_read_addr_ptr(dev);
+	if (!ccm)
+		return -EINVAL;
+
+	addr = ofnode_get_addr(ofnode_by_compatible(ofnode_null(),
+						    "fsl,vf610-anatop"));
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	anatop = (void __iomem *)addr;
+
+	clk_dm(VF610_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
+	clk_dm(VF610_CLK_SIRC_128K,
+	       clk_register_fixed_rate(NULL, "sirc_128k", 128000));
+	clk_dm(VF610_CLK_SIRC_32K,
+	       clk_register_fixed_rate(NULL, "sirc_32k", 32000));
+	clk_dm(VF610_CLK_FIRC,
+	       clk_register_fixed_rate(NULL, "firc", 24000000));
+	ret = vf610_clk_fixed(dev, VF610_CLK_SXOSC, "sxosc");
+	if (ret)
+		return ret;
+	ret = vf610_clk_fixed(dev, VF610_CLK_FXOSC, "fxosc");
+	if (ret)
+		return ret;
+	/* not in the device tree of the Colibri: the inputs nothing selects */
+	clk_dm(VF610_CLK_AUDIO_EXT,
+	       clk_register_fixed_rate(NULL, "audio_ext", 0));
+	clk_dm(VF610_CLK_ENET_EXT,
+	       clk_register_fixed_rate(NULL, "enet_ext", 0));
+	clk_dm(VF610_CLK_LVDS1_IN,
+	       clk_register_fixed_rate(NULL, "lvds1_in", 0));
+	clk_dm(VF610_CLK_FXOSC_HALF,
+	       imx_clk_fixed_factor(dev, "fxosc_half", "fxosc", 1, 2));
+
+	clk_dm(VF610_CLK_SLOW_CLK_SEL,
+	       imx_clk_mux(dev, "slow_clk_sel", ccm + CCM_CCSR, 4, 1,
+			   slow_sels, ARRAY_SIZE(slow_sels)));
+	clk_dm(VF610_CLK_FASK_CLK_SEL,
+	       imx_clk_mux(dev, "fast_clk_sel", ccm + CCM_CCSR, 5, 1,
+			   fast_sels, ARRAY_SIZE(fast_sels)));
+
+	clk_dm(VF610_CLK_PLL1_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll1_bypass_src", anatop + PLL1_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL2_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll2_bypass_src", anatop + PLL2_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL3_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll3_bypass_src", anatop + PLL3_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL4_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll4_bypass_src", anatop + PLL4_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL5_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll5_bypass_src", anatop + PLL5_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL6_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll6_bypass_src", anatop + PLL6_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(VF610_CLK_PLL7_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll7_bypass_src", anatop + PLL7_CTRL, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+
+	clk_dm(VF610_CLK_PLL1,
+	       imx_clk_pllv3(dev, IMX_PLLV3_SYS_VF610, "pll1",
+			     "pll1_bypass_src", anatop + PLL1_CTRL, 0x1));
+	clk_dm(VF610_CLK_PLL2,
+	       imx_clk_pllv3(dev, IMX_PLLV3_SYS_VF610, "pll2",
+			     "pll2_bypass_src", anatop + PLL2_CTRL, 0x1));
+	clk_dm(VF610_CLK_PLL3,
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB_VF610, "pll3",
+			     "pll3_bypass_src", anatop + PLL3_CTRL, 0x2));
+	clk_dm(VF610_CLK_PLL4,
+	       imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll4",
+			     "pll4_bypass_src", anatop + PLL4_CTRL, 0x7f));
+	clk_dm(VF610_CLK_PLL5,
+	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll5",
+			     "pll5_bypass_src", anatop + PLL5_CTRL, 0x3));
+	clk_dm(VF610_CLK_PLL6,
+	       imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll6",
+			     "pll6_bypass_src", anatop + PLL6_CTRL, 0x7f));
+	clk_dm(VF610_CLK_PLL7,
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB_VF610, "pll7",
+			     "pll7_bypass_src", anatop + PLL7_CTRL, 0x2));
+
+	clk_dm(VF610_PLL1_BYPASS,
+	       imx_clk_mux_flags(dev, "pll1_bypass", anatop + PLL1_CTRL, 16, 1,
+				 pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL2_BYPASS,
+	       imx_clk_mux_flags(dev, "pll2_bypass", anatop + PLL2_CTRL, 16, 1,
+				 pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL3_BYPASS,
+	       imx_clk_mux_flags(dev, "pll3_bypass", anatop + PLL3_CTRL, 16, 1,
+				 pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL4_BYPASS,
+	       imx_clk_mux_flags(dev, "pll4_bypass", anatop + PLL4_CTRL, 16, 1,
+				 pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL5_BYPASS,
+	       imx_clk_mux_flags(dev, "pll5_bypass", anatop + PLL5_CTRL, 16, 1,
+				 pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL6_BYPASS,
+	       imx_clk_mux_flags(dev, "pll6_bypass", anatop + PLL6_CTRL, 16, 1,
+				 pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(VF610_PLL7_BYPASS,
+	       imx_clk_mux_flags(dev, "pll7_bypass", anatop + PLL7_CTRL, 16, 1,
+				 pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+
+	/* Do not bypass the PLLs */
+	for (i = 0; i < 7; i++) {
+		ret = clk_get_by_id(VF610_PLL1_BYPASS + i, &mux);
+		if (ret)
+			return ret;
+		ret = clk_get_by_id(VF610_CLK_PLL1 + i, &pll);
+		if (ret)
+			return ret;
+		ret = clk_set_parent(mux, pll);
+		if (ret)
+			return ret;
+	}
+
+	clk_dm(VF610_CLK_PLL1_SYS,
+	       imx_clk_gate(dev, "pll1_sys", "pll1_bypass", anatop + PLL1_CTRL,
+			    13));
+	clk_dm(VF610_CLK_PLL2_BUS,
+	       imx_clk_gate(dev, "pll2_bus", "pll2_bypass", anatop + PLL2_CTRL,
+			    13));
+	clk_dm(VF610_CLK_PLL3_USB_OTG,
+	       imx_clk_gate(dev, "pll3_usb_otg", "pll3_bypass",
+			    anatop + PLL3_CTRL, 13));
+	clk_dm(VF610_CLK_PLL4_AUDIO,
+	       imx_clk_gate(dev, "pll4_audio", "pll4_bypass",
+			    anatop + PLL4_CTRL, 13));
+	clk_dm(VF610_CLK_PLL5_ENET,
+	       imx_clk_gate(dev, "pll5_enet", "pll5_bypass", anatop + PLL5_CTRL,
+			    13));
+	clk_dm(VF610_CLK_PLL6_VIDEO,
+	       imx_clk_gate(dev, "pll6_video", "pll6_bypass",
+			    anatop + PLL6_CTRL, 13));
+	clk_dm(VF610_CLK_PLL7_USB_HOST,
+	       imx_clk_gate(dev, "pll7_usb_host", "pll7_bypass",
+			    anatop + PLL7_CTRL, 13));
+
+	clk_dm(VF610_CLK_PLL1_PFD1,
+	       imx_clk_pfd("pll1_pfd1", "pll1_sys", anatop + PFD_PLL1_BASE, 0));
+	clk_dm(VF610_CLK_PLL1_PFD2,
+	       imx_clk_pfd("pll1_pfd2", "pll1_sys", anatop + PFD_PLL1_BASE, 1));
+	clk_dm(VF610_CLK_PLL1_PFD3,
+	       imx_clk_pfd("pll1_pfd3", "pll1_sys", anatop + PFD_PLL1_BASE, 2));
+	clk_dm(VF610_CLK_PLL1_PFD4,
+	       imx_clk_pfd("pll1_pfd4", "pll1_sys", anatop + PFD_PLL1_BASE, 3));
+	clk_dm(VF610_CLK_PLL2_PFD1,
+	       imx_clk_pfd("pll2_pfd1", "pll2_bus", anatop + PFD_PLL2_BASE, 0));
+	clk_dm(VF610_CLK_PLL2_PFD2,
+	       imx_clk_pfd("pll2_pfd2", "pll2_bus", anatop + PFD_PLL2_BASE, 1));
+	clk_dm(VF610_CLK_PLL2_PFD3,
+	       imx_clk_pfd("pll2_pfd3", "pll2_bus", anatop + PFD_PLL2_BASE, 2));
+	clk_dm(VF610_CLK_PLL2_PFD4,
+	       imx_clk_pfd("pll2_pfd4", "pll2_bus", anatop + PFD_PLL2_BASE, 3));
+	clk_dm(VF610_CLK_PLL3_PFD1,
+	       imx_clk_pfd("pll3_pfd1", "pll3_usb_otg", anatop + PFD_PLL3_BASE,
+			   0));
+	clk_dm(VF610_CLK_PLL3_PFD2,
+	       imx_clk_pfd("pll3_pfd2", "pll3_usb_otg", anatop + PFD_PLL3_BASE,
+			   1));
+	clk_dm(VF610_CLK_PLL3_PFD3,
+	       imx_clk_pfd("pll3_pfd3", "pll3_usb_otg", anatop + PFD_PLL3_BASE,
+			   2));
+	clk_dm(VF610_CLK_PLL3_PFD4,
+	       imx_clk_pfd("pll3_pfd4", "pll3_usb_otg", anatop + PFD_PLL3_BASE,
+			   3));
+
+	clk_dm(VF610_CLK_PLL1_PFD_SEL,
+	       imx_clk_mux(dev, "pll1_pfd_sel", ccm + CCM_CCSR, 16, 3,
+			   pll1_sels, ARRAY_SIZE(pll1_sels)));
+	clk_dm(VF610_CLK_PLL2_PFD_SEL,
+	       imx_clk_mux(dev, "pll2_pfd_sel", ccm + CCM_CCSR, 19, 3,
+			   pll2_sels, ARRAY_SIZE(pll2_sels)));
+	clk_dm(VF610_CLK_SYS_SEL,
+	       imx_clk_mux(dev, "sys_sel", ccm + CCM_CCSR, 0, 3, sys_sels,
+			   ARRAY_SIZE(sys_sels)));
+	clk_dm(VF610_CLK_DDR_SEL,
+	       imx_clk_mux(dev, "ddr_sel", ccm + CCM_CCSR, 6, 1, ddr_sels,
+			   ARRAY_SIZE(ddr_sels)));
+	clk_dm(VF610_CLK_SYS_BUS,
+	       imx_clk_divider(dev, "sys_bus", "sys_sel", ccm + CCM_CACRR, 0,
+			       3));
+	clk_dm(VF610_CLK_PLATFORM_BUS,
+	       imx_clk_divider(dev, "platform_bus", "sys_bus", ccm + CCM_CACRR,
+			       3, 3));
+	clk_dm(VF610_CLK_IPG_BUS,
+	       imx_clk_divider(dev, "ipg_bus", "platform_bus", ccm + CCM_CACRR,
+			       11, 2));
+	clk_dm(VF610_CLK_PLL3_MAIN_DIV,
+	       imx_clk_divider(dev, "pll3_usb_otg_div", "pll3_usb_otg",
+			       ccm + CCM_CACRR, 20, 1));
+
+	clk_dm(VF610_CLK_USBPHY0,
+	       imx_clk_gate(dev, "usbphy0", "pll3_usb_otg", anatop + PLL3_CTRL,
+			    6));
+	clk_dm(VF610_CLK_USBPHY1,
+	       imx_clk_gate(dev, "usbphy1", "pll7_usb_host", anatop + PLL7_CTRL,
+			    6));
+	clk_dm(VF610_CLK_USBC0,
+	       imx_clk_gate2(dev, "usbc0", "ipg_bus", ccm + CCM_CCGRx(1),
+			     CCM_CCGRx_CGn(4)));
+	clk_dm(VF610_CLK_USBC1,
+	       imx_clk_gate2(dev, "usbc1", "ipg_bus", ccm + CCM_CCGRx(7),
+			     CCM_CCGRx_CGn(4)));
+
+	clk_dm(VF610_CLK_ENET_50M,
+	       imx_clk_fixed_factor(dev, "enet_50m", "pll5_enet", 1, 10));
+	clk_dm(VF610_CLK_ENET_25M,
+	       imx_clk_fixed_factor(dev, "enet_25m", "pll5_enet", 1, 20));
+	clk_dm(VF610_CLK_ENET_SEL,
+	       imx_clk_mux(dev, "enet_sel", ccm + CCM_CSCMR2, 4, 2, rmii_sels,
+			   ARRAY_SIZE(rmii_sels)));
+	clk_dm(VF610_CLK_ENET_TS_SEL,
+	       imx_clk_mux(dev, "enet_ts_sel", ccm + CCM_CSCMR2, 0, 3,
+			   enet_ts_sels, ARRAY_SIZE(enet_ts_sels)));
+	clk_dm(VF610_CLK_ENET,
+	       imx_clk_gate(dev, "enet", "enet_sel", ccm + CCM_CSCDR1, 24));
+	clk_dm(VF610_CLK_ENET_TS,
+	       imx_clk_gate(dev, "enet_ts", "enet_ts_sel", ccm + CCM_CSCDR1,
+			    23));
+	clk_dm(VF610_CLK_ENET0,
+	       imx_clk_gate2(dev, "enet0", "ipg_bus", ccm + CCM_CCGRx(9),
+			     CCM_CCGRx_CGn(0)));
+	clk_dm(VF610_CLK_ENET1,
+	       imx_clk_gate2(dev, "enet1", "ipg_bus", ccm + CCM_CCGRx(9),
+			     CCM_CCGRx_CGn(1)));
+
+	clk_dm(VF610_CLK_PIT,
+	       imx_clk_gate2(dev, "pit", "ipg_bus", ccm + CCM_CCGRx(1),
+			     CCM_CCGRx_CGn(7)));
+	clk_dm(VF610_CLK_UART0,
+	       imx_clk_gate2(dev, "uart0", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(7)));
+	clk_dm(VF610_CLK_UART1,
+	       imx_clk_gate2(dev, "uart1", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(8)));
+	clk_dm(VF610_CLK_UART2,
+	       imx_clk_gate2(dev, "uart2", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(9)));
+	clk_dm(VF610_CLK_UART3,
+	       imx_clk_gate2(dev, "uart3", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(10)));
+	clk_dm(VF610_CLK_UART4,
+	       imx_clk_gate2(dev, "uart4", "ipg_bus", ccm + CCM_CCGRx(6),
+			     CCM_CCGRx_CGn(9)));
+	clk_dm(VF610_CLK_UART5,
+	       imx_clk_gate2(dev, "uart5", "ipg_bus", ccm + CCM_CCGRx(6),
+			     CCM_CCGRx_CGn(10)));
+	clk_dm(VF610_CLK_I2C0,
+	       imx_clk_gate2(dev, "i2c0", "ipg_bus", ccm + CCM_CCGRx(4),
+			     CCM_CCGRx_CGn(6)));
+	clk_dm(VF610_CLK_I2C1,
+	       imx_clk_gate2(dev, "i2c1", "ipg_bus", ccm + CCM_CCGRx(4),
+			     CCM_CCGRx_CGn(7)));
+	clk_dm(VF610_CLK_I2C2,
+	       imx_clk_gate2(dev, "i2c2", "ipg_bus", ccm + CCM_CCGRx(10),
+			     CCM_CCGRx_CGn(6)));
+	clk_dm(VF610_CLK_I2C3,
+	       imx_clk_gate2(dev, "i2c3", "ipg_bus", ccm + CCM_CCGRx(10),
+			     CCM_CCGRx_CGn(7)));
+	clk_dm(VF610_CLK_DSPI0,
+	       imx_clk_gate2(dev, "dspi0", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(12)));
+	clk_dm(VF610_CLK_DSPI1,
+	       imx_clk_gate2(dev, "dspi1", "ipg_bus", ccm + CCM_CCGRx(0),
+			     CCM_CCGRx_CGn(13)));
+	clk_dm(VF610_CLK_DSPI2,
+	       imx_clk_gate2(dev, "dspi2", "ipg_bus", ccm + CCM_CCGRx(6),
+			     CCM_CCGRx_CGn(12)));
+	clk_dm(VF610_CLK_DSPI3,
+	       imx_clk_gate2(dev, "dspi3", "ipg_bus", ccm + CCM_CCGRx(6),
+			     CCM_CCGRx_CGn(13)));
+	clk_dm(VF610_CLK_WDT,
+	       imx_clk_gate2(dev, "wdt", "ipg_bus", ccm + CCM_CCGRx(1),
+			     CCM_CCGRx_CGn(14)));
+
+	clk_dm(VF610_CLK_ESDHC0_SEL,
+	       imx_clk_mux(dev, "esdhc0_sel", ccm + CCM_CSCMR1, 16, 2,
+			   esdhc_sels, ARRAY_SIZE(esdhc_sels)));
+	clk_dm(VF610_CLK_ESDHC0_EN,
+	       imx_clk_gate(dev, "esdhc0_en", "esdhc0_sel", ccm + CCM_CSCDR2,
+			    28));
+	clk_dm(VF610_CLK_ESDHC0_DIV,
+	       imx_clk_divider(dev, "esdhc0_div", "esdhc0_en", ccm + CCM_CSCDR2,
+			       16, 4));
+	clk_dm(VF610_CLK_ESDHC0,
+	       imx_clk_gate2(dev, "eshc0", "esdhc0_div", ccm + CCM_CCGRx(7),
+			     CCM_CCGRx_CGn(1)));
+	clk_dm(VF610_CLK_ESDHC1_SEL,
+	       imx_clk_mux(dev, "esdhc1_sel", ccm + CCM_CSCMR1, 18, 2,
+			   esdhc_sels, ARRAY_SIZE(esdhc_sels)));
+	clk_dm(VF610_CLK_ESDHC1_EN,
+	       imx_clk_gate(dev, "esdhc1_en", "esdhc1_sel", ccm + CCM_CSCDR2,
+			    29));
+	clk_dm(VF610_CLK_ESDHC1_DIV,
+	       imx_clk_divider(dev, "esdhc1_div", "esdhc1_en", ccm + CCM_CSCDR2,
+			       20, 4));
+	clk_dm(VF610_CLK_ESDHC1,
+	       imx_clk_gate2(dev, "eshc1", "esdhc1_div", ccm + CCM_CCGRx(7),
+			     CCM_CCGRx_CGn(2)));
+
+	clk_dm(VF610_CLK_NFC_SEL,
+	       imx_clk_mux(dev, "nfc_sel", ccm + CCM_CSCMR1, 12, 2, nfc_sels,
+			   ARRAY_SIZE(nfc_sels)));
+	clk_dm(VF610_CLK_NFC_EN,
+	       imx_clk_gate(dev, "nfc_en", "nfc_sel", ccm + CCM_CSCDR2, 9));
+	clk_dm(VF610_CLK_NFC_PRE_DIV,
+	       imx_clk_divider(dev, "nfc_pre_div", "nfc_en", ccm + CCM_CSCDR3,
+			       13, 3));
+	clk_dm(VF610_CLK_NFC_FRAC_DIV,
+	       imx_clk_divider(dev, "nfc_frac_div", "nfc_pre_div",
+			       ccm + CCM_CSCDR2, 4, 4));
+	clk_dm(VF610_CLK_NFC,
+	       imx_clk_gate2(dev, "nfc", "nfc_frac_div", ccm + CCM_CCGRx(10),
+			     CCM_CCGRx_CGn(0)));
+
+	clk_dm(VF610_CLK_SNVS,
+	       imx_clk_gate2(dev, "snvs-rtc", "ipg_bus", ccm + CCM_CCGRx(6),
+			     CCM_CCGRx_CGn(7)));
+	clk_dm(VF610_CLK_OCOTP,
+	       imx_clk_gate(dev, "ocotp", "ipg_bus", ccm + CCM_CCGRx(6),
+			    CCM_CCGRx_CGn(5)));
+	clk_dm(VF610_CLK_CAAM,
+	       imx_clk_gate2(dev, "caam", "ipg_bus", ccm + CCM_CCGRx(11),
+			     CCM_CCGRx_CGn(0)));
+
+	return 0;
+}
+
+static const struct udevice_id vf610_clk_ids[] = {
+	{ .compatible = "fsl,vf610-ccm" },
+	{ }
+};
+
+U_BOOT_DRIVER(vf610_clk) = {
+	.name = "clk_vf610",
+	.id = UCLASS_CLK,
+	.of_match = vf610_clk_ids,
+	.ops = &vf610_clk_ops,
+	.probe = vf610_clk_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.56.0

