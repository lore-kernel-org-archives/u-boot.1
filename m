Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C56CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 15:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8D5849BD;
	Sun, 21 Jun 2026 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S04htwBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C6B84119; Sun, 21 Jun 2026 16:39:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7707983FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 16:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1703E3F131
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782052793;
 bh=Fsp/XvGzjMwapy2fP4BOH2TfbnPEk9zpjAkR4b1Aj94=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S04htwBA8I02C+vjueRvbPM4V0W3DcEyOWSgMSEeFmdrOOHSZyvBDoRXMT2GzD1Fz
 5BxBP5on4K53exlHTzYTSNcYqsOEl7NvSdcFG7B7fyzBKcvakP/qqRYjf+3zkaDCfi
 2SwE7epg/9EgXwV+JYv3CkSI1094cPpLlCJw3+0J/4J+GCqsDqZAHDvUXGisQXgz8Q
 gU8kWr63e5G+mam7XP7coVndJmm/ZkFuS4E4pHD4o3EJlKB5d/+AB3Jv4tT3dvCph3
 bleT6ANpHz9m55UnMWxRj1wrwpTdBdk8HhBbVVb4kCYdpBtGHw0rkVuw6fOW1Hgnse
 qtmJCCSc07dVqL+DqwhPNXVvK/H+0LDb5/5K6/gxhtB7frqDGUkiopGBkbh9aVKxvD
 0aTELJqyabyrn4wcrtA8O/VDBuujrE18rYurcPydVQ26qsUzPVWWpB6K0OTqxHfSRK
 SrZ+izl9EQAfYvp6RaMe0rqzPwV6/SbvyrK3qP5EKz46ogNwLN0xSOz9FBtGazU921
 1QO7cvnwDstHOAGIEkeHllmpCVunrtUPNLfA5QtsuOz8/2musjTZffxs8TL0+zSMTP
 7rSCfCEm4vmn0X4r/sQHmNgJhsuqdNMjbQfGWbrarJnl5uxYD4hOAdUSZlxRpRQhAH
 2aQVgJpLp/7ULzXEyIb1tESQ=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2347132a12.1
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782052792; x=1782657592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fsp/XvGzjMwapy2fP4BOH2TfbnPEk9zpjAkR4b1Aj94=;
 b=KiLecbkmWE4Lks6gUs4dC7UPo1y/la8XX7EOYBos3xyVDFz0mvKYg9kFUczNwu5EaP
 bLdyDcTZezNKXZmlf3NEG3v++dVU9f9otlVbIsZiFZ3MY/Xrrpf+DqJsxcXQscGEOek/
 88rvJyMSxwoE6TBce3GBkes/gBWq/vgVcK4KNe93UEzj1nREATFTBvq+N6bKbQJ6E1Qi
 uvuXonA9WWIAeqqP6i4gZUMn2PKgn+pWrbvQHdsjN6TlrE3rX62218y/YjQk0qVjjzOn
 fOqquMgP5hcUi2+ZEatk2t501Yhx4myZHmV0ZdGckiOMcawqODGuSa0PCCCRvjRTQXzH
 9dwg==
X-Gm-Message-State: AOJu0YzucnR3qnDAbDuiqz1FmiHKSWOTorMkqbYwl8aBGQq5QrhxOfxH
 7dXfHPNwYjaMGmhF5Hc41CT6qx7cwOiGxfbFlvb/lt2e2F9jT4KdQGYzqw399MxzU02fNLiN5Of
 RKJxxhyYiMZknn3mQ7zn5SC0vNE3cLz4PTTSvff8E8Qe7JEr90jiQMQui4KTQbQEoVsLkxUG8t2
 KJ+Ek=
X-Gm-Gg: AfdE7cmhmpxjlVAeO0+bbqz8SysXQrrGIv+uLN4Mp61YdFS9hWoT9zlUPXjmTaiZuj6
 O/z8Z84j3P+CdUB9MGrF+9tWzhv2HYeEQsJ8Bsq5zhDUXZOzzM1i5rKrlzJb9hWJAUqT1RGNHZI
 A5xnJ1VEiXK54N4CbvGfsVgOMqH+N8/zqDI/r13Mxj1KrpRURGars/R4WHBTMjDiRQyL20JocFY
 oHUoh4LeXPrR4Dkq3u+EYuXDbcI20Nhf0AULUS826JsVzQ7Ia/M0fbJXG5lZmeuPCAD+v56sxUr
 EAuraJd5JglGPhaFHdvW8pLhMEAK3p50eGH2Z10Ss4QssTnPqGcjsNBAyJJgfiisGfN6kgIj+bs
 QGG/E3iB/jmJqUswrsWdQmV+5xaf/L0idqrEyjv0xJFP3N7+AwxFpg8msgljZuA==
X-Received: by 2002:a05:6a20:4391:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3bb324241c0mr12331889637.19.1782052791681; 
 Sun, 21 Jun 2026 07:39:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:4391:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3bb324241c0mr12331874637.19.1782052791324; 
 Sun, 21 Jun 2026 07:39:51 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc31728edsm4485367a12.11.2026.06.21.07.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 07:39:50 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] vbe: bound FIT external-data offset and size before
 blk_read
Date: Sun, 21 Jun 2026 14:39:34 +0000
Message-ID: <20260621143938.2863-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621143938.2863-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 17:24:44 +0200
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

vbe_read_fit() loads a firmware-phase FIT from the trusted firmware area
and then issues a blk_read() to pull in the image, and optionally an
FDT, referenced by the FIT image node. The source offset on the device
and the read length both come from the FIT's data-position or data-offset
property and its data-size property, which live on mutable boot media
and can be controlled by an attacker with prior write access to the
firmware area.

Without a range check the resulting blk_read() can read past the
firmware area on the device and, on the non-SPL path, write an
attacker-chosen number of blocks past the malloc(aligned_size) FIT
buffer into adjacent memory. Only the SPL branch routes through
spl_load_simple_fit(), which hashes the data. The external-data block
reached from TPL or VPL, and from the bootflow path via
abrec_read_bootflow_fw() and vbe_simple_read_bootflow_fw(), runs before
any signature or hash check on the loaded phase.

Confine the FIT-supplied [load_addr, load_addr + len) window to
[addr, addr + area_size] before computing block numbers and lengths,
and apply the same constraint to fdt_load_addr and fdt_size. The checks
are written in subtraction-only form against the trusted area_size so
the comparison itself cannot overflow.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/vbe_common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index a86986d86e9..844100b7ee6 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -278,6 +278,17 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		ulong fdt_offset;
 		void *base_buf, *fdt_base_buf;
 
+		/*
+		 * load_addr and len describe the external data location in
+		 * the FIT, which lives on mutable boot media. Bound them
+		 * against the trusted area_size so the blk_read() below
+		 * cannot read past the firmware area or write an
+		 * attacker-chosen number of blocks past the FIT allocation.
+		 */
+		if (load_addr < addr || load_addr - addr > area_size ||
+		    len > area_size - (load_addr - addr))
+			return log_msg_ret("rng", -E2BIG);
+
 		/* Find the start address to load from */
 		base = ALIGN_DOWN(load_addr, desc->blksz);
 
@@ -321,6 +332,11 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 
 		/* now the FDT */
 		if (fdt_size) {
+			/* Same constraint as above for the FDT region */
+			if (fdt_load_addr < addr ||
+			    fdt_load_addr - addr > area_size ||
+			    fdt_size > area_size - (fdt_load_addr - addr))
+				return log_msg_ret("rng", -E2BIG);
 			fdt_offset = area_offset + fdt_load_addr - addr;
 			blknum = fdt_offset / desc->blksz;
 			extra = fdt_offset % desc->blksz;
-- 
2.43.0

