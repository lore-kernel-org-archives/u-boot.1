Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E9C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AC581D4F;
	Sat, 15 Mar 2025 15:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAMdgE62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5E880756; Sat, 15 Mar 2025 15:28:34 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B454681E92
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1952369f8f.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048912; x=1742653712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdQoOz1zISe0YJiWCm9sKf7EgPu3JrRFZI2tWCQHhYs=;
 b=jAMdgE628YQufH0oOzyebtuM9ldTXLDW89WtxPszgH/4L9wgKRnD+gMfx1ndXYyi8+
 ehu/N3zJhwB3JVwiZvYONrKZK3bl6UNM+92ANRLHTU0IamI8tP21R11qmjbneqfUuQ2e
 gUTmUSwb5INpHk5Uc7tkq7ooJQjwH/icOykuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048912; x=1742653712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdQoOz1zISe0YJiWCm9sKf7EgPu3JrRFZI2tWCQHhYs=;
 b=fhGa+fikXS1Mtrm15UN236wS7PUji5bderENEzPE6wtF1OyJIWOltF1pgj+dvpQDsk
 rag2GT+5atpZmWMt6vU62f9wjLS9M4wCuyW8FFgiupxa8DgxUibkSuerx442WHTXVlxM
 j7Bz+iZrNvlxhYKbUlTTkLtpkwYg+fOPw5e9ikn1FfxhN3d9J4LRhlhSaBrlNTUfcCoB
 N+HOLsmsasL/QkesH6cpC00Us+iGEVLm8mYwgka97gPLOcZ7UmWXZ0kiy2smRoDaX7yY
 2fjPxragPBRSdgxHgaLmcpy+6JdQHMvhxy3Ebfo/hhh4nZGSd51I7KLYP1CWWxxba9f0
 HYGg==
X-Gm-Message-State: AOJu0YwTh10Yejppr0hGsQrRBFYXS5nnuF38RUm8+zZRpAdAPv7hbKXI
 ESVkSZ6/fbWuFnmnMq7XrFG+uK68SrsuN3k2KWRy1KGe0ayNf7SGdbfSgcyl80sji/8P07P0gK5
 8Ig==
X-Gm-Gg: ASbGncsr1fkq8cLscqlNdSNBFECKVP6VN1jEbaSxQdav7yQiElCZean3P3Dw5rd86S7
 KHx16AfqBKsENHXCrAIQUiIkMi72+DBIbkfsXkWh3CFfcoZXffx0gJlO7hbszUcEAdIbj3VkgEl
 drlSQf28dgMQfZxlzNcs4C/UAiZHtDWwIEoUbYXB+q02ZeReHbPHQmz9qY+fcyZIgLLKpQHNF9S
 G/YKQJ2X9DoEF7+AcUlquMteCw3CwRFEBHga+Ee8cR7aaB26Nq1K6AVsYuuq0bXMnhWGmJpwSU7
 AdrR1Kiz12CbTlt30Nbo10eLDafW/BkYwHxHyerjQQ==
X-Google-Smtp-Source: AGHT+IE1Lfw8vU3oPvd458AqPfmWmbbyt+CfdLx79FT3ZCNvo6jpcaFqMS5vpUF1Er8aviJw8xUApw==
X-Received: by 2002:adf:9bcc:0:b0:391:48d4:bd02 with SMTP id
 ffacd0b85a97d-3971daebc61mr6309677f8f.29.1742048911676; 
 Sat, 15 Mar 2025 07:28:31 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 38/46] boot: Consider non-bootable partitions
Date: Sat, 15 Mar 2025 14:25:58 +0000
Message-ID: <20250315142643.2600605-39-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Any 'bootable' flag in a DOS partition causes boostd to only scan
bootable partitions for that media. This can mean that extlinux.conf
files on the root disk are missed.

Put this logic behind a flag and update the documentation.

For now, the flag is enabled, to preserve existing behaviour. Future
work may provide a command (or some other mechanism) to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Rewrite the commit message
- Enable the flag by default

Changes in v3:
- Add new patch to consider non-bootable partitions

 boot/bootdev-uclass.c            | 4 +++-
 cmd/bootflow.c                   | 2 +-
 doc/develop/bootstd/overview.rst | 5 +++--
 include/bootflow.h               | 2 ++
 test/boot/bootdev.c              | 1 +
 test/boot/bootflow.c             | 5 +++--
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index c39147940b6..9e4c3db2dc1 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -168,8 +168,10 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		 */
 
 	/* if there are bootable partitions, scan only those */
-	} else if (iter->first_bootable >= 0 &&
+	} else if ((iter->flags & BOOTFLOWIF_ONLY_BOOTABLE) &&
+		   iter->first_bootable >= 0 &&
 		   (iter->first_bootable ? !info.bootable : iter->part != 1)) {
+		log_debug("Skipping non-bootable partition %d\n", iter->part);
 		return log_msg_ret("boot", -EINVAL);
 	} else {
 		ret = fs_set_blk_dev_with_part(desc, bflow->part);
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index a89c3bfd9c5..e9ac9746104 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -174,7 +174,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	std->cur_bootflow = NULL;
 
-	flags = 0;
+	flags = BOOTFLOWIF_ONLY_BOOTABLE;
 	if (list)
 		flags |= BOOTFLOWIF_SHOW;
 	if (all)
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index c46bd7a5a90..7bca043791b 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -235,8 +235,9 @@ means that `default_get_bootflow()` is used. This simply obtains the
 block device and calls a bootdev helper function to do the rest. The
 implementation of `bootdev_find_in_blk()` checks the partition table, and
 attempts to read a file from a filesystem on the partition number given by the
-`@iter->part` parameter. If there are any bootable partitions in the table,
-then only bootable partitions are considered.
+`@iter->part` parameter. If there are any bootable partitions in the table and
+the BOOTFLOWIF_ONLY_BOOTABLE flag is set in `@iter->flags`, then only bootable
+partitions are considered.
 
 Each bootdev has a priority, which indicates the order in which it is used,
 if `boot_targets` is not used. Faster bootdevs are used first, since they are
diff --git a/include/bootflow.h b/include/bootflow.h
index d9045bc3dae..2caeb80b878 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -161,6 +161,7 @@ struct bootflow_img {
  * before using it
  * @BOOTFLOWIF_ALL: Return bootflows with errors as well
  * @BOOTFLOWIF_HUNT: Hunt for new bootdevs using the bootdrv hunters
+ * @BOOTFLOWIF_ONLY_BOOTABLE: Only consider partitions marked 'bootable'
  *
  * Internal flags:
  * @BOOTFLOWIF_SINGLE_DEV: (internal) Just scan one bootdev
@@ -177,6 +178,7 @@ enum bootflow_iter_flags_t {
 	BOOTFLOWIF_SHOW			= 1 << 1,
 	BOOTFLOWIF_ALL			= 1 << 2,
 	BOOTFLOWIF_HUNT			= 1 << 3,
+	BOOTFLOWIF_ONLY_BOOTABLE	= BIT(4),
 
 	/*
 	 * flags used internally by standard boot - do not set these when
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 5f07430714e..d5499918249 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -509,6 +509,7 @@ static int bootdev_test_bootable(struct unit_test_state *uts)
 	iter.part = 0;
 	ut_assertok(uclass_get_device_by_name(UCLASS_BLK, "mmc1.blk", &blk));
 	iter.dev = blk;
+	iter.flags = BOOTFLOWIF_ONLY_BOOTABLE;
 	ut_assertok(device_find_next_child(&iter.dev));
 	uclass_first_device(UCLASS_BOOTMETH, &bflow.method);
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 49ef4d0c3ab..1447af2eb14 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -301,8 +301,9 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	/* The first device is mmc2.bootdev which has no media */
 	ut_asserteq(-EPROTONOSUPPORT,
-		    bootflow_scan_first(NULL, NULL, &iter,
-					BOOTFLOWIF_ALL | BOOTFLOWIF_SKIP_GLOBAL, &bflow));
+		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
+					BOOTFLOWIF_SKIP_GLOBAL |
+					BOOTFLOWIF_ONLY_BOOTABLE, &bflow));
 	ut_asserteq(2, iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(0, iter.part);
-- 
2.43.0

