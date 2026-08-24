Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542D8C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FA4F607C4;
	Mon, 24 Aug 2026 16:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWTzXCbVorSa; Mon, 24 Aug 2026 16:45:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589931;
	bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1HeLhqjtdt0ORjf/mN5fDjC0Mn2kNsYYCDDJmL/CsMa54oE1Wgg5T9GL3Dso0iMB
	 T/csCaw/B2kUk8/uqSsWxMjopKz7qraQTadehIOXljX2/4XESYtHM4G19we+dAsg7N
	 BAn0a3qgz3hNM5N5pi6NIWYv1sNbn/7GgDQ0ypLbuM2GVuSZUE7tlwvpkbEwfuEzbw
	 ACsCOgMulyAnSQcwQ0qHXdPb6tjD2k/3hFM1BeotSE/wx1H+NOfGt3aVYperWEpIsM
	 NxMC9BHJYCcl49b3S5vIfqiKe42sGYuR1RFrCpJJeVf1osUA7ybtrNdHqQ0bRfe5My
	 bZ92PIL5+jxtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ECA260737;
	Mon, 24 Aug 2026 16:45:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0C23279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D32ED605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuBXIpr5Jto4 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=gggot7lb
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9620360626
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:08 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2193c18362so46587266b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586126; x=1788190926;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=gggot7lb2IRW3+9RHg+BI3kSUdHuzPU69frX0d0CjyXRDoSNHktd3bs/SMduzmGQXB
 S7q0wFnz8R24ryFIRH/EYGVI19Iy/WljwIic7xIZ9tt8pRA/0rKR6JNDCSmhUGFkzioQ
 BT7PBCvy3zHg7DwDlrnoL3FhCN8Kv9kloKy+6GJ7FsrfRaON81VTyMra0EdebpbqFSwk
 y01+b/jEfKETqQ2WLE2awqVQoigIE78dfyGas6hxSAxflLPxAWR4fGP5pyduzgWaeTCt
 +VJQg7c4c9l1xGvSFgzgP2X2FFJ4NN1jxxnzx/8OJwSWgBqJ0FXKsnnQOYVutYLExSnp
 M9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586126; x=1788190926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=F2sSPM3YSK1GWDlfbcN6MZyslOqdqtKf5H+i57WgcADfP6PySKwLbEySD1VTy2gCd3
 QRWL9ZUS00U+ZTfRcG6I0K1TVIV8ZJf6w8tWhyD/6czGiAXzsV1ZHbkXSD8tZBzY/gaO
 U9cyRPeu5wZ8dL9gI2D0RXniZFV1vtklqVgt9YXZKkmve/tPmFRE3B4HWXLxHc2Z2dGV
 WDMZ1PzbHwxaMi1YUcf5tPb/OZ4zUDgQgqTROpbXgW89E9ZJBMqxu9KNx/zBAYjTgZqc
 IYJb1X799zdfifRu1X9ZCqPx3cg/l1fbpWzsRnOwUdRHx9kM9aY7QedYSLzObXqZ7pAn
 OMyw==
X-Gm-Message-State: AFuF++lolawy+Uy/RxmMXJB5UcJ9o/mJkx+1R2NhWjyWJ/QieuLXG3d3
 HoIZsJfOsWqy/e7rIn8dfAzA7brGLMA97uTsy5WlWXR5YNr7qHfyCEGpBGbefvAchnQ58nfzP8m
 21s0/
X-Gm-Gg: AR+sD10aH7NApoGlMv68WwxRjmtgVg0C6eVZBtwhRP4PfWdrmjAzcEC/e3dx1+tV/Jo
 nNZ8ZJSfw6wPgPeA0xDUp3Xd8jSGcatnj4lIXHy7KifdLFZaK/3U3W3WdZnqyO5sTLYDx4ugFc2
 7v8c6/RzXbzAvpNjDCGHhvqy2qb+24USZSDvIdMnldAQVhvwMrJmOeI7XdxMQRkLjtiLR3hNCAp
 lDh7wgh5RDFmDJB6HQP+h2dD0iD4dZVnOpOBqmoTxFa5Be1NgM+0ulN8ghVumIhNDi3ygUSil5i
 Bi5o4IGrkzhk2cHo3FDICww8hH0ZDcGF3yfi83El8bK/uNzfF+4Nbia2WZf6fuHaGirMFjxxYYo
 8VZopgwkNC164EOPpZjZQEaW6zEu0cu5nxa8kOJmkg7cSxH1drcAdoVYxqLvR+25IDUpWQu1QgJ
 zqr2QpTElNyHjZvPaNrBnp0EJ1RhAn8du/OrJN3263pToKcqhHrMiaWGNMZau+Ib+gKfxN/hS49
 45QuBi7TajAkMm1R5S+SrS8KwedOF5O
X-Received: by 2002:a17:906:f59a:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c246a67540dmr1434362366b.2.1787586126544; 
 Mon, 24 Aug 2026 08:42:06 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:05 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 01/24] dm: add helpers needed by the resynced DWC3 code
Date: Mon, 24 Aug 2026 17:41:10 +0200
Message-ID: <20260824154133.217744-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

The resynced DWC3 code calls a few helpers that u-boot did not have.
Add them first so the next commits can use them.

These are not copies of kernel files. They are small u-boot versions of
the Linux v6.16 API that the DWC3 code expects:

- dev_err_probe() from include/linux/device.h.
- device_property_*() from include/linux/property.h. They are thin
  wrappers on the matching dev_read_*() calls.
- struct device gets an of_node member, so the kernel code that carries
  it around still compiles.
- reset_control_assert() and reset_control_deassert() from
  include/linux/reset.h, as empty stubs. u-boot has no reset_control of
  that shape. The DWC3 core only calls reset_control_assert() in
  dwc3_core_exit(), and dwc->reset is never set, because the glue driver
  handles the reset through the DM reset framework. So doing nothing is
  correct here.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/dm/device_compat.h | 13 ++++++++++
 include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h     | 15 +++++++++++
 3 files changed, 79 insertions(+)

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
index 12dcde6645c7..86c4933fd694 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,57 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
+static inline int dev_count_u32(const struct udevice *dev,
+				const char *name)
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
-- 
2.53.0

