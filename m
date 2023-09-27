Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538B3E7F14E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E171786DE2;
	Wed, 27 Sep 2023 15:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="RCDVn+Ul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F5C86D62; Wed, 27 Sep 2023 15:34:13 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED9386DD6
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695821650; x=1727357650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7AcQfsd+AbOWv1kcBBRScEfD9r8J/wu/83u7x+1quFY=;
 b=RCDVn+UlKopWGmwncMSJdK+l0Vm2mkjPOZVYcN7c/isE2YZwha+P2p33
 csGNiAfSzJDWGg/aSPuCtplNYANjzUCHhgAt9Xk5CqkbC6YiMcoWBsMYs
 ULodWGxeT6H+SQBygU39t4qIv7KXkPCy1KdCkdNeuUhIaXwbmVQ3qqUrG
 RPT8GFOT7ORw7zOOxTbKQQsGqzTqKSDRaMBdZc9GzV+Qrtdp1KHfp091R
 7Jr03VhLe1Awoy/OatSDOpIj1rp9teoQ8HIo7+hdvigb4gHB9OprTXLOz
 wEQjAoEoeMy9AJW7mX8KkiQAOfr/7B4LQ14Pn3ypOKE7pw8UWedAZylHU w==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178731"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:34:04 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 67E5B280086;
 Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/5] pinctrl: single: fix compile warnings with PHYS_64BIT on
 32bit
Date: Wed, 27 Sep 2023 15:33:33 +0200
Message-Id: <e704b87c2a636c5a5f11a4d1c693df065c0c2e92.1695817360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

pinctrl-single uses fdt_addr_t and phys_addr_t inconsistently, but both
are wrong to be passed to readb() etc., which expect a pointer or
pointer-sized integer. Change the driver to use
dev_read_addr_size_index_ptr(), so we consistently deal with void*
(except for the sandbox case and single_get_pin_muxing()).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

Tested on x86 sandbox and TI AM62x. No new unit test failures in
sandbox.

 drivers/pinctrl/pinctrl-single.c | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index d80281fd3dd..fb34f681740 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -24,7 +24,7 @@
  * @bits_per_mux: true if one register controls more than one pin
  */
 struct single_pdata {
-	fdt_addr_t base;
+	void *base;
 	int offset;
 	u32 mask;
 	u32 width;
@@ -97,7 +97,7 @@ struct single_fdt_bits_cfg {
 
 #if (!IS_ENABLED(CONFIG_SANDBOX))
 
-static unsigned int single_read(struct udevice *dev, fdt_addr_t reg)
+static unsigned int single_read(struct udevice *dev, void *reg)
 {
 	struct single_pdata *pdata = dev_get_plat(dev);
 
@@ -113,7 +113,7 @@ static unsigned int single_read(struct udevice *dev, fdt_addr_t reg)
 	return readb(reg);
 }
 
-static void single_write(struct udevice *dev, unsigned int val, fdt_addr_t reg)
+static void single_write(struct udevice *dev, unsigned int val, void *reg)
 {
 	struct single_pdata *pdata = dev_get_plat(dev);
 
@@ -131,18 +131,18 @@ static void single_write(struct udevice *dev, unsigned int val, fdt_addr_t reg)
 
 #else /* CONFIG_SANDBOX  */
 
-static unsigned int single_read(struct udevice *dev, fdt_addr_t reg)
+static unsigned int single_read(struct udevice *dev, void *reg)
 {
 	struct single_priv *priv = dev_get_priv(dev);
 
-	return priv->sandbox_regs[reg];
+	return priv->sandbox_regs[map_to_sysmem(reg)];
 }
 
-static void single_write(struct udevice *dev, unsigned int val, fdt_addr_t reg)
+static void single_write(struct udevice *dev, unsigned int val, void *reg)
 {
 	struct single_priv *priv = dev_get_priv(dev);
 
-	priv->sandbox_regs[reg] = val;
+	priv->sandbox_regs[map_to_sysmem(reg)] = val;
 }
 
 #endif /* CONFIG_SANDBOX  */
@@ -214,7 +214,8 @@ static int single_get_pin_muxing(struct udevice *dev, unsigned int pin,
 {
 	struct single_pdata *pdata = dev_get_plat(dev);
 	struct single_priv *priv = dev_get_priv(dev);
-	fdt_addr_t reg;
+	phys_addr_t phys_reg;
+	void *reg;
 	const char *fname;
 	unsigned int val;
 	int offset, pin_shift = 0;
@@ -226,13 +227,15 @@ static int single_get_pin_muxing(struct udevice *dev, unsigned int pin,
 	reg = pdata->base + offset;
 	val = single_read(dev, reg);
 
+	phys_reg = map_to_sysmem(reg);
+
 	if (pdata->bits_per_mux)
 		pin_shift = pin % (pdata->width / priv->bits_per_pin) *
 			priv->bits_per_pin;
 
 	val &= (pdata->mask << pin_shift);
 	fname = single_get_pin_function(dev, pin);
-	snprintf(buf, size, "%pa 0x%08x %s", &reg, val,
+	snprintf(buf, size, "%pa 0x%08x %s", &phys_reg, val,
 		 fname ? fname : "UNCLAIMED");
 	return 0;
 }
@@ -243,7 +246,7 @@ static int single_request(struct udevice *dev, int pin, int flags)
 	struct single_pdata *pdata = dev_get_plat(dev);
 	struct single_gpiofunc_range *frange = NULL;
 	struct list_head *pos, *tmp;
-	phys_addr_t reg;
+	void *reg;
 	int mux_bytes = 0;
 	u32 data;
 
@@ -321,7 +324,7 @@ static int single_configure_pins(struct udevice *dev,
 	int stride = pdata->args_count + 1;
 	int n, pin, count = size / sizeof(u32);
 	struct single_func *func;
-	phys_addr_t reg;
+	void *reg;
 	u32 offset, val, mux;
 
 	/* If function mask is null, needn't enable it. */
@@ -379,7 +382,7 @@ static int single_configure_bits(struct udevice *dev,
 	int n, pin, count = size / sizeof(struct single_fdt_bits_cfg);
 	int npins_in_reg, pin_num_from_lsb;
 	struct single_func *func;
-	phys_addr_t reg;
+	void *reg;
 	u32 offset, val, mask, bit_pos, val_pos, mask_pos, submask;
 
 	/* If function mask is null, needn't enable it. */
@@ -570,7 +573,7 @@ static int single_probe(struct udevice *dev)
 
 static int single_of_to_plat(struct udevice *dev)
 {
-	fdt_addr_t addr;
+	void *addr;
 	fdt_size_t size;
 	struct single_pdata *pdata = dev_get_plat(dev);
 	int ret;
@@ -591,8 +594,8 @@ static int single_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	addr = dev_read_addr_size_index(dev, 0, &size);
-	if (addr == FDT_ADDR_T_NONE) {
+	addr = dev_read_addr_size_index_ptr(dev, 0, &size);
+	if (!addr) {
 		dev_err(dev, "failed to get base register address\n");
 		return -EINVAL;
 	}
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

