Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A3506087F;
	Tue, 28 Jul 2026 13:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jR_H_98nyPp; Tue, 28 Jul 2026 13:00:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33A4E6090B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243615;
	bh=MMVe6eQUYDiQ8zT64JUpKblaFQRRNTPU8POUWINNM8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pyLE1f0kYMdt8S0vv+upDeUofMRoaz4Bn0KB9OKupMjbNUcVQUUe0Lms0acy6du+a
	 VyAK/AF5apTizKoOaXnADsCndsZfW/Ah0uWioSWPtGGc9fDbefrxucKqIYfh9Fjwny
	 FOsXISsBcpXFn4tXF2udrQGDRoKDw4rXOeF9NoPLXdiFTfbu6Fe+XIEOStkn4fItmH
	 1oAkU62D6324j4v93SQveVJ64vFtiQtqZogljHqE6HXgXXCFAs38TE/AE0HMXt53Y+
	 Z9aImSdgeFn/A4guocXuVRmjJ6lqvZDajDcktcl+NT5pWBVosOEcI9MZqbqEzTHj0t
	 QoSuW/tAmJiMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33A4E6090B;
	Tue, 28 Jul 2026 13:00:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EE903B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 513AE8127C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZOYmVfU_twS for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:43:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 63D5D81274
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63D5D81274
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63D5D81274
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D395D82991; Tue, 28 Jul 2026 09:43:16 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D563C84873
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 09:43:14 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a02aedabadso993363a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224594; x=1785829394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MMVe6eQUYDiQ8zT64JUpKblaFQRRNTPU8POUWINNM8c=;
 b=gCyac8xfXBdQmapTMsjBymptjvOuWlhTM+B0PCbMpTBFEn5s3fJ17DB1ddJ8mI+vAk
 iJbBKgbrvTgxfVergtYzurHiBHcr1oes0YVXaCfnEevNVOuIKlR96jqYNgfTYjDlljTx
 eA5wf1t4kiEZef4nalg6BsGW2q8TVwvp9Z8rrmYbYs5d1K48k6RzMs8T01NLVsAjHLtK
 prom5tjBfVyIoQ/gfbOmfXwELYI+EL4fNw4lJNe+OURoid9a6TtEyLxTodLZGoVSpWxW
 kvgJK2QQe7HrFrLy6t4wgbukt7/Je6vd1Tuukrd173gWMWE6Dc1GqpWEsrr5XTW9yP2d
 WvGw==
X-Gm-Message-State: AOJu0YycB9Cjh4/KNSqQFtt1gwuqan8T/8UNdACGGf8WoGOilJkGZdL3
 +Ip7ohupzFNkASIG5ahMpn1Oz2hOBC5o67ML07c+N0N1ghftEEzWpzLzKAc/cAETXaY=
X-Gm-Gg: AR+sD12EhPTmjkuuwnd1mP0ctHQdf0VVciDX3MWpk76yU9ki/Y7VtbPvyaeFD+O5/rg
 S/snkB0qZFvhZqpYtNrOCJ8gpv2cTs3MUtxLVywX7KWsncoSMKo+yWZ5UpYqU9ijmbdxmkWjhjR
 wjA/CF0kAX9yYH8hBmw4iy6AAmU8uJ6Eic9+YwvcGYrZ2NqzJaPUmMN/N5hU9HqNA2zW55Rt1Cs
 xoIFEFWEjbDqDqd9kqOT3SpcdQhr0Iy3Ty5I127yO6A9rGIjNgPbJ8FCnKHcmdhyZ5OwZV7Eqnt
 Aib0zT6UIij7k8h8mbUdChYuYDdvr97GDBfmVtLFKPSpihIuCxD9nu+2EXXI4QDjhZcKaz5Scoo
 p0ttlXlL5UXQj2g8pIwxh5w+szQ0cFKY+ZhSt87+hsL9R4YKBl5iqYYWdpBumuJeygqaTV+/uzv
 jYuRi5CHr47cXj46uhFQNxX2B0Uvp1Lz+3xqf3NDoe8b3fFT+Fj+WoOi+JV+KZ18ZsIFU=
X-Received: by 2002:a17:907:5c4:b0:c16:29eb:e834 with SMTP id
 a640c23a62f3a-c1f71defeacmr54360266b.21.1785224594372; 
 Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90205sm725093766b.33.2026.07.28.00.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 09:43:03 +0200
Subject: [PATCH v2 1/2] video: bmp: bound RLE8 decode writes to the framebuffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-video-oob-fix-v2-1-97162af76510@byteray.co.uk>
References: <20260728-video-oob-fix-v2-0-97162af76510@byteray.co.uk>
In-Reply-To: <20260728-video-oob-fix-v2-0-97162af76510@byteray.co.uk>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224594; x=1785829394;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMVe6eQUYDiQ8zT64JUpKblaFQRRNTPU8POUWINNM8c=;
 b=PNTeiB+P5hk+/IYaS/eJNsgLhTkvq8gLTq0cKU2L6kuVgG4nX/sosQV1aVK+spYK2S
 37tkOp7Tjs3X/zLKW3O+VxJcjSAxDUwzbuO2GP4AgzFMn+XTbz1d0xqK/bWFXmaQhlYE
 zOmwXe6Fl4NqaVtQ550JnMe6urCtaq7McagXNJOCw+mkG0l1L/7O0tnhlGk5/agXY8Ry
 AlBPwYIEwKWhrMFvDy0HyMwii1GFtKaofIDGrG0VnoS2WbYYjQYC2Iec7wp8UrNa1bas
 3lgC1hrfwcx7OXHlGrZ8RTyJWA4yNp40TmAsAnVMsXXi4+LNsZ8aLEo+/2SkB7QyLoya
 rFYg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=PNTeiB+P
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="PNTeiB+P"; 
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
---
 drivers/video/video_bmp.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 1f267d45812..d59ef430755 100644
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
@@ -337,8 +347,10 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 				&bmp->header.compression);
 			debug("compressed %d %d\n", compression, BMP_BI_RLE8);
 			if (compression == BMP_BI_RLE8) {
-				video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
-							  x, y, width, height);
+				if (video_display_rle8_bitmap(dev, bmp, bpix,
+							      palette, fb, x, y,
+							      width, height))
+					return -EINVAL;
 				break;
 			}
 		}

-- 
2.43.0

