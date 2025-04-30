Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC30C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77C982C03;
	Wed, 30 Apr 2025 19:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sairon.cz header.i=@sairon.cz header.b="clQan9v4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D37282C49; Wed, 30 Apr 2025 19:16:05 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B02482C2B
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sairon@sairon.cz
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so5389166b.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sairon.cz; s=google; t=1746033362; x=1746638162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EOqBxfjTnNqFtaQHZ+Bg4k+vLIL7mICU2BW5EpLqyOE=;
 b=clQan9v4a3/WU5v4tzk+Eus9kKNKuX1DInSwl0lFWnCy7Ii5ZG3uo64iWGR5W6kMfg
 DKQbMFO1Lf+6pQJh1j/1Ax2ddoYZDxk8Zr/ISqBZeLu/arRs96VfijYpGabJgu/97Ht7
 ILLcSmH4fq7sj0GfRJvr/Z+vFgn2XOw8/Z9g7cD8giHm/28zmSILGHW8xzKP0xjDmBSG
 hR7doAeX94bKXkPvy+MVZuPwU1F2jIyXFdHk5Dn+fO2SsGsYn+b8aZfEGBLBks+1Ep/f
 QPaHzGW1+xH2k2/Gao8ddeDO5+f+Cb2yB4lTlhfyfCq1F3U+UCcPq2213zJ6O9dShaK1
 8SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033362; x=1746638162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOqBxfjTnNqFtaQHZ+Bg4k+vLIL7mICU2BW5EpLqyOE=;
 b=v327Hz68sMSR3H3Hl3wFo4YR+98zgVrsYPa1I9BjulwYGlKUBCU0NzZ+uaOeHQDCi5
 pAhG9bAK4MArEo4nHomS2ervCxnUVTWvE2n80BW/m9KQlnh1x+QPhDnbxqhq4wonQSt2
 sPkucIl38PApBFeKpGZWpHpWs4PEJsnQBOhQejXIPLtAfG6IUrsuU1D455FPxC6zQWIs
 ngSvuYoiN9ISoQZ9sBirySlKKvu9hS/xDImkxTsgVvi1QR+p+akTTm1PYeNbKJtuWkHh
 ywRTC8xjhcWb3iqu/oi35gh/DWKOYBc2AjxZp/l7fSpYiJSnA4McT706D4Hbt4nUYvfC
 rY5A==
X-Gm-Message-State: AOJu0YwPSh3B18MoyeOK1ox4PuDM8OG+tYGVTYuw+A2dN6VDpQPwOoS9
 ieGpXsUWt3iGe8A6fvRUmgxi2Ztrv9Xrlr5aLeucnoOu7xoi4tsTiO9xBryGwMdMGGAcP8G9ycB
 8upQ=
X-Gm-Gg: ASbGncuzVVFDvMhpFRpfKWNireOx1qmRFV8j8I3TMszOpzqNijHsV68p6/2Mz/ETy6j
 XJn8ujCGgWaqCCnNWkrnJ8TJ9aoh0hCANgMQkuF7FjFf2ZGGDJVtSnzZWAQqMY2DN2I/297OMpB
 UZEu5u3P37ymK02G3Pg697z2NR921/qd9RxWfO3/ThupY8unb13oxlVTeLaYyw4lMT10F3JOohI
 R+l4/ydM6GNk21YCH8rFlZF7n6AhJDGvMyCnxFb8l3S9jnC5McTsXQe0VYab6iXgnb6jITwWWhO
 tx2nEF1tqx+dsgQjEo5IxUn4GwRqmIDH5sXQhqf3934+Hukpe0CaG1xePIaBtxVmPM/i
X-Google-Smtp-Source: AGHT+IEj2F5pdkt4YzKpcz5TXIlXAFAKZ8UwWaBNYkPKt/zrnbd5O41eeExPypCj3gtogoI6IReU5w==
X-Received: by 2002:a17:907:3f86:b0:abf:4da0:28e3 with SMTP id
 a640c23a62f3a-acee21ae31dmr390184566b.18.1746033362251; 
 Wed, 30 Apr 2025 10:16:02 -0700 (PDT)
Received: from krabice.lan (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6edb1580sm962044066b.175.2025.04.30.10.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:16:01 -0700 (PDT)
From: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: rpi: set NR_DRAM_BANKS to 8 to accommodate RAM on
 16GB models
Date: Wed, 30 Apr 2025 19:15:35 +0200
Message-ID: <20250430171555.144243-1-sairon@sairon.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Apr 2025 19:31:44 +0200
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

Raspberry Pi 5 can now have up to 16 GiB of RAM where the memory spans 8
DRAM banks in total. Increase the config value to 8 to initialize the
whole RAM. Without this change, kernel only sees 8 GiB of RAM on the 16
GiB CM5 as reported in [1].

[1] https://github.com/home-assistant/operating-system/issues/3989

Signed-off-by: Jan Čermák <sairon@sairon.cz>
---

 configs/rpi_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 9fe5d177943..69e8e72c5d7 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_BCM283X=y
 CONFIG_TARGET_RPI_ARM64=y
+CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.49.0
