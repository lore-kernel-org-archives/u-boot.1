Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DCA807D7;
	Wed, 12 Mar 2025 08:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XWvh3UW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B9580756; Wed, 12 Mar 2025 08:37:19 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3BC801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BC44FA46D3A;
 Wed, 12 Mar 2025 07:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561FC4CEE3;
 Wed, 12 Mar 2025 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741765035;
 bh=UkRo1OFNuoco3YdcfEhdDEXa8rxv/Jr0QFSi+U+MKLM=;
 h=From:To:Cc:Subject:Date:From;
 b=XWvh3UW3IguLMTOgtESOHzXPMiYR3PBK+6wq32bMBI/BzwLKDiRCYsEc/ASsNhm31
 dc7MWkO7dRkXbthKeO/PdzS3XVepO5nPExkdxue7NliiyZVYSJEVIRsOJcZLMXoLrS
 WrNSh6g1IzIktYvdqEUqxruF+h6cAyBz3N4/os6GZzBjuwZKSVU6/neub/HTDIoZjA
 x8LHmifV9P91tpIHyRgLrdWubl26YkD2sHMUPDzFSsxsTSrZhaG9srwDBcPPcF+GfC
 U1FVW/7FAn0aI6pFL6c3aZpN0sX785oJ8/91YrJYD7vGRJMKFyDJr6Pgjk4xXxrFjE
 HcXGMsrGl53UA==
From: Michael Walle <mwalle@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
Date: Wed, 12 Mar 2025 08:36:55 +0100
Message-Id: <20250312073655.2281377-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
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

Fastboot works either over TCP, UDP or USB. The latter doesn't have
anything to do with networking, thus should work just fine with
regardless which network stack is selected. In practice, header symbols
are used inside common code paths. Add some ifdeffery to guard against
that.

This will make fastboot over USB work with the new LWIP stack.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Alternatively, we could add the defines and stub functions to the lwip
header.
---
 cmd/fastboot.c               | 4 ++++
 drivers/fastboot/Kconfig     | 1 -
 drivers/fastboot/fb_common.c | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index d4cfc0c7a28..be84a482b81 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -16,6 +16,7 @@
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
+#if CONFIG_IS_ENABLED(NET)
 static int do_fastboot_udp(int argc, char *const argv[],
 			   uintptr_t buf_addr, size_t buf_size)
 {
@@ -55,6 +56,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 
 	return CMD_RET_SUCCESS;
 }
+#endif
 
 static int do_fastboot_usb(int argc, char *const argv[],
 			   uintptr_t buf_addr, size_t buf_size)
@@ -160,10 +162,12 @@ NXTARG:
 
 	fastboot_init((void *)buf_addr, buf_size);
 
+#if CONFIG_IS_ENABLED(NET)
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
 	if (!strcmp(argv[1], "tcp"))
 		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
+#endif
 	if (!strcmp(argv[1], "usb")) {
 		argv++;
 		argc--;
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1eb460f5a02..70207573de2 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,6 +1,5 @@
 menu "Fastboot support"
 	depends on CMDLINE
-	depends on !NET_LWIP
 
 config FASTBOOT
 	bool
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 12ffb463deb..68f92c4b887 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -183,11 +183,15 @@ void fastboot_handle_boot(int command, bool success)
 	switch (command) {
 	case FASTBOOT_COMMAND_BOOT:
 		fastboot_boot();
+#if CONFIG_IS_ENABLED(NET)
 		net_set_state(NETLOOP_SUCCESS);
+#endif
 		break;
 
 	case FASTBOOT_COMMAND_CONTINUE:
+#if CONFIG_IS_ENABLED(NET)
 		net_set_state(NETLOOP_SUCCESS);
+#endif
 		break;
 
 	case FASTBOOT_COMMAND_REBOOT:
-- 
2.39.5

