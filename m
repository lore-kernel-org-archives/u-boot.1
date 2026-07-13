Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A291FC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B41484AA2;
	Mon, 13 Jul 2026 12:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="TM7BKEHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D366284A78; Mon, 13 Jul 2026 12:02:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC45184A7B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso810889f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936971; x=1784541771; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fgqzAb68i9ihlFkgq7cjJ1BNVN2vB2qo/0Yp3oDyDi8=;
 b=TM7BKEHe6vphjEezu13XAlsfdoXjyuziBqSUK3Hh4/Jr2e2foxj0ucYVzoSDdClWoN
 Rc7OPtrh6xiB92K0Fl9Ai5B8Uu/DBdlE6FsAvFytnliaKp1PAVqsiNfzcQ3thkKx0NZC
 c/bOkZcsJ4bjK8lpNo2egI644FsSl4NgSqdWMpW1PJaFoOiv7Zwr73VALdXcm8s4Lif+
 vFdQb44XISgRjo9iLET8/AJzheEdGabtn0ik2OT2CnbApwYlkaEHQmYkJVxsBtNfOYLi
 jw6zPuD8CbpNRy6Xxf925dcAfGKAh/oS3RYIfRse3aaF6RJPxJdIsFxzTpqTKsNoQZr1
 23yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936971; x=1784541771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fgqzAb68i9ihlFkgq7cjJ1BNVN2vB2qo/0Yp3oDyDi8=;
 b=Z1lITaBb6N3nHsPJrx8/yTdiF9z8Jw7EBP0Sz5Dv1FO0HLhASFXekYVNDOeRa0MlNe
 hxWvWJ8+YAPeUqSQ53AF4CEGzGrFkqFGjF6M8Omy+4uJRh6TQKP75N2bJtI+TmkhRt4/
 8HYZS1IUrvjCRMEfBs2zz9rxFS0orxvxLGIaBTpXcKmW1VkpTaMmyymFOxSV52OcNtSV
 ywXMYWmF1g9kYzTf/kDbRB2Te+1kdmcc5pCWF3WvVmWVrq0vmkHNziHdFevnxqJXNAhN
 LrgyglOgvd6yPzxXHEWldcM/oTTCQzwBWW7cCIochXnGztTCPp4IOpHOtnzji6Te2en0
 pzPQ==
X-Gm-Message-State: AOJu0Yyiyw4Dk9ep+6NdIdkBjxUktgm4myc5JsFTnPAI5hMmhFgzTaVL
 i521o9l8mq10HXbbsP6Rmu3xKxvwq3aaVZDOiXylC2gwpIcw/bfWNi7btVZfO7XVLIw=
X-Gm-Gg: AfdE7clyWqB2PyG+vQ4wJ2snUAgmCP7bp5J4mEpz0y19L/L+6YeXyCGxU8JU4jKvCdn
 jIgHF0l6smnqc6pCu81/51RD01De5oUCy8x5t5IzdZT7tYCOFKl8pBiNamDETl4SbVimVqS2+vr
 cnfLeG1aH56AiRB29EXYHABzkvbXIzVoY/UNS4mfd/IBAwrb/cK83Oz2qGnF5OyBWlf/px3s+TF
 usSC4yrvf3R9D4XoLuNjxCHf0PDvKDP/zm7/a8weDVqzb6ZJpz5zoxjBe955ISaBv5sK+H3ocJa
 IvwS/mMpd3d5oChAxztdpyuHWRNLmtjZatMAm9YJs82uX7vvXaShrMW6n9o31YVhMOTxYrPrW5R
 sTkUYgx70550lxZ4QVkxKadS/o11nU91YENHUHAjptV38vtqQ8nfsJXcXLOPEiv13yxq4UfHfJX
 WYQGHnTJpeFPvIh+/b3TUQwMELDUEvD0+s7HnqsiqG5ReViy0SoWUjztL/HuGajO06
X-Received: by 2002:a05:6000:2305:b0:47d:eee8:ec40 with SMTP id
 ffacd0b85a97d-47f2dcd717dmr9212192f8f.38.1783936971052; 
 Mon, 13 Jul 2026 03:02:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:42 +0400
Subject: [PATCH 1/7] rockchip: mkimage: Split size_and_off and size_and_nimage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-1-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4522; i=alchark@flipper.net;
 h=from:subject:message-id; bh=CS0iKPHRZJBCyL76zyAI0FyUDSMXCvIa3G9h0bAjuCk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD/mpr3q2azjZbleWr2XaxVvdgimqhXlfU6552zLw
 TT7+Zo7HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEw1z3pGhrvvT+6xnNYgLWz0arLA/DMZOdGLn/VIxS9/H3h08/35XjGMDFsvzHo
 tXHF13u48zyOblDoK2Br5kpZ13A68+yE4UZ5BlRcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Jonas Karlman <jonas@kwiboo.se>

Split 32-bit size_and_off and size_and_nimage fields of the v2 image
format header into their own 16-bit size, offset and num_images fields.

Set num_images based on number of images passed by the datafile
parameter and size based on the offset to the hash field to fix using a
single init data file and no boot data file for the v2 image format.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index b39777fc0607..034896d57f80 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -34,15 +34,16 @@ enum hash_type {
 /**
  * struct image_entry
  *
- * @size_and_off:	[31:16]image size;[15:0]image offset
- * @address:	default as 0xFFFFFFFF
+ * @offset:	image offset (unit as 512 byte blocks)
+ * @size:	image size (unit as 512 byte blocks)
+ * @address:	load address (default as 0xFFFFFFFF)
  * @flag:	no use
  * @counter:	no use
  * @hash:	hash of image
- *
  */
 struct image_entry {
-	uint32_t size_and_off;
+	uint16_t offset;
+	uint16_t size;
 	uint32_t address;
 	uint32_t flag;
 	uint32_t counter;
@@ -56,16 +57,17 @@ struct image_entry {
  * This is stored at SD card block 64 (where each block is 512 bytes)
  *
  * @magic:	Magic (must be RK_MAGIC_V2)
- * @size_and_nimage:	[31:16]number of images;[15:0]
- *			offset to hash field of header(unit as 4Byte)
- * @boot_flag:	[3:0]hash type(0:none,1:sha256,2:sha512)
- * @signature:	hash or signature for header info
- *
+ * @size:	offset to hash field of header (unit as 4 bytes)
+ * @num_images:	number of images
+ * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
+ * @images:	images
+ * @hash:	hash or signature for header info
  */
 struct header0_info_v2 {
 	uint32_t magic;
 	uint8_t reserved[4];
-	uint32_t size_and_nimage;
+	uint16_t size;
+	uint16_t num_images;
 	uint32_t boot_flag;
 	uint8_t reserved1[104];
 	struct image_entry images[4];
@@ -351,17 +353,18 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 	printf("Image Type:   Rockchip %s boot image\n",
 		rkcommon_get_spl_hdr(params));
 	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
-	hdr->magic   = cpu_to_le32(RK_MAGIC_V2);
-	hdr->size_and_nimage = cpu_to_le32((2 << 16) + 384);
+	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
 	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
 	sector_offset = 4;
 	image_size_array[0] = spl_params.init_size;
 	image_size_array[1] = spl_params.boot_size;
 
 	for (i = 0; i < 2; i++) {
+		if (!image_size_array[i])
+			break;
 		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
-		hdr->images[i].size_and_off = cpu_to_le32((image_sector_count
-							<< 16) + sector_offset);
+		hdr->images[i].offset = cpu_to_le16(sector_offset);
+		hdr->images[i].size = cpu_to_le16(image_sector_count);
 		hdr->images[i].address = 0xFFFFFFFF;
 		hdr->images[i].counter = cpu_to_le32(i + 1);
 		image_ptr = buf + sector_offset * RK_BLK_SIZE;
@@ -370,6 +373,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 		sector_offset = sector_offset + image_sector_count;
 	}
 
+	hdr->num_images = cpu_to_le16(i);
+	hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));
 	do_sha256_hash(buf, (void *)hdr->hash - buf, hdr->hash);
 }
 
@@ -516,10 +521,8 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 			return;
 		}
 
-		init_size = header0_v2.images[0].size_and_off >> 16;
-		init_size = init_size * RK_BLK_SIZE;
-		boot_size = header0_v2.images[1].size_and_off >> 16;
-		boot_size = boot_size * RK_BLK_SIZE;
+		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
+		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
 	} else {
 		ret = rkcommon_parse_header(buf, &header0, &spl_info);
 
@@ -533,8 +536,9 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 		}
 
 		image_type = ret;
-		init_size = header0.init_size * RK_BLK_SIZE;
-		boot_size = header0.init_boot_size * RK_BLK_SIZE - init_size;
+		init_size = le16_to_cpu(header0.init_size) * RK_BLK_SIZE;
+		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
+			    init_size;
 
 		printf("Image Type:   Rockchip %s (%s) boot image\n",
 		       spl_info->spl_hdr,

-- 
2.53.0

