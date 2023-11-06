Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69672C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642C58709C;
	Mon,  6 Nov 2023 03:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RS2qvUvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3758686F56; Mon,  6 Nov 2023 03:28:12 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63F986FF9
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cd52c51abso25229421cf.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237580; x=1699842380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRVdC6VQeW9Cy0lr4ajpWjhDHtcoPHotr2PcTKYcBEo=;
 b=RS2qvUvEPifLDiHrIb+7SSu0fbSFoOcOGIvPoeNuOMGq5uWd1PvMXJVqtaVhJAC0qT
 /trcZUElk4XCi//AmQl4qjveEEWAzzrx7IdLNpq28p1C3BWkbmaoUfIjdHBXH4QqqVco
 kj9KaeM/Ugf17NmY39NZdskodnF0LdH9D1sZ0Sl9KTLdMv6RhZoNg8N687gQ/OrHfz2/
 SjJNVQ6uyVuPNshfHv1zA6XzEuW5XVg0iRpNN8C3I5RmjNL2eMWWPeRmAoKkYU61saBX
 wVyjscIyp48AiYFZTNnC58CRDCgyy3+HwB3QbZRAyQo8cI80hEhb8txbgebSqI2QeJGx
 nVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237580; x=1699842380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRVdC6VQeW9Cy0lr4ajpWjhDHtcoPHotr2PcTKYcBEo=;
 b=YnmgxoxYHdFAI8FaY2YFRMUBTNZmaj+IkhvZVw2WI1QGpxPbq3/DefZknFJBJdycGI
 Ly7p/082Ef/Pd3u5LuCo8FK0MTbuvH7MtAKit5+LbFAIEpfbhiMCp9cfcEjWzw7kg3IC
 vkrZVdxmfw9VzdB0UHRFB/aQgpIbWH7rA0jUz4tM3yMOKa5nCf94CiYpx8DIf6oVMF/h
 quVlAyKn8/z9swU4ldma5Sks9zNuy2UG2wpuNtDQgWquI5t9ZURp1dXmGjFEfvt2dZTZ
 DME64hqpdFSHqKU6HqeSWxnYugBELo6tqRegXfAmbwAHkJ/n6lPh97KPs2tvTSoAkGSD
 yPeA==
X-Gm-Message-State: AOJu0YxZlitwxM1UpwVMwHB3/EvdcF6Bz4Tovp7f4lz8ci4MW1BaBs1u
 OkcYaFB6gYQwN9/bKQFrj0c=
X-Google-Smtp-Source: AGHT+IF4niDRFnYOoJ556gc8na7qeWt032pyGp8OZNFM3WytHnZqTtL0g5POX6Uf2j8xjoVjGARHpw==
X-Received: by 2002:a05:622a:104b:b0:41e:196c:3a37 with SMTP id
 f11-20020a05622a104b00b0041e196c3a37mr31940171qte.35.1699237580439; 
 Sun, 05 Nov 2023 18:26:20 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g14-20020ac84dce000000b00417b9f5b883sm2990963qtw.2.2023.11.05.18.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:20 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 12/25] spl: legacy: Split off LZMA decompression into its
 own function
Date: Sun,  5 Nov 2023 21:25:50 -0500
Message-Id: <20231106022603.3405551-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

To allow for easier reuse of this functionality, split it off into its
own function.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_legacy.c | 73 ++++++++++++++++++++++-------------------
 include/spl.h           | 13 ++++++++
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 75d9d822337..a561939b4f0 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -82,6 +82,43 @@ int spl_parse_legacy_header(struct spl_image_info *spl_image,
 	return 0;
 }
 
+int spl_load_legacy_lzma(struct spl_image_info *spl_image,
+			 struct spl_load_info *load, ulong offset)
+{
+	SizeT lzma_len = LZMA_LEN;
+	void *src;
+	ulong dataptr, overhead, size;
+	int ret;
+
+	/* dataptr points to compressed payload  */
+	dataptr = ALIGN_DOWN(sizeof(struct legacy_img_hdr),
+			     spl_get_bl_len(load));
+	overhead = sizeof(struct legacy_img_hdr) - dataptr;
+	size = ALIGN(spl_image->size + overhead, spl_get_bl_len(load));
+	dataptr += offset;
+
+	debug("LZMA: Decompressing %08lx to %08lx\n",
+	      dataptr, spl_image->load_addr);
+	src = malloc(size);
+	if (!src) {
+		printf("Unable to allocate %d bytes for LZMA\n",
+		       spl_image->size);
+		return -ENOMEM;
+	}
+
+	load->read(load, dataptr, size, src);
+	ret = lzmaBuffToBuffDecompress(map_sysmem(spl_image->load_addr,
+						  spl_image->size), &lzma_len,
+				       src + overhead, spl_image->size);
+	if (ret) {
+		printf("LZMA decompression error: %d\n", ret);
+		return ret;
+	}
+
+	spl_image->size = lzma_len;
+	return 0;
+}
+
 /*
  * This function is added explicitly to avoid code size increase, when
  * no compression method is enabled. The compiler will optimize the
@@ -101,8 +138,6 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 			struct spl_load_info *load, ulong offset,
 			struct legacy_img_hdr *hdr)
 {
-	__maybe_unused SizeT lzma_len;
-	__maybe_unused void *src;
 	ulong dataptr;
 	int ret;
 
@@ -133,39 +168,9 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 			   map_sysmem(spl_image->load_addr, spl_image->size));
 		break;
 
-	case IH_COMP_LZMA: {
-		ulong overhead, size;
+	case IH_COMP_LZMA:
+		return spl_load_legacy_lzma(spl_image, load, offset);
 
-		lzma_len = LZMA_LEN;
-
-		/* dataptr points to compressed payload  */
-		dataptr = ALIGN_DOWN(sizeof(*hdr), spl_get_bl_len(load));
-		overhead = sizeof(*hdr) - dataptr;
-		size = ALIGN(spl_image->size + overhead, spl_get_bl_len(load));
-		dataptr += offset;
-
-		debug("LZMA: Decompressing %08lx to %08lx\n",
-		      dataptr, spl_image->load_addr);
-		src = malloc(size);
-		if (!src) {
-			printf("Unable to allocate %d bytes for LZMA\n",
-			       spl_image->size);
-			return -ENOMEM;
-		}
-
-		load->read(load, dataptr, size, src);
-		ret = lzmaBuffToBuffDecompress(map_sysmem(spl_image->load_addr,
-							  spl_image->size),
-					       &lzma_len, src + overhead,
-					       spl_image->size);
-		if (ret) {
-			printf("LZMA decompression error: %d\n", ret);
-			return ret;
-		}
-
-		spl_image->size = lzma_len;
-		break;
-	}
 	default:
 		debug("Compression method %s is not supported\n",
 		      genimg_get_comp_short_name(image_get_comp(hdr)));
diff --git a/include/spl.h b/include/spl.h
index 4c421664a9d..d8d2cf43eeb 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -405,6 +405,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 #define SPL_COPY_PAYLOAD_ONLY	1
 #define SPL_FIT_FOUND		2
 
+/**
+ * spl_load_legacy_lzma() - Load an LZMA-compressed legacy image
+ * @spl_image:	Image description (already set up)
+ * @load:	Structure containing the information required to load data.
+ * @offset:	Pointer to image
+ *
+ * Load/decompress an LZMA-compressed legacy image from the device.
+ *
+ * Return: 0 on success, or a negative error on failure
+ */
+int spl_load_legacy_lzma(struct spl_image_info *spl_image,
+			 struct spl_load_info *load, ulong offset);
+
 /**
  * spl_load_legacy_img() - Loads a legacy image from a device.
  * @spl_image:	Image description to set up
-- 
2.37.1

