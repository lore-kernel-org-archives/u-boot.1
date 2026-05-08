Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E809CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A0984C7E;
	Fri,  8 May 2026 10:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UOmOiKvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167EF84C19; Fri,  8 May 2026 10:52:25 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB47B84C72
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso1209490f8f.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778230341; x=1778835141; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y8vrFhqBTHej2HxxkuVWDnAwULO8/UofMg1dD67M7aY=;
 b=UOmOiKvWB3M5llrAlf+m7yKRIiLb2LEhai7jqytYAQE8nAW2WHaGL3CWraSvJHQnqg
 2hVVvrKroyn4O2v/6G/ucZaKPetxzGmnoD2c4gwCDmCqN6deb7Eh9Toog2TKBkIgkWo6
 zJikCyH7GKGUIN6ZDMFG6J0pTI5wNYCMVi0FqhvJ6u2xB1RZ8H9IHZM+gwyAKXS0R1C9
 Jn8vIo2jnQsrxcoGdTQQ9ZoC8RYJLSEpWEk5tPLXJRe3qQERc47NF3FEgYO+bxbAB6P0
 V7/OUHvnWsGWrBqet/jrIiCElVTH7xMxIVV8Btr3eloopEk0crTFOQs1h6t+4vUUSE5s
 QwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778230341; x=1778835141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y8vrFhqBTHej2HxxkuVWDnAwULO8/UofMg1dD67M7aY=;
 b=TISaMe9mUEzvwsJ6zlz1UT4oSuU6Gd+GnH2JZo007heOAVjj6CektB1Pe1F6peJqLd
 Fww3/Fcc5Jl/+Pv8zHxR0PWxElVg1/xkP3CDHHxYC7HS/RcNCEC2CsTGy36iLHQPuKyc
 3DznK6oPnkaI91cGvVDVoJQilgCqxOVx9pe/0WJPHoaOOvjmDJ5C9+xHd1mi+2fKUFoF
 Tz9w+HBbogqxGsylvq6Dmds+RtOsbaZ0P3F6l9secIXGuJkHN9+Rf0VOQeoSxAMuLm87
 /nvF6m4pmvk3OcOdC4RDLnmXBMcwtOIS5lKvZfgKrBPi5+Ic9ktoeSEwVJjPXsrw29RZ
 h9TA==
X-Gm-Message-State: AOJu0YwaYEcm5fdXa3hNWR5oi+rmiMCjnmDSl+2GcE3L0jKAUEzeLxZX
 eAe/JcyB/SZDGUAYZLZuxwXIOV3ZJbnS6/TtoBdqQwu+tTylaSjTwo1p
X-Gm-Gg: Acq92OF7kMyg6ntOGrxRRPCWfo9763Fd1DeKLF148ZgnJ5ugaRf+fzZE8G0A6vEaJHw
 o7G6udH52zmMQTh9cH78ilLA7RKD/8XKOVT9iMdMFNbjjLc3pGW7xAMSYz8bz0Hb1dhH0utd/rM
 6nka5PnVgHIFebQn7YSrpTRw+QRuzSHy5ZlS7FahXuFhSDJLlsn2tUBUSPIcFGlgxUaBu/MYC7F
 OmeWGLn8nrkvze42wHqtg1x+SJWzRF2QerxdJN9HkJqIxgXP1S8KB27a7BdeM4SrdYl0GBrelz4
 EJBSG5VYk3IQM9ysgocz1ZlpC998guTZA8Dmpzl2PZxIxogSqEiISr9pLqNJgQXH87sXqVVsl6r
 orBbg4kQabAJ95LVjXWez1itR9ec4GXJAv0ognHsgkRCji4qNPc6++keD3eilK/B078+20Xxsl0
 sNMxcRxzfgIYGb2xlJmNL29o9lYGU6mfQsfaTc/PoAenLGUcmDyZHm2nzWKC+iqd8WNejIDFGIv
 DDepilzgxWarIIS+KiLzrISsPqVTH+ZVg3k0A==
X-Received: by 2002:a05:6000:420c:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-454637c817fmr2551893f8f.38.1778230341020; 
 Fri, 08 May 2026 01:52:21 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm2676777f8f.8.2026.05.08.01.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 01:52:20 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 08 May 2026 10:52:11 +0200
Subject: [PATCH 3/4] board: toradex: aquila-am69: update rm-cfg.yaml and
 tifs-rm-cfg.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-v1-update-rm-cfg-v1-3-ec9d033f8ec1@toradex.com>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
To: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Repurpose the allocated resources with version V12.00.00 of
k3-resource-partition, matching the update made for the TI J784S4
configuration files. [1]

The Aquila AM69 rm-cfg.yaml and tifs-rm-cfg.yaml remain aligned with
board/ti/j784s4/*-rm-cfg.yaml.

[1] commit c4fcf9b806ae ("board: ti: j7*: Update rm-cfg and tifs-rm-cfg")

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 board/toradex/aquila-am69/rm-cfg.yaml      | 40 +++++++++++++++---------------
 board/toradex/aquila-am69/tifs-rm-cfg.yaml | 26 +++++++++----------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/board/toradex/aquila-am69/rm-cfg.yaml b/board/toradex/aquila-am69/rm-cfg.yaml
index 02a753a0a9f1..a3cf5643dc5a 100644
--- a/board/toradex/aquila-am69/rm-cfg.yaml
+++ b/board/toradex/aquila-am69/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J784S4
 #
@@ -453,36 +453,36 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 16
-            num_resource: 80
+            num_resource: 78
             type: 18112
             host_id: 12
             reserved: 0
         -
-            start_resource: 96
+            start_resource: 94
             num_resource: 14
             type: 18112
             host_id: 13
             reserved: 0
         -
-            start_resource: 110
+            start_resource: 108
             num_resource: 21
             type: 18112
             host_id: 21
             reserved: 0
         -
-            start_resource: 131
+            start_resource: 129
             num_resource: 21
             type: 18112
             host_id: 23
             reserved: 0
         -
-            start_resource: 152
+            start_resource: 150
             num_resource: 12
             type: 18112
             host_id: 25
             reserved: 0
         -
-            start_resource: 164
+            start_resource: 162
             num_resource: 12
             type: 18112
             host_id: 27
@@ -1719,72 +1719,72 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 56
-            num_resource: 56
+            num_resource: 54
             type: 20554
             host_id: 12
             reserved: 0
         -
-            start_resource: 112
+            start_resource: 110
             num_resource: 24
             type: 20554
             host_id: 13
             reserved: 0
         -
-            start_resource: 136
+            start_resource: 134
             num_resource: 12
             type: 20554
             host_id: 21
             reserved: 0
         -
-            start_resource: 148
+            start_resource: 146
             num_resource: 12
             type: 20554
             host_id: 23
             reserved: 0
         -
-            start_resource: 160
+            start_resource: 158
             num_resource: 10
             type: 20554
             host_id: 25
             reserved: 0
         -
-            start_resource: 170
+            start_resource: 168
             num_resource: 10
             type: 20554
             host_id: 27
             reserved: 0
         -
-            start_resource: 180
+            start_resource: 178
             num_resource: 28
             type: 20554
             host_id: 35
             reserved: 0
         -
-            start_resource: 208
+            start_resource: 206
             num_resource: 8
             type: 20554
             host_id: 37
             reserved: 0
         -
-            start_resource: 216
+            start_resource: 214
             num_resource: 12
             type: 20554
             host_id: 40
             reserved: 0
         -
-            start_resource: 228
+            start_resource: 226
             num_resource: 8
             type: 20554
             host_id: 42
             reserved: 0
         -
-            start_resource: 236
+            start_resource: 234
             num_resource: 10
             type: 20554
             host_id: 45
             reserved: 0
         -
-            start_resource: 246
+            start_resource: 244
             num_resource: 10
             type: 20554
             host_id: 47
@@ -1875,7 +1875,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 4472
-            num_resource: 136
+            num_resource: 134
             type: 20557
             host_id: 128
             reserved: 0
diff --git a/board/toradex/aquila-am69/tifs-rm-cfg.yaml b/board/toradex/aquila-am69/tifs-rm-cfg.yaml
index 2889baacf82e..964d9e47e660 100644
--- a/board/toradex/aquila-am69/tifs-rm-cfg.yaml
+++ b/board/toradex/aquila-am69/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J784S4
 #
@@ -1455,72 +1455,72 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 56
-            num_resource: 56
+            num_resource: 54
             type: 20554
             host_id: 12
             reserved: 0
         -
-            start_resource: 112
+            start_resource: 110
             num_resource: 24
             type: 20554
             host_id: 13
             reserved: 0
         -
-            start_resource: 136
+            start_resource: 134
             num_resource: 12
             type: 20554
             host_id: 21
             reserved: 0
         -
-            start_resource: 148
+            start_resource: 146
             num_resource: 12
             type: 20554
             host_id: 23
             reserved: 0
         -
-            start_resource: 160
+            start_resource: 158
             num_resource: 10
             type: 20554
             host_id: 25
             reserved: 0
         -
-            start_resource: 170
+            start_resource: 168
             num_resource: 10
             type: 20554
             host_id: 27
             reserved: 0
         -
-            start_resource: 180
+            start_resource: 178
             num_resource: 28
             type: 20554
             host_id: 35
             reserved: 0
         -
-            start_resource: 208
+            start_resource: 206
             num_resource: 8
             type: 20554
             host_id: 37
             reserved: 0
         -
-            start_resource: 216
+            start_resource: 214
             num_resource: 12
             type: 20554
             host_id: 40
             reserved: 0
         -
-            start_resource: 228
+            start_resource: 226
             num_resource: 8
             type: 20554
             host_id: 42
             reserved: 0
         -
-            start_resource: 236
+            start_resource: 234
             num_resource: 10
             type: 20554
             host_id: 45
             reserved: 0
         -
-            start_resource: 246
+            start_resource: 244
             num_resource: 10
             type: 20554
             host_id: 47

-- 
2.43.0

