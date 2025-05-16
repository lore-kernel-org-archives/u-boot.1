Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D5C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA728006D;
	Fri, 16 May 2025 17:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+n5D5Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9A982998; Fri, 16 May 2025 17:25:54 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A3C78129F
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so23913775e9.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747409151; x=1748013951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M7OnFqQC9vmPtOx/grx76LrORgu7/IPi6GTTAkEqoYc=;
 b=D+n5D5Ir3VcgtVT34cbzJlY/klAaYalbc8uzr8N4QZDKo/87Fr5lLRjb9OlzpeKyRO
 yRemeP4kYhOZ6wlXEfBiKu4oFn+W9gfury47IvmiR3jE2gWwxSstxI274xF6uJZbeZh/
 Bne31qjXAp4G6r2kF3TbVlKoqGw110l+ruVV3U/dCN3CCePbRUyJzZ541O3XqtA44yxI
 Z5NcWs3+i4vk1xKp0UJSeOzLm/xc1Ck0u5UH9gCXHiE5RROokLZLonGjjDZqmy484C1s
 nBcLMe/zQf9cfdxXSSQ7bOdskCq4TiEs4am7v7h5J6nKHPuW6FH4/hog2PaGPM6tGS2f
 6MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747409151; x=1748013951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7OnFqQC9vmPtOx/grx76LrORgu7/IPi6GTTAkEqoYc=;
 b=BIeH0gDHJeVdWC9n6xV0kT7DluP1CYFSb1sKiJq1br1Bub1NkYOSi0nXiEG7JKmSfW
 fLlFSs9hWCVE7NtF/rC43oUaCLwxwWwyLZP2tM1ZJ7G+U4hQityfBOz0q+cfgrKAwoi+
 iXvtaBVKrEWtlOcq9th/KsOii7XuOn+WiUwoJeYfFxpvrx3BAuZjXN+Oh5z5jJeOk5X7
 hzpjXF3AwHFo+OQ+p0aH6FebodIIbiL5/w8eBZCM2TlqNW6BdJ9PXtT8Lh/z2qk8dCIv
 WxV1Qq8V2aH0DO54T2QCrJq7OpV3RI3A+WswJjuQIXRfwbDF5O4yL8tJQUDQ2ARZzsYw
 bt9Q==
X-Gm-Message-State: AOJu0Yws1fo52l4gHtFJoA8HiclMNtcBH94bCVssaozjfIs8XSsNmsFT
 itwXTr5tgJaK8qE7UDKYxtSjBUVKVjTU+H6+dL9lzdrT5T1UxqjfJGq+bmvE61S5
X-Gm-Gg: ASbGncsiOWxcxAm02ZmnlmTeWfPZ0AFfLm9IzsNYqt2Q7/qq1R+0C0+u6w3unYHpjED
 iqnxXWkhSeMBHAY7WZhP3b0fI+5F4H3nMJpUYZhvmGUiSKCtCbh1W5XzoVf+lfUpX2fCpxC2ba4
 z7Tf5dbOp2BrCVBBmRowrtdMIj7GsAfE5LJTS36QuQNvtttKsiChoQMjy77B0En7hugfYE58Mox
 lm5lpUuZzKiSEmYTUxVYhpNvMSsY4fyxn5o8jHoW9c3Tk97O1MAXGMAtao+5Kgtt9uIs1ndKunh
 qDa5jAtog2dtihqPE3OCQ4g3ma6U6CMC5ILlrD8RAozOWP2HnXQ7BaH6LVDXAGmHVumjF3YiJjh
 xXOWf+kzYVmdJ+Lt7WQ==
X-Google-Smtp-Source: AGHT+IG1PUBHaZ0Gr2XG+0Mvmt/mD8lYsgfRrbGD/1ur+fFH/y8D2mPTR+vZVIpS8AloxRyHq4eUmw==
X-Received: by 2002:a05:6512:31d1:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-550e72418e1mr1571222e87.46.1747409140742; 
 Fri, 16 May 2025 08:25:40 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-328085b8f15sm4579291fa.83.2025.05.16.08.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 08:25:40 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: fix handle leak in ifdtool.c
Date: Fri, 16 May 2025 18:25:38 +0300
Message-Id: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Prevent file descriptor leaks by properly closing 'fd' and 'new_fd'
when fstat() or write() operations fail.

- Added close(fd) before return in open_for_read() if fstat() fails.
- Added close(new_fd) before return in write_image() if write() fails.
- No close needed if open() fails (fd == -1 is invalid).

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/ifdtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/ifdtool.c b/tools/ifdtool.c
index b70570361f4..5db6fa7d195 100644
--- a/tools/ifdtool.c
+++ b/tools/ifdtool.c
@@ -499,8 +499,10 @@ static int write_image(char *filename, char *image, int size)
 		      S_IWUSR | S_IRGRP | S_IROTH);
 	if (new_fd < 0)
 		return perror_fname("Could not open file '%s'", filename);
-	if (write(new_fd, image, size) != size)
+	if (write(new_fd, image, size) != size) {
+		close(new_fd);
 		return perror_fname("Could not write file '%s'", filename);
+	}
 	close(new_fd);
 
 	return 0;
@@ -604,8 +606,10 @@ int open_for_read(const char *fname, int *sizep)
 
 	if (fd == -1)
 		return perror_fname("Could not open file '%s'", fname);
-	if (fstat(fd, &buf) == -1)
+	if (fstat(fd, &buf) == -1) {
+		close(fd); 
 		return perror_fname("Could not stat file '%s'", fname);
+	}
 	*sizep = buf.st_size;
 	debug("File %s is %d bytes\n", fname, *sizep);
 
-- 
2.30.2

