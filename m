Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5899EC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8520480F12;
	Wed, 26 Feb 2025 21:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E3FM3HTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6464480F88; Wed, 26 Feb 2025 21:31:16 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AB88081A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6e891e447dcso3013936d6.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601873; x=1741206673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CivOovrG6MCVs2MUZBRPG1VrFWDIYo1Xt0zbocVW3UQ=;
 b=E3FM3HTKurJL6LAilxAPaV64jBTe4IC5oyKSfla6CJOIxUmivmd4Z5RUoZmpIdN5l8
 4AKEWOpqJOacJmgpmn6AV5xlPxqg2utGPhaZogl5b3gEN3yfpjKY/kvHZQX0pBJ4HPE4
 lO1+e+RPWho/ElS2hVNJuLI3KABmWt7I8ZDNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601873; x=1741206673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CivOovrG6MCVs2MUZBRPG1VrFWDIYo1Xt0zbocVW3UQ=;
 b=C5oJSNXiiWgf1NkUQmeXIANVC2BAbOVTn21Ntq15/nfzxGTG5S6JWix6ktxakJbI8J
 sTKMrMqrptFOMAhngp2me8TlATpUphDdnfMLhbbeYBxGHXvImGoZQ+yloT1rzphmgZ0h
 XT2KpkqqgYF662SOgMAMfeOTV68Q6Bls8CS0h56dl8GDMyGf8N63R595o5/DT4LCXC+Y
 sKwb/sRx/J6T80iv+vN7TJlXJfCN6fwgS9Bva+wOJK0DGHZvgFLlSoIBjo4JNMPOcj7T
 mHkspJoYk3yXEe9MYPOOYkLANBylGz+YTA1adwO+sp4jM0f81n8YU6krfxL9cGM4YYRU
 wnhw==
X-Gm-Message-State: AOJu0YyWrHf2Y6Ylwj/MFw1nGwq0p4/zaf6LzgrPqXWWknOkqR0iLkmU
 dCxtD/wB0kbqlrHMvWBt7bklrOyFAT990eN2OJvWbuRHknU5aYn6FvD9TwLwaUyzjBShn0oBTqm
 Y
X-Gm-Gg: ASbGncu5qWI69hj6axhG4qy7HtwiczQ3QQyqHVgwplPSWjmtMuafAtWwfF3OSmYwESk
 /bLPjxxRjrzuIc9p+5FNo5xVKv+bSpYRV4QyS8bLcFjLsQfjSEmcfQk+ycUX4bT678tjdyM6UUz
 NdhJ5R9f3nTcd+28RTLksn/sUbSaVif3ypd4HqSLyjbZnbOBLfTmkPvxddMPnLNMQKVrzP8CuD8
 vkHpff8ao5uojpXtZQt+QCDlttylw6iMiOnFj1+DJ1QD28zvFx7+kRHKt0Kiy2q/m8NYiESXxLI
 roHdYChpOX+Se24E56ZP/7jrPjY=
X-Google-Smtp-Source: AGHT+IFmwQLpaOI9mqxIG7pd4ljdHU00z2oMjEcKw4AhUq1mGpLjSfkzfHxXsmoSY0qYBJUZDh+Gyw==
X-Received: by 2002:a05:6214:acc:b0:6e8:95d3:2fff with SMTP id
 6a1803df08f44-6e895d331b5mr11237546d6.25.1740601873116; 
 Wed, 26 Feb 2025 12:31:13 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e89766120esm376376d6.54.2025.02.26.12.31.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test: event: Correct usage of IS_ENABLED() macro in
 test/common/event.c
Date: Wed, 26 Feb 2025 14:31:09 -0600
Message-ID: <20250226203109.3831895-1-trini@konsulko.com>
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

This file was using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/common/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/common/event.c b/test/common/event.c
index bfbbf019768e..e77e020b00bc 100644
--- a/test/common/event.c
+++ b/test/common/event.c
@@ -91,7 +91,7 @@ static int test_event_probe(struct unit_test_state *uts)
 	struct test_state state;
 	struct udevice *dev;
 
-	if (!IS_ENABLED(SANDBOX))
+	if (!IS_ENABLED(CONFIG_SANDBOX))
 		return -EAGAIN;
 
 	state.val = 0;
-- 
2.43.0

