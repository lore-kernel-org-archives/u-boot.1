Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 08:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B54846DF;
	Sun, 15 Oct 2023 10:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkyJS7QJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F257386EE2; Sun, 15 Oct 2023 10:18:41 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F32863F8
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 10:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9ad67058fcso3361754276.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697357918; x=1697962718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbAvrdYSk5sBa33b8hWYB8LPlT4TxLLWVKh2r/hocgM=;
 b=DkyJS7QJfdU/BG9BhpBq7suKr3Q1L9jOy2jbUGh7TcPZreKlJ9TT84vkxfs/fVyZId
 2RYNpOBELqwzbknY3Uliq+6nr/1pJuLWu7DjcHG4abSd+BKfR2YG5abK6y46il9IYNGg
 m+jBlqgpeKURAzV4CTUr+k8ASfkB0RJSvLoZaHi1toQxiNqWHtwQEofJXdiqg7bEmKwg
 fCdTkfdcj8vvgT0bEHlztHLXcvT+kshL2kWvl8XGk+LdDe5nXbLYlOIU6LK84m5mfY28
 2tYJVFpxIGaEQY37SwXGYvtKgZ6t/+unH0oKqPe8wEgt+LyxV7NZs+pf5wax8BMJjckr
 XO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697357918; x=1697962718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbAvrdYSk5sBa33b8hWYB8LPlT4TxLLWVKh2r/hocgM=;
 b=VIMuEmW6KX4iSVDpnr9Ea0MCFx+PdYAzxYRq2HAxDlREDQONSuELVyR2g33j3XKFVu
 iLpaaCNzBC9h6VpkDmqPLuRePpJA9vhCAX8J29no86Xm2aEmW7H+AypMFjol8EfqfgJY
 eQTCUWd5Or4RXY7QSEkbZLpa9++clWywD2eIHeqDtT5YXz3au4NNNT7gjdaedU5N9X70
 nphTSakS90WeYqqPE1BsGv6gjhpOp8+L393MO3t6XfAn8/juACgdo4RXQ5Q1dwBbvuDD
 FNp4jpgyJpjH5eor6OfRaId2eadpALz8pbUCj6IuDf51g6tHORmLuReFCSydk2l+LhJ/
 JoEA==
X-Gm-Message-State: AOJu0YydgaD/JqKIscdwBsBlC/SRyH+EkR9ejvYy7ChMe3MiUq34uVZc
 zmrdpdE190BX6Y+RcuWCXgvRsMFvDZlatQ==
X-Google-Smtp-Source: AGHT+IFuPL+/qHQeLtVyeioQXtJ6kcm6AuBRSmb1FmCAqbwMkyNxI69RUzqRoLVUMRjeug8WRVe52A==
X-Received: by 2002:a05:622a:5:b0:417:d68d:2b24 with SMTP id
 x5-20020a05622a000500b00417d68d2b24mr39121949qtw.33.1697316496254; 
 Sat, 14 Oct 2023 13:48:16 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g16-20020ad45110000000b0065b12c7a48dsm1943496qvp.133.2023.10.14.13.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:15 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 07/29] arm: imx: Add function to validate i.MX8 containers
Date: Sat, 14 Oct 2023 16:47:43 -0400
Message-Id: <20231014204805.439009-8-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Add a function to abstract the common task of validating i.MX8 container
image headers.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 arch/arm/include/asm/mach-imx/image.h | 9 +++++++++
 arch/arm/mach-imx/ele_ahab.c          | 2 +-
 arch/arm/mach-imx/image-container.c   | 2 +-
 arch/arm/mach-imx/imx8/ahab.c         | 2 +-
 arch/arm/mach-imx/parse-container.c   | 2 +-
 arch/arm/mach-imx/spl_imx_romapi.c    | 3 ++-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/image.h b/arch/arm/include/asm/mach-imx/image.h
index ee67ca96f4c..54cd684e35d 100644
--- a/arch/arm/include/asm/mach-imx/image.h
+++ b/arch/arm/include/asm/mach-imx/image.h
@@ -18,6 +18,9 @@
 #define CONTAINER_HDR_QSPI_OFFSET SZ_4K
 #define CONTAINER_HDR_NAND_OFFSET SZ_128M
 
+#define CONTAINER_HDR_TAG 0x87
+#define CONTAINER_HDR_VERSION 0
+
 struct container_hdr {
 	u8 version;
 	u8 length_lsb;
@@ -66,4 +69,10 @@ struct generate_key_blob_hdr {
 } __packed;
 
 int get_container_size(ulong addr, u16 *header_length);
+
+static inline bool valid_container_hdr(struct container_hdr *container)
+{
+	return container->tag == CONTAINER_HDR_TAG &&
+	       container->version == CONTAINER_HDR_VERSION;
+}
 #endif
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 785b0d6ec3c..6a1ad198f89 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -343,7 +343,7 @@ int authenticate_os_container(ulong addr)
 	}
 
 	phdr = (struct container_hdr *)addr;
-	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+	if (!valid_container_hdr(phdr)) {
 		printf("Error: Wrong container header\n");
 		return -EFAULT;
 	}
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 5f188ab32d1..eff9e0c4597 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -50,7 +50,7 @@ int get_container_size(ulong addr, u16 *header_length)
 	u32 max_offset = 0, img_end;
 
 	phdr = (struct container_hdr *)addr;
-	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+	if (!valid_container_hdr(phdr)) {
 		debug("Wrong container header\n");
 		return -EFAULT;
 	}
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index b58b14ca9b4..44ea63584aa 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -146,7 +146,7 @@ int authenticate_os_container(ulong addr)
 	}
 
 	phdr = (struct container_hdr *)addr;
-	if (phdr->tag != 0x87 && phdr->version != 0x0) {
+	if (!valid_container_hdr(phdr)) {
 		printf("Error: Wrong container header\n");
 		return -EFAULT;
 	}
diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index 48cffb3ab4d..d57f25df6dc 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -85,7 +85,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 		goto end;
 	}
 
-	if (container->tag != 0x87 && container->version != 0x0) {
+	if (!valid_container_hdr(container)) {
 		log_err("Wrong container header\n");
 		ret = -ENOENT;
 		goto end;
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 4af41699678..b51061b987b 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -184,7 +184,8 @@ static u8 *search_container_header(u8 *p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = p + i;
-		if (*(hdr + 3) == 0x87 && *hdr == 0 && (*(hdr + 1) != 0 || *(hdr + 2) != 0))
+		if (valid_container_hdr((void *)hdr) &&
+		    (*(hdr + 1) != 0 || *(hdr + 2) != 0))
 			return p + i;
 	}
 
-- 
2.37.1

