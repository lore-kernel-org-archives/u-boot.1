Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E44C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3076987C6B;
	Sun, 29 Oct 2023 04:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5jrJFGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B1C87C66; Sun, 29 Oct 2023 04:49:00 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE5D87C5D
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41cc7379b23so23139091cf.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551335; x=1699156135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek/t3/OnkB2Ff2L4jaCnFvE+iLlax+BbtikvxS1whJI=;
 b=l5jrJFGRd0UQkVf2oCW6Dk54u6nVa3xJxqxCSCBwQX5M6uomZZSCDPjGSlbuM4r9uP
 ALRH3t68oM309rSj3dQfnIxtXLFqMwecEWyg/qbQOiyb0d3r4VXfjBhZ/MmXUUUyLNsY
 LQZoAdzu5fLslyGp4dKhOdzdGVHc/UjK4lgkKky5RGBwVJ/3GIhPnAdajG3cxzqjHXI8
 CzuYYYUrDhMivj9ovBjZeKW9kTXyKk8Iq6f/yWV3q7XIOwfpv/rgjFAeiIIxVMC/Di1J
 EP+O3dYKIjaRAdEv+5jwxoHkwqNLM6xKtKCaNOtRHYB1zoYOF3Raw2Rel9AavevrdtQ4
 mopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551335; x=1699156135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek/t3/OnkB2Ff2L4jaCnFvE+iLlax+BbtikvxS1whJI=;
 b=NKgDOM4wSuHKNizUNwo1dwqUgEemdwQ8kZMiUDFw1jQbaHj0XWTRH09yQkq2n4E2Qd
 Mks/IxbOE0+5Ow7sxRafTxonmH2RRoNYH8/DqmYK+F++DSSUpG7hgbyAzdn5eka563pD
 6WQBqc4oAq49OgBt1V5uYp3CPCt2Kmno+l9gCPIeSDpSpXPDYufMRHSvh85FOFjqtBCC
 YWj1uo9BM2oUY6rCyHkXTcfAoShaWIhEMORe8uNXbeEgsHvrG7kES5JJuEqZPtMF497n
 kZWhOLzfUIigur36yxBQJwpP6aD4vWJOjxSUlgRPaYoq5Tv6bBBwouDelzqngUpd5+RY
 SMWQ==
X-Gm-Message-State: AOJu0YySf6Tn7C+Xq8sYoA/jm9U8ekEEiunD5CUyascdKeW2z1SaLpeh
 +Xi85bllLNwru4heW7yxNPBK/H8CUm+K6w==
X-Google-Smtp-Source: AGHT+IFjBNc8Z5g9X2FE8gZ2+xCSHn1QR8m6ln5CVS2CxQtVduL6EmtlNjw7I61oLSLhTFlF5eX/xA==
X-Received: by 2002:a05:622a:18a4:b0:41e:2423:f0be with SMTP id
 v36-20020a05622a18a400b0041e2423f0bemr9584805qtc.40.1698551335082; 
 Sat, 28 Oct 2023 20:48:55 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d9-20020a056214184900b0064f5d70d072sm1212736qvy.37.2023.10.28.20.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:54 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 05/15] spl: legacy: Honor bl_len when decompressing
Date: Sat, 28 Oct 2023 23:48:35 -0400
Message-Id: <20231029034845.1169614-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

When allocating a buffer to load compressed data into, we need to ensure we
have enough space for over- and under-flow due to alignment. Otherwise we
will clobber the malloc bookkeeping data. Calculate the correct amount of
overhead and use it when determining the size.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_legacy.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 51656fb9617..9189576b774 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -133,25 +133,31 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 			   map_sysmem(spl_image->load_addr, spl_image->size));
 		break;
 
-	case IH_COMP_LZMA:
+	case IH_COMP_LZMA: {
+		ulong overhead, size;
+
 		lzma_len = LZMA_LEN;
 
 		/* dataptr points to compressed payload  */
-		dataptr = offset + sizeof(*hdr);
+		dataptr = ALIGN_DOWN(sizeof(*hdr), load->bl_len);
+		overhead = sizeof(*hdr) - dataptr;
+		size = ALIGN(spl_image->size + overhead, load->bl_len);
+		dataptr += offset;
 
 		debug("LZMA: Decompressing %08lx to %08lx\n",
 		      dataptr, spl_image->load_addr);
-		src = malloc(spl_image->size);
+		src = malloc(size);
 		if (!src) {
 			printf("Unable to allocate %d bytes for LZMA\n",
 			       spl_image->size);
 			return -ENOMEM;
 		}
 
-		load->read(load, dataptr, spl_image->size, src);
+		load->read(load, dataptr, size, src);
 		ret = lzmaBuffToBuffDecompress(map_sysmem(spl_image->load_addr,
 							  spl_image->size),
-					       &lzma_len, src, spl_image->size);
+					       &lzma_len, src + overhead,
+					       spl_image->size);
 		if (ret) {
 			printf("LZMA decompression error: %d\n", ret);
 			return ret;
@@ -159,7 +165,7 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 
 		spl_image->size = lzma_len;
 		break;
-
+	}
 	default:
 		debug("Compression method %s is not supported\n",
 		      genimg_get_comp_short_name(image_get_comp(hdr)));
-- 
2.37.1

