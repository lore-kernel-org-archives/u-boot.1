Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BB1E8536F
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 14:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E95C83642;
	Fri,  3 Apr 2026 16:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZR6eurf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8D383642; Fri,  3 Apr 2026 16:28:43 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC851800AE
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 16:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d23305225so1422439f8f.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775226520; x=1775831320; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LJLHq7UfGWVfNp2yiXg+NEq0ZJqVdoCSXBUylA3Pz34=;
 b=JZR6eurfJQC+5IF3qnr+m7pWR9XcH4OkecQ/VNmfGpwFpAzMSA9qHiryaTSB2PsgPR
 MAqCaPC2g9UAvXn+IkFCUoCuq1NVY9VXkVSVmVLd7Ow1pdVkyiLT4s+pjobYlesqZgV0
 EmpTl1bLSKVmkw4MBPp8OtgAUc5RYeCCW+yxM/ERymv8yRpaL1cYjYoltasmtV/34myT
 Hgc7ZQqXYm4eB2KIR2Sbml14JoMsjNqxAheZTQaxESRP1SpKjwxcFI5p1/1nGF2FGO0l
 n1U5PnvTWpUgIyNo5Q0y4Cxfg+IVKX7MNC956j8EH0zAT2ny6S2LbZPeHZ8+v1xCLBIX
 mkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775226520; x=1775831320;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJLHq7UfGWVfNp2yiXg+NEq0ZJqVdoCSXBUylA3Pz34=;
 b=Yr+5YcYgMGK3l53a7DXHnSLuyeoYIpsnMWiknsv8pB8pqCuGN9QWtoUOT3dELgvLjI
 6ZcQhh/MOVJEdOdDVD6lAkcUg/0dkl7HfV5U6/0Y1Zn6YLaglmrRrlz78Sorkqq0nMW3
 VRtfYDoNrtE860bQ1fKjxxwsNY5tyxVI3GZ5/YkQN0EHgIwMOfsO89k+JleAaMDMj7m0
 UFYDgZftRNQSL+DQomMpRW3UCXJmY9bjBpfunmGRwR44JJ2ACxiPG97aJjk91htvRn9v
 T7LxzZpt6w1z6jJTUDMuM0PocMVL+jl8zVeHwz27LHIHapSORRuFZlW4AA0Z8t06su9H
 X6hw==
X-Gm-Message-State: AOJu0YwTKMsezJYSY5DaxS7ocbkq47/oNKs9dwy9KCrUTHFnVqLVJBAo
 wj8MEHfr2I7JU5mOPYkA9VUjCUHfWQQ2ei8984cE5cKwl9EMUZOb2KMy
X-Gm-Gg: AeBDiethdFLLbWfj0biRpHsYn+kpQFsipLr3m9Ak1H9fPsgTqU8POFrubLy45t9VH69
 rjD+agJOeU4fVGSLd1noArAfItDCK5sSvbCtCU4bg+9BT5JwaSEkYWwH9hBJY1Bjzjq5PQkNuwK
 C/Iq147fFkpr3+1u39EMlga/r/Q3mPiMPgfWVmLlR938GIcMbG1NReTr7XTZO3KiDICzyD0/Eyz
 IQQCOP9VyIFyriKxIFGkSZnJvA3iux2vIUx+kovYwC9Z1Rnh37x6M5K9BvmanaEZVPIfIldCyYY
 q16JfqRaU5sW9RulDonzxWDJsndCTiFzfSRXhsoQ/xbd2FIBJa9RmkMB3lI9VQo45iIP5Wy3QFi
 /kq2QBjvJw+EIAWAIvrdTanI3NGoIHuAqoUKyI2g017Yrtk/j2WaoG8j0lcai938Zp6VxwD7mcF
 g0cUD/IS86H8Nqiz5aDUeF+aQ2fzYJOfZH3dbma6EotQtwfyGRZUXUUuIb9GS91+nXeS+5Ai4Wo
 cT3/kAdqlvy4g==
X-Received: by 2002:a05:6000:1869:b0:43c:f95c:3e70 with SMTP id
 ffacd0b85a97d-43d292c76e3mr5356376f8f.25.1775226519627; 
 Fri, 03 Apr 2026 07:28:39 -0700 (PDT)
Received: from [192.168.0.79]
 (laubervilliers-659-1-61-87.w80-13.abo.wanadoo.fr. [80.13.212.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f1esm16960266f8f.2.2026.04.03.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:28:38 -0700 (PDT)
From: Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Google-Original-From: Guillaume Ranquet <granquet@missingno.tech>
Date: Fri, 03 Apr 2026 16:28:23 +0200
Subject: [PATCH v2] arch/x86/lib: implement cmdline configuration property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMQQ6DIBCF4auYWZcGCCh21Xs0LiiOOkkFA4a0M
 dy91G2X38vLf0DCSJjg1hwQMVOi4CvkpQG3WD8jo7EaJJctV1wwt44v8sjss9fKKjRGGqjvLeJ
 E77P0GKoXSnuInzOcxW/9b2TBKnSru24ysm/5faWUyM8+XHd0CwyllC/jjK8kowAAAA==
X-Change-ID: 20260401-cmdline-ab954a4e8828
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Guillaume Ranquet <granquet@missingno.tech>
X-Mailer: b4 0.14.2
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

Implement the cmdline configuration property as described in the spec
[1]

[1]: https://fitspec.osfw.foundation/#id10

Signed-off-by: Guillaume Ranquet <granquet@missingno.tech>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260401-cmdline-v1-1-c56577f82960@missingno.tech
---
 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/bootm.c          | 10 +++++++++-
 arch/x86/lib/zimage.c         |  6 +++---
 boot/image-fit.c              | 30 +++++++++++++++++++++++++++++-
 include/image.h               |  3 +++
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 8b5426051701c8266395afd9232eb1ff30d38304..ee0114a227a2b067a3a3126d7d80ab0cc89cea6e 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -132,7 +132,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
  * Return: 0 (always)
  */
 int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
+		 ulong initrd_addr, ulong initrd_size, const char *cmdline_force);
 
 /**
  * zboot_start() - Prepare to boot a zimage
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index cde4fbf35574a267b856a668659ece7e0a36367f..e029cc1ff18bd53eb873c0e56fd9d3b0a331b4c2 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -61,6 +61,7 @@ int arch_fixup_memory_node(void *blob)
 static int boot_prep_linux(struct bootm_headers *images)
 {
 	char *cmd_line_dest = NULL;
+	const char *cmd_line_override = NULL;
 	struct legacy_img_hdr *hdr;
 	int is_zimage = 0;
 	void *data = NULL;
@@ -99,6 +100,13 @@ static int boot_prep_linux(struct bootm_headers *images)
 			puts("Can't get image data/size!\n");
 			goto error;
 		}
+
+		ret = fit_image_get_cmdline(images->fit_hdr_os,
+					    images->fit_noffset_cfg,
+					    &cmd_line_override);
+		if (ret)
+			debug("unable to retrieve cmdline for zimage\n");
+
 		is_zimage = 1;
 #endif
 	}
@@ -125,7 +133,7 @@ static int boot_prep_linux(struct bootm_headers *images)
 	printf("Setup at %#08lx\n", images->ep);
 	ret = setup_zimage((void *)images->ep, cmd_line_dest,
 			0, images->rd_start,
-			images->rd_end - images->rd_start, 0);
+			images->rd_end - images->rd_start, cmd_line_override);
 
 	if (ret) {
 		printf("## Setting up boot parameters failed ...\n");
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a5f2231aa523356de93368338b5fd249b8abad6e..af7ee8dbcf3e8f402cb0c76767b8a587f205ad5d 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -276,7 +276,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 }
 
 int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force)
+		 ulong initrd_addr, ulong initrd_size, const char *cmdline_force)
 {
 	struct setup_header *hdr = &setup_base->hdr;
 	int bootproto = get_boot_protocol(hdr, false);
@@ -333,7 +333,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 
 		/* build command line at COMMAND_LINE_OFFSET */
 		if (cmdline_force)
-			strcpy(cmd_line, (char *)cmdline_force);
+			strcpy(cmd_line, cmdline_force);
 		else
 			build_command_line(cmd_line, auto_boot);
 		if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
@@ -404,7 +404,7 @@ int zboot_setup(void)
 
 	ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
 			   0, state.initrd_addr, state.initrd_size,
-			   (ulong)state.cmdline);
+			   state.cmdline);
 	if (ret)
 		return -EINVAL;
 
diff --git a/boot/image-fit.c b/boot/image-fit.c
index e7c7212195f4a291e26ed6d3440a1b42274dacab..1790af4a8e5a9c7d11f7dee5f67226071f8f057e 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1096,6 +1096,32 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 	return ret;
 }
 
+/**
+ * fit_image_get_cmdline - get image configuration command line
+ * @fit: pointer to the FIT format image header
+ * @cfg_noffset: configuration node offset
+ * @cmdline: double pointer to char, will hold pointer to the cmdline
+ *
+ * fit_image_get_cmdline() gets the cmdline from the configuration node.
+ * If the property is found its data start address is returned to the caller.
+ *
+ * returns:
+ *     0, on success
+ *     -1, on failure
+ */
+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline)
+{
+	int len;
+
+	*cmdline = (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE_PROP, &len);
+	if (!*cmdline) {
+		fit_get_debug(fit, noffset, FIT_CMDLINE_PROP, len);
+		return -1;
+	}
+
+	return 0;
+}
+
 /**
  * fit_image_hash_get_algo - get hash algorithm name
  * @fit: pointer to the FIT format image header
@@ -2136,8 +2162,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_base_uname_config = fdt_get_name(fit, cfg_noffset, NULL);
 		printf("   Using '%s' configuration\n", fit_base_uname_config);
 		/* Remember this config */
-		if (image_type == IH_TYPE_KERNEL)
+		if (image_type == IH_TYPE_KERNEL) {
 			images->fit_uname_cfg = fit_base_uname_config;
+			images->fit_noffset_cfg = cfg_noffset;
+		}
 
 		if (FIT_IMAGE_ENABLE_VERIFY && images->verify) {
 			puts("   Verifying Hash Integrity ... ");
diff --git a/include/image.h b/include/image.h
index 34efac6056dd29307df359dce21e4f94d5fcbf2d..9916e67168e3a4f5412fc26d318af32047c239e2 100644
--- a/include/image.h
+++ b/include/image.h
@@ -365,6 +365,7 @@ struct bootm_headers {
 	 * format, even for SPL, this extra data size seems worth it.
 	 */
 	const char	*fit_uname_cfg;	/* configuration node unit name */
+	int		fit_noffset_cfg;	/* configuration node offset */
 
 	void		*fit_hdr_os;	/* os FIT image header */
 	const char	*fit_uname_os;	/* os subimage node unit name */
@@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_TFA_BL31_PROP	"tfa-bl31"
 #define FIT_TEE_PROP		"tee"
 #define FIT_COMPAT_PROP		"compatible"
+#define FIT_CMDLINE_PROP	"cmdline"
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 
@@ -1259,6 +1261,7 @@ int fit_get_data_node(const void *fit, const char *image_uname,
 int fit_get_data_conf_prop(const void *fit, const char *prop_name,
 			   const void **data, size_t *size);
 
+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline);
 int fit_image_hash_get_algo(const void *fit, int noffset, const char **algo);
 int fit_image_hash_get_value(const void *fit, int noffset, uint8_t **value,
 				int *value_len);

---
base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254
change-id: 20260401-cmdline-ab954a4e8828

Best regards,
-- 
Guillaume Ranquet <granquet@missingno.tech>

