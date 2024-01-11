Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D740BC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293B087883;
	Thu, 11 Jan 2024 11:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V7ihr5yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2705287885; Thu, 11 Jan 2024 11:34:35 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704E586813
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40BAYTX8053612;
 Thu, 11 Jan 2024 04:34:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704969270;
 bh=8h3yCOrquOEfKhrSF6IevhdxJ/n0y5OG3GFYh9jmumE=;
 h=From:Date:Subject:To:CC;
 b=V7ihr5yIvs3BigDHc5i8pAqOwai8GnU8E5jJEMfw21CBIejaXeUK27brIP6PBeuYl
 PNcAwRgY9dLY35KGm3Tt53J/r+5keO87RcdpCZ05hrc6rI/rv7LPEJqwLHInz4cMCj
 HZfQ0fcGw5IEBpZCV8rx8bdkMBUSOuSnEZfSF/VQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40BAYTYG081678
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 04:34:29 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 04:34:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 04:34:29 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40BAYQmC087112;
 Thu, 11 Jan 2024 04:34:27 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 11 Jan 2024 16:04:19 +0530
Subject: [PATCH RFC] Kconfig: Add support for FIT image signature enforcing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-b4-upstream-fit-signature-enforce-v1-1-2b91be31866e@ti.com>
X-B4-Tracking: v=1; b=H4sIACrEn2UC/x3NsQqDMBCA4VeRm3uQWIvBtdAH6FocEr3oDY1yF
 4sgvruh47f8/wFKwqTQVQcI/Vh5SQX2VsEw+zQR8lgMtanv1poWQ4PbqlnIfzFyRuUp+bwJIaW
 4yEBo3cObMTgX2gilswpF3v+PD7xfT+jP8wIP/SSSeAAAAA==
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704969266; l=3873;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=vWIkcju0OAfvvy49A7FjPhnym3Ko1tCo1178ZInrgDU=;
 b=yPUbELg0uRkq+62VLqR/IW6UGTfWAnnmLkG5RjmtgnWjz3dnOXG5hFbacyFoyYKUm/XCMYC9a
 +Ve0ncQuITxBFhPHZuVcugg5qxbGLiqqk2nwx4QaO2Ux1HwVBnFmEsf
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

FIT_SIGNATURE doesn't enforce the U-boot setup to be correct for booting
the FIT images, the DTB might not have all the proper nodes and it just
boots up without any warning. This makes it difficult to get the correct
setup working.

Adds an enforcement flag that doesn't allow the setup to have problems
and enforces the environment to only pick the signature node from DTB
and don't rely on anything else.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
A very crude implementation of [0], not exactly sure if the Kconfig
should just protect the getting key part of if we can make it more
generic and handle this as some lockdown where we can disable boot for
any other method and just allow FIT Images to bootup.

[0]: https://lore.kernel.org/u-boot/CAPnjgZ3B9hWTNAMr2QjSN8P1AsOme4XfSAYUKSg=tRRiJ9drTg@mail.gmail.com/
---
 boot/Kconfig         | 11 +++++++++++
 boot/image-fit-sig.c | 31 +++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fbc49c5bca47..ed85fd3dc3c5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -78,6 +78,17 @@ config FIT_SIGNATURE
 	  format support in this case, enable it using
 	  CONFIG_LEGACY_IMAGE_FORMAT.
 
+config FIT_SIGNATURE_ENFORCE
+	bool "Enforce the signature in FIT Images"
+	default y if TI_SECURE_DEVICE
+	depends on FIT_SIGNATURE
+	help
+	  Enabling FIT_SIGNATURE by default doesn't enforce the U-boot DTB to be
+	  having keys and allows booting the images without having proper setup.
+	  This option enforces the FIT signature mechanism to contain the keys in
+	  the DTB and enforce the nodes to be authenticated without relying on
+	  the "required" node in the DTB.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 12369896fe3f..8a324733e7e4 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -490,15 +490,24 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
-		debug("%s: No signature node found: %s\n", __func__,
-		      fdt_strerror(key_node));
-		return 0;
+		if (IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
+			printf("%s: No signature node found: %s\n", __func__,
+			       fdt_strerror(key_node));
+			return -EPERM;
+		} else {
+			debug("%s: No signature node found: %s\n", __func__,
+			      fdt_strerror(key_node));
+			return 0;
+		}
 	}
 
 	/* Get required-mode policy property from DTB */
-	reqd_mode = fdt_getprop(key_blob, key_node, "required-mode", NULL);
-	if (reqd_mode && !strcmp(reqd_mode, "any"))
-		reqd_policy_all = false;
+	if (!IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
+		reqd_mode =
+			fdt_getprop(key_blob, key_node, "required-mode", NULL);
+		if (reqd_mode && !strcmp(reqd_mode, "any"))
+			reqd_policy_all = false;
+	}
 
 	debug("%s: required-mode policy set to '%s'\n", __func__,
 	      reqd_policy_all ? "all" : "any");
@@ -514,10 +523,12 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		const char *required;
 		int ret;
 
-		required = fdt_getprop(key_blob, noffset, FIT_KEY_REQUIRED,
-				       NULL);
-		if (!required || strcmp(required, "conf"))
-			continue;
+		if (!IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
+			required = fdt_getprop(key_blob, noffset,
+					       FIT_KEY_REQUIRED, NULL);
+			if (!required || strcmp(required, "conf"))
+				continue;
+		}
 
 		reqd_sigs++;
 

---
base-commit: a803f87202aa48974bdff4d8100464a8288931e4
change-id: 20231107-b4-upstream-fit-signature-enforce-185a0db88b7f

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

