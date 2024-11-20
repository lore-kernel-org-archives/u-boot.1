Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB60D711B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996B4892C6;
	Wed, 20 Nov 2024 16:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AceMBFM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A9B89348; Wed, 20 Nov 2024 16:36:11 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476CA88FCE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a789d422bcso2730705ab.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116965; x=1732721765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q21QPSPAOlBI/jIWnKcOfeM5dlHghv4XE1zIczlTwys=;
 b=AceMBFM5L5cJgS7KcAAtOPQ1xbspioMy9MoaNyOAZZ+Y43KW4lZrRfh1N5uWP/5XHV
 VOrNpx/ehLo4dfzX9KNo4WZ6EphEiNQm7sb553/M4zJsvdkomrooJDMStYc01TRQl2mk
 pc8HUmuCrbE0LwM6x1mfVzpp58nVAkxxiDArQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116965; x=1732721765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q21QPSPAOlBI/jIWnKcOfeM5dlHghv4XE1zIczlTwys=;
 b=vT1kBfzsWCkl+ZE3lu12BhXEYmqAB9s4Qa+tbT+gIOoBVSDzAYSw7rvH8R6dW1LzhJ
 vsAJzQjt1J+80mSkm629wVzJ9GyPj/npaY10XPSmvxTexaV3cCkbiwvKVtPEDcgsawKg
 3MLrJlFrLE2LhELNOqKwDZudlWcH2vjpXPPD9WMNsCKyRDyDSDg9NNes6iySMyDjkCcn
 D8KnD86J7nk6ffSW4eexipfrfwR0qRMQzt9TExEhjYkQ2/K+gT8EgV2/SUOyhIZMf6Ke
 d8hDGyTElsTfiLV5edtpAEl1lJ4q3dwDngdC51SmzKjycVmIGm8W7Fq0qZfYRcNLYWLZ
 PZGg==
X-Gm-Message-State: AOJu0YzLzeLIZZRGOA8Sp4DPMuR8NS3MoTFTKra7YmRtrgX/BHD0X7PM
 D0JirtLrcNmWV4uflcGZPjDc3Z1QLB2O3ywciYlf+zMlEq8hxlW7AaQ1xOCZz2OrTE4fW7xinr8
 =
X-Google-Smtp-Source: AGHT+IHNxGU7NO+NDVAnza3VT+LI7DYUpS9VhOequPTOkcdP+TNRM+RBRDhaIu1Nj86omjC4zUQV+g==
X-Received: by 2002:a05:6602:14c1:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-83eb5f99cf6mr438442839f.3.1732116964820; 
 Wed, 20 Nov 2024 07:36:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6dffd678sm274395139f.23.2024.11.20.07.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/3] serial: Allow a serial port to be silent disabled
Date: Wed, 20 Nov 2024 08:35:52 -0700
Message-Id: <20241120153554.860710-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153554.860710-1-sjg@chromium.org>
References: <20241120153554.860710-1-sjg@chromium.org>
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

Provide a way to disable a serial port at runtime if it is known that it
will not work.

This is useful when booting from coreboot, if it does not provide info
about the serial port in its sysinfo tables. U-Boot then hangs since if
does not have the UART harware-address needed to write to the UART.

The feature is optional, since it increases code-size slightly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/serial/Kconfig         |  9 +++++++++
 drivers/serial/serial-uclass.c | 19 ++++++++++++++++++-
 include/serial.h               | 25 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b27ad9a77e..d6541b289a0 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -99,6 +99,15 @@ config VPL_SERIAL_PRESENT
 	  This option enables the full UART in TPL, so if is it disabled,
 	  the full UART driver will be omitted, thus saving space.
 
+config SERIAL_CAN_DISABLE
+	bool "Serial ports can be silently disabled"
+	help
+	  Enable this to allow serial ports to be disabled at runtime. This is
+	  used when there is a UART driver available, but it cannot operate,
+	  perhaps because it does not have the required hardware information.
+	  An example is when coreboot boots into U-Boot but does not provide the
+	  serial information in its sysinfo tables
+
 config CONS_INDEX
 	int "UART used for console"
 	depends on SPECIFY_CONSOLE_INDEX
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index a08678dde4e..7f1914e21ed 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -242,11 +242,20 @@ static void _serial_flush(struct udevice *dev)
 		;
 }
 
+bool serial_is_disabled_(struct udevice *dev)
+{
+	struct serial_dev_plat *uplat = dev_get_uclass_plat(dev);
+
+	return uplat->disable;
+}
+
 static void _serial_putc(struct udevice *dev, char ch)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
 	int err;
 
+	if (serial_is_disabled(dev))
+		return;
 	if (ch == '\n')
 		_serial_putc(dev, '\r');
 
@@ -262,6 +271,8 @@ static int __serial_puts(struct udevice *dev, const char *str, size_t len)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
 
+	if (serial_is_disabled(dev))
+		return 0;
 	do {
 		ssize_t written = ops->puts(dev, str, len);
 
@@ -306,6 +317,8 @@ static int __serial_getc(struct udevice *dev)
 	struct dm_serial_ops *ops = serial_get_ops(dev);
 	int err;
 
+	if (serial_is_disabled(dev))
+		return 0;
 	do {
 		err = ops->getc(dev);
 		if (err == -EAGAIN)
@@ -319,6 +332,9 @@ static int __serial_tstc(struct udevice *dev)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
 
+	if (serial_is_disabled(dev))
+		return 0;
+
 	if (ops->pending)
 		return ops->pending(dev, true);
 
@@ -568,7 +584,7 @@ static int serial_post_probe(struct udevice *dev)
 	int ret;
 
 	/* Set the baud rate */
-	if (ops->setbrg) {
+	if (!serial_is_disabled(dev) && ops->setbrg) {
 		ret = ops->setbrg(dev, gd->baudrate);
 		if (ret)
 			return ret;
@@ -611,6 +627,7 @@ UCLASS_DRIVER(serial) = {
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.post_probe	= serial_post_probe,
 	.pre_remove	= serial_pre_remove,
+	.per_device_plat_auto	= sizeof(struct serial_dev_plat),
 	.per_device_auto	= sizeof(struct serial_dev_priv),
 };
 #endif
diff --git a/include/serial.h b/include/serial.h
index e5f6d984d28..f62dc6e9ba4 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -287,6 +287,19 @@ struct dm_serial_ops {
 	int (*getinfo)(struct udevice *dev, struct serial_device_info *info);
 };
 
+/**
+ * struct serial_dev_plat - plat data used by the uclass
+ *
+ * @disable: true to disable probing and using this device. This is used when
+ * there is a UART driver available, but it cannot operate, perhaps because it
+ * does not have the required hardware information. An example is when coreboot
+ * boots into U-Boot but does not provide the serial information in its sysinfo
+ * tables
+ */
+struct serial_dev_plat {
+	bool disable;
+};
+
 /**
  * struct serial_dev_priv - information about a device used by the uclass
  *
@@ -309,6 +322,18 @@ struct serial_dev_priv {
 /* Access the serial operations for a device */
 #define serial_get_ops(dev)	((struct dm_serial_ops *)(dev)->driver->ops)
 
+bool serial_is_disabled_(struct udevice *dev);
+
+/* Provide a way to silently disable the port */
+static inline bool serial_is_disabled(struct udevice *dev)
+{
+#ifdef CONFIG_SERIAL_CAN_DISABLE
+	return serial_is_disabled_(dev);
+#else
+	return false;
+#endif
+}
+
 /**
  * serial_getconfig() - Get the uart configuration
  * (parity, 5/6/7/8 bits word length, stop bits)
-- 
2.34.1

