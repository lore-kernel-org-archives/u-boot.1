Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74CEC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE31B80792;
	Thu, 16 Jan 2025 02:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E70cJop6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C2080792; Thu, 16 Jan 2025 02:28:23 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1EC807B9
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso34340039f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990898; x=1737595698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNZsQ5R+E0aYPiySZLvaeWNzzNFHEegit2IxlI9/ldw=;
 b=E70cJop6hKnSA0JFhq/NK4X0tlmw7Fn8l2ZNjH3GWu3atTQQaxMqvfsibq2PrPfkcq
 nMggrK8pUUhFo0wAWM8HDkhK+MpGVX+Fp3oiBp+1zwRpWIWUpMsoAJEm95XBi5VSGbU6
 MPU0IXsyP3JNJVjnUKI1h8fitBr9lkEu/8gu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990898; x=1737595698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNZsQ5R+E0aYPiySZLvaeWNzzNFHEegit2IxlI9/ldw=;
 b=sFDLbsjKFeaFv9S+sKrRlvfSQQVAu+yNYjDAPBtfgimXBF4Eoxxg/soWMlm9jotWgF
 xcB9Jjy64npBM/SS+Bz1Sdbrb0GI9bSUjxp2ET3/RkyEZ5RS0HtrYKbABbNMPFN5oyds
 H1+pbX1Zd2ytyV/Pc37k+EgxsJ6dVBxEQCl4y4NdcisWwdyI7WR6Z/OBQzjPjcduHjqu
 rXDP1oXkROGp9tbvoZBKK5p2t+LBxVgmpsyeedPNX7FOKIUtZ3g8SSiZ9LGV1e7DtqiA
 R0hkybjMBObQwp2dNh9bekeScAzVSW3NxlmIr3Kf/IOzxWYZb9ZShmpwA+YP1jvMjn4L
 DHsA==
X-Gm-Message-State: AOJu0YxIQcS2AGJMYczWSE2exXRwHU2vbzCFnJezP/70GfV6uvG5qzwu
 CUXrFgYzgyx1/HSq//qIdxkaF+QUaP/gqO7NZv3jGMggPpjybPml0dd2sncT/WS2Geejiad9swM
 =
X-Gm-Gg: ASbGncv2rTYXX7EtbaUjt2Vp3jw4fBPQSp3HmRgYv+MbGr7zZc36ND16aTfnTtDMu+P
 H7r0sYgAU60yiUZpjyrSJ3/xJBABUHezQbEgDn3kSiFRJnUigGiPJUYPNAY0gpJKIhmRmKBBG8Z
 i/Qsknl9fRpnj8xtV52aVpw2R42MIwFvw6daW5s2WPWP1P6Xuh5CipLSUHQh7iygSn5b+Qox6K/
 w/QoDXhCl5qC31wJRdT0CSkUjCg9ledEj8yKLz5Ah5je41j77e5n6uWJScX0vLiivSOrcLQ60X0
 Rhg6ghfxaJZnTUrJeg==
X-Google-Smtp-Source: AGHT+IGdQbewh30m3LtUnYa2mdIZbQ4uaxynivkXi56XThKxx0xWQ2AxV5LZPXwvGUT6umV6jYh2bA==
X-Received: by 2002:a05:6e02:16c7:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3ce3a88ac8fmr254962835ab.12.1736990897957; 
 Wed, 15 Jan 2025 17:28:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/22] vbe: Support loading an FDT from the FIT
Date: Wed, 15 Jan 2025 18:27:16 -0700
Message-Id: <20250116012723.2820301-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

(no changes since v1)

 boot/vbe_common.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index b935513d44c..30dd18d3c38 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -110,11 +110,11 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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
 
@@ -195,12 +195,16 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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
@@ -234,6 +238,29 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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

