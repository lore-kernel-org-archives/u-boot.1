Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3498E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E221080282;
	Tue, 17 Dec 2024 14:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OqhEKO+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A7D80288; Tue, 17 Dec 2024 14:29:19 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A274980243
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a766b475so56116505e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734442157; x=1735046957;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xChXVoYLQIZ0+6Ny/GRR7NMZz0etGrqWae12T7L18/s=;
 b=OqhEKO+LmJWlWwAme+u5DwfSirBE6I0wc4toJh8OTez8R0557Ne6xCO06/xROUtMs+
 4sI4pXG1F/JUHDK6eyrh+ZXf6TtbAUiFzlCb/xbpXwJPTk5Zxxwhd0aZqIlWAP1nABcY
 wsTrO1VPuBowRjsWP96vS0NUlyPrKcfJQApb4/FJBqheTrQeCxoFO+f0q7xnscWp6Y88
 FHtVGllxJofxZ5UJ6WE0BYrcc2/kPuL1HDli1/B3MSPFtpudeOWISMe5asL/5grjd6qd
 MEYrqnsy9vUDvR9QkBU4v7Ms9ThoxBAAe+pQhMbxt07QzXrBz1cpm/Luh9p1ZsWFAS0v
 0RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442157; x=1735046957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xChXVoYLQIZ0+6Ny/GRR7NMZz0etGrqWae12T7L18/s=;
 b=tCCNhxxNxVRje9RhJ9t+hn8O0CyFgG7EYd6Zh/sNMsZOktGnEAw7Zob8aJdYeWbbst
 h3PtBR8ZD6wAsHJYI+pDc7hvei8HQzCjXOEsWRLv8xSllOC1IS8WKgncDFVAFIV5dT7h
 E1vcj3D+U2NPHgQxqvbdomUQtNkdr1K3pfdZrrYofcNs4FsK7cFw2kCsUqGKam7BVKoY
 VyrCqAmHTtgeUjzvzX3kGji6C4cGydp6Q74NjaiwUhH20MqdVjedvtSk0tTzPo0CxT5e
 WsQ6S9vdM7mRJkrrSQVvsezR0xKoHBP77Mv0L0v8qvKkySox4w5W803Fk1JQDfaDh1sN
 49cg==
X-Gm-Message-State: AOJu0YwSfC7LfxLtCF6uYe3HDvqRc9gPN8keoigq8YI37eL7ywuUu3g7
 bWhSPM5o2J7QgKU+WLrJUNRSxArdL5Rsn1xFt8/cnbo5vRIVy3b602D0j9SBZVs=
X-Gm-Gg: ASbGncsmYiKjza5AObf6a3dhJLPwgfQiw5uL8IDHMUtxJEtsMuhHdhpmXPUzq20r5L/
 pByOZR68VhOpcZkJSF5qoclN5xNklNFoCe/fYMSfUqdr29N0njbghNSTLzZC+ngv2PxMsoa+bxO
 krvNuLOMWKo70+m4iTZHhEGJOsJg+xRWVGlYKpqcSnBfPE67KzwzyLE7Qbfq1FJgpASrPcOipYi
 FJxhev2bI5yo3XKSPXIQdTCG6evPOT/UygwiLUvNAhFlxtYA7dli2ct
X-Google-Smtp-Source: AGHT+IFK+qA7OkWDm1G+lJ47Pu9hMbRefGF5h8DMzrOYwiKTym/1Dv8vPbSNczeDfxRndg6xr0jyZg==
X-Received: by 2002:a05:600c:1d0e:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-43639cc458dmr123434415e9.2.1734442156974; 
 Tue, 17 Dec 2024 05:29:16 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:d0f1:bd21:f6c6:25a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec08sm173605115e9.22.2024.12.17.05.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:29:16 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Tue, 17 Dec 2024 14:29:10 +0100
Subject: [PATCH v2 3/3] boot: android: rework bootargs concatenation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-fix-bootargs-concatenation-v2-3-b2fd7cf4e130@baylibre.com>
References: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
In-Reply-To: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734442151; l=2347;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=YkJMAVMqFFfm4iNwwfQeFMVYMsrPZRZXedKUakEBc9E=;
 b=n/NFjVx0p1Nf9m3fYYbpfC4bzlhfmQLKSOmb9dRLBaoDw5ZcPStmwmZSfcjhaiwIRCRo6m4Bq
 Ir7UkTQog4/AIYUM4eSGK31eDtRLnh79G+dzQCYOCNUvCuebML6Zzgw
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
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

Rework the bootargs concatenation allocating more accurately
the length that is needed.
Do not forget an extra byte for the null termination byte as,
in some cases, the allocation was 1 byte short.

Fixes: 86f4695b ("image: Fix Android boot image support")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 362a5c7435a3a8bcf7b674b96e31069a91a892b5..61ac312db7ad9ba6c55727469dd4ded61824c67c 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -287,37 +287,40 @@ int android_image_get_kernel(const void *hdr,
 	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
 
 	int len = 0;
+	char *bootargs = env_get("bootargs");
+
+	if (bootargs)
+		len += strlen(bootargs);
+
 	if (*img_data.kcmdline) {
 		printf("Kernel command line: %s\n", img_data.kcmdline);
-		len += strlen(img_data.kcmdline);
+		len += strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1 for extra space */
 	}
 
 	if (*img_data.kcmdline_extra) {
 		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
-		len += strlen(img_data.kcmdline_extra);
+		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
 	}
 
-	char *bootargs = env_get("bootargs");
-	if (bootargs)
-		len += strlen(bootargs);
-
-	char *newbootargs = malloc(len + 2);
+	char *newbootargs = malloc(len + 1); /* +1 for the '\0' */
 	if (!newbootargs) {
 		puts("Error: malloc in android_image_get_kernel failed!\n");
 		return -ENOMEM;
 	}
-	*newbootargs = '\0';
+	*newbootargs = '\0'; /* set to Null in case no components below are present */
 
-	if (bootargs) {
+	if (bootargs)
 		strcpy(newbootargs, bootargs);
-		strcat(newbootargs, " ");
-	}
 
-	if (*img_data.kcmdline)
+	if (*img_data.kcmdline) {
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+			strcat(newbootargs, " ");
 		strcat(newbootargs, img_data.kcmdline);
+	}
 
 	if (*img_data.kcmdline_extra) {
-		strcat(newbootargs, " ");
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+			strcat(newbootargs, " ");
 		strcat(newbootargs, img_data.kcmdline_extra);
 	}
 

-- 
2.34.1

