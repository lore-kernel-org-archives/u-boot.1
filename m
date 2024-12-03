Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA94E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF8C89709;
	Wed,  4 Dec 2024 00:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TRgIcgLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480D789709; Wed,  4 Dec 2024 00:47:46 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232EC88F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-841d8dec299so246387739f.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269662; x=1733874462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FjgX98zQ9LiIHYFJUf6V1snK6MplD46fQlGJcvlOq8=;
 b=TRgIcgLeTbW+9w9p3iGin1aKTbCdOjtdQm0LJ0l3DJn9BVZLEz7QCkauQk4t/jiwAt
 FfcQIgXG4pNQk4rBbQXWcYQE11wwMHG5aFGQDF1WbVAUskGxXAo/NXNfi8zoZKmO3t1j
 ebIZ7u1hE94774ULnmAcEYrKPCjaitFNfpNPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269662; x=1733874462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FjgX98zQ9LiIHYFJUf6V1snK6MplD46fQlGJcvlOq8=;
 b=KSvMKcg1mMYGF0kPI3SsoEDxv4M9BZeNjQMYVqg5nycJsURRZl2YtqZqS3tdDcmJKw
 qcZ2uZ6GEKDae0Utk2gRZnMZTqe6Kryr7xHylosdqilmyJhSJOneYh8pqdFZADgOFzxS
 G8vDFEwp3UhV3GHTbSyXKuZm4RYBlMj3jaBRjUQJO+QHJrBSYg0MXMRn7W7qZByCgIVW
 tHCNqRTJ1BaI98Rlxh0M8EA4XBUkaX9jebX4Pz2YnwWsiaBpPtncrrkadm1OIGgKfQ87
 p6VclJaYek+F98nt5adsg2eGANuA8viVDGT7JKCsVb3emYdBpAbjNLKqDTaj/xf2xiZn
 p6MQ==
X-Gm-Message-State: AOJu0YwHW2EMknFmTs4Kld62phVPaET1ubNWST05p+J1tTUT4Euk2A2q
 MSCebKBQLFw10cmOcj8WBr0zAg1l6pEkF8sk2RiJdtJS0D+UBuZIbFPgD7MPNbRfo0qD5CQ1yOk
 =
X-Gm-Gg: ASbGncsOSoEgc98qVJGvWG4DnDBJbhgc/F1bcQRwTPQu5cjCbUot1olLxEpZjfEbyi9
 ZJqDrfHFy/o6WDkrCS6Zd2E7IcnpRIEMbo+/dmGC8a2Z9onrBlhrW7eZH9RWJ3N2s9Jk45QHqX5
 jsJGYiRweLPL2NhofGtdMVA86J6A8oZrT2dJ29PwcoY6cm5Kh3jqybtiZvGd68w0gDjlBtcM2yS
 vaby62nlhUzyXR6spMF8AOt4XjcqxESsxv7U2FMLiZUemDSmVYgRUBk2DtQQY0nmLy/nrhFM1Oi
 wAjL5/fmOIs=
X-Google-Smtp-Source: AGHT+IFyhF+6psWaSfRMQcRWnjeLBiMbs1D1meVDfk8gqiAmuTBaMA1PvzvOtQW1DIBwXoP2kIL7sw==
X-Received: by 2002:a05:6602:1484:b0:82c:ed57:ebd9 with SMTP id
 ca18e2360f4ac-8445b5cb75dmr484200239f.10.1733269662443; 
 Tue, 03 Dec 2024 15:47:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 32/41] bootmeth_extlinux: Move pxe_context into plat
Date: Tue,  3 Dec 2024 16:45:50 -0700
Message-Id: <20241203234559.2938192-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index e2050af8203..144f5a11425 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -27,9 +27,11 @@
  *
  * @use_fallback: true to boot with the fallback option
  * @info: Info passed to the extlinux_getfile() function
+ * @ctx: holds the PXE context, if it should be saved
  */
 struct extlinux_plat {
 	bool use_fallback;
+	struct pxe_context ctx;
 	struct extlinux_info info;
 };
 
@@ -183,7 +185,6 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context ctx;
 	ulong addr;
 	int ret;
 
@@ -192,12 +193,12 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	plat->info.dev = dev;
 	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+	ret = pxe_setup_ctx(&plat->ctx, extlinux_getfile, &plat->info, true,
 			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-	ret = pxe_process(&ctx, addr, false);
+	ret = pxe_process(&plat->ctx, addr, false);
 	if (ret)
 		return log_msg_ret("bread", -EINVAL);
 
-- 
2.34.1

