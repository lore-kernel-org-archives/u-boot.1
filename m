Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3A3C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA74888EA;
	Thu, 13 Jun 2024 12:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q5BQKxWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E99883D3; Thu, 13 Jun 2024 12:13:35 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02EAF888DD
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4218180a122so6353455e9.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718273612; x=1718878412;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8pcrNNtyvmSnnPWBu5V0jwxWwuKPIZMjnUEnkwn69b4=;
 b=Q5BQKxWPDx2bO3YtQH2syH/RZytCdudWrXFKirCDoM14Cuz/Hkg1+MdihJjDcw4fc3
 lAPvFx8JlJl7G3lskmj+SIvGXETA7gVCjzvg7+xwzFrsOYTyo7mBrcZYARKWmplhJGOK
 dQ2VRzlhQI6pjQM4FJZTd1uPS97NNdsSjVYwgcIka1aK7oHYyCvgpYopl13NF77bXQKl
 meUythOZCExlJgX5/jE0+v0BOkCiyiNoyuiua0exRkPB7sSBe3Pch4c93MgMfD1bvihZ
 6sflUgVwqMX8ha7m1TdKElQuCbQS6gBfGMhYXYJsycy1FyZLIumXptrZ8pAngsLmXHfv
 SwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273612; x=1718878412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pcrNNtyvmSnnPWBu5V0jwxWwuKPIZMjnUEnkwn69b4=;
 b=cAl/XJGWP+SET6GU0LQkVI+vg7lSNiodKZzi2+TnhFKE2GFn04o4wmfoqFOgn/rP6G
 cRnkjFrLpG4DawOZjxhYCBgn6H1V72USpNuCtP0UphYbP3zYX01RolYlSpd7B8622fy5
 ZTcMj3w5Yp1sg9ochKHcbaqDscfl2pijog1+JdCR0508yslUhmU5FTukTHGbKa4kxYMV
 tLeqU+sI9D403RHTVKxhg2hAKpFlHL/fw+Y4wklLUSQ1oFo4oNrhbBDwYqu4uxKjWsHj
 XMuCefzoc3wO+6zRKxjpUrt1sgvnR0iBFRD/gN7M1AW0gmuDxNYhPJNRW7Wx58gmuqYf
 xGWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLu3Yk/LgCnKIJ2iP7oPKUEs/WP4ImqYCtdKCBmGCVM5csHONj4yTkHkvf6BaN+jvlJh1fpSFOCUdycAm9qfCJcK8ldg==
X-Gm-Message-State: AOJu0YwQxav/dzr2SxSorhIrVPIzBDs2h1uAGKSAdPhTs1CNHT+momWE
 sWCbnWqfNawkEnJypLooPOTktyD7aSJ8NVqLdAtq5ZdfZLnm73a1qdc0KndxLGw=
X-Google-Smtp-Source: AGHT+IFAZLvhTVMCgSQQpS1LpfH6y4q8AmNtmciMjTP0Th3gpbbCASSWnkMPZoschVaF0wnBodDQNA==
X-Received: by 2002:adf:e781:0:b0:351:c960:b5af with SMTP id
 ffacd0b85a97d-35fdf787f8amr3849434f8f.17.1718273612486; 
 Thu, 13 Jun 2024 03:13:32 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm1251573f8f.82.2024.06.13.03.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 03:13:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 13 Jun 2024 12:13:08 +0200
Subject: [PATCH v2 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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

When calling android_image_get_dtb_by_index() using boot image v3+,
we should also pass the vendor_boot ramdisk address.

Use get_avendor_bootimg_addr() to do so.

Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr()
       returns -1.
       for legacy implementations that don't have CMD_ABOOTIMG, add a weak
       implementation to avoid linking errors.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/image-android.c | 5 +++++
 boot/image-fdt.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index ee626972c114..09c7a44e058a 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -56,6 +56,11 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+__weak ulong get_avendor_bootimg_addr(void)
+{
+	return -1;
+}
+
 static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3 *hdr,
 					       struct andr_image_data *data)
 {
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 56dd7687f51c..8332792b8e80 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 * Firstly check if this android boot image has dtb field.
 		 */
 		dtb_idx = (u32)env_get_ulong("adtb_idx", 10, 0);
-		if (android_image_get_dtb_by_index((ulong)hdr, 0,
+		if (android_image_get_dtb_by_index((ulong)hdr, get_avendor_bootimg_addr(),
 						   dtb_idx, &fdt_addr, &fdt_size)) {
 			fdt_blob = (char *)map_sysmem(fdt_addr, 0);
 			if (fdt_check_header(fdt_blob))

-- 
2.45.2

