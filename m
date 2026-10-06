Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461DECA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E252040659;
	Tue,  6 Oct 2026 15:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wv94fIDrFXT; Tue,  6 Oct 2026 15:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB72A4064E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302364;
	b=lRhb7eg3dCyGYm329E3Q0qGwsCTFrg/TbIE5d4TAmdPlFPe2P8XPa4iLQ59vis+0nZhi
	 1lFsM4v0bwIds78XDjUI/tKE/oHl0IrjVXntgfOw4gSR8X+/zo3/ZxJ8Rc7NIlN3OOKY8
	 d3EPeY7KPXY2bn909V4qsVgKZvBHYtWZ3ChJ4zvPFIsTSNiE3C/ErHhWlIR7lHwaUmfAd
	 LrukwVmE83xOkGs0QgWL7c52HJik+x6jF/FdJZgbv8pAfX0+RaLI2mUeqtS4F9OYIcX3d
	 C+xSuBiQSHzmnBYcltL0/6uDwH/FjwIMfbEvKJZddiEZJhFAUIpGyq5Rta7oixvr8kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=efkXnJ4htfOgFIoyMNj72+HlgTV4LtBjFJ06e7DGMno=;
	b=JK7LXVCglvrx9d3iRrXL81owV6KwRiMrNlK2z7TLzozIL+3/0J+PzdWbYLolh6arslbh
	 3KlyetVBhIZiDF3qNExc/GoQkUUTyho9wnMh5LKPWjcpBh+3SikYx2ffxbdOgLpQyJWdq
	 8SIx0S3cnAkaOxR4N4M2yi9Tvigl8xJMmlodIzSmi3eBRwRC5rkUO0ORMArHNCI2mAD6w
	 IqOId5xwAgOIahM0oesyPCx1lbxu8j1oAWhdWeM0ExC3JkNLtGXwiWYD1q7MylJ29p3z6
	 vSWQCI29HmopUsx+Elp9l1+21oHNnG2dyA/hdFjeJo1gTLiniZkYoEG8WT+CWz0LGzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302364;
	bh=efkXnJ4htfOgFIoyMNj72+HlgTV4LtBjFJ06e7DGMno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHVgagnVP8V+Laejv6LxQ14UsNctO0FvhaXVsFhwBKJ9daxxho123L4EE5ptw/Ui5
	 KozSaXUMlIAT27BfeAIAVKbMhEBWoiexsWQWdV9zniYCTTA5IO2+h5ndkuhrBOh+F7
	 WxmGp0f/GdzVJkspE9AGel0/wOgoh48qH/+4XLsHJx7j6Y6jrNlvP4zA7khuELSXRg
	 T5GHZbCqZNGW5eZTYvh5DiV/nv55XIXKOLRD+eTRhnPAsUFA/IJfYVZ4rfvpeQn0xe
	 U2qoYkvEYF2SN6d55rL9wDVu8SHSUis0evBpU5eMltcy/+6zawZPvq/ReA/SY0Nt/O
	 oZb/ybseSxryA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB72A4064E;
	Tue,  6 Oct 2026 15:59:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 243C875
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 161BC402AF
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GB8liLd2beu6 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 68F2440274
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791301943;
 b=FYvAjcQlz1tK0xPsfm/KvjKYjSoxCEVRI76r2AleQTOfthUa0AmVuGKC4eTdrCcwoEKC
 PcUkkZrxfordgcRlDe08GhYbyNBNbNyNabWlpJGWWJkKXS09mvdloHpUGmoTzGObJTXIF
 lNzSAi9gVR0ba0CwrXzCG5XZv+MGTUeO5bWoRogtTr3DGgrytjitZujSWIEjpTevXyqrX
 JNR8ZGa8rypnkCWiMrnLfVskNa3RKARUT7zo+ZSJUkJirSjL62W4j29emJtKFFcYmx+Rm
 vdc06r8NIpywIzVEckJxmRvN5oN5Udtq9N9zPRIh4BcMlFKiBBL59kX2hmpAvZxtPnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301943;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=efkXnJ4htfOgFIoyMNj72+HlgTV4LtBjFJ06e7DGMno=;
 b=MexDXjiS1r58vHIF/gcEBT8xp/P6ELp5yJg/v9Eehn/KhxP2gNg/FOxS+cN5nHwzqa2I
 vTlngQVzmGHYN1qjNQtjUK8cAE7HuhwudyIW/6b9t49njBUQNWwChH3gyI7Jl2roEIcSC
 MhobllyiaKS/MDbecsm+OK/F3W7pOjwT11vtnfHyh5Frh6XRpg5vdqlOXaz2mQxrOHqDQ
 kr8PsoJVmnVCcgpkPsH9J/H2CkA139VUK1CbVqvkqSlCOU3HUsbapdmOSCPb9NzgdgA4a
 ZFlthCzihe12GGzwUZCw0YkDPpxPFTaTesxvLVy7blvkWHpbi7dQnyffZ6Rw6bLH1tw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=CnXpdm6L; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-664519-20261006155218770d5647ba00020764-bndzag@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=CnXpdm6L
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F2440274
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:21 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20261006155218770d5647ba00020764
 for <u-boot@lists.u-boot-project.org>;
 Tue, 06 Oct 2026 17:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=efkXnJ4htfOgFIoyMNj72+HlgTV4LtBjFJ06e7DGMno=;
 b=CnXpdm6LsfhC1eZyJH9emWT1kPRKwL0IzbDU2OH0AKvd1DQyCUNvtUcsbY2oOYlyC6PqUZ
 uQIeUzYVO+F8mrpSJdH5BbnTXgb4pZ0UqG3EIwcw5DGvrnygXKOIjoUJwR3PrtgKfAFuJB3J
 W8bmGDZ6xBmYiu8BwTpm/FxZa10ELquEvzAq5JVtTdSMq2fi3XqI+CiHVTlZbOWZviDmggiw
 OdCLdpDNEaGB12Cnc4m7Ph485BIqHvZLv42CYWVOvogXsTQ2klwocg3uxsflNrqJfGniiDO2
 /j9RR8PP/I4WQ1R88ygmkbALWxVBgsHUnSJNIUdrRcx4gM2zc+iZUHRw==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 1/3] tpm: Add an option to start the TPM during init
Date: Tue,  6 Oct 2026 17:52:15 +0200
Message-Id: <20261006155217.187050-2-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-1-michael.haener@siemens.com>
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
'tpm autostart' command does, but it does not depend on a boot script or
on the environment.

Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
is used (and then only from bootm) or when booting via EFI with
CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
uninitialised and the OS has to start it itself, which Linux reports as
"A TPM error (256) occurred attempting the self test". Boards have worked
around this by putting 'tpm autostart' into their environment, see
board/xilinx/zynqmp/zynqmp_kria.env.

The startup is done from an event rather than in the uclass probe:
nothing probes the TPM on a plain booti/bootm, and the event runs exactly
once in U-Boot proper without changing what probing a TPM means for the
existing callers.

Boards that share one binary between variants with and without a TPM
fitted can enable this safely: when no TPM device is found the startup is
skipped silently. Other errors are reported as warnings but do not stop
the boot. Note that the full self-test adds to the boot time.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changes in v3:
- Split the tests and the Kria conversion into separate patches

Changes in v2:
- Move the code to lib/tpm_autostart.c and the option to lib/Kconfig
- Stay silent only when no TPM device exists (-ENODEV), warn otherwise
- Use u32 and %#x for the tpm_auto_start() result
- Mention the boot-time cost of the self-test in the help text
- Document the option in doc/usage/measured_boot.rst
- Explain in the commit message why an event is used instead of probe

 doc/usage/measured_boot.rst | 18 ++++++++++++++++++
 lib/Kconfig                 | 19 +++++++++++++++++++
 lib/Makefile                |  1 +
 lib/tpm_autostart.c         | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 lib/tpm_autostart.c

diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 488dd546f13..d74cfab2594 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -55,3 +55,21 @@ Requirements
 * The operating system must also be configured to use the memory regions
   specified in the U-Boot device-tree in order to make use of the event
   log.
+
+Starting the TPM without measured boot
+--------------------------------------
+
+Measured boot starts the TPM as a side effect, but only on the boot paths
+listed above. A plain booti/bootm without CONFIG_MEASURED_BOOT, or a boot
+which does not go through the EFI subsystem, leaves the chip uninitialised
+and the operating system has to start it itself. Some kernels report this as
+an error.
+
+CONFIG_TPM_AUTOSTART runs the same startup and self-test sequence as the
+'tpm autostart' command from an EVT_LAST_STAGE_INIT handler, independently of
+the boot path, the environment and any boot script. When no TPM device is
+found the startup is skipped, so a board which shares one binary between
+variants with and without a TPM fitted can enable it safely.
+
+Note that a full self-test can take a noticeable amount of time on a TPMv2,
+which is added to every boot even when the TPM is not used afterwards.
diff --git a/lib/Kconfig b/lib/Kconfig
index ff7655e1496..33ae8037479 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -565,6 +565,25 @@ config TPM
 	  If you want a fully functional TPM enable all hashing algorithms.
 	  If you enabled measured boot all hashing algorithms are selected.
 
+config TPM_AUTOSTART
+	bool "Start the TPM during board initialisation"
+	depends on TPM
+	select EVENT
+	help
+	  Run the TPM startup and self-test sequence from an EVT_LAST_STAGE_INIT
+	  handler, which is the same thing the 'tpm autostart' command does.
+	  Without this the chip is still uninitialised when the OS takes over
+	  and the OS has to start it itself, which some kernels report as an
+	  error.
+
+	  Boards that share one binary between variants with and without a TPM
+	  fitted can enable this safely: when no TPM device is found the
+	  startup is skipped silently.
+
+	  Note that a full self-test can take a noticeable amount of time on
+	  a TPMv2, so this adds to the boot time of every boot, even when the
+	  TPM is not used afterwards.
+
 config SPL_TPM
 	bool "Trusted Platform Module (TPM) Support in SPL"
 	depends on SPL_DM
diff --git a/lib/Makefile b/lib/Makefile
index 93a389b10e4..b31861fe4b5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_$(PHASE_)OF_LIVE) += of_live.o
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
+obj-$(CONFIG_TPM_AUTOSTART) += tpm_autostart.o
 obj-$(CONFIG_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_TPM_V2) += tpm-v2.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
diff --git a/lib/tpm_autostart.c b/lib/tpm_autostart.c
new file mode 100644
index 00000000000..5b43b2aecbb
--- /dev/null
+++ b/lib/tpm_autostart.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Start the TPM during init, so that the OS does not have to do it.
+ *
+ * Copyright (c) 2026 Siemens AG
+ */
+
+#define LOG_CATEGORY UCLASS_TPM
+
+#include <dm.h>
+#include <errno.h>
+#include <event.h>
+#include <log.h>
+#include <tpm_api.h>
+
+static int tpm_evt_autostart(void)
+{
+	struct udevice *dev;
+	int ret;
+	u32 rc;
+
+	ret = uclass_first_device_err(UCLASS_TPM, &dev);
+	if (ret) {
+		/* a board may share one binary between variants without a TPM */
+		if (ret != -ENODEV)
+			log_warning("Cannot init TPM (err=%dE)\n", ret);
+
+		return 0;
+	}
+
+	rc = tpm_auto_start(dev);
+	if (rc)
+		log_warning("TPM startup failed (rc=%#x)\n", rc);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
-- 
2.55.0

