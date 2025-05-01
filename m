Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91252C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 16:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E14820EB;
	Thu,  1 May 2025 18:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BWWP+EK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB3B820E2; Thu,  1 May 2025 18:47:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF836809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 18:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2cc82edcf49so349773fac.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746118044; x=1746722844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7QrpBlZC1qtV+TcIJ9NU2lYOOqmkRK6SFzr6byITe0=;
 b=BWWP+EK9+/leJJ0qW8AsEyhCJhn68a0ME5QhcUFSEDx3oQV2ewkgx97clXcXxKgRx0
 FRMuxBqXsVyTbuRPHQ6G5+FiIyVTljdzcZ/3qAAO7HQ+82JM/Ng06zgRq+mGn4dLeiFv
 9cdExx4nJczhcQ/A6E4r++zbKp5ayzfeQNBk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746118044; x=1746722844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7QrpBlZC1qtV+TcIJ9NU2lYOOqmkRK6SFzr6byITe0=;
 b=rrLDtYDEHi3KavEqQInQwBZY5vTTZe0IoRZySLdVbIQAYUOQwY0yNRcZ/qx4w081N/
 275287YiGxxk/zmoQ0+kPJNlIKrDkYWQRQ797FnXoarQitbwVH5mAorptQlCp4/mYz23
 aEOyNVC31cymR3pfaeKzvVKfI3v/t72ajaFoFugrlKZxzWTe8RKlCnXV+njg1K41yWsD
 yYN14x4xncZZGODJgEUxS098ixk50DOq9geQbx6koa7OzcgBFEW+ndrhXSsFBqJHzClM
 eqRm0TZcNRUcrK6Fh2FFn9rOc7D5tzostsEhihAqrmc5SA38k1vvX7O/h2f7cUyEaqP6
 PNhQ==
X-Gm-Message-State: AOJu0Yz8hec/cJaheHSxe0iy4Edz4ZZEMurufrzihPGBV7B8P5L7tpS5
 n4vRDtb9xMDGh2U9gSwxzxJNlSkPMdmTEV6yUPGRruWh7HAhtPZzvix8iY4Oy+L+IuYLbsJkgm3
 e
X-Gm-Gg: ASbGncuUUsLRL3snsaBC47x5CdVeGqfsBbjIPJhGLzvf43h3MJbuPU5CPL9b0fZMwbD
 Q0Ij2hduJoVfxtn9GTje5/ihRjLGU+9D9aBNVQ3lPPE8N4YxI5zqUu2kytV54I71HdIKU5XfvLR
 n7h0PS9qhYg/lHN011vfU5f3Kf8JrP2G2N3QJYQgKL5xClw1rS4k3f6HJ/f6eh5i5xBqbOLKRSw
 ucsR0u2j+xzfCZhMDk/vQsJpjL9axzwk01YQ5SoUo/zBDaDwb1kE2fxpEJmIpVhomFNqNi9tcTu
 plYJpLy/9n8DqhK9Sh5ZeY0C1WNpURp0qNyhugNLWuk2UvYO+PcQHEAzIJKh5gbeTZ3XSlx3rxm
 X6czV
X-Google-Smtp-Source: AGHT+IEk1GqAWrvhqMK6ZZs6H6pfA3pusBzSCsrq3+IIwvcx5gAZ0Suun2w7oEfS403KXf9FpW+Obg==
X-Received: by 2002:a05:6870:d10b:b0:2d4:d07c:7cb2 with SMTP id
 586e51a60fabf-2da8c401d6emr2214218fac.11.1746118044419; 
 Thu, 01 May 2025 09:47:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa1207425sm193656fac.39.2025.05.01.09.47.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 09:47:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/4] ext4fs.c: Add missing include
Date: Thu,  1 May 2025 10:47:19 -0600
Message-ID: <20250501164721.1494370-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501164721.1494370-1-trini@konsulko.com>
References: <20250501164721.1494370-1-trini@konsulko.com>
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

This file references rtc functions and implicitly includes <rtc.h>
today. Add this explicitly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 fs/ext4/ext4fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 1727da2dc6db..bd058a096142 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -27,6 +27,7 @@
 #include <ext4fs.h>
 #include <malloc.h>
 #include <part.h>
+#include <rtc.h>
 #include <u-boot/uuid.h>
 #include "ext4_common.h"
 
-- 
2.43.0

