Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE400C5DF93
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 985EA40CE1;
	Fri, 21 Aug 2026 13:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3TnRUkULP4b; Fri, 21 Aug 2026 13:15:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318111;
	bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XrbqSNMKr8M1zteEyQpiWEUTsh0TnufJEGuUgdtF09Ho/eNipaEfG6yjxob71SJwu
	 PY2/DCr/xk2kGZ7LrpWK0XjqCuj9DYZNSRRuCbtVNFqE7KHd1NL7FyryFGZnM0nPCC
	 3UxKQwK2SsIn1X47b3oje5wFcmQIZ/P1d2VYVygFww7d4ACfWvxylA6kyiul2FqSPY
	 vAtw6BXeswmmJFr0th10V7/qt9HmFc9iUx5U//d5G+3cVYrmw+tBM4OXsclgIJ29Ib
	 koan7dna+k1TdQjInsfsfmZWSA96Ou+Zw/pGuxala88x8nl/l2nnZFsT5ofKukgp4T
	 GV0BqsJD52jaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82EC640D72;
	Fri, 21 Aug 2026 13:15:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42C80476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28F2340073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKp9MgSXL4Ms for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=gYJBzVjA
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 270F540071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:23 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69edc72e513so135367a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302341; x=1787907141;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=gYJBzVjAPnvEqtQrHnoMGYSStGbZbt5MDr6hTP0P3vIjZPUOIYs8CMxUvsw/o/+3Qx
 /NMDfav5G3zuYvi8hScuFAe3GmvQbjVUUdZOlsshy/lf3DG4YkXFMjvQ0OJy6P0A5Kzu
 H7lo+fPQWwJdmDJGhTxNcOI1oxbTFD662dpMJP4Dc7HbHpV2z1p5kEQO4W3GzaAKUDbo
 tDg9ZLqNS+VvR+8ZOpzJvj8pm/6U0JW7wvLGz4uXc2dinj5LSeRz3cvvKfgqoQ4OxOLu
 JKZBsKOfug6TccyM8GQYA5OkfnaYqm5JECUgnozoYYYR9LM+NDvIhX9eRPdTOVnudflH
 1vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302341; x=1787907141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=l9msIVlQSmLcGMqDpOYcKD5Aqs1LormZjiQctoDFtWdS+I1fPayfCFdwrgueO8PVvC
 4gbu9N7En3ddlCVpfX8onccT4PwQeKQTrCdBCDIb2E5Fnz1H+5hPPg95hLA0gbl4Blj7
 M7OFwYeG/1YyVD1IYlUurscRwfA5i6NkqGX1qJVRHnJ+D2dcO3QuZoGoDy0SoNN1TSHc
 iMGAO9rYVku++jME5dzKyxGzQXb0XPItcKPkoviesZtL1YCM8/zURW0N/AsaoxAJhdB6
 B2xMVCqVDBRivfBXHnU+5ctyUyiKxO7JhN37bLu5+LLBAtIWUxBGv3ZBTUBaX/L9toFS
 UIog==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYD76XubSavJu0pDDtKnvt8xQSWl6mz0qa8ZIcPr6o8do1Xmyf51sh1NUdQgsT+ZtoXzugVNE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m6yMEwdSs3ScR+HpEsx79IcrpFXwMVU40M0zk/E2lhmaoa8n5C
 FOH7CKdqaqOoQH8ZdTx9bYzOAcThXupnMzvYQV+0wHZelih1VLbsTBfoV5O/88C6778=
X-Gm-Gg: AR+sD12R+BWzDtb2Ji4Yrdjbc/kwp5G3QoGSAMn4iiGhPIGuo0mRbc0jZhIR/+oMfNU
 ElDNFWfmDmCOq3DZ09VtayuflhUr88PjK0XHpxNW5LBq9V921x0XBBFnqTdAd6R07m5Gc/aOS2F
 NmpFqPpR84Nji6FLzDmmR0+87w9cfdl12LN5Xdw3o9yChNDEPagZIogbud/YaboaP46w6p9QVII
 tm0vS4TjOCmBLxRigDGVYJIZlFIIh6XFCPst6ZYd/ucENfrNJ7WEAVKXl4yaVZm+ZWrWtGLxoc9
 LXqn3O5nM6Gc1ljIZYhm95zpK/QmmUBUMrRH5ThgdhgLLCK3Uxdu0gfImvNTYt/dz7ADHU4clNc
 l8Mi5B0D+ev8zkw6x70gISWggQE1RNlNEd8YYf8QgRAOU8yzyiVEH+pJZm8CVBtPIwOgSht4XS1
 l94Olgr3BFkaFbZ5UvERQS7P7UP0U/uJzAg23/NYiFyKhV4zDBh5wK+cphFEhzT9oqQcEOARRIT
 nNImFILq28b6a4lLfaEjEwh
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr2760387a12.0.1787302341094; 
 Fri, 21 Aug 2026 01:52:21 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3fec280e9sm5707054a12.0.2026.08.21.01.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:20 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 64/87] dm: add helpers needed by the resynced DWC3 code
Date: Fri, 21 Aug 2026 10:47:40 +0200
Message-ID: <20260821084829.2070426-65-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

