Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34465C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0456870BD;
	Mon,  6 Nov 2023 17:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AA/5ZEEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5631870EE; Mon,  6 Nov 2023 17:52:46 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828568701D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so8084250a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699289563; x=1699894363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7SoJKqDgP25AiukZHak+TpoJYQP5fd1mh4vjneFuEH4=;
 b=AA/5ZEErcbJuak9ag+3n69ORuLTljo3XITDrxVjKwIrFBq/nNraCaAfRGDjyA+FvYj
 eHL4s6l3YKt8POLQoJs9u8V+6ceMsFKU6Iolnaebz5yxJ35B4soU+ZaiuxTjpEsztwb7
 widqOg54QYWLVzVPv/VQqtYg3sVS6KOhBeqrgxfqWOcG9FUbt5bko8aatwxTzKAhznmP
 2xA1/gLjjp2v0+U6hx/utoi0hR6QXCgLWNWW1T21MsPXIg3tvI4StNf6UqTj0arEAdLH
 zBzz9t+JihDFpYVsX0rveFQbUGRdveWHm4Kt2FSvJWVmF99UngEINDCDaTI9FLvX8qWc
 AKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289563; x=1699894363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7SoJKqDgP25AiukZHak+TpoJYQP5fd1mh4vjneFuEH4=;
 b=ftXbhRJksOKoI9ch9zps6z29GBwF26kLq+OmReQwvCJ0/jWWvzZy1ovx8S+ER/s9l1
 jc0u3y1zHuTy6Vj9UM6ncW8dRHJgwewl58hGRIJ89PPhd5LRCM8sFme06etGzsPY5ds+
 caPbPZ/ObvxLxaAEkpxARXtQSl3bB+G/mVuma32kkpYuFrCLZRKZjy/LFz0ILuIAYrcq
 BAog7NM4uD30n/4ZeT9RhvOXqyMvAfXrJMiwQ+9yIHvqk/yhsBIFUb6SpSIXszpzaDA/
 DTfZqt7uFgmvW0dK6qfZ+GV0Af7xdhzBDJpv1UOAHCMpaG50hzNjuJVRSY7UVog1VbeW
 2Z8A==
X-Gm-Message-State: AOJu0YxIFuA+LeiaE6llYywgii+npDz46QLXm9D5J3EEpiL6ywMbUyfH
 3yL6NuMvTvBLjgYlXlUmPF1O7qA/u+0=
X-Google-Smtp-Source: AGHT+IE+Osr66f2MCMZ0JVdZ+yJehut/M2TlKEqJ3Y7/CvEozIsUGtXaViqt4PIa4Uqm/IoiKiC1oA==
X-Received: by 2002:a17:907:9281:b0:9ba:1d08:ad43 with SMTP id
 bw1-20020a170907928100b009ba1d08ad43mr13787723ejc.70.1699289562924; 
 Mon, 06 Nov 2023 08:52:42 -0800 (PST)
Received: from workstation.sas.sys.sphairon.com (51-6-142-46.pool.kielnet.net.
 [46.142.6.51]) by smtp.gmail.com with ESMTPSA id
 i21-20020a170906091500b009ad87fd4e65sm28673ejd.108.2023.11.06.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:52:42 -0800 (PST)
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] mips: fix change_k0_cca()
Date: Mon,  6 Nov 2023 17:52:38 +0100
Message-ID: <20231106165241.298426-1-daniel.schwierzeck@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The intention of change_k0_cca() is to read the C0.Config register into
register $t0, update $t0 with the new cache coherency mode passed in $a0
and write back $t0 to C0.Config. With MIPS32 R2 or later instruction
sets, this can be achieved with a single instruction with INS. The
source and destination register of the INS instruction is passed as
first parameter. In case of change_k0_cca() it is register $t0. But
for writing back the updated value to C0.Config, the incorrect $a0
register is used. This is only correct in the MIPS32 R1 code path.

Fix the `mtc0` instruction to write back the value of the $t0 register.
Fix the MIPS32 R1 code path to also store the updated value in $t0.

Reported by user ddqxy138 on Github.
https://github.com/u-boot/u-boot/commit/b838586086af3278bcaead3720c7a18813cf4619

Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

---

 arch/mips/lib/cache_init.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/cache_init.S b/arch/mips/lib/cache_init.S
index 602741c65d..d64209d76a 100644
--- a/arch/mips/lib/cache_init.S
+++ b/arch/mips/lib/cache_init.S
@@ -431,9 +431,9 @@ LEAF(change_k0_cca)
 #else
 	xor		a0, a0, t0
 	andi		a0, a0, CONF_CM_CMASK
-	xor		a0, a0, t0
+	xor		t0, a0, t0
 #endif
-	mtc0		a0, CP0_CONFIG
+	mtc0		t0, CP0_CONFIG
 
 	jr.hb		ra
 	END(change_k0_cca)
-- 
2.41.0

