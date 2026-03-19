Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD941091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F0F840B0;
	Thu, 19 Mar 2026 22:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JJVhV5wD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC8284090; Thu, 19 Mar 2026 22:36:50 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9052840AE
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so192098a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956204; x=1774561004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjz83l+/f/Rappzt26S0sNwpSiNH73ZyeuTOrMSbT5c=;
 b=JJVhV5wDlOpvS4AezWaMBtolaesPrshy7HNvWuJ+LleWeloVqGIOukEp5yCGNn3BkA
 p37fZ/PN2yLODoNpYd9bRonbGQNvG3XdgK4VcXQcWpyPPj29Fl2pptNbS0XlimHeqi1O
 f9oEKsNKowFeN79hM2DynvOXxEP31KxAztQfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956204; x=1774561004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjz83l+/f/Rappzt26S0sNwpSiNH73ZyeuTOrMSbT5c=;
 b=aE0UzGEqVFRCOiAxYqIZ82n9LhYk1HKWz0cDMh63CJud2+TZe401jRm1FlsoN/bvu+
 jVlRyIzp5A8UcSFgiidfBNBdo+/TlbehhOk5ubm//442EwoHeOR5POplCyhBxTw8XgM/
 ygSG63K4MGsU469idal5x0LM/61/gf1o5NrWyB/om8JDHMCseEzAbkXt3GO/TRnZvmRw
 0N1cm3x9QS+GiCqr4MMTUGiRghmd8nFl0tAdfKep0Q25TT8sCgm6g5VasncM5AcrOAsU
 Z4ULHrHut+Hy523TlrhMz2p2w0iiUBl2ispfpY6Z10JV41ucpBLpeCWtaUiPxu/Tv2Cu
 PCsA==
X-Gm-Message-State: AOJu0YwM9Nn49BFlBeEXJXQ9UHGFWAlrrm8ln11dcUbHBPf4gyzpcxA9
 TZe9zdPhJh0TIXN2/3CTBrVK9rxiMBbRDjFRIy9XPKVEMKCduQv0Jw5PVPhlnYu8leR5lGz9E3I
 QN2FZYaIo
X-Gm-Gg: ATEYQzyQh81sF9vR+UmUBCskwIkPWNvuF0DQv9AXeZDtv8gii+BEf+YCWMqo+RxPsSO
 KGO9rlZMlOkXOlXUigm9j3JgRQkzKTZ05tvxo0tSZLOk+JQHy6/DA9HqCoXKxu9Sm5iNGaj7Jrl
 sJ+gVEc5Zg0omTHZU/6Wab6cV//RMCdX5n096rOEVqfHIw/ieO6GjBncolFZQsnqTwcFpw8eeMX
 21aCoUuxTLK5p4GpkgZvoLWXOiaDogI70OzQFXkTSB9o+Lhv6Xj8O/veAfqzn1WJ+xG9TPRGJbn
 eeNYtiUUKH1G9NKoLUUvfHe0LQT1JZLceR/UIvpXORM1sHpkoccgGOoNOsGAJMy2VIy49t2kgHo
 CyfrQo0as8x3CvAOB/GjT6GY4GacYfX3VD8VU6wCbS+DWzpXrDFtSOUSDel34Ar2sOreyVDRxJ0
 rTgnl6sPjqfSXKcZhSTg==
X-Received: by 2002:a05:6830:700e:b0:7d7:58b0:8e72 with SMTP id
 46e09a7af769-7d7eae42153mr622811a34.4.1773956203931; 
 Thu, 19 Mar 2026 14:36:43 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 07/15] dm: core: Add uclass-adjunct data structures
Date: Thu, 19 Mar 2026 15:35:37 -0600
Message-ID: <20260319213551.267031-8-sjg@chromium.org>
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

Add the data structures needed to support uclass adjuncts, which allow
a device to belong to more than one uclass.

Make the dev back-pointer in struct uclass_member unconditional so it
works for both primary (embedded) and adjunct (standalone) memberships.
This simplifies the list traversal at a cost of an extra pointer in
every device (even without DM_UC_ADJUNCT).

Add adj_head to struct udevice and adj_node to struct uclass_member
(both conditional on DM_UC_ADJUNCT) for chaining a device's uclass
memberships.

Update dtoc to generate the .dev field in ucm initialisers.

No functional change is intended.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/Kconfig       | 10 ++++++++++
 include/dm/device.h        |  9 +++++----
 include/dm/uclass.h        |  4 +++-
 tools/dtoc/dtb_platdata.py |  1 +
 tools/dtoc/test_dtoc.py    |  7 +++++++
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index c9253099e6e..8d72c7838b8 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -85,6 +85,16 @@ config DM_STATS
 
 	  To display the memory stats, use the 'dm mem' command.
 
+config DM_UC_ADJUNCT
+	bool "Support uclass adjuncts for devices"
+	depends on DM
+	default y if SANDBOX
+	help
+	  Allow a device to belong to more than one uclass.
+	  A device bound to one uclass (e.g. UCLASS_PHY) can register
+	  adjunct uclasses (e.g. UCLASS_CLK) at bind/probe-time via
+	  device_add_uclass_adj(). If unsure, say N.
+
 config SPL_DM_STATS
 	bool "Collect and show driver model stats in SPL"
 	depends on SPL_DM
diff --git a/include/dm/device.h b/include/dm/device.h
index 5824476f91d..ebc253397a4 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -131,10 +131,9 @@ enum {
  * @uc_priv: Per-device private data owned by the uclass
  * @uc_plat: Per-device platform data owned by the uclass
  * @seq: Sequence number within this uclass (-1 = none)
+ * @dev: Owning device (set for both primary and adjunct memberships)
  * @ops: Ops provided by this device for the uclass
- * @dev: Owning device (adjuncts only; for the primary uclass use
- *	container_of)
- * @adj_node: Node in the device's list of adjuncts
+ * @adj_node: Node in the owning device's adj_head list (struct udevice)
  */
 struct uclass_member {
 	struct uclass *uc;
@@ -142,9 +141,9 @@ struct uclass_member {
 	void *uc_priv;
 	void *uc_plat;
 	int seq;
+	struct udevice *dev;
 	const void *ops;
 #if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
-	struct udevice *dev;
 	struct list_head adj_node;
 #endif
 };
@@ -177,6 +176,8 @@ struct uclass_member {
  * @parent: Parent of this device, or NULL for the top level device
  * @priv_: Private data for this device (do not access outside driver model)
  * @ucm: Primary uclass membership (do not access outside driver model)
+ * @adj_head: List of all uclass memberships including the primary (struct
+ *	uclass_member via adj_node)
  * @parent_priv_: The parent's private data for this device (do not access
  *	outside driver model)
  * @child_head: List of children of this device
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index b76797eeabd..ad49d675570 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -28,7 +28,8 @@
  * @uc_drv: The driver for the uclass itself, not to be confused with a
  * 'struct driver'
  * @dev_head: List of devices in this uclass (devices are attached to their
- * uclass when their bind method is called)
+ * uclass when their bind method is called). Adjunct registrations also appear
+ * on this list as standalone struct uclass_member entries.
  * @sibling_node: Next uclass in the linked list of uclasses
  */
 struct uclass {
@@ -39,6 +40,7 @@ struct uclass {
 };
 
 struct driver;
+struct uclass_member;
 struct udevice;
 
 /* Members of this uclass sequence themselves with aliases */
diff --git a/tools/dtoc/dtb_platdata.py b/tools/dtoc/dtb_platdata.py
index a570fd3b9a9..b6b8dd4a477 100644
--- a/tools/dtoc/dtb_platdata.py
+++ b/tools/dtoc/dtb_platdata.py
@@ -769,6 +769,7 @@ class DtbPlatdata():
             self.buf('\t\t.uc_plat = %s,\n' % uclass_plat_name)
         self.list_node('uc_node', uclass.node_refs, node.uclass_seq, indent=2)
         self.buf('\t\t.seq\t= %d,\n' % node.seq)
+        self.buf('\t\t.dev\t= DM_DEVICE_REF(%s),\n' % node.var_name)
         self.buf('\t},\n')
 
         if parent_priv_name:
diff --git a/tools/dtoc/test_dtoc.py b/tools/dtoc/test_dtoc.py
index 6bbf800adec..e4542b174a5 100755
--- a/tools/dtoc/test_dtoc.py
+++ b/tools/dtoc/test_dtoc.py
@@ -566,6 +566,7 @@ DM_DEVICE_INST(i2c) = {
 \t\t\t.next = &DM_UCLASS_REF(i2c)->dev_head,
 \t\t},
 \t\t.seq\t= 4,
+\t\t.dev\t= DM_DEVICE_REF(i2c),
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(i2c)->child_head,
@@ -595,6 +596,7 @@ DM_DEVICE_INST(root) = {
 \t\t\t.next = &DM_UCLASS_REF(root)->dev_head,
 \t\t},
 \t\t.seq\t= 0,
+\t\t.dev\t= DM_DEVICE_REF(root),
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test3)->sibling_node,
@@ -642,6 +644,7 @@ DM_DEVICE_INST(some_bus) = {
 \t\t\t.next = &DM_UCLASS_REF(testbus)->dev_head,
 \t\t},
 \t\t.seq\t= 2,
+\t\t.dev\t= DM_DEVICE_REF(some_bus),
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(test0)->sibling_node,
@@ -673,6 +676,7 @@ DM_DEVICE_INST(spl_test) = {
 \t\t\t.next = &DM_DEVICE_REF(spl_test3)->ucm.uc_node,
 \t\t},
 \t\t.seq\t= 0,
+\t\t.dev\t= DM_DEVICE_REF(spl_test),
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test)->child_head,
@@ -704,6 +708,7 @@ DM_DEVICE_INST(spl_test3) = {
 \t\t\t.next = &DM_UCLASS_REF(misc)->dev_head,
 \t\t},
 \t\t.seq\t= 1,
+\t\t.dev\t= DM_DEVICE_REF(spl_test3),
 \t},
 \t.child_head\t= {
 \t\t.prev = &DM_DEVICE_REF(spl_test3)->child_head,
@@ -754,6 +759,7 @@ DM_DEVICE_INST(test) = {
 \t\t\t.next = &DM_DEVICE_REF(test0)->ucm.uc_node,
 \t\t},
 \t\t.seq\t= 1,
+\t\t.dev\t= DM_DEVICE_REF(test),
 \t},
 \t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test,
 \t.child_head\t= {
@@ -802,6 +808,7 @@ DM_DEVICE_INST(test0) = {
 \t\t\t.next = &DM_UCLASS_REF(testfdt)->dev_head,
 \t\t},
 \t\t.seq\t= 2,
+\t\t.dev\t= DM_DEVICE_REF(test0),
 \t},
 \t.parent_priv_\t= _denx_u_boot_fdt_test_parent_priv_test0,
 \t.child_head\t= {
-- 
2.43.0

