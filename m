Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A49CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170A286C78;
	Thu, 12 Oct 2023 03:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZgLuLP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99D286D94; Thu, 12 Oct 2023 03:57:49 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2374F86DC4
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d0169cf43so2658226d6.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075796; x=1697680596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abZ/4SvzNl0rnFCntYRxip0mB+LaBVilQjE34T44fU0=;
 b=gZgLuLP/03MFJ+P6Iuc13cRk0yYR8n8kSYH+Epj3nq1FnZvJpx+/RO1oyF/styz+tF
 ELCj8vvEq7iWCmKXZWjT8mGYKRDlzg493WlkSedHfsazlEXLyinSkPX1YHxQverIssrL
 /VG1TV4I+FP9DbZLzdUsAEbA1smnqx++/p59aTZjWAfnlIUH8bcqeMv/tZi2Es79oDPd
 SHJ6BWhtx3WCP5X9J7yfwFX7kUJj233+oKPXIlPpAmv1S9ksXj1j7b0dUzhaKDPnRe8n
 A+5+6Zl5/HaK3FcBY3A+/vXnTkI5K38rmWA6uvI7KUBErIAVQW1tdBGcr1aPoqegT37z
 629g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075796; x=1697680596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abZ/4SvzNl0rnFCntYRxip0mB+LaBVilQjE34T44fU0=;
 b=vztKPPxOQ0kq6TkxWKrGRUH/drHk25X3w3zIA4mvTf4Ymj6NG94J3PpNMDrlj3ve5g
 IUIt7AIWvzAsvV9jOOfYtBYaC64gnkKwrnTHcgQY6BGln1TYNIepyUlCtfS9f043Dkz7
 7vmYhCiYb38rcfIeoRQIeqQ+vn20DPoSMbiN8qD0+7hMn6xsIKDzPA2CkjW9fVL/7SCc
 XQCUQBoR/jkMuQ2lLv3Dc1KhnU8/dFQiIZ+gypPeGmMzkT9fjfDuDfiL2ibN7iepsQ3i
 b+02QDYMZmAAJj4j1MgSHlPdHxXGNXK7Q+B6JexKlpgH865bpjGzNKZ3OcdL95+iALij
 STvw==
X-Gm-Message-State: AOJu0YzCi4a1OMI2io4XkiuBRB4JQq8KfCEzDN66LsbnmQQA+Q+X4Ulc
 NbvHzOrpqVeeJhpIzvCfBu26H5YMgEAsrw==
X-Google-Smtp-Source: AGHT+IFh1+4oJtm6/CWVVhSFHPj45ntrsZ24hkHtCtQzb6U1+XpDyXyA5RkZS/MzPeef+JU/1SxiSg==
X-Received: by 2002:a0c:f30a:0:b0:656:526d:4041 with SMTP id
 j10-20020a0cf30a000000b00656526d4041mr23789787qvl.21.1697075795901; 
 Wed, 11 Oct 2023 18:56:35 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 t12-20020a0cde0c000000b0065b24c08994sm6122062qvk.128.2023.10.11.18.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:35 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 06/26] arm: imx: Add function to validate i.MX8 containers
Date: Wed, 11 Oct 2023 21:56:06 -0400
Message-Id: <20231012015626.3487451-7-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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
index c5df78d1c58..0a3d41f411e 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -84,7 +84,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 		goto end;
 	}
 
-	if (container->tag != 0x87 && container->version != 0x0) {
+	if (!valid_container_hdr(container)) {
 		printf("Wrong container header\n");
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

