Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E4C88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F38E8101D;
	Mon, 14 Sep 2026 14:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bhdspGdp09r; Mon, 14 Sep 2026 14:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 67C7881008
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395486;
	b=HPHLpw4GDknCAmtO+LQxMRBedbBTvXwbt9h+9z6MPU3jxHSE5IN/DXDE/hYHNNiWwKZs
	 expczy1CNDWsP11eQhcCDeLeLnxEcZs3a5aAa73tyhou0UV4HnblTE1NhdfJPGBsoOlDX
	 FNOmkRKR7v4uEydSPIVSx7ZUqi9OBFFBOxKaaI03IhXt2t1TWuJ8gFtxSJhu+LkCbgL3F
	 ZztVMRrH3cB8McERGtFKMWcPZytVdxusBCHvz+9f1YgOHZXgAbGwEzw51cFCu6LJmt9q1
	 uxg5b59TmW+OkyrY87VDg3AwQfixRlTkBqpAhOrkp0M2KsSy04ki6Appf8a+Zk18YuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jYv8bkSu1yC1NN8wLM+GYrigGeFVZ1kfUiPtGmwYjy4=;
	b=Lm0kj+p5RI1QQ+JLe7rx+k6B5E2VouTQVWF7IXZgaVhaWcyE3CPoceld1vy3uigwiSNf
	 Dwoyry4GkDgwwtbvHvPaMNNkFioIejJAKbP+mcbVXVP//0SLlpemMVuDDhwqMU8kb0Q2f
	 4D7TBOLReloLrHGTx+7U153rlXmJtyz1kDrcu/Qdk31z/IG2It/gmGP2UTVBWZhB/L1Ru
	 UaX9LmZ7C5ZnBevgW+5xbp66njdCYqUGjKaPOt5Pcykd/dt7BRYy0Xtr2R41u8873sqfN
	 Ro+mEyTPH+ryPkgDq2mbPCngdN4OUERG9kx417LSJMxfUYu3i9K43dQ+Spn++Ggcv/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395486;
	bh=jYv8bkSu1yC1NN8wLM+GYrigGeFVZ1kfUiPtGmwYjy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PenQBo+leUi4eRXbm6W/1pwYXE/gpFuNbvAGx1/MALF67jhWuM8cCjqXLRKHcYB7U
	 o8yybW4S/1MBtgvUv9Wum5D1pvI1j/0bPxoqh6O0qmf/g3n+I1/DLJPKm8pmRmmPSU
	 B/ZByAfbKYC3j2JfLt0jNeGIdK6pBjx2J2eK8eel9oJzqg1yvqXPzOLyR/XCi3tAQS
	 lG71loA4qyOSyQ/CV56AhaLBak8Gj5XC1imSVfvbNmH8PjdVQJ6s7M8nI3EtGfGk/6
	 KoTFXxrX6WYqMxU6iXdfrqJ7ypJshMvQKoot/7KQwG08kSwZmW9gwlEWuuLUyOYI8Z
	 /Pvuk8LxjJjLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C7881008;
	Mon, 14 Sep 2026 14:18:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EA8724D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33F3B60689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id On9AUZwk_gOp for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A26206069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=ClOXKL19Z2YHeDzvNxFhZ0exgIn+hG8AFCiVp8eLHrgorRJAQ++9KS3GlSobJb4Il6kj
 AjBIC/lLUWES22gRmVLLnxx3xvesBuIwix3lF6Ml44pw5bdIszuEhlbF5zYqFb8Owy35J
 dVFgWsWVHu+PUvDX9mJuscURptJQo17pAN4QzLuFxtyC6db+S6wVtcd5LXShrXZiASYE5
 rhf9r/PgCY84VTGK8QHRiQwccAXv7l1XkhbMGrUDudw1ykl8l7Iy9xNtbHauJdoFxplG4
 BzmSacOJc2uuE1qOFwLkjwLFs/TQDbTktIc4dNf9dJuJXtSvV8bv2fOKhFZjq+mK/9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jYv8bkSu1yC1NN8wLM+GYrigGeFVZ1kfUiPtGmwYjy4=;
 b=SJi5s04IE9SXF8fSGRNPvEw2VqFRWOaCvJ/gX1CREoaJsPUYsqKXe/V4XdDM+428vW7x
 sbjyYnqt0idqICvj0NaEyTDzyo/SntIIrCcsOgBoSxKdTeyHLfGnB7Q8BFoNv4sTOonUx
 APdld/v0XPknrNPR4SHbdKhGRchv2R12cv8maVbINtUt+W5pjLZ10FiFxBQ5pW++/qNxr
 NStohr3Gi7qJWww5tayL6Bnk6pB964d/eBs2Mjr0rn9aoGbVPUi79NLPI9tG97rQZXxdn
 I+FthdNbpGYhRZVlNXN4+QcTrUZFxQmBklBrbHVImXFqh/7S1iWDaa/CHXVGH0bnIDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=WqfyH3K3; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WqfyH3K3
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A26206069C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153E21D15;
 Mon, 14 Sep 2026 04:01:34 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3363F9A2;
 Mon, 14 Sep 2026 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383697; bh=6US+bg8vRPPGs9blE4aoPY/Evnt0CGMgA8Gb7KPXPko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WqfyH3K3dJHSZh7KXoy/7L4LTaQAlOgRNBW5Vkn/jHYsWWc4t9J5Qb4ZfxJLv+bIw
 J0lIop9GX6tZw2/BBxBkp32n6rfxj8L70QbOiIT8vcRpI7nimkvNTGY7qDo926qoW2
 95crbPiLydjJOK8ga+ErXfYDCAG1vnkBe/kdI++E=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 06/22] arm-ffa: enable runtime context at ExitBootServices
Date: Mon, 14 Sep 2026 12:00:50 +0100
Message-Id: <20260914110106.1974894-7-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

