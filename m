Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2DFCDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 00:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F266847C8;
	Fri, 26 Jun 2026 02:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkesgps/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2123084894; Fri, 26 Jun 2026 02:18:41 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF696847C3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 02:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so194496eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782433117; x=1783037917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GUelnesoah+OXh37pmXj0IAl68I3gleTXTmI79WjJxQ=;
 b=gkesgps/Y76hb8S08+LcvexF2pCmsERUbGnLlWQnKI7EX0GCd6v/GNIZWT+WNXgC78
 U/NyU98QtuG7a7pE9p+tvBAvvV8CrJLCHjZUlxX2o7xSi+uGRfiV8lvyQ0eTFm3J+6b6
 DT3Wlj6eMTgDLrGSFPGKZTz2OWuT5mgfaHY56o5DuJvoJ1/TNMt4mcoZF92nAfsT0TwW
 qvE8Qc98/AJCgdCScoqT+MtXPqSVdbLRzlixN89Mg2sVe8rjPMgY52ykRKq+VOdUKCp5
 2MVVJgSYRvPmEnph5zDFchiBzQywhmBv4OCIZmVsm0DZvvSmrCF09bMnduvWqdFdYKoZ
 bGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782433117; x=1783037917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUelnesoah+OXh37pmXj0IAl68I3gleTXTmI79WjJxQ=;
 b=MLfoVnSqI7oqcmv9YxNOHfI1RDRX+/PMBBVzwB4RXK5G+0yexjCo8BlL7XZoDyX5AH
 j7bvn8PvHkLaVStqFzoUECdKbOxDnwqOHPxWSBqy9A+uj2aqY9vJiabM78vWN5JwNUED
 mldwVy2qg3R8I3uGdQnegnDzqJRzsaBdocrujWvQ2bvF8AsmWrQ3Z4A4+RgMk41pjD67
 Icv6EZMUUubzuomlLVdDJrbxl+Iv67bq3dTEs3b2oopKGoSkSf3BRrBhj0Vp3ZPI/lrY
 Ryw3DH3Sk0YY+gV9QrRYovjCtwXF+/t6Ne2sWi2e4mTt/JgLuc4bolA1a/FY/W25//xA
 kAuQ==
X-Gm-Message-State: AOJu0YwC100ewdYmKvEjBHPbBNpBYw4v466ei2/c5jjMd6raAT259egQ
 /HR33L2hW6eCUWBPCbiq4tuo+PcQWyQwx07BpRgumqt0uG+UBsjKU8NZ/20O+Z8x
X-Gm-Gg: AfdE7cl6sZOUuheXXgelwPqL2PCe+YROEa6Aedn2AHpa9IgNyL7Gxfy6fnRGsH69r1N
 owycs4DZ1/1vwdX0CWTaxw1oGrK62Eh+mWQWSZ7hdSuiqyVepppVBNk4yGkijumWlUyPwb0xhty
 sjl31BITMuxH9qiiLg0fYVfN19qCGBshIHcC2gag7EyojfB97jz5gi3M0BBtHt7TwIqFGAbMU/1
 hGuq98ybFIHyys/X+mC3wfb6Bch38yZgpJieqiQcMMd474j7V2OnbFE6LAc+jPlWeoIFLgX4zwg
 BrTu8qcfKLL2+wIrpJg94x1jFo514QOinY+Hf71ePkY2owrfZHQf3bqdTmckrE7wyb73F3uCeTs
 7Z0mivPmZ7IDNTwp7KDiAlJ31GnllnpPj4XzfeYO1wo7+kxrxRpkLbAChUUDnsKTPoAmJ5NLVEY
 4WS/fqfAKnAIve5VKrJZhov04D0ncN3maDjz+zT2RabXjlIjD9MPQv2b/ddiGBBd2ijoCJ7rz75
 k2PjwyP8svp4C7PRrrZBtfwDHSwmYlQh71/iLK9Dwl+CNVFa03iw7Fp0flmuySO7tq5K2UxTZtl
 qTFrZwEZSHQdrmpKYqvKeQndmw==
X-Received: by 2002:a05:6820:4dc7:b0:69b:196a:de67 with SMTP id
 006d021491bc7-6a134f56ea4mr3341214eaf.0.1782433117487; 
 Thu, 25 Jun 2026 17:18:37 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ecd3de2sm14580730fac.8.2026.06.25.17.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 17:18:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>
Subject: [PATCH] cmd: fdt: keep control FDT during checksign
Date: Thu, 25 Jun 2026 18:18:21 -0600
Message-ID: <20260626001823.1746868-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The fdt checksign command accepts an optional address for an FDT
containing public keys. It currently installs that blob as gd->fdt_blob
before verifying the FIT configuration.

This breaks verification with DM-backed crypto drivers which have not
probed yet, since the later probe path expects gd->fdt_blob to remain
U-Boot's control FDT. For example, an ECDSA verifier can be bound from
the control FDT but fail to probe after fdt checksign points
gd->fdt_blob at the key-only DTB.

Add a FIT config verification helper that takes the key blob explicitly
and use it from fdt checksign. This keeps gd->fdt_blob unchanged while
still allowing the command to verify against an external key DTB.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/image-fit-sig.c |  8 +++++++-
 cmd/fdt.c            | 14 ++++++--------
 include/image.h      |  9 +++++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 9b5ab754561..fe7ca6e4ab5 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -708,8 +708,14 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	return 0;
 }
 
+int fit_config_verify_with_key_blob(const void *fit, int conf_noffset,
+				    const void *key_blob)
+{
+	return fit_config_verify_required_keys(fit, conf_noffset, key_blob);
+}
+
 int fit_config_verify(const void *fit, int conf_noffset)
 {
-	return fit_config_verify_required_keys(fit, conf_noffset,
+	return fit_config_verify_with_key_blob(fit, conf_noffset,
 					       gd_fdt_blob());
 }
diff --git a/cmd/fdt.c b/cmd/fdt.c
index d6d5b9fdfd2..7e2abf96103 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -719,22 +719,19 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (strncmp(argv[1], "che", 3) == 0) {
 		int cfg_noffset;
 		int ret;
-		unsigned long addr;
-		struct fdt_header *blob;
+		struct fdt_header *key_blob;
 
 		if (!working_fdt)
 			return CMD_RET_FAILURE;
 
 		if (argc > 2) {
-			addr = hextoul(argv[2], NULL);
-			blob = map_sysmem(addr, 0);
+			key_blob = map_sysmem(hextoul(argv[2], NULL), 0);
 		} else {
-			blob = (struct fdt_header *)gd->fdt_blob;
+			key_blob = (struct fdt_header *)gd->fdt_blob;
 		}
-		if (!fdt_valid(&blob))
+		if (!fdt_valid(&key_blob))
 			return 1;
 
-		gd->fdt_blob = blob;
 		cfg_noffset = fit_conf_get_node(working_fdt, NULL);
 		if (cfg_noffset < 0) {
 			printf("Could not find configuration node: %s\n",
@@ -742,7 +739,8 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return CMD_RET_FAILURE;
 		}
 
-		ret = fit_config_verify(working_fdt, cfg_noffset);
+		ret = fit_config_verify_with_key_blob(working_fdt, cfg_noffset,
+						      key_blob);
 		if (ret == 0)
 			return CMD_RET_SUCCESS;
 		else
diff --git a/include/image.h b/include/image.h
index 9c8a746d576..4b3c9c87bf5 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1461,11 +1461,20 @@ int fit_image_verify_with_data(const void *fit, int image_noffset,
 int fit_image_verify(const void *fit, int noffset);
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 int fit_config_verify(const void *fit, int conf_noffset);
+int fit_config_verify_with_key_blob(const void *fit, int conf_noffset,
+				    const void *key_blob);
 #else
 static inline int fit_config_verify(const void *fit, int conf_noffset)
 {
 	return 0;
 }
+
+static inline int fit_config_verify_with_key_blob(const void *fit,
+						  int conf_noffset,
+						  const void *key_blob)
+{
+	return 0;
+}
 #endif
 int fit_all_image_verify(const void *fit);
 int fit_config_decrypt(const void *fit, int conf_noffset);
-- 
2.53.0

