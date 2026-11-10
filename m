Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFE606A7E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FimU9x0o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XvpFTL3u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03EE381491;
	Tue, 10 Nov 2026 13:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZ2DU8IPMTTN; Tue, 10 Nov 2026 13:06:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 761B581457
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315979;
	b=lsSo153AqAF/INj59glnlyr1uyC6GORPhx/QANbs5Hsv65J/e0EkTFbJu6CnxU/1MEM4
	 dgTISaykGegTvmkf2DhXZvmrxFDkgWzkphWeBJMQJO8ATYXsdbv2hPoGzvkqRy4kHhgmv
	 yosQHhaEMqco0uqF3Xk6BfogWsrEkbXeX4aqv6ELtH9/ZX/FpzV1GeR2K/Gq3usu6erg/
	 lohmCCKCn5L13R2qAx12bcMHsmG0cifGEnBoKcFPP+9DaJNwrWDaeR7rGSn1ZjpD73qy2
	 7yMOI8zizFHwVmjEzzDcMQrKMhOLMGX06/YAmjkMOrTS+VTP1zNk4qlXhmTL+B/mshw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SS1vCoFlD+31czvJyiElst51Hx5JdpHHuEa02iptAJw=;
	b=DCz2k8GOYAJ5X8bcHNQd3A+YQS1ncE+fW0Qhea3xeRJXNyKzv/PJ9Y0CCd+FMpdLXQtS
	 qWZ1l6QaVqkigKpW386BrY1HVDO2dIW/C60oP1Q8v5YSD4q5eQlOm2/Qh3fNWg9QfxEyf
	 07lxGmeYiiuhBVy6sP26U3VIKn4atpBOqf27zu3Ksy6auhMNuORc3JEA5/SOO0Tn1MFns
	 PNgiVBg3CXv1WL6xIxFQxw4bYbH7/xwdUyrmtrwrBATsFgTwDZfyadP7SooSL7g9/z0gG
	 X9DoC6CDa/YusSryuc/fwlJ2zxn9NNit09I2YJNDzvGNhaS7R25mmwJgTT3s3XIxzwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315979;
	bh=SS1vCoFlD+31czvJyiElst51Hx5JdpHHuEa02iptAJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FimU9x0oDLkWZcYX1qHbSvYpK2U8YsOG92hwf4G6Qj56XNOCdqTX7SD0qKBcfkiq+
	 hVFCDvrvDZ8gH6GhSb2RUIZpDRLDkn4RcEj4RlAjoZThcxLQ/SGu6YUV3fEww63FBz
	 ayO+u9fAO8EeshnWx3WSAYMlfz3mylIVQ2i5CS9u5DfJa04/puaXwD8+02a+ZLFEDQ
	 1jsY7fstU4MQmqKi/rrVKjeYgaQn8HmOIESoPkShgmK+ZmaZNNc0K5FQZUlP/o9Vkp
	 MU26y5NVZUK85HW+fT88vde8l/jGFklfaII+jfTmQ3G/nrdHzerS0tZH3v8T0+pIev
	 FDofzeiU0Onaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 761B581457;
	Tue, 10 Nov 2026 13:06:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3705AD7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 284004008A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NU5gSVlozVj8 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 467F040347
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=XvpFTL3u
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 467F040347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1290E1E7D;
 Tue, 10 Nov 2026 01:58:18 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E677C3F632;
 Tue, 10 Nov 2026 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304701; bh=FL2hzvNEAzHC5Kvn0UJxY+USixgBLzNAUHgAqKHjuMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XvpFTL3uLJU+UCE0mSuudDxwMA4X61pHgb3KLTlyg0jThBexHlCTneYHjFJyy2CFK
 UIjq4hpnAOIzDWr4UjY2H+g+YRtvv2j1SKnN1UCcLtsIRgkXH8fheqSFY5Mly326Qd
 ZlW5Z3FCTuf3s/3qO1dn23JtjmdzAZ1/5CjKbOP4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 06/22] arm-ffa: enable runtime context at ExitBootServices
Date: Tue, 10 Nov 2026 09:57:47 +0000
Message-ID: <9c004fb23bbed9a743e81dc888125cd16fde4e39.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changelog:
===============

v3:

Simon:

- Move ExitBootServices event registration to the end of probe
- Use an early-return guard and log missing-context with log_warning()
- Drop the unrelated whitespace-only hunk
- Fix commit message styling

v2:

Simon:

- Leave runtime mode disabled if private data is missing and update the
  log message
- Register the ExitBootServices event earlier in probe
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
2.43.0

