Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F498E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67876806DC;
	Thu,  9 Jan 2025 13:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PxqvQplG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9EF80619; Thu,  9 Jan 2025 13:30:48 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A900B80634
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so61447739f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425845; x=1737030645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3c57TphYFYGLzAedjxOsHfLF0vKdO+QjPGZitIqnyQ=;
 b=PxqvQplGXFOMIFJi4SiG0dExG9WxJlZaOh450ACB6o4qgrVIPZyr7YWuBgIEzy0u96
 OgB9UiXzvezrxwv7P6YAUXv1xefYOGxANBW5ZeRkuQtx+dGH/wkRH95mw7ghpPS4J3FV
 D1l/DDC62J2KomMI8YKEF9pw+eqMMYkuv7JXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425845; x=1737030645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3c57TphYFYGLzAedjxOsHfLF0vKdO+QjPGZitIqnyQ=;
 b=AXHjcjPHsCKPFUWl/a0MED6QcDWj/+wbkbW3h0Y0ovqeYPi1ZurMpgJ/yUk/Ag/Joq
 GzjzdeHdQqlCbxCOVrQ7duXq68+bmX6vVQ1NwlOVGQMkeUcwN58PeeBsjjSBFHP9ZyqV
 vhckMqDLVDHQ6IB40+Ec4Qth3MWlKsV/4DxoAcfCdFd/prHF+1im5MC/G0RAoJlpFeEV
 TVED0VXnetjKXWby7deSsfcrWkgS9L4k9zDymRTdxxRa5IVMfHA27Bbw7gVqISm39pLB
 z/ENoUs1+q/cwNvY9lMNZ8q2XDOZbUQLFPFvf6wsAMl6OS49RCSiipRSXzJhZixXtfVx
 mKdQ==
X-Gm-Message-State: AOJu0Yy++12vuIcKK9hsEKPPtxQFS44avA8/c7Z4FsLXTSkQs1BGjiMk
 UiuxLx/Jfzozd5Owy7/SJC59gKHUSRW4FDqoXUAe9E6nrHXZYZ6DWe2Q9wJ4kFuUzyd1F6h7lPw
 =
X-Gm-Gg: ASbGnct95fAqx7sLP8zZ5V6FiEYKjmtl/a5Tmn7Y/MaVmcrrxvqazb3oIO9bUKdFQLA
 66mPBQy4OOEgV5+pCBUwqC95i5UJqEp7nkIYd2pegOI7JJScY0eLyfndSRUT/XP25h2D0ZNvGXv
 soJ4vYrGuOLyL6dU0UNP/kxItFaPtecr4UkoNrFNzy5Cn6TGouw20Jt1gaIHWybLWruU5tcvi19
 s+x/DE4cj3yKHHejFsl9JzGh+Zx3A7Xulh3Sy6p0ygq7c9WcQJoZ63c601TiarbYA6t99e/hQDV
 gtiRF9+ZzE7BUTJr5Q==
X-Google-Smtp-Source: AGHT+IGvpweQjAFIbJe12Njqx/WSVSxJBRoeT6QruYG1iGZQPeByI8CI4pd5YqZkHQmBbf8OAuTiKQ==
X-Received: by 2002:a05:6602:3789:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-84cebf885famr279901039f.5.1736425844851; 
 Thu, 09 Jan 2025 04:30:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/15] vbe: Handle loading from an unaligned offset
Date: Thu,  9 Jan 2025 05:30:01 -0700
Message-Id: <20250109123010.4005298-7-sjg@chromium.org>
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

There is no guarantee that an FIT image starts on a block boundary. When
it doesn't, the image starts part-way through the first block.

Add logic to detect this and copy the image down into place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index c7f09c6d090..02e2c4ae066 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -105,32 +105,41 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	log_debug("load_addr %lx len %lx addr %lx aligned_size %lx\n",
 		  load_addr, len, addr, aligned_size);
 	if (load_addr + len > addr + aligned_size) {
-		ulong base, full_size;
+		ulong base, full_size, offset, extra;
 		void *base_buf;
 
 		/* Find the start address to load from */
 		base = ALIGN_DOWN(load_addr, desc->blksz);
 
+		offset = area_offset + load_addr - addr;
+		blknum = offset / desc->blksz;
+		extra = offset % desc->blksz;
+
 		/*
 		 * Get the total number of bytes to load, taking care of
 		 * block alignment
 		 */
-		full_size = load_addr + len - base;
+		full_size = len + extra;
 
 		/*
 		 * Get the start block number, number of blocks and the address
 		 * to load to, then load the blocks
 		 */
-		blknum = (area_offset + base - addr) / desc->blksz;
 		num_blks = DIV_ROUND_UP(full_size, desc->blksz);
 		base_buf = map_sysmem(base, full_size);
 		ret = blk_read(blk, blknum, num_blks, base_buf);
-		log_debug("read %lx %lx, %lx blocks to %lx / %p: ret=%d\n",
-			  blknum, full_size, num_blks, base, base_buf, ret);
+		log_debug("read foffset %lx blknum %lx full_size %lx num_blks %lx to %lx / %p: ret=%d\n",
+			  offset - 0x8000, blknum, full_size, num_blks, base, base_buf,
+			  ret);
 		if (ret < 0)
 			return log_msg_ret("rd", ret);
 		if (ret != num_blks)
 			return log_msg_ret("rd", -EIO);
+		if (extra && !IS_ENABLED(CONFIG_SANDBOX)) {
+			log_debug("move %p %p %lx\n", base_buf,
+				  base_buf + extra, len);
+			memmove(base_buf, base_buf + extra, len);
+		}
 	}
 	if (load_addrp)
 		*load_addrp = load_addr;
-- 
2.34.1

