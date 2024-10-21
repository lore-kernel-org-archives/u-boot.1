Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E54CD15DB4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4352888F6B;
	Mon, 21 Oct 2024 17:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mEVWnVNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3026188E3A; Mon, 21 Oct 2024 17:51:54 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C8D88F01
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso5603240a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729525911; x=1730130711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doKhn3icG1vdoS6mi1lkX0bbPvp71388IvqtQdBj3yY=;
 b=mEVWnVNyMAW0JLsulMpcIjHGOUPIHvhQjwEPVuvkaGTFXmtJzFrAXM3De/R0O/m1o3
 IL/Ye4WbdcYPda5jHg/S3FZHLUtE/kUQbsFpSM8za5QfuTmCC2xdWCxO1y4oKgFrq2go
 ZGVMCp8G8XF14vVdAmxQaqclxRC7BSnQ70xZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525911; x=1730130711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doKhn3icG1vdoS6mi1lkX0bbPvp71388IvqtQdBj3yY=;
 b=qR/kdxUSlRO1oxk193YmC/gOZaEzUuqs36TtepBB+d2+STKqXL3kmShNzrybq8j12Y
 V25AnDJc2jjswc1zw5N6Sm3P3BnenLk/uWiQL81v7aLS62u/agt4v+V6i9ZJVHcFDbL8
 MsR1KMFlkUqhGF2xajjJ7thziQUob37IfBmg4f6SXl9VvrPNNXl4IMQv3p/AtQsgmSQD
 KXOPXbqPkS4QyJ3HorhIN4E8vPxRrefICgIULqUjgq7989B1sntYzDQRuFp5hj+cZZke
 19bFwT1QnsISwO9USG8Qp3aXP64QSel/6yskXF5l4T3yPsVZ0AhC34DxXoNz3CpHcZoX
 7UjQ==
X-Gm-Message-State: AOJu0Yy4564uFP7mz22Vh3+MTvWcfGDvKdknXReEDg/2+y2VvbDhb4tT
 tt6J1fQy7/kHiGCGfvv/1sWZB3qWIkLeG7i2y3x7cYWBkrLNnmxoLDs5YDdZjIqpy9m1nwEUwpj
 nPzNT
X-Google-Smtp-Source: AGHT+IFFriuxsKIhuusSgiuS2ym0OaIujsnAaFVt3ICXh8299enqBNOQnjifgZYGYvMhb8EXoxqN0g==
X-Received: by 2002:a05:6402:2110:b0:5c2:6d16:ad5e with SMTP id
 4fb4d7f45d1cf-5ca0ac63325mr9407483a12.19.1729525911027; 
 Mon, 21 Oct 2024 08:51:51 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d798sm2143886a12.50.2024.10.21.08.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:51:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] common: Move autoprobe out to board init
Date: Mon, 21 Oct 2024 17:51:31 +0200
Message-ID: <20241021155133.29557-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021155133.29557-1-sjg@chromium.org>
References: <20241021155133.29557-1-sjg@chromium.org>
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

This patch also drops autoprobe from SPL. If that is needed, we could
add a call in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c    |  4 ++++
 common/board_r.c    |  4 ++++
 drivers/core/root.c | 17 ++++++++++++++---
 include/dm/root.h   | 10 ++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 8684ed71284..6564b2ac2f7 100644
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
index e5f33f40643..a2948b7b55c 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -243,6 +243,10 @@ static int initr_dm(void)
 	if (ret)
 		return ret;
 
+	ret = dm_autoprobe();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 #endif
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 2d4f078f97f..f6bda84b2b9 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -281,7 +281,7 @@ void *dm_priv_to_rw(void *priv)
 }
 #endif
 
-static int dm_probe_devices(struct udevice *dev)
+static int dm_probe_devices_(struct udevice *dev)
 {
 	struct udevice *child;
 
@@ -294,7 +294,18 @@ static int dm_probe_devices(struct udevice *dev)
 	}
 
 	list_for_each_entry(child, &dev->child_head, sibling_node)
-		dm_probe_devices(child);
+		dm_probe_devices_(child);
+
+	return 0;
+}
+
+int dm_autoprobe(void)
+{
+	int ret;
+
+	ret = dm_probe_devices_(gd->dm_root);
+	if (ret)
+		return log_msg_ret("pro", ret);
 
 	return 0;
 }
@@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
 	if (ret)
 		return ret;
 
-	return dm_probe_devices(gd->dm_root);
+	return 0;
 }
 
 int dm_init_and_scan(bool pre_reloc_only)
diff --git a/include/dm/root.h b/include/dm/root.h
index b2f30a842f5..2ba5104ce1f 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
  */
 int dm_init_and_scan(bool pre_reloc_only);
 
+/**
+ * dm_autoprobe() - Prove devices which are marked for probe-after-bind
+ *
+ * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
+ * entire tree, so parent nodes need not have the flag set.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int dm_autoprobe(void);
+
 /**
  * dm_init() - Initialise Driver Model structures
  *
-- 
2.43.0

