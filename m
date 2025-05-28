Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEE0C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD1E83A97;
	Wed, 28 May 2025 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V1njCKGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9100883A98; Wed, 28 May 2025 14:33:47 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4BB83AA4
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85db3475637so26405739f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435623; x=1749040423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2CabTZBrewwErcizQtiA9yQjzZcMR09BizNKS3rt4M=;
 b=V1njCKGbMTkFc/o0ZUGlCYjMgaWPK5kjgJwAXEZBOOvMAyAxaYyqnh5QoJoqRSIDzB
 r7nFB79Q8mfNF0cCp0rIciv8ucoHMJjpl5BQpFR3R8mMQDuarWgm+WINJJ9HXLAy0nVB
 Ecfz+WX6zz33jVYZJxE11/2tzYX/RU9lE9mX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435623; x=1749040423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2CabTZBrewwErcizQtiA9yQjzZcMR09BizNKS3rt4M=;
 b=wVvo4v8hb875QyFME56VbCLYXlCDxVDRmjHlSgvtsdHB14m9WKsHRvGCiOCwz4UfnD
 f9/zm/BwY6C+Quda43BTbWHnIOhPtwOdb+BhDSxkih0bUTXgQYSrZWyrGynhIOq4tH3t
 wInYYChlEdxww4LDfogAJE3LdVnUSQGicx42LuBcFNTdxFo0V1R9nnhMgc+5MO7Aefae
 75WnJevpdmdtRI58XIChdN+De3seQ5Xcl+zzTzaOyqZZ/cWjK0gcvrgYdIZitblKtWh2
 ch4pW6ewheZnQDiCG3+6Wo2zPtsmOZWODFpLcBloapNPiyvp4nIqrXtbDsPpVVSmM/n6
 7qZQ==
X-Gm-Message-State: AOJu0YwrXpg/5I35nZDfyMXNnBbS/LN9RktjMQqCnaF9Jxhj9I4UvEXU
 bMw3/nTsMiES6JbKik/YpoQkd8hyjs6lDXXmlHNKQGA6xE5dykLHcohgXjgtwUltKFfs4YQpAuL
 nKZvornLW
X-Gm-Gg: ASbGncsPhA/2LymNE3aQfnY78vTd7NCokfLDstHZwYNSwZfzT02ymqMfKCeMOCzELSN
 dkBnmXsemtVdY/q0rxWGEmIaHcc1FmO6rcBzMhVayX1B3+0XWF+hZHOc51QBTlCMuWhEVNIKZIh
 BByCQn3K8HbscTGtG6SN1GTRMS8sFVbpIJ0W9BFtUebESZB+kleYPaOwa1v43Ax1sYQRUVPR37R
 h77t+yjsTgoaxf3ken8byYC8Wt6+mJFWXkCqO4aCRVFqW8fH2/nbq3q3SJXSflTOpmZjotb5CAu
 jCNR4incFMM/HJgipz26PLMoQkpOjmgVbnz9CrHhsyj2M0MJ8RpGNl6w9A2r+0a77pd4T7/hx86
 HY7U9LePDdDND
X-Google-Smtp-Source: AGHT+IFdGLJUTUdr31C01CUCtoIvvnwYJ6NbXuyy6l0VS/t6yZCSE5uFkhjFJZS4FzOlnJvsJxIasw==
X-Received: by 2002:a05:6e02:1b04:b0:3dc:8358:fc07 with SMTP id
 e9e14a558f8ab-3dd8761496cmr50713855ab.3.1748435623185; 
 Wed, 28 May 2025 05:33:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 14/25] passage: spl: Support passing the passage to U-Boot
Date: Wed, 28 May 2025 06:32:16 -0600
Message-ID: <20250528063224.v5.14.Ifb43052c7d1729d6d1503a74e89abb69ee99cbf3@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Create a new arch-specific way of creating a standard passage for the
next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Fix 'to' typo

Changes in v2:
- Make the stdpass calling standard arch-specific

 common/spl/spl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6e38f118f48..b705fd5514a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <nand.h>
+#include <passage.h>
 #include <serial.h>
 #include <spl.h>
 #include <spl_load.h>
@@ -398,13 +399,28 @@ int spl_load(struct spl_image_info *spl_image,
 
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
-	typedef void __noreturn (*image_entry_noargs_t)(void);
-
-	image_entry_noargs_t image_entry =
-		(image_entry_noargs_t)spl_image->entry_point;
+	ulong bloblist = 0;
 
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
-	image_entry();
+
+	if (CONFIG_IS_ENABLED(PASSAGE_OUT)) {
+		const void *fdt;
+
+		bloblist = bloblist_get_base();
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+
+		log_debug("passage: sending bloblist %lx dtb %lx\n",
+			  bloblist, (ulong)map_to_sysmem(fdt));
+		arch_passage_entry(spl_image->entry_point,
+				   map_to_sysmem(gd_bloblist()),
+				   map_to_sysmem(fdt));
+	} else {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+
+		image_entry_noargs_t image_entry =
+			(image_entry_noargs_t)spl_image->entry_point;
+		image_entry();
+	}
 }
 
 #if CONFIG_IS_ENABLED(HANDOFF)
-- 
2.43.0

