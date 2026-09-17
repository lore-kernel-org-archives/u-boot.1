Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182CAC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D127460BDC;
	Thu, 17 Sep 2026 17:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vaho13Y688DB; Thu, 17 Sep 2026 17:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C0C6F60BD9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665607;
	b=B2EIqUsQ6ohF0Qdjy3idj01WAbfi25ZNv8APYaLeYGFaEhB/x/AKvdpFePOWIj4p7fnd
	 RGxLoRmQthhIjf/UMaurGq43Cw/VmSEOwC8fp489LM5/VQIF1rOt0CjAprE4pdlU+pFxz
	 GbT5PC/FudNbWjW8Hx2AdbgjdZ7sQHSXLn/23da8/zUbaGLfuBfOs7my5DXZGDBBWmER7
	 lIAbiy1MmIitoGWzuRbxpaF1AmW6ijNdaSkQYxYAR5isOSsZKaGmxa20q/tH9qjie04an
	 BsDQNazwBlz4coBKBG+NHbagjFzz7S5PiJC2L0rcccbhJ73HwnouoteEt1i6RzS2oZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=56/fmZmyIUmW2PoB+WBpWMcbmYr/jGBKwFlAhvvBI6Y=;
	b=ejSLEdA4+ziOn9GBkaq7C/6NkFttDyn+TZc8nTCf7G5bcect/qN9ftSDjm9kYaoFAPb/
	 +BF1P6ANFd4+3E3a+G32TwMRN6IY9uepeDWzfCLbpI3QNbBKbHqVquUO96fqiLvirVptY
	 YOjy2JsuxYdDERA3A1aHFXHPjlqnc5G7wjJHuUp9jX/P6cxNXxf6vm23lwlM3z0tiqk8a
	 ZBog/rtVatF/nYcpTtI74Ww0HjqieG7+KR7QPgZ5FCM28rbfj2NQ/10lmbbnzMzbN0sM6
	 ctyo4obpaaeVwUfClIdJcaGVJnFXY78v/cqk9KjNCI32+417PGqd1KoHGqn4KPwUSyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oAhtknt0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665607;
	bh=56/fmZmyIUmW2PoB+WBpWMcbmYr/jGBKwFlAhvvBI6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=doNT0wQfI9MeM1soDQFeGjb3GFqMemet9hmXw3iB3gcQKoiBTPNkL7fnwjlKrPfLI
	 3cF005biiI5ueW0XFabP25CZqrC0YkG61nIORPs0TtQ6qj3UFf1IU+Epja9iYKwkDe
	 kTJJEibUzrJ5IjVque2p4desj363lpFyWf8/VqdNX+dggk1XW/Fmex6ZxAMtgdZBax
	 1ltswiRW3Kyv+weXfNML4QI9eFbN3GrFoHD5D3yH3J1TYPNyC7Nz0LyAp113fGKvdo
	 hrbogH5eAnuuvayfCgT/hURbUeg0z+alea6qDLrCfX20mtiqyTa9S5Udk7prh9b6qt
	 qLl/5lBckNyLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0C6F60BD9;
	Thu, 17 Sep 2026 17:20:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5DA2362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7F8360B64
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnmIAyd8ja9V for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9F8B60B2D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665549;
 b=Fb3jBO8S8USwTheQhxKZld/0PMvuLOdbLE1iiM7Yf8B8kEzQ0kOIG9ENWfXng05VD1An
 /YN4bKjt+ro+7MFu232lD2srjcFst3eePGX3Ia+IzOgrRL/pMiZCW4E7NvFERdOo48vIU
 8B5AMJ0SWVJNsC+XyZVKby/VSVzjXVArh4uVdSLc9aQpWRAvFXlqagVde4IjXl5MwmlNT
 dGNfaO5A5klDkUe7QQ5jyKpxoUf90axwFW2E/aKo3lTF7D2q0GkZkPZSpCEu00I8dya5o
 x9Uca2Meg+xdPo4PY+1m4S8EYy5STaEV2km8yDlCdbqRt1+AHZL8M+UWmJ+Bzi+OVxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665549;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=56/fmZmyIUmW2PoB+WBpWMcbmYr/jGBKwFlAhvvBI6Y=;
 b=d9OxRfhxyn7qkcQa58DB98PffeLhGo8KOwRdKsWIvqp3tAoKZTaudVn/jlyczGmaT9Gd
 Whw0CvPytCOgJFhVZ5gRfUdwY0U5SaaBxES6bgmH3BgcTMAMffRthCWMprfdOb1yhczoQ
 HXxI0De7GzaXN1MxpFh2cKZmxQRMNYuWg3VMuPWhbWqogBrFmWsJmffFYVHyVns3ANuBT
 QH6qNQfsEJ6rLXeBcV27QXbZVlk8FC5bKRjBVgJYpwwy9TsueLsrAJnf2PFWktQkxVVgu
 pTyb0y1oAuzwQfZMWjFbploKgwMuiuSbqniBXvJ7ycoveGuRkyg72frtMAj5DmWjJvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=oAhtknt0; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=oAhtknt0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9F8B60B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5910B143D;
 Thu, 17 Sep 2026 10:19:04 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 450C13F7B4;
 Thu, 17 Sep 2026 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665547; bh=Y1RUkpKCWykWhkUPiUnIveBByhH/75o0YnE8TKp7prA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oAhtknt0y9XCHn+MTgP5i1Br/D7hiO6H9DjTmdFv34ZNaOMwMma7TFxl7WtnLuewU
 39yrtqEdCMzPEpB+cu/WkOZhcCkWnv4wZrCiinAl5LYvbWcsSFuD0e+iqcf6FV+g0g
 ayjtGpCFb7oDC+FnP+nPr+f0Qv15dMGZI+te6ah0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 17/24] fwu_arm_psa: Add ESRT support
Date: Thu, 17 Sep 2026 18:18:03 +0100
Message-ID: <20260917171810.4122899-18-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:36 +0000
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

Read ESRT data from Secure world in GetImageInfo()

Use FWU_READ_STREAM ABI to read ESRT data from Secure world.

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
 include/fwu_arm_psa.h        |  13 ++++
 lib/efi_loader/fwu_arm_psa.c | 118 +++++++++++++++++++++++++++++++----
 2 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index 1177ccea0db..9fb5f87ac6c 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -18,6 +18,9 @@
 
 #define DEFAULT_HW_INSTANCE		(1)
 
+/* The minimum supported ESRT version */
+#define EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION		(1)
+
 /* Default values of the ESRT fields which are not supported at this stage */
 #define PACKAGE_VERSION_NOT_SUP		(0xffffffff)
 #define LAST_ATTEMPT_NOT_SUP		(0)
@@ -361,6 +364,16 @@ struct __packed fwu_image_directory {
 	struct fwu_image_info_entry entries[];
 };
 
+/**
+ * struct fwu_esrt_data_wrapper - Wrapper for the ESRT data
+ * @data: The ESRT data read from secure world
+ * @entries: The ESRT entries
+ */
+struct fwu_esrt_data_wrapper {
+	struct efi_system_resource_table data;
+	struct efi_system_resource_entry entries[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+} __packed;
+
 /**
  * fwu_agent_init() - Setup the FWU agent
  * Perform the initializations required to communicate
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index c467922a6d8..20e4fdf9b90 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -28,6 +28,7 @@ static bool g_fwu_initialized;
 static bool g_in_trial;
 static struct fwu_image_directory *g_fwu_cached_directory;
 efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+struct fwu_esrt_data_wrapper g_esrt_data;
 
 /* Error mapping declarations */
 
@@ -930,6 +931,98 @@ close_handle:
 	return ret;
 }
 
+/**
+ * fwu_esrt_sanity_check() - Verify ESRT data
+ *
+ * Description: Make sure the ESRT data matches the directory data.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_esrt_sanity_check(void)
+{
+	int i;
+
+	log_debug("FWU: ESRT data check ...\n");
+
+	if (g_esrt_data.data.fw_resource_count !=
+	    CONFIG_FWU_NUM_IMAGES_PER_BANK) {
+		log_err("FWU: Unexpected ESRT entries count (%d , %d)\n",
+			g_esrt_data.data.fw_resource_count,
+			CONFIG_FWU_NUM_IMAGES_PER_BANK);
+		return -EINVAL;
+	}
+
+	if (g_esrt_data.data.fw_resource_version <
+		EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION) {
+		log_err("FWU: Secure world ESRT version %llu not supported\n",
+			g_esrt_data.data.fw_resource_version);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < g_fwu_cached_directory->num_images; i++) {
+		if (guidcmp(&g_fwu_cached_directory->entries[i].img_type_guid,
+			    &g_esrt_data.data.entries[i].fw_class)) {
+			log_err("FWU: GUID mismatch for image %d\n", i + 1);
+			return -EINVAL;
+		}
+	}
+
+	log_debug("FWU: ESRT data check passed\n");
+
+	return 0;
+}
+
+/**
+ * fwu_read_esrt() - Read the ESRT data
+ *
+ * Description: Read the ESRT data from the Secure world.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_read_esrt(void)
+{
+	int ret, close_ret;
+	u32 handle = 0;
+	efi_guid_t esrt_guid = EFI_SYSTEM_RESOURCE_TABLE_GUID;
+	u32 esrt_data_size;
+	void *g_esrt_data_buf;
+
+	ret = fwu_open(&esrt_guid, FWU_OP_TYPE_READ, &handle);
+	if (ret) {
+		log_err("FWU: Open ESRT image failed (err: %d)\n",
+			ret);
+		return ret;
+	}
+
+	log_debug("FWU: ESRT image handle (0x%x)\n", handle);
+
+	esrt_data_size = sizeof(g_esrt_data);
+	g_esrt_data_buf = &g_esrt_data;
+
+	ret = fwu_read_stream(handle, (void **)&g_esrt_data_buf, &esrt_data_size);
+	if (ret) {
+		log_err("FWU: Read ESRT image failed (err: %d)\n",
+			ret);
+		goto close_handle;
+	}
+
+	ret = fwu_esrt_sanity_check();
+	if (ret)
+		goto close_handle;
+
+	log_debug("FWU: ESRT version supported by Secure world (%llu)\n",
+		  g_esrt_data.data.fw_resource_version);
+
+close_handle:
+	/* The Update Agent can execute for an unbounded time */
+	close_ret = fwu_commit(handle, FWU_IMG_NOT_ACCEPTED, 0);
+	if (close_ret)
+		log_err("FWU: Close ESRT image handle failed (err: %d)\n",
+			close_ret);
+
+	return ret;
+}
+
 /**
  * fwu_discover_ts_sp_id() - Query the FWU partition ID
  *
@@ -1193,7 +1286,6 @@ static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
 			efi_ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
-
 	} else {
 		log_info("FWU: ExitBootServices: Booting in regular state\n");
 	}
@@ -1336,8 +1428,12 @@ efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
 		}
 	}
 
-	required_image_info_size = g_fwu_cached_directory->num_images *
-		image_info_desc_size;
+	ret = fwu_read_esrt();
+	if (ret)
+		return EFI_NOT_READY;
+
+	required_image_info_size =
+		g_fwu_cached_directory->num_images * image_info_desc_size;
 
 	if (*image_info_size < required_image_info_size) {
 		*image_info_size = required_image_info_size;
@@ -1355,15 +1451,13 @@ efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
 		image_info[i].image_index = i + 1;
 
 		/* Corresponding ESRT field: FwClass */
-		guidcpy(&image_info[i].image_type_id,
-			&g_fwu_cached_directory->entries[i].img_type_guid);
+		guidcpy(&image_info[i].image_type_id, &g_esrt_data.entries[i].fw_class);
 
 		image_info[i].image_id = image_info[i].image_index;
 		image_info[i].image_id_name = NULL; /* Not supported */
 
 		/* Corresponding ESRT field: FwVersion */
-		image_info[i].version =
-			g_fwu_cached_directory->entries[i].img_version;
+		image_info[i].version = g_esrt_data.entries[i].fw_version;
 
 		image_info[i].version_name = NULL; /* Not supported */
 		image_info[i].size =
@@ -1382,13 +1476,13 @@ efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
 
 		/* Corresponding ESRT field: LowestSupportedFwVersion */
 		image_info[i].lowest_supported_image_version =
-			g_fwu_cached_directory->entries[i].lowest_acceptable_version;
+			g_esrt_data.entries[i].lowest_supported_fw_version;
 
-		/* Corresponding ESRT field: LastAttemptVersion (not supported) */
-		image_info[i].last_attempt_version = LAST_ATTEMPT_NOT_SUP;
+		/* Corresponding ESRT field: LastAttemptVersion */
+		image_info[i].last_attempt_version = g_esrt_data.entries[i].last_attempt_version;
 
-		/* Corresponding ESRT field: LastAttemptStatus (not supported) */
-		image_info[i].last_attempt_status = LAST_ATTEMPT_NOT_SUP;
+		/* Corresponding ESRT field: LastAttemptStatus */
+		image_info[i].last_attempt_status = g_esrt_data.entries[i].last_attempt_status;
 
 		image_info[i].hardware_instance = DEFAULT_HW_INSTANCE;
 		image_info[i].dependencies = NULL; /* Not supported */
-- 
2.43.0

