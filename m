Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0AC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13A381DF6;
	Thu,  6 Mar 2025 17:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aA7XU2f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE2181335; Thu,  6 Mar 2025 17:06:12 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69266805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85ada0cf40fso22242339f.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277168; x=1741881968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqBsBOBK65Bl0pmA3ZZFejM9O0QfsYRh1N+g1mywSQk=;
 b=aA7XU2f2/xjWtJ4zrPo5GqUr7jUMn6Gl3mbOcxock02AhDhcsldruMuoL0p6RavX91
 TIHReTe3CvvOD6qEnwnIpVCFA+iDIBweatQfJcBTZNdwzOB0C0Az5B1wm4yybhrUScsu
 fbbqG+QCVEj3otCGVn6UbwoH53EAbcPeHtd60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277168; x=1741881968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqBsBOBK65Bl0pmA3ZZFejM9O0QfsYRh1N+g1mywSQk=;
 b=Mnrs58h0aZZxnDzFk43qBFm50psQgkTa2nfHrCtugLeFI7sG68PGXmYc518YW7dZDU
 lf3+JPHvvXAbFmWa5o3Eny436shcSWlEYeZ5LCRQ2Vb+T4Mpk2Fdt0V11VVoeg//nubL
 wGgpL2T0I0eEMgTofCVjtySD1JPx+B/BdXjq0+CuvyWH2rpWQa8U53BoGIXVzPoway8n
 fKz8rmjqzG8RAvkLa7gywqqaIFCNsFrXq8ZQodVLJs/DJg2z7jZAi/ruRABNo5eDQMtH
 uRVIyphHNv//gUVq4+dzuJhAskwCEEoo9Y8cpFa4iguhdj2Ys4zPFJZCxQmc4YQXi1+F
 c8SA==
X-Gm-Message-State: AOJu0YyZ+CGjSkfquG4EN/KapuCQLWFywk9g0zK0IE0U4ACBsN0NPamL
 NE32ZdG6uGtAtNAWH9Nv2H3dFB1P3WbpU+DloM7pgb0zl2HOaiaT5aZVqXTJ2S6+YDpsu6fxND8
 =
X-Gm-Gg: ASbGncu425OCWBug3jV5xHjdhMLzh3I+XI+uYe2xTMP0PHXV7XnEZZrr9AszpVyaivm
 TZCOJSlREE/HU+U37/tcmlog9RKGU27jbHaCxBVrH6Sc1DeM+9UJjxQzsizGvDplZwh6UbYlgDe
 bcfeWHQ3NOK3vNk02ymcxYgUIRYn63gCx1jdhOBgZCX85IZuT5tf2eBYqQeA28E9ontKOhKZUbt
 AfE3qznftDsqPcMfwHjYjRmvrM3r/FhnnA2PM7rsjFu45jdYRSbiUM+8bAOLyKFGu7ivXTgBng3
 p9Z0rAv79FYNJIqgYMPGz2PgyxlAUHZZTNPASO+bIeEsotXRDYKbs9w9kG7lI2Pa7wC4Ums/jZx
 5/IrIcA==
X-Google-Smtp-Source: AGHT+IF5jtz+paPC3+LPnlv1NOD1wbfufO6Ud1PnDpHgw/se0vH6cg5KcX3D+NXVWCgr4t5eEm9sAg==
X-Received: by 2002:a05:6e02:18cb:b0:3d1:883c:6e86 with SMTP id
 e9e14a558f8ab-3d4419b2b3fmr202035ab.8.1741277167660; 
 Thu, 06 Mar 2025 08:06:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 38/47] boot: Consider non-bootable partitions
Date: Thu,  6 Mar 2025 09:04:05 -0700
Message-ID: <20250306160428.3041057-39-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

