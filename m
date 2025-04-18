Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46D8C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 18:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2408682A8D;
	Fri, 18 Apr 2025 20:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYwfVwoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B06482AB1; Fri, 18 Apr 2025 20:21:37 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471AD82A3B
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 20:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54d65cb6e8aso2572672e87.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745000494; x=1745605294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bqIoIDYVu13cOnDraECfbSTjVFobIVyRFh3ry1Ba1Dc=;
 b=eYwfVwoVZsrkp/FpbtGVL01jKur4Fswda720QlcIlQnZv95W3shq4H0QRJeQemx8t8
 PSXV1+kg6ngvK5hJhJ+aLzCbYSNRU8mni2ZtzZW+D5Az6iS5sZgnypaEqccWzVsfJVbR
 7pEXznfURVluozo1Dz7RlA0cL9fHSeUkBSx5Wkmz7jc219MeiVBPcRzRqYJ25uKYNnt9
 bUy6OlkvqrusnAu1WndZTsY2Awgi5Ec33qVgsD6aE7wnSCONoPqkMa5ddg2TwAGzc63D
 SvyKiGtXl9+9tKhLv1Oo/T8bV4w3BfAXsCGETxGnEZcX7Pp5zVkPm1hJnnmA/PlaM3cq
 4H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745000494; x=1745605294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqIoIDYVu13cOnDraECfbSTjVFobIVyRFh3ry1Ba1Dc=;
 b=sSVOHpc2dhBCBfHZrDMVJlHx/jVJpnHqhmCNG1ZRdAuYBtqxUjvzr39XeZ+UFcI59j
 CTWw89i4r4hx4zz13EemOHSKONwxAp6pKnZC2Ajrk06/mV5r8fIErRV2fXA+TiLoXBJX
 N7riylDo+NOfCZwZqHqmyT8+T2bvsjqq6H9Z8JBNmKGI4na0b8dx4kHbfGFG4WFhwvRX
 XIVwqwdpx6ZZn1AuP0ah0S6r9jpnHVJFjyTdH33iUev3/Z0E3qzAIHUpqu86b4YYxIHu
 z0Mxc7o/6PzBTYCGc2mhvIRJB/SKXaYhq/Ofx94C8Sa1/cQ+apBoltXa56AnpMkYq9GX
 NCJQ==
X-Gm-Message-State: AOJu0YzR5IU7pTV4HeIqpovkKMKuPi0nnwQWJ5Dmr36fMZmQ7uFwYooY
 moka78nvHR6zApDpN4iyiuVdeTw3dkbvqYLtl0kcd0SsTbZhvM6Ys5lYVelr
X-Gm-Gg: ASbGncv+vtQxB8zISvylJIY59IlryjmFDsYor2cPDv2PizDdvCN1FXptTkNuI1mV9t7
 ZEuJnFiQ2EEuWIy78EzHdW1PES1oreATN9oHM3J3+/6DZejJQVz1WL+GlCV6b05ARqsORzQCm7E
 xhrQ8KB/MmvpCLE0YNJ8Amgk43i7ZkReM3259jGZMk6EvexAdQgtOgVIZPwkmZhIUKTAWUmjTW4
 1NCMvI8EYO67mB6ozXFCO2F5I8hdJzoeP5SGKUX/08pZR5ZR4GcRWdaKKVZKnXSWgzW1GhhUcPw
 NOslHdaf0O5KAth72wKLNFve6oSysiFJHbUFsIHijFZS6ooU6YC2WXg1mkKhpNYs9G/g1zm+XYj
 1+KoSyV7k
X-Google-Smtp-Source: AGHT+IEnpkyphu9RVkf5bl6ckRVyD2w4ARPYjQHGsWNBhBUZMcRUvjnBtrtQ3O1NvMvSX24KAFbRrA==
X-Received: by 2002:a05:6512:3d05:b0:545:16a5:10f5 with SMTP id
 2adb3069b0e04-54d6e633f6fmr922749e87.30.1745000494108; 
 Fri, 18 Apr 2025 11:21:34 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e52435esm249745e87.32.2025.04.18.11.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:21:33 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: Fix memory and descriptor leak
Date: Fri, 18 Apr 2025 21:21:31 +0300
Message-Id: <20250418182131.190511-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/zynqmpbif.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1a52..33c68eac9f3 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -205,7 +205,7 @@ static const struct bif_flags bif_flags[] = {
 
 static char *read_full_file(const char *filename, size_t *size)
 {
-	char *buf, *bufp;
+	char *buf = NULL, *bufp;
 	struct stat sbuf;
 	int len = 0, r, fd;
 
@@ -214,24 +214,28 @@ static char *read_full_file(const char *filename, size_t *size)
 		return NULL;
 
 	if (fstat(fd, &sbuf) < 0)
-		return NULL;
+		goto out;
 
 	if (size)
 		*size = sbuf.st_size;
 
 	buf = malloc(sbuf.st_size);
 	if (!buf)
-		return NULL;
+		goto out;
 
 	bufp = buf;
 	while (len < sbuf.st_size) {
 		r = read(fd, bufp, sbuf.st_size - len);
-		if (r < 0)
-			return NULL;
+		if (r < 0) {
+			free(buf);
+			buf = NULL;
+			goto out;
+		}
 		len += r;
 		bufp += r;
 	}
 
+out:
 	close(fd);
 
 	return buf;
-- 
2.30.2

