Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF5EC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 871F160B96;
	Thu, 17 Sep 2026 17:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0zUAw_rTX80; Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EC2D860BA8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665603;
	b=qz0Hok525xg1iZpN9nnbRmp4kxkj4Ea1+gbuRuXOoLWqQt/t92nYUWtcIG+4IQAyntFq
	 lEBX2/iWwrGqsaWZ1wKyN3FxKsAzlZI0GwHHUn6xXFh2OhPxL81Czm5cuP52sv/DPMue7
	 EZCcgJMCai9jYoRXmk6wrKzL9sXftbuV1GdzH7NYNl78pyo9epnm5vpDRSKKOuCKqCyNw
	 ssFB0pNWkeVczCo8e2Awp/PJ9VBBX3PR9arIrUR46twMDTFPu83yyrThOwDddzaHGZdaY
	 ouW4JxGVx5Bc9Cz0mk0QJsgbYBGQFi5BpC1OjHPVm8dVV6OvfBCcGQ+IdSkKNMaDGfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nWyHxlImxiPnZZhYvBPNVHYCThHlYQs1nGxoIM0nfj0=;
	b=GvpTJXsOCnrQxZHJtCaLR7Ck23VmQtwpcped03LoIHn28+NXuPEbIARSQ8KnHW1UoTIA
	 lTpDzlTlhzU4q+c8w1f/Sk8Qe0P6uj7QQI+yYbW8nyVmsQVQDkYfmU9Ep+EqlyInqJSx+
	 3CE5PYDRXTGuRYZE+oWcwPml8Mcnp+aptobdR+EborPH9G7hQGkdBrm6pc2r52+TTpNf6
	 gTNvdhYczNXVxW5JZuad1J97+IuApDKh3YOdi7rgYOQ/VDLWdHMvR4YGzw36v8K00xz8l
	 KyAo+DS9USU/m0qmWU4Rn37wu76Z0oBQ2bvGLysZJkUEmIhDk8fEn/ub/T2i0T6r+HQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665603;
	bh=nWyHxlImxiPnZZhYvBPNVHYCThHlYQs1nGxoIM0nfj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U9IOc1TZ9BtIhVA2P8PPyIhLck4p1X9OvSH+tRd+JcDtcezefS+lTfl4cj+2dM7aP
	 v7wua/GDU/CuSh0xYSwYprKtAomooL04kOt9LAa0jfUs3kcebmegu5dyY+D33sV7o9
	 QE+X9HAQoVGxacWxLk+rXFCzwpBArdS03fpZxuStA3tAEgMgqer3V40RiJcrP+49mp
	 l984JArCAQLk2AYeJ9uFTQpN6YqI/rsJ1SeGid3pozvJnKoGNGxagx33bj37St5S/t
	 0tdbn1ssx195NGv2dXSWmQgCKRUYSiGwmSMxXyT2TfiW7deVIhmAqoqbcryGhWJUpK
	 mMoSffDvbhv2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC2D860BA8;
	Thu, 17 Sep 2026 17:20:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6CC913D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD15940427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRVQqcCBFcOv for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A65E140378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665546;
 b=jw7DAIQQsMbewGX6jslwBd9U5NXgozsWBKHPz3SYxvpB7GO6JsnfcecsxKKmvVgpZLPW
 uD7HwR+JQiuP1vxtuscshcsYg0NkBR/VT+D5C+8eo737UeL4c+EZtjnQP4+VwDbGhFrj+
 yz/usDa3IOznv1mLFIci1hhJIRlC9ksdWHqfQ6qxbBJmATVlKovyPJ6b9jQTgNHl8XD00
 roosSRy+vqhcGL27PfiKM6gbkerfGTWDLqzHjv78CjRXGUB15cXxRYGUFW2NnIqEAveAM
 GqQ6KNr60MOnRLYBK6Gve2oLPoQCiOJQfNkUsiVLS+SM7dWZtjQJj3CAnKD9DGnllkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665546;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nWyHxlImxiPnZZhYvBPNVHYCThHlYQs1nGxoIM0nfj0=;
 b=m95m6PyTxixKV9CcHTPDWgnizE81El0Q0pXc+dL0RLY2BnMUprTASq+dw5H3GAEQVA8O
 HQGkMPwdl71sxkb/E8/mVRh+QUK5nHsddP1p5Pv5VNIdffZUrjBblhzuW690XzGgkko35
 ZLR47+Djx84/kUrd/txY+5t/r4Ylz4qTJYhTuXRQjwM/L4H4AjLKV6zVYq+iHYjjhq2Pc
 pMoy08RIMMJIMrjGPekUntqmptPAeWGKiu2D4X+iXxv4B8jseYGrCmhzzU9AgK+bghgKx
 qhG/5/smGCbFhanmHzOOk+g/2Nr6qwZ/61dawmeDWD9IXdRsGQ6dLDv3mfeBsZLLGoQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ubgUsFE4; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ubgUsFE4
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A65E140378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612191F37;
 Thu, 17 Sep 2026 10:19:02 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F4F3F7B4;
 Thu, 17 Sep 2026 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665545; bh=Vi2DlqVb4NbE7dN7GfgUMt8VfdVDQYKcTrZ5icQKwAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ubgUsFE4boq2MQ3mTMUI0yd4PB8bsbtbraS8/KwgIEECyzzd2Ij8144PBY5OdJFpN
 PXeFFHM7LlpEyGUCdv43BWLewXs1m8iO0K2ttX158AntzI2F8Dg9G9N4lH0jafuZrQ
 B7AbvezFyWM+i29hiwOIxOpd7A2WD0YW3vgrdyO0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 16/24] fwu_arm_psa: Add FWU acceptance mechanism
Date: Thu, 17 Sep 2026 18:18:02 +0100
Message-ID: <20260917171810.4122899-17-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Accept the FWU at ExitBootServices()

Provide the FWU_ACCEPT_IMAGE ABI and setup an event triggered
on ExitBootServices().
This mechanism notifies Secure world that the system booted
successfully by accepting the images in trial state.

Also, add FWU_ARM_PSA_ACCEPT_IMAGES config
to allow platforms to switch off image acceptance
in ExitBootServices().

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 include/fwu_arm_psa.h        |  23 ++++-
 lib/efi_loader/Kconfig       |   8 ++
 lib/efi_loader/fwu_arm_psa.c | 171 +++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index 5b82a7b0fb2..1177ccea0db 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -90,9 +90,10 @@ enum fwu_abis {
 	FWU_WRITE_STREAM = 20,
 	FWU_READ_STREAM = 21,
 	FWU_COMMIT = 22,
+	FWU_ACCEPT_IMAGE = 23,
 	/* To be updated when adding new FWU IDs */
 	FWU_FIRST_ID = FWU_DISCOVER, /* Lowest number ID */
-	FWU_LAST_ID = FWU_COMMIT, /* Highest number ID */
+	FWU_LAST_ID = FWU_ACCEPT_IMAGE, /* Highest number ID */
 };
 
 enum fwu_abi_errcode {
@@ -316,6 +317,26 @@ struct fwu_write_stream_resp {
 	int status;
 } __packed;
 
+/**
+ * struct fwu_accept_image_args - fwu_accept_image ABI arguments
+ * @function_id: fwu_accept_image service ID
+ * @reserved: Reserved, must be zero
+ * @image_type_guid: GUID of the image to be accepted
+ */
+struct fwu_accept_image_args {
+	u32 function_id;
+	u32 reserved;
+	efi_guid_t image_type_guid;
+} __packed;
+
+/**
+ * struct fwu_accept_image_resp - fwu_accept_image ABI returns
+ * @status: The ABI return status
+ */
+struct fwu_accept_image_resp {
+	int status;
+} __packed;
+
 /*
  * FWU directory information structures
  */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 50302a03eae..09932a98d6e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -395,6 +395,14 @@ config FWU_KEEP_FMP_HEADER
 	  Select this option if you do not want to strip the FMP header
 	  of the payload
 
+config FWU_ARM_PSA_ACCEPT_IMAGES
+	bool "Accept images at EFI ExitBootServices() level"
+	depends on FWU_ARM_PSA
+	default y
+	help
+	  Select this option if reaching ExitBootServices() level means the boot succeeded
+	  This option will add a callback at ExitBootServices() that accepts all the images.
+
 config FWU_BUFFER_PAGES
 	int "Number of 4KB pages in the FWU shared buffer"
 	depends on FWU_ARM_PSA
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 40e0611adb9..c467922a6d8 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -115,6 +115,14 @@ static struct fwu_abi_errmap err_msg_map[FWU_ERRMAP_COUNT] = {
 			"FWU_DENIED: The system is not in a Staging state",
 		},
 	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_ACCEPT_IMAGE)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Image with type=image_type_guid is not managed by the Update Agent",
+			[FWU_DENIED] =
+			"FWU_DENIED: The system has not booted with the active bank, or the image cannot be accepted before being activated",
+		},
+	},
 };
 
 /**
@@ -712,6 +720,35 @@ static int fwu_write_stream(u32 handle, const u8 *payload, u32 payload_size)
 	return ret;
 }
 
+/**
+ * fwu_accept() -  fwu_accept_image ABI
+ *
+ * @guid: GUID of the image to be accepted
+ *
+ * Description: Sets the status of the firmware image, with a given GUID
+ * to "accepted" in the active firmware bank.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_accept(const efi_guid_t *guid)
+{
+	struct fwu_accept_image_args *args = g_fwu_buf;
+	struct fwu_accept_image_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_ACCEPT_IMAGE";
+
+	if (!guid)
+		return -EINVAL;
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_ACCEPT_IMAGE;
+
+	guidcpy(&args->image_type_guid, guid);
+
+	/* Executing the FWU ABI through the FF-A bus */
+	return fwu_invoke_svc(args->function_id, svc_name,
+			     sizeof(*args), sizeof(*resp), NULL);
+}
+
 /**
  * fwu_update_image() - Update an image
  *
@@ -1079,6 +1116,117 @@ failure:
 	return ret;
 }
 
+/**
+ * fwu_one_image_accepted() - Accept one image in trial state
+ *
+ * @img_type_guid: Pointer to the img_type_guid.
+ * @image_number: Image number for logging purposes.
+ *
+ * Description: Invoke FWU accept image ABI to accept the image.
+ *
+ * Return: true on success, false on failure.
+ */
+static bool fwu_one_image_accepted(const efi_guid_t *img_type_guid,
+				   u32 image_number)
+{
+	int fwu_ret;
+
+	fwu_ret = fwu_accept(img_type_guid);
+	if (fwu_ret) {
+		log_err("FWU: Failed to accept image #%d\n",
+			image_number + 1);
+		return false;
+	}
+
+	log_debug("FWU: Image #%d accepted\n", image_number + 1);
+
+	return true;
+}
+
+/**
+ * fwu_all_images_accepted() - Accept any pending firmware update images
+ *
+ * Description: Read the acceptance state of each image from the cached image
+ * directory. Then, accept the images which are not accepted yet.
+ *
+ * Return: true on success, false on failure.
+ */
+static bool fwu_all_images_accepted(void)
+{
+	u32 i;
+	bool accepted;
+	struct fwu_image_info_entry *entry;
+
+	for (i = 0; i < g_fwu_cached_directory->num_images; i++) {
+		entry = &g_fwu_cached_directory->entries[i];
+		if (entry->accepted)
+			continue;
+
+		accepted = fwu_one_image_accepted(&entry->img_type_guid, i);
+		if (!accepted)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * fwu_accept_notify_exit_boot_services() - ExitBootServices callback
+ *
+ * @event:	callback event
+ * @context:	callback context
+ *
+ * Description: Reaching ExitBootServices() level means the boot succeeded.
+ * So, accept all the images.
+ */
+static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
+							void *context)
+{
+	efi_status_t efi_ret = EFI_SUCCESS;
+	bool all_accepted;
+
+	EFI_ENTRY("%p, %p", event, context);
+
+	if (g_in_trial) {
+		all_accepted = fwu_all_images_accepted();
+		if (!all_accepted) {
+			efi_ret = EFI_ACCESS_DENIED;
+			goto out;
+		}
+
+	} else {
+		log_info("FWU: ExitBootServices: Booting in regular state\n");
+	}
+
+out:
+	EFI_EXIT(efi_ret);
+}
+
+/**
+ * fwu_setup_accept_event() - Setup the FWU accept event
+ *
+ * Description: Create a FWU accept event triggered on ExitBootServices().
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_setup_accept_event(void)
+{
+	efi_status_t efi_ret;
+	struct efi_event *evt = NULL;
+
+	efi_ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
+				   fwu_accept_notify_exit_boot_services, NULL,
+				   &efi_guid_event_group_exit_boot_services,
+				   &evt);
+	if (efi_ret != EFI_SUCCESS) {
+		log_err("FWU: Cannot install accept event %p, err (%lu)\n", evt,
+			efi_ret);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
 /**
  * fwu_agent_init() - Setup the FWU agent
  *
@@ -1092,6 +1240,7 @@ failure:
 int fwu_agent_init(void)
 {
 	int ret;
+	int i;
 
 	ret = uclass_first_device_err(UCLASS_FFA, &g_dev);
 	if (ret) {
@@ -1115,6 +1264,28 @@ int fwu_agent_init(void)
 	if (ret)
 		goto failure;
 
+	/*
+	 * When booting from a bank, each image is expected to be either
+	 * accepted or in a trial state.
+	 */
+	for (i = 0; i < g_fwu_cached_directory->num_images; i++) {
+		if (g_fwu_cached_directory->entries[i].accepted == 0) {
+			g_in_trial = true;
+			break;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES)) {
+		ret = fwu_setup_accept_event();
+		if (ret)
+			goto failure;
+	}
+
+	if (g_in_trial)
+		log_info("FWU: System booting in Trial State\n");
+	else
+		log_info("FWU: System booting in Regular State\n");
+
 	g_fwu_initialized = true;
 
 	return 0;
-- 
2.43.0

