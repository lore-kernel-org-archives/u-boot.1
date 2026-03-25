Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A357E109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04BD84090;
	Wed, 25 Mar 2026 17:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X/ctBrxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618F28408D; Wed, 25 Mar 2026 17:55:57 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BF083F14
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46805c4ae5dso4048b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457753; x=1775062553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/X8linunaJh7FOP64XGfe4iHFWg4bjSahyn53q0yEfQ=;
 b=X/ctBrxUWLUcn+0mmwgDMoK0ho28JFdgLs4aalInFCe86it8oG0qVzNhneHbcS21vt
 R+VAmCvpjG+VOAmf/WstYQKYLeCx5UcUsw+i9McKF9ooif3LDBFx2AeEjDknyl91ZM14
 TzrxyLY2n4p8OqALy56Dh6Ec0hPD9uCUkvde0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457753; x=1775062553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/X8linunaJh7FOP64XGfe4iHFWg4bjSahyn53q0yEfQ=;
 b=FHbDffVmIL3hhFP0imSWdv835S9vhLcxMZ8BMPwrJeTqxJ8JalLikGLsjOCgi/nxV7
 O+MpUkhciqLYJkHOIBDPJHDCoTJlEElCmA7bayYWMKdNXtxgr0+TeP+5kl6LqEp/0NHM
 ifjQ/PV6w674QA4O+L2l1GrVCYwE/iux2ey5g+OPma6agIGZPJc+TW+idxpVQXA/IfrF
 4ntRLfzsXinMuo2BfmxsNLcrxxJibKIywiMw5gXb3x2hYNXKY1KhbhPNjJOxXXCpj+gr
 9qcPb7I5/GyZz0jBrFk9yOW9c1ysSXRYTwFz8Za+Pnx5gWQLvEZC4KpJp5I1ZWLfww1R
 iaMg==
X-Gm-Message-State: AOJu0YztYndqTlr3sQrSAXF8UUKjOIMCGBnUeEB6c1thy2LSpqIVanHp
 MuR4zYJlfDxSoGehRQeQEdW6MuFnMdfRf3VUS+sx796iBVzbqBTu0DxQC4lZnZgaVmm2+nOuMu7
 XuuSSKA==
X-Gm-Gg: ATEYQzzu2E/PyPQB+v5XDQ9PSwetb3YTJyXfi0ZQQTLNO4uJTJi0W+bl6Do+PyGRa1M
 jJEwjakCwHe5a0/hXXeneGyWOPTAo5GFgLd/fdlYlua6P3QrZG+0Ob5kRovFOfJH+8l0KhxGtXT
 9AzwbIMLKt2AqDlWWs1AmHpDYVxBTLXXZ64ty/qREm9BU4eHFsd0K29YDW3uD7EvEQ8CPTEHTsW
 ksxQIZs8IEKKk9mNAcjTrY4a+WQr+pLTVLN5kVT8tr/pvi3Y8nSYOJN8rOYYBA+MjzCIhwY13Hx
 b6ICfH37fa7mUDcK9Yl3IIALYbziWoKmGC0Pdk/aIjQ1Gnhi042yIEnK+h74YEzuA1ggRE4LiF4
 P5C8USTxKTLUhXMFgmuvMkW+WmnQnUnJeqFLWlgAmF/U7EV/0vgSfwMgtSXtshhMG6x8l5UTq0u
 o9WCqNYk+Vrgmx9nNfTQ==
X-Received: by 2002:a05:6808:23cc:b0:467:f636:23bd with SMTP id
 5614622812f47-46a5c7448f7mr2004293b6e.42.1774457753357; 
 Wed, 25 Mar 2026 09:55:53 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] boot: Move setting the OS arch into check_allowed()
Date: Wed, 25 Mar 2026 10:54:20 -0600
Message-ID: <20260325165431.1027591-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

Remove a few more lines from fit_image_load() by dealing with this small
detail in check_allowed().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 7efd0f30dc5..749cbe19ade 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2182,17 +2182,19 @@ static int select_image(const void *fit, struct bootm_headers *images,
  *
  * @fit: FIT to check
  * @noffset: Node offset of the image being loaded
+ * @images: Boot images structure
  * @image_type: Type of the image
  * @arch: Expected architecture for the image
  * @bootstage_id: ID of starting bootstage to use for progress updates
  * Return: 0 if OK, -EIO if not
  */
 static int check_allowed(const void *fit, int noffset,
+			 struct bootm_headers *images,
 			 enum image_type_t image_type, enum image_arch_t arch,
 			 int bootstage_id)
 {
 	bool type_ok, os_ok;
-	uint8_t os;
+	uint8_t os, os_arch;
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
 	if (!tools_build() && IS_ENABLED(CONFIG_SANDBOX)) {
@@ -2238,6 +2240,9 @@ static int check_allowed(const void *fit, int noffset,
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL_OK);
 
+	fit_image_get_arch(fit, noffset, &os_arch);
+	images_set_arch(images, os_arch);
+
 	return 0;
 }
 
@@ -2476,7 +2481,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const void *fit;
 	void *buf;
 	ulong load, data, len;
-	uint8_t os_arch;
 	const char *prop_name;
 	int ret;
 
@@ -2493,13 +2497,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (noffset < 0)
 		return noffset;
 
-	ret = check_allowed(fit, noffset, image_type, arch, bootstage_id);
+	ret = check_allowed(fit, noffset, images, image_type, arch,
+			    bootstage_id);
 	if (ret)
 		return ret;
 
-	fit_image_get_arch(fit, noffset, &os_arch);
-	images_set_arch(images, os_arch);
-
 	ret = obtain_data(fit, noffset, prop_name, bootstage_id, &buf, &len);
 	if (ret)
 		return ret;
-- 
2.43.0

