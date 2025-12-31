Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37EDEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF0B841B1;
	Wed, 31 Dec 2025 20:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Yg3NkZsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23EF84105; Wed, 31 Dec 2025 20:11:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF1D84183
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 899DF3F11B
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208276;
 bh=qr/0P1U54yEKUJ/r9FlmvoTfzqMSSADWq19z9AUuUu4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Yg3NkZsqEK4h5i6tbDNymt249Yf1UCPhvVM6ifJLJsa7EIp6Bn5gk67i+7zdb6/eY
 wm36u/+N1cPtBaU1OXMBBNswoArdF6p1YWhRGR9xKN2a8zQSCiAjmTHWHovba2eXZy
 DNfJQcXENnD4VGLAs1ke8s1x2sq/rf0L22U71+ZDgmSBijINECW96+l2Asi9CdMXAh
 X1D8dH6xu2zhFiwngYYFoaTY+XGvWlb4fdav6uwoqa/QfI09RV797wulKUJevwjVTz
 8+OPKnI4Yczxx9G+iysQCubOlYRilqJBR0SV4QL1ll4CRYK5YhSTR3qxsp65dXon2q
 8A6fRQ7sgrzrsAV2yZMozZK1jUnKAoAk7stA9BW2p+glPUiUGSw0WVTtlM48Q8tODk
 8RrzqABsoyMkPYMFSFnG1XxFX8HYOTVs+Z8tDPd1bo4FC1lh3veAO6suXGMS1tNne5
 txMspMwECluKFX3X9Vr03r4ST+I987T5egfMjKcI/X8fkWDLGwMnQNWKmpB3Yw5Dl2
 Sa5sfK6VQu7s3ZRCZDcayS4u0LHQyEZ7lXYG9SKfLdmCawlaR0fH5m6HAZ2xq33Gxd
 /FzOYdPTTjZNHqdOg6VzkxgHIIXYAFIObCV+mUJYKaIDX2JMWQyh0z/qnMGVhfafLe
 FIJB2LrbHvik8+Nk3RhHi4fg=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4327778efa9so3383647f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208276; x=1767813076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr/0P1U54yEKUJ/r9FlmvoTfzqMSSADWq19z9AUuUu4=;
 b=ezqJby/l25nQ2Ko0r4kEeGykiO0fVP3N6TzV2fgRivzMQISxZWJP0Slkf/cTVIgUPx
 XS5qpfKeTEvqMI5jHK0iOAId/9Thjf4O1OknMLXn0eCg1Lsu6hfFNreL3FSHoeZPLCCV
 RdTFHLnCr9LB2+KC+ZEZyKV+Y92gVv4OG8mqBI6g9NIlXrvowjpN9JcdElUMvm726QJO
 BL3CBx3wCMR1MYPROjA7KoEXSMH4oo3aMfUIPJJn2GanUtrGLl0dqmLKoBN/xGomJ/vF
 f/dGsbOdLwYx4KZsQVK6LvBs/Z9sPv/7/ClQ2xZqWfPaTPXPJyEKEtz2niwGbBSxXO4l
 SYnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURS4e7JeXA4MdnRP3ykKWELUBUgTU6eSMsrdMBH1ZHiP9t7va34QzLmHPhboyJ7xExbx7JYRQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy23gEjX0acXNM/YZGDq7K6MxDxDZdd4Tw57sLLfTGgFKvc+bvT
 jczZxrvUO7IXfRgj/zf7vMABfx6nPRZoPDLj8QKmDEEXhbwClDgXCSvGQmxsSQcP/qr0lNl6BCL
 98eicIB0NAFpHPL1kyerX5ulPwI60fv17qmQL+pyWI+bGZUMJekodLMBcORMfLndyH61OFWM=
X-Gm-Gg: AY/fxX50gBE9u2nRAhl0EZ5c14N3bDLWlt+OhGR4wXGGpiHksXr/Trjgemnxcc9o+mI
 0i57WKngbayTDb+nlVMSPO6+oBRLQ/31FPe5qogUiaDqjM87CfExoqbqOv249dsejeCqfAZviBr
 tcPdiRRmSbwfhjLar6GwQ5IhsZVRK84ml2xgaZJqfSXH0+Ng+RFGHen0lLb54CsEjvblcb5uvVw
 pTjxm/sSxCIp+Y+/p8c7K/TXIkCYX+MkpR+nbP2MqoVa0MK+AL5hVT5OJ0hKRR0hKAHqEY6eNrJ
 O4uWskm1IWrDYNJPLMxP8okDnZtIzJHGASO/Xe1AMzwKPZB09Eh/3I+4U+qBADwEji1CX07bURo
 LOMAS+zU5j3byYaZiCSF1ucNTh4yT4jShF6oVhJ3rJSr7hJMYQXXtN6eFwPpHZuICSn7QGk3tj9
 H5
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d1958a755mr485033165e9.21.1767208276144; 
 Wed, 31 Dec 2025 11:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtCljx7d4IFCjY0EnY2TFoZj897jYpVluQOjkKkj7bu3hxCq9lHNAeNDaZQY6+SCFZCFEWoQ==
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d1958a755mr485033015e9.21.1767208275764; 
 Wed, 31 Dec 2025 11:11:15 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm701685995e9.5.2025.12.31.11.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:11:15 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] dm: dummy implementations of live-tree functions
Date: Wed, 31 Dec 2025 20:10:54 +0100
Message-ID: <20251231191054.247270-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
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

We have opted to prefer 'if' over '#if' to more easily see problems in
contributed code.

When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the compiler does not
execute all optimization paths and references live-tree functions
even if CONFIG_$(PHASE_)OF_LIVE is not defined.

E.g. building qemu-riscv64_smode_defconfig with
CONFIG_CC_OPTIMIZE_FOR_DEBUG=y fails due to missing symbols.

Provide dummy implementation to allow debug builds.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/core/Makefile     |   6 +-
 drivers/core/nof_access.c | 246 ++++++++++++++++++++++++++++++++++++++
 drivers/core/nof_addr.c   |  37 ++++++
 3 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/nof_access.c
 create mode 100644 drivers/core/nof_addr.c

diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b..caa912f48ab 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -11,7 +11,11 @@ obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o
-obj-$(CONFIG_$(PHASE_)OF_LIVE) += of_access.o of_addr.o
+ifdef CONFIG_$(PHASE_)OF_LIVE
+obj-y += of_access.o of_addr.o
+else
+obj-y += nof_access.o nof_addr.o
+endif
 ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
diff --git a/drivers/core/nof_access.c b/drivers/core/nof_access.c
new file mode 100644
index 00000000000..08adba247f7
--- /dev/null
+++ b/drivers/core/nof_access.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file contains dummy function implementations that are only needed
+ * when compiling with -Og. In this case the optimizer does not remove
+ * function calls based on CONFIG_$(PHASE_)OF_LIVE.
+ */
+
+#include <dm/of_access.h>
+#include <linux/errno.h>
+
+int of_n_addr_cells(const struct device_node *np)
+{
+	return -ENOSYS;
+}
+
+int of_n_size_cells(const struct device_node *np)
+{
+	return -ENOSYS;
+}
+
+int of_simple_addr_cells(const struct device_node *np)
+{
+	return -ENOSYS;
+}
+
+int of_simple_size_cells(const struct device_node *np)
+{
+	return -ENOSYS;
+}
+
+struct property *of_find_property(const struct device_node *np,
+				  const char *name, int *lenp)
+{
+	return NULL;
+}
+
+struct device_node *of_find_all_nodes(struct device_node *prev)
+{
+	return NULL;
+}
+
+const void *of_get_property(const struct device_node *np, const char *name,
+			    int *lenp)
+{
+	return NULL;
+}
+
+const struct property *of_get_first_property(const struct device_node *np)
+{
+	return NULL;
+}
+
+const struct property *of_get_next_property(const struct device_node *np,
+					    const struct property *property)
+{
+	return NULL;
+}
+
+const void *of_get_property_by_prop(const struct device_node *np,
+				    const struct property *property,
+				    const char **name,
+				    int *lenp)
+{
+	return NULL;
+}
+
+int of_device_is_compatible(const struct device_node *device,
+			    const char *compat, const char *type,
+			    const char *name)
+{
+	return -ENOSYS;
+}
+
+bool of_device_is_available(const struct device_node *device)
+{
+	return false;
+}
+
+struct device_node *of_get_parent(const struct device_node *node)
+{
+	return NULL;
+}
+
+struct device_node *of_find_node_opts_by_path(struct device_node *root,
+					      const char *path,
+					      const char **opts)
+{
+	return NULL;
+}
+
+struct device_node *of_find_compatible_node(struct device_node *from,
+		const char *type, const char *compatible)
+{
+	return NULL;
+}
+
+struct device_node *of_find_node_by_prop_value(struct device_node *from,
+					       const char *propname,
+					       const void *propval, int proplen)
+{
+	return NULL;
+}
+
+struct device_node *of_find_node_by_phandle(struct device_node *root,
+					    phandle handle)
+{
+	return NULL;
+}
+
+int of_read_u8(const struct device_node *np, const char *propname, u8 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_read_u32(const struct device_node *np, const char *propname, u32 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_read_u32_array(const struct device_node *np, const char *propname,
+		      u32 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+
+int of_read_u32_index(const struct device_node *np, const char *propname,
+		      int index, u32 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+{
+	return -ENOSYS;
+}
+
+int of_property_match_string(const struct device_node *np, const char *propname,
+			     const char *string)
+{
+	return -ENOSYS;
+}
+
+int of_property_read_string_helper(const struct device_node *np,
+				   const char *propname, const char **out_strs,
+				   size_t sz, int skip)
+{
+	return -ENOSYS;
+}
+
+struct device_node *of_root_parse_phandle(struct device_node *root,
+					  const struct device_node *np,
+					  const char *phandle_name, int index)
+{
+	return NULL;
+}
+
+int of_root_parse_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cell_count, int index,
+				    struct of_phandle_args *out_args)
+{
+	return -ENOSYS;
+}
+
+int of_root_count_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cell_count)
+{
+	return -ENOSYS;
+}
+
+struct device_node *of_parse_phandle(const struct device_node *np,
+				     const char *phandle_name, int index)
+{
+	return NULL;
+}
+
+int of_parse_phandle_with_args(const struct device_node *np,
+			       const char *list_name, const char *cells_name,
+			       int cell_count, int index,
+			       struct of_phandle_args *out_args)
+{
+	return -ENOSYS;
+}
+
+int of_count_phandle_with_args(const struct device_node *np,
+			       const char *list_name, const char *cells_name,
+			       int cell_count)
+{
+	return -ENOSYS;
+}
+
+int of_alias_scan(void)
+{
+	return -ENOSYS;
+}
+
+int of_alias_get_id(const struct device_node *np, const char *stem)
+{
+	return -ENOSYS;
+}
+
+int of_alias_get_highest_id(const char *stem)
+{
+	return -ENOSYS;
+}
+
+struct device_node *of_get_stdout(void)
+{
+	return NULL;
+}
+
+int of_write_prop(struct device_node *np, const char *propname, int len,
+		  const void *value)
+{
+	return -ENOSYS;
+}
+
+int of_add_subnode(struct device_node *parent, const char *name, int len,
+		   struct device_node **childp)
+{
+	return -ENOSYS;
+}
+
+int of_remove_property(struct device_node *np, struct property *prop)
+{
+	return -ENOSYS;
+}
+
+int of_remove_node(struct device_node *to_remove)
+{
+	return -ENOSYS;
+}
diff --git a/drivers/core/nof_addr.c b/drivers/core/nof_addr.c
new file mode 100644
index 00000000000..8f619f9ec33
--- /dev/null
+++ b/drivers/core/nof_addr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file contains dummy function implementations that are only needed
+ * when compiling with -Og. In this case the optimizer does not remove
+ * function calls based on CONFIG_$(PHASE_)OF_LIVE.
+ */
+
+#include <dm/of_addr.h>
+#include <linux/errno.h>
+
+const __be32 *of_get_address(const struct device_node *dev, int index,
+			     u64 *size, unsigned int *flags)
+{
+	return NULL;
+}
+
+u64 of_translate_address(const struct device_node *dev, const __be32 *in_addr)
+{
+	return -ENOSYS;
+}
+
+u64 of_translate_dma_address(const struct device_node *dev, const __be32 *in_addr)
+{
+	return -ENOSYS;
+}
+
+int of_get_dma_range(const struct device_node *dev, phys_addr_t *cpu,
+		     dma_addr_t *bus, u64 *size)
+{
+	return -ENOSYS;
+}
+
+int of_address_to_resource(const struct device_node *dev, int index,
+			   struct resource *r)
+{
+	return -ENOSYS;
+}
-- 
2.51.0

