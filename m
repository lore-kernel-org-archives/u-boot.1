Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6494DC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CE9809A5;
	Wed, 22 Jan 2025 17:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4RYZkeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0AC80A22; Wed, 22 Jan 2025 17:15:12 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846CF80944
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso52393135e9.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737562510; x=1738167310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=skJcUyTA1z7y0ACdDZTCB6vnfHmPeFbARq15UVmMpmM=;
 b=P4RYZkeHeOm1CU0FcJ33BOpAC065Rt4b7klx52CIGIEisoj5XB0478WkPbctVdgCij
 KKtFP/FunREI2ysMlHJbGPuiimpdhu0CWELOh3oaJjizJZFVTeZ2ieL4P9jytaUD9C0z
 LF6IyqbMqGe+ALQNBxR2QhmxEmz+Usk9KcK+4PuIQZX8qEUPbIJ1lZd1UgSmHX0l+qh2
 WFL8+yVVrJGUgpTNghvOT5K0txAxM/TwldtA+t1Cx7WJZGeqBRNVBFHFwAsug8lWnImr
 9x2p6nDn4n/oyIRUr657BJBor7fPxGkErpo1EitQYCXCs1KGuDb9Z037YHphIGmtV6lJ
 PODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562510; x=1738167310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=skJcUyTA1z7y0ACdDZTCB6vnfHmPeFbARq15UVmMpmM=;
 b=rpgUIYllxw5KdnGcuYWVqHI9j2OMzUM70hhH/SgY0zV65apZhTCG0Q8zwi5ktwnpew
 RfR3LcaJ3JeS5tjqwutPMgop8dKPuFZVdEvnZEezumcsYSRwVidgchIOEXK/gdowO+iq
 NMimJOfdXTYkmC8s8ZDzpNHP982lEvyKULW3Ex5sYeZsCj+jvwHM8gccEYivBECdtwDb
 csYO1KTyKcODuViwuxoRx4wCi8Vg6gZNMlMuWRIH5TMYKb4jwlgKEw2JLEEmss4PdYxL
 tbHs7/O8UNZJGXkGJ2BG2QZTU3wtUcgMSXIuby436o9CjxQDQ5d+9k2GjSJF5Pd1sZ5g
 QZ+g==
X-Gm-Message-State: AOJu0YwSA+BGCVxjy9jDSi1by0bWzy1cSB4d4NKph48Abp+DmChlDbE/
 Hylh/XN8K4DRxEsvLdY4K0yuHwetjSFGZUUqwfujJguduP2yqAeqlC0tlw==
X-Gm-Gg: ASbGncs6kayet52rCRwt0KTRuhTl7dAk9n7Zjc+Fn25+S+x98gRRQzljNVFxVYwAXME
 9eqw8tpQKLsqZk/8dEJUeOHHSxI7T5AqlQaM5LOsoWbfum1I3VqgKwScZa5QW7QVqLoSKaRbLyn
 t6ZPQwE5d9KgkS0akFZkwDivfuVpBZd4tnIpQdT1r8WaVnjLmB+yaT/vn8CoKBZv5uWQ2p0+M6D
 J2zaJiUlGu0/ItT2ixLCFwkImwefM9ji0gPi5FPehgJ1IQ/0hRr7jVd7HHdJZc5ijjxCnantfqM
 DT68BURiy/kT9nVd7SA=
X-Google-Smtp-Source: AGHT+IHYS1/e4Xm4W53zyElstT29i8aiqenWRDq9V5ckxdqoaFzCZzESR5fw05LGiQD3YXuxl2QqgQ==
X-Received: by 2002:a05:600c:1907:b0:434:effb:9f8a with SMTP id
 5b1f17b1804b1-438913ef2c5mr217043305e9.15.1737562509468; 
 Wed, 22 Jan 2025 08:15:09 -0800 (PST)
Received: from DESKTOP-VDDG490.rasu.local ([212.233.85.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31b1566sm29645575e9.24.2025.01.22.08.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:15:09 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: check result of lseek
Date: Wed, 22 Jan 2025 19:15:04 +0300
Message-ID: <20250122161505.74348-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 17:34:42 +0100
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

Return value of function 'lseek', called at pblimage.c:211,
is not checked, but it is usually checked for this function.

This trigger was found using the Svace static analyzer.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/pblimage.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/pblimage.c b/tools/pblimage.c
index 6c4d360e46..34650cf7b7 100644
--- a/tools/pblimage.c
+++ b/tools/pblimage.c
@@ -188,7 +188,7 @@ static void add_end_cmd(void)
 void pbl_load_uboot(int ifd, struct image_tool_params *params)
 {
 	FILE *fp_uboot;
-	int size;
+	int size, ret;
 
 	/* parse the rcw.cfg file. */
 	pbl_parser(params->imagename);
@@ -208,7 +208,12 @@ void pbl_load_uboot(int ifd, struct image_tool_params *params)
 		fclose(fp_uboot);
 	}
 	add_end_cmd();
-	lseek(ifd, 0, SEEK_SET);
+	ret = lseek(ifd, 0, SEEK_SET);
+	if (ret < 0) {
+		fprintf(stderr, "%s: lseek error %s\n",
+			__func__, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
 
 	size = pbl_size;
 	if (write(ifd, (const void *)&mem_buf, size) != size) {
-- 
2.43.0

