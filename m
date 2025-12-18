Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C440FD6ACE6
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0A583DA7;
	Thu, 18 Dec 2025 12:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="euJ7OEb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99DC83DAE; Thu, 18 Dec 2025 12:17:13 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788FB83D5D
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so5153595e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766056631; x=1766661431;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VXghJDc7pkaiVnkMn7Eoc6se+oJDayltzW4tQSwlMsE=;
 b=euJ7OEb08SzgP5CT3Ko6JQ/o1Y28YONKuFHPM02sfR/Ok0eTHnXfu8B3laOU5H/UeM
 GwrW5z9DzqbbnOUTr2WZA6Kn065PoWT0R/MDVH/256ZoCRDBeTDvaWxPEfgj0roaP485
 iVqHV/3b8tVAy3Rt/JOy21Kw2M1OsIy5C5gJVNpXHciPNuyk4fzW5+f9jp62KDJHICzw
 m2ugCqzpGkhFTfm7y2V9KzAUexmqfBkuZ2m/FeZjlZ1dUQqpkMtjq9RDHRxULWLwWDRs
 EpFbJTtJIZp3raQKKeeP+ojjZJAIhuL/Dt994suMSYZPNQPvzWXh2MldVceWTa8LORmF
 mwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766056631; x=1766661431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VXghJDc7pkaiVnkMn7Eoc6se+oJDayltzW4tQSwlMsE=;
 b=HhDa9fKvZXnMDkNTGJd5E4XEPZyOtcT5JFHs/FWHRejGooMmlV0pYN+nb0AuBtm1OJ
 PI+RW7HY/mqysCK2BexIfzgEsAc8Zecx7ybCslfo+8Ce/k5fY4XOhoVEI9+3vnflrIR6
 PmAE8eY30zQ2VK68wHju73TiWellq9/JUqS4EEuvLBVTBN1zZj+f98JPFx72fFAnwh+x
 LB3Y5u7sNf8kBFEM+kwxLiIth/SkMvUyANHOn+Xbf8nhCE+5t2JEwfhQejkAJDStFan9
 TjxyYpCj27LgYUihn9U5gLAhq/7hrY9jOThGUlke0evpy2gDMfKHMFkg8oa2DHIXzfb0
 ittg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc4UbXNHbdTupvCZNU019y9puif9/+YTx8EtcfStoWqKLp6vElYKt6zL1ZmqABCGgP2tpOxbU=@lists.denx.de
X-Gm-Message-State: AOJu0YzRFn5BeC2iQ7CB8F5szifXIzqyG/h7bYrtDq2iAv8wX1SWClmM
 p8Zz08FkLAr2Sv2TKuioqg1vA/1gBXKIlbCWY1mZfQOz1WoVk+FOb0l2800FU++KR94=
X-Gm-Gg: AY/fxX69GjOxRN6YwzSsE0ir+RBS2q42ipSkcK50ACAB256oIhJrODMIUhcvGBwRG23
 Qcyi7Myf9QmJAZo+yWa+mHdDaZd04U66u2J2QjQvGkfe+wE8IsSrX3QIW79ve5HBsLAYsdAajej
 rau6eCqc0AcdAIaLfetxX77jKKJYtT6bYBUdSmgbGE1ucNxP5yl87Qi8GEtElf9aAtLwBubKPJ0
 kEHMAKFP851TXgyVxmAzeeTYCDpunRa3Xk91vE6QDEFqoYrUM36rrwM9nBulrY5oLjIdabgDzss
 kcUtByHVlCdD+Syku6QNJ2JPMP5qBB8d+bejVtr9x9sNV42qICYZPZ+BV10ZiV+5cpBZ3xAkH+K
 ydVt7p//PHEW8usQr9mfMbhAgstz/kccIQtKxFpCjd9IAg5TyMQjRagCOoyC3seMpzglV16Sp+f
 728lJ2wxcR7cASGQ==
X-Google-Smtp-Source: AGHT+IGQ2XJTIjT1QEVvD/FU82l2efU+jmrmOjHzwTvrR4sVxnbTjrvLFzuvYv/a75YoIXTXVRaeRQ==
X-Received: by 2002:a05:600c:1992:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-47a8f90378fmr209073125e9.24.1766056630811; 
 Thu, 18 Dec 2025 03:17:10 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:3734:1277:36b8:3f57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm38070965e9.7.2025.12.18.03.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 03:17:10 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 18 Dec 2025 12:16:59 +0100
Subject: [PATCH v4 4/5] cmd: abootimg: Add 'get ramdisk' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-bootconfig-v4-4-5bbbdb0be1dc@baylibre.com>
References: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
In-Reply-To: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.3
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

Add support for retrieving ramdisk address and size from Android boot
images. This command allows users to extract the ramdisk information
for boot image v3+ which combines vendor ramdisk, boot ramdisk and
bootconfig sections.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 cmd/abootimg.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 6fb52153786..2a8e2c20941 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -230,6 +230,33 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int abootimg_get_ramdisk(int argc, char *const argv[])
+{
+	ulong rd_data, rd_len;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	/*
+	 * Call android_image_get_ramdisk with UNMAPPED addresses
+	 * The function will do its own mapping internally as needed
+	 */
+	if (android_image_get_ramdisk((void *)abootimg_addr(),
+				      (void *)get_avendor_bootimg_addr(),
+				      &rd_data, &rd_len))
+		return CMD_RET_FAILURE;
+
+	if (argc == 0) {
+		printf("%lx\n", rd_data);
+	} else {
+		env_set_hex(argv[0], rd_data);
+		if (argc == 2)
+			env_set_hex(argv[1], rd_len);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
@@ -249,6 +276,8 @@ static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 		return abootimg_get_dtb_load_addr(argc, argv);
 	else if (!strcmp(param, "dtb"))
 		return abootimg_get_dtb(argc, argv);
+	else if (!strcmp(param, "ramdisk"))
+		return abootimg_get_ramdisk(argc, argv);
 
 	return CMD_RET_USAGE;
 }
@@ -315,5 +344,9 @@ U_BOOT_CMD(
 	"    - get address and size (hex) of DT blob in the image by index\n"
 	"      <num>: index number of desired DT blob in DTB area\n"
 	"      [addr_var]: variable name to contain DT blob address\n"
-	"      [size_var]: variable name to contain DT blob size"
+	"      [size_var]: variable name to contain DT blob size\n"
+	"abootimg get ramdisk [addr_var [size_var]]\n"
+	"    - get address and size (hex) of ramdisk in the image\n"
+	"      [addr_var]: variable name to contain ramdisk address\n"
+	"      [size_var]: variable name to contain ramdisk size"
 );

-- 
2.34.1

