Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AEEC28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528888175D;
	Wed, 12 Mar 2025 01:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mAq0Ewif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60192817D8; Wed, 12 Mar 2025 01:31:59 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D22807D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e8f916e75fso4051116d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739515; x=1742344315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7gMOENVrRum1IVmPT+RqHDPfSpjpRQ/Sk6xuD8GBfk=;
 b=mAq0Ewifn+z2kbv+gAEcZnprLya5ZKC8FwJE6wADT/UW2z4rzHabjezMC1sYWEhNdu
 D7WuZLk9WIIlnct/fcmLlgzuLbvq+IKJUb46E+Lm3UWoK0eYT6ix+KMcODUE9DrBUTqd
 BCfIe4bAFLzamS0nLdAGJOICD8pgll52oZRrPTFlBwc30k/ZjKIQVRkXekOT7Dc4CXUh
 sIxQUrQ/xm+UZlZINfYHyASZ5ONuPmLiVbY4Tyejzqaez5lq1Y7+RMuyZAxISJQGXnRW
 k7rPBLG32P8FrrfbPH+WT6bkrII48qHyxX3m+8PaMuj9+mnj83CwW3hyM/T55+VwOSWX
 EKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739515; x=1742344315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7gMOENVrRum1IVmPT+RqHDPfSpjpRQ/Sk6xuD8GBfk=;
 b=ieH68g/TBwctwXVFR+W0xMTDzc8jg1PEbM2b8yC6lQIP+XtGCWlWQf7umP2Xr9UZFG
 kpKBaYWzxD5QKhPZn3lgG6WX/wN8Hkys4y5fDdspz0u5l65zNX1YHFbxYSuoG+g45vlQ
 9yx/AHxvHcjSzLhJE/WAHzX5Sc1r69/Jbbt0qlO6yfs4gAxPeii7jN4ofC/VpyH7bmNr
 HmGiWGEymZwdwCBW9UERyzzzFO1pSHzdXIBqIs8xvp2oM+Ygizrri/n9wbLoVBlL3l5X
 de+jaetuUqxLYsjsaDmDLlilg0TfXjpjYLxRyOebAwFYchGyDC9Du3UxlnhuCH8yB+9G
 bSMw==
X-Gm-Message-State: AOJu0YxPDtGDA238UBPrlF1vc1fkUOyoU8NGD1vxzNSxE2vSfq1XCwpv
 2iwAXytLx8uVJqZKXOFZgGuhFNkSaaq/SNyZCijLW4WaIDdLtynZJKBqtg==
X-Gm-Gg: ASbGncsoBY5jU+NKxZMK440IunsEZ7WPeKyQgCI7r3swuWk8l5+szpjP+aKbuYY61X/
 nzjP1655gqzfXu58TGfrhY0zKPP9XcatbFEJlEzsGQhSugsHsY7hnmqaoeY6QgiL5zjnrhRKoH+
 uVygjDVKcrWzMFwF3ARPSOzISKwISYW6FCwQeGFXa22b7E+xe+6nOwZEoa1pTA/Q+J8Aa1GfWPe
 cHplEgr5tnMzs2RDopytlr5OS8D84HXjre6C0hOKZ3T8r4BGYlJ7aMS1rcljAxQZI+1Km7kQYgn
 Df6jJqmuPFbmNp6IincZq3PN/ZRzOKx9rB0At91SLdEQhUFsy6PihgUKl5qmBrSLJcoyfzzTdvG
 LFIIyRFE8PepV3j2/6/4=
X-Google-Smtp-Source: AGHT+IHB8T/oQusJy67Z41jTRA7bVB55aIL2l9izTgdrYSr8tGio/X4W49PJ/FeXZrmaCZoM9AJagw==
X-Received: by 2002:ad4:5943:0:b0:6e4:540b:5352 with SMTP id
 6a1803df08f44-6ea608e2bb6mr90878016d6.16.1741739515467; 
 Tue, 11 Mar 2025 17:31:55 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:54 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 05/10] serial: mxc: Support bulk enabling clocks
Date: Tue, 11 Mar 2025 19:30:25 -0500
Message-ID: <20250312003041.110023-6-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Depending on the platform, there may be multiple clock sources
required to enable a UART.  Use the bulk functions to get and
enable the clocks when the UART probes.  This can facilitate
the removal of functions to manually enable the clock.

This is made dependent on CLK_CCF which is used on imx6q,
imx8m[mnqp], several imxrt, imx9.  If/when the UART clock
registration is done for older boards, this limitation
could be updated.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/serial/serial_mxc.c           | 11 +++++++++++
 include/dm/platform_data/serial_mxc.h |  1 +
 2 files changed, 12 insertions(+)
 
 V2:  Fix build issue when built without CLK_CCF

diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
index c5fd740be4d..28f4435d01d 100644
--- a/drivers/serial/serial_mxc.c
+++ b/drivers/serial/serial_mxc.c
@@ -3,6 +3,7 @@
  * (c) 2007 Sascha Hauer <s.hauer@pengutronix.de>
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <watchdog.h>
@@ -312,7 +313,17 @@ int mxc_serial_setbrg(struct udevice *dev, int baudrate)
 static int mxc_serial_probe(struct udevice *dev)
 {
 	struct mxc_serial_plat *plat = dev_get_plat(dev);
+#if CONFIG_IS_ENABLED(CLK_CCF)
+	int ret;
 
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret)
+		return ret;
+#endif
 	_mxc_serial_init(plat->reg, plat->use_dte);
 
 	return 0;
diff --git a/include/dm/platform_data/serial_mxc.h b/include/dm/platform_data/serial_mxc.h
index cc59eeb1dd1..6f607b987ef 100644
--- a/include/dm/platform_data/serial_mxc.h
+++ b/include/dm/platform_data/serial_mxc.h
@@ -9,6 +9,7 @@
 /* Information about a serial port */
 struct mxc_serial_plat {
 	struct mxc_uart *reg;  /* address of registers in physical memory */
+	struct clk_bulk clks;
 	bool use_dte;
 };
 
-- 
2.45.2

