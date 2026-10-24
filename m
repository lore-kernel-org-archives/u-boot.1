Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4084606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g0Pnxl/U;
	dkim=pass (2048-bit key, unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.a=rsa-sha256 header.s=google header.b=qQoTVY0Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4539D81656;
	Sat, 24 Oct 2026 06:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lf7hoSGRigyA; Sat, 24 Oct 2026 06:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1117815D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792821990;
	b=GFpBIvP4G045qnuKLq/jVEA1skVm3oVnv7a4s/jF1CPEzpmVjTW9nrzLHa/ZnsbcNI9k
	 61KAH/BMIDQkqJ++GbfD2gMYgoJXYbmcDLyk+9VgnAhm4zEXHyQK6WGmmwPlTeORzxMa+
	 /+wwYtVh47xAkjOpeWJsFCdFthxmhJ2malJ8KqcvPVYYoOjJsKmQiLloEppyGVMsvike+
	 Bw1lIO2z4jHFOWckVQ3IwKXNGbMjizv+JD70bBZ3uYJ5rJ8llbg7nuE5Yy5eQSivslnRM
	 W/l1G4zVPTtwvLd2Jq9/wsy44n2oPoep0LqYmZsNKPVoWqcFmgIrLKAP+qKEUUjsg5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792821990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sogg8DS22OjQbIL3XrQAW0xBeV8bIgVkMqB3LA3nkUQ=;
	b=Nb7czNDRq+3+vf6bz0V11QI2NZMBQEGEVZi2/u5pFbFazv0gnzYP1vddlLTQt69QVdMc
	 Uno+kzFBYtgc7J3HlJL+DeAPDbXok/KrgJBm+FHNBqz+b8F6D/xU06ND30EJ1whmdpOST
	 g2l0HomNICv+HkSMwMoZUEpVYjEImqZ4rbfOxkF8hWv5mBNUc9ugzLJAZBfPYfj+LLmjM
	 69C10zqUBeDW7UVaO4gPWZMy9/rHK/HMeI97O4UxlN9muedO23vG0+aWctT6raAA9RckV
	 ZI4zTF47exuqwqema9jrEZJAP3ToXX6khAQcHWXEUlN9DmP9AwgGl9/vaHkB5YrcNaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792821990;
	bh=Sogg8DS22OjQbIL3XrQAW0xBeV8bIgVkMqB3LA3nkUQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g0Pnxl/Ujdmb2c1+sD8RYmUVTWXsMe3xPO4W06wVohyoZFi8mFAHwaAHauLyo6C28
	 6zCP3mlRfc5efvnHUf6Q4huxseCpbc9z8+9d8PmGDdK9+h/5Nnty4w677IRg5vBYPn
	 7r/OHZLJLa9fP1yemjY5qetQSgf/HVGlc2Q3fSB79xdc92gcT156v/Ss9p9AEv6RxD
	 sBxhsTFqrtZ8mD0oMAL8LGcEawT5UoXAvFngNqr6zdvAwWxghNGjJcyc8aTTtYwPcX
	 JK6Gen87OUO9cBo6nqfXQEvhS2yTwayRPNZHmyrmvWwdEMbsGLtWap9FET+h2c2c2i
	 67qGhNvxPDtLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1117815D1;
	Sat, 24 Oct 2026 06:06:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 87B4C4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 784EF400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDjyyY8pbBku for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5A5CD40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792821987;
 b=Gm/iTrJm/VibmD2EAfTgLDDCKVVDJglTcwhtURXot4v4vqI12/XgCMPJQK3VlxM93jmn
 VfTcqcXGqH53QCAmmdxFOGFN972urzTclDd2wnX1Znp9+LXwdZhJOP/PKJIf28l8sF1G1
 Mh4c3IcI+FV4Z+3j8ml2v7XQGbtlrKtptnwHCCo0pcDwUEXBR+6QI3WB5fWCpY6TW77Q0
 wQu+jgnhdL5bK/Y9RxUZ21pH5fn84hoS3HvAkySFA2Md2TeeL1HZXzzeJFjo0dI4NvsHv
 qp1gdF8NSBivNTAziH0188A/W3GEJVufZ+82nrjPpYFZTd/CKpgrB3bEm00D1HhDg2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792821987;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Sogg8DS22OjQbIL3XrQAW0xBeV8bIgVkMqB3LA3nkUQ=;
 b=CzEF4pAEQCi04tNigcgqNXnFI2oSToEwuOhm9861qgSomIjph1peauIPu+BGhOPEsOGj
 Ssho9u1F1YkpcAitQbJt8tjwrKFrfd0h3VJN1iKbpsIlfo7NhkgJIRWBfxTD3lVEEMRNS
 Pe2SIRGb/f5OMOYVtznf5BlD8LefeZY5aIxoQOWmLLYcfcoCRk9mz8ROQukCp2+uGAZEw
 AbXIRFBX+1Vf5sOq9uGqflbVOMScAhLHfi8jjI2WOhbwaEHWLbJbR8lRBQktj+/NpoRoZ
 PuMGxP7kcKub4rDD+k2MF6u3ybkA89wt2ZUlcNumeoMbn/zkHMsI7JSZ53IRPJ2+JCA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mechasystems.com;
 dkim=pass header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=qQoTVY0Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::a;
 helo=mail-dy2-x0a.google.com; envelope-from=advaitd@mechasystems.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=qQoTVY0Q
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A5CD40068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:06:26 +0000 (UTC)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-35eaf84cc66so1372310eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1792821986; x=1793426786;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sogg8DS22OjQbIL3XrQAW0xBeV8bIgVkMqB3LA3nkUQ=;
 b=qQoTVY0QfBlW1N+TPWAa03SbkswcK6W0/ezgQ07YjWiXqQgIsPf+HDk54PPqGZNR81
 sheEzox7u+H8VCLzHpO18hgtUYzG0bHBSlNLXCichq/lx9/12PxNeC4FAmf0HzvRzz5m
 ky6QIeJUadC0G1Ee83GIpoG5mPVQoW1PhcFPD4FU4+OKhrPG6kX6vEbxZiEDevS4r9GF
 uDj7buTVnfM1RDbYf6iMQxIMgOpo3oAias/N5XtqNg9ZN52kIh8ioTh3tUGYRzdbxvzK
 Wb86NPk3h5Ijbqw0k3NTWTrvdwzNzkwN49Yjje4GE8x6BHOAOThV5LUPihaF8grC+PBx
 V9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792821986; x=1793426786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sogg8DS22OjQbIL3XrQAW0xBeV8bIgVkMqB3LA3nkUQ=;
 b=QrW3X54QiiOXs8f/b0b8RqMsdW53Zw4i0RxSvqkX70e8pEz7sZzKky9T4xRGoNaEMd
 hhdnumkc7zq11DdmtUhXux7oSWq94yfngQWDpuM+cS7UIS3tY2OKOsWSmZoHk4Chj/sK
 GWzxD8dCO/KseE6jZmZRv1vQo3vYdQosIh/T8/sTKzDEclV4NIin2TywGWj7KVZhZn/C
 MGHfaUlNmlnhx26mfS4hkhOswb/zUGQ/5Qt5JI0cOgJ7/VcOtAKlUUkV/jYAH+VVeLGc
 MMkBHgT1wh+801Bgh3L/idzVvjq8c1axKur7xViJ6Ex43+Gv/xTMtSWvRiA07Xc31NEN
 zz9A==
X-Gm-Message-State: AFq9FYKHQCrJ8rPMs6v63XTyfw1zn8jDPOJmQX0N1oHc7ycCukoCnqY7
 lzW6cf1UIqYFZUmXjEpINTND9qSQCrrOcRQaaMGCUAqOh+yUq62STO/c7IgRVcbb+fpGzS3IqyY
 uk8oDjHsQTg==
X-Gm-Gg: AYBFou3MhI9l6fLyM3xN6KL/jh6ymh+jmmeGa2lfx9whzHcE/OG1xrGEKAoCX3Hg2q0
 1m6MqFr7NPDambrrnN5t6MxRjKu23TbwxLDFGuCP6popZ7w6IbnAU8/dW6O5KbrCWI9mqbLCr/l
 SheC9a1vv715FxeQmZVBKRzxs8x4D/GHsgbMArzrqmg60wW96Yc8n8TcpmRxQNT0xKVIHz3F1G9
 tEN2IgE4NP5kb1HNPiT37gFH45wLGeOQdhvVkbfXuzVl3vUINuMJonhgAYSl4+UL9l3llEre8+w
 ForEJs+gfltC9mk8XsMjLo+4t+BGwOYQXk/kJqWDTdWTYIwFXTTvg3bYFATkeY6UxRJ6Rgr9+B7
 V65nrqHk+oaEBEtR5hp9ou7c6M+MLEffUD3cfESAqDtuCAPtZ9jJYTUj6cOk7FMox99Qz/CKt6e
 yA7yWgq9Ens852PGnpQzuaNX4F0Fem6EO6Du+tPPeEWAMpFHIA+Q8tqK+ySB7Lx1Z959SNzZR54
 tp5vKEpOZW9wqLCrSiD+lZFZowIMjpp6gWTuxE0DPMTIVJpUFuJJOM7NsnKXaLBdw==
X-Received: by 2002:a05:7022:5f14:b0:144:de98:eec1 with SMTP id
 a92af1059eb24-1993571a23bmr1821052c88.11.1792821985722; 
 Fri, 23 Oct 2026 23:06:25 -0700 (PDT)
Received: from fedora.taild9c4b8.ts.net ([2a09:bac5:3b6f:16b4::243:6b])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm8501935c88.17.2026.10.23.23.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:06:24 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, ag.dev.uboot@gmail.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 sjg@chromium.org, patrice.chotard@foss.st.com, xypron.glpk@gmx.de,
 ravi@prevas.dk, clamor95@gmail.com, pratham.malaviya@siliconsignals.io,
 Advait Dhamorikar <advaitd@mechasystems.com>
Subject: [PATCH v6] video: add ChipWealth CH13726A AMOLED panel driver
Date: Sat, 24 Oct 2026 11:35:35 +0530
Message-ID: <20261024060535.95010-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v5 -> v6
Link to v5: https://lore.kernel.org/all/20260917184524.122806-1-advaitd@mechasystems.com/
- Add missing header for regulators
- Rebased on latest main and fixed conflicts

 drivers/video/Kconfig               |   8 +
 drivers/video/Makefile              |   1 +
 drivers/video/chipwealth-ch13726a.c | 221 ++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/video/chipwealth-ch13726a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index de0197b21cd..f7a66aa3d2a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -790,6 +790,14 @@ config VIDEO_LCD_SPI_MISO
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
 source "drivers/video/mediatek/Kconfig"
 source "drivers/video/meson/Kconfig"
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 7a7b54e6b53..d97c2181968 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_VIDEO_MVEBU) += mvebu_lcd.o
 obj-$(CONFIG_VIDEO_MXS) += mxsfb.o videomodes.o
 obj-$(CONFIG_VIDEO_NX) += nexell_display.o videomodes.o nexell/
 obj-$(CONFIG_VIDEO_OMAP3) += omap3_dss.o
+obj-$(CONFIG_VIDEO_PANEL_CHIPWEALTH_CH13726A) += chipwealth-ch13726a.o
 obj-$(CONFIG_VIDEO_DSI_HOST_SANDBOX) += sandbox_dsi_host.o
 obj-$(CONFIG_VIDEO_SANDBOX_SDL) += sandbox_sdl.o
 obj-$(CONFIG_VIDEO_SIMPLE) += simplefb.o
diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipwealth-ch13726a.c
new file mode 100644
index 00000000000..af633244312
--- /dev/null
+++ b/drivers/video/chipwealth-ch13726a.c
@@ -0,0 +1,221 @@
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
+#include <power/regulator.h>
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
2.56.0

