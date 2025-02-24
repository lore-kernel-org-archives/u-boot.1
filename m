Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC3EC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40647811D8;
	Tue, 25 Feb 2025 00:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IWsVwiSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210D881219; Tue, 25 Feb 2025 00:08:17 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B440980F91
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3ce85545983so14992315ab.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438493; x=1741043293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRmykzopbjSa1RTO/3DxwYH0svGjzv33YVri2u5WkSc=;
 b=IWsVwiStztz3ZpfMdOvOClFpVbm1LpAugriRPVM3R69VT6Zn4RmtOmcVVN2UP/gz5J
 72OopjPJRD/WIpROEgzpcfk8mr7MyE4TzVqcfqY0Pdg5/gtIsifl5hB1q5alD1YN8JIq
 rhIfYvDkVi8+GCOb/spW0FaWuOn9h2ndsiebM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438493; x=1741043293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRmykzopbjSa1RTO/3DxwYH0svGjzv33YVri2u5WkSc=;
 b=r3TMjvFvhneVlDCRCW7gaUVAY9vegshOP5mjb8GqQKj6ohK+8XNpurH/anSUOgn4wx
 CX/dB50SayUu5903U03kZIzTHCvsNJwhV7a2B+bEkQvTFa+JMUbUIm7LJjdnhVV1tL2F
 jqCvWfsS8kU1zGK6bw+Sh8kYYgRQN5Ug9fgcZ61mjaI3h6RXWHRoIjHwb9IXymQp7S8G
 OKo1bBooViA905VZG8PJHTyPzidJnlAE8HyVf13gL9xU6xV3zvAQ3hHHt1n+UqCwvrlG
 sAZ8TihvqlYzf+rWeIHtVZ0SzN1GKvtunJ9PVZS8jDZHDTnYReAU4FB/E9oqbkF3W3nj
 jknw==
X-Gm-Message-State: AOJu0Yx5mKLHLLFcvQjy7nbjLi1QQjfWUe3dwzZjUCFPYEM5JRKyQdJ4
 2AVwVyreK7GJQr5TThX4sLURctiVJM96zT1wkW214oBjUF4pkeNAo6c1TT+gaIjtlXdE29YzGQk
 =
X-Gm-Gg: ASbGnctoPeLEnPKgrYFWZmtPQPc//dcd46L2cVmsjvgmVOU7dHJnPfvIH8XRlNQmCxr
 sGXM6YT4kcIhrtOTOyLD44b2c4hrzLFVyWBGu1l41MTYrEFzw9/vxy8ymMSOnco+kvsHvAXB9YO
 aWppeDA5Swz/0DSEnW2JDzAbIR9EafwdV2xsnrz8eu96haedi6R2BEr5CObC5i4sryDvwq8cvyk
 KALaiRCgq+crwzPKTuK2tHkB9YqfPkeMhDu3qa0tl6hXYOymayEXJGDIEHE74NvTlCXUhpecayx
 tdPk4aeSuCQqsA8hG1zcONQtz+lMH1NlIRVuks93hL9Vx0kNqqqVcPQFgKt+ZnY=
X-Google-Smtp-Source: AGHT+IHqTFFXQbrqNQS2HaAERGwhysyfcaRbUTsxENDElbMI6AYBjHYpye7MycsjugRwsxGOhsdcxQ==
X-Received: by 2002:a92:cb4e:0:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d2c020ccabmr157711285ab.7.1740438492901; 
 Mon, 24 Feb 2025 15:08:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 36/44] boot: Consider non-bootable partitions
Date: Mon, 24 Feb 2025 16:06:25 -0700
Message-ID: <20250224230640.2665206-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The 'bootable' flag in the DOS partition is deprecated so we should not
rely on it by default. The logic which skips non-bootable partitions can
miss extlinux.conf files on the root disk.

Put this logic behind a flag and update the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to consider non-bootable partitions

 boot/bootdev-uclass.c            | 4 +++-
 doc/develop/bootstd/overview.rst | 5 +++--
 include/bootflow.h               | 2 ++
 test/boot/bootdev.c              | 1 +
 test/boot/bootflow.c             | 5 +++--
 5 files changed, 12 insertions(+), 5 deletions(-)

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

