Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C317BD16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF33689174;
	Mon, 14 Oct 2024 15:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XGZeZUxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D63B89151; Mon, 14 Oct 2024 15:12:47 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE808915D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d63a79bb6so1419635f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911565; x=1729516365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWAQpFWueEgDbwjBv1RENGFQDnhZkMaUF5NIWaewJKM=;
 b=XGZeZUxIsvyRC4Omm0TiDcR0unjv+Tv4Wd6zSex2txonOB48AFGp461yht1BawAFMg
 RsSVp9in/xMxkL/Nfbf8YKd+BacQz+s1bPQQnCfmXpF4hO5769XtxXEok0TKFCIxfM0r
 02Tj6KEz3cYsl7YKiP8CzQOrJcmgtODXkqVNAndBtP1B/ZB/Pto0LecMn2jrJxQMeNvs
 MMTgXn6J0ICL9wTWl9m3/5S58dNo56JtgybAL0gYf44w/AXX8vhCG7B/C+jm5aUO6/RD
 WH/tX6c0tWQMdVOY/MDHPnFlA3QExSq2z3a3ZZuH4FKtb6PyECbgcHjioUN2F7egc1dG
 cjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911565; x=1729516365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWAQpFWueEgDbwjBv1RENGFQDnhZkMaUF5NIWaewJKM=;
 b=VEGmv/HQKdH6j6lDNDGr5PANGkKv7rIWQtERTkjZW+ze15e0lM4Bh2zwkDyCpna14E
 AAryL74z6lurMUIugS07vCLmK6eGixSq9ZiuBSRBm3yj77UyvdqaEWK6g5TYhqOt1zVP
 LT8mTEcQ2sYrBB/eefht6dhISerRR7Tk+oGWIEejF/MF6OK9CSmcxQgFfZgy9mzlJqWt
 FtmN9QCTS4aseEuYu4uApWsoN7Qlb2WcmlchalxdCctNFiOuayNXrv/NNsUw2h66eg5Y
 XRyvXZvJVT7f00IuiHRYz3dNQGGl9rlwoDJSeKOIzDHrrLveh4iblGYhW853mQTtoxdu
 WJnw==
X-Gm-Message-State: AOJu0YyeGoeAd+EfsXGbBc0t8Oj8qCqg/jdrvDrLLjHwOBBD2TAZg94v
 NZbTWZj5aP8BAThrs+THaLFsg/g0qxP+e8gyGEtoirFbgLA01EB1zIypZAi+Nb0+I10QAhxUkQN
 +
X-Google-Smtp-Source: AGHT+IFx8UVDfd7DL3Nuy3aI584ayYBRVHzL+h0jimG+qaWVNRy4KwzI0SnhhFKlbn3mW9Qjbe+04g==
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id
 ffacd0b85a97d-37d551d5113mr7062933f8f.23.1728911564943; 
 Mon, 14 Oct 2024 06:12:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:44 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 22/37] drivers: misc: irq-uclass: Update irq_get_by_index
Date: Mon, 14 Oct 2024 15:10:38 +0200
Message-ID: <20241014131152.267405-23-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

Support reading the "interrupts" property from the devicetree in case
the "interrupts-extended" property isn't found. As the "interrupts"
property is commonly used, this allows to parse all existing FDT and
makes irq_get_by_index() more useful.

The "interrupts" property doesn't contain a phandle as "interrupts-extended"
does, so implement a new method to locate the interrupt-parent called
irq_get_interrupt_parent().

TEST: Read the interrupts from the GIC node for ACPI MADT generation.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/dts/test.dts |  3 ++
 drivers/misc/irq-uclass.c | 66 ++++++++++++++++++++++++++++++++++++++-
 include/irq.h             | 14 +++++++++
 test/dm/irq.c             | 15 +++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 8412506c17..9599a8db9c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -522,6 +522,9 @@
 	};
 
 	f-test {
+		#interrupt-cells = <2>;
+		interrupt-parent = <&irq>;
+		interrupts = <4 0>;
 		compatible = "denx,u-boot-fdt-test";
 	};
 
diff --git a/drivers/misc/irq-uclass.c b/drivers/misc/irq-uclass.c
index 79eb7c200d..068f67fe02 100644
--- a/drivers/misc/irq-uclass.c
+++ b/drivers/misc/irq-uclass.c
@@ -62,6 +62,40 @@ int irq_read_and_clear(struct irq *irq)
 	return ops->read_and_clear(irq);
 }
 
+int irq_get_interrupt_parent(const struct udevice *dev,
+			     struct udevice **interrupt_parent)
+{
+	struct ofnode_phandle_args phandle_args;
+	struct udevice *irq = NULL;
+	ofnode node;
+	int ret;
+
+	if (!dev || !interrupt_parent)
+		return -EINVAL;
+
+	*interrupt_parent = NULL;
+
+	node = dev_ofnode(dev);
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	while (ofnode_valid(node)) {
+		ret = ofnode_parse_phandle_with_args(node, "interrupt-parent",
+						     NULL, 0, 0, &phandle_args);
+		if (!ret && !device_get_global_by_ofnode(phandle_args.node, &irq))
+			break;
+		node = ofnode_get_parent(node);
+	}
+
+	if (!irq) {
+		log_err("Cannot find an interrupt parent for device %s\n", dev->name);
+		return -ENODEV;
+	}
+	*interrupt_parent = irq;
+
+	return 0;
+}
+
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 int irq_get_by_phandle(struct udevice *dev, const struct phandle_2_arg *cells,
 		       struct irq *irq)
@@ -142,10 +176,40 @@ err:
 int irq_get_by_index(struct udevice *dev, int index, struct irq *irq)
 {
 	struct ofnode_phandle_args args;
-	int ret;
+	struct udevice *interrupt_parent;
+	int ret, size, i;
+	const __be32 *list;
+	u32 count;
 
 	ret = dev_read_phandle_with_args(dev, "interrupts-extended",
 					 "#interrupt-cells", 0, index, &args);
+	if (ret) {
+		list = dev_read_prop(dev, "interrupts", &size);
+		if (!list)
+			return -ENOENT;
+
+		ret = irq_get_interrupt_parent(dev, &interrupt_parent);
+		if (ret)
+			return -ENODEV;
+		args.node = dev_ofnode(interrupt_parent);
+
+		if (dev_read_u32(dev, "#interrupt-cells", &count)) {
+			log_err("%s: could not get #interrupt-cells for %s\n",
+				__func__, dev->name);
+			return -ENOENT;
+		}
+
+		if (index * count >= size / sizeof(*list))
+			return -ENOENT;
+		if (count > OF_MAX_PHANDLE_ARGS)
+			count = OF_MAX_PHANDLE_ARGS;
+		args.args_count = count;
+		for (i = 0; i < count; i++)
+			args.args[i] = be32_to_cpup(&list[index * count + i]);
+
+		return irq_get_by_index_tail(ret, dev_ofnode(dev), &args,
+					     "interrupts", index, irq);
+	}
 
 	return irq_get_by_index_tail(ret, dev_ofnode(dev), &args,
 				     "interrupts-extended", index > 0, irq);
diff --git a/include/irq.h b/include/irq.h
index 5638c10128..0fbc1a5f48 100644
--- a/include/irq.h
+++ b/include/irq.h
@@ -200,6 +200,20 @@ int irq_restore_polarities(struct udevice *dev);
  */
 int irq_read_and_clear(struct irq *irq);
 
+/**
+ * irq_get_interrupt_parent() - returns the interrupt parent
+ *
+ * Walks the devicetree and returns the interrupt parent's ofnode
+ * for the specified device.
+ *
+ * @dev: device
+ * @interrupt_parent: The interrupt parent's ofnode'
+ * Return: 0 success, or error value
+ *
+ */
+int irq_get_interrupt_parent(const struct udevice *dev,
+			     struct udevice **interrupt_parent);
+
 struct phandle_2_arg;
 /**
  * irq_get_by_phandle() - Get an irq by its phandle information (of-platadata)
diff --git a/test/dm/irq.c b/test/dm/irq.c
index 836f2d82e7..ca3e188065 100644
--- a/test/dm/irq.c
+++ b/test/dm/irq.c
@@ -76,6 +76,21 @@ static int dm_test_request(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test of irq_get_by_index() */
+static int dm_test_irq_get_by_index(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct irq irq;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_TEST_FDT, "f-test",
+					      &dev));
+	ut_assertok(irq_get_by_index(dev, 0, &irq));
+	ut_asserteq(4, irq.id);
+
+	return 0;
+}
+DM_TEST(dm_test_irq_get_by_index, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test of irq_get_acpi() */
 static int dm_test_irq_get_acpi(struct unit_test_state *uts)
 {
-- 
2.46.2

