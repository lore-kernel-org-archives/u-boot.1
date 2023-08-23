Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D690DEE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6AE864CA;
	Wed, 23 Aug 2023 10:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sf/Lp6KS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A304864C8; Wed, 23 Aug 2023 10:38:35 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E84864CA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a40d8557eso2222306b3a.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692779911; x=1693384711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXso1edERymhBFfXr1gjPdjcU4abvx9CRP772g7aCWo=;
 b=sf/Lp6KSlI5XUsSLO2pG8TjEXCctdwMxF3fgHw1erTBzjiXAqF67U8KPrhrZLCFM87
 hQeSswPjLpEcxgOxllFuacgWfMQPyHy8BKx0AgmS098vEE5gZpXVROynAL3vL7or3WNz
 BM3QU+tc5TyzTcAI/S+emgp5oofyu7szHHEzo7dvhumhAmDKiR6qB8h0M94BCdBzdWaR
 Vr78EqZhmXIIT8byY7FVJ2fZMIf0ghwHDso1FLcEji39OsczgrUp77NkEidlVfvwxDI9
 GN84Ul1vHap9uiI4+Yr+TBy6SMTCLqiNzqzgr82GNy9KqYQbzaQpPMi5sx+cUttB4ZAP
 LXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779911; x=1693384711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXso1edERymhBFfXr1gjPdjcU4abvx9CRP772g7aCWo=;
 b=eaTFBLKz8S+vPszsjXWaM0bkPC1Ci77Ob/Uy2Kmy7D/AMBeMWSGYTm6KPPlC4cRI5y
 f1B2GfaP06F1iyXvaKNjxKHOaxdeloL4zkJYZxBS13CRjICH1GnPEok6pJgGd0t+3Tn7
 n2S5QkMaIdInUi5Eu/rleZAS5Zvokp5kboOT+Y/jkvD/snkc174fJoeKd0ThjKBV6ya7
 RZa46AUosNObhmpi2kmta5MMpAAj4TT6ol6l0Un9pK4s6SmrsMkAumr2SEdFlPcnXSL+
 qLHO3X0Hl8AXaqw/rEkCC928U2UmF3fMDuWAo2he/ICZIUWWqwPBq6h/7zIfGoTONvbP
 OxgQ==
X-Gm-Message-State: AOJu0Yxgz6FxhMT0U0weYEOog2mdd8SQTJLzMG11szBc2mHnVD0R9Wk7
 a/Z0jRTqGQyuC/rPxYz3c26p50ycFWCNasowBm0=
X-Google-Smtp-Source: AGHT+IHCvK3Jvchx426nsyWkVMCCXsohjywCelHrjH8T5kggeblXk/iDLWPqHTedAfL6sdr2U1iTnA==
X-Received: by 2002:a05:6a00:23d5:b0:687:9909:3c78 with SMTP id
 g21-20020a056a0023d500b0068799093c78mr15747854pfc.0.1692779910929; 
 Wed, 23 Aug 2023 01:38:30 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x17-20020aa79191000000b006871fdde2c7sm8936369pfa.110.2023.08.23.01.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:38:30 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 2/2] efi_loader: support boot from URI device path
Date: Wed, 23 Aug 2023 17:37:20 +0900
Message-Id: <20230823083721.1318097-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This supports to boot from the URI device path.
When user selects the URI device path, bootmgr downloads
the file using wget into the address specified by loadaddr
env variable.
If the file is .iso or .img file, mount the image with blkmap
then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
If the file is .efi file, load and start the downloaded file.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 213 +++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..8b20f486f2 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -7,10 +7,14 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blk.h>
+#include <blkmap.h>
 #include <common.h>
 #include <charset.h>
+#include <dm.h>
 #include <log.h>
 #include <malloc.h>
+#include <net.h>
 #include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -168,6 +172,209 @@ out:
 	return ret;
 }
 
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+/**
+ * mount_image() - mount the image
+ *
+ * @lo_label	label of load option
+ * @file_size	file size
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t mount_image(u16 *lo_label, int file_size,
+				efi_handle_t *handle)
+{
+	int err;
+	efi_status_t ret;
+	char *label = NULL, *p;
+	lbaint_t blknum;
+	struct udevice *bm_dev;
+	efi_handle_t bm_handle;
+	struct udevice *blk, *partition;
+	struct efi_handler *handler;
+	struct efi_device_path *file_path;
+	struct efi_device_path *device_path;
+
+	label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
+	if (!label)
+		return EFI_OUT_OF_RESOURCES;
+
+	p = label;
+	utf16_utf8_strcpy(&p, lo_label);
+	err = blkmap_create(label, NULL);
+	if (err) {
+		log_err("failed to create blkmap\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	bm_dev = blkmap_from_label(label);
+	if (!bm_dev) {
+		log_err("\"%s\" is not the name of any known blkmap\n", label);
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	blknum = file_size / 512; /* TODO: don't use literal value. */
+	err = blkmap_map_pmem(bm_dev, 0, blknum, image_load_addr);
+	if (err) {
+		log_err("Unable to map %#llx at block %d : %d\n",
+			(unsigned long long)image_load_addr, 0, err);
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
+		 (unsigned long long)image_load_addr);
+
+	/* TODO: without calling this, partition devices are not binded. */
+	blk_list_part(UCLASS_BLKMAP);
+
+	/*
+	 * Search the partition having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
+	 * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
+	 */
+	device_foreach_child(blk, bm_dev)
+	{
+		device_foreach_child(partition, blk)
+		{
+			if (dev_tag_get_ptr(partition, DM_TAG_EFI,
+					    (void **)&bm_handle)) {
+				log_warning("DM_TAG_EFI not found\n");
+				continue;
+			}
+
+			ret = efi_search_protocol(
+				bm_handle,
+				&efi_simple_file_system_protocol_guid,
+				&handler);
+			if (ret != EFI_SUCCESS)
+				continue;
+
+			ret = efi_search_protocol(
+				bm_handle, &efi_guid_device_path, &handler);
+			if (ret != EFI_SUCCESS)
+				continue;
+
+			ret = efi_protocol_open(handler, (void **)&device_path,
+						efi_root, NULL,
+						EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+			if (ret != EFI_SUCCESS)
+				continue;
+
+			file_path = expand_media_path(device_path);
+			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
+						      NULL, 0, handle));
+			efi_free_pool(file_path);
+			if (ret == EFI_SUCCESS)
+				goto out;
+		}
+	}
+
+out:
+	efi_free_pool(label);
+
+	return ret;
+}
+
+/**
+ * try_load_from_uri_path() - Handle the URI device path
+ *
+ * @uridp:	uri device path
+ * @lo_label	label of load option
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
+					   u16 *lo_label,
+					   efi_handle_t *handle)
+{
+	efi_status_t ret;
+	int file_size, file_name_len;
+	char *s, *host_name, *file_name, *str_copy;
+
+	/*
+	 * Download file using wget.
+	 *
+	 * URI device path content is like http://www.example.com/sample/test.iso.
+	 * U-Boot wget takes the target uri in this format.
+	 *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
+	 * Need to resolve the http server ip address before starting wget.
+	 */
+
+	/* only support "http://" */
+	if (strncmp(uridp->uri, "http://", 7)) {
+		log_err("Error: uri must start with http://\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	str_copy = strdup(uridp->uri);
+	if (!str_copy)
+		return EFI_OUT_OF_RESOURCES;
+	s = str_copy + strlen("http://");
+	host_name = strsep(&s, "/");
+	if (!s) {
+		log_err("Error: invalied uri, no file path\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	file_name = s;
+	net_dns_resolve = host_name;
+	net_dns_env_var = "httpserverip";
+	if (net_loop(DNS) < 0) {
+		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	s = env_get("httpserverip");
+	if (!s) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/*
+	 * WGET requires that "net_boot_file_name" and "image_load_addr" global
+	 * variables are properly set in advance.
+	 */
+	strlcpy(net_boot_file_name, s, 1024);
+	strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
+	strlcat(net_boot_file_name, file_name, 1024);
+	s = env_get("loadaddr");
+	if (!s) {
+		log_err("Error: loadaddr is not set\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	image_load_addr = hextoul(s, NULL);
+
+	file_size = net_loop(WGET);
+	if (file_size < 0) {
+		log_err("Error: downloading file failed\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/*
+	 * Identify file type by file extension.
+	 * If the file extension is ".iso" or ".img", mount it and boot with default file.
+	 * If the file is ".efi", load and start the downloaded file.
+	 */
+	file_name_len = strlen(net_boot_file_name);
+	if (!strncmp(&net_boot_file_name[file_name_len - 4], ".iso", 4) ||
+	    !strncmp(&net_boot_file_name[file_name_len - 4], ".img", 4)) {
+		ret = mount_image(lo_label, file_size, handle);
+	} else if (!strncmp(&net_boot_file_name[file_name_len - 4], ".efi", 4)) {
+		ret = efi_run_image((void *)image_load_addr, file_size);
+	} else {
+		log_err("Error: file type is not supported\n");
+		ret = EFI_INVALID_PARAMETER;
+	}
+
+out:
+	free(str_copy);
+
+	return ret;
+}
+#endif
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +418,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			ret = try_load_from_uri_path(
+				(struct efi_device_path_uri *)lo.file_path,
+				lo.label, handle);
+#endif
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
-- 
2.34.1

