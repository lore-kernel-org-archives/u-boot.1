Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB4CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AF686EF3;
	Mon, 16 Oct 2023 16:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Km5HEN5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC46C86801; Mon, 16 Oct 2023 16:14:44 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C220486BF2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F7E920011;
 Mon, 16 Oct 2023 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifiXwy7qK2cBwBiji0/3qQs0iZdGamB+huPQXYSi+t4=;
 b=Km5HEN5B4BdBUADTMlJuJOXrA5NoOuexFOGIo6CpFe77i48VIjmjQglLboZjKg4G4GN9NM
 Av6ORrhWCapDyMbe9HMpMTVZtJqNGWcn/E8mPj4o/zOZYw99TZiJ2vVLFHqYO5aPcr06vY
 ax7V8mBWyyugG5Azokx3bx3Lz6i31rQ9ubi+A+Rc1XpsCv3OqVyacKCs24XrM08IVDjbgX
 qAC7Wdv9oWKxBwd55a5CkRvBug7mdh2TxFuBrxIPjC77/HOmtDQbfRI541cd9EUh6wJGhf
 kQ4qRkV+Rfky6Pv/pkPvyKCSrVidOpK6rGu4G3tTi7b5aZ46FO7aMK3HSqW+1w==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 9/9] cmd: test_enter_suspend: Add test_enter_suspend command
Date: Mon, 16 Oct 2023 16:11:35 +0200
Message-Id: <20231016141135.325698-10-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

Add test_enter_suspend command using PSCI.
This command is only to test suspend sequence from U-Boot.
The resume will not work.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

---

 cmd/Kconfig             |  7 +++++++
 cmd/boot.c              |  8 ++++++++
 drivers/firmware/psci.c | 23 +++++++++++++++++++++++
 include/command.h       |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69c..54e7d4b0e6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1450,6 +1450,13 @@ config CMD_POWEROFF
 	help
 	  Poweroff/Shutdown the system
 
+config CMD_TEST_ENTER_SUSPEND
+	bool "test enter suspend"
+	depends on ARM
+	select ARM_SMCCC
+	help
+	  Command to test the suspend sequence (only for test)
+
 config CMD_READ
 	bool "read - Read binary data from a partition"
 	help
diff --git a/cmd/boot.c b/cmd/boot.c
index 14839c1ced..609c07a5a5 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -70,3 +70,11 @@ U_BOOT_CMD(
 	""
 );
 #endif
+
+#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
+U_BOOT_CMD(
+	test_enter_suspend, 1, 0, do_test_enter_suspend,
+	"Test the enter SUSPEND sequence of the device",
+	""
+);
+#endif
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c6b9efab41..591ad1869d 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -23,6 +23,9 @@
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
+#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
+#include <cpu_func.h>
+#endif
 
 #define DRIVER_NAME "psci"
 
@@ -303,6 +306,26 @@ int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
+int do_test_enter_suspend(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	do_psci_probe();
+
+	puts("suspend ...\n");
+	puts("disable dcache\n");
+
+	dcache_disable();
+
+	/* ARM_PSCI_1_0_FN64_SYSTEM_SUSPEND */
+	invoke_psci_fn(PSCI_0_2_FN64(14), (unsigned long)do_test_enter_suspend, 0, 0);
+
+	dcache_enable();
+
+	log_err("Suspend failed or not supported on this platform\n");
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static const struct udevice_id psci_of_match[] = {
 	{ .compatible = "arm,psci" },
 	{ .compatible = "arm,psci-0.2" },
diff --git a/include/command.h b/include/command.h
index c4e3170967..0126da6b37 100644
--- a/include/command.h
+++ b/include/command.h
@@ -177,6 +177,8 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 	     char *const argv[]);
 int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc,
 		char *const argv[]);
+int do_test_enter_suspend(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[]);
 
 unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
 			 char *const argv[]);
-- 
2.39.2

