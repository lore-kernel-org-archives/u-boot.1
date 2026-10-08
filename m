Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2957CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CCFB60873;
	Thu,  8 Oct 2026 21:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlktR3QQ_xLW; Thu,  8 Oct 2026 21:56:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 405FB60832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791496591;
	b=IoImwbhNqZVeDKLgB29tglGRJIt0X28e40lo0fvqvPPPeY6s9kjy9m3dYzDVWEUTrDg+
	 W0XEu9tdxmouflwJeIB77xMceoy2CksizHFFK7iGy9+jmGQpkNAsNZIPUM0WIhs1/dwAH
	 xhWDjJA7vIBR6FF1yK7QHLts9vZjS0xUc3b/lEx3a67OK1Q+jl4NthJBb8Pq8+oYFzBlJ
	 A1mCug+ygoJG80OyQyNxK6Vo1JblXJWaoIjM0/bv8bpOhomKIjjBRSULiVEK+lsAlobjk
	 UEUX6dqGQdH4zFhnRjYWLeGP+9tnl8PBS0pxnecGUO5nYkOjCezRkez5JQ7POxFWEJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791496591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c0+BQX1I25V88CH+aAYqz/53Uo65bndpcuIAO/H8Du4=;
	b=NpkpelMVQ1+7neeAWEl5VSFud85nY13IKwA2IyCEDVgae8jONKELygvPCjtvwq8p2Fyq
	 tei5qcABSqc27xHEPQJ71T1KP9zRTx7Yf4Hcu7A6S+jKgOg1ZghX1g/r8SyGxk2E3YbbV
	 oJKlLK09UksEyI6nQl/llHTccBqx4L86Sb0Jq5OgKiJNzCqa16oIVnF9vhTm+n+EjTXem
	 pFRD1y4c6kZyCOaVh7Qi3Tblqbz9TqNUqDAhPSAeTbihFR/G60yGezDZ4Mlh++CshWs9Y
	 S4RSKPLO/B4RLV/UHVoYvi8KTknMIZthLNPHlWoAMc6zF2woobmc3TUWa0/3KKgOVEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HzoMYgfL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791496591;
	bh=c0+BQX1I25V88CH+aAYqz/53Uo65bndpcuIAO/H8Du4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYNvb9Vcjx9QBwKZhlZkERBieeAW50WkGO/FgE1HiS4j150FVZq2WeIVt9qV3tvSE
	 HQ7itbJ41uRckh8vljVqGJNQi1h8VarKj6q9B6wgCaCH4sJ6ZJvQEu6/1aLMgh9/aP
	 a1rJcW+E3ekZ5MsMgRA0abR6oUn4kXn0KhPS4+ynlPvmg6I1q4ktPvNz1RpeLBqG6F
	 RBrGIM/FJVqxwhUyXEYDt3+MTrNU1KX+2YCuiK2Iw0Q864zi0s5N5moY3Hhwbhp43D
	 LWDqtSLgOGKswuAAX3XrFbrqqTLOSza/eU71NDPoOs3kh5El41sJL9GDE26PYyVOMc
	 XK9BOPieI25lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 405FB60832;
	Thu,  8 Oct 2026 21:56:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21D9E156
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07A8560832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHzaIuWZWrnh for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:56:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D233B6082C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791496588;
 b=lGmCNV0J+MGp0bXegYCAVDBKV1sS4HgsZpGYiF6xfKBu+WgkEOOKtaKMeOTjFFtDdXeR
 KR7VyV5QzVs41J7WXkWXvFS8yBN1z4pgnxeuh8+rBG02FxkLfmHz1BVCrYr6DACkAF7+Q
 0XmxOkmXUwZ8HjmNxPSqYJghsYNQhY4VmaQlTQ9ZK2UGbzEcRg5OmaB7rn+DO+1DFF0nQ
 vn/EFVqP/AVe6MbSN0QarKG9cMCHVxNFXdYtsj3CMmRg0mPRv3JqqK5JMx8rHAsc+6+73
 ll+j2j3zhy3NQPAS5UGftVnJxXqy4sNhXPxBFFuJqrzC6uv+ltVzfbRkWHwV59otEtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791496588;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=c0+BQX1I25V88CH+aAYqz/53Uo65bndpcuIAO/H8Du4=;
 b=DGfUIHaqE1NBC1gJ089PZf53RQXn6GE8iHCQYHLb49VFRVSTChfDjCmRTSPJbggmETrB
 /ohGpgkAeo4pHmJVp4CYbtNbOP6ZWDv9S+lBqpYo7au1sB+lV4CYHdtafm7t/pINPuUKn
 pASqMlbR/7UkmLxMpAPw6d+HZWgW2ZnjI5FbWzHggcxaykK7C8xOIpTRXONrf/46b478R
 Jnhnga/eCAloWa9TzG4l87Cd26FnrhXKJVafw4nHvltnoYIa25hWwxT+tuhqoGcHoxxV0
 wT98a5N0G2H3wjuZPkj+QSfEbAvA2mFKNlHoRV7VXVCY2A0WrDeC6kjrBhfLoYQdcFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=HzoMYgfL; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 21:56:27 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=HzoMYgfL
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-664519-20261008215519ec18fc4d7b000207c1-o7onnv@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D233B6082C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:25 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20261008215519ec18fc4d7b000207c1
 for <u-boot@lists.u-boot-project.org>;
 Thu, 08 Oct 2026 23:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=c0+BQX1I25V88CH+aAYqz/53Uo65bndpcuIAO/H8Du4=;
 b=HzoMYgfL8K5CIQXXJ+UJSLH6n/5/ycA1l0pkMbnPTgIefuI+kDF47/vJMh1MnD/s44H6an
 BDSMhkNRnN2F2g+TLnGVuxQ0tjsRoQMtgJjReaFbxY9TnFg0sl5DMOIRYpUa2m8Hh8Yrd2dR
 Q++mRN+qnW/cGpUh0esMJSDeWVeUsJ66enBLABrtZAC5Y5BUdAlmTBybHNbl3h4xBwXZXucB
 +6tjQY2bEhHCMQ5XIruPPvuyo1Pd18tuwn0doNexxPU/Xv1gVN5EfZrpHswfPa9hSnbDHbgD
 5nLZ7VvYO2UOMG7sf/xbeOzTUh//agugZwfPIv/xkcCkLIUMCHax0Qyg==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v4 1/3] tpm: Add an option to start the TPM during init
Date: Thu,  8 Oct 2026 23:55:16 +0200
Message-Id: <20261008215518.209510-2-michael.haener@siemens.com>
In-Reply-To: <20261008215518.209510-1-michael.haener@siemens.com>
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
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
existing callers. The startup itself is in tpm_autostart_init(), so that
it can also be called directly, e.g. from tests.

Boards that share one binary between variants with and without a TPM
fitted can enable this safely: when no TPM device is found the startup is
skipped silently. Other errors are reported as warnings but do not stop
the boot. Note that the full self-test adds to the boot time.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v4:
- Move the startup into tpm_autostart_init(), so that tests can call it
  without sending EVT_LAST_STAGE_INIT
- Add Reviewed-by from Simon

Changes in v3:
- Split the tests and the Kria conversion into separate patches

Changes in v2:
- Move the code to lib/tpm_autostart.c and the option to lib/Kconfig
- Stay silent only when no TPM device exists (-ENODEV), warn otherwise
- Use u32 and %#x for the tpm_auto_start() result
- Mention the boot-time cost of the self-test in the help text
- Document the option in doc/usage/measured_boot.rst
- Explain in the commit message why an event is used instead of probe

 doc/usage/measured_boot.rst | 18 ++++++++++++++
 include/tpm_api.h           | 10 ++++++++
 lib/Kconfig                 | 19 +++++++++++++++
 lib/Makefile                |  1 +
 lib/tpm_autostart.c         | 48 +++++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)
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
diff --git a/include/tpm_api.h b/include/tpm_api.h
index 022a8bbaeca..73c0ac6b3e7 100644
--- a/include/tpm_api.h
+++ b/include/tpm_api.h
@@ -339,4 +339,14 @@ static inline bool tpm_is_v2(struct udevice *dev)
  */
 u32 tpm_auto_start(struct udevice *dev);
 
+/**
+ * tpm_autostart_init() - start up the first TPM, if there is one
+ *
+ * This is run from EVT_LAST_STAGE_INIT when CONFIG_TPM_AUTOSTART is enabled.
+ * Errors are reported as warnings.
+ *
+ * Return: 0 if OK or if there is no TPM, -ve on error
+ */
+int tpm_autostart_init(void);
+
 #endif /* __TPM_API_H */
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
index 00000000000..ae69f797652
--- /dev/null
+++ b/lib/tpm_autostart.c
@@ -0,0 +1,48 @@
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
+int tpm_autostart_init(void)
+{
+	struct udevice *dev;
+	int ret;
+	u32 rc;
+
+	ret = uclass_first_device_err(UCLASS_TPM, &dev);
+	if (ret) {
+		/* a board may share one binary between variants without a TPM */
+		if (ret == -ENODEV)
+			return 0;
+
+		log_warning("Cannot init TPM (err=%dE)\n", ret);
+		return ret;
+	}
+
+	rc = tpm_auto_start(dev);
+	if (rc) {
+		log_warning("TPM startup failed (rc=%#x)\n", rc);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int tpm_evt_autostart(void)
+{
+	/* errors are reported above and must not stop the boot */
+	tpm_autostart_init();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
-- 
2.55.0

