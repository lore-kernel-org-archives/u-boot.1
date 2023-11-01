Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6295C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A08987B35;
	Wed,  1 Nov 2023 19:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aF2bOcdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4A987B92; Wed,  1 Nov 2023 19:04:55 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD7E876E1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-359343e399fso204665ab.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698861890; x=1699466690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p/LwgR9QCcUBaM+IAjNvInNOh7YSETgZebFJcC2hPe8=;
 b=aF2bOcdruRZEVqgbfnevDNOmeXnuQDK/FLGU+lBx8MSRHwep0GOMj9MYE81hg6pMtP
 Sw0sR98sK08aAu1/aiNQNrD/sa8W/VTBGS5Wf8zwFJkNd1/mROq02gL8SGJ45+cKX6u0
 wPxAChA09nAKBwcjiG2iXFUyDcFqfl7QaGvGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698861890; x=1699466690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/LwgR9QCcUBaM+IAjNvInNOh7YSETgZebFJcC2hPe8=;
 b=BjYV4KJ8HhK3k3XmUreIfpbAxpG+7kcaYtdTneZjdunCmeKXZZfxFmBgJ2dez1WK5p
 E3iwPr5Cwvdz0hJ4AsK0Mm9xAzZQ/dZU67HacBJdEb/qkJJ9tHczHzIulEKZ3qB+eLeE
 HIguJkpSA/VAHOg8zy73P8E+k9ueaQF9buadXHVTUup66TdSG/khkfFvKBAOUxVJY5h/
 i4PfJuVjltWqPp907QD1GCTHyNCgz1I5GwpaaCUF6T85mTdMu8pQmBt099JeA5J4Q6Rt
 AwnXaqU5FCpd5SNBKUiI/QQwO+zSBCcgqYg7Kx32qnyA4ST9UA3HCwtItd8BXbd64onx
 xpJg==
X-Gm-Message-State: AOJu0YyorWrpHfIyXd5cOI0zoSB/EKlhaVwVuRioyUrMRgByhzcrd7pQ
 Z5rpssxE6rkkOks7AvBVBFtiTJqTPyorzNDmo7g+bQ==
X-Google-Smtp-Source: AGHT+IEIQeXV7fVhTjt57x8pDNL5RAk31Vi/8jdZ/UYuQsvYtbD3d7f9xSPYhymnLTdwDF4AsgMC7Q==
X-Received: by 2002:a92:730e:0:b0:359:4287:28fc with SMTP id
 o14-20020a92730e000000b00359428728fcmr2795170ilc.7.1698861889959; 
 Wed, 01 Nov 2023 11:04:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1e5:3cc7:2119:ada8])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056e02114700b0034f6f2eca21sm659108ill.69.2023.11.01.11.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 11:04:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2] x86: serial: ns16550: Allow the UART to be silently
 disabled
Date: Wed,  1 Nov 2023 12:04:42 -0600
Message-ID: <20231101180447.99361-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

Changes in v2:
- Drop RFC tag since there were no comments

 drivers/serial/ns16550.c         | 17 +++++++++++++++--
 drivers/serial/serial_coreboot.c |  1 +
 include/ns16550.h                |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6deb1d8ddc5..a0545f37cb6 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -385,6 +385,8 @@ static int ns16550_serial_putc(struct udevice *dev, const char ch)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
 	if (!(serial_in(&com_port->lsr) & UART_LSR_THRE))
 		return -EAGAIN;
 	serial_out(ch, &com_port->thr);
@@ -405,6 +407,9 @@ static int ns16550_serial_pending(struct udevice *dev, bool input)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	if (input)
 		return (serial_in(&com_port->lsr) & UART_LSR_DR) ? 1 : 0;
 	else
@@ -415,6 +420,9 @@ static int ns16550_serial_getc(struct udevice *dev)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	if (!(serial_in(&com_port->lsr) & UART_LSR_DR))
 		return -EAGAIN;
 
@@ -429,7 +437,8 @@ static int ns16550_serial_setbrg(struct udevice *dev, int baudrate)
 
 	clock_divisor = ns16550_calc_divisor(com_port, plat->clock, baudrate);
 
-	ns16550_setbrg(com_port, clock_divisor);
+	if (!(plat->flags & NS16550_FLAG_DISABLE))
+		ns16550_setbrg(com_port, clock_divisor);
 
 	return 0;
 }
@@ -442,6 +451,9 @@ static int ns16550_serial_setconfig(struct udevice *dev, uint serial_config)
 	uint bits = SERIAL_GET_BITS(serial_config);
 	uint stop = SERIAL_GET_STOP(serial_config);
 
+	if (com_port->plat->flags & NS16550_FLAG_DISABLE)
+		return 0;
+
 	/*
 	 * only parity config is implemented, check if other serial settings
 	 * are the default one.
@@ -534,7 +546,8 @@ int ns16550_serial_probe(struct udevice *dev)
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
index 7f481300083..3c4f3e7539a 100644
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
2.42.0.820.g83a721a137-goog

