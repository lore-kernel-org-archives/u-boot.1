Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F4BC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 17:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA87988851;
	Wed,  3 Jul 2024 19:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ay75O6oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEED688855; Wed,  3 Jul 2024 19:57:45 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDABE88818
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 19:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-72703dd2b86so633509a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720029462; x=1720634262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WsIz8RdAflFIdi94i0sF/9cYYrY2y3oGThPRud6PjoI=;
 b=Ay75O6oz58ZjMDs9b1VFZOoy3MIWVz0AruFDr+rjoL94tab6hnguUUL9UWmdm43fwz
 5A1gI7gj8rqcpqobklFNzeg+e+VUY32vXwi5Mxa0KFj5gY5ONrU5nVcBPUzeKWTYXA6J
 1PhdF3n9oCZX1GOohTil0/+ZUNCagyAc00jZHijcuQaIulSrjcLwkW8o9c62cpBWEer6
 NrbvklqHy5pP9ib2dHmqCzed59uLMDozF933Lq4yWEMI1tEXC1t4qYJ/Re+2IxE/HIVH
 ORyZ+TYa1O5opiYc1caomzuD1IEmJysWY9LU7AWkGft0btZiDOvfgDFNd5Bjrwa5Cg55
 rrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720029462; x=1720634262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsIz8RdAflFIdi94i0sF/9cYYrY2y3oGThPRud6PjoI=;
 b=tEzcBO0JR6Ocum0UTRmfLMVxF8lGCUKcOBVKNMUZ47jab1wVyYf21WgSTGrFv4Y8GI
 2q0ZVd4rrikjWb8T8x3OlheGm4X/GiI8W2fwET7+Lj3tz0eIe22R9uZoG0Y4wpTEVlvA
 D1UDtVogPBYK5WdYv2hPPKXTzFyTDPnAQEOpm89zDmf3UtmVAPRXd8YKah4TjJr4C09+
 fcYnEIOh4vkaTIFXqUfA9X6SP8Jfzy6d8I6Qf5ZbsMcinagD8hCtku9QIvkhbE1hoypF
 hDMvYf+DpLNL3MJGOhumVybDl/3sCUOFjgl957W1A0CBh24WGENempR8KBS2Jwc6yPh4
 QBSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSP2A11EXy6I1UYyvHoxm6FE+6qQ8fKzfMr5CRIGMPNMeiL3aIUdS0RHD9mHvyXiN45WYyqU8PAyq8UAJbeykCkrNFfg==
X-Gm-Message-State: AOJu0Yz5GSE1vqnl+HZ3Ndt5bE3Ff22T0yT6VGx3qGgCT8PzZQEHf+cQ
 gOJ6af3q/S1xLGcWkHv8XiKiOGIh7FIEYFZJtknTwwO8eReKkYqu
X-Google-Smtp-Source: AGHT+IGsLQ0Soo5ZcIik3/suM5HdVBhYsEjB83r0d4AqZrGM/UwO1S5VNAwCnyO4Ej742LZq/6Vh5Q==
X-Received: by 2002:a05:6a20:7490:b0:1be:c3fc:1ccf with SMTP id
 adf61e73a8af0-1bef60fac31mr15966640637.2.1720029462215; 
 Wed, 03 Jul 2024 10:57:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b8a2:5329:f702:6533])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246f656sm10688788b3a.65.2024.07.03.10.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:57:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: ian.ray@gehealthcare.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] msc_sm2s_imx8mp: Adjust the initrd_addr location
Date: Wed,  3 Jul 2024 14:57:27 -0300
Message-Id: <20240703175727.446205-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Booting an initramfs with the current address may lead to initramfs
corruption and boot failure.

Move it 0x48000000 which avoids initramfs overlap and allows a
successful initramfs boot.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 include/configs/msc_sm2s_imx8mp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index 3c7d96cb3c0a..2a52455ace34 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -39,7 +39,7 @@
 	"fdt_addr_r=0x43000000\0"			\
 	"boot_fdt=try\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
+	"initrd_addr=0x48000000\0"		\
 	"bootm_size=0x10000000\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-- 
2.34.1

