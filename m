Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E9CE8D44
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2AC8416F;
	Fri, 14 Nov 2025 16:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xmJLbEXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557C1833C6; Fri, 14 Nov 2025 16:28:49 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654648415D
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so14556485e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763134127; x=1763738927;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dzS5jGCYgz06++uZwbOHhVmVbN8GS4MZm10xjna2TFA=;
 b=xmJLbEXGy4AiUYXcKDXFO3icrEfIGT0tc15fKNyqtkbERs99SUPL8pxdG1iN5lul7z
 CkQV2LmG4HaFBe4hd4wsAgNvhQR+MpETPKSi07R3XDYEMs8zYDC5NgyUM7kIl31Yc4cg
 7BoVSMYKKDO4OMi1jpndHY+CaioUNlwRQ/VBLra7/pLl6EPTKxJE/VGf7rsfZS2v27nU
 bD7/P5IyeV9BMFpW6mKSBZ1CRNDjIsW80ms3ybXZSkHyk0QkI9+RORjzGxjBFUeeYJEB
 Q9G9sQNplgOJxv60voqTRVCA4mVOFA5+d3GBC2j5hHW5SQjrDv76Wuu16C+EyqFJu/tN
 /MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134127; x=1763738927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dzS5jGCYgz06++uZwbOHhVmVbN8GS4MZm10xjna2TFA=;
 b=AGFt+6QMKoaHh/Ehc4FftavJiRUgArTxb0FFdFRrE+3NwA9wbKpfE4hSBW8/F4O5cu
 3FvgblPZJOO62m0arFbwNZHbmsK6etvbaRzVQmk+BxFgNPAbo3710obnqIIg2T3gQZuq
 diAlYSU1GlxxKRwG7/To8wXFqmJddH+El7uUciVgNWT9kIQAUa5OK0OGASOguiYoS5K6
 YTUjSKpRngByUoAXBAQjVy2LfuE6e8CCzDxhP+pvIdYYZoveFK0GOqfiPj8rPmd5u8ST
 px6lME2YTQ292R7R/BGK5YQTRYQQFeBxR3O5hK3YyAcPS05mbDWzeJPrMtfniiiCAuQC
 cOyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOkxTsUUDh67NzWABxttfh+MSlwjtCh8cW7Neql+ZH4FuFE9SpfFqDTSxE/4bln1NjoSGk8YY=@lists.denx.de
X-Gm-Message-State: AOJu0YzGB0UcUue5uy5isHadxwqDDmnXerr+W+cui5XDHsXon7kEvYvV
 psCVCIO4JzWskPDVQKsjrdx7RKin2Q4nAcn0KpOdRAphOXex6ismMlHOZslfi3URVz0=
X-Gm-Gg: ASbGncsj+erJchP9EMtjGpclic0Jlotyn3fduLS1BkSuk7wE8AJGWZgmxAu4TC6+qO7
 WCYgHqYxjSNdCSU5ygSitOzxCDpokZEr8xvcWRKlFWJMVrNynMpD+fAKXabnXOG+Qj6MnQqvRUB
 A2jVfI5qJcgXFuru9ecMtS3PUWMJz5TsWPzB4AzfmpBnYpmc+CaUCTmDeWEfLZf/E7xcmKDxMDh
 cN1eOKqxN9IwJ9CgO7ifD/fJbLhDeIHSvczRZK4qkEU7cxPtHPY1G1dvIg+2yW1wjGDUQz36l5M
 gmpvv1x01GTlO/bwTo/2SIv+qzyz/GPk1W7vkNHdx8B62vraCLpZ2byfdiGORE5KjOP+H5Q6oGg
 Ssw940TdlKBDGQeE6SbZ6CD7iKBRqNW6JFOkQADqPt0MrI9dtHFHLjr2MAv+wwsC08gVIlejw6B
 p4Hg==
X-Google-Smtp-Source: AGHT+IGoCyEhNRM2ELOqgCpU4mnDlcXTcxjfFuRmRJ4999YXuNYFuaodtGjIF8rTFnTgq3Sqqyhzng==
X-Received: by 2002:a05:600c:4f15:b0:477:7f4a:44bd with SMTP id
 5b1f17b1804b1-4778fd3821cmr33884285e9.0.1763134126779; 
 Fri, 14 Nov 2025 07:28:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:1ab:5fd8:dd9b:8e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779524d2ffsm15741035e9.3.2025.11.14.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:28:46 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 14 Nov 2025 16:28:43 +0100
Subject: [PATCH v3 4/5] cmd: abootimg: Add 'get ramdisk' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bootconfig-v3-4-a28b813dba90@baylibre.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
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

