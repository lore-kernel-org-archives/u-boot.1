Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C618DCEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8820F842F3;
	Tue, 18 Nov 2025 19:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b8vcOqch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140BD842EB; Tue, 18 Nov 2025 19:04:40 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0261B83FAF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4501b097976so2773476b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489077; x=1764093877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YMETKe3zJYeq09rhPH+1Fs/HiPVbEtybPs/ZgNbD5ko=;
 b=b8vcOqchzi/et72WpCVyV8+JXnJl1CdRdMHGYX9+dDfM9phfbIAdnsuMaKic4gsuqt
 +DG12BL3PoQ597lEwTtQHB/xL2VKVvKvKcyvUDu1PpFu4ctL+1Q4xDAtKLaSmYweApuO
 33a8ZI6K9Ro6HvzR5e2o0H1gB137DcOfmQtjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489077; x=1764093877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMETKe3zJYeq09rhPH+1Fs/HiPVbEtybPs/ZgNbD5ko=;
 b=dxxcBTnsmnTMv3ibyWVXtvkSLGrJj9WNAI+A82XRf4QRL8e6w/hzVmxW/4XE/vwATF
 +WooiANN0mnCz9SVHTez2ils3anKHFuL5iWrs+LRcfc/B/XC/S+IwnYERwGwyfMgWoT3
 0xR7H7xJ7wSE/uoAwlxcjJBVwMAj2XFoSWeQwpi7QGXZUBD+eWEo1CaLyTQfR2Spflno
 cMOeOnjbZT9cu2vzuE+wBkasmpYg9KF+BuQuAXB73rYjL1jRpsIHo5/oYothCIUZu4VN
 TqFIlgWkUAgSmbjJ3qZG/1tZSK7pySuogEdcnOS9x3oHl9C1xWYwk1DQdqBxvUeh5hPh
 QghA==
X-Gm-Message-State: AOJu0YzqyZYK6ICi92ewmnn3Rp6gCEFmvE1E96kiFu64BmvpMQjhgxaV
 0IF80oJE0jjVW4wxnZbo4t/dA6Tfjo2xXO0/jR+DAPpZI9sWMl4Gg0EdGEOEIXvoMao1Lnxa7M0
 eIo9Gm9WfVQ==
X-Gm-Gg: ASbGncsKO9CTi8/hu+jfGMkAb6Rtsbl38GwgdYIcxTt/a67HHkHizccplwbA8h8oRgw
 WaOVKz60M/mdArmAitxF+Pw+84orUUV+owPZf+d3AyIqH6M7EkoVzWHw4k5TPbJPGGBoOLN3p87
 bZkVYUHd8HUinnjurbzQt72mJndSBAUmkFD6pOjgEo9C5aDEP03l0+yZucjoWCQEpSYGn9upNDa
 jmuZdIwXGXCGTkbasgiEh+c1GjMZyNXEGVarotWvXGzamJGMnOcEcB8OMTT+d5b0ZTyd6m7rjQN
 cPP9au+11DKng0+4PHbKVjoyK1Jg1ofQYSPdxwRsq9HYiPD9K/EAXZjY7WGMC7QXw4bdIMIHvhu
 7RsvcKfp2P8sutzUX+FfTliOotxKikrl4D6Nw9nkFXBi0eMpBV1iLjHKHC0GkfUbjD8UgG9lNqX
 kDh65xTQui8nUjtlrCeFq5TFewZ3Hv0b6UahVjAl9y3Vv7KmXkFxBH
X-Google-Smtp-Source: AGHT+IFTq8HS4Lqk9Fp8FGdxvqq+r5zhkfYWfmrIoS2z8UYgGZCdrmcS/qCAVKZpHCk+t+IT5T22zw==
X-Received: by 2002:a05:6808:470b:b0:44f:6a32:5364 with SMTP id
 5614622812f47-45097472700mr8041341b6e.24.1763489076687; 
 Tue, 18 Nov 2025 10:04:36 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a553f2asm5362334b6e.8.2025.11.18.10.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] udoo: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:35 -0600
Message-ID: <20251118180435.591502-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/udoo.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/udoo.h b/include/configs/udoo.h
index d85cf7808c7e..a1efa4ff9450 100644
--- a/include/configs/udoo.h
+++ b/include/configs/udoo.h
@@ -17,7 +17,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc1,115200\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=undefined\0" \
 	"fdt_addr=0x18000000\0" \
-- 
2.43.0

