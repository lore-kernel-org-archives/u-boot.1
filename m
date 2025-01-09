Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BDFE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2478C8066C;
	Thu,  9 Jan 2025 13:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i7zh3t+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E8280634; Thu,  9 Jan 2025 13:30:55 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFB2806E8
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a8165cfae8so2247415ab.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425851; x=1737030651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGs3nq6kANiLPGW+F9wPLF7r362HcWGtDTBfrHMOnog=;
 b=i7zh3t+7QmSQ5AO2JVLZV690Rto6p5cyJhagv2R+TYw92vabxIHkXp5ZMA5xLtjrMq
 7vAM8zKZUEg9JjIPqXEbPmONn39t7877HaIumR6PC6HNy+SQZO5acN5VNzj00XrpRZKI
 uxsU8bhrsa2P9VDy8nmnL7dkmuK+oSy8WMOWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425851; x=1737030651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGs3nq6kANiLPGW+F9wPLF7r362HcWGtDTBfrHMOnog=;
 b=rYSJ6nPlI/yQ9ISdOySGerM5Xm7mtY2UN7DF9wYUmHwxw4asJd6chL7/nD+W8dtBCE
 6Ir7IbY08Oj6dXdb7/l3/vidYOsBAcf6JbcRb/RZvClIedx/XNegM3Zb0MP1j529rjYq
 iJp1/AX/ztLMTPU1LnTroDIzUYS4x2www/9ZKXipwlWIxDQOEndxepOm4mbDTqBKX+6o
 onkQytwoe7ED9bATMQSIYe8wZssCwUFyP484AhhvPEKzs7O2yIniceu4yj0occYx2ODi
 s3zV7uq5QRjhPNT/Gu1+exeIHTy7LiCygViLn5vlzjXkJ+dOsObQ26hl44EomkRLdpiA
 f45w==
X-Gm-Message-State: AOJu0Yyja1suCfYKSYF4q4pyTe5te/fNL8Stj8nTryQ+dn0mtP7aAN1h
 mUsj8e7BSQYrsNsYs1Eip93K+LuNYXszyao+SgRI26oemzDvc18aFtSHUl/z2URaxdEpBIcIbeE
 =
X-Gm-Gg: ASbGncvOffeYN0jKmcTTJrfwCSPI1KY/9c8uKc2MGyiNC70uWDCLRf5k0kb7NLWtw2v
 3OstviqXPeFIKAu6OcIcWvO+Zv6XX3MNadcIlH7cIvooJRreyux6+I0utVftv/05b08GAzRP5hr
 hiu3sGP3F86wKDotFkKJdmO2YGgp14NIcLqq9YjeSctX8+BGMjzw7LwPGsd4tL4LOF4ie/xJR8v
 qXFbBUGvF/m9w2Mr7lcPdnZNNN+Rey6pcrKDEg+yfXxDXFA7rdyyeGiSQ9yajxXA0mr36bs+ftZ
 Tw60+4jpxgiHhRMcmg==
X-Google-Smtp-Source: AGHT+IGzBa+H1ASt3FH42k7V4KkuoaLJUkQO0VgmwnkOr+EdYbemC7ODUZYQ6DFrhKiVYmyZ9fh0PQ==
X-Received: by 2002:a05:6e02:1c87:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3ce3aa74970mr51465645ab.21.1736425851319; 
 Thu, 09 Jan 2025 04:30:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/15] vbe: Support loading an FDT from the FIT
Date: Thu,  9 Jan 2025 05:30:03 -0700
Message-Id: <20250109123010.4005298-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

In many cases the FIT includes a devicetree. Add support for loading
this into a suitable place in memory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 4b297e780b3..742e754b133 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -23,11 +23,11 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 {
 	ALLOC_CACHE_ALIGN_BUFFER(u8, sbuf, MMC_MAX_BLOCK_LEN);
 	ulong size, blknum, addr, len, load_addr, num_blks;
+	ulong aligned_size, fdt_load_addr, fdt_size;
 	const char *fit_uname, *fit_uname_config;
 	struct bootm_headers images = {};
 	enum image_phase_t phase;
 	struct blk_desc *desc;
-	ulong aligned_size;
 	int node, ret;
 	void *buf;
 
@@ -108,12 +108,16 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	node = ret;
 	log_debug("loaded to %lx\n", load_addr);
 
+	fdt_load_addr = 0;
+	fdt_size = 0;
+
 	/* For FIT external data, read in the external data */
 	log_debug("load_addr %lx len %lx addr %lx aligned_size %lx\n",
 		  load_addr, len, addr, aligned_size);
 	if (load_addr + len > addr + aligned_size) {
-		ulong base, full_size, offset, extra;
-		void *base_buf;
+		ulong base, full_size, offset, extra, fdt_base, fdt_full_size;
+		ulong fdt_offset;
+		void *base_buf, *fdt_base_buf;
 
 		/* Find the start address to load from */
 		base = ALIGN_DOWN(load_addr, desc->blksz);
@@ -147,6 +151,29 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 				  base_buf + extra, len);
 			memmove(base_buf, base_buf + extra, len);
 		}
+
+		/* now the FDT */
+		if (fdt_size) {
+			fdt_offset = area_offset + fdt_load_addr - addr;
+			blknum = fdt_offset / desc->blksz;
+			extra = fdt_offset % desc->blksz;
+			fdt_full_size = fdt_size + extra;
+			num_blks = DIV_ROUND_UP(fdt_full_size, desc->blksz);
+			fdt_base = ALIGN(base + len, 4);
+			fdt_base_buf = map_sysmem(fdt_base, fdt_size);
+			ret = blk_read(blk, blknum, num_blks, fdt_base_buf);
+			log_debug("fdt read foffset %lx blknum %lx full_size %lx num_blks %lx to %lx / %p: ret=%d\n",
+				  fdt_offset - 0x8000, blknum, fdt_full_size, num_blks,
+				  fdt_base, fdt_base_buf, ret);
+			if (ret != num_blks)
+				return log_msg_ret("rdf", -EIO);
+			if (extra) {
+				log_debug("move %p %p %lx\n", fdt_base_buf,
+					  fdt_base_buf + extra, fdt_size);
+				memmove(fdt_base_buf, fdt_base_buf + extra,
+					fdt_size);
+			}
+		}
 	}
 	if (load_addrp)
 		*load_addrp = load_addr;
-- 
2.34.1

