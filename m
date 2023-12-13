Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BEC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 12:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385148747A;
	Wed, 13 Dec 2023 13:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUtovC2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87EBB871AA; Wed, 13 Dec 2023 13:13:59 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 827B2871AA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 13:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so9504400a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702469637; x=1703074437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LwzAgYguCUI3fFT9g4IbBFSqWUc8RX17VxSC4sRkipo=;
 b=lUtovC2mbJnQVnCO4JSkbCOnQJfRXk41GkP4WH5lclhZIz27yoa8Q7MJLw4SNfN13K
 tNQQwxr5jtqx6adHrMlCXicy6ntHoMNzQVLOVPSazrKOLFvB9WCMDYolvMX8TPZZp68j
 he/rCYWm1n2JGgav32qk4vtmSlB0CxZTzEzJeoMuB/g9TZaMgwNuiywu5Kj8DydqRfa1
 MiN4F+17hHQ56CV83xjxXFAuxmXKqQ9Nj1jHeYpxSc//1vlryXn3uML+5C/JBYVnNdv6
 9y70eb9FiJuzswVtzfJxKln21Vxc5VKz+yNj1r6o7psXxy/WEB2nCD5fZF4jONXJ7wyw
 89Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702469637; x=1703074437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwzAgYguCUI3fFT9g4IbBFSqWUc8RX17VxSC4sRkipo=;
 b=i26nCWmoZ79MuUSUk2Fd0G1BS0lnoeAZfgKJ1u4Ll5PRtcQmzDqnX3mLNMeeYSToNg
 e1g8YFYKGkIZQQxw1O7jejNhSeJZ38r64whtJrJRq8IE0Yy6YVa0njjDlYQhZtbcLjsd
 y0pK85HxOn/dyZtX9wZKrhlZ5+kb3QRvYyTRjjobZfpvzLPebA6PN0/buK/u8SoNKD01
 ZZ1806wo8sDmVntxS++GmDCx8+HynhYkJ0jtTg7IeKMtZ4uzhGC40a+1IfXFfvL/P8Rp
 aKMoOUDuerpKGNPZGkeMP7ZMfKM+OW4QaHiMLy+JgiZLa4o1IENoiZ8d45aCx0Gp3I9X
 gocg==
X-Gm-Message-State: AOJu0YwRgsuepcE5dFY2FtizmUwVkPILZGn+LGAZfnd59dwm/mhIEYf3
 X85C2Q8kGPN9l4QEy8O2XOYsqClM0Tg=
X-Google-Smtp-Source: AGHT+IEPeT0yRe6XSdVA8ua+ZlZHZCWAo+2m3ZxVqo7eCQS3+N0AOSd+fQbPM0DCc3NaXz0CLy2prA==
X-Received: by 2002:a17:906:3613:b0:a19:a1ba:8cbb with SMTP id
 q19-20020a170906361300b00a19a1ba8cbbmr4079966ejb.89.1702469636763; 
 Wed, 13 Dec 2023 04:13:56 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 vb2-20020a170907d04200b00a1f72df5617sm7288192ejc.141.2023.12.13.04.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 04:13:56 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] fw_env: keep calling read() until whole flash block is read
Date: Wed, 13 Dec 2023 13:13:54 +0100
Message-Id: <20231213121354.13303-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

It's totally valid for read() to provide less bytes than requested
maximum. It may happen if there is no more data available yet or source
pushes data in small chunks.

This actually happens when trying to read env data from NVMEM device.
Kernel may provide NVMEM content in page size parts (like 4096 B).

This fixes warnings like:
Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 16384 bytes but got 4096
Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 12288 bytes but got 4096
Warning on /sys/bus/nvmem/devices/u-boot-env0/nvmem: Attempted to read 8192 bytes but got 4096

Since the main loop in flash_read_buf() is used to read blocks this
patch adds a new nested one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 0347e9d15a..90010dabd8 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -948,29 +948,25 @@ static int flash_read_buf(int dev, int fd, void *buf, size_t count,
 		 */
 		lseek(fd, blockstart + block_seek, SEEK_SET);
 
-		rc = read(fd, buf + processed, readlen);
-		if (rc == -1) {
-			fprintf(stderr, "Read error on %s: %s\n",
-				DEVNAME(dev), strerror(errno));
-			return -1;
-		}
+		while (readlen) {
+			rc = read(fd, buf + processed, readlen);
+			if (rc == -1) {
+				fprintf(stderr, "Read error on %s: %s\n",
+					DEVNAME(dev), strerror(errno));
+				return -1;
+			}
 #ifdef DEBUG
-		fprintf(stderr, "Read 0x%x bytes at 0x%llx on %s\n",
-			rc, (unsigned long long)blockstart + block_seek,
-			DEVNAME(dev));
+			fprintf(stderr, "Read 0x%x bytes at 0x%llx on %s\n",
+				rc, (unsigned long long)blockstart + block_seek,
+				DEVNAME(dev));
 #endif
-		processed += rc;
-		if (rc != readlen) {
-			fprintf(stderr,
-				"Warning on %s: Attempted to read %zd bytes but got %d\n",
-				DEVNAME(dev), readlen, rc);
+			processed += rc;
 			readlen -= rc;
-			block_seek += rc;
-		} else {
-			blockstart += blocklen;
-			readlen = min(blocklen, count - processed);
-			block_seek = 0;
 		}
+
+		blockstart += blocklen;
+		readlen = min(blocklen, count - processed);
+		block_seek = 0;
 	}
 
 	return processed;
-- 
2.35.3

