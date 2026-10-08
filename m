Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6DFCA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6474A40925;
	Thu,  8 Oct 2026 21:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQ6o4djI8vkY; Thu,  8 Oct 2026 21:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 199134091E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791496529;
	b=GX44JC6ftLLVPEF2qYG8VmiEGDnJGf0O94uhJikkkzuv6p3Sgvk6TZAUBbhS4sO2EDuW
	 JDemPZHa0lGUQHBFuJbZJAq6TDFWtEEdmLcSkgi+/53td/yEHk3Krf6ZcOEfwbrHf08XZ
	 X+/pVYEgFhCkcsOdyWZwaSnOohoX4wHptXpqoNnA8aOaic4cs2zk1cFB1NsbrigjB1sBP
	 WFJPvxM9qz+0NHGp13WY5q3h0v/F/MwPeG6QcxBqVnD7ZpJ96iL7NKzkfM0awWO/BsIni
	 xxfEgGrv+pYcNumKz1enM+S8KCkolAFN1T7ohXhS8V05ZYxJzhw6NJtUaMMXSkMExSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791496529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4NaScZzxEPt0VrsBpPVe2lXFgV6fIw1CFPGsMNkP1gM=;
	b=GaeyQ1IlNY1zGsw9Ta9bmEllQTWMvjpoS1GlwbSnZOJqeErotTLs0rIFCA+9fTUIJ2v7
	 zzjhONTMx4EkklBaLcrpea8xkXUVSPfV6Fc7F6/kpzoUsXs/gjak4iKIlxEPsSWJkoAx/
	 2MbVXeihRjkUaMn6+InjbD2suIwzLnOC90xMvu/zTiMuK/FO3eFZbpk1ZWdhIkNlo0KYp
	 Xt9/SSNzDLwWOLRUEj3jdtSHUg9Azxebx9cFZn8F4EbS/HyxoHGhovWEYI41TjkEl8GcA
	 UPO1S8l2DbQheEBa4Q7gtavA7Do8x4QH9iAdK+gy8mjj9dKKHsMmvgr6tNl0xxT10XQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791496529;
	bh=4NaScZzxEPt0VrsBpPVe2lXFgV6fIw1CFPGsMNkP1gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eN+vNJZMc+lyr9GttQSXM8izfwpvxgcaAgP+U74p781oRUEt2zza7STZUfa/0FiWL
	 4EDGajFTxFPyLsCShcu135PagrFBGRwi6498TnAhUXEMJUz2Vifeylt6hIPFD4XkrW
	 1DPGYwr+LAUWs6Vk79jivgMUA6cVs/CJceuxfItaJyFz84Lqs0U2Cbly7EWNGdP+bi
	 J1csInlzecsZuZH1yCawl4AyBglsmLMocJO2syrU7uqnfs1JO0CZxpJa3txgTPwFrG
	 DiSvsg+ab+uXCypFj704C801MskesMgTA/eaEU19CGukfDzWXgWC9mVWYO1ykMe18l
	 wdzt7S/s1Y0GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 199134091E;
	Thu,  8 Oct 2026 21:55:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F88521A7
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85D136083D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQyaym-0TV-X for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 136226082C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791496524;
 b=O6gGWHDLOxuNsJjCM5dtYP7fh1mzVxOcumXMKm4woBt7T3yWUPOUuG4c04ksU7U/7eZg
 Qk0015tkdRUC/ziRmsVoDX0KJA9kstoXYxEQx0q2Dg2gyJg16BdmkDn+ZP1SKFLiiL7Jn
 VR1E3aa+xS7RkQKtWbNgs557E0wE05OgqCld0935yJp/eVUGDH3NKr2/9aNikY3GNjlXX
 OSrgQWZ/oCyy0E7XxtIRdnX6NqmAt63ypbsvD5EA5oIUzDN+skg2N8kS5fDTP9ydmIpyB
 eUvqdwAVl5jnXY6YThZ5OhVBZMaj3Ce75AvImsqzI4VtGibyzIBhun/ggggiLdqNYZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791496524;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=4NaScZzxEPt0VrsBpPVe2lXFgV6fIw1CFPGsMNkP1gM=;
 b=r7itP47KuC2p0DWIGkTmQ/D8kl9aypGAmj6Kkr5fyBtpt8+JBYGO6qVnumFeAk2SV/s1
 /kVSKynFx+VHKvEtuJO/sZiyvA7GH2p4r52Ksl8BR1fmI1jKvw6NfMggAoFmcvFhRC+/L
 oPPyoDYjlZq5DRsYjNuyJe2QrCSRFet319UM4G4eUQUvBp4AA+Kqv/iUkfPmllx6+1ecZ
 r/D7JH30zgAaswP2UncSpEJBmi7lMocONfWyFWC+82z7DfNTMjZ+TXdkWgXyfWfisw6mf
 9KQ3tR+2qjl0RId6jvDl+KVun0/s3xERiw2FGtRnmAaH5feZEVk6l87afR0xoJA6Tvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=ltVv2YI1; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-664519-20261008215520ecca365e9c00020742-ajlfyw@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=ltVv2YI1
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 136226082C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:22 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20261008215520ecca365e9c00020742
 for <u-boot@lists.u-boot-project.org>;
 Thu, 08 Oct 2026 23:55:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4NaScZzxEPt0VrsBpPVe2lXFgV6fIw1CFPGsMNkP1gM=;
 b=ltVv2YI16NNXmDgHCvqAPMb7VdDiGza/n+eGMGTLLLVosMXuwPeqUIUL77SgjSBeGmpDpZ
 JK7lSHPaK8VCznn7QwuH6hrYc8J6S5vjR9hLX7I0tQiH7r3gYIpMqXoHiTN3Ee6Gxi/JIRvX
 K/oiBg8AKOoU0HaflDRGuW1jSw27Xnxl/8WE9d1aAon45pshALyYKboWUkEm1E3tNqR0SsC7
 Yoz0HqoFCCB/31lEAikJdto2FYExH5bC2bMnf2CooveyyN4VLcmLZmfzZ68EdBL/Jz9x+Apy
 saCOm08xmhedRymXwKQd9yFA5gEjN4GkQ3WmGNoiTKNrfdi839tnjbFw==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v4 2/3] tpm: Add tests for CONFIG_TPM_AUTOSTART
Date: Thu,  8 Oct 2026 23:55:17 +0200
Message-Id: <20261008215518.209510-3-michael.haener@siemens.com>
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

Enable CONFIG_TPM_AUTOSTART on sandbox and add two tests which call
tpm_autostart_init(): one checks that the first TPM is started, the
other that a missing TPM is skipped silently. Both check that nothing
is printed.

Add the new event spy to test_event_dump.py, which lists every spy in
the sandbox image.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changes in v4:
- Call tpm_autostart_init() instead of sending EVT_LAST_STAGE_INIT
- Use the first TPM, as the handler does, and check that it is the v2 one
- Return -EAGAIN when CONFIG_TPM_AUTOSTART is disabled
- Check with UTF_CONSOLE that nothing is printed
- Add the new spy to test_event_dump.py

Changes in v3:
- New patch, split out of patch 1

 configs/sandbox_defconfig        |  1 +
 test/dm/tpm.c                    | 47 ++++++++++++++++++++++++++++++++
 test/py/tests/test_event_dump.py |  1 +
 3 files changed, 49 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a2708e6fb33..3efbdc6fdf1 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -400,6 +400,7 @@ CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
+CONFIG_TPM_AUTOSTART=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 87c5c416daa..3969711bc3c 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -6,7 +6,9 @@
 
 #include <dm.h>
 #include <tpm_api.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
+#include <dm/uclass-internal.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -197,3 +199,48 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
+
+/* Check that tpm_autostart_init() starts the first TPM */
+static int dm_test_tpm_autostart_init(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	char buf[50];
+
+	if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
+		return -EAGAIN;
+
+	/* tpm_autostart_init() uses the first TPM, which is the v2 one */
+	ut_assertok(uclass_first_device_err(UCLASS_TPM, &dev));
+	ut_asserteq(TPM_V2, tpm_get_version(dev));
+
+	ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
+	ut_asserteq_str("init_done=0", buf);
+
+	ut_assertok(tpm_autostart_init());
+	ut_assert_console_end();
+
+	ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
+	ut_asserteq_str("init_done=1", buf);
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_autostart_init, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Check that a missing TPM is skipped silently */
+static int dm_test_tpm_autostart_init_missing(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
+		return -EAGAIN;
+
+	while (!uclass_find_first_device(UCLASS_TPM, &dev) && dev)
+		ut_assertok(device_unbind(dev));
+
+	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_TPM, &dev));
+	ut_assertok(tpm_autostart_init());
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_autostart_init_missing, UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index b9d48f54dc2..4b43f65908f 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -20,6 +20,7 @@ EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
 EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/acpi/acpi_table.c:.*
 EVT_LAST_STAGE_INIT   efi_block_device_create         .*lib/efi_driver/efi_block_device.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
+EVT_LAST_STAGE_INIT   tpm_evt_autostart               .*lib/tpm_autostart.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.55.0

