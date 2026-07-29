Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84534C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07E4A407C0;
	Wed, 29 Jul 2026 21:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_xfTZhkjNeZ; Wed, 29 Jul 2026 21:52:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C76540723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361934;
	bh=efyHV6KKt3QKvjj4/IY8l3Apqfgh5ZlScOUlesSxOq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiNErEaisf+6j6JDtXemIUCkz4yr3iMj4yl5MpKcQrddxrVAKZPGIf2xNDraUTUqP
	 UHNs2/L3ijMFC3JQkmkbaRdqzX4hGgfpwbykX1IA6Vp27du6ZymefO7roiIpXnScTu
	 X/rJe8ycLZU4TnMNdN4txj2D32cPBd0Tj+YaIA8wUMv7RFHUB9kQAoSS/K/+mEgZ4x
	 uiykkUUlZui+V8DaCGYa/Eb8iFmPriVJLXV/DbY8+/lZTKd9rGW3vz7h+AQ0+qu2yg
	 vU2f0mLf9kBifdhMAqVG88cIMrINbQr0X516CZW0ZD85HaS6VRyCw4TCV6rqeT+JCU
	 cuJPsUScTbLNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C76540723;
	Wed, 29 Jul 2026 21:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B51E350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0FAA4075C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XCdworn9Xr5A for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:47:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C371C40755
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C371C40755
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C371C40755
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C024E803F6; Wed, 29 Jul 2026 18:47:45 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851128494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 18:47:43 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so1842555a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785343663; x=1785948463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=efyHV6KKt3QKvjj4/IY8l3Apqfgh5ZlScOUlesSxOq4=;
 b=SLTZVEdHjyFwryKwU8HuDeOqP2Attaozfd1zvEDwbH7Qx4nZqPHdbgH6YhcQ7b+Xw1
 wMv1mk4MFbYQRL2sH0ygMzxMQg4za1JfGcV4BKR7bIh8ufYJvhXUBVw4k7534Qs81cjb
 rrDp+L7sW0YrXWTyqbeWU5T1fbwMjYRH+XyPQ5m/67PP0uw3HkLAFfT82+SgMgX0s3lQ
 YFpHj+skyaaxl327F+xVYjp46rYlyOzezE4o/Zn35EkfwYBd6fFHqcFCyj/lQm9dpVvt
 yh8TdLt0REIeziyypLIVwdkyqvCE0XGnxzwBpY/3ZvOBOfSlrRveFt4UtyWeH3KPtHVR
 ur3A==
X-Gm-Message-State: AOJu0Yz4pbet6dYOkz+H2XkYqFo1nsmn6ZYYMNmZHcfx0CkmEKTOXaVV
 HONrEi/Z/MTQTJdXQyR9zitzyJcfnpI6tGp9UTPvvITjxaNKm6CtOnwoKaqsNMGDUuE=
X-Gm-Gg: AR+sD1013jaQfRBVYB2O7vTglRPfILolpm4s8uebk1ICFcripi4Vg5s9dXyaocCIk9s
 F7UFoWRorCTfdeeES/PVP4woSxLolccNsFRF8X8YYiGaxyTTpDS0BBF3NzeBnWGA2TSW47QFIir
 GmrTr/qwKRM3d6edNRcXobXbotuqvTUPN1pmheUuvl1mQjY6NI0YWfMHznWm6OZWXpxnCF6kop2
 IXLYriqBAcWO/64kdxSq5OC6IvfT12T3t1YNukgil97C2kdCLTAaWqHt5dFVFibOyQMciQYrq3l
 CALVkOxZfZC0ADWdE3G1qbfNWsGX+zdrWQyJCBqMiN+nLwsgdU+ctUFD3HtmTFlBjOVhVCnBn+N
 qSp+1kGNH7FEpqfUnIvG7gJUeM3JWmSwOKqWOeERcR2xUSR02RmeN/HtehZ4AxV+3Uli4oHVHcm
 hfat8qEUfcaR56pEmT6extucc7kSAcqypIm8N6UHr2URD6oQmDGAbm8Xra/7GN6ixaYR0AhABJa
 I4GHY8pOTZMUMZIoKDBSSRVvld8PxDo5ybabw7qTK7BuAJD6lIUZg==
X-Received: by 2002:a05:6402:52cb:b0:69a:56e1:c51e with SMTP id
 4fb4d7f45d1cf-6a034ab9436mr3655301a12.25.1785343662864; 
 Wed, 29 Jul 2026 09:47:42 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c6c9casm1058292a12.26.2026.07.29.09.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:47:42 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 29 Jul 2026 18:47:01 +0200
Subject: [PATCH v3 1/2] video: bmp: bound RLE8 decode writes to the framebuffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-video-oob-fix-v3-1-21d3412212cf@byteray.co.uk>
References: <20260729-video-oob-fix-v3-0-21d3412212cf@byteray.co.uk>
In-Reply-To: <20260729-video-oob-fix-v3-0-21d3412212cf@byteray.co.uk>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785343663; x=1785948463;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=efyHV6KKt3QKvjj4/IY8l3Apqfgh5ZlScOUlesSxOq4=;
 b=PEEe2ddQ/UIja1UFDjJtSFIh6gRFgaplNlR0lgvOGYj1sIZ7tBJ8k+yp2NSEFHjsrp
 yDfX0tZmgE74bNKyZXhvPpUcK+SDnIb74bFmhwpr4TWtsgEq9dPn1yXwM9fNEpXtfKe+
 v8/PcbPqPUg+xqd7ctizRV4nf6Z8vyQa0hX+SoO9Q+qCBUtz/l8439HX0a/R0O7NlNWU
 vf1B5pOd3EdlivtONm1gZBsy/R0zlrs5pYn9yE2RkdVCu449lzv+PgauJLkVktVhPU50
 8VGYFpVMzAa3egYPk6fmHgDDAUTScz5P5jnkbuQ6LeFOYCg69yVl+3IdOfKEj/P+l8MO
 lXlg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=PEEe2ddQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="PEEe2ddQ"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

video_display_rle8_bitmap() moves the framebuffer cursor fb up by a
full row plus a scanline on each End-Of-Line escape, with no
lower-bound check.  Repeated EOL escapes desynchronise fb from the
scanline index y: after height - 1 escapes y is back in range while fb
has drifted about one framebuffer below priv->fb, and the decoder
writes pixel data before the start of the framebuffer.  The DELTA
escape recomputes fb from an unchecked y as well.  A crafted RLE8
image displayed from the splash-screen or PXE-menu path can therefore
write out of bounds.

Check the cursor against [priv->fb, priv->fb + fb_size) before each
run and reject the image with -EINVAL if a write would fall outside
it.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/video/video_bmp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 1f267d45812..c6710f898da 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -122,13 +122,15 @@ static void draw_encoded_bitmap(u8 **fbp, uint bpix, enum video_format eformat,
 	*fbp = fb;
 }
 
-static void video_display_rle8_bitmap(struct udevice *dev,
-				      struct bmp_image *bmp, uint bpix,
-				      struct bmp_color_table_entry *palette,
-				      uchar *fb, int x_off, int y_off,
-				      ulong width, ulong height)
+static int video_display_rle8_bitmap(struct udevice *dev,
+				     struct bmp_image *bmp, uint bpix,
+				     struct bmp_color_table_entry *palette,
+				     uchar *fb, int x_off, int y_off,
+				     ulong width, ulong height)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
+	uchar *fb_start = priv->fb;
+	uchar *fb_end = (uchar *)priv->fb + priv->fb_size;
 	uchar *bmap;
 	ulong cnt, runlen;
 	int x, y;
@@ -176,6 +178,9 @@ static void video_display_rle8_bitmap(struct udevice *dev,
 							cnt = width - x;
 						else
 							cnt = runlen;
+						if (fb < fb_start ||
+						    fb + cnt * bytes_per_pixel > fb_end)
+							return -EINVAL;
 						draw_unencoded_bitmap(
 							&fb, bpix, eformat,
 							bmap, palette, cnt);
@@ -202,6 +207,9 @@ static void video_display_rle8_bitmap(struct udevice *dev,
 						cnt = width - x;
 					else
 						cnt = runlen;
+					if (fb < fb_start ||
+					    fb + cnt * bytes_per_pixel > fb_end)
+						return -EINVAL;
 					draw_encoded_bitmap(&fb, bpix, eformat,
 							    palette, &bmap[1],
 							    cnt);
@@ -211,6 +219,8 @@ static void video_display_rle8_bitmap(struct udevice *dev,
 			bmap += 2;
 		}
 	}
+
+	return 0;
 }
 
 /**
@@ -267,6 +277,7 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 	enum video_format eformat;
 	struct bmp_color_table_entry *palette;
 	int hdr_size;
+	int ret;
 
 	if (!bmp || !(bmp->header.signature[0] == 'B' &&
 	    bmp->header.signature[1] == 'M')) {
@@ -337,8 +348,11 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 				&bmp->header.compression);
 			debug("compressed %d %d\n", compression, BMP_BI_RLE8);
 			if (compression == BMP_BI_RLE8) {
-				video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
-							  x, y, width, height);
+				ret = video_display_rle8_bitmap(dev, bmp, bpix,
+								palette, fb, x, y,
+								width, height);
+				if (ret)
+					return ret;
 				break;
 			}
 		}

-- 
2.43.0

