Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0476DC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 23:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2F987960;
	Thu, 28 Dec 2023 00:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="Z/w939Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E238758C; Thu, 28 Dec 2023 00:34:20 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047C88764D
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 00:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 48C3FA05EF;
 Thu, 28 Dec 2023 00:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=jMMw8wHaoYTYFOk/e98I
 eyOfQj5fgiXn5tO5M2AVnSk=; b=Z/w939Mh3gce8Yj7dr6RQ6IA8UnRkv55+lMP
 FlzzEOiGEJ6b0qhyEDYOZpQuFEgko14aW6RaGo4ZTyf5Q//6qnd+56uZRH5jQbg8
 AoFrynuMTNfQvXViHYUvBcM7C0FXYXv1ZUavNavdI1ezCstdaDY1WznnC9ZkEa/g
 t9YuRrSCXkWxizZFCZrg008oKFjhyj2Iy74HRTkg0TdiSDhjop3BElZY/CPDoVpW
 C9gQt+znYpupTjaT9nkwXgRKTMPr6hlcXTVOYgviccnFsyC549lzlPBCkeqoFhaX
 8cKFnv4wvNY8YB0zk+IS4fswhuXsm8FtNi8TMcQROTPLnIED2UssOrKrjcnLHd78
 O62ksns1qXfHCPQZd3IyGTFDIZ2paZIE5UaAFwbOQN9KPmB3ppolQvOHVoLBLdtN
 1tK40/odW11s6tg2fOUyrRP9KZjOMwxRHl8R8meF1Ftpy4KV3KIMzbl8Iqpp/upl
 qiDQaT0qWrUK1ETohjZfm6NnUNzCOAAtQ/dXOiAzRyy3ELaFnzyYuc+5EPDmCRUP
 guhwYj+tHMLp3ECP+xvVx6/rqdhC8PTYFzvTjIRy9ccbkyNalS1CfprVxxqyCplN
 Tbq/XewsfZO3y6yO+PpiGaq4Z00iEuh0kEpmtZ03FI7a8Img9jOVQkUFhWDlpthP
 JCRTvt8=
From: Bence Cs <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Dragan Simic <dsimic@manjaro.org>, Simon Glass <sjg@chromium.org>, "Daniel
 Golle" <daniel@makrotopia.org>, Sean Anderson <seanga2@gmail.com>, "Mark
 Kettenis" <mark.kettenis@xs4all.nl>, Bence Cs <csokas.bence@prolan.hu>
Subject: [RFC PATCH 2/2] common: console: Add support of passing the saved
 console log to the OS
Date: Thu, 28 Dec 2023 00:30:12 +0100
Message-ID: <20231227233011.358276-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227233011.358276-1-csokas.bence@prolan.hu>
References: <20231227233011.358276-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1703720056; VERSION=7966; MC=2712546285;
 ID=305939; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D385C6C7D6A
X-Mailman-Approved-At: Thu, 28 Dec 2023 00:34:44 +0100
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

CONFIG_CONSOLE_RECORD_SAVE option allows for the recorded console log to
be saved to a memory location, along with some metadata. This memory
address is then passed to the booted OS via command line.

Signed-off-by: Bence Cs <csokas.bence@prolan.hu>
---

Notes:
    Some improvements to consider:
    * pass CONFIG_CONSOLE_RECORD_SAVE_BASE via FDT
    * or possibly add it to U-Boot env, so scripts can choose the passing method
    * find a better place to call console_record_save(), ideally as late as possible
    
    Link: https://lists.denx.de/pipermail/u-boot/2023-December/541138.html

 boot/bootm.c      | 27 +++++++++++++++++++++++++--
 common/Kconfig    | 13 +++++++++++++
 common/console.c  | 13 +++++++++++++
 include/console.h | 19 +++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 7a050ed41a..7f67f6a58e 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -10,6 +10,7 @@
 #include <bootstage.h>
 #include <cli.h>
 #include <command.h>
+#include <console.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
@@ -857,6 +858,16 @@ static int process_subst(char *buf, int maxlen)
 	return ret;
 }
 
+static int append_bootlog_base(char *buf, int maxlen)
+{
+	int size = strlen(buf);
+
+	if (size + 1 + strlen(" bootlog.base=0x" + 8 > maxlen)
+		return -ENOSPC;
+
+	sprintf(buf + size, " bootlog.base=0x%08X", CONFIG_CONSOLE_RECORD_SAVE_BASE);
+}
+
 int bootm_process_cmdline(char *buf, int maxlen, int flags)
 {
 	int ret;
@@ -875,6 +886,11 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags)
 		if (ret)
 			return log_msg_ret("subst", ret);
 	}
+	if (IS_ENABLED(CONFIG_CONSOLE_RECORD_SAVE)) {
+		ret = append_bootlog_base(buf, maxlen);
+		if (ret)
+			return log_msg_ret("bootlogbase", ret);
+	}
 
 	return 0;
 }
@@ -882,7 +898,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags)
 int bootm_process_cmdline_env(int flags)
 {
 	const int maxlen = MAX_CMDLINE_SIZE;
-	bool do_silent;
+	bool do_silent, do_pass_record;
 	const char *env;
 	char *buf;
 	int ret;
@@ -890,7 +906,8 @@ int bootm_process_cmdline_env(int flags)
 	/* First check if any action is needed */
 	do_silent = IS_ENABLED(CONFIG_SILENT_CONSOLE) &&
 	    !IS_ENABLED(CONFIG_SILENT_U_BOOT_ONLY) && (flags & BOOTM_CL_SILENT);
-	if (!do_silent && !IS_ENABLED(CONFIG_BOOTARGS_SUBST))
+	do_pass_record = IS_ENABLED(CONFIG_CONSOLE_RECORD_SAVE);
+	if (!do_silent && !do_pass_record && !IS_ENABLED(CONFIG_BOOTARGS_SUBST))
 		return 0;
 
 	env = env_get("bootargs");
@@ -1056,6 +1073,13 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 #endif
 
+	if (ret)
+		return ret;
+
+#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
+	console_record_save();
+#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
+
 	/* From now on, we need the OS boot function */
 	if (ret)
 		return ret;
diff --git a/common/Kconfig b/common/Kconfig
index 0283701f1d..d70fa748c2 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -52,6 +52,19 @@ config CONSOLE_RECORD_IN_SIZE
 	  The buffer is allocated immediately after the malloc() region is
 	  ready.
 
+config CONSOLE_RECORD_SAVE
+	bool "Save a copy of the recording for the OS to read"
+	depends on CONSOLE_RECORD
+	help
+	  This option makes a copy of the recorded console log available at a fixed
+	  RAM location, so that the booted OS can read it
+
+config CONSOLE_RECORD_SAVE_BASE
+	hex "Memory location to save the log to"
+	depends on CONSOLE_RECORD_SAVE
+	help
+	  The base address for the saved copy (will be passed to the booted OS)
+
 config SYS_CBSIZE
 	int "Console input buffer size"
 	default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
diff --git a/common/console.c b/common/console.c
index 1ffda49c87..77a41d99f7 100644
--- a/common/console.c
+++ b/common/console.c
@@ -860,6 +860,19 @@ int console_in_puts(const char *str)
 
 #endif
 
+#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
+void console_record_save(void)
+{
+	struct console_record_log *log = (struct console_record_log *)(CONFIG_CONSOLE_RECORD_SAVE_BASE);
+	char *buf = (char *)(log + 1);
+	// buffer starts at the end of the log struct
+	log->version = 1U;
+	log->uboot_version = U_BOOT_CURRENT_VERSION_CODE;
+	log->len = membuff_get((struct membuff *)&gd->console_out, buf, console_record_avail());
+	log->magic = CONSOLE_RECORD_LOG_MAGIC;
+}
+#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
+
 /* test if ctrl-c was pressed */
 static int ctrlc_disabled = 0;	/* see disable_ctrl() */
 static int ctrlc_was_pressed = 0;
diff --git a/include/console.h b/include/console.h
index e29817e57b..7a1b5ebffd 100644
--- a/include/console.h
+++ b/include/console.h
@@ -133,6 +133,25 @@ static inline int console_in_puts(const char *str)
 
 #endif /* !CONFIG_CONSOLE_RECORD */
 
+#if CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE)
+struct console_record_log {
+	u32 magic;
+	u32 version;
+	u32 uboot_version;
+	u32 len;
+};
+
+/*
+ * Magic value for struct console_record_log
+ */
+#define CONSOLE_RECORD_LOG_MAGIC 0xB0021062
+
+/*
+ * Saves the recorded console log to CONSOLE_RECORD_SAVE_BASE
+ */
+void console_record_save(void);
+#endif /* CONFIG_IS_ENABLED(CONSOLE_RECORD_SAVE) */
+
 /**
  * console_announce_r() - print a U-Boot console on non-serial consoles
  *
-- 
2.25.1


