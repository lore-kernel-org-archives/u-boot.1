Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA590C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF5A81DB4;
	Fri, 28 Mar 2025 16:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PbDPx8ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77D281DED; Fri, 28 Mar 2025 16:45:02 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EFD81A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso40922039f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176699; x=1743781499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cis/JByolNEuqu5PP0L8IDSM39TBMMd7aCDRLvuW88s=;
 b=PbDPx8eiHFB86m9et+YgfB5y1shCZrLnHQTN8VnZprwV2Y7YNNpd5+OeO1wXjQIHoo
 5IhYfH6D7DcwybfNRbbK6o6+bVye3q414170AurX8xw/FLLOPokUKwYFpW1yFbgCF92T
 Eb3Z9k/MPMOAwy9DfILqFXO7rMzqucZUlUlHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176699; x=1743781499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cis/JByolNEuqu5PP0L8IDSM39TBMMd7aCDRLvuW88s=;
 b=xKKN5Kq0vP8AFLj/NXq/GJZ1qXLuVLyPAW/Ph9CNic8Fl7CfZADHXEU2oucXVCNptf
 acuLt1+5H0cWF5RwAgMW9Pm1v0AUg8qyBs37gf9yE0JpeB+bUAl+3WzsPdbPc3uz/xIu
 pfzS2HgZbEXvMUKT8Guc4ki4GzKz9gsXUZqqHM8fDWpCxC3yoWoqRKSBAZ4+FRj8wEwK
 BpSDxXxaGNOf91KbfO8iTfplFStQudJMY9XXcp2T80PNAJvYmmaTo9CM0ovGBr2udZ/P
 CT8gIRgLrllqLOy1jJlrZFHX4wmj/DPs/TtRRErSC6XiWP6ZG8L+MXtnlYmeWww2ytlr
 Bx8g==
X-Gm-Message-State: AOJu0YzOHfM86x5baga9tXDhDsyGa91JzNpykptyvXgJf65CRoh+iYCD
 +a+AoZn48uvD3SWQRpaC7BN9fohreAkTSVoR6Cn1EdoGbPKigT43wS/8E1gGJExAj1YkjaZNMew
 =
X-Gm-Gg: ASbGncutfWKn9KEIi498D0pHxU1s8U0DjZR/x68PHK0MSJEpxKMClZc+xLR6pKjZD4Z
 zpiJVQDwg2RO76bXleDoIc+AoEwsHpQ8D9WEgNs52SG8kLLuclwLZ81na3tiZiWlg+48ZBD/m4j
 rkW/aNL502w5yw3zX9RQgKybrCs4cOXU00KexfHxxwANVXS6JAkhDaNsuy1TSBrQuT5Q9w+EiD2
 NT01qqq6m2xYP23F12PXDAGrH91m4L9g2wsmKzgNIuU1wnLTHau58DHLdBhOGmBm1GHPO/6CIkH
 +pAXar5aOFThYPOZu7qiQAAKsj2HhNiLza1BH9UbaPLWF7aGGxaGGOLbUXjjw1s7q9c5vGtlGiM
 1lOBcLcVJYknoAm7E
X-Google-Smtp-Source: AGHT+IEJVRiE6kobGGuMZEYyZ5nfaiCWoQpNorQbhzcVOp9FT79IWiLA2Ayv/QRgwmMpd9rDY1dX0w==
X-Received: by 2002:a05:6602:1356:b0:85e:183e:4c00 with SMTP id
 ca18e2360f4ac-85e8206c5b7mr870887939f.1.1743176668898; 
 Fri, 28 Mar 2025 08:44:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e8ffd6b56sm42174439f.17.2025.03.28.08.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:44:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] fdt: Obtain the FDT from bloblist without parsing it
Date: Fri, 28 Mar 2025 09:43:58 -0600
Message-ID: <20250328154401.3563921-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
References: <20250328154401.3563921-1-sjg@chromium.org>
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

We don't need or want to parse the bloblist to obtain the FDT. Use the
feature in the transfer list that was designed for this situation.

This avoids the complexity of trying to init the bloblist twice before
relocation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/bloblist.c  | 32 +++++++++++++++++++++++++++++---
 include/bloblist.h | 11 +++++++++++
 lib/fdtdec.c       | 11 ++++-------
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 83d9de2749e..6bef1ab1895 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -596,11 +596,17 @@ int bloblist_maybe_init(void)
 	return 0;
 }
 
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+/**
+ * has_signature() - Check if the bloblist signature is in the registers
+ *
+ * @rzero: Register which should be zero
+ * @rsig: Register which should have the bloblist signature
+ * Return: true if signature found, false if not
+ */
+static bool has_signature(ulong rzero, ulong rsig)
 {
 	u64 version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
-	int ret;
 
 	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
 			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
@@ -612,7 +618,17 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 	}
 
 	if (rzero || rsig != sigval)
-		return -EIO;
+		return false;
+
+	return true;
+}
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+{
+	int ret;
+
+	if (!has_signature(rzero, rsig))
+		return -ENOENT;
 
 	ret = bloblist_check(xlist, 0);
 	if (ret)
@@ -623,3 +639,13 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 
 	return 0;
 }
+
+void *bloblist_early_get_fdt(void)
+{
+	ulong addr, fdt;
+
+	if (xferlist_from_boot_arg(&addr, &fdt))
+		return NULL;
+
+	return map_sysmem(fdt, 0);
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 7ff70e9554c..8be871f2d98 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -515,4 +515,15 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
  */
 int xferlist_from_boot_arg(ulong *addrp, ulong *fdtp);
 
+/**
+ * bloblist_early_get_fdt() - Get the FDT from a bloblist before it is set up
+ *
+ * The transfer list calling convention specifies that the FDT can be obtained
+ * without parsing the bloblist. Check for the presence of a bloblist and return
+ * the FDT indicated
+ *
+ * Return: Pointer to FDT or NULL if no bloblist is present
+ */
+void *bloblist_early_get_fdt(void);
+
 #endif /* __BLOBLIST_H */
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 833f8aca3ce..afa51f34867 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1692,17 +1692,14 @@ int fdtdec_setup(void)
 	int ret;
 
 	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
-		ret = bloblist_maybe_init();
-		if (ret)
-			return ret;
-		gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-		if (!gd->fdt_blob) {
+		const void *blob;
+
+		blob = bloblist_early_get_fdt();
+		if (!blob) {
 			printf("Not FDT found in bloblist\n");
-			bloblist_show_list();
 			return -ENOENT;
 		}
 		gd->fdt_src = FDTSRC_BLOBLIST;
-		bloblist_show_list();
 		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
 	} else {
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-- 
2.43.0

