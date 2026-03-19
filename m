Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB1A1091931
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8815984255;
	Fri, 20 Mar 2026 00:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LTNVt00x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66568413A; Thu, 19 Mar 2026 22:36:51 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457C3838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d7422b4ff1so456558a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956202; x=1774561002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub9Cp/I2guANtFrLVdsGc3BivPrDghPoXSenLxMsVbI=;
 b=LTNVt00xq0sUyWe2/a4fer7yYIPH69STHLPYhmmPtKS5M2XakrGj7QiZ7DVoNg9424
 mJ2hN9R1MXGr7ZEsQetHE/jhvHcJ4TGu0PMSnUfj9haCrKB5WsmvX3+Mr11RMb4UziWY
 qDsu/d/lzIb74dQU2kE43Cl1SEmJCFe7Muegc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956202; x=1774561002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ub9Cp/I2guANtFrLVdsGc3BivPrDghPoXSenLxMsVbI=;
 b=WtEMPc3Y3UngKJtZoXmRRLN1/4eeVLRwLTjDKntAEfIM6ZmcsRyg9Xa4E+u7EMe6mw
 lLuzSlZgCm2RsTr9ZQPOGcMi9WL3+3/H21eihULBQ824RktqDSTnWxwYP3V96kwyLJ3r
 +8p4LnY5AaOpVtYNf1yVH5W4WnJAD8rsTz1lVrFcE3MoOAc0okXfZ9CXGO8elncaxias
 WvwCwDHRh72ROEQs5E1wNbD7TD58qBe88YCsmsIn6vtmKOslq4w1yzUlzS9T/jhAdrHx
 XD1eiSdxqxVZR8gPoTH7Y75du8JwwZv4IeOJLFGEuIStyoTESV1oXZrT66ycCZdsFS52
 MNYg==
X-Gm-Message-State: AOJu0YyXKGWNCYeS3mlPjwyE3mZpUT/ZLh/QYGDD3EEnlTc9k+Fa+FdX
 MImrdBBNuILsfgD09FPE5FK4d6wlDyM+NsnDZuYBHb1uDjEq0EPDHEYlbKWwMAOTve7L7wsGltm
 nm+16Hs7b
X-Gm-Gg: ATEYQzx7Dreg+D/wWpRigTt7BHJWJGz5S3XIcEOjNG7TFdLs4DGhMb8731OCRZDw23k
 Kl4NruuwLgPeR59U72rJEK7ZI6Pk5n3+I2MXy07YSC+cC/SJYclFvY9DmjmMYA+hWtBez/3At19
 MRjPVBq/82lKNDLnLKaxiU1tq/TXu04q9EeHvZLqZ9fyoysCJ+CvryIDNdPGHfSnAxDgCQw/wJw
 QYyHLDoDH/S+kJp/iU+tNsk3VPpM9YGiLuhYYXTCMQGPQryTdJPkRljVSMepujaAagYeA/pbaMj
 f18GmPt90cPSw9sNEdqsiuMq3YwpBXZaFeAZAE3lMt5Hvfge+9JR5tWsbAjzo7S6R1RZ9sCBMyP
 DvF0jR+33JcvXn/L/V2Ca/ssI9tArNBXm/V+P0t6GwxELpgYV8Nr7HAZ8vs29EwQni/AueC5QVP
 oojXDpl9xHH7RlzEz9Yw==
X-Received: by 2002:a05:6830:6d2a:b0:7d7:da02:1aa4 with SMTP id
 46e09a7af769-7d7eae3f3e3mr505138a34.1.1773956202064; 
 Thu, 19 Mar 2026 14:36:42 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@nabladev.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stanley Chu <yschu@nuvoton.com>, Stefan Bosch <stefan_b@posteo.net>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [RFC PATCH 06/15] dm: Embed struct uclass_member in struct udevice
Date: Thu, 19 Mar 2026 15:35:36 -0600
Message-ID: <20260319213551.267031-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:02:25 +0100
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

Replace the individual uclass-membership fields in struct udevice
(uclass_, uclass_priv_, uclass_plat_, uclass_node, seq_) with an
embedded struct uclass_member. This groups the uclass-membership state
into a single struct that can also (later) be allocated independently
for adjunct uclass-registrations.

Update the affected accessors and the dtoc tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/board.c          |   2 +-
 board/nuvoton/poleg_evb/poleg_evb.c     |   4 +-
 board/theobroma-systems/common/common.c |   4 +-
 cmd/rng.c                               |   2 +-
 drivers/core/device-remove.c            |   4 +-
 drivers/core/device.c                   |  44 ++++-----
 drivers/core/dump.c                     |   6 +-
 drivers/core/read.c                     |   2 +-
 drivers/core/uclass.c                   |  46 +++++-----
 drivers/i2c/ast2600_i2c.c               |   2 +-
 drivers/i2c/npcm_i2c.c                  |   2 +-
 drivers/pci/pcie_mediatek_gen3.c        |   4 +-
 drivers/serial/serial_s5p4418_pl011.c   |   2 +-
 include/dm/device.h                     |  23 +----
 include/dm/uclass.h                     |   6 +-
 test/dm/bus.c                           |  12 +--
 test/dm/core.c                          |   8 +-
 test/dm/test-uclass.c                   |   8 +-
 tools/dtoc/dtb_platdata.py              |  33 +++----
 tools/dtoc/test_dtoc.py                 | 114 +++++++++++++-----------
 20 files changed, 165 insertions(+), 163 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2e6bb38b923..6df816d3fb0 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -531,7 +531,7 @@ int mmc_get_env_dev(void)
 		return devnum;
 	}
 
-	devnum = dev->seq_;
+	devnum = dev_seq(dev);
 	debug("%s: get MMC env from mmc%d\n", __func__, devnum);
 	return devnum;
 }
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 9dfe9744363..bed755f3053 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -55,14 +55,14 @@ static int last_stage_init(void)
 		env_set("mem", value);
 	}
 
-	if (dev && (dev->seq_ >= 0)) {
+	if (dev && (dev_seq(dev) >= 0)) {
 		void *addr;
 		addr = dev_read_addr_ptr(dev);
 		if (addr) {
 			sprintf(value, "uart8250,mmio32,0x%x", (u32)addr);
 			env_set("earlycon", value);
 		}
-		sprintf(value, "ttyS%d,115200n8", dev->seq_);
+		sprintf(value, "ttyS%d,115200n8", dev_seq(dev));
 		env_set("console", value);
 #ifdef CONFIG_SYS_SKIP_UART_INIT
 		return board_set_console();
diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
index 585da438845..5db8d439e34 100644
--- a/board/theobroma-systems/common/common.c
+++ b/board/theobroma-systems/common/common.c
@@ -78,8 +78,8 @@ int setup_boottargets(void)
 	 * If mmc1 comes first in the boot order and U-Boot proper was
 	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
 	 */
-	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
-	    (mmc0 > mmc1 && devp->seq_ == 0)) {
+	if ((mmc0 < mmc1 && dev_seq(devp) == 1) ||
+	    (mmc0 > mmc1 && dev_seq(devp) == 0)) {
 		mmc0[3] = '1';
 		mmc1[3] = '0';
 		debug("%s: set boot_targets to: %s\n", __func__, env);
diff --git a/cmd/rng.c b/cmd/rng.c
index 4d91094a8ec..a752f704096 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -23,7 +23,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
 			idx++;
-			printf("RNG #%d - %s\n", dev->seq_, dev->name);
+			printf("RNG #%d - %s\n", dev_seq(dev), dev->name);
 		}
 
 		if (!idx) {
diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index b532855621d..2a3253b34a5 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -137,7 +137,7 @@ void device_free(struct udevice *dev)
 		free(dev_get_priv(dev));
 		dev_set_priv(dev, NULL);
 	}
-	size = dev->uclass_->uc_drv->per_device_auto;
+	size = dev->ucm.uc->uc_drv->per_device_auto;
 	if (size) {
 		free(dev_get_uclass_priv(dev));
 		dev_set_uclass_priv(dev, NULL);
@@ -145,7 +145,7 @@ void device_free(struct udevice *dev)
 	if (dev->parent) {
 		size = dev->parent->driver->per_child_auto;
 		if (!size)
-			size = dev->parent->uclass_->uc_drv->per_child_auto;
+			size = dev->parent->ucm.uc->uc_drv->per_child_auto;
 		if (size) {
 			free(dev_get_parent_priv(dev));
 			dev_set_parent_priv(dev, NULL);
diff --git a/drivers/core/device.c b/drivers/core/device.c
index fe4b23b141b..f90c436e0a9 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -42,6 +42,7 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 			      ulong driver_data, ofnode node,
 			      uint of_plat_size, struct udevice **devp)
 {
+	struct uclass_member *ucm;
 	struct udevice *dev;
 	struct uclass *uc;
 	int size, ret = 0;
@@ -66,9 +67,10 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	if (!dev)
 		return -ENOMEM;
 
+	ucm = &dev->ucm;
 	INIT_LIST_HEAD(&dev->sibling_node);
 	INIT_LIST_HEAD(&dev->child_head);
-	INIT_LIST_HEAD(&dev->uclass_node);
+	INIT_LIST_HEAD(&ucm->uc_node);
 #if CONFIG_IS_ENABLED(DEVRES)
 	INIT_LIST_HEAD(&dev->devres_head);
 #endif
@@ -78,9 +80,9 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	dev_set_ofnode(dev, node);
 	dev->parent = parent;
 	dev->driver = drv;
-	dev->uclass_ = uc;
+	ucm->uc = uc;
 
-	dev->seq_ = -1;
+	ucm->seq = -1;
 	if (CONFIG_IS_ENABLED(DM_SEQ_ALIAS) &&
 	    (uc->uc_drv->flags & DM_UC_FLAG_SEQ_ALIAS)) {
 		/*
@@ -90,15 +92,15 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 		if (CONFIG_IS_ENABLED(OF_CONTROL) &&
 		    !CONFIG_IS_ENABLED(OF_PLATDATA)) {
 			if (uc->uc_drv->name && ofnode_valid(node)) {
-				if (!dev_read_alias_seq(dev, &dev->seq_)) {
+				if (!dev_read_alias_seq(dev, &ucm->seq)) {
 					auto_seq = false;
-					log_debug("   - seq=%d\n", dev->seq_);
+					log_debug("   - seq=%d\n", ucm->seq);
 					}
 			}
 		}
 	}
 	if (auto_seq && !(uc->uc_drv->flags & DM_UC_FLAG_NO_AUTO_SEQ))
-		dev->seq_ = uclass_find_next_free_seq(uc);
+		ucm->seq = uclass_find_next_free_seq(uc);
 
 	/* Check if we need to allocate plat */
 	if (drv->plat_auto) {
@@ -146,7 +148,7 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
 	if (parent) {
 		size = parent->driver->per_child_plat_auto;
 		if (!size)
-			size = parent->uclass_->uc_drv->per_child_plat_auto;
+			size = parent->ucm.uc->uc_drv->per_child_plat_auto;
 		if (size) {
 			dev_or_flags(dev, DM_FLAG_ALLOC_PARENT_PDATA);
 			ptr = calloc(1, size);
@@ -362,9 +364,9 @@ static int device_alloc_priv(struct udevice *dev)
 	}
 
 	/* Allocate private data if requested and not reentered */
-	size = dev->uclass_->uc_drv->per_device_auto;
+	size = dev->ucm.uc->uc_drv->per_device_auto;
 	if (size && !dev_get_uclass_priv(dev)) {
-		ptr = alloc_priv(size, dev->uclass_->uc_drv->flags);
+		ptr = alloc_priv(size, dev->ucm.uc->uc_drv->flags);
 		if (!ptr)
 			return -ENOMEM;
 		dev_set_uclass_priv(dev, ptr);
@@ -374,7 +376,7 @@ static int device_alloc_priv(struct udevice *dev)
 	if (dev->parent) {
 		size = dev->parent->driver->per_child_auto;
 		if (!size)
-			size = dev->parent->uclass_->uc_drv->per_child_auto;
+			size = dev->parent->ucm.uc->uc_drv->per_child_auto;
 		if (size && !dev_get_parent_priv(dev)) {
 			ptr = alloc_priv(size, drv->flags);
 			if (!ptr)
@@ -643,7 +645,7 @@ void *dev_get_uclass_plat(const struct udevice *dev)
 		return NULL;
 	}
 
-	return dm_priv_to_rw(dev->uclass_plat_);
+	return dm_priv_to_rw(dev->ucm.uc_plat);
 }
 
 void *dev_get_priv(const struct udevice *dev)
@@ -664,7 +666,7 @@ notrace void *dev_get_uclass_priv(const struct udevice *dev)
 		return NULL;
 	}
 
-	return dm_priv_to_rw(dev->uclass_priv_);
+	return dm_priv_to_rw(dev->ucm.uc_priv);
 }
 
 void *dev_get_parent_priv(const struct udevice *dev)
@@ -700,7 +702,7 @@ void *dev_get_attach_ptr(const struct udevice *dev, enum dm_tag_t tag)
 int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 {
 	const struct udevice *parent = dev_get_parent(dev);
-	const struct uclass *uc = dev->uclass_;
+	const struct uclass *uc = dev->ucm.uc;
 	const struct uclass_driver *uc_drv = uc->uc_drv;
 	const struct driver *parent_drv = NULL;
 	int size = 0;
@@ -716,7 +718,7 @@ int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 		if (parent) {
 			size = parent_drv->per_child_plat_auto;
 			if (!size)
-				size = parent->uclass_->uc_drv->per_child_plat_auto;
+				size = parent->ucm.uc->uc_drv->per_child_plat_auto;
 		}
 		break;
 	case DM_TAG_UC_PLAT:
@@ -729,7 +731,7 @@ int dev_get_attach_size(const struct udevice *dev, enum dm_tag_t tag)
 		if (parent) {
 			size = parent_drv->per_child_auto;
 			if (!size)
-				size = parent->uclass_->uc_drv->per_child_auto;
+				size = parent->ucm.uc->uc_drv->per_child_auto;
 		}
 		break;
 	case DM_TAG_UC_PRIV:
@@ -829,7 +831,7 @@ int device_find_child_by_seq(const struct udevice *parent, int seq,
 	*devp = NULL;
 
 	device_foreach_child(dev, parent) {
-		if (dev->seq_ == seq) {
+		if (dev->ucm.seq == seq) {
 			*devp = dev;
 			return 0;
 		}
@@ -1094,7 +1096,7 @@ const void *dev_get_driver_ops(const struct udevice *dev)
 
 enum uclass_id device_get_uclass_id(const struct udevice *dev)
 {
-	return dev->uclass_->uc_drv->id;
+	return dev->ucm.uc->uc_drv->id;
 }
 
 const char *dev_get_uclass_name(const struct udevice *dev)
@@ -1102,7 +1104,7 @@ const char *dev_get_uclass_name(const struct udevice *dev)
 	if (!dev)
 		return NULL;
 
-	return dev->uclass_->uc_drv->name;
+	return dev->ucm.uc->uc_drv->name;
 }
 
 bool device_has_children(const struct udevice *dev)
@@ -1161,7 +1163,7 @@ void dev_set_parent_priv(struct udevice *dev, void *parent_priv)
 
 void dev_set_uclass_priv(struct udevice *dev, void *uclass_priv)
 {
-	dev->uclass_priv_ = uclass_priv;
+	dev->ucm.uc_priv = uclass_priv;
 }
 
 void dev_set_plat(struct udevice *dev, void *plat)
@@ -1176,12 +1178,12 @@ void dev_set_parent_plat(struct udevice *dev, void *parent_plat)
 
 void dev_set_uclass_plat(struct udevice *dev, void *uclass_plat)
 {
-	dev->uclass_plat_ = uclass_plat;
+	dev->ucm.uc_plat = uclass_plat;
 }
 
 void dev_int_set_seq(struct udevice *dev, int seq)
 {
-	dev->seq_ = seq;
+	dev->ucm.seq = seq;
 }
 
 #if CONFIG_IS_ENABLED(OF_REAL)
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index f3f7b46a973..60e9a8ad001 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -39,8 +39,8 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 
 	/* print the first 20 characters to not break the tree-format. */
 	printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
-	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass_->uc_drv->name,
-	       dev->seq_,
+	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->ucm.uc->uc_drv->name,
+	       dev->ucm.seq,
 	       flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);
 
 	for (i = depth; i >= 0; i--) {
@@ -156,7 +156,7 @@ static void dm_display_line(struct udevice *dev, int index)
 	printf("%-3i %c %s @ %08lx", index,
 	       dev_get_flags(dev) & DM_FLAG_ACTIVATED ? '*' : ' ',
 	       dev->name, (ulong)map_to_sysmem(dev));
-	if (dev->seq_ != -1)
+	if (dev->ucm.seq != -1)
 		printf(", seq %d", dev_seq(dev));
 	puts("\n");
 }
diff --git a/drivers/core/read.c b/drivers/core/read.c
index 7cf50c0b040..489741aac09 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -347,7 +347,7 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
 	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass_->uc_drv->name;
+	const char *uc_name = dev->ucm.uc->uc_drv->name;
 	int ret = -ENOTSUPP;
 
 	if (ofnode_is_np(node)) {
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index da7c367d5c0..276aec855a0 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -122,7 +122,7 @@ int uclass_destroy(struct uclass *uc)
 	 */
 	while (!list_empty(&uc->dev_head)) {
 		dev = list_first_entry(&uc->dev_head, struct udevice,
-				       uclass_node);
+				       ucm.uc_node);
 		ret = device_remove(dev, DM_REMOVE_NORMAL | DM_REMOVE_NO_PD);
 		if (ret)
 			return log_msg_ret("remove", ret);
@@ -203,7 +203,7 @@ enum uclass_id uclass_get_by_name(const char *name)
 int dev_get_uclass_index(struct udevice *dev, struct uclass **ucp)
 {
 	struct udevice *iter;
-	struct uclass *uc = dev->uclass_;
+	struct uclass *uc = dev->ucm.uc;
 	int i = 0;
 
 	if (list_empty(&uc->dev_head))
@@ -256,7 +256,7 @@ int uclass_find_first_device(enum uclass_id id, struct udevice **devp)
 	if (list_empty(&uc->dev_head))
 		return 0;
 
-	*devp = list_first_entry(&uc->dev_head, struct udevice, uclass_node);
+	*devp = list_first_entry(&uc->dev_head, struct udevice, ucm.uc_node);
 
 	return 0;
 }
@@ -266,9 +266,9 @@ void uclass_find_next_device(struct udevice **devp)
 	struct udevice *dev = *devp;
 
 	*devp = NULL;
-	if (!list_is_last(&dev->uclass_node, &dev->uclass_->dev_head))
-		*devp = list_entry(dev->uclass_node.next, struct udevice,
-				   uclass_node);
+	if (!list_is_last(&dev->ucm.uc_node, &dev->ucm.uc->dev_head))
+		*devp = list_entry(dev->ucm.uc_node.next, struct udevice,
+				   ucm.uc_node);
 }
 
 int uclass_find_device_by_namelen(enum uclass_id id, const char *name, int len,
@@ -310,7 +310,7 @@ struct udevice *uclass_try_first_device(enum uclass_id id)
 	if (!uc || list_empty(&uc->dev_head))
 		return NULL;
 
-	return list_first_entry(&uc->dev_head, struct udevice, uclass_node);
+	return list_first_entry(&uc->dev_head, struct udevice, ucm.uc_node);
 }
 
 int uclass_find_next_free_seq(struct uclass *uc)
@@ -324,9 +324,9 @@ int uclass_find_next_free_seq(struct uclass *uc)
 		max = dev_read_alias_highest_id(uc->uc_drv->name);
 
 	/* Avoid conflict with existing devices */
-	list_for_each_entry(dev, &uc->dev_head, uclass_node) {
-		if (dev->seq_ > max)
-			max = dev->seq_;
+	list_for_each_entry(dev, &uc->dev_head, ucm.uc_node) {
+		if (dev->ucm.seq > max)
+			max = dev->ucm.seq;
 	}
 	/*
 	 * At this point, max will be -1 if there are no existing aliases or
@@ -351,8 +351,8 @@ int uclass_find_device_by_seq(enum uclass_id id, int seq, struct udevice **devp)
 		return ret;
 
 	uclass_foreach_dev(dev, uc) {
-		log_debug("   - %d '%s'\n", dev->seq_, dev->name);
-		if (dev->seq_ == seq) {
+		log_debug("   - %d '%s'\n", dev->ucm.seq, dev->name);
+		if (dev->ucm.seq == seq) {
 			*devp = dev;
 			log_debug("   - found\n");
 			return 0;
@@ -715,11 +715,11 @@ int uclass_bind_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass_;
-	list_add_tail(&dev->uclass_node, &uc->dev_head);
+	uc = dev->ucm.uc;
+	list_add_tail(&dev->ucm.uc_node, &uc->dev_head);
 
 	if (dev->parent) {
-		struct uclass_driver *uc_drv = dev->parent->uclass_->uc_drv;
+		struct uclass_driver *uc_drv = dev->parent->ucm.uc->uc_drv;
 
 		if (uc_drv->child_post_bind) {
 			ret = uc_drv->child_post_bind(dev);
@@ -731,7 +731,7 @@ int uclass_bind_device(struct udevice *dev)
 	return 0;
 err:
 	/* There is no need to undo the parent's post_bind call */
-	list_del(&dev->uclass_node);
+	list_del(&dev->ucm.uc_node);
 
 	return ret;
 }
@@ -742,7 +742,7 @@ int uclass_pre_unbind_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass_;
+	uc = dev->ucm.uc;
 	if (uc->uc_drv->pre_unbind) {
 		ret = uc->uc_drv->pre_unbind(dev);
 		if (ret)
@@ -754,7 +754,7 @@ int uclass_pre_unbind_device(struct udevice *dev)
 
 int uclass_unbind_device(struct udevice *dev)
 {
-	list_del(&dev->uclass_node);
+	list_del(&dev->ucm.uc_node);
 
 	return 0;
 }
@@ -765,7 +765,7 @@ int uclass_pre_probe_device(struct udevice *dev)
 	struct uclass_driver *uc_drv;
 	int ret;
 
-	uc_drv = dev->uclass_->uc_drv;
+	uc_drv = dev->ucm.uc->uc_drv;
 	if (uc_drv->pre_probe) {
 		ret = uc_drv->pre_probe(dev);
 		if (ret)
@@ -774,7 +774,7 @@ int uclass_pre_probe_device(struct udevice *dev)
 
 	if (!dev->parent)
 		return 0;
-	uc_drv = dev->parent->uclass_->uc_drv;
+	uc_drv = dev->parent->ucm.uc->uc_drv;
 	if (uc_drv->child_pre_probe) {
 		ret = uc_drv->child_pre_probe(dev);
 		if (ret)
@@ -790,7 +790,7 @@ int uclass_post_probe_device(struct udevice *dev)
 	int ret;
 
 	if (dev->parent) {
-		uc_drv = dev->parent->uclass_->uc_drv;
+		uc_drv = dev->parent->ucm.uc->uc_drv;
 		if (uc_drv->child_post_probe) {
 			ret = uc_drv->child_post_probe(dev);
 			if (ret)
@@ -798,7 +798,7 @@ int uclass_post_probe_device(struct udevice *dev)
 		}
 	}
 
-	uc_drv = dev->uclass_->uc_drv;
+	uc_drv = dev->ucm.uc->uc_drv;
 	if (uc_drv->post_probe) {
 		ret = uc_drv->post_probe(dev);
 		if (ret)
@@ -814,7 +814,7 @@ int uclass_pre_remove_device(struct udevice *dev)
 	struct uclass *uc;
 	int ret;
 
-	uc = dev->uclass_;
+	uc = dev->ucm.uc;
 	if (uc->uc_drv->pre_remove) {
 		ret = uc->uc_drv->pre_remove(dev);
 		if (ret)
diff --git a/drivers/i2c/ast2600_i2c.c b/drivers/i2c/ast2600_i2c.c
index 9d1d70670b9..57c3f574d49 100644
--- a/drivers/i2c/ast2600_i2c.c
+++ b/drivers/i2c/ast2600_i2c.c
@@ -183,7 +183,7 @@ static int ast2600_i2c_set_speed(struct udevice *dev, unsigned int speed)
 	int inc = 0;
 	u32 data;
 
-	debug("Setting speed for I2C%d to <%u>\n", dev->seq_, speed);
+	debug("Setting speed for I2C%d to <%u>\n", dev_seq(dev), speed);
 	if (!speed) {
 		debug("No valid speed specified\n");
 		return -EINVAL;
diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index d57237a6df1..fa83a772352 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -578,7 +578,7 @@ static int npcm_i2c_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	bus->num = dev->seq_;
+	bus->num = dev_seq(dev);
 	bus->reg = dev_read_addr_ptr(dev);
 	bus->freq = dev_read_u32_default(dev, "clock-frequency", 100000);
 	bus->started = false;
diff --git a/drivers/pci/pcie_mediatek_gen3.c b/drivers/pci/pcie_mediatek_gen3.c
index 1818d4c1e30..6ed8f3aad03 100644
--- a/drivers/pci/pcie_mediatek_gen3.c
+++ b/drivers/pci/pcie_mediatek_gen3.c
@@ -97,10 +97,10 @@ static pci_dev_t convert_bdf(const struct udevice *controller, pci_dev_t bdf)
 	 * external PCIe device. If multiple PCIe controllers are probed in U-Boot,
 	 * U-Boot will use bus numbers greater than 2 as input parameters. Therefore,
 	 * we should convert the BDF bus number to either 0 or 1 by subtracting the
-	 * offset by controller->seq_
+	 * offset by dev_seq(controller)
 	 */
 
-	bdfs[0] = bdfs[0] - controller->seq_;
+	bdfs[0] = bdfs[0] - dev_seq(controller);
 
 	return PCI_BDF(bdfs[0], bdfs[1], bdfs[2]);
 }
diff --git a/drivers/serial/serial_s5p4418_pl011.c b/drivers/serial/serial_s5p4418_pl011.c
index 1fb954e80c2..dbbe3d98dcf 100644
--- a/drivers/serial/serial_s5p4418_pl011.c
+++ b/drivers/serial/serial_s5p4418_pl011.c
@@ -22,7 +22,7 @@ int s5p4418_pl011_serial_probe(struct udevice *dev)
 	int rst_id, ret;
 
 	if (!plat->skip_init) {
-		uart_num = dev->seq_;
+		uart_num = dev_seq(dev);
 		rst_id = RESET_ID_UART0 + uart_num;
 
 		if (uart_num < 0 || rst_id > RESET_ID_UART5) {
diff --git a/include/dm/device.h b/include/dm/device.h
index 6d9528807cc..5824476f91d 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -172,28 +172,17 @@ struct uclass_member {
  *	model)
  * @parent_plat_: The parent bus's configuration data for this device (do not
  *	access outside driver model)
- * @uclass_plat_: The uclass's configuration data for this device (do not access
- *	outside driver model)
  * @driver_data: Driver data word for the entry that matched this device with
  *		its driver
  * @parent: Parent of this device, or NULL for the top level device
  * @priv_: Private data for this device (do not access outside driver model)
- * @uclass_: Pointer to uclass for this device
- * @uclass_priv_: The uclass's private data for this device (do not access
- *	outside driver model)
+ * @ucm: Primary uclass membership (do not access outside driver model)
  * @parent_priv_: The parent's private data for this device (do not access
  *	outside driver model)
- * @uclass_node: Used by uclass to link its devices
  * @child_head: List of children of this device
  * @sibling_node: Next device in list of all devices
  * @flags_: Flags for this device `DM_FLAG_...` (do not access outside driver
  *	model)
- * @seq_: Allocated sequence number for this device (-1 = none). This is set up
- * when the device is bound and is unique within the device's uclass. If the
- * device has an alias in the devicetree then that is used to set the sequence
- * number. Otherwise, the next available number is used. Sequence numbers are
- * used by certain commands that need device to be numbered (e.g. 'mmc dev').
- * (do not access outside driver model)
  * @node_: Reference to device tree node for this device (do not access outside
  *	driver model)
  * @devres_head: List of memory allocations associated with this device.
@@ -209,20 +198,16 @@ struct udevice {
 	const char *name;
 	void *plat_;
 	void *parent_plat_;
-	void *uclass_plat_;
 	ulong driver_data;
 	struct udevice *parent;
 	void *priv_;
-	struct uclass *uclass_;
-	void *uclass_priv_;
+	struct uclass_member ucm;
 	void *parent_priv_;
-	struct list_head uclass_node;
 	struct list_head child_head;
 	struct list_head sibling_node;
 #if !CONFIG_IS_ENABLED(OF_PLATDATA_RT)
 	u32 flags_;
 #endif
-	int seq_;
 #if CONFIG_IS_ENABLED(OF_REAL)
 	ofnode node_;
 #endif
@@ -341,12 +326,12 @@ static inline void dev_set_ofnode(struct udevice *dev, ofnode node)
 
 static inline int dev_seq(const struct udevice *dev)
 {
-	return dev->seq_;
+	return dev->ucm.seq;
 }
 
 static inline struct uclass *dev_uclass(const struct udevice *dev)
 {
-	return dev->uclass_;
+	return dev->ucm.uc;
 }
 
 /**
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index 8fdd7272511..b76797eeabd 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -504,7 +504,7 @@ int uclass_id_count(enum uclass_id id);
  */
 #define uclass_id_foreach_dev(id, pos, uc) \
 	if (!uclass_get(id, &uc)) \
-		list_for_each_entry(pos, &uc->dev_head, uclass_node)
+		list_for_each_entry(pos, &uc->dev_head, ucm.uc_node)
 
 /**
  * uclass_foreach_dev() - iterate through devices of a given uclass
@@ -517,7 +517,7 @@ int uclass_id_count(enum uclass_id id);
  * @uc: uclass to scan (`struct uclass *`)
  */
 #define uclass_foreach_dev(pos, uc)	\
-	list_for_each_entry(pos, &uc->dev_head, uclass_node)
+	list_for_each_entry(pos, &uc->dev_head, ucm.uc_node)
 
 /**
  * uclass_foreach_dev_safe() - safely iterate through devices of a given uclass
@@ -532,7 +532,7 @@ int uclass_id_count(enum uclass_id id);
  * @uc: uclass to scan (`struct uclass *`)
  */
 #define uclass_foreach_dev_safe(pos, next, uc)	\
-	list_for_each_entry_safe(pos, next, &uc->dev_head, uclass_node)
+	list_for_each_entry_safe(pos, next, &uc->dev_head, ucm.uc_node)
 
 /**
  * uclass_foreach_dev_probe() - iterate through devices of a given uclass ID
diff --git a/test/dm/bus.c b/test/dm/bus.c
index dd4c34f1f8a..7dd0d040650 100644
--- a/test/dm/bus.c
+++ b/test/dm/bus.c
@@ -219,15 +219,15 @@ static int dm_test_bus_parent_data_uclass(struct unit_test_state *uts)
 	size = drv->per_child_auto;
 
 #ifdef CONFIG_SANDBOX
-	os_mprotect_allow(bus->uclass_->uc_drv, sizeof(*bus->uclass_->uc_drv));
+	os_mprotect_allow(bus->ucm.uc->uc_drv, sizeof(*bus->ucm.uc->uc_drv));
 	os_mprotect_allow(drv, sizeof(*drv));
 #endif
-	bus->uclass_->uc_drv->per_child_auto = size;
+	bus->ucm.uc->uc_drv->per_child_auto = size;
 	drv->per_child_auto = 0;
 	ret = test_bus_parent_data(uts);
 	if (ret)
 		return ret;
-	bus->uclass_->uc_drv->per_child_auto = 0;
+	bus->ucm.uc->uc_drv->per_child_auto = 0;
 	drv->per_child_auto = size;
 
 	return 0;
@@ -360,15 +360,15 @@ static int dm_test_bus_parent_plat_uclass(struct unit_test_state *uts)
 	drv = (struct driver *)bus->driver;
 	size = drv->per_child_plat_auto;
 #ifdef CONFIG_SANDBOX
-	os_mprotect_allow(bus->uclass_->uc_drv, sizeof(*bus->uclass_->uc_drv));
+	os_mprotect_allow(bus->ucm.uc->uc_drv, sizeof(*bus->ucm.uc->uc_drv));
 	os_mprotect_allow(drv, sizeof(*drv));
 #endif
-	bus->uclass_->uc_drv->per_child_plat_auto = size;
+	bus->ucm.uc->uc_drv->per_child_plat_auto = size;
 	drv->per_child_plat_auto = 0;
 	ret = test_bus_parent_plat(uts);
 	if (ret)
 		return ret;
-	bus->uclass_->uc_drv->per_child_plat_auto = 0;
+	bus->ucm.uc->uc_drv->per_child_plat_auto = 0;
 	drv->per_child_plat_auto = size;
 
 	return 0;
diff --git a/test/dm/core.c b/test/dm/core.c
index 78ee14af228..94fa6cfa8f2 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1226,11 +1226,11 @@ static int dm_test_all_have_seq(struct unit_test_state *uts)
 	struct uclass *uc;
 
 	list_for_each_entry(uc, gd->uclass_root, sibling_node) {
-		list_for_each_entry(dev, &uc->dev_head, uclass_node) {
-			if (dev->seq_ == -1)
+		list_for_each_entry(dev, &uc->dev_head, ucm.uc_node) {
+			if (dev->ucm.seq == -1)
 				printf("Device '%s' has no seq (%d)\n",
-				       dev->name, dev->seq_);
-			ut_assert(dev->seq_ != -1);
+				       dev->name, dev->ucm.seq);
+			ut_assert(dev->ucm.seq != -1);
 		}
 	}
 
diff --git a/test/dm/test-uclass.c b/test/dm/test-uclass.c
index 0f9c8a5a355..ee2ed1b6643 100644
--- a/test/dm/test-uclass.c
+++ b/test/dm/test-uclass.c
@@ -66,11 +66,11 @@ static int test_pre_probe(struct udevice *dev)
 static int test_post_probe(struct udevice *dev)
 {
 	struct unit_test_state *uts = ut_get_state();
-	struct udevice *prev = list_entry(dev->uclass_node.prev,
-					    struct udevice, uclass_node);
+	struct udevice *prev = list_entry(dev->ucm.uc_node.prev,
+					    struct udevice, ucm.uc_node);
 
 	struct dm_test_uclass_perdev_priv *priv = dev_get_uclass_priv(dev);
-	struct uclass *uc = dev->uclass_;
+	struct uclass *uc = dev->ucm.uc;
 
 	dm_testdrv_op_count[DM_TEST_OP_POST_PROBE]++;
 	ut_assert(priv);
@@ -78,7 +78,7 @@ static int test_post_probe(struct udevice *dev)
 	priv->base_add = 0;
 	if (uts->skip_post_probe)
 		return 0;
-	if (&prev->uclass_node != &uc->dev_head) {
+	if (&prev->ucm.uc_node != &uc->dev_head) {
 		struct dm_test_uclass_perdev_priv *prev_uc_priv
 				= dev_get_uclass_priv(prev);
 		struct dm_test_pdata *pdata = dev_get_plat(prev);
diff --git a/tools/dtoc/dtb_platdata.py b/tools/dtoc/dtb_platdata.py
index e0561f588b2..a570fd3b9a9 100644
--- a/tools/dtoc/dtb_platdata.py
+++ b/tools/dtoc/dtb_platdata.py
@@ -735,8 +735,6 @@ class DtbPlatdata():
             self.buf('\t.plat_\t\t= &%s%s,\n' % (VAL_PREFIX, node.var_name))
         if parent_plat_name:
             self.buf('\t.parent_plat_\t= %s,\n' % parent_plat_name)
-        if uclass_plat_name:
-            self.buf('\t.uclass_plat_\t= %s,\n' % uclass_plat_name)
         driver_date = None
 
         if node != self._fdt.GetRoot():
@@ -763,20 +761,22 @@ class DtbPlatdata():
                      node.parent.var_name)
         if priv_name:
             self.buf('\t.priv_\t\t= %s,\n' % priv_name)
-        self.buf('\t.uclass_\t= DM_UCLASS_REF(%s),\n' % uclass.name)
-
+        self.buf('\t.ucm\t\t= {\n')
+        self.buf('\t\t.uc\t= DM_UCLASS_REF(%s),\n' % uclass.name)
         if uclass_priv_name:
-            self.buf('\t.uclass_priv_ = %s,\n' % uclass_priv_name)
+            self.buf('\t\t.uc_priv = %s,\n' % uclass_priv_name)
+        if uclass_plat_name:
+            self.buf('\t\t.uc_plat = %s,\n' % uclass_plat_name)
+        self.list_node('uc_node', uclass.node_refs, node.uclass_seq, indent=2)
+        self.buf('\t\t.seq\t= %d,\n' % node.seq)
+        self.buf('\t},\n')
+
         if parent_priv_name:
             self.buf('\t.parent_priv_\t= %s,\n' % parent_priv_name)
-        self.list_node('uclass_node', uclass.node_refs, node.uclass_seq)
         self.list_head('child_head', 'sibling_node', node.child_devs, node.var_name)
         if node.parent in self._valid_nodes:
             self.list_node('sibling_node', node.parent.child_refs,
                            node.parent_seq)
-        # flags is left as 0
-
-        self.buf('\t.seq_ = %d,\n' % node.seq)
 
         self.buf('};\n')
         self.buf('\n')
@@ -827,11 +827,12 @@ class DtbPlatdata():
         self.buf('\t\t.next = &%s->%s,\n' % (first, member))
         self.buf('\t},\n')
 
-    def list_node(self, member, node_refs, seq):
-        self.buf('\t.%s\t= {\n' % member)
-        self.buf('\t\t.prev = %s,\n' % node_refs[seq - 1])
-        self.buf('\t\t.next = %s,\n' % node_refs[seq + 1])
-        self.buf('\t},\n')
+    def list_node(self, member, node_refs, seq, indent=1):
+        tab = '\t' * indent
+        self.buf('%s.%s\t= {\n' % (tab, member))
+        self.buf('%s\t.prev = %s,\n' % (tab, node_refs[seq - 1]))
+        self.buf('%s\t.next = %s,\n' % (tab, node_refs[seq + 1]))
+        self.buf('%s},\n' % tab)
 
     def generate_uclasses(self):
         self.out('\n')
@@ -876,7 +877,7 @@ class DtbPlatdata():
                 self.buf('\t.priv_\t\t= %s,\n' % priv_name)
             self.buf('\t.uc_drv\t\t= DM_UCLASS_DRIVER_REF(%s),\n' % uclass.name)
             self.list_node('sibling_node', uclass_node, seq)
-            self.list_head('dev_head', 'uclass_node', uc_drv.devs, None)
+            self.list_head('dev_head', 'ucm.uc_node', uc_drv.devs, None)
             self.buf('};\n')
             self.buf('\n')
         self.out(''.join(self.get_buf()))
@@ -967,7 +968,7 @@ class DtbPlatdata():
             node.uclass_seq = len(node.uclass.devs)
             node.uclass.devs.append(node)
             uclass.node_refs[node.uclass_seq] = \
-                '&%s->uclass_node' % node.dev_ref
+                '&%s->ucm.uc_node' % node.dev_ref
 
             parent_driver = None
             if node.parent in self._valid_nodes:
diff --git a/tools/dtoc/test_dtoc.py b/tools/dtoc/test_dtoc.py
index fc1b73c5125..6bbf800adec 100755
--- a/tools/dtoc/test_dtoc.py
+++ b/tools/dtoc/test_dtoc.py
@@ -455,8 +455,8 @@ DM_UCLASS_INST(i2c) = {
 		.next = &DM_UCLASS_REF(misc)->sibling_node,
 	},
 	.dev_head	= {
-		.prev = &DM_DEVICE_REF(i2c)->uclass_node,
-		.next = &DM_DEVICE_REF(i2c)->uclass_node,
+		.prev = &DM_DEVICE_REF(i2c)->ucm.uc_node,
+		.next = &DM_DEVICE_REF(i2c)->ucm.uc_node,
 	},
 };
 
@@ -467,8 +467,8 @@ DM_UCLASS_INST(misc) = {
 		.next = &DM_UCLASS_REF(root)->sibling_node,
 	},
 	.dev_head	= {
-		.prev = &DM_DEVICE_REF(spl_test3)->uclass_node,
-		.next = &DM_DEVICE_REF(spl_test)->uclass_node,
+		.prev = &DM_DEVICE_REF(spl_test3)->ucm.uc_node,
+		.next = &DM_DEVICE_REF(spl_test)->ucm.uc_node,
 	},
 };
 
@@ -479,8 +479,8 @@ DM_UCLASS_INST(root) = {
 		.next = &DM_UCLASS_REF(testbus)->sibling_node,
 	},
 	.dev_head	= {
-		.prev = &DM_DEVICE_REF(root)->uclass_node,
-		.next = &DM_DEVICE_REF(root)->uclass_node,
+		.prev = &DM_DEVICE_REF(root)->ucm.uc_node,
+		.next = &DM_DEVICE_REF(root)->ucm.uc_node,
 	},
 };
 
@@ -491,8 +491,8 @@ DM_UCLASS_INST(testbus) = {
 		.next = &DM_UCLASS_REF(testfdt)->sibling_node,
 	},
 	.dev_head	= {
-		.prev = &DM_DEVICE_REF(some_bus)->uclass_node,
-		.next = &DM_DEVICE_REF(some_bus)->uclass_node,
+		.prev = &DM_DEVICE_REF(some_bus)->ucm.uc_node,
+		.next = &DM_DEVICE_REF(some_bus)->ucm.uc_node,
 	},
 };
 
@@ -507,8 +507,8 @@ DM_UCLASS_INST(testfdt) = {
 		.next = &uclass_head,
 	},
 	.dev_head	= {
-		.prev = &DM_DEVICE_REF(test0)->uclass_node,
-		.next = &DM_DEVICE_REF(test)->uclass_node,
+		.prev = &DM_DEVICE_REF(test0)->ucm.uc_node,
+		.next = &DM_DEVICE_REF(test)->ucm.uc_node,
 	},
 };
 
@@ -558,11 +558,14 @@ DM_DEVICE_INST(i2c) = {
 \t.name\t\t= "sandbox_i2c",
 \t.plat_\t\t= &dtv_i2c,
 \t.priv_\t\t= _sandbox_i2c_priv_i2c,
-\t.uclass_\t= DM_UCLASS_REF(i2c),
-\t.uclass_priv_ = _sandbox_i2c_uc_priv_i2c,
-\t.uclass_node\t= {
-\t\t.prev = &DM_UCLASS_REF(i2c)->dev_head,
-\t\t.next = &DM_UCLASS_REF(i2c)->dev_head,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(i2c),
+\t\t.uc_priv = _sandbox_i2c_uc_priv_i2c,
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_UCLASS_REF(i2c)->dev_head,
+\t\t\t.next = &DM_UCLASS_REF(i2c)->dev_head,
+\t\t},
+\t\t.seq\t= 4,
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(i2c)->child_head,
@@ -572,7 +575,6 @@ DM_DEVICE_INST(i2c) = {
 \t\t.prev = &DM_DEVICE_REF(root)->child_head,
 \t\t.next = &DM_DEVICE_REF(some_bus)->sibling_node,
 \t},
-\t.seq_ = 4,
 };
 
 /*
@@ -586,16 +588,18 @@ DM_DEVICE_INST(root) = {
 \t.driver\t\t= DM_DRIVER_REF(root_driver),
 \t.name\t\t= "root_driver",
 \t.plat_\t\t= &dtv_root,
-\t.uclass_\t= DM_UCLASS_REF(root),
-\t.uclass_node\t= {
-\t\t.prev = &DM_UCLASS_REF(root)->dev_head,
-\t\t.next = &DM_UCLASS_REF(root)->dev_head,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(root),
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_UCLASS_REF(root)->dev_head,
+\t\t\t.next = &DM_UCLASS_REF(root)->dev_head,
+\t\t},
+\t\t.seq\t= 0,
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test3)->sibling_node,
 \t\t.next = &DM_DEVICE_REF(i2c)->sibling_node,
 \t},
-\t.seq_ = 0,
 };
 
 /*
@@ -627,14 +631,17 @@ DM_DEVICE_INST(some_bus) = {
 \t.driver\t\t= DM_DRIVER_REF(denx_u_boot_test_bus),
 \t.name\t\t= "denx_u_boot_test_bus",
 \t.plat_\t\t= &_denx_u_boot_test_bus_plat_some_bus,
-\t.uclass_plat_\t= _denx_u_boot_test_bus_ucplat_some_bus,
 \t.driver_data\t= DM_TEST_TYPE_FIRST,
 \t.priv_\t\t= _denx_u_boot_test_bus_priv_some_bus,
-\t.uclass_\t= DM_UCLASS_REF(testbus),
-\t.uclass_priv_ = _denx_u_boot_test_bus_uc_priv_some_bus,
-\t.uclass_node\t= {
-\t\t.prev = &DM_UCLASS_REF(testbus)->dev_head,
-\t\t.next = &DM_UCLASS_REF(testbus)->dev_head,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(testbus),
+\t\t.uc_priv = _denx_u_boot_test_bus_uc_priv_some_bus,
+\t\t.uc_plat = _denx_u_boot_test_bus_ucplat_some_bus,
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_UCLASS_REF(testbus)->dev_head,
+\t\t\t.next = &DM_UCLASS_REF(testbus)->dev_head,
+\t\t},
+\t\t.seq\t= 2,
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(test0)->sibling_node,
@@ -644,7 +651,6 @@ DM_DEVICE_INST(some_bus) = {
 \t\t.prev = &DM_DEVICE_REF(i2c)->sibling_node,
 \t\t.next = &DM_DEVICE_REF(spl_test)->sibling_node,
 \t},
-\t.seq_ = 2,
 };
 
 /*
@@ -660,10 +666,13 @@ DM_DEVICE_INST(spl_test) = {
 \t.driver\t\t= DM_DRIVER_REF(sandbox_spl_test),
 \t.name\t\t= "sandbox_spl_test",
 \t.plat_\t\t= &dtv_spl_test,
-\t.uclass_\t= DM_UCLASS_REF(misc),
-\t.uclass_node\t= {
-\t\t.prev = &DM_UCLASS_REF(misc)->dev_head,
-\t\t.next = &DM_DEVICE_REF(spl_test3)->uclass_node,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(misc),
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_UCLASS_REF(misc)->dev_head,
+\t\t\t.next = &DM_DEVICE_REF(spl_test3)->ucm.uc_node,
+\t\t},
+\t\t.seq\t= 0,
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test)->child_head,
@@ -673,7 +682,6 @@ DM_DEVICE_INST(spl_test) = {
 \t\t.prev = &DM_DEVICE_REF(some_bus)->sibling_node,
 \t\t.next = &DM_DEVICE_REF(spl_test3)->sibling_node,
 \t},
-\t.seq_ = 0,
 };
 
 /*
@@ -689,10 +697,13 @@ DM_DEVICE_INST(spl_test3) = {
 \t.driver\t\t= DM_DRIVER_REF(sandbox_spl_test),
 \t.name\t\t= "sandbox_spl_test",
 \t.plat_\t\t= &dtv_spl_test3,
-\t.uclass_\t= DM_UCLASS_REF(misc),
-\t.uclass_node\t= {
-\t\t.prev = &DM_DEVICE_REF(spl_test)->uclass_node,
-\t\t.next = &DM_UCLASS_REF(misc)->dev_head,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(misc),
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_DEVICE_REF(spl_test)->ucm.uc_node,
+\t\t\t.next = &DM_UCLASS_REF(misc)->dev_head,
+\t\t},
+\t\t.seq\t= 1,
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test3)->child_head,
@@ -702,7 +713,6 @@ DM_DEVICE_INST(spl_test3) = {
 \t\t.prev = &DM_DEVICE_REF(spl_test)->sibling_node,
 \t\t.next = &DM_DEVICE_REF(root)->child_head,
 \t},
-\t.seq_ = 1,
 };
 
 /*
@@ -737,12 +747,15 @@ DM_DEVICE_INST(test) = {
 \t.driver_data\t= DM_TEST_TYPE_FIRST,
 \t.parent\t\t= DM_DEVICE_REF(some_bus),
 \t.priv_\t\t= _denx_u_boot_fdt_test_priv_test,
-\t.uclass_\t= DM_UCLASS_REF(testfdt),
-\t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test,
-\t.uclass_node\t= {
-\t\t.prev = &DM_UCLASS_REF(testfdt)->dev_head,
-\t\t.next = &DM_DEVICE_REF(test0)->uclass_node,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(testfdt),
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_UCLASS_REF(testfdt)->dev_head,
+\t\t\t.next = &DM_DEVICE_REF(test0)->ucm.uc_node,
+\t\t},
+\t\t.seq\t= 1,
 \t},
+\t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test,
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(test)->child_head,
 \t\t.next = &DM_DEVICE_REF(test)->child_head,
@@ -751,7 +764,6 @@ DM_DEVICE_INST(test) = {
 \t\t.prev = &DM_DEVICE_REF(some_bus)->child_head,
 \t\t.next = &DM_DEVICE_REF(test0)->sibling_node,
 \t},
-\t.seq_ = 1,
 };
 
 /*
@@ -783,12 +795,15 @@ DM_DEVICE_INST(test0) = {
 \t.driver_data\t= DM_TEST_TYPE_SECOND,
 \t.parent\t\t= DM_DEVICE_REF(some_bus),
 \t.priv_\t\t= _denx_u_boot_fdt_test_priv_test0,
-\t.uclass_\t= DM_UCLASS_REF(testfdt),
-\t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test0,
-\t.uclass_node\t= {
-\t\t.prev = &DM_DEVICE_REF(test)->uclass_node,
-\t\t.next = &DM_UCLASS_REF(testfdt)->dev_head,
+\t.ucm\t\t= {
+\t\t.uc\t= DM_UCLASS_REF(testfdt),
+\t\t.uc_node\t= {
+\t\t\t.prev = &DM_DEVICE_REF(test)->ucm.uc_node,
+\t\t\t.next = &DM_UCLASS_REF(testfdt)->dev_head,
+\t\t},
+\t\t.seq\t= 2,
 \t},
+\t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test0,
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(test0)->child_head,
 \t\t.next = &DM_DEVICE_REF(test0)->child_head,
@@ -797,7 +812,6 @@ DM_DEVICE_INST(test0) = {
 \t\t.prev = &DM_DEVICE_REF(test)->sibling_node,
 \t\t.next = &DM_DEVICE_REF(some_bus)->child_head,
 \t},
-\t.seq_ = 2,
 };
 
 '''
-- 
2.43.0

