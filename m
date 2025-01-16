Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8ADC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0945B806FD;
	Thu, 16 Jan 2025 02:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y9lvGYVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73B18077D; Thu, 16 Jan 2025 02:28:16 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C298033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce8c069840so3094145ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990892; x=1737595692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVy7ZtYJB64A3Hg6vV5rJXVNneVFC1JzrTNS5yjX/e4=;
 b=Y9lvGYVCZeqVZBtOn5gZM0tH601ARgHfA1eX7W1fIHVkSUAD8pu1O/K4O01n+JDj2T
 kVKt87ixxzSYhXq+pzaMEilZcMCgoakrPECieHRQGzOEfBysdvWwBuk4Ggt8180XEuED
 buC5zEuslgVcsOXLy9Vc0p0stfgyeahGDx2lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990892; x=1737595692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVy7ZtYJB64A3Hg6vV5rJXVNneVFC1JzrTNS5yjX/e4=;
 b=N7+v3CT9niVAZQJiki2kBFbjmtmtxMdaTpuQ/i7KaKl+MYfdtuenTYJsVMZf3d9Jl1
 NpSz3tDs3DcKgPZ/KG3KXrzUc19SJYU2TE5ziYB9NaB6fw29N1U/8bkOSLUdgO4Ug26C
 zW7GI3yVwWuJOOv13KJwc0CUTwyht6sn0IbgcPAkKLQfFk/GtBHk2LAFJ5Le7gBEDEr3
 TzEdcbBvoG0quhIwfuqFOY4lFT7XcB+Ugoz58VolCiauB97+ZSolmQu99D1y+qqYIGvy
 s3tBA6QlLHq4iBDP4np3t/JdcpakQGTLjmdnO0Q2smYHcjo9hjLJZ4+wjMhX2etb20JY
 l0SA==
X-Gm-Message-State: AOJu0Yzq7WwnOioZMkHPyGgKzMMiISWJiFLBu3EJVk5S5dz/eSETB7ef
 CAKDQZ2J511Htd+aYX26qJCm7SK83DEwdFDJD6G/SGBLmV1ixRNOZnGrFvv+pbxOJbVDJ/5Nczs
 =
X-Gm-Gg: ASbGncuyR2QmNbPvTmQ8ThJrIES0W5fad0FNAR3HHJCIFRtiJw3JJs4W0OVIWxESBMF
 9+vv/VZwe9YVpnJCqiqXtuKZEzF6PyUgetxvQA96Z7j2h7YTetXmNRKlyKrS7AnkdwlCngd/R2D
 M9xN80NOeZ0r1NoO2BVSU40edSCS3wbOpeBrwhteuI/tB/ALxLuKbIyopFo0ENRqgTxIP7LXz+7
 K3YDsSr/j2E3pn8gHqe7SqIkEb6iGm4kyZGkIkW/H0LkKH0fiIqBt3MVj7AcbaocHL8ZBsCsfyS
 uGi/G6w7Zg9pwYADQQ==
X-Google-Smtp-Source: AGHT+IFZyMV6V2Gaubcy2ZlKP01I8GXee+KF7Fs2zWSk8gHsyqw+ewWoDoDYNGU/KvBPfkuB3W6O9w==
X-Received: by 2002:a05:6e02:1705:b0:3ce:8aa2:3fb1 with SMTP id
 e9e14a558f8ab-3ce8aa2408dmr42413975ab.22.1736990892468; 
 Wed, 15 Jan 2025 17:28:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/22] vbe: Handle loading from an unaligned offset
Date: Wed, 15 Jan 2025 18:27:14 -0700
Message-Id: <20250116012723.2820301-14-sjg@chromium.org>
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

There is no guarantee that an FIT image starts on a block boundary. When
it doesn't, the image starts part-way through the first block.

Add logic to detect this and copy the image down into place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 0f5e0e4ca98..8fe278ba1a9 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -192,32 +192,41 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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

