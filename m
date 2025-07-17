Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCBC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 10:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6646E8334A;
	Thu, 17 Jul 2025 12:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cyna12mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB6C8338C; Thu, 17 Jul 2025 12:23:54 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E64E83335
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e897c8ca777so769791276.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752747828; x=1753352628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=waJHkJxuQcoi81x+d3kFw11hGwP3Hsufx7YK0Sgkh+o=;
 b=Cyna12mxaEUQZaa+6eQol0i8v2k+SsJPw8TneFYzjkECZl1JhaaAchvdSo3A+82tjN
 OWu/pjiimNW7IIdXGnOXvLNdQBvsVJnYrjvnjjS3yzQ8dr11eXGaZWSeV0njxeU8d0mp
 6SGvAlLdbm1Sp14qdspqPrcpYizjmYbYr2Xkpn1zDWZrJ9zFWjUwY336RGtHf9ANjKgR
 Gqzd6hn50ctdFCuVypZoqM3JC2xROomXgeUNQwtyG+q0eKnC8ZtXjlJwbHQESaKufI8R
 /moHn3QbqYOg5XxQdgSQKaOoNzyh3WhqGgW4y8zCLLmiUcxgL1dSpX2HtDRSF6dx7oMq
 pCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752747828; x=1753352628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waJHkJxuQcoi81x+d3kFw11hGwP3Hsufx7YK0Sgkh+o=;
 b=HWGWxaPAgB0RWwWDWttRbsN8KK5cQC+5kx7Pv3wKmy3fymUjVfk6U6qV285G1hUZNJ
 sIK4yIKtdkbB3MxvHlKvkpt8mtiyyWjZkcFOc3Tn3IaVmoBlNoYDHaATfcn//BTiXojD
 w+FJHMqpAqT4o5Gm3M8VmyYduOec0tnASKwn/fA9wh9+fbmZmMyr8ZbHZIG3CcmEC4CB
 DFpyujCPUxbUgfexRIZnlKbDlbXbZ8DbjpbaC3ohum+sBm1DmVpy7pISancKGrSaVibu
 O9b16KhFq4q0XCoAThLyEHi8bahfYQ3owQqwYZk9zWCpOCDLG8ttq0sgCD1kRtqUZXC8
 I0rg==
X-Gm-Message-State: AOJu0Yz9IAv1v957sRqKFCzd6ciiXDs7fJwJdH2GhltkgJwkwmau5MW+
 niizRGOfSxHiA1wVLYlOgdIiI1I5fo5LFMe2qlBqMpxDSt2NQKsvzWBULaIh
X-Gm-Gg: ASbGncscJttDpqGtafpJRQdl/Grs61r1feNtuFDwK6o6bqPIp0RtMfnMYhMFXwliTyT
 1YJ8mk2fNZBOxaby2zQNZDCgDwl0WVK0gdY9lMESThl9AiLRkG1tigdc+lX6kps/OpMcpH2l16Z
 PpjjAxo5Wly4Oe2jWuekkIhQ8urcBFYVpYOTn1cweLGJla8idh3kMBl3DCU3/+0pegXrWKUMhOV
 BDUCdFbR9ADA0WSQKWOOsQUiXp2zuQFLa9sgjYQ9iEl7aGKSFHiibw/PX7QDRBa/bpQZf6so89y
 qo+KbhOB49vEUGPga2YIL6PS6Nq7JcjjMrgzbJ4P3JaH5LoXWcTq2Kzc8xzLHTP1dSE/7mvYr7k
 dBL2F2leH4Zlf6i5leswG1Z46zgxMcnE21mepiw==
X-Google-Smtp-Source: AGHT+IEJEWZghVK2133vKsQYVWGa+ae32b/zQvH+Crpc2hYI/ECNx1iVhfJ1M3nRK26iUnQo81Z5TQ==
X-Received: by 2002:a05:690c:490e:b0:710:f2a1:fa6 with SMTP id
 00721157ae682-7183515a205mr93524497b3.29.1752747828347; 
 Thu, 17 Jul 2025 03:23:48 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-717c5d8900csm33878757b3.50.2025.07.17.03.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:23:47 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Alexey Romanov <avromanov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] block: Remove blk_find_first/next
Date: Thu, 17 Jul 2025 06:19:01 -0400
Message-ID: <20250717102012.10018-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
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

In [0], Andrew noted a code quality issue in the implementation of
blk_find_first and blk_find_next. This led to the observation that the
logic of these functions was also likely incorrect, and based on a quick
check it seemed the functions were unused outside of test code, which
did not exercise the potential failure case, so we felt they should be
removed. In [1], a test patch which illustrates the failure in sandbox
is provided for reference.

Because a more thorough check agrees that these functions are unused,
they are currently incorrect, and fixed/removable flags on block devices
prior to probe are unreliable, just remove these functions instead of
fixing them. All potential users should have used blk_first_device_err
instead anyway.

CI results at [2].

[0] https://patchwork.ozlabs.org/project/uboot/patch/20250714-blk-uclass-v1-1-d21428c5f762@linaro.org/
[1] https://gist.github.com/gmalysa/b05e73a5c14bc18c5741a0e0e06a2992
[2] https://gitlab.com/gmalysa/lnxdsp-u-boot/-/pipelines/1931210857

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

 drivers/block/blk-uclass.c | 24 --------------------
 include/blk.h              | 45 -------------------------------------
 test/dm/blk.c              | 46 +++-----------------------------------
 3 files changed, 3 insertions(+), 112 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f3ac8db9464..73c24fd9176 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -611,30 +611,6 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
 	return flags & req_flags ? 0 : 1;
 }
 
-int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
-{
-	int ret;
-
-	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
-		return 0;
-
-	return -ENODEV;
-}
-
-int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
-{
-	int ret;
-
-	for (ret = uclass_find_next_device(devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
-		return 0;
-
-	return -ENODEV;
-}
-
 int blk_first_device_err(enum blk_flag_t flags, struct udevice **devp)
 {
 	for (uclass_first_device(UCLASS_BLK, devp);
diff --git a/include/blk.h b/include/blk.h
index 488d04cf32a..8d1b70cabd3 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -781,51 +781,6 @@ int blk_first_device_err(enum blk_flag_t flags, struct udevice **devp);
  */
 int blk_next_device_err(enum blk_flag_t flags, struct udevice **devp);
 
-/**
- * blk_find_first() - Return the first matching block device
- * @flags: Indicates type of device to return
- * @devp:	Returns pointer to device, or NULL on error
- *
- * The device is not prepared for use - this is an internal function.
- * The function uclass_get_device_tail() can be used to probe the device.
- *
- * Note that some devices are considered removable until they have been probed
- *
- * @return 0 if found, -ENODEV if not found
- */
-int blk_find_first(enum blk_flag_t flags, struct udevice **devp);
-
-/**
- * blk_find_next() - Return the next matching block device
- * @flags: Indicates type of device to return
- * @devp: On entry, pointer to device to lookup. On exit, returns pointer
- * to the next device in the same uclass, or NULL if none
- *
- * The device is not prepared for use - this is an internal function.
- * The function uclass_get_device_tail() can be used to probe the device.
- *
- * Note that some devices are considered removable until they have been probed
- *
- * @return 0 if found, -ENODEV if not found
- */
-int blk_find_next(enum blk_flag_t flags, struct udevice **devp);
-
-/**
- * blk_foreach() - iterate through block devices
- *
- * This creates a for() loop which works through the available block devices in
- * order from start to end.
- *
- * If for some reason the uclass cannot be found, this does nothing.
- *
- * @_flags: Indicates type of device to return
- * @_pos: struct udevice * to hold the current device. Set to NULL when there
- * are no more devices.
- */
-#define blk_foreach(_flags, _pos) \
-	for (int _ret = blk_find_first(_flags, &_pos); !_ret && _pos; \
-	     _ret = blk_find_next(_flags, &_pos))
-
 /**
  * blk_foreach_probe() - Helper function to iteration through block devices
  *
diff --git a/test/dm/blk.c b/test/dm/blk.c
index aa5cbc63777..1b928b27d9c 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -229,30 +229,7 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 
-	/* Iterate through devices without probing them */
-	ut_assertok(blk_find_first(BLKF_BOTH, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc2.blk", dev->name);
-
-	ut_assertok(blk_find_next(BLKF_BOTH, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc1.blk", dev->name);
-
-	ut_assertok(blk_find_next(BLKF_BOTH, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc0.blk", dev->name);
-
-	ut_asserteq(-ENODEV, blk_find_next(BLKF_BOTH, &dev));
-	ut_assertnull(dev);
-
-	/* All devices are removable until probed */
-	ut_asserteq(-ENODEV, blk_find_first(BLKF_FIXED, &dev));
-
-	ut_assertok(blk_find_first(BLKF_REMOVABLE, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc2.blk", dev->name);
-
-	/* Now probe them and iterate again */
+	/* Probe and look through block devices */
 	ut_assertok(blk_first_device_err(BLKF_BOTH, &dev));
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc2.blk", dev->name);
@@ -289,30 +266,13 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_blk_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
-/* Test blk_foreach() and friend */
+/* Test blk_foreach_probe() */
 static int dm_test_blk_foreach(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 	int found;
 
-	/* Test blk_foreach() - use the 3rd bytes of the name (0/1/2) */
-	found = 0;
-	blk_foreach(BLKF_BOTH, dev)
-		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(7, found);
-
-	/* All devices are removable until probed */
-	found = 0;
-	blk_foreach(BLKF_FIXED, dev)
-		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(0, found);
-
-	found = 0;
-	blk_foreach(BLKF_REMOVABLE, dev)
-		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(7, found);
-
-	/* Now try again with the probing functions */
+	/* The test device tree has two fixed and one removable block device(s) */
 	found = 0;
 	blk_foreach_probe(BLKF_BOTH, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-- 
2.45.2

base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
branch: uboot-master
