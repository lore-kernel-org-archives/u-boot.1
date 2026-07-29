Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2386C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9EAD6079D;
	Wed, 29 Jul 2026 21:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOu4vN7vtULU; Wed, 29 Jul 2026 21:52:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B85C7607D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361935;
	bh=pWALnTxwqx6U2Am8zKLwgYe8dEdm6lCWkzufcZ7E2aQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jWPQAwJvQeQgMSbd7Zgp/qzu26S7E6AgzzJ1bu/wBEKeFKbBdHsQf9+O5vlQW810h
	 x2k2sCngALqMMhcw4Gq0AiwNoxcog8M8fF/IFuHSJvycqm834MKNBTFRswJ02PNAgk
	 B4WheUVvZTDrGitSRsS3k2DACWPvAWgb9qLBR57hPMTi1oZB9eM4gLcnJ/kgkaZsda
	 9VMkrX0KSEFwN3zt+S9VkWiWCfOZUxyEZZL5DUymXsL+e3/bYhzSyGb1nmh7SLRqv2
	 oC7ZZJGFvs0mrrlFyJW1cP8vrqEqyPw9vUdPGYJ42iiVhW+MHhCNqKeO7eC5D/Mf7B
	 2nFy3IF7N/QaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B85C7607D5;
	Wed, 29 Jul 2026 21:52:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA4E13B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90C344075C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAkyIgxeHXVx for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:47:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4ED8F40755
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ED8F40755
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ED8F40755
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F8882991; Wed, 29 Jul 2026 18:47:47 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87FD849A1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 18:47:44 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso1706520a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785343664; x=1785948464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWALnTxwqx6U2Am8zKLwgYe8dEdm6lCWkzufcZ7E2aQ=;
 b=H3b/f+7pix/seo+lDQI+llM87JYCtx5IK+EMyXv4jDVIyPT/2hSiWBwZ9zJdn6lpES
 RUHZ8qKP8MA0OA5ATpVj/bfsHshvSqTPahUXkS8cCdPVnJxfbrGbdyEZ16lbjAWxq7JI
 CKTIROQ5SrcIYhOtrAKB6x31Rg64lF0Xn9fIF7G1K4LV5776M9yUYi0PFIKe/o7sa9/f
 MlKISEYM4NgPoQ1di/RKCuCeOjQF7VL+pKGz1FqmpoHvGx31D6lgc/A+yahur6qxc/rs
 3p6AY9dxG0xI5Wu5hcM6YcWwPhWY0UbesWyCTq499Q4yO2C6Yj3rN33grIbbqTFoAUwA
 0nvA==
X-Gm-Message-State: AOJu0YwLJ67N8nOBvm1wGvvvGp9AxnNkQGTzB5QSQyd8yIC/mYXh0jYJ
 +P7aEFIbjqWwEKvx7EEZeVik0TFauyrpm6gFXNLe2YuFYaGOYvchI/W5RPGHMSrtvN8=
X-Gm-Gg: AR+sD118BgV4XpHt9kVrMSJ0NS3686cXABQPJfFV0TzrFno2Na/pB1SV9cOJAd2PiE4
 NdNiFhkt97j30FhIaCXU7LrZcLdn2ag60Ug04cLNRvHRzgVrUAJ5uJ+fvb5H/A7tPBT0nsAeD7M
 SrKS3hEO2SdOPT32+Lg/NbSssBew5o+Ao6bSSdZ+HgajSo7kXGet07WXIV3fCJaWz/mBeZ9L2I0
 CX+4ySgjIl07oCEf5ZGBYyzMfIG8C87hVfYTDt6cPFcx5SsF9GG3FjAH/O/lq0SYKVc6jvZ/8Yj
 uPJIN0HkdJIUCfvFCSwT8ceJ+Qc5DPtnmRnhi7eTY7Rix+RP+7KMkqEyHhUC3mjop23kx+5lfs/
 PGyblaV2G4zqbwwoXaboK4yffFzJjikXRUMnW5Nw8c2xpPLHMP7flixddAz/vdT1Fh5UBjR8IOx
 mC4Tk8GeqVb1wJkgFjwDTijpgjQV14FL6kX9fOSS8X5ZQCQuGFd6Kblhl+1XeUO3bfqV1Lhp1Oz
 uYCIMP4O4Jfh4bzN8JWikqCNKfDL7Oj2W6I6/Jkj9EJAqZntfKSBrhKd+yjRrjx
X-Received: by 2002:a17:907:7b9b:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c1f7209b680mr451265166b.18.1785343664235; 
 Wed, 29 Jul 2026 09:47:44 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c6c9casm1058292a12.26.2026.07.29.09.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:47:43 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 29 Jul 2026 18:47:02 +0200
Subject: [PATCH v3 2/2] test: video: add regression test for RLE8 bmp overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-video-oob-fix-v3-2-21d3412212cf@byteray.co.uk>
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
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785343664; x=1785948464;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWALnTxwqx6U2Am8zKLwgYe8dEdm6lCWkzufcZ7E2aQ=;
 b=UYzhjz138Q1gVgB083j9XLCJOHivOmwsG6XYwo1n3j3B0v+KZGMe/5KdJZZ4SlQWGV
 SXC7sfhipvzYmpSCxqNov5yBMbs49Tcuytdj7Q5DieEZ2pltRePkwu2kDSGNARy0WV5P
 d7mMQ9aukvMC6RQlp2aHePAhVmG2cfnW2z/cErLks75IO5uNKGTJj1NDlqecpYELcWUb
 PpXwRWDGfvVBYRbS1EYDOsqeQOfQu9xUeoIE1DZy2lGg0j9s/HKs/MLnWps/efpwOOMc
 hhIWQd9fJJJrLhLxDzWZ2Y2ZC2LIKntdBy8bxAKvV0CNYKIJSRtN0a5A46jYlXP6b7FT
 8Ybw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UYzhjz13
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="UYzhjz13"; 
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

