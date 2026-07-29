Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02193C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD30C60B31;
	Wed, 29 Jul 2026 12:28:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8rZS1e8pj2w; Wed, 29 Jul 2026 12:28:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4748F60B2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328104;
	bh=0YCGyp+JdD2SFK8ArgsnOZPHqH6x3myEZBfquIAFDck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upxeMWccqOkoPiVMye6sOo9Xb2Pzsqro7lU3DQdLpW/pR2FMDFae35WZVXVFcl7S6
	 pytsoJPll7WD8RxsRdcEqHyXED2FP0DDys1GaWqkYKZKjkDnKlkm6BRdVcP6MMM5sP
	 KZkcrd2H2dlxseKnExtLIgb/GaqEoKJJLzYzVMdI+8eNY8jl+95M4CfGH2r8mDLq9v
	 +h0YTyFAlfnqZXEeUbwNRQSX5554f0DkE+9PAcdf4gY/lTGoYXPd/Xsyu/R1/+o9zw
	 RaGCyVZeHuxKCvsv2VkL0uPhBrxf+s5GRZKvMVEAOFt1djd3rfsmqpPLBmH1HQgH3a
	 JDYGWABdJh95g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4748F60B2B;
	Wed, 29 Jul 2026 12:28:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4160845B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27A4040AF7
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfUpW-8LmKUv for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:51:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9D56140891
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D56140891
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D56140891
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D37E849A1; Wed, 29 Jul 2026 10:51:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DB00C8493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:54 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23794169E;
 Wed, 29 Jul 2026 01:51:50 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9F73F66F;
 Wed, 29 Jul 2026 01:51:52 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 06/22] arm-ffa: enable runtime context at ExitBootServices
Date: Wed, 29 Jul 2026 09:51:08 +0100
Message-Id: <20260729085124.2618817-7-harsimransingh.tungal@arm.com>
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
 t=1785315114; bh=ft9fQqq/DcX1X8PQ8A5LfvDu2DhNBJlIP6LPZ8Y1R8s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=imM5oiCUdtZybYi7Ruwy+/FY4uBWn/HNnAjEGrYYvPU0XccAfsdcGZitfC7+bQ+u6
 4Ralw5jFQwp5AAE1uBM8YVdSY0WzaRLcB0qNG1Pdq5zTGptLu5DLtwEEc1qyeeVXP/
 RYQTzJwhz5Q+sgmNKjinI1OIcbdNchyVKhcAJNGk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=imM5oiCU
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="imM5oiCU"; 
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

Register an ExitBootServices event after the FF-A bus has completed
probe.

The callback copies the boot-discovered runtime fields into
resident storage and marks the FF-A runtime context ready.
EFI runtime services can then use the runtime transport without
depending on driver model state.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 drivers/firmware/arm-ffa/arm-ffa-runtime.c | 43 ++++++++++++++++++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c  |  9 +++++
 include/arm_ffa_runtime.h                  | 18 +++++++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
index d761ec9ee07..84c1a203d40 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-runtime.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
@@ -37,6 +37,49 @@ static const __ffa_runtime_data struct ffa_bus_ops_runtime ffa_ops_rt = {
 #define ffa_get_ops_runtime()		(&ffa_ops_rt)
 #define ffa_get_priv_runtime()		(&ffa_priv_rt)
 
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *event,
+						    void *context)
+{
+	struct ffa_priv *priv = context;
+
+	if (!priv) {
+		log_warning("FF-A: runtime data missing, keeping RT mode disabled\n");
+		return;
+	}
+
+	ffa_copy_runtime_priv(&priv->rt);
+	ffa_runtime_context_enable();
+}
+
+/**
+ * ffa_setup_efi_exit_boot_services_event() - register ExitBootServices event
+ * @priv: pointer to the FF-A private data
+ *
+ * Register an EFI event that enables the FF-A runtime context when
+ * ExitBootServices() is invoked.
+ *
+ * Return: 0 on success, -EPERM on failure to create the event.
+ */
+int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv)
+{
+	efi_status_t efi_ret;
+	struct efi_event *evt = NULL;
+
+	efi_ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
+				   ffa_rt_exit_boot_services_notify, priv,
+				   &efi_guid_event_group_exit_boot_services,
+				   &evt);
+	if (efi_ret != EFI_SUCCESS) {
+		log_err("FF-A: cannot install ExitBootServices event %p, err (%lu)\n",
+			evt, efi_ret);
+		return -EPERM;
+	}
+
+	return 0;
+}
+#endif
+
 /**
  * ffa_copy_runtime_priv() - copy runtime data into resident storage
  * @priv: pointer to the runtime private data
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 668c2156f8b..d21cc4cc35c 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -937,6 +937,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
 static int ffa_do_probe(struct udevice *dev)
 {
 	int ret;
+	struct ffa_priv *uc_priv = dev_get_uclass_priv(dev);
 
 	ret = ffa_get_version_hdlr(dev);
 	if (ret)
@@ -960,6 +961,14 @@ static int ffa_do_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		ret = ffa_setup_efi_exit_boot_services_event(uc_priv);
+		if (ret) {
+			ffa_unmap_rxtx_buffers_hdlr(dev);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/arm_ffa_runtime.h b/include/arm_ffa_runtime.h
index 77b528745e8..bfc4d387660 100644
--- a/include/arm_ffa_runtime.h
+++ b/include/arm_ffa_runtime.h
@@ -84,6 +84,24 @@ void ffa_runtime_context_reset(void);
  */
 void ffa_copy_runtime_priv(const struct ffa_priv_runtime *priv);
 
+/**
+ * ffa_setup_efi_exit_boot_services_event() - register ExitBootServices event
+ * @priv: pointer to the FF-A private data
+ *
+ * Register an EFI event that enables the FF-A runtime context when
+ * ExitBootServices() is invoked.
+ *
+ * Return: 0 on success, -EPERM on failure to create the event.
+ */
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv);
+#else
+static inline int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv)
+{
+	return 0;
+}
+#endif
+
 /**
  * ffa_runtime_context_ready() - Query FF-A runtime readiness
  *
-- 
2.34.1

