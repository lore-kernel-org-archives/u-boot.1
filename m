Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0FC8776E;
	Wed,  8 Nov 2023 17:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHEm7AmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E258A87747; Wed,  8 Nov 2023 17:49:28 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508FE87675
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a6c440faso384407285a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462158; x=1700066958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+mesTBxYW9aGZ4ycWCSC/Q22ZLWjxvplLaDHdLRBsQ=;
 b=NHEm7AmAAHK+LvmDpbnwcgClrJ0Pc7bGSMp9+co91Zc6SdGMlTow1SwW9KYpJvvwAX
 LMcnSkrWTU+4yl2tEUXJ/sftuF+tCNIGP/ms87rv5Re8Zuucj8U2KoLngEGqOQ9mtuNP
 1uVcZztDZ7CDIxO3Pw+yo58EXOwPKP59ndzXDyT8ygXIMvO+oc64mAYThw33gwfzL45S
 bVBYZQkJWZHReNxSBS0XszVFAOlv7MkEMxECQ1RxB3ZcZrKMf9bfqYZIom+c8G/+Ic9P
 NvkObReMdUaVzXAQEz+mMKOVao43iFmFfs5mw2luR5ACAP84liMq5GNw8SAOeDgGrkWy
 imcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462158; x=1700066958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+mesTBxYW9aGZ4ycWCSC/Q22ZLWjxvplLaDHdLRBsQ=;
 b=pokBzCTqS21kKTPYo/04iWJumHalsSPSzAkL+pqacLzpLDp7r1x7HcCtTQAR09CdLV
 sQID120jou184Et+FboNmSaqby5mhSD7jc1RDRRGg+Iea46wNQ7Tfu86ZAcJ2f/rj0YB
 qK5XvFsH77EVwNfWwWZVsf/tgFpMnbQJVt2Xqt4P5gb8lp+EFdCC3LG3ifekz9KPNM9W
 h9asHCLua9ZEq4xcB21ILULjA2MVfzHx/6rl2Ua2DZCseVPpls14iKD3Mgjs0IKqVNO9
 Z4Fk6NM1AyefKMEkBkJyo1tkDDhjr536tGWAd/oyngVkb+w0t5NIQ7er8O5o6xTf5ynt
 mn3Q==
X-Gm-Message-State: AOJu0YxsgGKQqufsCeCviRzGTNtoAZ10vLQN9s/3VGmahe7wtpzTCB12
 bRpkM0h6/Cyepi86i6nN24k=
X-Google-Smtp-Source: AGHT+IFC9KkG34aDQXpmr98uo7gmN0jt26t/7KbF/qz/b2PN7RzF6aqHJLg3GRqKnADnaC3gLovn9g==
X-Received: by 2002:a05:620a:2913:b0:76a:db80:121d with SMTP id
 m19-20020a05620a291300b0076adb80121dmr2083690qkp.6.1699462158116; 
 Wed, 08 Nov 2023 08:49:18 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 f16-20020ae9ea10000000b0076ee973b9a7sm1223066qkg.27.2023.11.08.08.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:17 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 13/26] spl: legacy: Split off LZMA decompression into its
 own function
Date: Wed,  8 Nov 2023 11:48:45 -0500
Message-Id: <20231108164858.3497420-14-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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
index 03c5c5c66b4..09521889014 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -407,6 +407,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
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

