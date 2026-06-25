Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1352CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6F684979;
	Thu, 25 Jun 2026 19:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQD1BrXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5810847C8; Thu, 25 Jun 2026 19:41:36 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C29846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yordy1902@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-46caaa805b2so12383f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782409294; x=1783014094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4q3kqBKSoU2iT7cmM32hL+hegKeEUaVALBLKa/6aNAE=;
 b=kQD1BrXQFFsHCYmCpbXA40CQHnsuW48Mx00CsQNmxc+VZ6Ikd0vC2o1WCL/KNRLdk7
 g5EQImICezXCO35AJlmJkHeCt9/VL46dxEq+b6HTOG2Mt/h5ccAh+UyDmxhgBMw5flNJ
 0lbQgeoKUIiOt+0dDJIoeJQTlQ293Y3RsvUL/6sNwqnnguk3AOCCTcn+UYco0Ih2xWrz
 mRsM8gNr+ulch8a8MpBHXQ13BbxIH6RTzQJ6vxDSwzu/drQX3qcTY4N4RaWyHsAVrD+d
 +XVJ/bomCJIMh+qAUBAh+MMpz6F7q0XGdQQGJITZtveQT9y6FIdDmlBnu2/lRqGI4gWI
 /RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409294; x=1783014094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4q3kqBKSoU2iT7cmM32hL+hegKeEUaVALBLKa/6aNAE=;
 b=jqU0DdzwY6TgDopa6LqP5nGp+XRcY+hytu1lTYrtb1mr70rWSDsQz6ubJosZnp2x+b
 MGoqV9NtvI7gTwiic2y76JWsoQL05H5sSV077W3wQPeFMi+OPq9NblismhOA4JtfngAV
 LfX0MmX/ttUwc623EhLjgRnDONVoSMR9zYgWwo80HQOlENnTUjhKP5VgwWoH2hd/jbAB
 6dqYzoLjYI10gWa+5e/+okJSKA/b4EBXdvzKRxFtyAV6rOvKKXLRjoeMuFhzo0CuyaHL
 4uEUZFqQUVZ+xriwPEZ5ic3SJwnWpq+hMxWP0lCMcvtIwduZXTtbvEveF7GtsLKVjzC6
 RNbQ==
X-Gm-Message-State: AOJu0YxH/SRrbRkzllJgyIFGIxaCbb90vGA5KJBfEecSwc+zjeuE8DW8
 8DvHtXMtG20wOutKLBMloC2XvzP6mkJPmPaB9Y5MM1BnP5gu+4uTjzUy0ITTOBNa
X-Gm-Gg: AfdE7cm6YSkissZovLEldYClfX2Thd4C1eV3PEdIRH+JB0s2HUr8H3UpprgrXSRiWfw
 Em5Cmz6MO6MQhPEs8taAOBiVMdoiBB1BSkDxItVw+zhyLy43qjOltXIabBAH3fMZBvMe+poz3J0
 1jo1jqdHUT8gULE34lP8S+UNJFIXspibokAgcoO15rOPAIdvi4g5OhLq5ChIUfayGzG547I+ywt
 /35ifCYU9NbTYs0a9BpWQQJka3tz9Pwtm1AE4u0+cwD+GXnn01mzXRdEFPwFW8eQAZQeRiqp9//
 D3jD4EBl1Nny4GSXyJt40nz62tHMepY6SXlgKrYQDIaRqVoBAzgWuuzyENF/KSrjVaWGv+vwmyJ
 HICgywfOAK1STlXy6uAd8+p0aFg62Izt8hX8Fm07/VZyIgm4HqGn1+T1WOzstCHIpKNWNwiIm7U
 4L7sdiqDBpQGq1ZrRxF8rYKqwWkUEe5+T6zbi8heVmCbqwlQhw0KUeRto=
X-Received: by 2002:a05:6000:2893:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-46dc0d0ea60mr5630332f8f.22.1782409293827; 
 Thu, 25 Jun 2026 10:41:33 -0700 (PDT)
Received: from FV4JTM0LIN.. (205.red-79-156-71.staticip.rima-tde.net.
 [79.156.71.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e95f3d71fsm1280876f8f.12.2026.06.25.10.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:41:33 -0700 (PDT)
From: Jordi Trepat Mur <yordy1902@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com, nm@ti.com,
 anshuld@ti.com, Jordi Trepat Mur <yordy1902@gmail.com>
Subject: [PATCH v2] pinctrl: single: parse gpio-range as a raw array (O(N^2)
 -> O(N))
Date: Thu, 25 Jun 2026 19:41:21 +0200
Message-Id: <20260625174121.3633162-1-yordy1902@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614103232.3586246-1-yordy1902@gmail.com>
References: <20260614103232.3586246-1-yordy1902@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:16 +0200
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

single_add_gpio_func() calls ofnode_parse_phandle_with_args() once per
gpio-range entry. With a flat device tree, every call re-iterates the
property from index 0 and, because cellname is set, performs an
fdt_node_offset_by_phandle() (a full-FDT scan) at every step. The total
cost is therefore quadratic in the number of entries and proportional to
the size of the device tree.

The impact depends on when the pinctrl is probed. On the J722S EVM
defconfig, pinctrl@f4000 (main_pmx0, the SoC's stock 7-entry gpio-range)
is probed after relocation (caches on): single_add_gpio_func() takes
~18 ms there and ~1 ms with this change. When the node is probed before
relocation (caches off) the same parse takes hundreds of ms; on a board
that probes it pre-relocation and runs LPDDR4 clocked down it reached
723 ms, cut to 22 ms here. Any pinctrl-single user with a populated
gpio-range property pays this cost.

The phandle target is never dereferenced by this function (only the
argument cells are stored), so resolve it only for the first entry to
learn the per-entry cell count, then read the argument cells directly
with ofnode_read_u32_index() and allocate the ranges in one block. A
zero phandle still terminates the list, as in the original loop. This
follows the existing pinctrl-single,gpio-range usage observed in current
DTs, where entries use the same provider and therefore a uniform
per-entry cell count.

Signed-off-by: Jordi Trepat Mur <yordy1902@gmail.com>
---
Changes in v2:
 - Restore terminate-on-zero-phandle: the original breaks on the first
   ofnode_parse_phandle_with_args() error and a zero phandle is one such
   error, so v1's "skip" was a behaviour change (Simon Glass).
 - Drop the args_count and size-multiple -EINVAL paths; malformed or
   partial data no longer turns into a hard probe failure and is handled
   leniently, as before (Simon Glass).
 - Read the argument cells with ofnode_read_u32_index() instead of an
   open-coded be32_to_cpup() walk; works for OF_LIVE too (Simon Glass).
 - Coalesce the per-entry devm_kzalloc() into a single devm_kcalloc()
   (Anshul Dalal, Simon Glass).
 - Drop the unused ret_total; reuse the single ret (Anshul, Simon).
 - Use single-space field assignment, matching the file (Anshul, Simon).
 drivers/pinctrl/pinctrl-single.c | 79 +++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 42980e09..0029a7e1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -509,29 +509,74 @@ static int single_add_gpio_func(struct udevice *dev)
 	struct single_priv *priv = dev_get_priv(dev);
 	const char *propname = "pinctrl-single,gpio-range";
 	const char *cellname = "#pinctrl-single,gpio-range-cells";
+	ofnode node = dev_ofnode(dev);
 	struct single_gpiofunc_range *range;
 	struct ofnode_phandle_args gpiospec;
-	int ret, i;
-
-	for (i = 0; ; i++) {
-		ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), propname,
-						     cellname, 0, i, &gpiospec);
-		/* Do not treat it as error. Only treat it as end condition. */
-		if (ret) {
-			ret = 0;
+	int size, total_cells, cells_per_entry, entries, ret, i;
+
+	/*
+	 * The original loop called ofnode_parse_phandle_with_args() once per
+	 * entry. On a flat DT each call resolves the phandle, which scans the
+	 * whole tree, so the repeated parse is quadratic in the number of
+	 * entries and proportional to the tree size. This is very slow
+	 * pre-relocation with caches off.
+	 *
+	 * The phandle target is not used here (only the argument cells are
+	 * stored), so resolve it only for the first entry to learn the
+	 * per-entry cell count, then read the argument cells directly. This
+	 * follows the existing pinctrl-single,gpio-range usage observed in
+	 * current DTs, where entries use the same provider and therefore a
+	 * uniform per-entry cell count.
+	 */
+	ret = ofnode_parse_phandle_with_args(node, propname, cellname, 0, 0,
+					     &gpiospec);
+	if (ret)
+		return 0;
+	if (gpiospec.args_count != 3)
+		return 0;
+
+	cells_per_entry = 1 + gpiospec.args_count;
+	size = ofnode_read_size(node, propname);
+	if (size < (int)sizeof(u32))
+		return 0;
+	total_cells = size / sizeof(u32);
+	entries = total_cells / cells_per_entry;
+	if (!entries)
+		return 0;
+
+	range = devm_kcalloc(dev, entries, sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	for (i = 0; i < entries; i++) {
+		int base = i * cells_per_entry;
+		u32 phandle;
+
+		ret = ofnode_read_u32_index(node, propname, base, &phandle);
+		if (ret)
 			break;
-		}
-		range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
-		if (!range) {
-			ret = -ENOMEM;
+
+		/* A zero phandle terminates the list, as in the original loop. */
+		if (!phandle)
 			break;
-		}
-		range->offset = gpiospec.args[0];
-		range->npins = gpiospec.args[1];
-		range->gpiofunc = gpiospec.args[2];
+
+		ret = ofnode_read_u32_index(node, propname, base + 1, &range->offset);
+		if (ret)
+			break;
+
+		ret = ofnode_read_u32_index(node, propname, base + 2, &range->npins);
+		if (ret)
+			break;
+
+		ret = ofnode_read_u32_index(node, propname, base + 3, &range->gpiofunc);
+		if (ret)
+			break;
+
 		list_add_tail(&range->node, &priv->gpiofuncs);
+		range++;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int single_probe(struct udevice *dev)
-- 
2.34.1

