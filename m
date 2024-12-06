Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46737E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 21:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB558971E;
	Fri,  6 Dec 2024 22:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cw+PRrrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 370328972B; Fri,  6 Dec 2024 22:10:34 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDD58913C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 22:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fcf59a41ddso1928656a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 13:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733519430; x=1734124230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GjM+TndTJl/rgL+5c3pq77lqaU/QRa0nplQnilA6BPk=;
 b=cw+PRrrWjcGcSXakyTb4k6EN2QCCkCeWHs8FlccmhuT9jON59X4V9SqXIFuKXGy9d4
 WJTFkBIDhaK/NoBGorO1cqndjNmzvWsmkAFCoJkMJ2JOY0nd9eCBMC718vmaN+W4TJ+D
 E9zi3RHmRBSdnyn9OwI9sB3loi36UkXBuY/GLR3Y5UnblB0mWdtjfuq97YubOugYgUrP
 jSorYJGLaJr2wjPExPkRFTjA8yzxojv0/1WXL4wmBWZFCSAmbilGyVVvNLPIDRCB1UKz
 9kpya9qOXPiKBNZQUYAisQjDyu2uePvbcXnMsUXvoejb3PckH5AW9xoBqaRwixsDqZs1
 7icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733519430; x=1734124230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjM+TndTJl/rgL+5c3pq77lqaU/QRa0nplQnilA6BPk=;
 b=h0kKNkI3cb3GX3IOPUSBtH3Pk5fpU0CMVOv9ozcmgcmokF0Bvyzfu1GHea0WRgwFWX
 IVpGgCK8p1SVdQFpEX7d4S0wOFX2kkkAI/+fo8V8IXI9X7voLZlSn68J4Z6QvWLymIQi
 qitkNIyWRP4BJxCv+jL9pQKLKba7JNu+Ttxi9FtKXQRfQVC4RBMa66rQUBqSWg/EfemE
 wOjAX92gVwAWh6iahz5GbTkEiyWB9N1U9YrHWsvm0OsfM4uFvMSNEfCDwRSDSqqYpNjF
 KEBhe58nsOInxbHIYRBS76sTizlhnweZhyMV877hstXJRKonbJpjr6Cy2HQWYHVJalKY
 eCBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKmpLUS24wIGD2vciWhnzQvCal6jNDjW3EMAKzJfeZj4ICSxO4Gyf2DVeuL7cWV9J/ZSqQhFU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl/P68KNCAEMSN17HGoC50xH6TU1JWQW99me7YPwfsO1mzb4Zq
 57vlV58JBLM85LTmghx44WZG3qL7ERxZYVXECVdZfg9U9VZ8q2Du
X-Gm-Gg: ASbGncuZbkDEi9NPmhXc0oUyalPP+GFVgRtxk8njluWx7AzickMojwyp46hkQhjpaG6
 PFsZbCjLuuhUIYkjLuIwPLgBPOLbcQZNw13Zk1s3+9am9lTscini8IFoYu9fZg139KOsJ1CIprI
 RpBM2kq6zSmwEb0cGVhh0Bqrq7mqfHi7nkjt+kVRjsOszXSOIW8bYqSWTwz4Mu1wKUHOdRlGkOo
 sb72FZDOaEmEqIXpWq1xddQ4r29Ar277c568YsciBm+1dlRsw==
X-Google-Smtp-Source: AGHT+IEoxTVfJ1soR5yOUp/Xp6IACD7Z/w3FhB0SqOFhAHKupBO6vbM2MZkzfbwtjwAkNDqBo/4Lvw==
X-Received: by 2002:a05:6a21:99a2:b0:1e1:6db4:8a78 with SMTP id
 adf61e73a8af0-1e1871371f4mr8418360637.40.1733519430372; 
 Fri, 06 Dec 2024 13:10:30 -0800 (PST)
Received: from desky.home.arpa ([2605:59c8:492:c300:85bd:2876:4605:c4df])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd157b1e44sm3041781a12.63.2024.12.06.13.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 13:10:29 -0800 (PST)
From: bschnei@gmail.com
X-Google-Original-From: ben@bens.haus
To: Stefan Roese <sr@denx.de>
Cc: Ben Schneider <ben@bens.haus>, Benjamin Schneider <bschnei@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig: enable
 full bootflow functionality
Date: Fri,  6 Dec 2024 13:09:57 -0800
Message-ID: <20241206211015.9640-1-ben@bens.haus>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Dec 2024 22:11:09 +0100
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

From: Ben Schneider <ben@bens.haus>

This appliance has multiple devices from which it can boot. Enable full
bootflow functionality so users can choose a non-default boot device.

Signed-off-by: Ben Schneider <ben@bens.haus>
---

 configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index aa9026acc3..6f1a66f5f1 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_LOAD_ADDR=0x6000000
 CONFIG_PCI=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
-- 
2.47.1

