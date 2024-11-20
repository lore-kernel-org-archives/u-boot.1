Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3418D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04860895C7;
	Wed, 20 Nov 2024 16:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fdMdsoVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C209895C7; Wed, 20 Nov 2024 16:37:08 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF39F8942F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a78c242d50so1968365ab.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117022; x=1732721822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QG9Hho4g19d3LRnaTN2WKv3qLECxPD6/RE9tYDxIVng=;
 b=fdMdsoVb9EMCkc0f055zWz7VlhsOP8vUvlF2F9j37oXnz7hz0OuHE6NKr6LjXPxhWl
 wdmnN9asELGaCycx9xK1gI30hP3yoRgX97ArhMKwMnZSg9t2Z1q8tMnBAySlH3s/wAPk
 DYUzR8GT/+R8I2rFuViXFR+WQrKK2y2OobUyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117022; x=1732721822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QG9Hho4g19d3LRnaTN2WKv3qLECxPD6/RE9tYDxIVng=;
 b=qfc4yWIqsh6SlQJVmhN/2LKrWhVvBlQpcUrKV8SQfbCARuMZOswSF13ZIz+2YOKZzS
 U3umYxiy4gRj2CksNZiwoT4cbWN0ecBciWkOUcpxRr2wbD0e1AsALsWARY3SGiqQDyh+
 D1xuwLOHrKqqr+7ni9g/bg5ywcl+JYSrp3NNQtZNcgnb1FP5M/AoVSzAG2C3oP3bcwxx
 tlNNxjqOmcegQwxQAFzN9Sc8/31UxsD6WhErnXVk3u2smLITmFl5as+HaBD9qwzZyvlZ
 +NkT09bgc/3N5uPkfbw9RoD8s8/CEZ8QXveuv0gP//+9NZ2URU4ZcEALoy7Vq3FfHoki
 6/ZQ==
X-Gm-Message-State: AOJu0Yy5mryX0CHZSoqMtdqKTmt4MlbNW1In5wDFpO7BRTCtyVsIhVDg
 bkW6m0+oOBQ7dRTrR9TlncV2ep8seL56v0EKbl2FAzB5BlKQMtTjoUjv5iKcx+Iy/5ZqnlA33RU
 =
X-Google-Smtp-Source: AGHT+IG844ZJi5LgWhsTxLPuR2qjXOLW1nApnvHgjkjpgqFk4fFDLwImC2X7xqnWdRKyFdMgxmNxBw==
X-Received: by 2002:a05:6602:2b12:b0:83a:9820:f26b with SMTP id
 ca18e2360f4ac-83eb5f57f45mr409130839f.2.1732117022051; 
 Wed, 20 Nov 2024 07:37:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df8cccfsm288747139f.6.2024.11.20.07.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:37:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Svyatoslav <clamor95@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/3] common: Move autoprobe out to board init
Date: Wed, 20 Nov 2024 08:36:41 -0700
Message-Id: <20241120153642.861633-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153642.861633-1-sjg@chromium.org>
References: <20241120153642.861633-1-sjg@chromium.org>
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

Rather than doing autoprobe within the driver model code, move it out to
the board-init code. This makes it clear that it is a separate step from
binding devices.

For now this is always done twice, before and after relocation, but we
should discuss whether it might be possible to drop the post-relocation
probe.

For boards with SPL, the autoprobe is still done there as well.

Note that with this change, autoprobe happens after the
EVT_DM_POST_INIT_R/F events are sent, rather than before.

Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add a link to the previous discussion
- Add a summary of the design challenge in the DM docs
- Use a simple return in initr_dm()
- Add a comment to dm_probe_devices()
- Expand comment to dm_autoprobe()

Changes in v2:
- Add autoprobe to SPL also
- Leave the function name the same
- Fix 'Prove' typo
- Update cover letter since SPL is now covered also
- Update the documentation too, with a discussion link

 common/board_f.c                    |  4 ++++
 common/board_r.c                    |  2 +-
 common/spl/spl.c                    |  4 ++++
 doc/develop/driver-model/design.rst | 17 +++++++++++++++++
 drivers/core/root.c                 | 22 +++++++++++++++++++++-
 include/dm/root.h                   | 15 +++++++++++++++
 6 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 1e1aa08530a..974eb4f39e9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -822,6 +822,10 @@ static int initf_dm(void)
 	if (ret)
 		return ret;
 
+	ret = dm_autoprobe();
+	if (ret)
+		return ret;
+
 	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
 		ret = dm_timer_init();
 		if (ret)
diff --git a/common/board_r.c b/common/board_r.c
index 62228a723e1..b761833294f 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -241,7 +241,7 @@ static int initr_dm(void)
 	if (ret)
 		return ret;
 
-	return 0;
+	return dm_autoprobe();
 }
 #endif
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 1ceb63daf31..c4256f237ee 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -500,6 +500,10 @@ static int spl_common_init(bool setup_malloc)
 			debug("dm_init_and_scan() returned error %d\n", ret);
 			return ret;
 		}
+
+		ret = dm_autoprobe();
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 8c2c81d7ac9..92f638a0204 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -842,6 +842,23 @@ steps (see device_probe()):
       cause the uclass to do some housekeeping to record the device as
       activated and 'known' by the uclass.
 
+For some platforms, certain devices must be probed to get the platform into
+a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND
+will be probed immediately after all devices are bound. For now, this happens in
+SPL, before relocation and after relocation. See the call to ``dm_autoprobe()``
+for where this is done.
+
+The auto-probe feature is tricky because it bypasses the normal ordering of
+probing. General, if device A (e.g. video) needs device B (e.g. clock), then
+A's probe() method uses ``clk_get_by_index()`` and B is probed before A. But
+A is only probed when it is used. Therefore care should be taken when using
+auto-probe, limiting it to devices which truly are essential, such as power
+domains or critical clocks.
+
+See here for more discussion of this feature:
+
+:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.272219-1-marex@denx.de/
+
 Running stage
 ^^^^^^^^^^^^^
 
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 2d4f078f97f..045f8fcda65 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -281,6 +281,15 @@ void *dm_priv_to_rw(void *priv)
 }
 #endif
 
+/**
+ * dm_probe_devices() - Check whether to probe a device and all children
+ *
+ * Probes the device if DM_FLAG_PROBE_AFTER_BIND is enabled for it. Then scans
+ * all its children recursively to do the same.
+ *
+ * @dev: Device to (maybe) probe
+ * Return 0 if OK, -ve on error
+ */
 static int dm_probe_devices(struct udevice *dev)
 {
 	struct udevice *child;
@@ -299,6 +308,17 @@ static int dm_probe_devices(struct udevice *dev)
 	return 0;
 }
 
+int dm_autoprobe(void)
+{
+	int ret;
+
+	ret = dm_probe_devices(gd->dm_root);
+	if (ret)
+		return log_msg_ret("pro", ret);
+
+	return 0;
+}
+
 /**
  * dm_scan() - Scan tables to bind devices
  *
@@ -331,7 +351,7 @@ static int dm_scan(bool pre_reloc_only)
 	if (ret)
 		return ret;
 
-	return dm_probe_devices(gd->dm_root);
+	return 0;
 }
 
 int dm_init_and_scan(bool pre_reloc_only)
diff --git a/include/dm/root.h b/include/dm/root.h
index b2f30a842f5..a71a2ebef85 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -136,6 +136,21 @@ int dm_scan_other(bool pre_reloc_only);
  */
 int dm_init_and_scan(bool pre_reloc_only);
 
+/**
+ * dm_autoprobe() - Probe devices which are marked for probe-after-bind
+ *
+ * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
+ * entire tree, so parent nodes need not have the flag set.
+ *
+ * It recursively probes parent nodes, so they do not need to have the flag
+ * set themselves. Since parents are always probed before children, if a child
+ * has the flag set, then its parent (and any devices up the chain to the root
+ * device) will be probed too.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int dm_autoprobe(void);
+
 /**
  * dm_init() - Initialise Driver Model structures
  *
-- 
2.34.1

