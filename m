Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1853CD6136
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 20:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D0C86487;
	Mon,  9 Oct 2023 22:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZM7TCvLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFC786BD0; Mon,  9 Oct 2023 22:32:49 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE14D8642D
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 22:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79faf4210b2so188148539f.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696883565; x=1697488365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I+Lp3XFGntTJgc0hNFf/bTB0F124VVp57snWB91oGSM=;
 b=ZM7TCvLcOIMuH9VlM2Gp3PpKLNttElRzTX7TcLcKTreUsPt8gEwPhNj2QQwQGnN16I
 3+FyMvkFas/Sv3dDiXMlHShsMRxriWwttjk9xqf9hEJygEUdqyoEyvBsDBWWN+BlPsHa
 g/It/GP1sMq9KotilmUC8ywQF18yUgQHj7mJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696883565; x=1697488365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+Lp3XFGntTJgc0hNFf/bTB0F124VVp57snWB91oGSM=;
 b=nTM0Ad2Tr7WsGRkmk86+tye3lFaQXKge0dqaD0cK2GfquBJJCgN9NgZRmWzt8T/sCn
 w7nmqxRy+0bEAqqxv9CdYAyO4+vSIbCQImNMJS2lqHSq7sIaMmzHtPIkN796cYlN/Od5
 g0HISgzZKo2mVPGabEC09+/Q+6FVzKYmOHLyAmoBdzKkeT0y8wKEnfxjFBGHQl9kctee
 8J0KYWcyTHu7X8rMZa78DMcmOg/RkvWh/uFfFmPXwVhPQ+3pILU7EiHgc/SDKPaDl8FS
 uuVpM9W7V3Y2j5fk8RIy4Yfzv86pFxwHWiDbBNY7RSzLh8A6heIwsdEFLDFL5+5FwqfR
 EXPg==
X-Gm-Message-State: AOJu0YwZSx4dWWyZWBkHOvf14DMDJBGsfYL+yyC0z+nRVZptZ3aR1Xpw
 G8JGbryP7qHazZmxB6g1d9vFEXaSCW/gxnJQGSc=
X-Google-Smtp-Source: AGHT+IEOrzG9gqzXcMJLw9vGsfMKG/hj9U6is0KbehJmbCQXho1MpFFuq++bSgJmpYgDfl49M4NdgQ==
X-Received: by 2002:a05:6602:22d8:b0:794:c9a2:5fe3 with SMTP id
 e24-20020a05660222d800b00794c9a25fe3mr18566541ioe.4.1696883565193; 
 Mon, 09 Oct 2023 13:32:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:138c:cf57:c18d:20f5])
 by smtp.gmail.com with ESMTPSA id
 br13-20020a05663846cd00b0042b62a31349sm2300859jab.146.2023.10.09.13.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 13:32:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] RFC: x86: serial: ns16550: Allow the UART to be silently
 disabled
Date: Mon,  9 Oct 2023 14:32:38 -0600
Message-ID: <20231009203242.1979537-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

U-Boot normally requires a UART. When booting from coreboot it is
sometimes just not available, e.g. when no sysinfo or DBG2 information
is provided.

In this case we need to continue running, since the display can be used.
Add a flag to disable serial for this case.

This allows U-Boot to start up and operation from the display, instead
of hanging on start-up.

This could perhaps be hidden behind a Kconfig option to reduce code
size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/serial/ns16550.c         | 17 +++++++++++++++--
 drivers/serial/serial_coreboot.c |  1 +
 include/ns16550.h                |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index eab9537fbae..6bb84f8c5bc 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -384,6 +384,8 @@ static int ns16550_serial_putc(struct udevice *dev, const char ch)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
 	if (!(serial_in(&com_port->lsr) & UART_LSR_THRE))
 		return -EAGAIN;
 	serial_out(ch, &com_port->thr);
@@ -404,6 +406,9 @@ static int ns16550_serial_pending(struct udevice *dev, bool input)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	if (input)
 		return (serial_in(&com_port->lsr) & UART_LSR_DR) ? 1 : 0;
 	else
@@ -414,6 +419,9 @@ static int ns16550_serial_getc(struct udevice *dev)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	if (!(serial_in(&com_port->lsr) & UART_LSR_DR))
 		return -EAGAIN;
 
@@ -428,7 +436,8 @@ static int ns16550_serial_setbrg(struct udevice *dev, int baudrate)
 
 	clock_divisor = ns16550_calc_divisor(com_port, plat->clock, baudrate);
 
-	ns16550_setbrg(com_port, clock_divisor);
+	if (!(plat->flags & NS16550_FLAG_DISABLE))
+		ns16550_setbrg(com_port, clock_divisor);
 
 	return 0;
 }
@@ -441,6 +450,9 @@ static int ns16550_serial_setconfig(struct udevice *dev, uint serial_config)
 	uint bits = SERIAL_GET_BITS(serial_config);
 	uint stop = SERIAL_GET_STOP(serial_config);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	/*
 	 * only parity config is implemented, check if other serial settings
 	 * are the default one.
@@ -525,7 +537,8 @@ int ns16550_serial_probe(struct udevice *dev)
 		reset_deassert_bulk(&reset_bulk);
 
 	com_port->plat = dev_get_plat(dev);
-	ns16550_init(com_port, -1);
+	if (!(plat->flags & NS16550_FLAG_DISABLE))
+		ns16550_init(com_port, -1);
 
 	return 0;
 }
diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index 23066e4d054..cdf9afc1739 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -120,6 +120,7 @@ static int coreboot_of_to_plat(struct udevice *dev)
 		 * there is no UART, which may panic. So stay silent and
 		 * pray that the video console will work.
 		 */
+		plat->flags |= NS16550_FLAG_DISABLE;
 		log_debug("Cannot detect UART\n");
 	}
 
diff --git a/include/ns16550.h b/include/ns16550.h
index e7e68663d03..618bb4026b3 100644
--- a/include/ns16550.h
+++ b/include/ns16550.h
@@ -52,6 +52,7 @@ enum ns16550_flags {
 	NS16550_FLAG_IO		= 1 << 0, /* Use I/O access (else mem-mapped) */
 	NS16550_FLAG_ENDIAN	= 1 << 1, /* Use out_le/be_32() */
 	NS16550_FLAG_BE		= 1 << 2, /* Big-endian access (else little) */
+	NS16550_FLAG_DISABLE	= BIT(3), /* No output or input */
 };
 
 /**
-- 
2.42.0.609.gbb76f46606-goog

