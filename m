Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CCC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20DEA81298;
	Wed, 29 Jul 2026 12:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehe3a_a9Pf6Y; Wed, 29 Jul 2026 12:28:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E62B8126E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328112;
	bh=ZcP/nzAE1k76Nb2EsCaHOX7MRO6lcW1Cy3YvuAmFiog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOqDHuYEJGOq11WIsDLUMC4RqVeji40Y9XjXZRCzY97ACRiXlUH4siJFmWK1g3RHx
	 iZz79WDXIw7yNSHsPddIviWvPdRN1lPh/PKRl4rh+IzrIzTWqVXIhgJ0DKgvAfrtjZ
	 +NV4G0AMnvG3n6a0cYf8/6xww3jf/gFwyisuc0r2MbJ5E6iu2kVQIZgHHqRLgNps40
	 R3Rd6j69xfJFbL0DAc5ZmXXdv38semkOCa97/PKYd6Ezqb7ZCpTqlnRg695ec2luVG
	 aXTt0OcqnyJr07NuLN6FofYlOTAik1IU6rUS3rJcaFSrEHO124P8KwihcRjkdogKZC
	 IVUlZ7eJjnQww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E62B8126E;
	Wed, 29 Jul 2026 12:28:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F7F326C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21D91607D3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7cPeonYU-JS7 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5A8B60836
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5A8B60836
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5A8B60836
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EB68493F; Wed, 29 Jul 2026 10:52:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 963718404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:00 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5CD4169C;
 Wed, 29 Jul 2026 01:51:55 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 633583F66F;
 Wed, 29 Jul 2026 01:51:58 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 09/22] efi_loader: make MM transport selection runtime-safe
Date: Wed, 29 Jul 2026 09:51:11 +0100
Message-Id: <20260729085124.2618817-10-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315119; bh=1Kgq8gonFbsIlQZrtzxbuWrBp2iSZwdIVAuVf0O7wW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QLMV3r4QngL1nO/iVf17zcXFN2VnRr8hcQktc/afUttbSrkU/d8uZrP6s/Lq5bcNo
 ong8kiAMUHZ5s1XE0a5cN+xrZLzNxcoUC8aSNDKFVCg/dti7ZNGzayEfiRStoXiZfO
 m7OvvbAKIzkuI8HbMo6gZa064Bb0+8SIuBac0zqs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=QLMV3r4Q
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="QLMV3r4Q"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Track when ExitBootServices() has been called and make the MM transport
selection helper callable from EFI runtime code.

At runtime, select the FF-A transport only when FF-A runtime mode is
enabled. Otherwise keep using the OP-TEE MM communication path so builds
without CONFIG_ARM_FFA_RT_MODE do not lose their existing runtime
backend.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 44 +++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 8a75da414f7..72055b36bba 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -56,12 +56,28 @@ extern struct efi_var_file __efi_runtime_data *efi_var_buf;
 static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
 static efi_uintn_t max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
+static bool __efi_runtime_data ebs_called;
 
 struct mm_connection {
 	struct udevice *tee;
 	u32 session;
 };
 
+/**
+ * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
+ *
+ * This helper returns whether the firmware has transitioned into the
+ * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
+ *
+ * Return:
+ *   true  - The system is operating in UEFI runtime mode.
+ *   false - The system is still in the boot services phase.
+ */
+static bool __efi_runtime efi_at_runtime(void)
+{
+	return ebs_called;
+}
+
 /**
  * get_connection() - Retrieve OP-TEE session for a specific UUID.
  *
@@ -399,27 +415,30 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 /**
  * get_mm_comms() - detect the available MM transport
  *
- * Make sure the FF-A bus is probed successfully
- * which means FF-A communication with secure world works and ready
- * for use.
+ * Make sure the FF-A bus is probed successfully during the boot phase,
+ * which means FF-A communication with secure world works and is ready for
+ * use. During the runtime phase, use FF-A only when FF-A runtime mode is
+ * enabled; otherwise keep using OP-TEE comms.
  *
- * If FF-A bus is not ready, use OPTEE comms.
+ * If FF-A bus is not ready at boot, use OP-TEE comms.
  *
- * Return:
- *
- * MM_COMMS_FFA or MM_COMMS_OPTEE
+ * Return: MM_COMMS_FFA or MM_COMMS_OPTEE
  */
-static enum mm_comms_select get_mm_comms(void)
+static enum mm_comms_select __efi_runtime get_mm_comms(void)
 {
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_debug("EFI: Cannot find FF-A bus device, trying Optee comms\n");
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
+			return MM_COMMS_FFA;
 		return MM_COMMS_OPTEE;
 	}
 
+	ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ret)
+		return MM_COMMS_OPTEE;
+
 	return MM_COMMS_FFA;
 }
 #endif
@@ -1018,6 +1037,9 @@ void efi_variables_boot_exit_notify(void)
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
+
+	/* Record that ExitBootServices() has been called */
+	ebs_called = true;
 }
 
 /**
-- 
2.34.1

