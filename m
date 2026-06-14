Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DCBCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 14:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB62783FEE;
	Sun, 14 Jun 2026 16:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHQkI4PV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E79183FEE; Sun, 14 Jun 2026 12:33:29 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08247800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 12:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yordy1902@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1271283f8f.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781433206; x=1782038006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gNYUcEu2Vgbf4T/2hX1VQZyg9lFckOgYGHNIyRPbOsE=;
 b=LHQkI4PVSb70OHsphsdFEHfeVyuZtXy6eph4ymrO88w8RTVuQevDXdSyQnC8Zc9XRt
 XO2KKNOf0WFvDq/GIoVSucCC/XOCWVyAdxJa9HRA9V1HyvTYRLe4wlK7/nK0WZ7XL3BQ
 LKIdnHWUposlbEK5qZ3/ieb+TT/MQ7FEz7HI38jGTvbkRZEjuxmpihci7X3JuGcJFne/
 t8IafgiPeshnhgLwDooU6hFhtfXdhn6fDjt11T2QpGIfffv/dIb8xd/onLb0PiNOmRFv
 4yS61SkF+0fN5+E1du62L/ZSsvmVlOBoUTKJla3NfCCHCtijMvS20YL798nDXistTzov
 v/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781433206; x=1782038006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNYUcEu2Vgbf4T/2hX1VQZyg9lFckOgYGHNIyRPbOsE=;
 b=bgdsz0Ark15iQCv1IiCnXLiUNUEWoLHqP1fdm813j2bIK/8N41hyydZ1UrJ4F6sqUF
 V3akiYsUj8Ut+ew+MYTYUeQTYwA9PSVBeOytwjKEvNksDIyXI7PYJ5hvt/xC46fY6/Iy
 1MdpM4u8euBEE6ic9VLyGjfn5KX5yPS0PWZP9Xnn2sikLsd0LyEBwhK7uO+hNwx9zwj0
 5SVbRoKhx680PHDJjjOmzz0YU9wE2BXI4IjnLIaoph8HAhEZAkMOPPwtSozx33xqpJf/
 Dn0Kf9lvHnWGePNqnw4GXzYsAoRB770N6vzR5Hdb+oDvXPciM6X7iM0cXUFCNOnWVAON
 YMvA==
X-Gm-Message-State: AOJu0YwsPsa/HPzs4UekboyErKVd2Cyrly2vqsy315cDCb9j9IWdG7nI
 57HQaRj1KU7E8XJWcq5eoI4BA6VC75hdSP05CND8sFz79XNuDLn1Adme8Yag9eSb
X-Gm-Gg: Acq92OFecsgUwU7c4cKrufPopjuGSg1oSqaB1CLAKSLqHv5+GSpSoGgxCOVV1eCb/LC
 1g+Nmw1PMC/XDc5Rsr6O8THJWhpZJ7lrENjXPkl59FNoOOUmhmJnRGEh2Vnqejm4PmhN/m46ZBu
 o5b/Cry/oFHeF0d6KkMK6afpP3VALPTwWpZQH5O8IAmFJFR7j42xF6dqqkQy7pBhx8foCUMcX+V
 gA2l8k7VDKu7Dm2iXp0wGJDMm6CWyKTZQn2lSNiC82ZxpcRaQctbK8t8j0MbjwQB5unvaIBhiO6
 XM/HVhITy1pof9KGcn2oTcaDXwaEqM6phfR+105K/doFFxwEeiw+EOogu4gjbxeh5cn/ujnmTdV
 JFk7nhTIdNRIJg+0zktJHwIhr8KGqghpe4lapT6kC6Eeh7/Ssn1pICc30eRpcn92rgJNOWNPbLR
 t68t/JfDjqg4LwlBBSzsNazWMP6SeCSoY=
X-Received: by 2002:a5d:5e8c:0:b0:460:51f6:6248 with SMTP id
 ffacd0b85a97d-4606dbc695bmr13041892f8f.27.1781433206220; 
 Sun, 14 Jun 2026 03:33:26 -0700 (PDT)
Received: from FV4JTM0LIN.ficosa.com ([185.23.223.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263950sm24014588f8f.7.2026.06.14.03.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:33:25 -0700 (PDT)
From: Jordi Trepat Mur <yordy1902@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com, nm@ti.com,
 Jordi Trepat Mur <yordy1902@gmail.com>
Subject: [PATCH] pinctrl: single: parse gpio-range as a raw array (O(N^2) ->
 O(N))
Date: Sun, 14 Jun 2026 12:32:32 +0200
Message-Id: <20260614103232.3586246-1-yordy1902@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 16:04:46 +0200
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
cost is therefore quadratic in the number of entries and proportional
to the size of the device tree.

On a TI J722S board this makes the pinctrl probe take 723 ms
pre-relocation (caches off) for only 7 entries; with this change it
takes 22 ms (-97%). Any pinctrl-single user with a populated
pinctrl-single,gpio-range property pays this cost.

Read the property once with ofnode_get_property() and iterate over the
raw cells in memory instead. The phandle target node is never used by
this function (only the three argument cells are stored), so resolve
only the first entry with ofnode_parse_phandle_with_args() to validate
the cell layout. Empty entries (phandle == 0) are skipped, matching the
previous behaviour.

Tested on TI J722S (HS-FS): pinctrl probe 723 ms -> 22 ms, identical
gpio-range list produced.

Signed-off-by: Jordi Trepat Mur <yordy1902@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 62 ++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 42980e09..44297951 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
 	const char *cellname = "#pinctrl-single,gpio-range-cells";
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
-			break;
+	const __be32 *list;
+	int size, total_cells, cells_per_entry, entries, ret, i;
+	int ret_total = 0;
+
+	/*
+	 * Read the property once and iterate over the raw cell array in
+	 * memory. Calling ofnode_parse_phandle_with_args() once per index
+	 * re-walks the property from the start on every call and resolves
+	 * the phandle (a full-FDT scan) at each step, which is O(N^2) in
+	 * the number of entries and very slow pre-relocation with caches
+	 * off. Resolve only the first entry's phandle to validate the
+	 * cell layout; the target node itself is never used here.
+	 */
+	list = ofnode_get_property(dev_ofnode(dev), propname, &size);
+	if (!list || size <= 0)
+		return 0;
+	total_cells = size / sizeof(*list);
+
+	/* Validate cell layout via the first entry (one phandle lookup total). */
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), propname,
+					     cellname, 0, 0, &gpiospec);
+	if (ret)
+		return 0;
+	if (gpiospec.args_count != 3) {
+		dev_err(dev, "expected 3 gpio-range args/entry, got %d\n",
+			gpiospec.args_count);
+		return -EINVAL;
+	}
+	cells_per_entry = 1 + gpiospec.args_count;	/* phandle + args */
+	if (total_cells % cells_per_entry) {
+		dev_err(dev, "gpio-range size %d cells not multiple of %d\n",
+			total_cells, cells_per_entry);
+		return -EINVAL;
+	}
+	entries = total_cells / cells_per_entry;
+
+	for (i = 0; i < entries; i++) {
+		const __be32 *entry = list + i * cells_per_entry;
+		u32 phandle_i = be32_to_cpup(entry + 0);
+
+		if (phandle_i == 0) {
+			/* empty entry - match original: skip without creating range */
+			continue;
 		}
 		range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
 		if (!range) {
-			ret = -ENOMEM;
+			ret_total = -ENOMEM;
 			break;
 		}
-		range->offset = gpiospec.args[0];
-		range->npins = gpiospec.args[1];
-		range->gpiofunc = gpiospec.args[2];
+		range->offset   = be32_to_cpup(entry + 1);
+		range->npins    = be32_to_cpup(entry + 2);
+		range->gpiofunc = be32_to_cpup(entry + 3);
 		list_add_tail(&range->node, &priv->gpiofuncs);
 	}
-	return ret;
+	return ret_total;
 }
 
 static int single_probe(struct udevice *dev)
-- 
2.34.1

