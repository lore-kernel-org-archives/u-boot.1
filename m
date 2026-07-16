Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F28C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F10684E99;
	Thu, 16 Jul 2026 18:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DDLBuS4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264B784D13; Thu, 16 Jul 2026 15:44:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E05384C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso75922466b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209484; x=1784814284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nWMu2g9KYlPG+71FcQZqNy+PUtk/s0lxJdbv8NzbSs0=;
 b=DDLBuS4jf6lyzq0pW4cMOyokwrXAvGbgTapV2l1Hu5hxkNLVtdy6Kg6ldCQfA/b5X0
 NJ309aoEMS4kdu+5X2PTqnwILlfAIWRunh1XW2sAXcxmDG7E+xgjfRrCgQBeDQzmuGUE
 hIAgOyZ5s542Op+p1db829XVAu3/fxgY41uQyeuCusl69J9BDM7N/Egk3UbPyQK/7Hsx
 qevzH3TxJVen9WQwKlwW/g9VHtcIzaPdqy4ufuSOIRh16nR1ePBX9P1gM174LiKAIbEk
 ZjqxEJmrYz+PN8sF/Nn3D2XO6ShQgwjYtqcyodTjfgtEVOkhjECr3OuzxGQWGDyX/X25
 qZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209484; x=1784814284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nWMu2g9KYlPG+71FcQZqNy+PUtk/s0lxJdbv8NzbSs0=;
 b=d4xcGMeYSqUgf3g8yPokgm+DeIY/n5xDf7QQBw3ZUq/RoF1+PlbyYOKe0ViRQ0grsr
 j8uB0lVY67GO4qMRdHcKWJzOq7VJfaTna0yGIFjOyZQw70WD9IChhTp8qpwClHpa7Qt3
 KnC/Ey07hIrJoMSYH9wgl67GAl/cRk1mrqVUe4JgsZBqEPOvAho1TGG5Twr5H1nW5P0O
 2TuTWT/qw78b4I9EtAWJKiL6WhEgZoIUJ4cPp8DbnZ0aF90dAb/WQ7aVmWfFYqgka74p
 i2SutV4E2voOUFJ3n54DEJCoYgPVtCay955YfLxrwcmuz4+kYL7yEMTVi3zeO46pMxYc
 Y2vQ==
X-Gm-Message-State: AOJu0Yz5+vGgwqWJxjcuSmdzUyb6JGm+rV6B5GSR6zvX9l1a//vDj4Wp
 yF10QWZ9YogX3I8fKekY/D3TNdYSGTZsHrDcVDgNFNmm+/7z+KnwCZix2uGjzfKfzAjvff1QVxF
 BYKVJ
X-Gm-Gg: AfdE7ckR6ly07IUpxOijwS2LYULD357F35Qg0KETaoYlXY5o9AbFC5CpgmZqaZQuDxJ
 qLKoY7NZ0DyPpAhsFrVqOECeRAuinSIiUMd7U6C1aC1u8wX7lWeGPEnf6V053j7HS884zAue+UG
 NeAG1m0VC5yeoneu2hZW86y9X9dA1yv7/guOR6jmtkpesCWRDUqbK10yk6X7pRd2hGMd4VjgPNk
 rf0qfH8ldmAs/UT1N6ex265572cKrhdexzyIew94Q+4FtZN43bH70hax7FtWqp21GnMUazU8zae
 xyTU3azgX64liByYLIAXY4v+oG//ZQg5+JrjQi4BGrQYqjJfEMKjln1znNbCBGE1GM8f8bRQITc
 6Utsl8I3anNGS6v5PsrtQa6Go6NIX5Dibr3XgxtjKGM3hjND94DXnqAHqJBjSUKNrMQoQkmQz4D
 hJFbmAie+j0axaUJqcHl8D925TVjdjTGu45vViEQ==
X-Received: by 2002:a17:907:3cc3:b0:c12:2aef:af2b with SMTP id
 a640c23a62f3a-c161e98a19cmr734979366b.4.1784209484459; 
 Thu, 16 Jul 2026 06:44:44 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e702sm218040766b.47.2026.07.16.06.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:44 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 64/75] usb: add helpers needed by the resynced DWC3 code
Date: Thu, 16 Jul 2026 15:42:34 +0200
Message-ID: <20260716134305.614278-65-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

The resynced DWC3 code calls a few helpers that u-boot did not have.
Add them first so the next commits can use them.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/dm/device_compat.h | 13 +++++++++
 include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++
 include/linux/compat.h     | 15 ++++++++++
 include/linux/usb/phy.h    | 56 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
index aa9a6fbb5e3f..6b31a72768fd 100644
--- a/include/dm/device_compat.h
+++ b/include/dm/device_compat.h
@@ -119,4 +119,17 @@
 #define dev_vdbg(dev, fmt, ...) \
 	__dev_printk(LOGL_DEBUG_CONTENT, dev, fmt, ##__VA_ARGS__)
 
+#define dev_err_probe(dev, err, fmt, ...) \
+	({ \
+		int _err = (err); \
+		if (_err != -EPROBE_DEFER) { \
+			dev_err(dev, fmt, ##__VA_ARGS__); \
+			dev_err(dev, "[err=%d]", _err); \
+		} else { \
+			dev_dbg(dev, fmt, ##__VA_ARGS__); \
+			dev_dbg(dev, "[err=%d]", _err); \
+		} \
+		_err; \
+	 })
+
 #endif
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c7..4a34afa81962 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,57 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
+static inline int dev_count_u32(const struct udevice *dev,
+					 const char *name)
+{
+	return dev_read_u32_array(dev, name, NULL, 0);
+}
+
+/* Linux compatibility */
+
+#define device_property_count_u32 dev_count_u32
+#define device_property_read_bool dev_read_bool
+#define device_property_read_u16 dev_read_u16
+#define device_property_read_u32_array dev_read_u32_array
+#define device_property_read_u32 dev_read_u32
+#define device_property_read_u8 dev_read_u8
+
+static inline int device_property_read_string(const struct udevice *dev,
+					      const char *propname,
+					      const char **val)
+{
+	*val = dev_read_string(dev, propname);
+	if (!*val)
+		return -ENOENT;
+	return 0;
+}
+
+static inline bool device_property_present(const struct udevice *dev,
+					   const char *propname)
+{
+	return (dev_read_size(dev, propname) > 0);
+}
+
+static inline int device_property_count_u8(const struct udevice *dev,
+					   const char *propname)
+{
+	return dev_read_size(dev, propname);
+}
+
+static inline int device_property_read_u8_array(const struct udevice *dev,
+						const char *propname,
+						u8 *out, size_t count)
+{
+	const u8 *ptr = dev_read_u8_array_ptr(dev, propname, count);
+
+	if (!ptr)
+		return -EINVAL;
+
+	memcpy(out, ptr, count);
+
+	return 0;
+}
+
 /**
  * dev_for_each_subnode() - Helper function to iterate through subnodes
  *
diff --git a/include/linux/compat.h b/include/linux/compat.h
index d4ba4d0088a0..16c02260c111 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -297,6 +297,7 @@ struct rw_semaphore { int i; };
 #define up_write(...)			do { } while (0)
 #define down_read(...)			do { } while (0)
 #define up_read(...)			do { } while (0)
+struct device_node;
 struct device {
 	struct device		*parent;
 	struct class		*class;
@@ -305,6 +306,7 @@ struct device {
 	/* This is used from drivers/usb/musb-new subsystem only */
 	void		*driver_data;	/* data private to the driver */
 	void            *device_data;   /* data private to the device */
+	struct device_node	*of_node; /* associated device tree node */
 };
 struct mutex { int i; };
 struct kernel_param { int i; };
@@ -402,4 +404,17 @@ typedef unsigned long dmaaddr_t;
 #define free_irq(irq, data) do {} while (0)
 #define request_irq(nr, f, flags, nm, data) 0
 
+/* From include/linux/reset.h */
+
+struct reset_control;
+
+static inline int reset_control_assert(struct reset_control *rstc)
+{
+	return 0;
+}
+
+static inline int reset_control_deassert(struct reset_control *rstc)
+{
+	return 0;
+}
 #endif
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 14b2c7eb2e63..de1d0c82076f 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -21,6 +21,13 @@ enum usb_phy_interface {
 	USBPHY_INTERFACE_MODE_HSIC,
 };
 
+/* associate a type with PHY */
+enum usb_phy_type {
+	USB_PHY_TYPE_UNDEFINED,
+	USB_PHY_TYPE_USB2,
+	USB_PHY_TYPE_USB3,
+};
+
 #if CONFIG_IS_ENABLED(DM_USB)
 /**
  * usb_get_phy_mode - Get phy mode for given device_node
@@ -37,4 +44,53 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
 }
 #endif
 
+struct usb_phy {
+	struct device		*dev;
+
+	/* initialize/shutdown the phy */
+	int     (*init)(struct usb_phy *x);
+	void    (*shutdown)(struct usb_phy *x);
+
+	/* enable/disable VBUS */
+	int     (*set_vbus)(struct usb_phy *x, int on);
+
+	/* effective for B devices, ignored for A-peripheral */
+	int     (*set_power)(struct usb_phy *x,
+			     unsigned mA);
+};
+
+static inline int
+usb_phy_init(struct usb_phy *x)
+{
+	if (x && x->init)
+		return x->init(x);
+
+	return 0;
+}
+
+static inline void
+usb_phy_shutdown(struct usb_phy *x)
+{
+	if (x && x->shutdown)
+		x->shutdown(x);
+}
+
+static inline int
+usb_phy_set_power(struct usb_phy *x, unsigned mA)
+{
+	if (!x)
+		return 0;
+
+	/* TODO usb_phy_set_charger_current(x, mA); */
+
+	if (x->set_power)
+		return x->set_power(x, mA);
+	return 0;
+}
+
+static inline int
+usb_phy_set_suspend(struct usb_phy *x, int suspend)
+{
+	return 0;
+}
 #endif /* __LINUX_USB_PHY_H */
-- 
2.53.0

