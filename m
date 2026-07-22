Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95D6C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D12407DE;
	Wed, 22 Jul 2026 08:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OyW7lZHho2Oj; Wed, 22 Jul 2026 08:15:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8769C40842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708148;
	bh=vBjZPejt2dlNcIbLjW4+XzPGg9BWUzMI1UCjr/A1oSY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YkoPrC8TOvvwH7z7YSLXDiEcwHhQfRvceLw23iRPqtpoT3FKC29uNCzVpw+HPT33q
	 9mVSILGYk7Q2CijHWrD+cvD8gNQKPm31g7HXPnVNFXuXX1RG2H1bkScGFRNRCvYKD/
	 nS/3vuHznN0uygmh7dRpsRrNRy3ZnVLqnLZRnDOnraXs/esE70MgF5eUQJcDtEumd7
	 OuwwDHiSM5/rbT3M3prj6osu7cBrxXgIquk45LQqcDUNgGqjelGxO1bT7gvlvXVDwR
	 NyH8C+KcuImB7UUAgngIekPRYadLTN/S298Mlz0TO928ifLqtAydY1+CzGMuWo9WDs
	 G7rVMfaKOmPTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8769C40842;
	Wed, 22 Jul 2026 08:15:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95B5710A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87DE2406F1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ur5uf0sVQ9Uv for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4ADCE40702
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ADCE40702
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ADCE40702
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0975848BA; Wed, 22 Jul 2026 09:10:24 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1154803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:10:22 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso1421031166b.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704222; x=1785309022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBjZPejt2dlNcIbLjW4+XzPGg9BWUzMI1UCjr/A1oSY=;
 b=qNjknBwCT6T2n1ilF5jCVe01SHl9/9EmJeFXnItCmwv4Piuywp24YoiCyGhiTUxYBD
 /XQOBzPW/8twXqEm2b+7tIeFmz2tQLosla/kyBNzTS4Ak3HZlopA1OHO3Wy9UYh20FTx
 bkjAMS7Tj1myialb4Z/GLa4LNk9UzeHGnJA1DKcVKB89Y0Ma4CBsM4ijmvj3gsEW0Smb
 MKAWubnMK8dAWHJjSI6+HVoUXpwLs4cwluMK0A8XT9DUxkhFgh9x2BMfUCvDWlgCsnDd
 XsoUltMWb37Ryi7uG7VvKfapb00LeGSzKffDiqNt/9RhTFm0OxH1QH0cQMmwziPB4A4I
 21Bw==
X-Gm-Message-State: AOJu0YzofLPcfe3xSFdak52LGUKKiQi+duTepYMr8sPO8wQIo2gTK4dC
 Dpzw3Z9MR6MHI9H0MrHzDaWgoIpHTvU+MVnJKRD1oMBSPFMIwNfsNVXNnZhaX1gHUgw=
X-Gm-Gg: AR+sD13qKeiuYGNOPx+2UegurD/Db93uzDWskqADKFWvIc8bxam6z8+8If3rMQTWQ7f
 PYw71ovx+pimkGlmNXRvtb4A3evuWYz1yl4rpPh9kYQz968homzVniF+eE1L4xTXUIbfcDG7qg3
 eIyEscER+sQFsyXAFReTXeBDkTQPTZjRnMnKRleiBYULRBOibUzrhRqIGMjhSLUn0ID2IOpfQVm
 UB/Ubsh9dtA0n5U6jtAWdmUJhZyGQ+f4Zd7LfzzdPdy5i+WMoHWcNz1TVKCM3Rw5bBJmW3pC+FG
 yQG80hPJSY0N2zdfgg9+g607f0gJE//VUS1qaSUT1Zvedv0LHfzytM6x3bH1KjMbIGJFhzFrkg7
 f+KEOARVG9WvvbjJX3vCjMh9PrJ4rDs/qJibkV/fN+PfuCdTKtmj2l5wnjpgOuVCEUxfkuTFDNP
 z+0Q3YJuy9hCDKrOJ4h1KlNhJQu+1tm9PtdiXGc9mW8F2ATnON2BYEfo3PoAU5UusGUQ==
X-Received: by 2002:a17:907:94c8:b0:c12:695b:8876 with SMTP id
 a640c23a62f3a-c16b4727031mr1005970966b.5.1784704222259; 
 Wed, 22 Jul 2026 00:10:22 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a74811sm60780666b.5.2026.07.22.00.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:10:20 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:10:11 +0200
Subject: [PATCH 2/2] test: video: add regression test for RLE8 bmp overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-video-oob-fix-v1-2-d6943f687c50@byteray.co.uk>
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
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784704222; x=1785309022;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBjZPejt2dlNcIbLjW4+XzPGg9BWUzMI1UCjr/A1oSY=;
 b=r5cnUcsJbcY4cblGDfJ/cWKwK92mkP8IvxqGsK2Lt/KAR5WKsyyqj663HONgZ2Guwk
 KCpbIc0siPhL3h1p6R47yp+UJ/BUUa8UCBRScbFvb2ZMAD7/5ELLexVC2yV6PCAxhO25
 GCxg07ITteaZFzsUseUpWdxXTjQHXW5aLf3YX5DGDZ8ApWFPMa8eNxTyz/oQNKe4vtLF
 OT72dnO3Hsz3R9y/c3h9cNOd9LqPuxxeCSaS5MSrUE8ncdCPlYVwSfCIMwEL33lUedlM
 N3aqudoVmWp7FDtTKKolwfCMQMDG0yjYJyo7sL4EWhGsJTEKbMt/bhz+JibjVPhq53ln
 9yuw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=r5cnUcsJ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="r5cnUcsJ"; 
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

Add a DM test that displays a crafted RLE8 bitmap whose decode cursor
is driven below the framebuffer.  Without the preceding fix
video_bmp_display() writes out of bounds and returns success; with it
the image is rejected with -EINVAL.

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 test/dm/video.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/test/dm/video.c b/test/dm/video.c
index ecf74605..48ec60c4 100644
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

