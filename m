Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F679C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D27F0407E8;
	Wed, 22 Jul 2026 08:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1brMH5ykJRS; Wed, 22 Jul 2026 08:15:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55482407FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708143;
	bh=kpgOuNQn4ZZwuYttoXesTczVi/5uHFsvVS+gqPxk3L4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mb4OwiLmnxofbAK3NmPhmO+kWW/y9TZNiB3YUWsxIURo/ELSMOMga8N0aV8Cmj/XE
	 gCsVfN4GN9dtk1abM9aNHFMG7rJPQtSQdoYexq/TdB4oEOAsJ91oZBCRML/XJ7gsue
	 Nn2ZoEjt3Z5FC0zcOnKfjK41o22qmnGRsWrlbcfWzlAG09d4rTYMn0N5WnVTkp2W0r
	 DndHgkT4TNbK3IaFJIzA2CvBlQO/tCzF0rqXZHZf1bKF+POXxbNbdtOzb4hMLFfQCC
	 v1fYLktOxqLzQ4gkareYtaNVu7cOdeXrtdBv9zQ/iR3Yr6pOYw6bNfQxyD0EnLieJM
	 oqOXe8bL9UlEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55482407FA;
	Wed, 22 Jul 2026 08:15:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 967A7EB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8892160737
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FTEU2JemXjZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:10:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9CDC660740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CDC660740
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CDC660740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1608584974; Wed, 22 Jul 2026 09:10:23 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27392848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:10:21 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15b33f7b23so1769661266b.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704220; x=1785309020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kpgOuNQn4ZZwuYttoXesTczVi/5uHFsvVS+gqPxk3L4=;
 b=SWwsbnJJzDgWoqL+U7CY2JLHr/OoG3jZmlbWgJFFtJv8im2kujITWcg2i/FjK9ghVL
 tki7Kb87pEFlVWLf7R/N8qMHRd9ibOakCVw6GNPe9Cykbcudd/XEDLdNTzl9INJMhfGn
 quzsAm6SBo16WsJjugnlgo+Aa5J21cQRZE5V7YYPSJzkWaXdkZec92TPX1n4CIFQq9Un
 qk3fTAKUYFmNgGrnZYGyF4vYT/A9X5gHmoV0WXWJ0vDMFc65ues79jgSnINSP5jGcy2M
 zn0/VwTg57RoQ7L6t9p3PGlvhsycSx5/G9l5R5wkREcgXcz8NblMDFtM9WxxoW7Pnbkn
 /X0g==
X-Gm-Message-State: AOJu0YwUIoH2GUua7lb1GAsr238PL/tJmMMNaML8Z/dbc6n3ys1VlDYD
 1r56pDogcRxrNP2QdjRmhF6XSrobprGxktRxcQMbJwZ+6QU0u8FSM/jRhOoUUjGsUPM=
X-Gm-Gg: AR+sD136iEIZFyUXcN1jh4mdECN6pEVgENENx1+KZBTcUvk+49lApa2P7Od42qGV13h
 XyRBSRP7pNmb0KVoPmEpyYHxihe9xSEsbZTznXgp7T8JqbdynUkykaEhCHoj0VhfMP972b0dB0v
 1JgKuXQEB+vz6J8VKyRE12eKaqW6aCdCmMdPkl5IKpit0lRCUs+Nn7+I6dttvKOyeAEqyZQOQvU
 KprNjsruHrik6aWRpcaC2RYgPL0JHlZP2INECfec4DGQvZbckjPkzH1LDpuGOfgsrfIh7V76CLZ
 4QpHbazq2enIbSxIQ5wuQxaqdhD9q1x05pkZcOhBPTYpHw2p51RHrCW8HKXlnqXtgsMKnvKRwNw
 /tHdXbES2DQ1diO9l07p8M+Wc32eaPm3AX6vIeEG6ujej+RJQ2c+N5UWbOWNug204xKuc4csT2O
 y5hxB7MiOwga1Z1Ey892UjHROojZyNwoxi+J2FSXwSzYxTKtdMpleJRF9A8aY4sgkIGtuWUuouI
 TVz
X-Received: by 2002:a17:906:ef02:b0:c12:12b7:84de with SMTP id
 a640c23a62f3a-c16b46d0512mr951038266b.17.1784704220548; 
 Wed, 22 Jul 2026 00:10:20 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a74811sm60780666b.5.2026.07.22.00.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:10:19 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:10:10 +0200
Subject: [PATCH 1/2] video: bmp: bound RLE8 decode writes to the
 framebuffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-video-oob-fix-v1-1-d6943f687c50@byteray.co.uk>
References: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
In-Reply-To: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 22 Jul 2026 08:15:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784704220; x=1785309020;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kpgOuNQn4ZZwuYttoXesTczVi/5uHFsvVS+gqPxk3L4=;
 b=khq1cBh/pbdoxZUwCXxXGHBBVBmkRCYlFxM6wBfsMKFK6HepERH3w+spUGh6dRfS0j
 K94fzby3mmAkMsi2WPwoeA7huPkYjYesptMx+lhM/wIE+zGMEL3s/YuCAonRNi9d+0JE
 fkCoc5RzG2Ug7g8npzdGSJ7w0bYc8+hhMN41ClM1tX1Zm9+2BBpo05vwf3Xuf7vCrd9p
 tI9Wbokt30yOZWrmaO1glsg6DqrnP7ngUmiazeyvvWvzDGnlmHJGLVaLXc0F4A2x86Za
 q4KzF7SPjfQ6rBWASSC5MC0tJ9gMl4MHdGL/5B9EUHgmdLViBQzWVMoYsIJO6E0Athug
 VPYA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=khq1cBh/
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="khq1cBh/"; 
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
From: shj via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: shj <shahriyar@byteray.co.uk>
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

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 drivers/video/video_bmp.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 1f267d45..d59ef430 100644
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

