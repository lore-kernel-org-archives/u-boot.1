Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2FAC83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 17:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B151886741;
	Sat,  2 Sep 2023 19:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPR4DoWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6758B86758; Sat,  2 Sep 2023 19:15:04 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBA8866CF
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 19:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso565641f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693674901; x=1694279701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=oLTUk3sfwEKdrnKVYSVf55XuUxs1fKx07R33W5O6ie8=;
 b=FPR4DoWY1EWdLXi8oUiw0hBHwn+joc/nq06p8JQ8zS9PYq6v5yiDZFhksrHxsZ6lob
 TQ1mu+2kX8JY6wvyD1Ioc/3IeObVwWdi19DGxdqqHEoEbETqceJp1YI4Hc2mc6uznkjh
 e++YihOWoZuXbbmBiHn4JumHo1qoLIRPCJQVKpqR2Yafaepygg8N5/eVpUshk9tj0i1S
 y3VIW3vLzB3bKsw3cKzL1jYvrRpw8wHoOm+1Rvlg5ytgoVMVt9EZCrZvTY2n2+FPxVri
 DKACQbYiQWjjkvPj/xQUL6YEsRdNDkAx5irHUQ2I0/syqjrzCcaA2YbdLhDSEQESuzFP
 Benw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693674901; x=1694279701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLTUk3sfwEKdrnKVYSVf55XuUxs1fKx07R33W5O6ie8=;
 b=PsvL449kUvaEB5Pn3qZxtGBWDAEy2d2G7CS55dkI4GrN6iPJX6PLsLpc1ymOi9FyZy
 dBBN3VQJAkoMrJA83ryKbQIL6WUPQFfusm1b+qEtX+K0aJCF7C8kdAcS8N58uKqVr8+T
 jt7mc1JY7IIEaZa6ddQYY5MOjbKBD7K5xTccbpnyOMp1jZrPN3tkGbnaV1wk7TXBmdFp
 Db7Q7nO4fz2vPx00HQ7WUkgEDMDm5mQIheyb4MM8mMTSjkXliphF8JEFT5cmPZi0b9ka
 lYUFXC8xfQXjrNFEcuKtrm7YwD/8Nfgbu9OtNZ1Rc4s7dm6uuKmDJWEZXZbDg1ALNzal
 XiAg==
X-Gm-Message-State: AOJu0Yzj+eH3aCGANI0qh9sxepvXngWmte4Z8fgW7GhDle4/7+BmiIHc
 hh9g2KxEKxdkkamvu+RRnvA5bEM/obDhjw==
X-Google-Smtp-Source: AGHT+IEOWtHlVnmB8LBg3Ja24004VITxh6qx4drVDQWJrvsJ1IwM7ju9L0dYA064ITZtiYYeYZeHuA==
X-Received: by 2002:a05:6000:1291:b0:315:a235:8aa8 with SMTP id
 f17-20020a056000129100b00315a2358aa8mr6527853wrx.2.1693674901187; 
 Sat, 02 Sep 2023 10:15:01 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.185.187])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a7bce0d000000b003fed630f560sm8562841wmc.36.2023.09.02.10.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 10:15:00 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 1/2] configs: rockchip: add DOS_PARTITION to rock-pi-s
 defconfig
Date: Sat,  2 Sep 2023 19:14:48 +0200
Message-Id: <20230902171448.351737-1-massimo.pegorer+oss@gmail.com>
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

Without DOS_PARTITION support U-Boot is not able to boot an OS stored
into an SD card with MBR partitions table. This is still a quite common
case so add DOS_PARTITION (only for U-Boot proper build) to ROCK Pi S
defconfig.

Reported-by: Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 configs/rock-pi-s-rk3308_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index cc3274a98b..1c1fdc6611 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
-- 
2.34.1

