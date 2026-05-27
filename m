Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687BECD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5B084881;
	Wed, 27 May 2026 18:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nZ2RileS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357338488F; Wed, 27 May 2026 18:11:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A27C84837
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e61e251966so2142681a34.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898278; x=1780503078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAqrs8COW1VAOJLM2mcNZfiouaQzyT4JJcI7W17GQJA=;
 b=nZ2RileS17jzxMtyal2k37aTmR+Uwmio3cSOk91QWLwR1RK9hqAW+1aGK2aj0FuPvq
 yh3ooA6kKcUug2KKFBf7Wcv4pTMBn/QqL3m2yzM1YJJd23U+9yY61QvDh5QxNaVDluP+
 UUaMnbBGd+Ub1O+I5qHjwVtPDD/lcW1JTJMtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898278; x=1780503078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lAqrs8COW1VAOJLM2mcNZfiouaQzyT4JJcI7W17GQJA=;
 b=GYyHO9uZI8a8kJygBfZ3/uouAstQjE6GdKuQ53ObdBdvYKVojLwwjpTS8AM+6JuYgQ
 VuGHRlQJ7M2fnTgFHNEEpPdMn+zerm/BwFE03PfI2+uRGEe77MAUzXpUVW81tEz9UxA8
 cGHyFCG1ZRr8CvJ0wDykVVDFU7JxWhlRz7L/zsacZjlo1wtndVxzTts664kNmG5CoQ5K
 nWPkaOuGVhbSaoxzf4Paw/tCyqA+8iiG/P0Hv35QLfBKnIAQD5Hr0vJopsi4/L4iStvL
 pO1qvRSAD3A+LMt0soteMK5xRWq5ZGlJkd72ExCpaipS1BogUYL831Eyr4lc5QEdB38U
 pE3A==
X-Gm-Message-State: AOJu0Yxnjx5RZlQEVsm/gVAfXcz7Cs6sj/jO9HPR+PTrZ6WcV+QQMZAj
 7uxyqKdFAu2m4oMEAN2L8Fhe0ymSCZ4xLzj31yk9l7S9avMiElIe5XMWvj20VkoCafnp4ReACUH
 MBFjqH4uOvGK35g==
X-Gm-Gg: Acq92OGEiPjdEgyzlV8T6h3xFGicCsElgKKAXn9bp3TbXzlExhkOKufw8V4FiPpskZq
 99VnRym1s6PS4p/cgS71EEaI+vTc2TB1YMdHmi19fzVJD3JVxuSnydcyw8CFjmFUBBwB/NzM+ux
 QWMxO5ovsE3XYQaOoLMJ+zOGhjlHhLs0T2Qh3lhHmKcL4ESpvTlju2P4rvT6ycyZGgguFXnhRSM
 6+QlGAbzwWPe6FZPbbyrec9XP6DgxElUkJyGcCwgi3BBCAPLXdlCI3Y1l2UTe7w/3eym7GPt9mg
 1WGZksvMBRBlOqXL9FE7M25nqOTmAgLf3AACrnxUc351e4ApUQZoybTg8sJoJa0Csefx55OcCle
 JWqQpzBeMUZxlJ0pkUUzL9TES5Re5P+bZ1G5jfSy81zZPTfyCgPnuCwzRGh2jDtiMmeDirNIPDy
 BIep0eF7snNw9k42Q5Bi4hrxt8Z60e
X-Received: by 2002:a05:6830:7306:b0:7db:a8b7:c565 with SMTP id
 46e09a7af769-7e5ff02c891mr14581618a34.20.1779898277962; 
 Wed, 27 May 2026 09:11:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/13] virtio: Implement a proper sandbox emulator
Date: Wed, 27 May 2026 10:10:16 -0600
Message-ID: <20260527161033.3273795-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

The existing sandbox implementation of virtio only tests the basic API.
It is not able to provide a block device, for example.

Add a new implementation which operaties at a higher level. It makes use
of the existing MMIO driver to perform virtio operations.

This emulator-device should be the parent of a function-specific
emulator. That emulator uses this MMIO transport to communicate with the
controller:

  virtio-blk {
    compatible = "sandbox,virtio-blk-emul";

    mmio {
      compatible = "sandbox,virtio-emul";
    };
  };

A new UCLASS_VIRTIO_EMUL uclass is created for the child devices, which
implement the actual function (block device, random-number generator,
etc.)

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig                  |   1 +
 configs/tools-only_defconfig  |   1 +
 drivers/virtio/Kconfig        |   8 +
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/sandbox_emul.c | 325 ++++++++++++++++++++++++++++++++++
 drivers/virtio/sandbox_emul.h | 160 +++++++++++++++++
 include/dm/uclass-id.h        |   1 +
 7 files changed, 497 insertions(+)
 create mode 100644 drivers/virtio/sandbox_emul.c
 create mode 100644 drivers/virtio/sandbox_emul.h

diff --git a/arch/Kconfig b/arch/Kconfig
index e28e4c4bce7..86fe2943de9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -261,6 +261,7 @@ config SANDBOX
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_SANDBOX
+	imply VIRTIO_SANDBOX_EMUL
 	# Re-enable this when fully implemented
 	# imply VIRTIO_BLK
 	imply VIRTIO_NET
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 3b7eea55f77..aa9bd32e848 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -39,5 +39,6 @@ CONFIG_TIMER=y
 CONFIG_VIRTIO_MMIO=n
 CONFIG_VIRTIO_PCI=n
 CONFIG_VIRTIO_SANDBOX=n
+CONFIG_VIRTIO_SANDBOX_EMUL=n
 CONFIG_GENERATE_ACPI_TABLE=n
 CONFIG_TOOLS_MKEFICAPSULE=y
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 512ac376f18..858556fe802 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -54,6 +54,14 @@ config VIRTIO_SANDBOX
 	  This driver provides support for Sandbox implementation of virtio
 	  transport driver which is used for testing purpose only.
 
+config VIRTIO_SANDBOX_EMUL
+	bool "Sandbox MMIO emulator for virtio devices"
+	depends on SANDBOX
+	select VIRTIO
+	help
+	  This driver provides an MMIO interface to an emulation of a block
+	  device. It is used for testing purpose only.
+
 config VIRTIO_NET
 	bool "virtio net driver"
 	depends on VIRTIO && NETDEVICES
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4c63a6c6904..d928c7b0ad2 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci_modern.o
 obj-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
 obj-$(CONFIG_VIRTIO_SANDBOX) += virtio_sandbox.o
+obj-$(CONFIG_VIRTIO_SANDBOX_EMUL) += sandbox_emul.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
diff --git a/drivers/virtio/sandbox_emul.c b/drivers/virtio/sandbox_emul.c
new file mode 100644
index 00000000000..673575806ac
--- /dev/null
+++ b/drivers/virtio/sandbox_emul.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VirtIO Sandbox emulator, for testing purpose only. This emulates the QEMU
+ * side of virtio, using the MMIO driver and handling any accesses
+ *
+ * This handles traffic from the virtio_ring
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
+#include <dm.h>
+#include <malloc.h>
+#include <virtio.h>
+#include <asm/io.h>
+#include <asm/state.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include "sandbox_emul.h"
+#include "virtio_types.h"
+#include "virtio_blk.h"
+#include "virtio_internal.h"
+#include "virtio_mmio.h"
+#include "virtio_ring.h"
+
+enum {
+	MMIO_SIZE		= 0x200,
+	VENDOR_ID		= 0xf003,
+	DEVICE_ID		= VIRTIO_ID_BLOCK,
+	DISK_SIZE_MB		= 16,
+};
+
+/* Replace the low 32 bits of @v with @val, keeping the high 32 bits */
+static u64 set_low32(u64 v, u32 val)
+{
+	return (v & GENMASK_ULL(63, 32)) | val;
+}
+
+/* Replace the high 32 bits of @v with @val, keeping the low 32 bits */
+static u64 set_high32(u64 v, u32 val)
+{
+	return (v & GENMASK_ULL(31, 0)) | ((u64)val << 32);
+}
+
+void process_queue(struct udevice *emul_dev, struct sandbox_emul_priv *priv,
+		   uint32_t queue_idx)
+{
+	struct virtio_emul_ops *ops = virtio_emul_get_ops(emul_dev);
+	bool processed_something = false;
+	struct virtio_emul_queue *q;
+	struct vring_avail *avail;
+	struct vring_desc *desc;
+	struct vring_used *used;
+	uint old_used_idx;
+
+	if (queue_idx >= priv->num_queues)
+		return;
+	log_debug("Notified on queue %u\n", queue_idx);
+
+	q = &priv->queues[queue_idx];
+	if (!q->ready)
+		return;
+
+	desc = (struct vring_desc *)q->desc_addr;
+	avail = (struct vring_avail *)q->avail_addr;
+	used = (struct vring_used *)q->used_addr;
+	old_used_idx = used->idx;
+
+	while (q->last_avail_idx != avail->idx) {
+		uint ring_idx = q->last_avail_idx % q->num;
+		uint desc_head_idx = avail->ring[ring_idx];
+		uint used_ring_idx;
+		int len;
+		int ret;
+
+		processed_something = true;
+		log_debug("Found request at avail ring index %u (desc head %u)\n",
+			  ring_idx, desc_head_idx);
+
+		ret = ops->process_request(emul_dev, desc, desc_head_idx, &len);
+		if (ret)
+			log_warning("Failed to process request (err=%dE)\n",
+				    ret);
+
+		used_ring_idx = used->idx % q->num;
+		used->ring[used_ring_idx].id = desc_head_idx;
+		used->ring[used_ring_idx].len = len;
+		used->idx++;
+		q->last_avail_idx++;
+	}
+
+	if (processed_something) {
+		bool needs_interrupt = true;
+
+		log_debug("finished processing, new used_idx is %d.\n",
+			  used->idx);
+		if (priv->driver_features & BIT(VIRTIO_RING_F_EVENT_IDX)) {
+			struct {
+				struct vring_avail *avail;
+				unsigned int num;
+			} vr;
+
+			vr.avail = avail;
+			vr.num = q->num;
+
+			needs_interrupt =
+				 vring_need_event(vring_used_event((&vr)),
+						  used->idx, old_used_idx);
+			log_debug("EVENT_IDX is enabled; driver wants event "
+				  "at %u needs_interrupt %d\n",
+				  vring_used_event(&vr), needs_interrupt);
+		}
+
+		if (needs_interrupt) {
+			log_debug("sending VRING interrupt\n");
+			priv->interrupt_status |= VIRTIO_MMIO_INT_VRING;
+		}
+	}
+}
+
+long h_read(void *ctx, const void *addr, enum sandboxio_size_t size)
+{
+	struct udevice *dev = ctx;
+	struct udevice *emul_dev = dev_get_parent(dev);
+	struct sandbox_emul_priv *priv = dev_get_priv(dev);
+	ulong offset = (ulong)addr - (ulong)priv->mmio.base;
+	struct virtio_emul_ops *ops = virtio_emul_get_ops(emul_dev);
+	struct virtio_emul_queue *q;
+	u32 val = 0;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		ulong config_offset = offset - VIRTIO_MMIO_CONFIG;
+		int ret;
+
+		ret = ops->get_config(emul_dev, config_offset, &val, size);
+		if (ret)
+			log_warning("Failed to process request (err=%dE)\n",
+				    ret);
+		return val;
+	}
+
+	if (priv->queue_sel >= priv->num_queues) {
+		log_debug("invalid queue_sel %d\n", priv->queue_sel);
+		return 0;
+	}
+	q = &priv->queues[priv->queue_sel];
+
+	switch (offset) {
+	case VIRTIO_MMIO_MAGIC_VALUE:
+		return ('v' | 'i' << 8 | 'r' << 16 | 't' << 24);
+	case VIRTIO_MMIO_VERSION:
+		return 2;
+	case VIRTIO_MMIO_DEVICE_ID:
+		return ops->get_device_id(emul_dev);
+	case VIRTIO_MMIO_VENDOR_ID:
+		return VENDOR_ID;
+	case VIRTIO_MMIO_DEVICE_FEATURES:
+		return !priv->features_sel ?
+			lower_32_bits(priv->features) :
+			upper_32_bits(priv->features);
+	case VIRTIO_MMIO_QUEUE_NUM_MAX:
+		return QUEUE_MAX_SIZE;
+	case VIRTIO_MMIO_QUEUE_READY:
+		return q->ready;
+	case VIRTIO_MMIO_INTERRUPT_STATUS:
+		return priv->interrupt_status;
+	case VIRTIO_MMIO_STATUS:
+		return priv->status;
+	case VIRTIO_MMIO_QUEUE_DESC_LOW:
+		return lower_32_bits(q->desc_addr);
+	case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+		return upper_32_bits(q->desc_addr);
+	case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+		return lower_32_bits(q->avail_addr);
+	case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+		return upper_32_bits(q->avail_addr);
+	case VIRTIO_MMIO_QUEUE_USED_LOW:
+		return lower_32_bits(q->used_addr);
+	case VIRTIO_MMIO_QUEUE_USED_HIGH:
+		return upper_32_bits(q->used_addr);
+	case VIRTIO_MMIO_CONFIG_GENERATION:
+		return priv->config_generation;
+	default:
+		log_debug("unhandled read from offset 0x%lx\n", offset);
+		return 0;
+	}
+}
+
+void h_write(void *ctx, void *addr, unsigned int val,
+	     enum sandboxio_size_t size)
+{
+	struct udevice *dev = ctx;
+	struct udevice *emul_dev = dev_get_parent(dev);
+	struct sandbox_emul_priv *priv = dev_get_priv(dev);
+	ulong offset = (ulong)addr - (ulong)priv->mmio.base;
+	struct virtio_emul_queue *q;
+
+	if (offset >= VIRTIO_MMIO_CONFIG)
+		return;
+
+	if (priv->queue_sel >= priv->num_queues &&
+	    offset != VIRTIO_MMIO_QUEUE_SEL)
+		return;
+	q = &priv->queues[priv->queue_sel];
+
+	switch (offset) {
+	case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
+		priv->features_sel = val;
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES:
+		if (priv->features_sel == 0)
+			priv->driver_features = set_low32(priv->driver_features,
+							  val);
+		else
+			priv->driver_features = set_high32(priv->driver_features,
+							   val);
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
+		priv->features_sel = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_SEL:
+		if (val < priv->num_queues)
+			priv->queue_sel = val;
+		else
+			log_debug("tried to select invalid queue %u\n", val);
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM:
+		q->num = (val > 0 && val <= QUEUE_MAX_SIZE) ? val : 0;
+		break;
+	case VIRTIO_MMIO_QUEUE_READY:
+		q->ready = val & 0x1;
+		break;
+	case VIRTIO_MMIO_QUEUE_NOTIFY:
+		process_queue(emul_dev, priv, val);
+		break;
+	case VIRTIO_MMIO_INTERRUPT_ACK:
+		priv->interrupt_status &= ~val;
+		break;
+	case VIRTIO_MMIO_STATUS:
+		priv->status = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_LOW:
+		q->desc_addr = set_low32(q->desc_addr, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+		q->desc_addr = set_high32(q->desc_addr, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+		q->avail_addr = set_low32(q->avail_addr, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+		q->avail_addr = set_high32(q->avail_addr, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_LOW:
+		q->used_addr = set_low32(q->used_addr, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_HIGH:
+		q->used_addr = set_high32(q->used_addr, val);
+		break;
+	default:
+		log_debug("unhandled write to offset 0x%lx\n", offset);
+		break;
+	}
+}
+
+static int sandbox_emul_of_to_plat(struct udevice *dev)
+{
+	struct udevice *emul_dev = dev_get_parent(dev);
+	struct virtio_emul_ops *ops = virtio_emul_get_ops(emul_dev);
+	struct sandbox_emul_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* set up the MMIO base so that virtio_mmio_probe() can find it */
+	priv->mmio.base = memalign(SZ_4K, MMIO_SIZE);
+	if (!priv->mmio.base)
+		return -ENOMEM;
+
+	ret = sandbox_mmio_add(priv->mmio.base, MMIO_SIZE, h_read, h_write,
+			       dev);
+	if (ret) {
+		free(priv->mmio.base);
+		return log_msg_ret("sep", ret);
+	}
+
+	priv->num_queues = MAX_VIRTIO_QUEUES;
+	priv->features = BIT(VIRTIO_F_VERSION_1) |
+		BIT(VIRTIO_RING_F_EVENT_IDX) | ops->get_features(emul_dev);
+
+	log_debug("sandbox virtio emulator, mmio %p\n", priv->mmio.base);
+
+	return 0;
+}
+
+static int sandbox_emul_remove(struct udevice *dev)
+{
+	sandbox_mmio_remove(dev);
+
+	return 0;
+}
+
+static const struct udevice_id virtio_sandbox2_ids[] = {
+	{ .compatible = "sandbox,virtio-emul" },
+	{ }
+};
+
+U_BOOT_DRIVER(virtio_emul) = {
+	.name	= "virtio-emul",
+	.id	= UCLASS_VIRTIO,
+	.of_match = virtio_sandbox2_ids,
+	.probe	= virtio_mmio_probe,
+	.remove	= sandbox_emul_remove,
+	.ops	= &virtio_mmio_ops,
+	.of_to_plat	= sandbox_emul_of_to_plat,
+	.priv_auto	= sizeof(struct sandbox_emul_priv),
+};
+
+UCLASS_DRIVER(virtio_emul) = {
+	.name	= "virtio_emul",
+	.id	= UCLASS_VIRTIO_EMUL,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.post_bind	= dm_scan_fdt_dev,
+#endif
+};
diff --git a/drivers/virtio/sandbox_emul.h b/drivers/virtio/sandbox_emul.h
new file mode 100644
index 00000000000..e206cac3994
--- /dev/null
+++ b/drivers/virtio/sandbox_emul.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * VirtIO Sandbox emulator, for testing purpose only. This emulates the QEMU
+ * side of virtio, using the MMIO driver and handling any accesses
+ *
+ * This handles traffic from the virtio_ring
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __SANDBOX_EMUL_H
+#define __SANDBOX_EMUL_H
+
+#include "virtio_mmio.h"
+#include "virtio_types.h"
+
+enum sandboxio_size_t;
+struct udevice;
+struct vring_desc;
+
+enum {
+	MAX_VIRTIO_QUEUES	= 8,
+	QUEUE_MAX_SIZE		= 256,
+};
+
+/**
+ * struct virtio_emul_queue - Emulator's state for a single virtqueue
+ *
+ * Mirrors the per-queue configuration the driver programs through the
+ * MMIO transport (VIRTIO_MMIO_QUEUE_*) plus the device-side state needed
+ * to consume the driver's requests.
+ *
+ * @num: Queue size, in descriptors. Driver writes via VIRTIO_MMIO_QUEUE_NUM
+ *	and must be <= %QUEUE_MAX_SIZE
+ * @ready: Non-zero once the driver has marked this queue as ready for use
+ *	(VIRTIO_MMIO_QUEUE_READY). Reset to zero on device reset
+ * @desc_addr: Guest-physical address of the descriptor table for this queue
+ * @avail_addr: Guest-physical address of the available ring
+ * @used_addr: Guest-physical address of the used ring
+ * @last_avail_idx: Index into the available ring of the next request the
+ *	device will consume. Advanced each time process_queue() handles a
+ *	descriptor chain
+ */
+struct virtio_emul_queue {
+	__virtio32 num;
+	__virtio32 ready;
+	__virtio64 desc_addr;
+	__virtio64 avail_addr;
+	__virtio64 used_addr;
+	__virtio16 last_avail_idx;
+};
+
+/**
+ * struct sandbox_emul_priv - Private info for the emulator
+ *
+ * Holds the per-device state that backs an emulated virtio MMIO transport.
+ * The MMIO callbacks h_read() / h_write() update these fields in response
+ * to driver accesses to the VIRTIO_MMIO_* register window.
+ *
+ * @mmio: Embedded virtio_mmio_priv used to share book-keeping (the MMIO
+ *	base in particular) with the regular virtio-mmio driver
+ * @num_queues: Number of virtqueues this device exposes; queues[] is valid
+ *	up to this index
+ * @queue_sel: Driver-selected queue index (VIRTIO_MMIO_QUEUE_SEL); names
+ *	which entry of queues[] subsequent QUEUE_* accesses refer to
+ * @status: Device status byte (VIRTIO_MMIO_STATUS), as written by the
+ *	driver during feature negotiation and bring-up
+ * @features_sel: Which 32-bit half of the 64-bit feature word the driver
+ *	is currently reading or writing (VIRTIO_MMIO_DEVICE_FEATURES_SEL /
+ *	DRIVER_FEATURES_SEL); 0 selects bits 0..31, 1 selects bits 32..63
+ * @features: Feature bits the device offers (read by the driver via
+ *	VIRTIO_MMIO_DEVICE_FEATURES)
+ * @driver_features: Feature bits the driver has acknowledged (written via
+ *	VIRTIO_MMIO_DRIVER_FEATURES); the negotiated set is the intersection
+ *	with @features
+ * @interrupt_status: Pending interrupt-cause bits (VIRTIO_MMIO_INT_*),
+ *	OR'd in when the device wants to interrupt and cleared by the driver
+ *	through VIRTIO_MMIO_INTERRUPT_ACK
+ * @config_generation: Counter exposed via VIRTIO_MMIO_CONFIG_GENERATION;
+ *	the driver re-reads the config space whenever this value changes
+ * @queues: Per-virtqueue state; only the first @num_queues entries are in
+ *	use
+ */
+struct sandbox_emul_priv {
+	struct virtio_mmio_priv mmio;
+	int num_queues;
+	int queue_sel;
+	u32 status;
+	u64 features_sel;
+	u64 features;
+	u64 driver_features;
+	u32 interrupt_status;
+	u32 config_generation;
+	struct virtio_emul_queue queues[MAX_VIRTIO_QUEUES];
+};
+
+/**
+ * struct virtio_emul_ops - Operations for a virtio device emulator
+ *
+ * Each device-type emulator (block, RNG, ...) provides these callbacks. The
+ * transport layer in sandbox_emul.c invokes them in response to driver
+ * activity on the MMIO window: process_request() when the driver notifies a
+ * queue, and the config / feature / device-id accessors when the driver probes
+ * the device.
+ *
+ * @process_request: Handle one descriptor chain from a virtqueue
+ * @get_config: Read from the device-specific configuration space
+ * @get_features: Return the device-specific feature bits
+ * @get_device_id: Return the virtio device ID for this emulator
+ */
+struct virtio_emul_ops {
+	/**
+	 * process_request() - Handles a single request from the driver
+	 *
+	 * @dev: The emulator device
+	 * @descs: Pointer to the virtqueue's descriptor table
+	 * @head_idx: The index of the first descriptor in the chain for this
+	 *	request
+	 * @lenp: Returns the total number of bytes written by the device into
+	 *	the driver's buffers (e.g. for a read request and the status
+	 *	byte). This is what will be placed in the `len` field of the
+	 *	used ring element.
+	 * @return 0 on success, negative on error.
+	 */
+	int (*process_request)(struct udevice *dev, struct vring_desc *descs,
+			       u32 head_idx, int *lenp);
+
+	/**
+	 * get_config() - Reads from the device-specific configuration space
+	 *
+	 * @dev: The emulator device
+	 * @offset: The byte offset into the configuration space to read from
+	 * @buf: The buffer to copy the configuration data into
+	 * @size: The number of bytes to read
+	 * @return 0 on success, negative on error.
+	 */
+	int (*get_config)(struct udevice *dev, ulong offset, void *buf,
+			  enum sandboxio_size_t size);
+
+	/**
+	 * get_features() - Returns the device-specific feature bits
+	 *
+	 * @dev: The emulator device
+	 * @return A bitmask of the device-specific features to be OR'd with
+	 *	the transport features.
+	 */
+	u64 (*get_features)(struct udevice *dev);
+
+	/**
+	 * get_device_id() - Returns the virtio device ID
+	 *
+	 * @dev: The emulator device
+	 * @return The virtio device ID for this emulator
+	 */
+	u32 (*get_device_id)(struct udevice *dev);
+};
+
+#define virtio_emul_get_ops(dev) ((struct virtio_emul_ops *)(dev)->driver->ops)
+
+#endif
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304..b3458065e04 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -34,6 +34,7 @@ enum uclass_id {
 	UCLASS_PCI_EMUL_PARENT,	/* parent for PCI device emulators */
 	UCLASS_USB_EMUL,	/* sandbox USB bus device emulator */
 	UCLASS_AXI_EMUL,	/* sandbox AXI bus device emulator */
+	UCLASS_VIRTIO_EMUL,	/* Emulator for a virtIO transport device */
 
 	/* U-Boot uclasses start here - in alphabetical order */
 	UCLASS_ACPI_PMC,	/* (x86) Power-management controller (PMC) */
-- 
2.43.0

