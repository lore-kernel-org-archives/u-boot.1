Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62218FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BB1841A2;
	Wed, 15 Apr 2026 06:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ln/rgvaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E9A80433; Wed, 15 Apr 2026 01:18:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02BD980077
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 01:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=julianbraha@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso57699955e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776208716; x=1776813516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=sMvqfpaTNmoJnjqb4jzrAVeOZnfCgKsdCRmMpWQ4r+I=;
 b=ln/rgvaCkU3EPntolnEuaJXALKbeSml///KQicvAGH0KQ8Pj+jTYII1n3HfuqpRwth
 AHj3OL61OrMI3D10syHhxHQJSZR0T7JSS7Vmk3pqiYEN0eL/PGCFwEC1v0neQiHjOg5L
 5kjTfi11LEfclMC++skW1YQUFuzMYsiWYmHRIHrhQVUYGwcnkGZcJj5N2GumIZ++iUhB
 /edHlqMoQ6+ST9knXcK759t3YiqJgq0VR4t8/hdp61uvap6dNF+oxpFUETpG8p3eiEk+
 RsuKyyZ9l9HfNP72DJNIqI3etLAHCOWujnsmTni4xkLDla1WEfoAks88MGZLuwDeQks9
 Daog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776208716; x=1776813516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMvqfpaTNmoJnjqb4jzrAVeOZnfCgKsdCRmMpWQ4r+I=;
 b=Vr6g8GH7/2Ug1wHQ8wiJTX2mmYsCz2t70izi0zm7HQNWaD/x58xz+Ojc74I2/4NN/5
 jt5FlTT3A1tntpHviiwkmeuHhQmFZSmmI+vDAAEZYvaemrvBq6dzNG8TQF2PZDfqlg8m
 3VF5BpvLcErHGvm+WruJpKnzkm654vPrcN1Dkw6+QyQ+wufmCNNpooGuJnCp7gs3wPRe
 TEP4snJ3wzifsNwhRJvf3AA3TjwBU1tCFBP4ajAWO7Q/9b+wwzCGZVGliRQ+ygi6V0vL
 dVuCIvMbZntMrV2WiidWmx1zxCxxgj1Sd5OeY9XpYwWSmDfz1HGvtflJLv0ckEhkmIgX
 Lisw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82oFUdVVHj/NuIniGMueUK5uqPsKs0vWQGpuPbSIn7WCcHTn1KrzDV0+aAbChQJGev03bkqG4=@lists.denx.de
X-Gm-Message-State: AOJu0YyUO/4D0TYJRC1WUtn9cNFslJe4TpDGZoEdX1Bs+GUfGojb5pTW
 OBUnbtsWa1oaQMVsqkjOSE26ofdTBJq8d0uISRtgdvj8kvXPIwG2wAdr
X-Gm-Gg: AeBDiet80WTMKi6UKi545Cdv9tdRMv9vEFv9/0YUkQ+fcrKrzyVRa28CthTJatXdAo7
 0guSxOh2/1+yMrF85gon8LNr0MXE6abKE8m1VOdOsyp9zYwdFo4BIlc1qMjErpiRqgvjeBJJAzz
 37mn10Dcq2xH5BxIRUrHQXf78jzG+d1kzrWDga5NcDcSqXmlrSooiH0riyGHU/gB3fHONT65TU5
 nwzBrFf1gH3VHzkuKiDCWrpWPBZ8TZBJzqJI4D/WG9KkZZRrfNTlt6ns2GxI9EruN39bYM+qwBp
 2vUGrq1J74/ybftX1zGSZ5FRDjp878WBT/DM2HCifpTTmnU8yCBwQFTqRlwmaBejwrLmgZ+W4l1
 AQhNCH0f0VkkKXAInGzfsx0Fz5wo/IuKmdCCYzNvwQZPGlVFtOHWEsZBvF7vrtwlguZTur/HevH
 zaHW6QNTSFqmAoj/EXT5HBBM9BqndEOZeG9SE/O06xNzNCqREN+fIwdkaetvrd+ay9zQ==
X-Received: by 2002:a05:600c:8589:b0:486:fe83:8621 with SMTP id
 5b1f17b1804b1-488d6860376mr186606045e9.23.1776208716167; 
 Tue, 14 Apr 2026 16:18:36 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e8a94csm6642195e9.9.2026.04.14.16.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 16:18:35 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: kabel@kernel.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: Julian Braha <julianbraha@gmail.com>
Subject: [RESEND PATCH] powerpc: fix dead default for SYS_L3_SIZE
Date: Wed, 15 Apr 2026 00:18:33 +0100
Message-ID: <20260414231833.200277-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:44 +0200
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

The 'default ... if SYS_L3_SIZE_512KB' statement is written twice, making
the second instance dead code.

Based on the context, I believe the author of the code intended to set a
default value of '1048576' when SYS_L3_SIZE_1024KB is set.

This dead code was detected by kconfirm, a static analysis tool for
Kconfig.

Fixes: b85d75951fe ("powerpc: Migrate SYS_L3_SIZE to Kconfig")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/powerpc/cpu/mpc85xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 55152ab227e..cb564b32c07 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -1375,7 +1375,7 @@ config SYS_L3_SIZE
 	int
 	default 262144 if SYS_L3_SIZE_256KB
 	default 524288 if SYS_L3_SIZE_512KB
-	default 1048576 if SYS_L3_SIZE_512KB
+	default 1048576 if SYS_L3_SIZE_1024KB
 
 config SYS_PPC64
 	bool
-- 
2.53.0

