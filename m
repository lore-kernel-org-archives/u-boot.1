Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A731CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32EA86E57;
	Tue, 12 Sep 2023 11:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iE6hCH5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4555386E4C; Tue, 12 Sep 2023 11:47:36 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4ACB286E23
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 842B2212BC16;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 842B2212BC16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=nI5jt60EPtXsXSWFazBSe9CIIfSGCDfMxCLIv6gRouA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iE6hCH5b0pMjxbhpg/mFOWSpe6/K23LFyzElPJlmcuHOqutPbyIlAwGuIdzF2j2hS
 Bb7wJHji/LkM1WiMyV8szsYCd3R12Gicd3+CmSFD+M7PaSMvcPXvSD4TfJR1kvdAR7
 xtPc8rzSztgp5SwaFGc0hhOwL45DTHE5exN9mf3Y=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 3/8] common: Add OS anti-rollback validation using rollback
 devices
Date: Tue, 12 Sep 2023 02:47:26 -0700
Message-Id: <20230912094731.51413-4-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Stephen Carlson <stcarlso@linux.microsoft.com>

New config CONFIG_ROLLBACK_CHECK to enable enforcement of OS anti-rollback
counter during image loading.

Images with an anti-rollback counter value "rollback" declared in the FDT
will be compared against the current device anti-rollback counter value,
and older images will not pass signature validation. If the image is
newer, the device anti-rollback counter value will be updated.

Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 boot/Kconfig         |  9 +++++
 boot/image-fit-sig.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 boot/image-fit.c     | 31 +++++++++++++++
 include/image.h      |  6 ++-
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e8fb03b801..9180a1c8dc 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -103,6 +103,15 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config FIT_ROLLBACK_CHECK
+	bool "Enable Anti rollback version check for FIT images"
+	depends on FIT_SIGNATURE
+	default n
+	help
+	  Enables FIT image anti-rollback protection. This feature is required
+	  when a platform needs to retire previous versions of FIT images due to
+	  security flaws and prevent devices from being reverted to them.
+
 config FIT_VERBOSE
 	bool "Show verbose messages when FIT images fail"
 	depends on FIT
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 12369896fe..91eaf4baa8 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -11,6 +11,8 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <dm.h>
+#include <rollback.h>
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 #include <fdt_region.h>
@@ -63,6 +65,44 @@ struct image_region *fit_region_make_list(const void *fit,
 	return region;
 }
 
+static int fit_image_verify_rollback(const void *fit, int image_noffset)
+{
+#if !defined(USE_HOSTCC)
+	u64 image_rollback;
+	u64 plat_rollback = 0ULL;
+	struct udevice *dev;
+	int ret;
+
+	ret = fit_image_get_rollback(fit, image_noffset, &image_rollback);
+
+	/* If the FIT doesn't contain the rollback property, assume an
+	 * anti-rollback version number of 0.  This ensures failure
+	 * if the platform anti-rollback version number is non-zero
+	 */
+	if (ret)
+		image_rollback = 0;
+
+	ret = uclass_first_device_err(UCLASS_ROLLBACK, &dev);
+	if (ret)
+		return ret;
+
+	ret = rollback_idx_get(dev, &plat_rollback);
+	if (ret)
+		return -EIO;
+
+	if (image_rollback < plat_rollback) {
+		return -EPERM;
+	} else if (image_rollback > plat_rollback) {
+		ret = rollback_idx_set(dev, image_rollback);
+		printf(" Updating OS anti-rollback to %llu from %llu\n",
+		       image_rollback, plat_rollback);
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
 static int fit_image_setup_verify(struct image_sign_info *info,
 				  const void *fit, int noffset,
 				  const void *key_blob, int required_keynode,
@@ -175,6 +215,16 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
 		goto error;
 	}
 
+	if (!tools_build()) {
+		if (FIT_IMAGE_ENABLE_ROLLBACK_CHECK && verified) {
+			ret = fit_image_verify_rollback(fit, image_noffset);
+			if (ret) {
+				err_msg = "Anti-rollback verification failed";
+				goto error;
+			}
+		}
+	}
+
 	return verified ? 0 : -EPERM;
 
 error:
@@ -385,6 +435,38 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 	return 0;
 }
 
+static int fit_config_verify_rollback(const void *fit, int conf_noffset,
+				      int sig_offset)
+{
+	static const char default_list[] = FIT_KERNEL_PROP "\0"
+			FIT_FDT_PROP;
+	int ret, len;
+	const char *prop, *iname, *end;
+	int image_noffset;
+
+	/* If there is "sign-images" property, use that */
+	prop = fdt_getprop(fit, sig_offset, "sign-images", &len);
+	if (!prop) {
+		prop = default_list;
+		len = sizeof(default_list);
+	}
+
+	/* Locate the images */
+	end = prop + len;
+	for (iname = prop; iname < end; iname += strlen(iname) + 1) {
+		image_noffset = fit_conf_get_prop_node(fit, conf_noffset,
+						       iname, IH_PHASE_NONE);
+		if (image_noffset < 0)
+			return -ENOENT;
+
+		ret = fit_image_verify_rollback(fit, image_noffset);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * fit_config_verify_key() - Verify that a configuration is signed with a key
  *
@@ -444,6 +526,16 @@ static int fit_config_verify_key(const void *fit, int conf_noffset,
 		goto error;
 	}
 
+	if (!tools_build()) {
+		if (FIT_IMAGE_ENABLE_ROLLBACK_CHECK && verified) {
+			ret = fit_config_verify_rollback(fit, conf_noffset, noffset);
+			if (ret) {
+				err_msg = "Anti-rollback verification failed";
+				goto error;
+			}
+		}
+	}
+
 	if (verified)
 		return 0;
 
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3cc556b727..510cb51cd5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1084,6 +1084,37 @@ int fit_image_get_data_and_size(const void *fit, int noffset,
 	return ret;
 }
 
+/**
+ * fit_image_get_rollback - get anti-rollback counter
+ * @fit: pointer to the FIT image header
+ * @noffset: component image node offset
+ * @rollback: holds the rollback property value
+ *
+ * returns:
+ *     0, on success
+ *     -ENOENT if the property could not be found
+ */
+int fit_image_get_rollback(const void *fit, int noffset, uint64_t *rollback)
+{
+	const fdt64_t *val;
+	int len;
+
+	val = fdt_getprop(fit, noffset, FIT_ROLLBACK_PROP, &len);
+
+	if (!val) {
+		printf("error! Can't find property %s in FIT\n", FIT_ROLLBACK_PROP);
+		return -ENOENT;
+	}
+	if (len != sizeof(uint64_t)) {
+		printf("Property %s must be 64-bits\n", FIT_ROLLBACK_PROP);
+		return -ENOENT;
+	}
+
+	*rollback = fdt64_to_cpu(*val);
+
+	return 0;
+}
+
 /**
  * fit_image_hash_get_algo - get hash algorithm name
  * @fit: pointer to the FIT format image header
diff --git a/include/image.h b/include/image.h
index 01a6787d21..3283cd7717 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1024,6 +1024,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_COMP_PROP		"compression"
 #define FIT_ENTRY_PROP		"entry"
 #define FIT_LOAD_PROP		"load"
+#define FIT_ROLLBACK_PROP	"rollback"
 
 /* configuration node */
 #define FIT_KERNEL_PROP		"kernel"
@@ -1105,6 +1106,7 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size);
 int fit_image_get_data_and_size(const void *fit, int noffset,
 				const void **data, size_t *size);
+int fit_image_get_rollback(const void *fit, int noffset, uint64_t *rollback_idx);
 
 /**
  * fit_get_data_node() - Get verified image data for an image
@@ -1389,6 +1391,7 @@ int calculate_hash(const void *data, int data_len, const char *algo,
  * device
  */
 #if defined(USE_HOSTCC)
+# define FIT_IMAGE_ENABLE_ROLLBACK_CHECK	0
 # if defined(CONFIG_FIT_SIGNATURE)
 #  define IMAGE_ENABLE_SIGN	1
 #  define FIT_IMAGE_ENABLE_VERIFY	1
@@ -1399,7 +1402,8 @@ int calculate_hash(const void *data, int data_len, const char *algo,
 # endif
 #else
 # define IMAGE_ENABLE_SIGN	0
-# define FIT_IMAGE_ENABLE_VERIFY	CONFIG_IS_ENABLED(FIT_SIGNATURE)
+# define FIT_IMAGE_ENABLE_VERIFY		CONFIG_IS_ENABLED(FIT_SIGNATURE)
+# define FIT_IMAGE_ENABLE_ROLLBACK_CHECK	CONFIG_IS_ENABLED(FIT_ROLLBACK_CHECK)
 #endif
 
 #ifdef USE_HOSTCC
-- 
2.40.0

