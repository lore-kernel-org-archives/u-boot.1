Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3251C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FBE88ADB;
	Wed, 28 Aug 2024 03:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EiJi4PlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C89188ABA; Wed, 28 Aug 2024 03:44:40 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856C188A7B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso226723839f.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809477; x=1725414277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVQN8EM8iMUv2XaqBR9jEHPxDJTZwcFT1oOYW3dlg60=;
 b=EiJi4PlBJa53o3Xrohi3z8u+C0HL0tewQBlUYR08K0iDkyR42IUBN06g5+uBSOUa3m
 IMfVhwWo+9QnjENzweuz00tS1HEYFE0L+i733fpY750in+8TyOX2kwS8Ew7AGIENPABV
 TdhzLpyWofXzMPonc9n6Vp22fc1uu/Y6DDTHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809477; x=1725414277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVQN8EM8iMUv2XaqBR9jEHPxDJTZwcFT1oOYW3dlg60=;
 b=Hy7LpeacLtKM3lSxIqXu1lQBI6+OgLSYXNF/tf55AfbOhZmmhobvq9FCVZXrUAdqE+
 GxFpgF/MYGWqV04VQ2yYLzTvM2Xr6HzI6ompoyz3u4L2YaCOVAyt66BPKu20cejsDauO
 EcFmsG21yLL+7BHkBXVvCwPaGf/Xyl6PJWmbdYmslqwl16QbqZ3a9/kOQzW2PmZLgFLg
 jNO4vBtP1jembzAl73BA4HgOJ3aaz0fjL4LCwS8203732UHt65S4LYIweY8QW9pg5xP5
 Hss8scQMIHsFrJJKZQkA4Qz23LTItv7h85+GITCrAX6cKBGuzDm3N7rBhvmPulNnqJjr
 yEEQ==
X-Gm-Message-State: AOJu0YyoaQvAbBn56RvMVLPsAMkG/z7i9EsKmTVEPlvb5Cf/OCm2GLTk
 57LZVRo3XfWjiuAMXTMsgaMkAkIX/pWDdD1VjYjTaFFEaacl+EtMYq7sgJDpmJFu/Pk0ShPqSSc
 =
X-Google-Smtp-Source: AGHT+IFcjnOjZhdq3WOOWOzUjY5D/6Y37PYaKGodIh+oRls4wzPNrRxfPHMoGymnT+u0EQ6xuxlABA==
X-Received: by 2002:a05:6602:6c07:b0:822:3df4:64c5 with SMTP id
 ca18e2360f4ac-82a03e59785mr72733239f.9.1724809476993; 
 Tue, 27 Aug 2024 18:44:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] x86: Sync up tsc_timer with Linux
Date: Tue, 27 Aug 2024 19:44:27 -0600
Message-Id: <20240828014429.3320011-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014429.3320011-1-sjg@chromium.org>
References: <20240828014429.3320011-1-sjg@chromium.org>
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

Since we are using the code from Linux, update it to the newer version
in v6.11

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/timer/tsc_timer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
index 2f2c2f27b7f..dd16ab320b2 100644
--- a/drivers/timer/tsc_timer.c
+++ b/drivers/timer/tsc_timer.c
@@ -83,7 +83,7 @@ static unsigned long cpu_mhz_from_cpuid(void)
 	if (cpuid_eax(0) < 0x16)
 		return 0;
 
-	return cpuid_eax(0x16);
+	return cpuid_eax(0x15);
 }
 
 /*
@@ -299,10 +299,19 @@ static unsigned long __maybe_unused quick_pit_calibrate(void)
 			if (!pit_expect_msb(0xff-i, &delta, &d2))
 				break;
 
+			delta -= tsc;
+
+			/*
+			 * Extrapolate the error and fail fast if the error will
+			 * never be below 500 ppm.
+			 */
+			if (i == 1 &&
+			    d1 + d2 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11)
+				return 0;
+
 			/*
 			 * Iterate until the error is less than 500 ppm
 			 */
-			delta -= tsc;
 			if (d1+d2 >= delta >> 11)
 				continue;
 
-- 
2.34.1

