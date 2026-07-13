Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D409C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B291784A9E;
	Mon, 13 Jul 2026 12:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="zpyk93Aa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0170C84AA6; Mon, 13 Jul 2026 12:02:57 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0741284A90
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2891409f8f.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936974; x=1784541774; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZRje9XS2T4olQM/NzcsYJOtJLb8OVpbDX5Gkj1rEJIs=;
 b=zpyk93AahdNA2bMC2+0M0awKrO8ygGulTBocMDZJJBT2wqpx7RmgKzFbWJWE1tpmAY
 8PPxhw7ClLK7NftWf0CxgJ2oBFL8vWnuqA8ift9np6UXuIOMJa90C54hXJo6yY6AaWtJ
 t4+QvBlZ4fu+ziEPu3ZHdIr8/r81FXdRt/uIHmGHeQzE35K51AKXdZxEPMP92N9wkCky
 VTMAvkp6BIajeRo8RHosUjO11LoWgaDZ7f7keYaxV+DUWxGYRpRiqXyBkWte2YAosfhC
 gReRAiedsVVnMZMHar7mR5cMwZeQsArQS4TRS2MotBr38Syxt9pMF69Xy42u8rbUUUzb
 hNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936974; x=1784541774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRje9XS2T4olQM/NzcsYJOtJLb8OVpbDX5Gkj1rEJIs=;
 b=Q+QqcT6+3g+Y+On3+C6s3SlqAycL4vvG5TAHGezPONcdzzmCL/eTafIhTX8To2Mr8j
 TESA7Jh9Gh9FHBi7SiNh5u5gGg11oD/AvFxhLocJBnuUudDMjgtYh1ggt/b24i4sUxIJ
 Qo1nabLnCOsuNWafhjT5UvYXKxnx1DjbkmC2o7wxXa/Ps+Xay2YZ+4eEn3RAH3CeM6px
 2mD68BVq2eZsbg9hQJMSQE7CmgaaWdObqZovx9oexb4LiR1/lBSyDLEpgtnVElgrT3/A
 zvMvXWwIUkVD2xExWXc4RF4UQZK6K3/dGN5G/VzXVCR4Vb9QeZ7A/MemBBBSUG6R9VJa
 EC2g==
X-Gm-Message-State: AOJu0Yz9AfGF+DKCkTxD6LeViriPiR6tKGG1qfsRP3n8apJZxMorU4of
 8te3NY0pQwnDX6dykZfurSjYz6ZE36RFYYayu72Max6Ty7Fo+BjAtL9ViW6yciqLDFo=
X-Gm-Gg: AfdE7cks8XadyhFZKQNgczpbIjA19FxDacAEqRfc36ebiQ+jVldnCgGGgF9oikWvv46
 rWur/D+uj7Z5geraQjqUCBXzzVJs4Og8PM4rRJoDtD5g6wRCZ952jpevV2JEAaEMu/Ie2VZmp3E
 NJ/0x0iXWxUaLG6JToUQG0ddQWCsS86RvnrDwwPcpn++7dMTGCSacnP3C0PECgZidXjlxc5rRqA
 XNT84eEugdXK/afe0yP4HAPX7Wl+p5LCEG6/CKBEQgL2xapEzepmHPAUWb1n4goFGtssYBnCYZD
 +8OKAn0c2Vl/3xl3BCORbOgsDxAVvESUAO3386uzXOoJlucVAemzOzrWv8OaBgoFWI6lxZIWtnk
 MJb/NOY4nbKEC2jfs4jodvq9c8w+1GD6BfSoR/k/GGhuB4M7og57qLbCzoVpR8Ngv+1Nd2BccaI
 lL7ZVgkX5GxvSPumpxfibzNEDoWWLEZ62gRmyIsffzZljlbWD2LrWxK8IbeS+YGFg7cjfBzwN+f
 34=
X-Received: by 2002:a5d:5d86:0:b0:47d:fb9e:c3f6 with SMTP id
 ffacd0b85a97d-47f2dc9b97cmr8781367f8f.20.1783936973202; 
 Mon, 13 Jul 2026 03:02:53 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:52 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:43 +0400
Subject: [PATCH 2/7] rockchip: mkimage: Print image information for all
 embedded images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-2-9d23aa08f674@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3609; i=alchark@flipper.net;
 h=from:subject:message-id; bh=WmsU0eQNIScF9MWdTgGWtPcvYfCYbgJ201LD9vTSHLw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD92t4gz59+fa+eZ0n9/+rl/3p59LKX8PxNDJD6WB
 f5WeKp3qWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICptsxh+O97L0KjW0XTMdD4TkG01NFvumsjnwnKTe3Zt2eTtMFe52BGhva2gAu
 hemH/eDwLI1/vZg5+fDlSjzPJdMeNu9dahTZasAIA
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
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 034896d57f80..fe0afc5629b3 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -350,8 +350,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 	uint8_t *image_ptr = NULL;
 	int i;
 
-	printf("Image Type:   Rockchip %s boot image\n",
-		rkcommon_get_spl_hdr(params));
 	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
 	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
 	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
@@ -505,6 +503,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
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
@@ -521,8 +542,7 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
 			return;
 		}
 
-		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
-		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
+		rkcommon_print_header_v2(&header0_v2);
 	} else {
 		ret = rkcommon_parse_header(buf, &header0, &spl_info);
 
@@ -540,15 +560,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
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
2.53.0

