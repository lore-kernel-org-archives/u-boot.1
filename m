Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1330C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 18:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7482810FE;
	Thu, 17 Sep 2026 18:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byPylionFIgR; Thu, 17 Sep 2026 18:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AA59F810F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789670751;
	b=s95Fw6/ipYbZ99XWIjgx5tciEwBrbNV+IiFoAvRbo6ZpkwyUNR4dcKeWbLSRrVZXCzTG
	 ir8bl6rNDziNnd4NKn5ZXfBeGHI/UayvjbIjBI1+3dj4nh35XbClOrpzKzvjpXK4J2eI6
	 j3rQpZuiw4yRMWZU8mtoGsbkY434OQzvmrf2pWsKJ1eouk/f/TMDKIBCQlQnnrtVhQuuz
	 mpYZtvwoYy8R3yo3e2wCNO/ZRFHs6V66hvbIQkY1OExJI7XNhOfVMXmrk63zsRphM+5fA
	 RS3QnSeMs52f1cGcSi5PzFlxcAn3EdeyIVxGmDMBX2wzuw0aISBKjjEur++VQjpqQrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789670751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PGjuI1IfLG2lPdHhI++ZVAf4+9h1DBHJv/4VgDRsrV0=;
	b=cDHQRaRuoG1D7GRtAoU75WX41V8SFl8xY48m2IKD0WzreoJbw3Vz7Fq4EJXLC8168ADb
	 XJ+V+YqM2zjpfRP/X7J7ubRZYtwUZZpQtzs/rMbr12AWWqm+Sl5QLOCH255ck0a64TI/c
	 5hDObkDwIk61XqtwYGAUD1SW1eaeAqO8uGjmec0GM5imrom3OqUhNx8Q2rHytEO3bJE0E
	 ikq2FOZc5Jn6j8JG4TLTwJkq/OuXqukmiynAhhLNJJmW8gnEaBqeANuNb4mZzimJaw+mA
	 BPwzNBr47KkXzerPFsBS74j/K9WwWB9P7WV3sag06GPx+eig1171TfIPgofbwMW6A4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789670751;
	bh=PGjuI1IfLG2lPdHhI++ZVAf4+9h1DBHJv/4VgDRsrV0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f5NoOGVS61S+f6cJXONbIJprYi+YCLOAwPGy7fxxJOZd5cxJQDr9iUNysdOiDe6Mz
	 VeSaTqZYQGzTLEkCdCv8l3vUZzk+SwCyaZ8Sh/gkjsqR+uv17M2shxsSUVY41uA5Xp
	 0Ys59+vfw6VEDz1LZ/5Ei6iDlF7eJWezZfFIUw74m1soATQuqRZJ0j6v8RT11eNkOJ
	 fnsiSmYEo7jbbgCXJlsEP7Qu9uGnalm7IkmYmoHHBkIpqS27IGCbd7+KimlaciiIKt
	 gKYVjqdRHXjixgVKVYubvm8pFvSRxVGCs9+U6NNxPQS2GeTdcVlVfmR4M4acSWwf2a
	 OaHJHZDubJCxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA59F810F8;
	Thu, 17 Sep 2026 18:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 062BF23F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBA434044A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wllP1n3qW0Gk for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 18:45:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DB43540427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789670750;
 b=I0l+5QxNsAG1vdG8DigrXk8/2zOdHAh6QWVyFZ6/3yY20rg8VuBUs6ycPcm9WQOF6Dbg
 NwBQk9Ml6S/M4F8P0RJOMaKJDFFGky359gk6a5220eH4HKT7j4whlC55gUvxWXpe6dGbd
 T+OL3dhAU5uL+pwTx5cQzUOE+4vlZqAB7fs9+gmNj0axULNndxRTj3zmMMKmA1ohB/szH
 rETlNdYJuEQdnKgzQi57rA9MOyAFWUnnRvJbRPs2Mg9ve7nfcdoSgecLKm18CMZzxEEop
 fpgLxf8yOZGZi1jr395CNNE/fvW9SuWoR/y7S6hnxjo0q7NEQusyzrmd2FdjZERzGXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789670750;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=PGjuI1IfLG2lPdHhI++ZVAf4+9h1DBHJv/4VgDRsrV0=;
 b=CWuxUi6IT+o5B6/Q0snZkiOBO499xIUQ8ExEq/C0PITslpH2otdQYLa0L2wKVaDT+JZg
 AKWNh1BLlheJI75IvcYq/U+C082q2LuXCk63LogyvUWwXWgTpQk17owLUcfRL3pxfPskJ
 Mq9wbm0GYUFeCIA3upj41Ob6c115FEebUbdnmHqFV7UgEv8n9rWNIrLV06q7ZibodLRL9
 yzEkkQRnkXlI7aBnn/dnv1r34+qXVOdU7BpdOXqrbCbKPkNXZLA09m2aSKw3NEUMqwS1G
 mjXUY9N15yh5yiQsf2P62axFcE4U36xkmDuijEXbUqdHxr+GBO4VrKVLOwlbZp1WRYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mechasystems.com; 
 dkim=pass header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=HcSONfP9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=advaitd@mechasystems.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=HcSONfP9
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB43540427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:45:49 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so30a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1789670749; x=1790275549;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGjuI1IfLG2lPdHhI++ZVAf4+9h1DBHJv/4VgDRsrV0=;
 b=HcSONfP9wbjvCBUHPGW9weMnzsrt6YuVziVdFbQyk7z26pTwz/qfHEwvu2hm0NOBMf
 8zCjatMNNu5xf2XC1xLdow3Fd4LMhKCtx47t/j9gGT+37z10H/uKERfrUtmOe2E4xiH3
 4udCnVroJD10cAsO5k0mxB7eC3UTanMLny8Vz2m/0fLQ7cav3t2h6Qbtrjf+s9xGJhLk
 TE+ZujNWnmHdHXPGkAMOdaLZ1gM0AkRzd228JDtC0BIwNboyzXl5GPtDC4WTYyAeX/rr
 JVaPjfJsPNxCL2MT/TFdd0YHrfEUOXYi/fO/R1bjt4KotyqB1vL/phvdYB6ZVMfqjqCm
 WTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789670749; x=1790275549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGjuI1IfLG2lPdHhI++ZVAf4+9h1DBHJv/4VgDRsrV0=;
 b=olsflcclXZUG5U1re79P3ALOoguc6AncfRmN01gNzZ7lZIehNFHVm301jw2wVZ5aRC
 PKQx9pfyu6BX1/XBgl5wKdv4igCELo2m2h81CnlSL6EQeS6PbJ/qgO/D1f8bwAeR9Q3U
 OYy4koR4/62EBnfgWl8q+dGhp/Fpxgy5deKiOiAGq9lcC0UN87YXn24tmytlwHr5DO44
 kJxc3akOKqSSMXD2V/brx4fBQS6OkIxyqm/MEmQYhYucPTTd89xkgHzWNM0pnW3fi1VL
 qE7W5x56P+kXWyBTVgM6314Z8MUy//u775ltDMxtsIGSbI/eQTDu2We5hjy6E1I3TcW0
 4WRQ==
X-Gm-Message-State: AFuF++kL1qkdhMhFPd5rDaDL1g+9iiQk10pHIOiRP3x7EkUe2f0xc5xm
 WUPdTMo20IG+6duV1WqD9C15KyE1N1iJ52/EFwZ2JQNo80HbSvUmMHsDxj7J/khhTrufCHI9B5i
 RXGhP
X-Gm-Gg: AYBFou1aPvqL43/l/60iYQLt8QMVR4uo9mZ9Cg+0jDsjvWqYYk4YqAP7Fz1N9Rpetnp
 01pOdgs3nhzStx/B9B4rgt0xOwjYRW39SPPtw6O8LTkwLm1IcBjVicqJc2+2A0AmldTCMgKt7jC
 YNf9l2IfI2ntko5IyqfwrcEBrQdtmtRev+uBJGXBLbIFxH3JYqNrCpdZcYdiLgB6CzROCVbGWng
 +Ly8bF5s6SaJVSU2lnEW6Veoxd4pPoNp8BTeY9xEnA6f4J3VRMXyhe2iq4VXDs4HV0jfzDzmFL1
 8MtSDKWhdAtQZQBbPZ8AbWz1fZB2cn3+iPdmKWOEBuxIRn1Loao1K4LkFfFroHQUhKt+EjAhlgS
 5Zo7jOZcUz3jv0r2y9K49zKQTnH1NVTsuo+BQjkc4k2bUZNjoQAfVjIOTAzKVYS0T2unbwl7rZF
 tC5AGTmodFeykihK8IvzffbIC0CmF3IV/5IUVLMqz1ppPgdc7uR4dteWs+Unni9txbvIs=
X-Received: by 2002:a17:90a:e707:b0:39e:345b:3322 with SMTP id
 98e67ed59e1d1-39e54cf11c2mr191198a91.23.1789670748739; 
 Thu, 17 Sep 2026 11:45:48 -0700 (PDT)
Received: from advait-work.. ([2a09:bac5:3afc:1aa0::2a7:d6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d4a48fsm14686892c88.10.2026.09.17.11.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:45:48 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: u-boot@lists.u-boot-project.org
Cc: clamor95@gmail.com, pratham.malaviya@siliconsignals.io,
 Advait Dhamorikar <advaitd@mechasystems.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de (open list)
Subject: [PATCH RESEND v5] video: add ChipWealth CH13726A AMOLED panel driver
Date: Fri, 18 Sep 2026 00:15:21 +0530
Message-ID: <20260917184524.122806-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for AMOLED panels based on the ChipWealth CH13726A
MIPI DSI display driver IC.

The driver configures the MIPI DSI interface for 4 data lanes in RGB888
video mode, performs the panel reset sequence, sends the vendor-specific
initialization commands required by the controller, and enables the
panel using the standard MIPI DCS Sleep Out and Display On commands.

This driver is based on an earlier implementation by Pratham Malaviya.

Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---

v1 -> v2
- Expand CC list based on get_maintainer.pl output.

v2 -> v3
Link to v2: https://lore.kernel.org/all/20260702151325.290749-1-advaitd@mechasystems.com/
- Add regulator support using the U-Boot regulator framework.
- Minor code cleanup.

v3 -> v4
Link to v3: https://lore.kernel.org/all/20260716110318.97757-1-advaitd@mechasystems.com/
- Remove unused struct variables

v4 -> v5
Link to v4: https://lore.kernel.org/all/20260722131626.77086-1-advaitd@mechasystems.com/
- Invert GPIO toggle polarity to match the recently merged upstream Linux driver
- Use MIPI DCS command enum members instead of DSI command values
- Update copyright info and Pratham's mail address

 drivers/video/Kconfig               |   8 +
 drivers/video/Makefile              |   1 +
 drivers/video/chipwealth-ch13726a.c | 220 ++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/video/chipwealth-ch13726a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c..a214626f376 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -762,6 +762,14 @@ config VIDEO_LCD_SPI_MISO
 	option takes a string in the format understood by 'sunxi_name_to_gpio'
 	function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_PANEL_CHIPWEALTH_CH13726A
+	bool "ChipWealth CH13726A AMOLED panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for AMOLED panels
+	  based on the ChipWealth CH13726A MIPI DSI display driver IC.
+
 source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..efa7e288691 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) += samsung-s6e63m0.o
+obj-$(CONFIG_VIDEO_PANEL_CHIPWEALTH_CH13726A) += chipwealth-ch13726a.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipwealth-ch13726a.c
new file mode 100644
index 00000000000..55adc6fba23
--- /dev/null
+++ b/drivers/video/chipwealth-ch13726a.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ChipWealth CH13726A DSI panel driver
+ *
+ * Copyright (C) 2026 Mecha Systems
+ * Copyright (C) 2026 Silicon Signals Pvt. Ltd.
+ * Author(s):
+ *   Advait Dhamorikar <advaitd@mechasystems.com>
+ *   Pratham Malaviya  <pratham.malaviya@siliconsignals.io>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <log.h>
+
+struct ch13726a_panel_priv {
+	struct udevice *vdd;
+	struct udevice *vddio;
+	struct udevice *vdd1v2;
+	struct udevice *avdd;
+	struct gpio_desc reset;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ			=	59832000,
+	.hactive.typ			=	1080,
+	.hfront_porch.typ		=	12,
+	.hback_porch.typ		=	12,
+	.hsync_len.typ			=	28,
+	.vactive.typ			=	1240,
+	.vfront_porch.typ		=	2,
+	.vback_porch.typ		=	2,
+	.vsync_len.typ			=	2,
+};
+
+#define dcs_write_seq(dev, cmd, seq...)				\
+({								\
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);	\
+	const u8 d[] = { cmd, seq };				\
+	int ret;						\
+								\
+	ret = mipi_dsi_dcs_write_buffer(plat->device,		\
+					d, ARRAY_SIZE(d));	\
+	if (ret < 0)						\
+		log_err("failed to write dcs sequence: %d\n", ret);\
+	ret;							\
+})
+
+static int ch13726a_hw_init(struct udevice *dev)
+{
+	int ret;
+
+	ret = dcs_write_seq(dev, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dcs_write_seq(dev, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(120);
+
+	ret = dcs_write_seq(dev, MIPI_DCS_SET_DISPLAY_ON, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ch13726a_reset(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->reset, false);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, true);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, false);
+	mdelay(5);
+}
+
+static int ch13726a_set_backlight(struct udevice *dev, int percent)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	u8 brightness;
+
+	if (percent < 0)
+		percent = 0;
+	else if (percent > 100)
+		percent = 100;
+
+	brightness = (percent * 255) / 100;
+
+	return mipi_dsi_dcs_set_display_brightness(device, brightness);
+}
+
+static int ch13726a_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	ch13726a_reset(dev);
+
+	ret = ch13726a_hw_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ch13726a_panel_get_display_timing(struct udevice *dev,
+					     struct display_timing *timings)
+{
+	memcpy(timings, &default_timing, sizeof(*timings));
+	return 0;
+}
+
+static int ch13726a_panel_of_to_plat(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vdd-supply",
+						  &priv->vdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vddio-supply",
+						  &priv->vddio);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vdd1v2-supply",
+						  &priv->vdd1v2);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "avdd-supply",
+						  &priv->avdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: cannot get reset GPIO (%d)\n",
+			__func__, ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ch13726a_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			MIPI_DSI_MODE_VIDEO_BURST |
+			MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct panel_ops ch13726a_panel_ops = {
+	.enable_backlight	=	ch13726a_panel_enable_backlight,
+	.set_backlight		=	ch13726a_set_backlight,
+	.get_display_timing	=	ch13726a_panel_get_display_timing,
+};
+
+static const struct udevice_id ch13726a_panel_ids[] = {
+	{ .compatible	=	"chipwealth,ch13726a" },
+	{ }
+};
+
+U_BOOT_DRIVER(ch13726a_panel) = {
+	.name		=	"ch13726a_panel",
+	.id			=	UCLASS_PANEL,
+	.of_match	=	ch13726a_panel_ids,
+	.ops		=	&ch13726a_panel_ops,
+	.of_to_plat	=	ch13726a_panel_of_to_plat,
+	.probe		=	ch13726a_panel_probe,
+	.plat_auto	=	sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	=	sizeof(struct ch13726a_panel_priv),
+};
-- 
2.43.0

