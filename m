Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A3CC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E256881065;
	Wed, 14 Oct 2026 20:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BMJdZcjCXsL; Wed, 14 Oct 2026 20:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6C0B8104C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008210;
	b=ACKN5E1t2pErfSqmF1ZpKcFLKHO3oMJg8+fM7itxHWvdHzxrocpnrkzQj7JmizKut7Z5
	 InA6lDaa+KtS9IM2djjEhXzjgeRD5wVgINB/EEtvi8T9hkgyVc323G3fzVituYXwPULEn
	 jhzJhBJ9Lkmql84rnl/1XKwzEVQC6PplX8kFltOr3OiLDW52uUPmPOUmf9fwVXHrOMsXc
	 Q4GbkvBdLSV+DKiATGSmhbCK7VZSi1sWLsN+9QdtMbWyjnZ7lCpq6sNUd/qe/sugZwUYC
	 jZrdgFOqgamAgJYL7q23UlyLvwR3+pqRHv/WW+NGRCT7thjUC+I1KtA2Zr/7J6xAo+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SS1vCoFlD+31czvJyiElst51Hx5JdpHHuEa02iptAJw=;
	b=b+MBkB+MKqP0lsKkQC7ry2S47R9p3zDeGFWZ6XZ6BRzD39bYhh8hvRgc7pwkcrO7B9kd
	 zhFHYoZTgrh1xufAH98M61EwGQnNHw18Qcpium87Jj+mELhQixIwgNZMC5wupcZIr0DzR
	 iUYk6RoBmNhD6TP4X4JlMIxVSljdVko7lyDaFNvc0Yn5cgQpHctDtxp7k+hD8F3GSRzhr
	 9/JsK7uTdWy7EMWII00WVlksbNoG99ydukAvxz+lQoH3Hs9TUt52/lBlIqPCDBoMcERRb
	 lS/uKw5WWfUXS6BoI7Kg2j1fhVVMzLvQCxawH10BJWCG4dPqSfaiVv+Ec+e6gt5/fMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008210;
	bh=SS1vCoFlD+31czvJyiElst51Hx5JdpHHuEa02iptAJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=voB2ORyQJUCjrMMoCCdaXwrJMvPFJqYaEHb0w1BxZQ10Kd8o1EhlvxxywSmQhNms5
	 34B/6kH8WkPcjTs+18s7hfBrGn5ERDAU+JeZnRMnWj6hyDXcA6BDHk0AzxNRGnAoZU
	 aRh3ysVDfW0HPnJbRQKUxBevZKhJ1bNlWFpsy6ZqguX+2mlNL9CYyOWJfvkLqmnKJp
	 VFgCetMXLI0YeVXEEbFUklCj2s10yYj51eub88ZwAncEMyM3chO96zkMVmCL1+hkBo
	 /GxRQFGAyGTXYUJ4fNDmU7crB2MaSxP9S4alJj0TItnveXkmtylvQ0pofPWlKsJaVF
	 EWYTPeN/1mUHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6C0B8104C;
	Wed, 14 Oct 2026 20:03:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B49F81DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B5A640191
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSQWf3M84jD2 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B129C4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002201;
 b=ElnLJ3vcNr06ARd24ZVIt+/vPzX4nQb1Ns3NVhtxHk3j5CnyYXCiuZHXneuxvgwd1mUj
 ydLqJGlAwjG8dJIyMbJ7b9Wjok7eajnbjXg04mIac8W8UPfZHCuSw1GEj4tpY/wabQGfi
 ZffOEGTDcjgOVFN94wslTGFzPtOaX4qb0H7OBIhytyO9hgporXt3Wi4zQhqOfTxXDnFeJ
 APXVtCJDJC4h9cpIJtMnINP0o424CYE6u+V5XTBbCzFeqJIz4Dqe+7PJaRoCID6uicSEx
 BRWkVOPgvtb7F/gk6sbfGN4DByO5RmQKjlGPSgwwLoWu6HBMxQa74u4nPYElRH3Qkcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002201;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SS1vCoFlD+31czvJyiElst51Hx5JdpHHuEa02iptAJw=;
 b=Rj2ppxlEV8zmjgdOP6nYKdmJjzDHQwMO3CEPqW2pur1UoER+FHbGp7fy/2HIviOnZMpR
 YBTBUJ5G72qRapKtypfC5v4H3VdtU4F8oZcP7WwJ9zUgAPXA9dgGlD6rM4jJTOr2HfB6g
 QJ0RF83EYx9ezp0A2IjDf5WOn7yA3OMzjgpH/oePrpkHt5VduQ1LhKAYhGlSqW0VfoKdl
 kUzVkMsKUIzwWmPgEwv7VD1nBiRv8XT5HK8ots8hGxGEWHpBquCmwD5pG3C/8F+rh8HnZ
 3smqQWcKlG7YR8geqrxAVKVFzxMK3JC8nStTC5lGh8Rqd5hVtOkj3iv1aZ3Otnao4tA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=fOpc6knP; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=fOpc6knP
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B129C4009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE088152B;
 Wed, 14 Oct 2026 11:23:17 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F353F871;
 Wed, 14 Oct 2026 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002201; bh=FL2hzvNEAzHC5Kvn0UJxY+USixgBLzNAUHgAqKHjuMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fOpc6knP34UPa7SWiJUM0dvduhRzgsoYRJBxYLwp1NuywSVFdL9o4+G3VUz2n2JrE
 YnrB9KqUzpm9ZhRZZHAoqbaCTX/SQGN8f4okEPFQJTrWw6ecG6sfUibYl03Uj7nWFp
 6uSXJZQku5QQW0F+JHl6bQ6DI9/+n/nTeIfuypRA=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 06/22] arm-ffa: enable runtime context at ExitBootServices
Date: Wed, 14 Oct 2026 19:22:46 +0100
Message-ID: <035fe2712311c4886f08ad68f852f3b7f13c567b.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

