Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB22C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3D7B81415;
	Tue, 28 Jul 2026 13:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srHQgyAL8SKs; Tue, 28 Jul 2026 13:00:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33F7C812B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243616;
	bh=Aw8zBey4wExlx1nDV0c7LeBxVtjvp0QbNi2RrrT3Qbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BX/zdlIUkYLGsp1waDXYQtAeGfbeaKflhye8E+dkwSrd7HL9IIZ2SqmizHnrIWbjz
	 G+d3aQ3nnCtAWI4FxE6uE9CztRKCJeINDeb1/Ba/ZRwqwHr+M/Cdz+S40HpGbxQXr/
	 iVjsYFmVhQ0wp9YuDWd25kpf7EmD6cIaBJp/LZIuCZ4hsL7rOOPcMA/xV9CiHZKoLq
	 sPuvhAzt3I4+LTd6AE+5Oam0NIegEzbQ3AKIdGoEunq+2XxruSqkCRcDLf827qii48
	 IQhdeBxtO3t5q3YlUoQeWDHIBHo1hlTyDvhHQTFnFKUlBfK+TODurSw42fEj0FRP0d
	 xfOidxPrn9fOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33F7C812B6;
	Tue, 28 Jul 2026 13:00:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E17026C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80B4C40265
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIDyU-rrE4Py for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:43:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A6BC4004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A6BC4004B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A6BC4004B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBAC84857; Tue, 28 Jul 2026 09:43:18 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9A38493F
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 09:43:15 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c197f968b3cso500465866b.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 00:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224595; x=1785829395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Aw8zBey4wExlx1nDV0c7LeBxVtjvp0QbNi2RrrT3Qbs=;
 b=Jvqokf+tm9lJF/gRsKIBpNqifDsLQ6SuxWW59GUbY1O6BAdjgaXDmZR2qr2l8JzyyE
 aEPfLf+hrUqlUe7Pxuz/kMepakf/M9i+teXLsoItp4XiWPduT7GxTXFqvB+h6GV4e1eA
 bsWoPInivoP/0/Wq28ENDUH+4ke+hLuU/w+w3l572ky9qFb9aAJeOYqA2b3gy/ZfyD5M
 mNV6ZII2EPR+KevOYskmF4WyJm5g1j6va/fyds7h7e/IAPzbNkCihMTAlLEz07HFYFQo
 gf5/VROIj9IqmYOWP/LAG52eq01WA3LHDT5igHS0MzxM13u+GPS28IX5IMFzk4+PEYpp
 CL9Q==
X-Gm-Message-State: AOJu0YwBB5hkHfc2pzAwcr9HfmMswJfnDOryFzU2HHA3wGVDCKnEfWaB
 J9fkHNWodCyB56NlS19L+SBZwqqoOt2q15Zw7O30MPuwKrmZKHUwkGD5zURkhhLRh+c=
X-Gm-Gg: AR+sD11QfXHv+npDkuxbaaVMhR/pu+zhVsNBjhXbzOXf+AECbVT4ibkycB+cWUD2b7z
 4v8HyQB8Xa/jq0pUAbwKP9xkxm6eU0KW0+X8DsYSscyUIis2W+p3ec8daTpzehlTnEwttdig35S
 yrDRA2qO2sF+EY30RJYuMgSUNP3Q7aIS99yBNEURnOpJ97zyNioeW52RSet88oMzbWxT77MvPlr
 /NWda+i22KzmHJ0iSbsucvMzu3THYY5vBUB73WGB+kA4HgFM3h5qj+C7vDb94vSyM59Au5ZB904
 0JZvbELFmVk8XlPScz/10yy8lhxCvXS9qXg54k/P8EiH1RKpAI4ohooK0/BuRkE8cl8jeZpKLHG
 RVq0GXdMlyiz7uqGRLy3LvxxB3LpxLNqo0o4aLwux0aLn6m2LULGiWuIKf+GIo/7t3pbDa3cW71
 csqtsyk4OT2fxnI/FCZFauLdn5d+7l/umtNB7AtheEHFMrBBj5KY6DvfE8vY+kLc+rZyk=
X-Received: by 2002:a17:907:983:b0:c12:74b8:9d3 with SMTP id
 a640c23a62f3a-c1f71e915c1mr56394766b.3.1785224594839; 
 Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90205sm725093766b.33.2026.07.28.00.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 09:43:04 +0200
Subject: [PATCH v2 2/2] test: video: add regression test for RLE8 bmp overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-video-oob-fix-v2-2-97162af76510@byteray.co.uk>
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
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224595; x=1785829395;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Aw8zBey4wExlx1nDV0c7LeBxVtjvp0QbNi2RrrT3Qbs=;
 b=qfdEA9KxwnfS2J8sPWFs2nskDp3qQo856h8t2K8To2LWT0GPrvnrT6N3SQJX7N9Fdm
 IIWE8BBx/mZGAnCUu3TIZXxY/fbsSHnHSJTlxxHrL/Qtj3PXtFgEJcCBE1AlMryFFcBd
 +KpZpxBLJmHJPViRWw+b6nSIie9kpirdm1+MoUrVmt5I51WrjUXwDTRculesZV970DYB
 B1n8p8PUFjbEZokO70KZaWmzphNYh/GW1St3x7hiTdfXCBNNcy5oDqjpsPDEhlNOTF1D
 03RGOvLfsGtBNw3IQrwKHo9yVTdx2WIjoUW7c+/Uo46W6t52SILj3mIWwNKq8k+/KBb2
 Qudg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qfdEA9Kx
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="qfdEA9Kx"; 
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

Add a DM test that displays a crafted RLE8 bitmap whose decode cursor
is driven below the framebuffer.  Without the preceding fix
video_bmp_display() writes out of bounds and returns success; with it
the image is rejected with -EINVAL.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 test/dm/video.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/test/dm/video.c b/test/dm/video.c
index ecf74605b5c..48ec60c4140 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -424,6 +424,56 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_video_bmp8, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/*
+ * A crafted RLE8 bitmap whose decode cursor is driven outside the
+ * framebuffer. Two End-Of-Line escapes move the cursor a full framebuffer
+ * below priv->fb while the scanline index y stays in range, then an
+ * unencoded run attempts to write there. The geometry (1366x3, 8bpp on the
+ * 16bpp sandbox display) makes the underflow happen after exactly two EOL
+ * escapes. video_bmp_display() must reject the image rather than write out
+ * of bounds.
+ */
+static const u8 rle8_oob_bmp[] = {
+	'B', 'M',			/* signature */
+	0x46, 0x00, 0x00, 0x00,		/* file size */
+	0x00, 0x00, 0x00, 0x00,		/* reserved */
+	0x3a, 0x00, 0x00, 0x00,		/* data offset (58) */
+	0x28, 0x00, 0x00, 0x00,		/* info header size (40) */
+	0x56, 0x05, 0x00, 0x00,		/* width (1366) */
+	0x03, 0x00, 0x00, 0x00,		/* height (3) */
+	0x01, 0x00,			/* planes */
+	0x08, 0x00,			/* bit count (8) */
+	0x01, 0x00, 0x00, 0x00,		/* compression (BI_RLE8) */
+	0x0c, 0x00, 0x00, 0x00,		/* image size */
+	0x00, 0x00, 0x00, 0x00,		/* x pixels per m */
+	0x00, 0x00, 0x00, 0x00,		/* y pixels per m */
+	0x01, 0x00, 0x00, 0x00,		/* colours used */
+	0x00, 0x00, 0x00, 0x00,		/* colours important */
+	0x00, 0x00, 0x00, 0x00,		/* palette entry 0 */
+	0x00, 0x00,			/* end of line */
+	0x00, 0x00,			/* end of line */
+	0x00, 0x03,			/* unencoded run of three pixels */
+	0x00, 0x00, 0x00,		/* pixel data */
+	0x00,				/* padding to word boundary */
+	0x00, 0x01,			/* end of bitmap */
+};
+
+/* A crafted RLE8 image must be rejected, not written out of bounds */
+static int dm_test_video_bmp_rle8_oob(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	void *bmp;
+
+	ut_assertok(video_get_nologo(uts, &dev));
+	bmp = map_sysmem(0, 0);
+	memcpy(bmp, rle8_oob_bmp, sizeof(rle8_oob_bmp));
+
+	ut_asserteq(-EINVAL, video_bmp_display(dev, 0, 0, 0, false));
+
+	return 0;
+}
+DM_TEST(dm_test_video_bmp_rle8_oob, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test drawing a bitmap file on a 16bpp display */
 static int dm_test_video_bmp16(struct unit_test_state *uts)
 {

-- 
2.43.0

