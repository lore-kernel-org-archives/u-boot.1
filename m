Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C4C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0CA81E06;
	Sun, 30 Mar 2025 11:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHDe/Nco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7190081A0C; Sun, 30 Mar 2025 11:01:45 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B0181879
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso6522439a12.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743325302; x=1743930102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LW+crjQ+fHQRWWUvN7wI5DOnrUciU39AkoCmAQ40tv4=;
 b=BHDe/Ncox3dfgsOIf5ujnavq2dlvGwsRZPwRV7RvWZ91wSDkydPTHPgAh6NWnAW3wD
 SMPg8eO1Gwmz5LEUcVOjFXJ7PGDccFcIDaX6rN7h4kROp6vFREy/EN8hfW9x4mMvSmT8
 Lb7A63GTmbEIaqaQgiurjhW866j1zreYA0e5HEmhrtqY8QfNhIQChE0rNgjOlfMTgQXP
 d4UOPrztCLRQABdDMiXR5N+ZsjzDPQJOyBgo4Zc9tGapGAVkBfpv3kYu3OKVTUXFtzhJ
 hd+DZLIdMYUHUuO/ZJnkvAs8MmFcPHXDDjKI5g73+Yf3ArpffNdxMve1JlU12Zw7yRZE
 gM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743325302; x=1743930102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LW+crjQ+fHQRWWUvN7wI5DOnrUciU39AkoCmAQ40tv4=;
 b=CXF3wYgvXzyqqXS1/yq1vn930TvpBG6eaSXGvwcAmvg7kIuhvVlKsgmQXYnx5Jo54/
 J3h7F2ZFuURU4Vmzy/ZlXInfvGCZuzIGvZ7iX5+UqOcWbfKEYD8Au5HwqotQw4NZl7/i
 KdP6Dx6hvVJHMB3aW0HLvF12BzHaHS39zyQQ3+rlsC+MK5tMR17VmZ8MdgEb5p+1eawl
 KnvEdQxzcuA1CZeZcW4IHTNGwZCSzbKU3m9QJbMlmFRFsIxqg4FCR73xw+YzTjeVtAiu
 u2hFgvXFEuy6aFCKzL+xIXzFeFLr9ibCHKUEuBtcud3Uk2Sb+C7McqAzH+J2jc2S8PgL
 OKiQ==
X-Gm-Message-State: AOJu0YzCRbiYQ68N0iyvElaJzIi3rJ/WNuxoh+J2HO3P+xvrusgTcgvF
 mVmHx9dAabtsbPOYGjAZsfIt0huiXBluDJLR6r+vCXD8Rndhe+si
X-Gm-Gg: ASbGncv0hJzF0K5wTeRiQduiGs0LNrV/81TuL0Erj5QBBKeHwH470K2r+NDb3OLbQbW
 JYwqUEvsT3tIfGPM1BpG1AZkqcxoGpK96TC7K5llZFh7pvb6Vi++UmWSdst1Drctpslf9ZaAcgG
 JXwqtyJKiR69EKoH6jb78Fr/oWQkYZAVuYxjGi2VJLBtjeSnplPK+IeTb91pxH13a6yeesDpjhe
 aw8VSouTkk1X1bmjaNmiMKix6er+jNrmU5w9zgJb/hHgg5ghT1OSPfXrtkTFW7puEQOFV/jZZ7W
 V5Av05MVMxgThTBZJwIYV38yEj1V+k7aeOmQ
X-Google-Smtp-Source: AGHT+IEP5uJkhKWtOMxNP0ebGAlU0LYvTvzoO8GcOYR2g1mh6jOieak6akBiajOKd0W1Q8yLWHdlkA==
X-Received: by 2002:a05:6402:270d:b0:5eb:9673:183f with SMTP id
 4fb4d7f45d1cf-5edfd7037b2mr4143961a12.20.1743325302346; 
 Sun, 30 Mar 2025 02:01:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16aac10sm4172595a12.9.2025.03.30.02.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:01:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: mocha: add missing SPL_HAVE_INIT_STACK option
Date: Sun, 30 Mar 2025 12:01:20 +0300
Message-ID: <20250330090121.8312-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330090121.8312-1-clamor95@gmail.com>
References: <20250330090121.8312-1-clamor95@gmail.com>
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

Mocha was added and tested right before this config option was added. Add
it to restore proper booting.

Fixes: d6a53f52 ("spl: Add an SPL_HAVE_INIT_STACK option")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/mocha_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index 0cbedb21797..dfeb16ac08e 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -28,6 +28,7 @@ CONFIG_SYS_PBSIZE=2086
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
-- 
2.43.0

