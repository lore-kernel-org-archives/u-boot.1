Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC7AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9504D84ACD;
	Wed,  8 Jul 2026 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LQTUyqDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B3E84979; Wed,  8 Jul 2026 12:35:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65BC843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7CF1A3F60D
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783506932;
 bh=NWRADDYRw2hguB2j1Tk1xLP07dayvLURHc7y9TUjTps=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LQTUyqDZEwN/bYratR+uZHSjHeu3UmDXzmAWthrVFWtRUxuC0YYTuv0QEa9yEloVB
 Sh2KD3n6wPB/yO11tOMWf1jNTmhV8+EJzebWmuruP2vWBfSEl7X64iKNQ93nlk+Jv9
 MW8UA65jLT6f2O8iTorsZuTdLqYKXvssNkq8hzfsXQQonlW7rt778DcDME8q55B+Jp
 sqNeLfD+ES6gy4eHaGFp+cxKopxg4Qbxf7NzKjhhUHbP4keglp8bH1CaMHDvFxPXbW
 plxdzr7iPkqrfoXpihvZpbW9wzttvdooFffs5ctpD+p+fHAIyBmGzvOZ//pgUzDvBR
 reKe7qV7LdPWArOGGrF9G4yxKeRNpWGvep48FmxJdByCXAih643MWQh4IqNp3ez6C9
 G6q93NrURmanOJ7ybVcxcFlJJFkO/FYbkRWHmJv+IGY7jVUun8aXoN4Pd5TOudUOT9
 L2G7oRJf40btvx1t2fZnlMqFMmIATJ0qiXR4k/Xa79f4Fm876xcCwJ080mduNuQWrG
 q3SAKHdqjNnfrUwwl+sop7LHypYhklgEb/KfI7GJs/vlNx0padXT4Oqgu/n0Yt+HyJ
 u17tlz6lOfldEfHooUk1oNGCPKxYT+KSrLrKbRzhu85IEmhZSkL/Dpuddyikqj6sAm
 tVev4YdfQAWLjdt3lygCo6eQ=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37fc66ee6a4so1203511a91.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506931; x=1784111731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NWRADDYRw2hguB2j1Tk1xLP07dayvLURHc7y9TUjTps=;
 b=iDijOZ3Gbq5tYpb4Dck9d0qh7Bg6WEWlCKXUvqjCbtSEZJ5yXaXATS/+/1CF5QJ6AR
 4ZWQ5Zop/McRZnVLlg1NUvhSSIF6RlR+WCoW5e8pzFzj2LrRAMM+q+GZ35vM8ZrZMcOv
 f/Sr9BsuROupgrenXvglOa6Dh4xWFVM3tid/8bYF94jvetHfk6R0p03+zyQ2timxvQYj
 gByitFG8685MWmqa5mIMRYStrKaZULPbG0xEzD+lkCpy9+hn3v/+PyCxM76hPeYl1GVx
 mEq1OvuhNOOes19CpIseOCYz0YJT3bmEcBqS4l/tmPuL9+Ni1sVXaECWckOFHIMJm/01
 6vBA==
X-Gm-Message-State: AOJu0YxEyLO9c+cAtMlqT2rougM4Zb33lmIM5i189jNn1DECKENFirYz
 kw0107Mso7ltmJp0/selml97y5hdBYGvIms8QYKZmkg+DvcIXoCXbJYqDPsHhUUTG6JPqP3IE0S
 +gboMBGYDQj0VKLlPP+FoQVjEoUJA1KVgdJnTNsyJ11hVC5FjwcuCO9bqrJDilc0cBzsfNsRzPW
 w060c=
X-Gm-Gg: AfdE7ckHrATGHgL8pljv2Vuc+4gGlkPQZs+rpH8r+f1kyrN+3teBjrqB/us9bKoGJ4l
 25K0imIAlIxldIDEGGVkfr5zoxaFsRbZcx45pLgw0BbQAYkZVUkOufKa5uO9e+kElf2O2isHItC
 l4V3EEnibLBS4NnumiGx+mbZBxEGgdGJV82eiKFIirKZnwqbJMgsQtONxVaoI/pKvuVyExiVbfm
 HHx3rfjNEWk2Pk/8I1uMyo+6X9MQY9zuDRzwZPRiXDxLTqbVLlSB5ailtc2dD9+JPPYPiG4+5rV
 OuFxQnOfVCJeFY1ixca12MFqHUqvLo2sMYeUOoyaTfaGqNdmOkoxgKLrQXLKu4plJqVYd4R6Kuf
 FZvgbU1SvjSF6z0jZtowA337ipyJDgY9i9zYZN+jZ4E/vHOhFHUKLsB5PRQbWgQ==
X-Received: by 2002:a17:90b:37c3:b0:37f:9ce1:cda4 with SMTP id
 98e67ed59e1d1-38941cc5993mr2081237a91.26.1783506930846; 
 Wed, 08 Jul 2026 03:35:30 -0700 (PDT)
X-Received: by 2002:a17:90b:37c3:b0:37f:9ce1:cda4 with SMTP id
 98e67ed59e1d1-38941cc5993mr2081213a91.26.1783506930509; 
 Wed, 08 Jul 2026 03:35:30 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d12fcd99sm2563896a91.2.2026.07.08.03.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:35:30 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Michael Walle <mwalle@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@gmx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/2] spl: fit: bound the external data size before reading
 it
Date: Wed,  8 Jul 2026 10:34:48 +0000
Message-ID: <20260708103452.49277-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708103452.49277-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260708103452.49277-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

load_simple_fit() loads an image stored as external data by reading
it from the boot device with a transfer sized from the FIT data-size
property. That property is listed in exc_prop[] in image-fit-sig.c,
so it is excluded from the configuration signature and stays under
the control of anyone able to modify the boot medium even when
CONFIG_SPL_FIT_SIGNATURE is enabled. The read happens before
fit_image_verify_with_data() checks the image hash, so an inflated
data-size overruns the destination before the corruption can be
detected. The device-tree overlay path is the sharpest case, because
there the destination is a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
heap buffer.

Pass the size of the destination into load_simple_fit() and reject
an image whose data does not fit before the read is issued. The
check is done in two places: an early bail on len > max_size, then a
bail on the block-aligned size > max_size. The size check is the
mathematically binding one because size is len rounded up to the
device block length. The early bail exists so that
get_aligned_image_size() never runs on a hostile len, where its int
arithmetic would invoke signed-integer overflow.

For the overlay path the bound is exact: the caller passes the size
of its temporary buffer. For the firmware, loadables, FDT and FPGA
call sites the destination is wherever the load_addr field points,
with no defined upper limit at the call site. Those callers pass
CONFIG_SYS_BOOTM_LEN as a conservative ceiling, matching the same
limit spl_parse_legacy_validate() already applies to legacy images.
It is not a tight bound on the actual capacity at the destination,
just a cap that rejects implausibly-sized data.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 common/spl/spl_fit.c | 51 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a..6c4d628ba4b 100644
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
@@ -291,6 +294,23 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return 0;
 		}
 
+		/*
+		 * data-size is excluded from the configuration signature (it
+		 * is in exc_prop[] in image-fit-sig.c), so it stays attacker
+		 * controlled even after fit_config_verify() succeeds. The
+		 * image hash is only verified after the device read below, so
+		 * an oversized value has to be rejected here.
+		 *
+		 * Bail out before get_aligned_image_size() runs on a hostile
+		 * len: that helper does its arithmetic in int and would
+		 * invoke signed-integer overflow on a value close to or above
+		 * INT_MAX. The block-aligned check further down is the
+		 * mathematically binding one, since size is len rounded up to
+		 * the device block length.
+		 */
+		if ((ulong)len > max_size)
+			goto too_big;
+
 		if (spl_decompression_enabled() &&
 		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
@@ -302,6 +322,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		size = get_aligned_image_size(info, length, offset);
 		read_offset = fit_offset + get_aligned_image_offset(info,
 							    offset);
+
+		/*
+		 * info->read() transfers the block-aligned size into the
+		 * destination, so this is the bound that actually matters;
+		 * len was rejected above only to keep this computation safe.
+		 */
+		if (size > max_size)
+			goto too_big;
+
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
@@ -372,6 +401,11 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	upl_add_image(fit, node, load_addr, length);
 
 	return 0;
+
+too_big:
+	printf("%s: FIT image too large (data-size %u, max %lu)\n",
+	       __func__, (u32)len, max_size);
+	return -EFBIG;
 }
 
 static bool os_takes_devicetree(uint8_t os)
@@ -427,7 +461,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		spl_image->fdt_addr = map_sysmem(image_info.load_addr, size);
 		memcpy(spl_image->fdt_addr, gd->fdt_blob, size);
 	} else {
-		ret = load_simple_fit(info, offset, ctx, node, &image_info);
+		ret = load_simple_fit(info, offset, ctx, node, &image_info,
+				      CONFIG_SYS_BOOTM_LEN);
 		if (ret < 0)
 			return ret;
 
@@ -479,7 +514,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			}
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
-					      &image_info);
+					      &image_info,
+					      CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ);
 			if (ret == -EBADSLT)
 				continue;
 			else if (ret < 0)
@@ -687,7 +723,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 	warn_deprecated("'fpga' property in config node. Use 'loadables'");
 
 	/* Load the image and set up the fpga_image structure */
-	ret = load_simple_fit(info, offset, ctx, node, &fpga_image);
+	ret = load_simple_fit(info, offset, ctx, node, &fpga_image,
+			      CONFIG_SYS_BOOTM_LEN);
 	if (ret) {
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
@@ -849,7 +886,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/* Load the image and set up the spl_image structure */
-	ret = load_simple_fit(info, offset, &ctx, node, spl_image);
+	ret = load_simple_fit(info, offset, &ctx, node, spl_image,
+			      CONFIG_SYS_BOOTM_LEN);
 	if (ret)
 		return ret;
 
@@ -890,7 +928,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
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

