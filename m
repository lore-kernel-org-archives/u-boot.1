Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36F1C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932258723C;
	Sat,  4 Nov 2023 21:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHc9AtnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29148708A; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFB186F23
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6707401e22eso19924286d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130282; x=1699735082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iyFe6XMu0OToPyVaPaH8JwS5ABm+HyvmHnD9ORsvd4=;
 b=LHc9AtnVre4MUpqALq1CdF2DCjyp85s1ua9WCNkLRBpAwboovLVpFAmKZdyRiOGthm
 8WjLYP4Kwv/KsKH5yfuAq2j6QsmjtSpsEQxgpyT/ovf26oLRCnn53lw0Bb45opsZ3C4C
 8uXRIPHFPbiQf6FayKjQ1RsjUxpHrYyIOswiVsHbrqhB/M/jrT6sTqA/rgIwFx4cMMhQ
 AzBcOvMnkNnQMX3MWyTUBcM/PzQJUchOkk9ZqPFFHW/3mqReBuN++iw1+Tzf08C4c2j6
 MSYL5c33lXkgRHZMtkuR0/iZoASr1YNoSVE9xov0dNOoOKLYALFDt3WqqyWHsyF+JAxL
 Xa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130282; x=1699735082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iyFe6XMu0OToPyVaPaH8JwS5ABm+HyvmHnD9ORsvd4=;
 b=FJayW7NobD7YqDLgySMKYxocRxtVxUhC4rgh9PZgsoBNj7EU/rYQJ9H06TGUjhOKwP
 jlTEakLcwZRlRTP5STAGWNZt2a9vikzhvznpqUXzqU2Zp0i9Z1q0jUDexPq4pauXcSAx
 9Pr86I10UA2eK6QQcUzSklDeB+nYGOLgWYm7Vno0ThYt2RshtvI13m96GTghK8dAY5K7
 CJJ0NS/JI/7hhichtNTUf43RQHLnifbyqOoFVA5AzN8lT6CZDQHE2LL236Jh/adVhPhO
 gWIz+Gjl+m+rMlivduUxzYJcgATm94eF/iAGqoBWeUPvz+h7M+UKpcU1TWMgMaGzcMr4
 sHuw==
X-Gm-Message-State: AOJu0YwdomLiKCVQkWapQ5R+JmjbCzfi1IgqabQ8m35jXoJg1id/m0MM
 poSO3z25hd3gxiYIAIg7Htz9cx6On0tPDw==
X-Google-Smtp-Source: AGHT+IEEw4AuIigIst85NyJFrp/wl2cx54vnFPoyLak9t5T6TCK9vBBfZ4mI0bs9QP0tyuabGBmBdQ==
X-Received: by 2002:ad4:4ee3:0:b0:66d:49aa:6844 with SMTP id
 dv3-20020ad44ee3000000b0066d49aa6844mr35554558qvb.19.1699130282173; 
 Sat, 04 Nov 2023 13:38:02 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g9-20020ad45109000000b0066cf2423c79sm1922478qvp.139.2023.11.04.13.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:01 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 05/15] spl: legacy: Honor bl_len when decompressing
Date: Sat,  4 Nov 2023 16:37:43 -0400
Message-Id: <20231104203753.1579217-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

(no changes since v1)

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

