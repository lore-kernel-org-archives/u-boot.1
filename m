Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C285CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69494607A1;
	Wed, 30 Sep 2026 13:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96beN1VXazIN; Wed, 30 Sep 2026 13:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C350B607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790773659;
	b=DA8vfr5nGdD0PeElwvbV0ebAS9KN0hMwN4wFcVes6GiJMv+GB9cdNAPXByKCl1bfeb3M
	 ewyRNqWshohI/C5Est/Bd+VTdJ2q9Y8sQlOdAdN8N2BEfucAh1RR5+EpNLwqDFeSA4B5e
	 OoqpCLKAU2ibsGrEPBqAEODzy4wUBQzhp07NhKiCy5KeZKBs5AJh0UGAiwJm6c+ufdV2i
	 ULPHmIKUH9WJsuX9nkUTuV89VnhLrx9/BE+hWn0uWshzG5XyfJcppudOn06LeSYngeKAY
	 3YOlNmMQ1Wh3r7sExOs2r8RIrNRBQy+6O2E7spC9HmaAEyeaojHISIA9ao7X9uo3RWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790773659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MxS4055tkp6kRTxXsXLZKAwISssfXT+b26ytPma6i7M=;
	b=rIxmkHOOH/6KHDYc8XpsrJ5jQHjZZGhJGOf6WfmW5m8zx0elcBVzpkNQsZy8WS1bViHu
	 EVIrjuSYLmfSmN454svFIoiYr+NUTpc9G3Hnn8XtEtfQKPSwlFXMbqx0at2fEMwkYvQrp
	 3uC0cPwHqssnUwfZGbjCAWOT+Z5uUGPT3cnTnr0mgCSd4ijkITSFwzEanUUXPuXJFqxMk
	 ifKLK2UC5w3bJCTdYhz7U0YrZsUq7k1Rn33r/MeBugwDE+co0wCgiLcozHTrUOXoXJOO+
	 AAGBHQL4Z3rEpSP2/euheP8a0mdm6ieqFDJwUATu+NGxamy00FenFRdsaeVGQ7ygtqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790773659;
	bh=MxS4055tkp6kRTxXsXLZKAwISssfXT+b26ytPma6i7M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vWkAYTjqbrmkpRF47GXrHNZJgwcU44k79qN7IPPprtp5s5WJbQpl86FsJflQmvFzt
	 eivAh1i4PKt1jqBRC4U2oLGJZDekliz6UH1qQUiH44EH3RARHMvzy12s7BeIaRzB1e
	 H8NNCqAEFBCfR//RRM0Agw8Xq1jnf4H7IxALMVZNkLQ6CDPrYlVY3XbIeHbtKYFXDM
	 wB4oWFN945WBK9iNpBTtOM2KWRonYiiuY1UfYysVRhX6ifWseK6WIUR0oXW6vIWjVA
	 snl+BYAJwTlnfbCbqc1UIGQZlfe3ungVMWK+Ff2ll/S5TloiVs2BwuJD/0eVLixyWd
	 pM3dudEXcGXCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C350B607E4;
	Wed, 30 Sep 2026 13:07:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B13FB2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95A5E80FB9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUNEGmln5-Fn for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 09:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F121280FF3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790759167;
 b=MqFyYo+ibbbn+q07vsnBsj+OPG2A5uaeu6Z6JXFowRCIQRa7XKLuulguu2pg4L9xcxaw
 hjg9/5ICwNsn5fX4EXKF/GuLsV5750cDQEVavhTO7WPoLGG/XezZtVbE/GKQKAV1QWMyk
 0WCx04EHmieFNITlstWVdJEDUakPqAl8g8LaAvKAwFGXmkLeP3EP8hF4xUhqc0TsBU6/s
 ZuCSNfJHn5ofidaaIAvGpTEKJ2s/UFIXxCYgyH3+Bj1t+nz7XGeNkMyaUa89Uq/44OCLA
 ArD9nPipinlYNDLwNx+zXAAGvUAB+1LeTuqsfH7z0R63sy94OlgxCPYRFmGq0GLFAMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790759167;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=MxS4055tkp6kRTxXsXLZKAwISssfXT+b26ytPma6i7M=;
 b=KaehO3aVs1XTqbI9+Rz9VymhKVh8uRt/tDk1owhDFa3YoSj24+em1dOrned7+XGwdIJI
 +KC4Rn+2BW91t/G/G6ntbUDSomF4KCiY/UjJ3T0G3gRcQK1clvOhhFZ8yCm0YuZ3Y9k0M
 YOLqBZoLJ0PIERGj+q8LyODwxytkVoxCiUv+qxqswym77wMbQbzaoVDTCm+m7MZexX8/9
 zrjzSeTvByenFDKypQPDIYMEotwLE+T1jg6l7vr2RQVLBV8UxDniJEgefBOvD/BnxPLEw
 rvygizRiu0v5jw7K40As4fNV72iWw71bz5IaE15g4PuBymGr8W1TDVZbABDfnKjUAnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=oIxVS8Ig; 
 arc=none smtp.remote-ip=185.136.64.225
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-664519-202609300905422d03fef61b00020707-8qfrbi@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=oIxVS8Ig
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F121280FF3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:06:01 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609300905422d03fef61b00020707
 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 11:05:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MxS4055tkp6kRTxXsXLZKAwISssfXT+b26ytPma6i7M=;
 b=oIxVS8Ig9hZSdIoyMKlDPtut1KUyyYMbyY9GbE463WLz82jj4SEgohlcTYSm0ByV0nl3zg
 TgirwiCQPezd1rU18iXvTvUdAVGiRzdNFoINO1OTzilzfU5ZBSgXqZ59PbV1pM7hTZsiYDPM
 h9URSNKY8Kz62/EuT26btoXkvzLkHrST2gI+gLnpFeB1clSWUH9pUad3Hhx6F+8LYV7sDgtl
 I3iQILRiouYbC8Ngify3MRPtRQ9YRYWUsZgAKG5Ug6/26mxvaj+5X9X2BdpjygtDJRtx+Uoo
 +splq6eI/GUes8AtZ7NrfEeDYyMiFtOXPeCcZSWgzubhjrkwc/AHxEJg==;
From: Michael Haener <michael.haener@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Michael Haener <michael.haener@siemens.com>
Subject: [PATCH] tpm: Add an option to start the TPM during init
Date: Wed, 30 Sep 2026 11:05:12 +0200
Message-Id: <20260930090512.52342-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 30 Sep 2026 13:07:38 +0000
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
on the environment, so it cannot be skipped by a stale or edited env.

Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
is used (and then only from bootm) or when booting via EFI with
CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
uninitialised and the OS has to start it itself, which Linux reports as
"A TPM error (256) occurred attempting the self test". Boards have worked
around this by putting 'tpm autostart' into their environment, see
board/xilinx/zynqmp/zynqmp_kria.env.

Boards that share one binary between variants with and without a TPM
fitted can enable this safely: when no TPM device is found the startup is
skipped silently.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/tpm/Kconfig         | 15 +++++++++++++++
 drivers/tpm/Makefile        |  1 +
 drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 drivers/tpm/tpm_autostart.c

diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
index 219ea606b50..97979f39c7d 100644
--- a/drivers/tpm/Kconfig
+++ b/drivers/tpm/Kconfig
@@ -4,6 +4,21 @@
 
 menu "TPM support"
 
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
 config TPM_V1
 	bool "TPMv1.x support"
 	depends on TPM
diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
index b83ce703ec0..c3bc6074b67 100644
--- a/drivers/tpm/Makefile
+++ b/drivers/tpm/Makefile
@@ -2,6 +2,7 @@
 # Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
 
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-uclass.o
+obj-$(CONFIG_$(PHASE_)TPM_AUTOSTART) += tpm_autostart.o
 
 obj-$(CONFIG_TPM_ATMEL_TWI) += tpm_atmel_twi.o
 obj-$(CONFIG_TPM_TIS_INFINEON) += tpm_tis_infineon.o
diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
new file mode 100644
index 00000000000..23d8f3a53a6
--- /dev/null
+++ b/drivers/tpm/tpm_autostart.c
@@ -0,0 +1,33 @@
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
+#include <event.h>
+#include <log.h>
+#include <tpm_api.h>
+
+static int tpm_evt_autostart(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/* A board may share one binary between variants without a TPM. */
+	ret = uclass_first_device_err(UCLASS_TPM, &dev);
+	if (ret) {
+		log_debug("No TPM found (err=%d)\n", ret);
+		return 0;
+	}
+
+	ret = tpm_auto_start(dev);
+	if (ret)
+		log_warning("TPM startup failed (err=%d)\n", ret);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
-- 
2.55.0

