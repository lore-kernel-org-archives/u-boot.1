Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725DC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E06D811DF;
	Sun,  2 Mar 2025 17:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSivw8dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3318180017; Sun,  2 Mar 2025 17:53:52 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2848058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso11197485ab.1
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934392; x=1741539192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHInHJYN4U5NzlG78beVQrOkzdLQV4vbcrSwngT2BI8=;
 b=WSivw8dgx8ciCxAbR6Zf6VE+xff+Ze/83Sxqr3L9LUk3cZ9+NcysRlZast4EbEA65C
 M0pGDHta1QDgN+Wdah8xPOwPduX/uuLhCgNgZTozka/aP3jH4gzJgK2b6FKO5Va96u03
 nO8UuxnAT3IOb/HpRkGP3IvZvPInur1oflbHxKBJJwY584wzrBI9g16hfUqjU5wZv4s7
 ZbO1ZFtFGRcWAwua9W6Ry7vFPBbHrGJkw65Z+0Xjq8XYzXmNUPSZP/RSGPjzPgPYy12F
 m8xz+5DAGXk9ImtyUSZIZgyiIYLbT9y9gWQdsXAWgwqf6TZrQxB0UY6VVPTdxV8c2gIU
 gR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934392; x=1741539192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHInHJYN4U5NzlG78beVQrOkzdLQV4vbcrSwngT2BI8=;
 b=eJfT0N0XKwC1tL4FnxD1QE8nTvTEllRILRbXCcTcIf2QhlmQtwID3I6ZFURB0QhilG
 U+QmHvrSA0Wv0LUG6JzJ0Nmd4z8PjLIoFxBL0whwRrIZOJH1qj52gb3wm9M6tDGLzU8L
 YDGyG3Qw6ZdsBVjWZlUW0ZEXyEJyXmjnDH+rrN40yvPXe2rIHrMEHYDYrClmXBwqD903
 3uepoWBBNAGi4nJ8SsRGJIcJz9pWa3j0bvYaHjiC8CiteZqA7Xs7e05BtTbYx/qbkVlv
 3ygyRSaEg2u5pwss5QsV6blK/1P040JNGueP3qsXTxVwAZVovSikWR81Np5gcDbq3y5s
 PmYQ==
X-Gm-Message-State: AOJu0Ywwtzerj/sDTekd0+6tUoOMsey8pm5Y5RQ051POxAhVwET32OQE
 rmYaG3WXfyzNvRt2/wjQmSntgGTLuGUArLKuTAcLZxZOEThdrq6cZkh5yA==
X-Gm-Gg: ASbGncvmWMaxQVN+jYe9tjecA1NcK8p1DRWRbRTJA7HwVqhMQPc5L1W7X5hZk6i3znA
 S4dmTtKgVYF0tBOzlqoiJa7DGAT0DgE/yt3bBQ3pjaoQXoJUFgnrXep1dlwiqZzpz7xOlZws7tb
 OzgnErb/Wv5gSpI0cRVMdpWvqsHnR/lb5N75b5Noe4/ft0a7yAFbFl8lWmqWjslWZva2vWjFWS+
 SSW78+KQ+6ZfDXBCRc6sMYOrSj/6ayrocw2JFJ6iOFvgCRO9B6VJJYKPy3a1D76l6FA5rM0+urt
 3/x6HwE5L3K6MkPQ7VjPnHygyotELVPwRqI7m7erP/Ato34JFzlhdmYrXpDyE27jr7KyRqatqpe
 k5VWfm15XjsqpKlOWaGE=
X-Google-Smtp-Source: AGHT+IECFMUc0xj8OEnoD+z4/2Gjy9F0EyR6CouYi7hk3h9f3llzVUUy39syUJo4eB2/fuxRZyn0iA==
X-Received: by 2002:a05:6e02:1a6b:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d3e6f64ce6mr119372915ab.21.1740934392085; 
 Sun, 02 Mar 2025 08:53:12 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:11 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 05/10] serial: mxc: Support bulk enabling clocks
Date: Sun,  2 Mar 2025 10:52:32 -0600
Message-ID: <20250302165249.267992-6-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250302165249.267992-1-aford173@gmail.com>
References: <20250302165249.267992-1-aford173@gmail.com>
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

diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
index c5fd740be4d..208dc52f2a3 100644
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
+	int ret;
 
+#if CONFIG_IS_ENABLED(CLK_CCF)
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

