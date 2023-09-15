Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9F5CD37B2
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 03:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2831E8653C;
	Sat, 16 Sep 2023 05:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="OKamMQxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A34864B3; Sat, 16 Sep 2023 00:12:04 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2840F86489
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 00:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yoann.congal@smile.fr
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31ffe67b5daso155440f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1694815921; x=1695420721;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NvRP1qbH3u0Y9gIv2IyDI2v/V71u/V/MOWor7iwt5jU=;
 b=OKamMQxTNwdfaV8zjjr8Qz5jdwiWYJ4SFp7R8tw516vi3kUU1+hYNv7tA3vyaBm75Q
 xYDkj3jv1KALJtVbmJV+x2ynOcWLhhGN72gsGNEZwHEZl3Z3nQlBwzDGkELXcC3OlfCX
 3nCj4shIwRDpuKkO+rage9m6u1TCOetlwN9c1UbJxFBJ2p527U5RJkR8lKFsuNxve3qB
 OF8XpJ2rkV4QZlyJ4unJCcVhLERLHMAXpxitI2SSIx7z8e1wHZ3mcaX1zK7160f57ejR
 tq46/f6Eo1P1UupMVlcHGH4KlQyr9w1txd3ufIB18ZDWGuvazQ2bAwj26vYW9rYqMZNb
 hYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694815921; x=1695420721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NvRP1qbH3u0Y9gIv2IyDI2v/V71u/V/MOWor7iwt5jU=;
 b=K4saabeujB/0FawXTW+fmESNFLZHA7FXunieYRFxZpo268g7LI9fdkKFa3ADR/2+kE
 D4Qk6V+0ZJya+5rmc7BSYPPNTcFsULgqzPaBm2TXyY0p9iCFtTb3gplz3rzn6t4l5plq
 wGQ+Eoh+drSJlpAu7OCC8H9lCYcJn9RdWfb17LqGClkYd0d7Bem3gcTdafbAu1YQJn0C
 Q/Vti44BlX1tGEjjrWilfS8qXf/5jQsbFJVs7B8IYdiyWCghjvlDC3Nj4eSPp9WKIQmf
 pjIwt3v3wInP7DC8S/MK8SL9p+m7OjvpDhxOFsIuanG0YcwQJlL62biZY2GJNr5vfnMs
 nCRw==
X-Gm-Message-State: AOJu0Ywrogtk0hWUZtKZ9EgRqmxb/Q3MPv//UUGpUyywJK9QM3EYQamo
 MMtT8vL2pLkChQeUeNrvBf6XL52xcSR2QifsDzM=
X-Google-Smtp-Source: AGHT+IF7ihqVkaKsS6PuSJjEW3YCCurmTS5FYz0eu4jLMeFJJ03I9lQhEebdTEH3ekuMW/CypgRIlw==
X-Received: by 2002:adf:fb08:0:b0:31f:e026:30ac with SMTP id
 c8-20020adffb08000000b0031fe02630acmr2128646wrr.34.1694815921128; 
 Fri, 15 Sep 2023 15:12:01 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a5d4dd0000000b0031c6cc74882sm5390694wru.107.2023.09.15.15.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 15:12:00 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Micka=C3=ABl=20Tansorier?= <mickael.tansorier@smile.fr>,
 Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] doc: usage: load: document part as hexadecimal
Date: Sat, 16 Sep 2023 00:11:53 +0200
Message-Id: <20230915221153.2767153-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 Sep 2023 05:32:51 +0200
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

From: Mickaël Tansorier <mickael.tansorier@smile.fr>

`part` option is in hexadecimal, so information is missing in usage
documentation.

Callgraph for `part` parsing is :
do_load -> fs_set_blk_dev -> part_get_info_by_dev_and_name_or_num ->
blk_get_device_part_str -> hextoul (This is why it is hexadecimal)

Signed-off-by: Mickaël Tansorier <mickael.tansorier@smile.fr>
Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
---
 doc/usage/cmd/load.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
index 1efee773179..2c892ee1cb7 100644
--- a/doc/usage/cmd/load.rst
+++ b/doc/usage/cmd/load.rst
@@ -40,7 +40,7 @@ bytes
 pos
     number of bytes to skip
 
-addr, bytes, pos are hexadecimal numbers.
+part, addr, bytes, pos are hexadecimal numbers.
 
 Example
 -------
-- 
2.30.2

