Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873F8CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71CB83A64;
	Mon, 19 Jan 2026 20:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gzb045wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AEFE839E2; Mon, 19 Jan 2026 20:07:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B66D83981
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A17A14344C;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81475C2BC87;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=SHeUuTRd+6r2DDsN3KD/V1SH2f6ckGBfSKR04gsa9pA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gzb045wN2ae6cLm5WxTYokuj9cikuo5KY63Q15lycMRJ6RSjx0/o6qhwhEnB/CWI4
 D2zYtoUYKcWYeZBZ03pxzxAjC7baYV9nD8EoxMYUP3CPH3H4IITLLDrd5AYtpa5qFx
 2Ic5FFjHTdPY9ERW3ZtvbrYlUkpLd/AC/S29SRY+jNgBw8dj212HNnwo0rpIdoLTlK
 3ipI6121FZj5fTvhWe+XZmzTSNN8d6T8llpJvf31ObjO1TWCEvvPaoZ6+nJTDQwSGj
 qgPiResgadnPGnAqCx2VKu/wY4urm0KVG3MGSPw7VFA6hIKHWmr/ynRRm+ti5PlON/
 06/n+oS8lolXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 779A2D29C4D;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Jan 2026 03:07:22 +0800
Subject: [PATCH v3 5/6] clk: allow assigning parent lazily
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-clk-reparent-v3-5-0d43d4b362ac@outlook.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=4923;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=5LNlJejSZamN5MUcEZo/X0XtiDziAhgS2uQ4xElUkDA=;
 b=h/mxQjHVYvNPa52tC3i7BMUkAf+1++db0/ngpfJIcAma7jj38G46+v8hNvhKZvEnYDgKx6OmH
 0lvDpai+EEHBpvfW05WK0T7n/r1PlT6X4/a1/c4fhB5QFPlnmpqOW2F
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Don't mandate the parent device exists when registering a clock.

Instead, cache the parent name in the core clk struct and resolve the
parent in clk_get_parent(), which is called lazily upon real use.

Disable this feature for xPLs by default to save size.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/Kconfig      | 12 ++++++++++++
 drivers/clk/clk-uclass.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/clk.c        | 14 ++++++++++++--
 include/clk.h            |  2 ++
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ae783254008c..5a57adef3ccb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -51,6 +51,18 @@ config VPL_CLK
 	  setting up clocks within TPL, and allows the same drivers to be
 	  used as U-Boot proper.
 
+config CLK_LAZY_REPARENT
+	bool "Enable clock lazy reparenting feature"
+	depends on CLK_CCF
+	default n if SPL_CLK || TPL_CLK || VPL_CLK
+	default y
+	help
+	  This option allows registering clocks in a less strict order that
+	  Parent clocks can be registered before their children. The clock subsystem
+	  will cache the parent's name and resolve it to the real parent device "lazily".
+	  This is the default behavior in Linux clock subsystem. Enabling this feature
+	  should simplifies the porting of Linux clock drivers to U-Boot.
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 297d4d63a579..a7f02d339a55 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -495,6 +495,32 @@ ulong clk_get_rate(struct clk *clk)
 	return ops->get_rate(clk);
 }
 
+static struct udevice *clk_reparent(struct clk *clk, const char *parent_name)
+{
+	struct udevice *pdev;
+	int ret;
+
+	if (!clk_valid(clk))
+		return NULL;
+
+	if (!parent_name)
+		return NULL;
+
+	debug("%s(clk=%p) reparenting to %s\n", __func__, clk, parent_name);
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &pdev);
+	if (ret) {
+		log_err("%s(clk=%p) failed to find parent \"%s\"\n", __func__, clk, parent_name);
+		return NULL;
+	}
+
+	ret = device_reparent(clk->dev, pdev);
+	if (ret)
+		return NULL;
+
+	return pdev;
+}
+
 struct clk *clk_get_parent(struct clk *clk)
 {
 	struct udevice *pdev;
@@ -505,8 +531,18 @@ struct clk *clk_get_parent(struct clk *clk)
 		return NULL;
 
 	pdev = dev_get_parent(clk->dev);
-	if (!pdev)
-		return ERR_PTR(-ENODEV);
+	if (!pdev) {
+		if (CONFIG_IS_ENABLED(CLK_LAZY_REPARENT)) {
+			pdev = clk_reparent(clk, clk->parent_name);
+			free(clk->parent_name);
+			clk->parent_name = NULL;
+
+			if (!pdev)
+				return ERR_PTR(-ENODEV);
+		} else {
+			return ERR_PTR(-ENODEV);
+		}
+	}
 
 	if (device_get_uclass_id(pdev) != UCLASS_CLK)
 		return ERR_PTR(-ENODEV);
@@ -630,6 +666,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	debug("%s(clk=%p, parent=%p)\n", __func__, clk, parent);
 	if (!clk_valid(clk))
 		return 0;
+
+	free(clk->parent_name);
+	clk->parent_name = NULL;
+
 	ops = clk_dev_ops(clk->dev);
 
 	if (!ops->set_parent)
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b8c2e8d531b9..32b3c03ab09a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,8 +24,18 @@ int clk_register(struct clk *clk, const char *drv_name,
 	if (parent_name) {
 		ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
 		if (ret) {
-			log_err("%s: failed to get %s device (parent of %s)\n",
-				__func__, parent_name, name);
+			log_debug("%s: failed to get %s device (parent of %s)\n",
+				  __func__, parent_name, name);
+
+			if (CONFIG_IS_ENABLED(CLK_LAZY_REPARENT)) {
+				/*
+				 * The parent is not yet registered.
+				 * Cache the parent name and resolve it later.
+				 */
+				clk->parent_name = strdup(parent_name);
+				if (!clk->parent_name)
+					return -ENOMEM;
+			}
 		} else {
 			log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
 				  parent->name, parent);
diff --git a/include/clk.h b/include/clk.h
index 90b42a618675..88db75c56d44 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -47,6 +47,7 @@ struct udevice;
 /**
  * struct clk - A handle to (allowing control of) a single clock.
  * @dev: The device which implements the clock signal.
+ * @parent_name: The name of the parent.
  * @rate: The clock rate (in HZ).
  * @flags: Flags used across common clock structure (e.g. %CLK_)
  *         Clock IP blocks specific flags (i.e. mux, div, gate, etc) are defined
@@ -72,6 +73,7 @@ struct udevice;
  */
 struct clk {
 	struct udevice *dev;
+	char *parent_name;
 	long long rate;	/* in HZ */
 	u32 flags;
 	int enable_count;

-- 
2.43.0


