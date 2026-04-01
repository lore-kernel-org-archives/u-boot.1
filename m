Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F49610FCAD0
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 20:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FE683CE3;
	Wed,  1 Apr 2026 22:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDYcDYCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9990683CF5; Wed,  1 Apr 2026 22:52:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2578080517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 22:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so1263325e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775076747; x=1775681547; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mTvpG8LYIXXSVhHeODA+65zIP4xMqzrXDbYVGAmkw3I=;
 b=iDYcDYCI+Vw5JOqcnawE4OeIT75oDPVs0pHvAvP5lVlYaiJwY3yt7ajkIokXZI30so
 MrO4ESu4jDrx9Q9AH2yR/vDF6LfvFrmRGM+fpPlDpdoCXNUtVMYHSCrXn3NojvNzWuq0
 c2rXaqi19WDTcjWosh1JFLDv+x5EdoYh9ulYGyB4KH+vn+eUcZpQG7pB+eu9EqoQjT1b
 FnKwDuK5utgmqfqk8pSpEpTQ9g3l1bWeH59Kfg6SX2DEmS+74XI+i0ZTCOSu6hscnKfb
 PSCiI/YyO3bbQDZx38Gd+csQ3ch6BxiWgxL8ShYJBWy8Db/bLps7mEKOOE938Kwr5jM+
 XdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775076747; x=1775681547;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTvpG8LYIXXSVhHeODA+65zIP4xMqzrXDbYVGAmkw3I=;
 b=BsbhSPU/Rber0K8Q9Fj62E8GR5WKmuRuVPLC1g7YmYp2uomBs8QgIMYfZyl0X+Ulhg
 IzXHEvHcs1EHT22aJZ56k1Wpuj4TmNH7rJj9JFupPscn2WEgGnf6JRXHh8tyNDc3/npK
 2q/glfblXxsEKnlhm6sO4FN3ZVvKGQgM6yq7xkOKYmb1hU+4YS9bor32Ua62CfHMZad8
 th3s48rZilmA6rXd7Yi8mLcOtH9zE+WNRGog3JhfSlCiAmYz49vMqGMt6CKfE/STHysq
 ldRXIgO8XK+i0rtmnJoooptuKuv8k2jsU3Fd1ao/H4VoFn/o9HfC6xubpL2LOwKSctwt
 Aymw==
X-Gm-Message-State: AOJu0YwbvaxDYvLytsADi1Qvcxvh2qRNd4WAqgfAC8/olxcxA6eIm0eP
 cNOlz5cR8+m/dPwJ68R6YsLRZjfR4vsgv+AHPvhe1GAd63EBcFKGGt3D
X-Gm-Gg: ATEYQzxGrFLDZ3Z8MDOzBdqoPQxgffwZENE96YPEzNMmXO67PpdvAXE13ST3IZNA/TB
 qkAoDvfWM2/CEpQXTge1xPyaOGwJ/9Yitd6alpLm/pOkkY4QYXwzta3Dul27NH3xWaV47p/5rwG
 eBJYMkbMvldFk3jmUUTUYTbYqJ2nzh7BN3Pf7QLT7NaGDeSDknTRyY7Aqlpuou+A4Ok+zDKWj/X
 teixh06mgvcqKvOYP5Yrgat4ex2MIwBtvI6ksQjyFJrClISVQbVzADTdxt7I+qdA8ixolDkFl5U
 lSxM2eilcpvbPb2d9p8fkljb7PiiKrQ4VrQbep0ndZ3FcifecXycQx/TkQ0ehuztSWi78yYyCf6
 jihvN98026g/Nc7uNJEinfHDYJIn3t8uda6VfzMtTdJWjqX+e7rPRviLDrXKAlpJV3EwvPlKkY4
 bS6ihSPonkloemNnKH+8Xj7Bw+k2pEPsbMJk5kJd20lBiJ7F+vntVbYyRLWnVkM9+0+UMc76RWB
 bZ4lA+lPR069g==
X-Received: by 2002:a05:600c:a16:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-4888359ddf2mr85461895e9.24.1775076746940; 
 Wed, 01 Apr 2026 13:52:26 -0700 (PDT)
Received: from [192.168.0.79]
 (laubervilliers-659-1-61-87.w80-13.abo.wanadoo.fr. [80.13.212.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a65635fsm21452495e9.6.2026.04.01.13.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:52:26 -0700 (PDT)
From: Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Google-Original-From: Guillaume Ranquet <granquet@missingno.tech>
Date: Wed, 01 Apr 2026 22:52:14 +0200
Subject: [PATCH] arch/x86/lib: implement cmdline configuration property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-cmdline-v1-1-c56577f82960@missingno.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3eTclJzMvFTdxCRLU5NEk1QLCyMLJaDqgqLUtMwKsEnRsbW1AM7
 GSS5ZAAAA
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
 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/bootm.c          | 10 +++++++++-
 arch/x86/lib/zimage.c         |  4 ++--
 boot/image-fit.c              | 30 +++++++++++++++++++++++++++++-
 include/image.h               |  3 +++
 5 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 8b5426051701c8266395afd9232eb1ff30d38304..bbcfa993761510e88610574c1c0debff519089a2 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -132,7 +132,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
  * Return: 0 (always)
  */
 int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
+		 ulong initrd_addr, ulong initrd_size, char *cmdline_force);
 
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
index a5f2231aa523356de93368338b5fd249b8abad6e..78e4a0df89157b1cfc612ff69c533b7a1c1d6405 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -276,7 +276,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 }
 
 int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force)
+		 ulong initrd_addr, ulong initrd_size, char *cmdline_force)
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
diff --git a/boot/image-fit.c b/boot/image-fit.c
index e7c7212195f4a291e26ed6d3440a1b42274dacab..5933c451011cfaf644b4422bc89c1e56cdbbd595 100644
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
+	*cmdline = (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE, &len);
+	if (!cmdline) {
+		fit_get_debug(fit, noffset, FIT_CMDLINE, len);
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
index 34efac6056dd29307df359dce21e4f94d5fcbf2d..793455d39683c1c63f5dc5e87a91d08a10cdb141 100644
--- a/include/image.h
+++ b/include/image.h
@@ -365,6 +365,7 @@ struct bootm_headers {
 	 * format, even for SPL, this extra data size seems worth it.
 	 */
 	const char	*fit_uname_cfg;	/* configuration node unit name */
+	int		fit_noffset_cfg;	/* os subimage node offset */
 
 	void		*fit_hdr_os;	/* os FIT image header */
 	const char	*fit_uname_os;	/* os subimage node unit name */
@@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_TFA_BL31_PROP	"tfa-bl31"
 #define FIT_TEE_PROP		"tee"
 #define FIT_COMPAT_PROP		"compatible"
+#define FIT_CMDLINE			"cmdline"
 
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

