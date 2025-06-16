Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C55C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 10:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B14682063;
	Mon, 16 Jun 2025 12:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBC38210D; Mon, 16 Jun 2025 12:24:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D03D081760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 12:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8886A150C;
 Mon, 16 Jun 2025 03:23:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D506D3F58B;
 Mon, 16 Jun 2025 03:23:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] cmd: eficonfig: add support for URI device path based boot
 options
Date: Mon, 16 Jun 2025 15:53:38 +0530
Message-Id: <20250616102338.1269541-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The eficonfig command provides a menu based interface for maintenance
of the EFI boot options. Add support for adding a URI based boot
option. This boot option can then be used for HTTP boot.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note: I had explored adding a corresponding test for this change. But
looks like the eficonfig command itself is not being tested since
commit 952018117ab4 ("dm: sandbox: Switch over to using the new host
uclass"). This needs to be taken up separately as to why the eficonfig
test has been bypassed, before adding stuff to the test.


 cmd/eficonfig.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 6e14d34a6bd..f69902b76f7 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -35,6 +35,7 @@ static int avail_row;
 
 #define EFICONFIG_DESCRIPTION_MAX 32
 #define EFICONFIG_OPTIONAL_DATA_MAX 64
+#define EFICONFIG_URI_MAX 512
 #define EFICONFIG_MENU_HEADER_ROW_NUM 3
 #define EFICONFIG_MENU_DESC_ROW_NUM 5
 
@@ -57,6 +58,7 @@ struct eficonfig_filepath_info {
  * @boot_index:		index of the boot option
  * @description:	pointer to the description string
  * @optional_data:	pointer to the optional_data
+ * @uri:		URI for HTTP Boot
  * @edit_completed:	flag indicates edit complete
  */
 struct eficonfig_boot_option {
@@ -66,6 +68,7 @@ struct eficonfig_boot_option {
 	unsigned int boot_index;
 	u16 *description;
 	u16 *optional_data;
+	u16 *uri;
 	bool edit_completed;
 };
 
@@ -538,6 +541,31 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	return dp;
 }
 
+static struct efi_device_path *eficonfig_create_uri_device_path(u16 *uri_str)
+{
+	char *pos, *p;
+	u32 len = 0;
+	efi_uintn_t uridp_len;
+	struct efi_device_path_uri *uridp;
+
+	len = utf16_utf8_strlen(uri_str);
+
+	uridp_len = sizeof(struct efi_device_path) + len + 1;
+	uridp = efi_alloc(uridp_len + sizeof(EFI_DP_END));
+	if (!uridp)
+		return NULL;
+
+	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+	uridp->dp.length = uridp_len;
+	p = (char *)&uridp->uri;
+	utf16_utf8_strcpy(&p, uri_str);
+	pos = (char *)uridp + uridp_len;
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
+
+	return &uridp->dp;
+}
+
 /**
  * eficonfig_file_selected() - handler of file selection
  *
@@ -983,6 +1011,22 @@ static efi_status_t eficonfig_boot_add_optional_data(void *data)
 				 "  enter optional data:");
 }
 
+/**
+ * eficonfig_boot_add_uri() - handle user input for HTTP Boot URI
+ *
+ * @data:	pointer to the internal boot option structure
+ * Return:	status code
+ */
+static efi_status_t eficonfig_boot_add_uri(void *data)
+{
+	struct eficonfig_boot_option *bo = data;
+
+	return handle_user_input(bo->uri, EFICONFIG_URI_MAX, 24,
+				 "\n  ** Edit URI **\n"
+				 "\n"
+				 "  enter HTTP Boot URI:");
+}
+
 /**
  * eficonfig_boot_edit_save() - handler to save the boot option
  *
@@ -998,7 +1042,8 @@ static efi_status_t eficonfig_boot_edit_save(void *data)
 		bo->edit_completed = false;
 		return EFI_NOT_READY;
 	}
-	if (u16_strlen(bo->file_info.current_path) == 0) {
+	if (u16_strlen(bo->file_info.current_path) == 0 &&
+	    u16_strlen(bo->uri) == 0) {
 		eficonfig_print_msg("File is not selected!");
 		bo->edit_completed = false;
 		return EFI_NOT_READY;
@@ -1318,6 +1363,11 @@ static efi_status_t eficonfig_show_boot_option(struct eficonfig_boot_option *bo,
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	ret = create_boot_option_entry(efi_menu, "Uri: ", bo->uri,
+				       eficonfig_boot_add_uri, bo);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	ret = create_boot_option_entry(efi_menu, "Save", NULL,
 				       eficonfig_boot_edit_save, bo);
 	if (ret != EFI_SUCCESS)
@@ -1340,6 +1390,22 @@ out:
 	return ret;
 }
 
+static bool eficonfig_fp_uri(struct efi_device_path *dp)
+{
+	return dp->type == DEVICE_PATH_TYPE_MESSAGING_DEVICE &&
+		dp->sub_type == DEVICE_PATH_SUB_TYPE_MSG_URI;
+}
+
+static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
+{
+	u16 *p = *uri_str;
+	struct efi_device_path_uri *uridp;
+
+	uridp = (struct efi_device_path_uri *)dp;
+
+	utf8_utf16_strcpy(&p, uridp->uri);
+}
+
 /**
  * fill_file_info() - fill the file info from efi_device_path structure
  *
@@ -1392,10 +1458,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	size_t len;
 	efi_status_t ret;
 	char *tmp = NULL, *p;
+	u16 *current_path = NULL;
 	struct efi_load_option lo = {0};
 	efi_uintn_t dp_size;
 	struct efi_device_path *dp = NULL;
 	efi_uintn_t size = load_option_size;
+	struct efi_device_path *dp_volume = NULL;
+	struct efi_device_path *uri_dp = NULL;
 	struct efi_device_path *device_dp = NULL;
 	struct efi_device_path *initrd_dp = NULL;
 	struct efi_device_path *fdt_dp = NULL;
@@ -1464,6 +1533,12 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		goto out;
 	}
 
+	bo->uri = calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
+	if (!bo->uri) {
+		ret =  EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
 	/* copy the preset value */
 	if (load_option) {
 		ret = efi_deserialize_load_option(&lo, load_option, &size);
@@ -1481,7 +1556,9 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		u16_strcpy(bo->description, lo.label);
 
 		/* EFI image file path is a first instance */
-		if (lo.file_path)
+		if (lo.file_path && eficonfig_fp_uri(lo.file_path))
+			fill_dp_uri(lo.file_path, &bo->uri);
+		else
 			fill_file_info(lo.file_path, &bo->file_info, device_dp);
 
 		/* Initrd file path (optional) is placed at second instance. */
@@ -1512,6 +1589,9 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			goto out;
 	}
 
+	if (utf16_utf8_strlen(bo->uri))
+		uri_dp = eficonfig_create_uri_device_path(bo->uri);
+
 	if (bo->initrd_info.dp_volume) {
 		dp = eficonfig_create_device_path(bo->initrd_info.dp_volume,
 						 bo->initrd_info.current_path);
@@ -1536,7 +1616,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		efi_free_pool(dp);
 	}
 
-	dp = eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_info.current_path);
+	dp_volume = bo->file_info.dp_volume;
+	current_path = bo->file_info.current_path;
+	dp = uri_dp ?
+		uri_dp : eficonfig_create_device_path(dp_volume, current_path);
 	if (!dp) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out;
@@ -1558,6 +1641,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	ret = eficonfig_set_boot_option(varname, dp, dp_size, bo->description, tmp);
 out:
 	free(tmp);
+	free(bo->uri);
 	free(bo->optional_data);
 	free(bo->description);
 	free(bo->file_info.current_path);
-- 
2.34.1

