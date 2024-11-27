Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0099D6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342588980A;
	Wed, 27 Nov 2024 18:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="svtJ/DaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0206897BE; Wed, 27 Nov 2024 18:23:02 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30A4D897BE
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d41edfac53so80696d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728179; x=1733332979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvoarqXbCSO3/TlKcs8g3oRI0nBqylQPY3+WYaNAev4=;
 b=svtJ/DaQB/xwOXRm/BeTa7wFHkluPNeAGSAgEJbKCGXj/iC6OAUhqSHHPzta7lmSh5
 Z43lx/05gZStEpogtmeLZIuJOm9GU+RpbYwAZtour2Wi0JoRBOWjeJqFBGx85pntuKc/
 KW2wTCbKk0NWcxngcpWH1ZT9wBX1R9384uDL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728179; x=1733332979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvoarqXbCSO3/TlKcs8g3oRI0nBqylQPY3+WYaNAev4=;
 b=Rx4sh2SEFO/EQtEzcLoiw5o1PaY1crObvaSm180FR3xgkjC5viOhpw0TckcNU2Si1M
 8utlZcU7z46Hfd2o7kTAuwnZdRC3Brjn2Ynd4Cr1YdEEdk9ZVGG9Cj4Y0eNvzHe44wt8
 JncHQq1Idb7Ck7RMvGViR5N1UCeP5f85EBe4iXFf82KVKf7UASYqwYgaR6h5L8UTCEyq
 7R89dIinSS3nhaOqBdW4cqO5hRWeJOmGeFm4diWsGYUqT6DyrbRsRB5FnAqbHQ/FsM/R
 pIKzg14AG1trvM7/ia40V1HVlSUWghkUNOB7rEIc56tSouDGPtBy0JINm2UXR04HhJXV
 DKCA==
X-Gm-Message-State: AOJu0Yy1wLHiqg6HwEtcx+/reRcxPfOY8MNlG+QiJmqjlV7IJjd7F2EA
 Hb5lQV+I7Jh41MvqHNfNyvu/Usa0OdggWKNMHjKwWTNsSx1notlGNcDghYp+RMhAWPE9spPH9r6
 Qf0g=
X-Gm-Gg: ASbGnctDShoRUc0ip+Ajbod15zu0KlbADzXaf4nVBbioDtnGaOHMrm8X/YYcUwBnyjU
 RS97XYViIAtTM/sNHVOsXfnvDmJwpwaJsecWdPhtp91y9vt6W/2Vzk6AMvTwMzqgWo829y73Tlp
 T3hZCfsHAf+jQljzBqx2uUC5gHc83YgDPJGX33VjnVrrOW2OlbGfWtth5HPqZSCwyJW0ghTvMo9
 dj8qjxcuUQUxNT2midkZenInj7aDtdcIGXmYkCeePM7wX1d+RF7CcJwhaQRc73unbi0kF3O
X-Google-Smtp-Source: AGHT+IH7JJEu0l+X5+flWZHP84soOEzxuWEBnBYkevAto5YdButHHMwmT5B18MnNqsXoWwFrU9rf7A==
X-Received: by 2002:a05:6214:f2b:b0:6d4:76a:d966 with SMTP id
 6a1803df08f44-6d864d3c31amr60490786d6.21.1732728179149; 
 Wed, 27 Nov 2024 09:22:59 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 04/12] docker: Use "make -j$(nproc)" when invoking make
Date: Wed, 27 Nov 2024 11:17:22 -0600
Message-ID: <20241127172247.1488685-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

We had a few places that were not using "make -j$(nproc)" but instead
just plain "make" and so slowing down the overall build.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- New patch
---
 tools/docker/Dockerfile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 0f6890b78218..449745712de3 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -142,7 +142,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip \
 	TARGET_NM=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm \
 	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib && \
-	make && \
+	make -j$(nproc) && \
 	./grub-mkimage -O arm64-efi -o /opt/grub/grubaa64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
@@ -156,7 +156,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-strip \
 	TARGET_NM=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-nm \
 	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ranlib && \
-	make && \
+	make -j$(nproc) && \
 	./grub-mkimage -O arm-efi -o /opt/grub/grubarm.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
@@ -170,7 +170,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-strip \
 	TARGET_NM=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-nm \
 	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ranlib && \
-	make && \
+	make -j$(nproc) && \
 	./grub-mkimage -O riscv64-efi -o /opt/grub/grubriscv64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
@@ -196,7 +196,7 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	cd /tmp/tf-a/ && \
 	git checkout v2.10.0 && \
 	cd tools/fiptool && \
-	make && \
+	make -j$(nproc) && \
 	mkdir -p /usr/local/bin && \
 	cp fiptool /usr/local/bin && \
 	rm -rf /tmp/tf-a
-- 
2.43.0

