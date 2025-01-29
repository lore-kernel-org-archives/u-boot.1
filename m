Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19672C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B4981F4D;
	Wed, 29 Jan 2025 23:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LOmWw3wE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA90809D2; Wed, 29 Jan 2025 23:36:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58A880AE5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738190213; bh=t+4UWt9ntc0rYKA7O0cqJy2J8IPygyERE8lmo5CPUck=;
 b=LOmWw3wErgus+CicI8aG95EgjZyfY2mTv+XUCOgf1SGvYMOiR7SAIpNI53F2CP5T+nbcnhJ3c
 2XIhP0JKqcZmIWDRRjt2+P4kLSxc7pfffA0IanBP6nz+/eTBS1j9x+38xK1qeWiCngjQbD/LO+S
 o2z2ApqmyRLRN2T9cRWxwMpfomrgoD2afaWmx8NI35fl+l484m6tMIHzXa13YO/sinYT+zeQ71z
 dNe6IOrCTID1/Qxj/I5rYLbC6LQVvynD8GwsSAwc4xVDXJznHJbRzMzd+B+ZarA3NNMbNjAZgtG
 cbJ2f60HglivGCqCScm98N9E0Xy/+xU1srP8iBV8LizQ==
X-Forward-Email-ID: 679aad843590a80aa97f8e18
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/6] rockchip: mkimage: Print image information for all
 embedded images
Date: Wed, 29 Jan 2025 22:36:28 +0000
Message-ID: <20250129223641.1888833-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129223641.1888833-1-jonas@kwiboo.se>
References: <20250129223641.1888833-1-jonas@kwiboo.se>
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

The v2 image format can embed up to 4 data files compared to the two
init and boot data files using the older image format.

Add support for displaying more of the image header information that
exists in the v2 image format, e.g. image load address and flag.

Example for v2 image format:

  > tools/mkimage -l rk3576_idblock_v1.09.107.img
  Rockchip Boot Image (v2)
  Image 1: 4096 @ 0x1000
  - Load address: 0x3ffc0000
  Image 2: 77824 @ 0x2000
  - Load address: 0x3ff81000
  Image 3: 262144 @ 0x15000

Example for older image format:

  > tools/mkimage -l u-boot-rockchip.bin
  Rockchip RK32 (SD/MMC) Boot Image
  Init Data: 20480 @ 0x800
  Boot Data: 112640 @ 0x5800

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index de3fd2d3f3c2..ad239917d2bd 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -331,8 +331,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 	uint8_t *image_ptr = NULL;
 	int i;
 
-	printf("Image Type:   Rockchip %s boot image\n",
-		rkcommon_get_spl_hdr(params));
 	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
 	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
 	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
@@ -486,6 +484,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
 	return -ENOENT;
 }
 
+static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
+{
+	uint32_t val;
+	int i;
+
+	printf("Rockchip Boot Image (v2)\n");
+
+	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
+		printf("Image %u: %u @ 0x%x\n",
+		       le32_to_cpu(hdr->images[i].counter),
+		       le16_to_cpu(hdr->images[i].size) * RK_BLK_SIZE,
+		       le16_to_cpu(hdr->images[i].offset) * RK_BLK_SIZE);
+
+		val = le32_to_cpu(hdr->images[i].address);
+		if (val != 0xFFFFFFFF)
+			printf("- Load address: 0x%x\n", val);
+
+		val = le32_to_cpu(hdr->images[i].flag);
+		if (val)
+			printf("- Flag: 0x%x\n", val);
+	}
+}
+
 void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 {
 	struct header0_info header0;
@@ -502,8 +523,7 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 			return;
 		}
 
-		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
-		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
+		rkcommon_print_header_v2(&header0_v2);
 	} else {
 		ret = rkcommon_parse_header(buf, &header0, &spl_info);
 
@@ -521,15 +541,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
 			    init_size;
 
-		printf("Image Type:   Rockchip %s (%s) boot image\n",
-		       spl_info->spl_hdr,
+		printf("Rockchip %s (%s) Boot Image\n", spl_info->spl_hdr,
 		       (image_type == IH_TYPE_RKSD) ? "SD/MMC" : "SPI");
-	}
 
-	printf("Init Data Size: %d bytes\n", init_size);
+		printf("Init Data: %d @ 0x%x\n", init_size,
+		       le16_to_cpu(header0.init_offset) * RK_BLK_SIZE);
 
-	if (boot_size != RK_MAX_BOOT_SIZE)
-		printf("Boot Data Size: %d bytes\n", boot_size);
+		if (boot_size != RK_MAX_BOOT_SIZE)
+			printf("Boot Data: %d @ 0x%x\n", boot_size, init_size +
+			       le16_to_cpu(header0.init_offset) * RK_BLK_SIZE);
+	}
 }
 
 void rkcommon_rc4_encode_spl(void *buf, unsigned int offset, unsigned int size)
-- 
2.48.1

