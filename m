Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB7CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BA787272;
	Thu, 19 Oct 2023 16:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFbeUIPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39052871F8; Thu, 19 Oct 2023 16:05:01 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2765186F6C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=deathcamel58@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso8910032276.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697724296; x=1698329096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgxDdd+/K/KvVrjjzHtSpqP1mmocc4RGes3eA469wsU=;
 b=iFbeUIPUCVbo6G/y5q0bztUzTr2b1vHt8ZX/Ubw7LjtZY++Jdnw9zNOvauVgpNCtdo
 +hKVy3qk5k7vMq28CGmsdOVMb2HlAckQOlTb/KyEuza4vRyHmQNKaxQtEJOpM9dUtvPd
 AzHEDqx9+WomvOV2ZH9jEmmrL1v+m7WmWsXs5muxH6eKgcoh6Gp3bi/LVD/1TzCO7nCT
 0phF1DoKwhtBVqnlgJs4nh2nC8ecsJOMjkdKb6xOqD/ypplnRrVa92EjWId5e8MKIF/K
 a7/BlziWmTU4RiJ0E6+zogk2xmN2UtZcjBW2L2KCOHN36UQn8A855UgQ3p8mnjOUPHXJ
 2Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724296; x=1698329096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgxDdd+/K/KvVrjjzHtSpqP1mmocc4RGes3eA469wsU=;
 b=ID34YECKXhbzZpIevVeCNdh/sEGfWca/V6/IgahAI4quHxDFEqgCf8vfW631a7BfuH
 mmbUWI4FjNElao2pww7u6r11+Ro+vqcMgx2WiW0KHr8JCREPrfH11STzn3WqIgPHDNfe
 wGAaeU1kHJxgkdAyjLpzFzXa7k65dKnaO17yf2eKMBnHgwzqLhFx3Vb5DembxDFOJlDI
 +cS5IM/xFhXDk75DwFCqVQOAMwvpdsdH0jAwwMYwm2zPaPsCCXpZA4lXeULsofhFPc6P
 YiyvV/CFDMOXpcF0y3unh7sESkwAq6MyvLjQ44K0v0HAIuZ6VZfc57i1q9fyAi6c+VJd
 Xf4A==
X-Gm-Message-State: AOJu0YzlCmHXhTMBPPXmO/VnBgP7r4N0tVYF4CNP+wd9YcqSGyvjiTG6
 3RJtuEN/58bByKFTw894ZLFmi/Tqj4g=
X-Google-Smtp-Source: AGHT+IG9GJMteJPXzwTwF6jgB7rM3NPsQLDeSEAmXdUgJjCui5m8JGRNiURHySgnZyFLk+HSib0+UQ==
X-Received: by 2002:a05:6902:541:b0:d9a:5908:a29 with SMTP id
 z1-20020a056902054100b00d9a59080a29mr2273856ybs.64.1697724296366; 
 Thu, 19 Oct 2023 07:04:56 -0700 (PDT)
Received: from localhost.localdomain
 (96-83-12-73-static.hfc.comcastbusiness.net. [96.83.12.73])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a25b317000000b00d9b4ddf1c32sm2083706ybj.2.2023.10.19.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:04:55 -0700 (PDT)
From: Dylan Corrales <deathcamel58@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Dylan Corrales <deathcamel58@gmail.com>
Subject: [PATCH] doc: Replace dm_dump_all() with dm_dump_tree()
Date: Thu, 19 Oct 2023 10:02:30 -0400
Message-Id: <20231019140230.2132338-1-deathcamel58@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Oct 2023 16:58:19 +0200
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

Replace dm_dump_all() with dm_dump_tree() in driver model documentation,
to reflect changes introduced in commit 145287040480 ("dm: core: Rename
dm_dump_all()").

Signed-off-by: Dylan Corrales <deathcamel58@gmail.com>
---

 doc/develop/driver-model/debugging.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/debugging.rst b/doc/develop/driver-model/debugging.rst
index bbb2794340..e13abddae6 100644
--- a/doc/develop/driver-model/debugging.rst
+++ b/doc/develop/driver-model/debugging.rst
@@ -49,7 +49,7 @@ to see errors. Common ones are:
      of_to_plat() method in the driver.
 
 If there is no error, you should check if the device is actually bound. Call
-dm_dump_all() just before you locate the device to make sure it exists.
+dm_dump_tree() just before you locate the device to make sure it exists.
 
 If it does not exist, check your device tree compatible strings match up with
 what the driver expects (in the struct udevice_id array).
-- 
2.34.1

