Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB5FC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208128129B;
	Wed, 26 Feb 2025 17:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XoEUByh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B202811DE; Wed, 26 Feb 2025 17:26:41 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F77D81111
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-852050432a8so1246639f.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587197; x=1741191997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tx/qzK845KIE0WwBhnn2Se8ARouMPiW2FIRl7IUEUJc=;
 b=XoEUByh7cuoc6h2JsL+ewk1fYB/2a5nDMnTMAfzMJLrcY/VKHtwTTwVfiBkjHMTF3F
 EjLbZ2BVDzTtK2Fy9coINR8zVSYhsNLi8gUGlXnWSPny2JAhszlvPJ8/zR34gC9973/Z
 kRy7lgIxgOZaTfmEmYjelbPGwJrQcuvy1GTxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587197; x=1741191997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tx/qzK845KIE0WwBhnn2Se8ARouMPiW2FIRl7IUEUJc=;
 b=gs55Kj62OUzzKef4BDXdvaR90IGDv4OZrsJSjupi4UUiX57xlEIMJ14vyGB128r1qG
 rdf1Fq2J6Yc4FNjiqrmi/uX0obaqo2KSEvwPKT8c+JaqU9olfE6sO0a7B4ux3qIL4kR5
 WC+UKMVPxrESclTIxH+AGTB4PlaiXzgaH2UY99IkRZsqR2CVLyekKRx+0bvgpC7+66Pb
 8mjvaQiB2gGcpHPExV2oO6MFH4bW7I0jOBPlr9I2qspejEvYxJfiuqLkV0R3YDPcGrwS
 Jb1sVaNzvui4ebhlODaM6hV7nBUhTmpaewISGSm5LH2DjQlxd6x5MMJO/pvB+stue2zN
 /Fig==
X-Gm-Message-State: AOJu0Ywfj4FEZZ4pKFLSgfkVvzhV1Fp1jLw5bN1h9Q+9J3CEttKvPM7J
 OYxh22j/WxqOdwf3/ecF6jur7Ae3gtoPoCm6+YbH+CznBdWEPlo5HHOeXsy69QuUz/3uJFZmJco
 =
X-Gm-Gg: ASbGncunxtalxRCN4TbNGyqX0x+OwrMkPrQj6fC9ZJEeYRY2oABPZYKgf+fwmxa+GAG
 zawoHRi49ckxZo0l6a2FAdvUayaQYCQ8lSlE8PbtOLLIUXVs1N26j+xn/PDhsbpiZGX4cqO0nfK
 /QkEYvsa+SbbS5gEqc/sB4JOw/stQty+D01xpboe8ashijGPEi/GYQkWPh1UweHzQ72eoVebFKz
 w+vUSa1efVnytLRSOXfnnx2KSNeahWZzUXArP8EnMwGqbcujaWeA0YCi9E/rpfbTITAp5/5BVLE
 kBI1PMOkjaqVA1HmU2g3P49Npd0R7+pwyRrcMvvoLVoW6qwUWuf0kTmbLaUP0vs=
X-Google-Smtp-Source: AGHT+IGPIsw29jtSqkKmvVztVe5APqz25DOOzMRXovzbLtjbc0chHyVCXuh6mMM8j6Vv87N+Y9H0eg==
X-Received: by 2002:a05:6602:3f85:b0:855:b0eb:3fe6 with SMTP id
 ca18e2360f4ac-855da2f7c50mr1872419139f.8.1740587197518; 
 Wed, 26 Feb 2025 08:26:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janne Grunau <j@jannau.net>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] Revert "dm: core: Simplify dm_probe_devices()"
Date: Wed, 26 Feb 2025 09:26:14 -0700
Message-ID: <20250226162621.2681677-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
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

Unfortunately this change was not safe as some devices are bound before
relocation, but we don't want to probe them.

It causes 'raise: Signal # 8 caught' on jerry.

Move the bootstage timer to after autoprobe in initf_dm() since the
trace test does not tolerate any variance.

This reverts commit 21dd873572a01d74bfdfceb7a30b056f8ccba187.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c    |  2 +-
 drivers/core/root.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 2912320054f..baf98fb8ec8 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -828,13 +828,13 @@ static int initf_dm(void)
 
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
 	ret = dm_init_and_scan(true);
-	bootstage_accum(BOOTSTAGE_ID_ACCUM_DM_F);
 	if (ret)
 		return ret;
 
 	ret = dm_autoprobe();
 	if (ret)
 		return ret;
+	bootstage_accum(BOOTSTAGE_ID_ACCUM_DM_F);
 
 	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
 		ret = dm_timer_init();
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 15b8c83fee9..e53381e3b32 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -295,22 +295,29 @@ void *dm_priv_to_rw(void *priv)
  * all its children recursively to do the same.
  *
  * @dev: Device to (maybe) probe
+ * @pre_reloc_only: Probe only devices marked with the DM_FLAG_PRE_RELOC flag
  * Return 0 if OK, -ve on error
  */
-static int dm_probe_devices(struct udevice *dev)
+static int dm_probe_devices(struct udevice *dev, bool pre_reloc_only)
 {
+	ofnode node = dev_ofnode(dev);
 	struct udevice *child;
+	int ret;
 
-	if (dev_get_flags(dev) & DM_FLAG_PROBE_AFTER_BIND) {
-		int ret;
+	if (pre_reloc_only &&
+	    (!ofnode_valid(node) || !ofnode_pre_reloc(node)) &&
+	    !(dev->driver->flags & DM_FLAG_PRE_RELOC))
+		goto probe_children;
 
+	if (dev_get_flags(dev) & DM_FLAG_PROBE_AFTER_BIND) {
 		ret = device_probe(dev);
 		if (ret)
 			return ret;
 	}
 
+probe_children:
 	list_for_each_entry(child, &dev->child_head, sibling_node)
-		dm_probe_devices(child);
+		dm_probe_devices(child, pre_reloc_only);
 
 	return 0;
 }
@@ -319,7 +326,7 @@ int dm_autoprobe(void)
 {
 	int ret;
 
-	ret = dm_probe_devices(gd->dm_root);
+	ret = dm_probe_devices(gd->dm_root, !(gd->flags & GD_FLG_RELOC));
 	if (ret)
 		return log_msg_ret("pro", ret);
 
-- 
2.43.0

