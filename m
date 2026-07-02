Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4899C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D8F84A5F;
	Thu,  2 Jul 2026 20:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Le2fTMuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949AA847C8; Thu,  2 Jul 2026 20:27:50 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE07D84A27
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljt46ntzyFg;
 Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016866;
 bh=BTux+gd5ZvqdNnc3Xi3rsSqfUcLOa7Zo/ey/F6ULpGU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Le2fTMuBw1OXOtSIab+n5oTa2fx16HA7LnPhNqZ/+e4+h6hT+QMF2GqX4qkQ6J446
 w9mh3dxIehu/A7GjRkzekqLoZr+IhvogsOlho1vKmJJEml1b6nX+2UyVb8o+G/xP/0
 WG2XyiQtY1js50RT7G0iW5TFDVDihvvbwEPqKCQnCA7vrVOE2k1fdGZte4276NIAoj
 rggrMqa20DZRUXwN4in7AvKmUay98pbvdx7nRjKaMDDBQs6zDOJ5/WZBHqVbo8KNJo
 ehyBpTbB3Rx2wg8npBThdcMdJ1+1h0mBvd8btOffJSO/+lyeSBRrY6t1Pta8Uf89M+
 qDw+o0BCYNEKA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljs4FcBzxwk; Thu,  2 Jul 2026 20:27:45 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 02 Jul 2026 20:27:36 +0200
Subject: [PATCH 6/6] Revert "drivers: sysreset: Add sysreset op that can
 take arguments"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-revert-sysreset-v1-6-7920c16a1f3a@cherry.de>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
In-Reply-To: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This reverts commit fcb48b89813b14f38b31b86b4a6ace376bd86d8b.

The args support for the sysreset uclass contains a logic bug. The first
sysreset device implementing the request_arg callback will consume the
args, not support the specified arg and thus return -EPROTONOSUPPORT
which will stop the iteration over all sysreset devices.

This is an issue if one has multiple sysreset devices and each with
support for different (valid) args. If a sysreset device implements a
-dummy argument and another -foo and one calls reset -dummy on the
U-Boot CLI, it'll depend on which sysreset device will be attempted
first. If it is the one implementing -foo, it'll return it doesn't
support the argument with -EPROTONOSUPPORT in which case the device
implementing -dummy will never be attempted and instead we'll do a cold
reset which is very likely not what's expected.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/sysreset/Kconfig           |  8 --------
 drivers/sysreset/sysreset-uclass.c | 37 -------------------------------------
 include/sysreset.h                 | 18 ------------------
 3 files changed, 63 deletions(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index f589ad154186..16ef434a8d9c 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -49,14 +49,6 @@ config SYSRESET_CMD_RESET
 	help
 	  Enable sysreset implementation of the reset command.
 
-config SYSRESET_CMD_RESET_ARGS
-	bool "Enable reset command to take arguments"
-	help
-	  Pass on the arguments received by the 'reset' command to the
-	  sysreset driver(s). The sysreset driver(s) may make use of the
-	  additional arguments for implementing arch/board specific
-	  functionality.
-
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..536ac7271427 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,18 +32,6 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
-{
-	struct sysreset_ops *ops = sysreset_get_ops(dev);
-
-	if (!ops->request_arg)
-		return -ENOSYS;
-
-	return ops->request_arg(dev, argc, argv);
-}
-#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
-
 int sysreset_get_status(struct udevice *dev, char *buf, int size)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -83,26 +71,6 @@ int sysreset_walk(enum sysreset_t type)
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-int sysreset_walk_arg(int argc, char * const argv[])
-{
-	struct udevice *dev;
-	int ret = -ENOSYS;
-
-	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
-		for (uclass_first_device(UCLASS_SYSRESET, &dev);
-		     dev;
-		     uclass_next_device(&dev)) {
-			ret = sysreset_request_arg(dev, argc, argv);
-			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
-				break;
-		}
-	}
-
-	return ret;
-}
-#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
-
 int sysreset_get_last_walk(void)
 {
 	struct udevice *dev;
@@ -164,11 +132,6 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	printf("resetting ...\n");
 	mdelay(100);
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
-		return 0;
-#endif
-
 	sysreset_walk_halt(reset_type);
 
 	return 0;
diff --git a/include/sysreset.h b/include/sysreset.h
index d1cc9ebc542a..ff20abdeed3c 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -43,24 +43,6 @@ struct sysreset_ops {
 	 * (in which case this method will not actually return)
 	 */
 	int (*request)(struct udevice *dev, enum sysreset_t type);
-
-	/**
-	 * @request_arg: Reset handler implementations that might need to process
-	 *		 arguments given to the 'reset' command.
-	 *
-	 * Note that this function may return before the reset takes effect.
-	 *
-	 * @dev:	Device to be used for system reset
-	 * @argc:	No. of items in @argv
-	 * @argv:	Arguments given to 'reset' command
-	 * Return:
-	 * -EINPROGRESS		if the reset has started and will complete soon
-	 * -EPROTONOSUPPORT	if not supported by this device
-	 * 0			if the reset has already happened
-	 * (in which case this method will not actually return)
-	 */
-	int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
-
 	/**
 	 * @get_status:	get printable reset status information
 	 *

-- 
2.55.0

