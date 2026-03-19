Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D31091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E79B83FD9;
	Thu, 19 Mar 2026 22:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dq0dM3My";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442EF83FD9; Thu, 19 Mar 2026 22:36:47 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703B98405B
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d74c1157a4so935185a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956197; x=1774560997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgprCzNfT7uLW+BfAoIWuGFRvyHiBmNweOqmL0S5RYM=;
 b=Dq0dM3MySqyPNY9uXWyf7iWNMXGfIytZf6J3GSK00OzvVw/Cb+QXo9VXRR1yZCFzam
 talBqPYUd3qEemRHxTdy0cy2iQOgKdEbt52gsCfG2u/S4KbsjbL2mJXNR9nrrAQNC6bS
 cCiog0rw0WjRh1AmXMYytnnjTaP8Px5vtIL2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956197; x=1774560997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qgprCzNfT7uLW+BfAoIWuGFRvyHiBmNweOqmL0S5RYM=;
 b=gwPj8ciGm3Nx9Vmfq6hlDXmW53Mz3XzOTgI/cEkhc7p7mWi675WXWREvRvSwBiB64f
 Lzuelxud1PKxo7yy2SxVc1w2IfmxTYOsveHgQ1y6ASi5YIBWx1mJv/OSIXMbNu80HCTA
 gCYyuOU8Vsu6b67HCChEjVhXOGxRk7WRUviLGaNgJLZHecHKZFdbZiQWIoFl2PiTzJwF
 wnSDI99x8MBjM3/AwAaTL9ItQ56irCyfXaa8vai5JuwrF5LlEwIeMvPKwfv6pI33H4X9
 xhSvr6+v9IaqxJlJYjvlvr1D2ubTzwUx/KVmOziHWBePmBvwafmEPSn0AAbcUxbdrnrx
 lqDQ==
X-Gm-Message-State: AOJu0YxcxbOQpY3Lf/YxbExoERzeENyYFyKXbGD2rGbBUgJP1OgPTRmQ
 /oYZVHcEgvmvyFPO4N4dqkoNSWUHhV3lBEz0LVEJsqE8yeypRjprTC2MZzSgzMmMbT8MU6BjcAU
 hcJwJRVOa
X-Gm-Gg: ATEYQzxgWzbsEmjZmTCAo/WONiTMjl1WtcFl7KgV5i7bPkofDACExW45k+uTv1Be1LW
 7scOsDq7gFUCnEm3RTZZhcVdT2QTy+uctAbB3JPxKmPLVuAuqK9BIGqaA0oALDOcJlkpAEZR/Ub
 alLmJjjFAygwLsLWJeEe8flTWG+W9JLjVFHM+2k5uXWJCvGbrGcAQJgnKpY6BSe0fgGUTGWwiNc
 PtTRp9IbOP+XwwfCMphuC49LOcfN5Eyju1AN+eejPOVN1UpjKH0txMGACPYkrkPz7xjDshn/q3H
 TCqosc3gZ964AxVE7/k8TFuqFYnZ4QRQjtfl56HilORQgdsCuRSXzK6EYWnCPNKjK8+IwG7naCD
 z/p3OGmfbdJnPHF6nq3aiX8uSf3VlRY+6zbpP6EBVZivvToWVyL5DOjjhFOMvlIWq5Fdb+ANhG2
 SUHnn5g1IkWLK7S5kmAA==
X-Received: by 2002:a05:6830:3149:b0:7d7:cf70:55fa with SMTP id
 46e09a7af769-7d7eaf9a798mr547057a34.22.1773956197238; 
 Thu, 19 Mar 2026 14:36:37 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH 04/15] dm: Rename uclass to uclass_ and add an accessor
Date: Thu, 19 Mar 2026 15:35:34 -0600
Message-ID: <20260319213551.267031-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

Rename the uclass field in struct udevice to uclass_ to match the
trailing-underscore convention used by other internal fields such as
seq_ and flags_

Add a dev_uclass() accessor for use outside driver model itself. The
driver-model core files are left alone, since they are part of the
implementation.

Update dtoc to generate the new field name, and update all callers
throughout the tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |  8 ++++----
 cmd/w1.c                                      |  4 ++--
 drivers/core/device-remove.c                  |  4 ++--
 drivers/core/device.c                         | 20 +++++++++----------
 drivers/core/dump.c                           |  2 +-
 drivers/core/read.c                           |  2 +-
 drivers/core/uclass.c                         | 20 +++++++++----------
 drivers/mmc/octeontx_hsmmc.c                  |  2 +-
 drivers/pci/pci-emul-uclass.c                 |  4 ++--
 drivers/pinctrl/pinctrl-uclass.c              |  2 +-
 drivers/spi/spi-uclass.c                      |  4 ++--
 drivers/usb/host/ehci-mx6.c                   |  2 +-
 drivers/usb/host/usb-uclass.c                 |  2 +-
 drivers/video/video-uclass.c                  |  4 ++--
 include/dm/device-internal.h                  |  2 +-
 include/dm/device.h                           |  9 +++++++--
 include/dm/read.h                             |  2 +-
 lib/efi_loader/efi_device_path.c              |  4 ++--
 net/eth-uclass.c                              |  2 +-
 test/dm/bus.c                                 | 12 +++++------
 test/dm/test-uclass.c                         |  2 +-
 tools/dtoc/dtb_platdata.py                    |  2 +-
 tools/dtoc/test_dtoc.py                       | 14 ++++++-------
 23 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a1..9563d655583 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -48,7 +48,7 @@ static int rk3288_noc_bind_of_plat(struct udevice *dev)
 {
 	struct rockchip_rk3288_noc_plat *plat = dev_get_plat(dev);
 	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
+	int size = dev_uclass(dev)->uc_drv->per_device_auto;
 
 	if (size && !priv) {
 		priv = calloc(1, size);
@@ -68,7 +68,7 @@ static int rk3288_grf_bind_of_plat(struct udevice *dev)
 {
 	struct rockchip_rk3288_grf_plat *plat = dev_get_plat(dev);
 	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
+	int size = dev_uclass(dev)->uc_drv->per_device_auto;
 
 	if (size && !priv) {
 		priv = calloc(1, size);
@@ -88,7 +88,7 @@ static int rk3288_sgrf_bind_of_plat(struct udevice *dev)
 {
 	struct rockchip_rk3288_sgrf_plat *plat = dev_get_plat(dev);
 	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
+	int size = dev_uclass(dev)->uc_drv->per_device_auto;
 
 	if (size && !priv) {
 		priv = calloc(1, size);
@@ -108,7 +108,7 @@ static int rk3288_pmu_bind_of_plat(struct udevice *dev)
 {
 	struct rockchip_rk3288_pmu_plat *plat = dev_get_plat(dev);
 	struct syscon_uc_info *priv = dev_get_uclass_priv(dev);
-	int size = dev->uclass->uc_drv->per_device_auto;
+	int size = dev_uclass(dev)->uc_drv->per_device_auto;
 
 	if (size && !priv) {
 		priv = calloc(1, size);
diff --git a/cmd/w1.c b/cmd/w1.c
index e462e786a96..96b7a7f2902 100644
--- a/cmd/w1.c
+++ b/cmd/w1.c
@@ -31,7 +31,7 @@ static int w1_bus(void)
 		ret = device_probe(dev);
 
 		printf("\t%s (%d) uclass %s : ", dev->name, dev_seq(dev),
-		       dev->uclass->uc_drv->name);
+		       dev_uclass(dev)->uc_drv->name);
 
 		if (ret)
 			printf("device error\n");
@@ -85,7 +85,7 @@ static int w1_read(int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	}
 
-	if (strcmp(dev->uclass->uc_drv->name, "w1_eeprom")) {
+	if (strcmp(dev_uclass(dev)->uc_drv->name, "w1_eeprom")) {
 		printf("the device present on the interface is of unknown device class\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 557afb8d817..b532855621d 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -137,7 +137,7 @@ void device_free(struct udevice *dev)
 		free(dev_get_priv(dev));
 		dev_set_priv(dev, NULL);
 	}
-	size = dev->uclass->uc_drv->per_device_auto;
+	size = dev->uclass_->uc_drv->per_device_auto;
 	if (size) {
 		free(dev_get_uclass_priv(dev));
 		dev_set_uclass_priv(dev, NULL);
@@ -145,7 +145,7 @@ void device_free(struct udevice *dev)
 	if (dev->parent) {
 		size = dev->parent->driver->per_child_auto;
 		if (!size)
-			size = dev->parent->uclass->uc_drv->per_child_auto;
+			size = dev->parent->uclass_->uc_drv->per_child_auto;
 		if (size) {
 			free(dev_get_parent_priv(dev));
 			dev_set_parent_priv(dev, NULL);
diff --git a/drivers/core/device.c b/drivers/core/device.c
index a55fdb1628f..fe4b23b141b 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -78,7 +78,7 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	dev_set_ofnode(dev, node);
 	dev->parent = parent;
 	dev->driver = drv;
-	dev->uclass = uc;
+	dev->uclass_ = uc;
 
 	dev->seq_ = -1;
 	if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
@@ -146,7 +146,7 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	if (parent) {
 		size = parent->driver->per_child_plat_auto;
 		if (!size)
-			size = parent->uclass->uc_drv->per_child_plat_auto;
+			size = parent->uclass_->uc_drv->per_child_plat_auto;
 		if (size) {
 			dev_or_flags(dev, DM_FLAG_ALLOC_PARENT_PDATA);
 			ptr = calloc(1, size);
@@ -362,9 +362,9 @@ static int device_alloc_priv(struct udevice *dev)
 	}
 
 	/* Allocate private data if requested and not reentered */
-	size = dev->uclass->uc_drv->per_device_auto;
+	size = dev->uclass_->uc_drv->per_device_auto;
 	if (size && !dev_get_uclass_priv(dev)) {
-		ptr = alloc_priv(size, dev->uclass->uc_drv->flags);
+		ptr = alloc_priv(size, dev->uclass_->uc_drv->flags);
 		if (!ptr)
 			return -ENOMEM;
 		dev_set_uclass_priv(dev, ptr);
@@ -374,7 +374,7 @@ static int device_alloc_priv(struct udevice *dev)
 	if (dev->parent) {
 		size = dev->parent->driver->per_child_auto;
 		if (!size)
-			size = dev->parent->uclass->uc_drv->per_child_auto;
+			size = dev->parent->uclass_->uc_drv->per_child_auto;
 		if (size && !dev_get_parent_priv(dev)) {
 			ptr = alloc_priv(size, drv->flags);
 			if (!ptr)
@@ -700,7 +700,7 @@ void *dev_get_attach_ptr(const struct udevice *dev, enum dm_tag_t tag)
 int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 {
 	const struct udevice *parent = dev_get_parent(dev);
-	const struct uclass *uc = dev->uclass;
+	const struct uclass *uc = dev->uclass_;
 	const struct uclass_driver *uc_drv = uc->uc_drv;
 	const struct driver *parent_drv = NULL;
 	int size = 0;
@@ -716,7 +716,7 @@ int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 		if (parent) {
 			size = parent_drv->per_child_plat_auto;
 			if (!size)
-				size = parent->uclass->uc_drv->per_child_plat_auto;
+				size = parent->uclass_->uc_drv->per_child_plat_auto;
 		}
 		break;
 	case DM_TAG_UC_PLAT:
@@ -729,7 +729,7 @@ int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 		if (parent) {
 			size = parent_drv->per_child_auto;
 			if (!size)
-				size = parent->uclass->uc_drv->per_child_auto;
+				size = parent->uclass_->uc_drv->per_child_auto;
 		}
 		break;
 	case DM_TAG_UC_PRIV:
@@ -1094,7 +1094,7 @@ const void *dev_get_driver_ops(const struct udevice *dev)
 
 enum uclass_id device_get_uclass_id(const struct udevice *dev)
 {
-	return dev->uclass->uc_drv->id;
+	return dev->uclass_->uc_drv->id;
 }
 
 const char *dev_get_uclass_name(const struct udevice *dev)
@@ -1102,7 +1102,7 @@ const char *dev_get_uclass_name(const struct udevice *dev)
 	if (!dev)
 		return NULL;
 
-	return dev->uclass->uc_drv->name;
+	return dev->uclass_->uc_drv->name;
 }
 
 bool device_has_children(const struct udevice *dev)
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 5cbaa97fa31..f3f7b46a973 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -39,7 +39,7 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 
 	/* print the first 20 characters to not break the tree-format. */
 	printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
-	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass->uc_drv->name,
+	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass_->uc_drv->name,
 	       dev->seq_,
 	       flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);
 
diff --git a/drivers/core/read.c b/drivers/core/read.c
index c0d7a969db2..7cf50c0b040 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -347,7 +347,7 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
 	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass->uc_drv->name;
+	const char *uc_name = dev->uclass_->uc_drv->name;
 	int ret = -ENOTSUPP;
 
 	if (ofnode_is_np(node)) {
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 5365ac68f9e..da7c367d5c0 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -203,7 +203,7 @@ enum uclass_id uclass_get_by_name(const char *name)
 int dev_get_uclass_index(struct udevice *dev, struct uclass **ucp)
 {
 	struct udevice *iter;
-	struct uclass *uc = dev->uclass;
+	struct uclass *uc = dev->uclass_;
 	int i = 0;
 
 	if (list_empty(&uc->dev_head))
@@ -266,7 +266,7 @@ void uclass_find_next_device(struct udevice **devp)
 	struct udevice *dev = *devp;
 
 	*devp = NULL;
-	if (!list_is_last(&dev->uclass_node, &dev->uclass->dev_head))
+	if (!list_is_last(&dev->uclass_node, &dev->uclass_->dev_head))
 		*devp = list_entry(dev->uclass_node.next, struct udevice,
 				   uclass_node);
 }
@@ -715,11 +715,11 @@ int uclass_bind_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass;
+	uc = dev->uclass_;
 	list_add_tail(&dev->uclass_node, &uc->dev_head);
 
 	if (dev->parent) {
-		struct uclass_driver *uc_drv = dev->parent->uclass->uc_drv;
+		struct uclass_driver *uc_drv = dev->parent->uclass_->uc_drv;
 
 		if (uc_drv->child_post_bind) {
 			ret = uc_drv->child_post_bind(dev);
@@ -742,7 +742,7 @@ int uclass_pre_unbind_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass;
+	uc = dev->uclass_;
 	if (uc->uc_drv->pre_unbind) {
 		ret = uc->uc_drv->pre_unbind(dev);
 		if (ret)
@@ -765,7 +765,7 @@ int uclass_pre_probe_device(struct udevice *dev)
 	struct uclass_driver *uc_drv;
 	int ret;
 
-	uc_drv = dev->uclass->uc_drv;
+	uc_drv = dev->uclass_->uc_drv;
 	if (uc_drv->pre_probe) {
 		ret = uc_drv->pre_probe(dev);
 		if (ret)
@@ -774,7 +774,7 @@ int uclass_pre_probe_device(struct udevice *dev)
 
 	if (!dev->parent)
 		return 0;
-	uc_drv = dev->parent->uclass->uc_drv;
+	uc_drv = dev->parent->uclass_->uc_drv;
 	if (uc_drv->child_pre_probe) {
 		ret = uc_drv->child_pre_probe(dev);
 		if (ret)
@@ -790,7 +790,7 @@ int uclass_post_probe_device(struct udevice *dev)
 	int ret;
 
 	if (dev->parent) {
-		uc_drv = dev->parent->uclass->uc_drv;
+		uc_drv = dev->parent->uclass_->uc_drv;
 		if (uc_drv->child_post_probe) {
 			ret = uc_drv->child_post_probe(dev);
 			if (ret)
@@ -798,7 +798,7 @@ int uclass_post_probe_device(struct udevice *dev)
 		}
 	}
 
-	uc_drv = dev->uclass->uc_drv;
+	uc_drv = dev->uclass_->uc_drv;
 	if (uc_drv->post_probe) {
 		ret = uc_drv->post_probe(dev);
 		if (ret)
@@ -814,7 +814,7 @@ int uclass_pre_remove_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass;
+	uc = dev->uclass_;
 	if (uc->uc_drv->pre_remove) {
 		ret = uc->uc_drv->pre_remove(dev);
 		if (ret)
diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index bb4fb29424b..aca801e4d34 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -3962,7 +3962,7 @@ static int octeontx_mmc_host_child_pre_probe(struct udevice *dev)
 		/*
 		 * FIXME: This is not allowed
 		 * dev_set_uclass_priv(dev, upriv);
-		 * uclass_set_priv(dev->uclass, upriv);
+		 * uclass_set_priv(dev_uclass(dev), upriv);
 		 */
 	} else {
 		upriv = dev_get_uclass_priv(dev);
diff --git a/drivers/pci/pci-emul-uclass.c b/drivers/pci/pci-emul-uclass.c
index 166ee9fcd43..14f29ade853 100644
--- a/drivers/pci/pci-emul-uclass.c
+++ b/drivers/pci/pci-emul-uclass.c
@@ -81,7 +81,7 @@ uint sandbox_pci_read_bar(u32 barval, int type, uint size)
 
 static int sandbox_pci_emul_post_probe(struct udevice *dev)
 {
-	struct sandbox_pci_emul_priv *priv = uclass_get_priv(dev->uclass);
+	struct sandbox_pci_emul_priv *priv = uclass_get_priv(dev_uclass(dev));
 
 	priv->dev_count++;
 	sandbox_set_enable_pci_map(true);
@@ -91,7 +91,7 @@ static int sandbox_pci_emul_post_probe(struct udevice *dev)
 
 static int sandbox_pci_emul_pre_remove(struct udevice *dev)
 {
-	struct sandbox_pci_emul_priv *priv = uclass_get_priv(dev->uclass);
+	struct sandbox_pci_emul_priv *priv = uclass_get_priv(dev_uclass(dev));
 
 	priv->dev_count--;
 	sandbox_set_enable_pci_map(priv->dev_count > 0);
diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
index 58e070bfe1e..cbedec3bc7e 100644
--- a/drivers/pinctrl/pinctrl-uclass.c
+++ b/drivers/pinctrl/pinctrl-uclass.c
@@ -37,7 +37,7 @@ static int pinctrl_config_one(struct udevice *config)
 			dev_err(config, "could not find pctldev\n");
 			return -EINVAL;
 		}
-		if (pctldev->uclass->uc_drv->id == UCLASS_PINCTRL)
+		if (dev_uclass(pctldev)->uc_drv->id == UCLASS_PINCTRL)
 			break;
 	}
 
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 6b7ad47c22d..0c52646bf92 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -94,7 +94,7 @@ int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	struct udevice *bus = dev->parent;
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 
-	if (bus->uclass->uc_drv->id != UCLASS_SPI)
+	if (dev_uclass(bus)->uc_drv->id != UCLASS_SPI)
 		return -EOPNOTSUPP;
 	if (!ops->xfer)
 		return -ENOSYS;
@@ -108,7 +108,7 @@ int dm_spi_get_mmap(struct udevice *dev, ulong *map_basep, uint *map_sizep,
 	struct udevice *bus = dev->parent;
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 
-	if (bus->uclass->uc_drv->id != UCLASS_SPI)
+	if (dev_uclass(bus)->uc_drv->id != UCLASS_SPI)
 		return -EOPNOTSUPP;
 	if (!ops->get_mmap)
 		return -ENOSYS;
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..e1e56a77952 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -609,7 +609,7 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 #if defined(CONFIG_MX6)
 	int anatop_off, ret, devnump;
 
-	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
+	ret = fdtdec_get_alias_seq(blob, dev_uclass(dev)->uc_drv->name,
 				   phy_off, &devnump);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index 7247245a702..03cb13dc940 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -63,7 +63,7 @@ int submit_control_msg(struct usb_device *udev, unsigned long pipe,
 {
 	struct udevice *bus = udev->controller_dev;
 	struct dm_usb_ops *ops = usb_get_ops(bus);
-	struct usb_uclass_priv *uc_priv = uclass_get_priv(bus->uclass);
+	struct usb_uclass_priv *uc_priv = uclass_get_priv(dev_uclass(bus));
 	int err;
 
 	if (!ops->control)
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 228d6bacc58..2479628d537 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -634,7 +634,7 @@ void video_set_white_on_black(struct udevice *dev, bool white_on_black)
 static int video_post_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
-	struct video_uc_priv *uc_priv = uclass_get_priv(dev->uclass);
+	struct video_uc_priv *uc_priv = uclass_get_priv(dev_uclass(dev));
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	char name[30], drv[15], *str;
 	const char *drv_name = drv;
@@ -753,7 +753,7 @@ static int video_post_bind(struct udevice *dev)
 		return 0;
 
 	/* Set up the video pointer, if this is the first device */
-	uc_priv = uclass_get_priv(dev->uclass);
+	uc_priv = uclass_get_priv(dev_uclass(dev));
 	if (!uc_priv->video_ptr)
 		uc_priv->video_ptr = gd->video_top;
 
diff --git a/include/dm/device-internal.h b/include/dm/device-internal.h
index 4f86ab5c8ed..9382c6c23de 100644
--- a/include/dm/device-internal.h
+++ b/include/dm/device-internal.h
@@ -42,7 +42,7 @@ struct udevice;
  *	.driver		= DM_DRIVER_REF(sandbox_fixed_clock),
  *	.name		= "sandbox_fixed_clock",
  *	.plat_		= &_sandbox_fixed_clock_plat_clk_fixed,
- *	.uclass		= DM_UCLASS_REF(clk),
+ *	.uclass_	= DM_UCLASS_REF(clk),
  *	...
  *	.seq_		= 0,
  * };
diff --git a/include/dm/device.h b/include/dm/device.h
index 678cd83c271..5302cb1f7f0 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -144,7 +144,7 @@ enum {
  *		its driver
  * @parent: Parent of this device, or NULL for the top level device
  * @priv_: Private data for this device (do not access outside driver model)
- * @uclass: Pointer to uclass for this device
+ * @uclass_: Pointer to uclass for this device
  * @uclass_priv_: The uclass's private data for this device (do not access
  *	outside driver model)
  * @parent_priv_: The parent's private data for this device (do not access
@@ -179,7 +179,7 @@ struct udevice {
 	ulong driver_data;
 	struct udevice *parent;
 	void *priv_;
-	struct uclass *uclass;
+	struct uclass *uclass_;
 	void *uclass_priv_;
 	void *parent_priv_;
 	struct list_head uclass_node;
@@ -310,6 +310,11 @@ static inline int dev_seq(const struct udevice *dev)
 	return dev->seq_;
 }
 
+static inline struct uclass *dev_uclass(const struct udevice *dev)
+{
+	return dev->uclass_;
+}
+
 /**
  * struct udevice_id - Lists the compatible strings supported by a driver
  * @compatible: Compatible string
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c..573dcb2b9c4 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1169,7 +1169,7 @@ static inline const void *dev_read_prop_by_prop(struct ofprop *prop,
 static inline int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
 #if CONFIG_IS_ENABLED(OF_CONTROL)
-	return fdtdec_get_alias_seq(gd->fdt_blob, dev->uclass->uc_drv->name,
+	return fdtdec_get_alias_seq(gd->fdt_blob, dev_uclass(dev)->uc_drv->name,
 				    dev_of_offset(dev), devnump);
 #else
 	return -ENOTSUPP;
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index b3fb20b2501..715356dc207 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -405,7 +405,7 @@ __maybe_unused static unsigned int dp_size(struct udevice *dev)
 		return dp_size(dev->parent) +
 			sizeof(struct efi_device_path_mac_addr);
 	case UCLASS_BLK:
-		switch (dev->parent->uclass->uc_drv->id) {
+		switch (dev_uclass(dev->parent)->uc_drv->id) {
 #ifdef CONFIG_IDE
 		case UCLASS_IDE:
 			return dp_size(dev->parent) +
@@ -638,7 +638,7 @@ __maybe_unused static void *dp_fill(void *buf, struct udevice *dev)
 		vdp->dp.length = sizeof(*vdp);
 		memcpy(&vdp->guid, &efi_u_boot_guid, sizeof(efi_guid_t));
 		vdp->uclass_id = uclass_id;
-		vdp->dev_number = dev->seq_;
+		vdp->dev_number = dev_seq(dev);
 
 		return &vdp[1];
 	    }
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5c437143a30..4d182ba3a73 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -529,7 +529,7 @@ int eth_initialize(void)
 
 static int eth_post_bind(struct udevice *dev)
 {
-	struct eth_uclass_priv *priv = uclass_get_priv(dev->uclass);
+	struct eth_uclass_priv *priv = uclass_get_priv(dev_uclass(dev));
 	int ret;
 
 	if (strchr(dev->name, ' ')) {
diff --git a/test/dm/bus.c b/test/dm/bus.c
index 166a8427406..dd4c34f1f8a 100644
--- a/test/dm/bus.c
+++ b/test/dm/bus.c
@@ -219,15 +219,15 @@ static int dm_test_bus_parent_data_uclass(struct unit_test_state *uts)
 	size = drv->per_child_auto;
 
 #ifdef CONFIG_SANDBOX
-	os_mprotect_allow(bus->uclass->uc_drv, sizeof(*bus->uclass->uc_drv));
+	os_mprotect_allow(bus->uclass_->uc_drv, sizeof(*bus->uclass_->uc_drv));
 	os_mprotect_allow(drv, sizeof(*drv));
 #endif
-	bus->uclass->uc_drv->per_child_auto = size;
+	bus->uclass_->uc_drv->per_child_auto = size;
 	drv->per_child_auto = 0;
 	ret = test_bus_parent_data(uts);
 	if (ret)
 		return ret;
-	bus->uclass->uc_drv->per_child_auto = 0;
+	bus->uclass_->uc_drv->per_child_auto = 0;
 	drv->per_child_auto = size;
 
 	return 0;
@@ -360,15 +360,15 @@ static int dm_test_bus_parent_plat_uclass(struct unit_test_state *uts)
 	drv = (struct driver *)bus->driver;
 	size = drv->per_child_plat_auto;
 #ifdef CONFIG_SANDBOX
-	os_mprotect_allow(bus->uclass->uc_drv, sizeof(*bus->uclass->uc_drv));
+	os_mprotect_allow(bus->uclass_->uc_drv, sizeof(*bus->uclass_->uc_drv));
 	os_mprotect_allow(drv, sizeof(*drv));
 #endif
-	bus->uclass->uc_drv->per_child_plat_auto = size;
+	bus->uclass_->uc_drv->per_child_plat_auto = size;
 	drv->per_child_plat_auto = 0;
 	ret = test_bus_parent_plat(uts);
 	if (ret)
 		return ret;
-	bus->uclass->uc_drv->per_child_plat_auto = 0;
+	bus->uclass_->uc_drv->per_child_plat_auto = 0;
 	drv->per_child_plat_auto = size;
 
 	return 0;
diff --git a/test/dm/test-uclass.c b/test/dm/test-uclass.c
index be4108bbecb..0f9c8a5a355 100644
--- a/test/dm/test-uclass.c
+++ b/test/dm/test-uclass.c
@@ -70,7 +70,7 @@ static int test_post_probe(struct udevice *dev)
 					    struct udevice, uclass_node);
 
 	struct dm_test_uclass_perdev_priv *priv = dev_get_uclass_priv(dev);
-	struct uclass *uc = dev->uclass;
+	struct uclass *uc = dev->uclass_;
 
 	dm_testdrv_op_count[DM_TEST_OP_POST_PROBE]++;
 	ut_assert(priv);
diff --git a/tools/dtoc/dtb_platdata.py b/tools/dtoc/dtb_platdata.py
index 89066e6403f..e0561f588b2 100644
--- a/tools/dtoc/dtb_platdata.py
+++ b/tools/dtoc/dtb_platdata.py
@@ -763,7 +763,7 @@ class DtbPlatdata():
                      node.parent.var_name)
         if priv_name:
             self.buf('\t.priv_\t\t= %s,\n' % priv_name)
-        self.buf('\t.uclass\t\t= DM_UCLASS_REF(%s),\n' % uclass.name)
+        self.buf('\t.uclass_\t= DM_UCLASS_REF(%s),\n' % uclass.name)
 
         if uclass_priv_name:
             self.buf('\t.uclass_priv_ = %s,\n' % uclass_priv_name)
diff --git a/tools/dtoc/test_dtoc.py b/tools/dtoc/test_dtoc.py
index 1a85ebcf81a..fc1b73c5125 100755
--- a/tools/dtoc/test_dtoc.py
+++ b/tools/dtoc/test_dtoc.py
@@ -558,7 +558,7 @@ DM_DEVICE_INST(i2c) = {
 \t.name\t\t= "sandbox_i2c",
 \t.plat_\t\t= &dtv_i2c,
 \t.priv_\t\t= _sandbox_i2c_priv_i2c,
-\t.uclass\t\t= DM_UCLASS_REF(i2c),
+\t.uclass_\t= DM_UCLASS_REF(i2c),
 \t.uclass_priv_ = _sandbox_i2c_uc_priv_i2c,
 \t.uclass_node\t= {
 \t\t.prev = &DM_UCLASS_REF(i2c)->dev_head,
@@ -586,7 +586,7 @@ DM_DEVICE_INST(root) = {
 \t.driver\t\t= DM_DRIVER_REF(root_driver),
 \t.name\t\t= "root_driver",
 \t.plat_\t\t= &dtv_root,
-\t.uclass\t\t= DM_UCLASS_REF(root),
+\t.uclass_\t= DM_UCLASS_REF(root),
 \t.uclass_node\t= {
 \t\t.prev = &DM_UCLASS_REF(root)->dev_head,
 \t\t.next = &DM_UCLASS_REF(root)->dev_head,
@@ -630,7 +630,7 @@ DM_DEVICE_INST(some_bus) = {
 \t.uclass_plat_\t= _denx_u_boot_test_bus_ucplat_some_bus,
 \t.driver_data\t= DM_TEST_TYPE_FIRST,
 \t.priv_\t\t= _denx_u_boot_test_bus_priv_some_bus,
-\t.uclass\t\t= DM_UCLASS_REF(testbus),
+\t.uclass_\t= DM_UCLASS_REF(testbus),
 \t.uclass_priv_ = _denx_u_boot_test_bus_uc_priv_some_bus,
 \t.uclass_node\t= {
 \t\t.prev = &DM_UCLASS_REF(testbus)->dev_head,
@@ -660,7 +660,7 @@ DM_DEVICE_INST(spl_test) = {
 \t.driver\t\t= DM_DRIVER_REF(sandbox_spl_test),
 \t.name\t\t= "sandbox_spl_test",
 \t.plat_\t\t= &dtv_spl_test,
-\t.uclass\t\t= DM_UCLASS_REF(misc),
+\t.uclass_\t= DM_UCLASS_REF(misc),
 \t.uclass_node\t= {
 \t\t.prev = &DM_UCLASS_REF(misc)->dev_head,
 \t\t.next = &DM_DEVICE_REF(spl_test3)->uclass_node,
@@ -689,7 +689,7 @@ DM_DEVICE_INST(spl_test3) = {
 \t.driver\t\t= DM_DRIVER_REF(sandbox_spl_test),
 \t.name\t\t= "sandbox_spl_test",
 \t.plat_\t\t= &dtv_spl_test3,
-\t.uclass\t\t= DM_UCLASS_REF(misc),
+\t.uclass_\t= DM_UCLASS_REF(misc),
 \t.uclass_node\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test)->uclass_node,
 \t\t.next = &DM_UCLASS_REF(misc)->dev_head,
@@ -737,7 +737,7 @@ DM_DEVICE_INST(test) = {
 \t.driver_data\t= DM_TEST_TYPE_FIRST,
 \t.parent\t\t= DM_DEVICE_REF(some_bus),
 \t.priv_\t\t= _denx_u_boot_fdt_test_priv_test,
-\t.uclass\t\t= DM_UCLASS_REF(testfdt),
+\t.uclass_\t= DM_UCLASS_REF(testfdt),
 \t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test,
 \t.uclass_node\t= {
 \t\t.prev = &DM_UCLASS_REF(testfdt)->dev_head,
@@ -783,7 +783,7 @@ DM_DEVICE_INST(test0) = {
 \t.driver_data\t= DM_TEST_TYPE_SECOND,
 \t.parent\t\t= DM_DEVICE_REF(some_bus),
 \t.priv_\t\t= _denx_u_boot_fdt_test_priv_test0,
-\t.uclass\t\t= DM_UCLASS_REF(testfdt),
+\t.uclass_\t= DM_UCLASS_REF(testfdt),
 \t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test0,
 \t.uclass_node\t= {
 \t\t.prev = &DM_DEVICE_REF(test)->uclass_node,
-- 
2.43.0

