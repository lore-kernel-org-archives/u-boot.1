Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFDCCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 20:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4F5847C3;
	Thu, 18 Jun 2026 22:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Wa8I9QWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A51E847C3; Thu, 18 Jun 2026 17:48:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244078005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D10DD3FA72
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781797686;
 bh=g3ISJClffV3pUkqf0hIV3yf9RRWWaq+9pjXt2JeqDaw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Wa8I9QWyF17byCR6FYVA/z9yMKD4HUldvGGGvIV1TY7Yk8cA8sBz3pnKAyfN/tEFc
 +CiFW+cUu3M4FOqZkK4PqlGUAU1wxQtp+kH3FyOi+SzhGoDBbD9DCob/yKVntvy+yU
 /mKt/L1EkEFDD16vGhfo9OfeS9FqQbCg+78+QxjvDq8jNplEWWSfEMZ6NevbFc96MJ
 yp9ueJAM6crgfawWc7ZX5nGp9yUBsP0u5ST9fiWCLh5Fqw4HRWldtHDcxLtY9D4CyX
 T5szhL+fO57gxSElL4OIbeCKopdegMVIjQAruZ5pz/kbwe8gutihYh4znGHsTv7F/0
 oH365ooViYRBcd+v47ee5mftIGnHGNH9/F9RvwJLv5gQGWUssTQT+5N47P+Ldu+6xx
 nAov3cmPPBRhpXahoPTYgl/lDYpEs/AdZWPaq1oPHBRL7+Zqc0Ba2ijQt+fi9QKy8f
 Iv8EmGR/8lw0g7xue3jul8pWXyhtuJCg7cRp+YlNt7khJVLRvWAoeHkoQJRlbJxNXw
 YTJnPKVBPO0pg2PjmIbIOzGU1yzVNfZHMH0EwhPlwQKsQQL/inw9cvuLYdu2piXVWi
 LeuI6FRNc4R24dEnNVUBbYy2qRzN2mKpmnoclPxaYppWGSMDOWsJik0Xq2Kju0FzK0
 B3Q36tB4FgGz9rOqvnrmjTiA=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so823251a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797685; x=1782402485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3ISJClffV3pUkqf0hIV3yf9RRWWaq+9pjXt2JeqDaw=;
 b=Y201yMPQo1UxcDOHxwxaPKiZQmFn+eA+RypR/05KKI92wF2qThn2EDHkGCjfVHfRGd
 fiOKj+m9tVvHsfcbBjUUKDzQTGNjB1xJFAiizY13PpZb5lmiDIhpDYJQXfatC8okVsrN
 7lV+yAFeIvnS3d51ESnydQZEkFKA+xUyB+xqoTQyQgwGPjFm67cfTZRsuiBU3LWDoFkr
 mjAjS8F4LsE22JujplD8lvcUuYj5+PHGCRW89Gb+OCWc8JpiPDP/ktE6zMV/bemGbW7N
 tR9ZtfUPPb4XfsQgUJzY3WioLX7+PwHHTghRwaZJV3onGxOhDdLIQ2yjOArXHDoqbgr1
 7h1w==
X-Gm-Message-State: AOJu0Yw/U5vxg0bKwK61XKPV9Tt6tDsq3oHsMUcOyocJusz2ZyzIjV2M
 yJa63aose3oIqDSs/2UewUoDPVgZU7ZY9FBTf4iXjDb2mkrzHpLzBtuoSL+IR1aOa6NA/uq7iEf
 vS26ex+1IkAj7gWy7biBXRp327g7/jj82rbBuR3aqwOl0ncaKfy1/qP+ahj21vyeUJ4cEx2VR50
 6XuDFeuw==
X-Gm-Gg: AfdE7cm9G+OWXRT57k+KkFuMnNbTuGg+Y48t65T4dOpwXANpv7Y5G88mD2hrxwkkhzu
 9LcggdzbXjAcKMk+R2W8Tq2+S6lmpNR5prYJp4cEQjy0vTD5RBYYsdZMoccVtpW4Iwq64WUoVHR
 qrrUcW1YOhxZaF68bWidrleYOc0zEgN3T19WFQZh56ff6qvxAb56IvY2WQRwy4+rF6PrN3UZ4Gk
 adhWj1r4LxHuSi9ZwU/43QMm+3A3AvSXXU5e+eNtSuu2N38Y9DtK2LLa5R6gRJtVE/naEAyj44N
 bcrGg7L7dl4JLVwCk8ZSu2SO5+Zcy2533r55wanu/p29iWNWkynsRRl0//GI6604bCmZrYhokk4
 x2KBdoqx6QwVZLYZmfBLcF2Boktu8hruNjnQS/IszLIxj9h/D4P0lNREYTbsraCuwj6fDUzaXzI
 hivI0k
X-Received: by 2002:a05:6a00:2342:b0:842:21f0:5113 with SMTP id
 d2e1a72fcca58-845245451b1mr10347994b3a.24.1781797684548; 
 Thu, 18 Jun 2026 08:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:2342:b0:842:21f0:5113 with SMTP id
 d2e1a72fcca58-845245451b1mr10347955b3a.24.1781797684126; 
 Thu, 18 Jun 2026 08:48:04 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b049120sm19860127b3a.55.2026.06.18.08.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:48:03 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anshul Dalal <anshuld@ti.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut <marek.vasut@mailbox.org>,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 1/2] spl: fit: bound the external data size before reading
 it
Date: Thu, 18 Jun 2026 15:47:46 +0000
Message-ID: <20260618154750.180675-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618154750.180675-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 22:42:13 +0200
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

load_simple_fit() loads an image stored as external data by reading it
from the boot device with a transfer sized from the FIT data-size
property. That property is listed in exc_prop[] in image-fit-sig.c, so
it is excluded from the configuration signature and stays under the
control of anyone able to modify the boot medium even when
CONFIG_SPL_FIT_SIGNATURE is enabled. The read happens before
fit_image_verify_with_data() checks the image hash, so an inflated
data-size overruns the destination before the corruption can be
detected. The device-tree overlay path is the sharpest case, because
there the destination is a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
heap buffer.

Pass the size of the destination into load_simple_fit() and reject an
image whose data does not fit before the read is issued. The data-size
property is read into an int, so a value with bit 31 set arrives as a
negative number, and comparing it as an unsigned quantity rejects that
case as well. The block-aligned transfer length is checked too, because
info->read() moves data-size rounded up to the device block length.

Callers that load into a memory region pass CONFIG_SYS_BOOTM_LEN, the
limit spl_parse_legacy_validate() already applies to legacy images. The
overlay path passes the size of its temporary buffer.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 common/spl/spl_fit.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a..224fd97d680 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -204,6 +204,9 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *		If the FIT node does not contain a "load" (address) property,
  *		the image gets loaded to the address pointed to by the
  *		load_addr member in this struct, if load_addr is not 0
+ * @max_size:	maximum number of bytes that may be written to the
+ *		destination; an image whose data exceeds this is rejected
+ *		before it is read from the device
  *
  * Return:	0 on success, -EBADSLT if this image is not the correct phase
  * (for CONFIG_BOOTMETH_VBE_SIMPLE_FW), or another negative error number on
@@ -211,7 +214,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  */
 static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			   const struct spl_fit_info *ctx, int node,
-			   struct spl_image_info *image_info)
+			   struct spl_image_info *image_info, ulong max_size)
 {
 	int offset;
 	size_t length;
@@ -291,6 +294,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return 0;
 		}
 
+		/*
+		 * data-size is excluded from the configuration signature (it
+		 * is in the exc_prop[] list in image-fit-sig.c), so it remains
+		 * attacker-controlled even after fit_config_verify() succeeds.
+		 * The image hash is only verified after the device read below,
+		 * so an oversized data-size has to be rejected here. The value
+		 * is stored into an int, so one with bit 31 set arrives as a
+		 * negative number; the unsigned compare rejects that too.
+		 */
+		if ((ulong)len > max_size)
+			goto too_big;
+
 		if (spl_decompression_enabled() &&
 		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
@@ -302,6 +317,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		size = get_aligned_image_size(info, length, offset);
 		read_offset = fit_offset + get_aligned_image_offset(info,
 							    offset);
+
+		/* The block-aligned read size must also fit the destination */
+		if (size > max_size) {
+too_big:
+			printf("%s: FIT image too large (max %lu)\n",
+			       __func__, max_size);
+			return -EFBIG;
+		}
+
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
@@ -427,7 +451,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		spl_image->fdt_addr = map_sysmem(image_info.load_addr, size);
 		memcpy(spl_image->fdt_addr, gd->fdt_blob, size);
 	} else {
-		ret = load_simple_fit(info, offset, ctx, node, &image_info);
+		ret = load_simple_fit(info, offset, ctx, node, &image_info,
+				      CONFIG_SYS_BOOTM_LEN);
 		if (ret < 0)
 			return ret;
 
@@ -479,7 +504,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			}
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
-					      &image_info);
+					      &image_info,
+					      CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ);
 			if (ret == -EBADSLT)
 				continue;
 			else if (ret < 0)
@@ -687,7 +713,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 	warn_deprecated("'fpga' property in config node. Use 'loadables'");
 
 	/* Load the image and set up the fpga_image structure */
-	ret = load_simple_fit(info, offset, ctx, node, &fpga_image);
+	ret = load_simple_fit(info, offset, ctx, node, &fpga_image,
+			      CONFIG_SYS_BOOTM_LEN);
 	if (ret) {
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
@@ -849,7 +876,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/* Load the image and set up the spl_image structure */
-	ret = load_simple_fit(info, offset, &ctx, node, spl_image);
+	ret = load_simple_fit(info, offset, &ctx, node, spl_image,
+			      CONFIG_SYS_BOOTM_LEN);
 	if (ret)
 		return ret;
 
@@ -890,7 +918,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			continue;
 
 		image_info.load_addr = 0;
-		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
+		ret = load_simple_fit(info, offset, &ctx, node, &image_info,
+				      CONFIG_SYS_BOOTM_LEN);
 		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
-- 
2.43.0

