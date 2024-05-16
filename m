Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC09C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560A088495;
	Fri, 17 May 2024 00:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BCiFXmTx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyV7ewNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3750388497; Fri, 17 May 2024 00:16:52 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55E88847A
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 0A0991140186;
 Thu, 16 May 2024 18:16:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 16 May 2024 18:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897809;
 x=1715984209; bh=RIToTcx8S7EMX/U/a+0E86JecOPTDCi3li8eEj2AIKA=; b=
 BCiFXmTx+EMPvVh2hL9igraVk/JVpoKR+dla2gnRNfzpqkc4iUESqBmZDWoRzmOw
 ch3YwOf+e/N3bE62YG3N87X4r52DVDNG3ecR5o1Oqr0IHiFl4NozRoM8vbtV1n7G
 ESMsoc+lr6z3MvJPl9AJ1FnUMhWFDStzyy6bGCekqH/IiyoLbLCQYtSnJ6o8Op63
 zEId2iWMYUF9dnR9T9lf8qqr7nFLv2R2AVcekmRlPc5MoXalw42PHi6MFXDGSEHz
 264gML/jVtu0KkpIFE5T0V+Bh/ggnxqMHYHtGPe3ELw1nmcem1lHbP6aC1TZeVJF
 HSwkOVOFUWY+XjTp0V6O4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897809; x=
 1715984209; bh=RIToTcx8S7EMX/U/a+0E86JecOPTDCi3li8eEj2AIKA=; b=U
 yV7ewNAlfuN7n0XRu5qD81rTXMXM+lrb7vCsEonC5bOR9EBn8zAPMamaBxj5bHNG
 piDZh2Jm7R6n/Rxt0GBKY3Wnb4Nn+2mj0LSNi5pWeQ/jBn4OSN4tn/NWbiKKD2Yo
 KRu11gAkBr3gS8MkMdxnIXwUdFFWSCJBDlBJUmlMdTBfPkB7JR0AGm2+Vkl1qaKH
 tO/y46X7qTbOO4xFoXd7NuFGGMdcn+D2rb4iqDGT5dlxw77lkzUWSXubnAjxZn1x
 y9vywQnHPnMneszH/uKlE/C9hEMheO0lixVNwaAeqBNlSiyzwrvjzDehk9enH6fw
 kk7bdlgM5IaQPYr/t2Xxg==
X-ME-Sender: <xms:0IVGZvdb4XAg-vwnPiGHIzHMMVUGJFqxRJcQ7y0lGswwnGEDKlSxYQ>
 <xme:0IVGZlMuPsrvSMPxtffFNCo8OuWUIjb16XWcW1GYH2SmDnEvgS5bJeRBb4o0fLJRA
 Oevb6esDOk_OtPcsOE>
X-ME-Received: <xmr:0IVGZoij_J9HltiwKNrStFz92woIVHmCOYoDlpB4f0d0caIlIMpRa5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:0IVGZg89wQ9J6f4C5vpTJ8OUM2VjWU4ysJa4LlrTU1K1XAGFj3Mlfg>
 <xmx:0IVGZrs9Oto1BUpi6sK504fgYVTUf2A65pawOpZgwrBGbIyMI9LeVA>
 <xmx:0IVGZvHmjNEHnzqG60QKkGucZZ_rw8FfSIhqgzHrm_UnJaxPj6e3MQ>
 <xmx:0IVGZiNsRCeXbaUNBCKGbhx_R3bhZ4SauRDEK7kwxoUZfTFbHBF5xw>
 <xmx:0YVGZpK_a-qBak2YiX9l1Q8qu-VAIyUTMaxOYJj4aFJCF5IdkaN4F1DO>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:44 +0100
Subject: [PATCH 4/6] video: bmp: Rework with video_rgb_to_pixel_*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-4-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9710;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=AiJIKmsI55RYZc6lMlOxT37G66wNzSr76seeFsulxzE=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tMGs6QmSeywf+u7MNoxK8q924Wf+9vSkMVL1T/4X
 p23OnBbRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEwk5Rgjw9RryosDcw8J7FPm
 KH9YL5eixOf6v4evWb7wpUZwfFOQO8MfPgtWHgc/Z5/p0Q3bWYMLdQ9ULHx2Y6LMrtkai09enxb
 HDAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Using RGB to pixel conversion function provided in previous
patch to implement frame buffer writing functions.

Massively simplifed the code, also get rid of limitations
on bmp_bpix vs display_bpix.

Test cases are also corrected to refect a tiny change in
color quantization.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/video/video_bmp.c | 201 +++++++++++++---------------------------------
 test/dm/video.c           |   4 +-
 2 files changed, 59 insertions(+), 146 deletions(-)

diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 83380a87fd2b..80c276aaf231 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -17,42 +17,6 @@
 #define BMP_RLE8_EOBMP		1
 #define BMP_RLE8_DELTA		2
 
-/**
- * get_bmp_col_16bpp() - Convert a colour-table entry into a 16bpp pixel value
- *
- * Return: value to write to the 16bpp frame buffer for this palette entry
- */
-static uint get_bmp_col_16bpp(struct bmp_color_table_entry cte)
-{
-	return ((cte.red   << 8) & 0xf800) |
-		((cte.green << 3) & 0x07e0) |
-		((cte.blue  >> 3) & 0x001f);
-}
-
-/**
- * get_bmp_col_x2r10g10b10() - Convert a colour-table entry into a x2r10g10b10  pixel value
- *
- * Return: value to write to the x2r10g10b10 frame buffer for this palette entry
- */
-static u32 get_bmp_col_x2r10g10b10(struct bmp_color_table_entry *cte)
-{
-	return ((cte->red << 22U) |
-		(cte->green << 12U) |
-		(cte->blue << 2U));
-}
-
-/**
- * get_bmp_col_rgba8888() - Convert a colour-table entry into a rgba8888 pixel value
- *
- * Return: value to write to the rgba8888 frame buffer for this palette entry
- */
-static u32 get_bmp_col_rgba8888(struct bmp_color_table_entry *cte)
-{
-	return ((cte->red) |
-		(cte->green << 8U) |
-		(cte->blue << 16U) | 0xff << 24U);
-}
-
 /**
  * write_pix8() - Write a pixel from a BMP image into the framebuffer
  *
@@ -63,33 +27,37 @@ static u32 get_bmp_col_rgba8888(struct bmp_color_table_entry *cte)
  * @palette: BMP palette table
  * @bmap: Pointer to BMP bitmap position to write. This contains a single byte
  *	which is either written directly (bpix == 8) or used to look up the
- *	palette to get a colour to write
+ *	palette to get a colour to write, NULL if it's a pseudo palette with one entry.
  */
 static void write_pix8(u8 *fb, uint bpix, enum video_format eformat,
 		       struct bmp_color_table_entry *palette, u8 *bmap)
 {
-	if (bpix == 8) {
-		*fb++ = *bmap;
-	} else if (bpix == 16) {
-		*(u16 *)fb = get_bmp_col_16bpp(palette[*bmap]);
-	} else {
-		/* Only support big endian */
-		struct bmp_color_table_entry *cte = &palette[*bmap];
-
-		if (bpix == 24) {
-			*fb++ = cte->red;
-			*fb++ = cte->green;
-			*fb++ = cte->blue;
-		} else if (eformat == VIDEO_XRGB2101010) {
-			*(u32 *)fb = get_bmp_col_x2r10g10b10(cte);
-		} else if (eformat == VIDEO_RGBA8888) {
-			*(u32 *)fb = get_bmp_col_rgba8888(cte);
-		} else {
-			*fb++ = cte->blue;
-			*fb++ = cte->green;
-			*fb++ = cte->red;
-			*fb++ = 0;
-		}
+	const int entry = bmap ? *bmap : 0;
+	const struct video_rgb rgb = {
+		.r = palette[entry].red,
+		.g = palette[entry].green,
+		.b = palette[entry].blue
+	};
+
+	switch (bpix) {
+#if CONFIG_IS_ENABLED(VIDEO_BPP8)
+	case 8:
+		*(u8 *)fb = video_rgb_to_pixel8(eformat, rgb);
+		break;
+#endif
+#if CONFIG_IS_ENABLED(VIDEO_BPP16)
+	case 16:
+		*(u16 *)fb = video_rgb_to_pixel16(eformat, rgb);
+		break;
+#endif
+#if CONFIG_IS_ENABLED(VIDEO_BPP32)
+	case 32:
+		*(u32 *)fb = video_rgb_to_pixel32(eformat, rgb);
+		break;
+#endif
+	default:
+		log_debug("Unsupported BPP %d for BMP\n", bpix);
+		break;
 	}
 }
 
@@ -266,6 +234,7 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 	unsigned colours, bpix, bmp_bpix;
 	enum video_format eformat;
 	struct bmp_color_table_entry *palette;
+	struct bmp_color_table_entry pseudo_cte __maybe_unused;
 	int hdr_size;
 	int ret;
 
@@ -293,21 +262,6 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 		return -EINVAL;
 	}
 
-	/*
-	 * We support displaying 8bpp and 24bpp BMPs on 16bpp LCDs
-	 * and displaying 24bpp BMPs on 32bpp LCDs
-	 */
-	if (bpix != bmp_bpix &&
-	    !(bmp_bpix == 8 && bpix == 16) &&
-	    !(bmp_bpix == 8 && bpix == 24) &&
-	    !(bmp_bpix == 8 && bpix == 32) &&
-	    !(bmp_bpix == 24 && bpix == 16) &&
-	    !(bmp_bpix == 24 && bpix == 32)) {
-		printf("Error: %d bit/pixel mode, but BMP has %d bit/pixel\n",
-		       bpix, colours);
-		return -EPERM;
-	}
-
 	debug("Display-bmp: %d x %d  with %d colours, display %d\n",
 	      (int)width, (int)height, (int)colours, 1 << bpix);
 
@@ -354,10 +308,10 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 			for (j = 0; j < width; j++) {
 				write_pix8(fb, bpix, eformat, palette, bmap);
 				bmap++;
-				fb += bpix / 8;
+				fb += bpix / BITS_PER_BYTE;
 			}
 			bmap += (padded_width - width);
-			fb -= byte_width + priv->line_length;
+			fb -= priv->line_length + width * (bpix / BITS_PER_BYTE);
 		}
 		break;
 	case 16:
@@ -365,93 +319,52 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 			for (i = 0; i < height; ++i) {
 				schedule();
 				for (j = 0; j < width; j++) {
-					*fb++ = *bmap++;
-					*fb++ = *bmap++;
+					u16 bmp_rgb = le16_to_cpu(*(u16 *)bmap);
+					/* RGB565 */
+					pseudo_cte.red = ((bmp_rgb & 0xf800) >> 11) << 3;
+					pseudo_cte.green = ((bmp_rgb & 0x7e0) >> 5) << 2;
+					pseudo_cte.blue = (bmp_rgb & 0x1F) << 3;
+					write_pix8(fb, bpix, eformat, &pseudo_cte, NULL);
+					fb += (bpix / BITS_PER_BYTE);
+					bmap += (bmp_bpix / BITS_PER_BYTE);
 				}
 				bmap += (padded_width - width);
-				fb -= width * 2 + priv->line_length;
+				fb -= priv->line_length + width * (bpix / BITS_PER_BYTE);
 			}
 		}
 		break;
 	case 24:
 		if (CONFIG_IS_ENABLED(BMP_24BPP)) {
 			for (i = 0; i < height; ++i) {
+				schedule();
 				for (j = 0; j < width; j++) {
-					if (bpix == 16) {
-						/* 16bit 565RGB format */
-						*(u16 *)fb = ((bmap[2] >> 3)
-							<< 11) |
-							((bmap[1] >> 2) << 5) |
-							(bmap[0] >> 3);
-						bmap += 3;
-						fb += 2;
-					} else if (eformat == VIDEO_XRGB2101010) {
-						u32 pix;
-
-						pix = *bmap++ << 2U;
-						pix |= *bmap++ << 12U;
-						pix |= *bmap++ << 22U;
-						*fb++ = pix & 0xff;
-						*fb++ = (pix >> 8) & 0xff;
-						*fb++ = (pix >> 16) & 0xff;
-						*fb++ = pix >> 24;
-					} else if (eformat == VIDEO_RGBA8888) {
-						u32 pix;
-
-						pix = *bmap++ << 8U; /* blue */
-						pix |= *bmap++ << 16U; /* green */
-						pix |= *bmap++ << 24U; /* red */
-
-						*fb++ = (pix >> 24) & 0xff;
-						*fb++ = (pix >> 16) & 0xff;
-						*fb++ = (pix >> 8) & 0xff;
-						*fb++ = 0xff;
-					} else {
-						*fb++ = *bmap++;
-						*fb++ = *bmap++;
-						*fb++ = *bmap++;
-						*fb++ = 0;
-					}
+					pseudo_cte.blue = *bmap++;
+					pseudo_cte.green = *bmap++;
+					pseudo_cte.red = *bmap++;
+					write_pix8(fb, bpix, eformat, &pseudo_cte, NULL);
+					fb += (bpix / BITS_PER_BYTE);
 				}
-				fb -= priv->line_length + width * (bpix / 8);
 				bmap += (padded_width - width);
+				fb -= priv->line_length + width * (bpix / BITS_PER_BYTE);
 			}
 		}
 		break;
 	case 32:
 		if (CONFIG_IS_ENABLED(BMP_32BPP)) {
 			for (i = 0; i < height; ++i) {
+				schedule();
 				for (j = 0; j < width; j++) {
-					if (eformat == VIDEO_XRGB2101010) {
-						u32 pix;
-
-						pix = *bmap++ << 2U;
-						pix |= *bmap++ << 12U;
-						pix |= *bmap++ << 22U;
-						pix |= (*bmap++ >> 6) << 30U;
-						*fb++ = pix & 0xff;
-						*fb++ = (pix >> 8) & 0xff;
-						*fb++ = (pix >> 16) & 0xff;
-						*fb++ = pix >> 24;
-					} else if (eformat == VIDEO_RGBA8888) {
-						u32 pix;
-
-						pix = *bmap++ << 8U; /* blue */
-						pix |= *bmap++ << 16U; /* green */
-						pix |= *bmap++ << 24U; /* red */
-						bmap++;
-						*fb++ = (pix >> 24) & 0xff;
-						*fb++ = (pix >> 16) & 0xff;
-						*fb++ = (pix >> 8) & 0xff;
-						*fb++ = 0xff; /* opacity */
-					} else {
-						*fb++ = *bmap++;
-						*fb++ = *bmap++;
-						*fb++ = *bmap++;
-						*fb++ = *bmap++;
-					}
+					u32 bmp_rgb = le32_to_cpu(*(u32 *)bmap);
+					/* RGBX8888 */
+					pseudo_cte.red = (bmp_rgb >> 24) & 0xff;
+					pseudo_cte.green = (bmp_rgb >> 16) & 0xff;
+					pseudo_cte.blue =  (bmp_rgb >> 8) & 0xff;
+					write_pix8(fb, bpix, eformat, &pseudo_cte, NULL);
+					fb += (bpix / BITS_PER_BYTE);
+					bmap += (bmp_bpix / BITS_PER_BYTE);
 				}
-				fb -= priv->line_length + width * (bpix / 8);
+				bmap += (padded_width - width);
+				fb -= priv->line_length + width * (bpix / BITS_PER_BYTE);
 			}
 		}
 		break;
diff --git a/test/dm/video.c b/test/dm/video.c
index 7dfbeb9555d1..0da96aec5efd 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -400,7 +400,7 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_asserteq(1118, compress_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -541,7 +541,7 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_asserteq(1118, compress_frame_buffer(uts, dev));
 
 	return 0;
 }

-- 
2.34.1

