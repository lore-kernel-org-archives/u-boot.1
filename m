Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881CFCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7582F8935D;
	Wed, 23 Oct 2024 15:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LgFQRFOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF4D89350; Wed, 23 Oct 2024 15:29:18 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE17589355
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314b316495so66212525e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690150; x=1730294950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xmQLXC0uaRjKkSflpCjZv+x+pRgOIXGpr7RR9pIpyM=;
 b=LgFQRFOHdxTgVLpzn8tZvb3iLEMHVaSvBwu6F7HnKaO9xMp460E/WZNu3smFJeVhkY
 shbCA2KN2SbUBhSD0QC4t1LAWIvKJiNNKS+MyctgBelxE6OKbCQX4N2e0QjsWmuMlVPJ
 zcsZxP5qbKZNX/cqwPk3396wvNB2KEuI3UESuZ0fc6cubhQ6rD+9RXthCan7Gua5RA1D
 y07qiXmAa1nSQiqx9J6AUogDfTu7V5HB13C9FPgOY+AV5Z8UENBXlYAj0bZ1zmUZ6MUP
 g+ei3msLDjOIAQwB7eoufpzQ1ANEemus4VGsv3jOuPMZEeWvRUk2ggi9cjnuWawTSH0H
 thwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690150; x=1730294950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xmQLXC0uaRjKkSflpCjZv+x+pRgOIXGpr7RR9pIpyM=;
 b=cnJJBsnqxqxD6yRQZZujnqsdg5M5DRr9ddyynqrLYt/CdHM+qEOeB698OpqIL2TkEJ
 iSL2L8NeuzppZ0jmVNnGk37JroxcMd52TUspcwUtn9UPPYi/nbRKjgDDyTHZadcHYvk2
 VgFmKM5804BdChFS+5iTEk4P20BrckegTtF+NGoMtzBK+/jAfhjXugbtUbVY096crYPd
 PbHdUoH/cQt0vhm/V+KJ2AYL0433jzq34WBhxV02NYqp3YGiTngjn+1Trcrd6ybvr4JK
 k42Oyz6U0wfhUrl5JEN/PncvdX33rRbMFEeA1w1YQwPCH7+Mj0cPoZz1PqkUL7Lp9tUy
 d/RA==
X-Gm-Message-State: AOJu0YxSvNDYtTrMGea3vBKkj1d7xxRgdPdwMHsPbJW8yf6Zc9/py6Cn
 qeavSVoGsgHwVJX1puw2jSucxqrZVJzi3LHlWjW5A4nHr3BNolfQhk2+WiNGH7t624fPF99RA0x
 0
X-Google-Smtp-Source: AGHT+IH7emQV9/Zk0Ls1nUtVbYeUjNokMBoEZImr3L0u93OiSGptUtlVVW9/++7s8TAqPlvWzqkorA==
X-Received: by 2002:a05:6000:1b0e:b0:37d:3541:5643 with SMTP id
 ffacd0b85a97d-37efcf851f3mr1947101f8f.51.1729690150225; 
 Wed, 23 Oct 2024 06:29:10 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:09 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 22/37] drivers: misc: irq-uclass: Update irq_get_by_index
Date: Wed, 23 Oct 2024 15:20:05 +0200
Message-ID: <20241023132116.970117-23-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Moritz Fischer <moritzf@google.com>
---
Changelog v9:
- Read interrupt-cells from interrupt parent
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
index 79eb7c200d..ac778593c9 100644
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
+		if (dev_read_u32(interrupt_parent, "#interrupt-cells", &count)) {
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

