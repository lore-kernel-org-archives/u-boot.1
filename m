Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B4CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA68848E2;
	Tue,  2 Jun 2026 10:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="LcO9q8MN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D30848A1; Tue,  2 Jun 2026 09:42:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8AC84895
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso1227778f8f.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780386140; x=1780990940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxDpY8HfagRtcmzjJzNZ4oMIp9RwfLUyPGmF04u1fI0=;
 b=LcO9q8MNJv/2J2oxSyOv7XDJ7trgTvc8WbvAZE2A2dNH7rppGZgQ3Syh1RoIbVja+g
 LVIRaqAqz5zSX1SRz9viiXcFnZCwxE5Cq+DH6OMvBM8O4+doQHwHPh42kgIx8vJIyNug
 YDiQ+pL2Cu5/mGBpraxJB5hUWmDqPPsoTM03/+iMVvjTe2FifdJDq+9+YXDT8k1mtboc
 yTc7LtxUKhh/b0aYLsK3D9gBMeQYFyoJ96PPIizX6tjpH+SSKjFxporeoS4KaRs80d9r
 9eT2iY8H8ZYFuumaEAuIMRUU+N9TOOE6i+/pAxWpJ1TyRzzxkmGoqVgi3y/FPOhkfGig
 qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386140; x=1780990940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YxDpY8HfagRtcmzjJzNZ4oMIp9RwfLUyPGmF04u1fI0=;
 b=QwwMcKBXqE1kkRbcy1PURGEjt5drhzCMOcXJCVn4vSgssMAjBEDBb/x/ojqaWgsPaG
 cNoMOWOpgGDyhS4cIlSUny+aam/+p6rrmO7X/7wIu5+zENxiWa0BSpz4CwHgBFB/PF0B
 p12U6yABD/v4llpb7pWd1VzZbdHsKRCzWgD6T/bz19cPFZwHApX96EAI0AShbD1kcDXv
 /NSwo2Evg7KwBFiTguKxzUHBtRPqNfA8ACm8kw2WaOxCKdEeYru3sLekW7rSPffcmwwn
 od04fkDGFlS1yU7M093j0f6t8xIGpC9OGISa6cj/k4o8OnRMtNBU+RNZMdZmpnbVyHn3
 2ciA==
X-Gm-Message-State: AOJu0YwF3tiSC/MkNP53RMazVr4+4VW2q8bi4dAWkISqycWf3adFfIRc
 /s47LMs6zv+e7Pjt4lyQvwC3Lhm9PkbfzwFP6whVUONnlQUkxmcMrPgH/16SmqqxDLZZXJ859yk
 H3Z5/4SAd8w==
X-Gm-Gg: Acq92OEhf5LOoxE2LUdrAboHZTcWXZMm23PqzmTTp3Cg+du9O/HEliCdjI0pZJRH5jG
 C7qKY4wBi6RDdFV2x66pu3D5eLxAcH+1qwqYmJ+59cqdoKIY/62IbfDLqzATIAmicSVVRQw+4tu
 poPb0j6FjT2jkgOCrRYGQiDGHZjmXAthtfmPIQ4JPqJdeniVKuVTnDncDcCiU3WOf9TOGUr9fgh
 NrUFz6hhq9NB8jJFSY+isBPLCmeAQDqg0A+/aXiYcqSx2qsKCMGaBv+5DL/jTOk2a9y9upzKo3b
 vdItb7KMXv1bQc+2g+Ux4GDpyFE9YXWg7evaNXEgN8zDHP/fiwaEzLFAZ1aHZUYPTM4TQK9UC+B
 ro+zxt3g955iga/KxFOUXRtJzBDTYVq5G65WvtTkHDQZOnxuOwYgOKntg24pLeil14Yk88q+mRc
 WTTRWiAOXIJsabw9x5ZHyZc3dTWqppZO0uDqLsMQzg1KkD3g==
X-Received: by 2002:a05:6000:1283:b0:45e:739b:2750 with SMTP id
 ffacd0b85a97d-46018cf9ed4mr3498270f8f.9.1780386139594; 
 Tue, 02 Jun 2026 00:42:19 -0700 (PDT)
Received: from mimir.fritz.box ([2a04:9546:1c18:5b01:cab3:2478:20a6:2fb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm30239748f8f.21.2026.06.02.00.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:42:19 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 upstream+uboot@sigma-star.at, Bruce Monroe <bruce.monroe@intel.com>,
 Arie Haenel <arie.haenel@intel.com>,
 Julien Lenoir <julien.lenoir@intel.com>,
 Lorenz Kofler <lorenz@sigma-star.at>
Subject: [RFC PATCH 2/3] boot/fit: stop rejecting '@' during image and config
 verification
Date: Tue,  2 Jun 2026 09:43:34 +0200
Message-ID: <20260602074335.3965312-3-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602074335.3965312-1-lorenz@sigma-star.at>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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

Partially revert commit 79af75f7776f ("fit: Don't allow verification of
images with @ nodes").

That commit rejected any FIT node whose name contains '@' in
fit_image_verify(), fit_image_verify_sig() and
fit_config_verify_required_keys(). FIT references are now resolved with
an exact subnode-name match, so the aliasing weakness behind
CVE-2021-27138 can no longer be exploited even when '@' node names are
present. These checks are therefore no longer needed, so drop them to
restore support for FIT images that use unit addresses in their node
names.

This is not a full revert. That commit's fit_image_verify() error-path
refactor and its test_fit.py and vboot_forge.py renames (replacing '@'
unit addresses with '-' in the test FIT node names) are kept.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 boot/image-fit-sig.c | 21 +--------------------
 boot/image-fit.c     |  9 ---------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..a30a2ccd8a1 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -148,14 +148,6 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
 	fdt_for_each_subnode(noffset, fit, image_noffset) {
 		const char *name = fit_get_name(fit, noffset, NULL);
 
-		/*
-		 * We don't support this since libfdt considers names with the
-		 * name root but different @ suffix to be equal
-		 */
-		if (strchr(name, '@')) {
-			err_msg = "Node name contains @";
-			goto error;
-		}
 		if (!strncmp(name, FIT_SIG_NODENAME,
 			     strlen(FIT_SIG_NODENAME))) {
 			ret = fit_image_check_sig(fit, noffset, data, size,
@@ -608,13 +600,11 @@ error:
  * @conf_noffset: Offset of the configuration node to check (e.g.
  *	/configurations/conf-1)
  * @key_blob: Blob containing the keys to check against
- * @return 0 if OK, -EPERM if any signatures did not verify, or the
- *	configuration node has an invalid name
+ * @return 0 if OK, -EPERM if any signatures did not verify
  */
 static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 					   const void *key_blob)
 {
-	const char *name = fit_get_name(fit, conf_noffset, NULL);
 	int noffset;
 	int key_node;
 	int verified = 0;
@@ -627,15 +617,6 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		return 0;
 #endif
 
-	/*
-	 * We don't support this since libfdt considers names with the
-	 * name root but different @ suffix to be equal
-	 */
-	if (strchr(name, '@')) {
-		printf("Configuration node '%s' contains '@'\n", name);
-		return -EPERM;
-	}
-
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
diff --git a/boot/image-fit.c b/boot/image-fit.c
index a6504cd8041..d82603ae557 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1434,19 +1434,10 @@ error:
  */
 int fit_image_verify(const void *fit, int image_noffset)
 {
-	const char *name = fit_get_name(fit, image_noffset, NULL);
 	const void	*data;
 	size_t		size;
 	char		*err_msg = "";
 
-	if (IS_ENABLED(CONFIG_FIT_SIGNATURE) && strchr(name, '@')) {
-		/*
-		 * We don't support this since libfdt considers names with the
-		 * name root but different @ suffix to be equal
-		 */
-		err_msg = "Node name contains @";
-		goto err;
-	}
 	/* Get image data and data length */
 	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
 		err_msg = "Can't get image data/size";
-- 
2.54.0

