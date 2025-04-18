Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013C7C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775E38329B;
	Fri, 18 Apr 2025 19:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNWUmzmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A17283190; Fri, 18 Apr 2025 19:20:06 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7279F832E6
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5499659e669so2283184e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744996799; x=1745601599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vFW/qomCO/1pp+94VCNaYlUGVZoTD3BsZLzogVg5bqU=;
 b=JNWUmzmMFfhlfAdnVyOOtLXA/eTDBIvWcVmpT7Q+LhoZ1BMm2T81cj2YgD3xpZoRNX
 0HJwQafZxqQkzXUVddLqVyrt7dUcB1TbuSL/8INsqdx9pzRmV/ad+kcE5aCvhsxrnBjJ
 rVDA3gfkTfpSAS0vlN9tR6LmEi8YEcw/DfXaAH60YBe8iooxyIxsU9X+uwQiM3iGYVRy
 Ue50OyE/U3E6IbXCdouqu/PjvTfta1vkievLLyhN2Mh085+CEX5crpWq7ExEYFfyVami
 zD/ntZ35eC7EofRV4OP8cSYI0UQsTpXJb7mHKzHATkxK2TBoCy4GY+m0uVIEkOqGII/W
 x0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996799; x=1745601599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vFW/qomCO/1pp+94VCNaYlUGVZoTD3BsZLzogVg5bqU=;
 b=lWiqFpA9u0zt64x5FN2BvTkwVFYLgQ/3uhv3axMjf2CdSZHIBtsweoWEGs6r91m704
 wwsjnHsbZBo/6izJYajJMwSAaZVRyFWi1bKQkcU8aLniMz+bz1WyaLrq2pRH0QmRLHXP
 R6pFCyGXKh8M+7RWyrG6npo/xliYjoPTBZTXIjPHvqvxpYKEG2V79aKPo4ZEIknKTYtN
 ECpmcGLF9mQiL3qlWI7NexSbYZhs7bKrt2QiJFQRgBHEpusHBhXlqHLB9SM9ciZ8BJ2i
 p99OF0VUI0bHPz5yn/udJ/9eJgd0IfD7o3DMQtSlj2fVb7HzzT1En/Eoo2K6GsgZKSRy
 IUnA==
X-Gm-Message-State: AOJu0Yz1GpL7+zPpJNVsvXn0V5G3V6gjQvqvgFDnE59hu0N9zNd0OZ7t
 Xvb0gasPMlxTcrLVduK729G8wHpoe8cIhxfiQyhqtEm0ShR8buE+5NtMxg==
X-Gm-Gg: ASbGncuzK/50sD3nnNbvrbnpa9+dz2Bwe/ZpJnM4eybiWPRi2jMNup3a2mMcDdxgP7R
 K67z20YgFWgITw8NThaMCLG9ree3zP62ULhZLlQr3VhUXXEbRF23QenKz3kN4XBzeeT6qi0tXc4
 V3v/T7NKrUmeyaIoM3pSRS0KxigbDXKqgly69w7Gm21+5W4FXUuDtVcDdrxowVtoUgM4Rw1JBot
 WoEhJ0HbN6joQ5isYHKKKuULYRl+QYwJJ3m90iZYe7tWNueylLCVCDAT0ym0t5+wTJxZw10KJmZ
 LYTkOKbzLuc3jI4no9G3v3LHVcOYD2KRrppNejQMYA4yF0CJw4J9T0iMRUMt4hMHzke2kWmXL+C
 zyCa6RVIz
X-Google-Smtp-Source: AGHT+IHwpnFbCTzf8/OVd4guhCIJI8e8WUCartuLnazqCAc0KxWkkEZNKrlOlajPArmnS/5sU8KftA==
X-Received: by 2002:a05:6512:398d:b0:54d:65b7:1375 with SMTP id
 2adb3069b0e04-54d6e66cecdmr1141204e87.48.1744996799114; 
 Fri, 18 Apr 2025 10:19:59 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e540decsm238554e87.73.2025.04.18.10.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 10:19:58 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: Fix memory and file descriptor leaks in
 read_full_file()
Date: Fri, 18 Apr 2025 20:19:47 +0300
Message-Id: <20250418171947.172163-1-ant.v.moryakov@gmail.com>
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

Fixes potential memory and file descriptor leaks in the read_full_file()
function. If malloc succeeds but read() fails, the buffer was not freed,
and the file descriptor was not closed. This patch ensures both resources
are properly released using a common exit point.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/zynqmpbif.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1a52..33c68eac9f3 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -205,7 +205,8 @@ static const struct bif_flags bif_flags[] = {
 
 static char *read_full_file(const char *filename, size_t *size)
 {
-	char *buf, *bufp;
+	char *buf = NULL, *bufp;
 	struct stat sbuf;
 	int len = 0, r, fd;
 
@@ -214,24 +215,29 @@ static char *read_full_file(const char *filename, size_t *size)
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
