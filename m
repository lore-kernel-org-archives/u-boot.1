Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD505CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5181786E33;
	Tue, 12 Sep 2023 11:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ASLGi+fR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F1486E5B; Tue, 12 Sep 2023 11:47:38 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 8DF8D86E38
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id A4253212BC18;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4253212BC18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=BoWZ3VmIwKCQDl6F+aIrW8AX7mDNvPGXGAKTVxBPh7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ASLGi+fRgd7LyORvrM7POpdHsP1xA9YhI2DU6L/qbceRIHdH5LhyQXUmyZFO9kXKl
 zkNABLzZM/6RVJtd9NzSHUSILm83hTy3yuPk/nAlYE6zoIrwSG99GPKkkRGTaBGlml
 sWdJiEHRBWEzZ/HSmLe8GBqvHqSETQX06AVaafd8=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 4/8] common: Add OS anti-rollback grace version
Date: Tue, 12 Sep 2023 02:47:27 -0700
Message-Id: <20230912094731.51413-5-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Stephen Carlson <stcarlso@microsoft.com>

New config CONFIG_FIT_ROLLBACK_CHECK_GRACE to add a one unit grace version
to OS anti-rollback protection, allowing images with anti-rollback
counters exactly one less than the platform value to still be loaded. No
update to the platform anti-rollback counter will be performed in this
case.

Signed-off-by: Stephen Carlson <stcarlso@microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 boot/Kconfig         | 10 ++++++++++
 boot/image-fit-sig.c |  7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9180a1c8dc..95a717765c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -112,6 +112,16 @@ config FIT_ROLLBACK_CHECK
 	  when a platform needs to retire previous versions of FIT images due to
 	  security flaws and prevent devices from being reverted to them.
 
+config FIT_ROLLBACK_CHECK_GRACE
+	bool "Enable FIT Anti rollback grace version"
+	depends on FIT_ARBP
+	default n
+	help
+	  Enables a one unit grace version for FIT image anti-rollback protection,
+	  where anti-rollback protection will still accept a FIT image with an
+	  anti-rollback version one less than the current number, but will not
+	  update the platform anti-rollback counter in that case.
+
 config FIT_VERBOSE
 	bool "Show verbose messages when FIT images fail"
 	depends on FIT
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 91eaf4baa8..5689a316b6 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -70,6 +70,7 @@ static int fit_image_verify_rollback(const void *fit, int image_noffset)
 #if !defined(USE_HOSTCC)
 	u64 image_rollback;
 	u64 plat_rollback = 0ULL;
+	u64 target_rollback;
 	struct udevice *dev;
 	int ret;
 
@@ -90,7 +91,11 @@ static int fit_image_verify_rollback(const void *fit, int image_noffset)
 	if (ret)
 		return -EIO;
 
-	if (image_rollback < plat_rollback) {
+	target_rollback = plat_rollback;
+	/* Calculate target anti-rollback version, including grace version if enabled */
+	if (CONFIG_IS_ENABLED(FIT_ROLLBACK_CHECK_GRACE) && plat_rollback > 0ULL)
+		target_rollback = plat_rollback - 1ULL;
+	if (image_rollback < target_rollback) {
 		return -EPERM;
 	} else if (image_rollback > plat_rollback) {
 		ret = rollback_idx_set(dev, image_rollback);
-- 
2.40.0

