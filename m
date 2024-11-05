Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D0CD31765
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC1D89001;
	Tue,  5 Nov 2024 17:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tpy136AP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75228919A; Tue,  5 Nov 2024 17:54:02 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFABD88DE9
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b14f3927ddso435282785a.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730825639; x=1731430439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GT9r1EdL4TDYYetDadNeuAtH6/phyJsSIC282CB8SRw=;
 b=Tpy136APIXT5He0Pz0UOntsJuKnJuDcYYrXsILLybgoUO+odxzmO/NF+AzEpW6dJvc
 6T17lkHUj1c6fuFzKB4S/TqApZUDIIeab5IqoyGud7IsTGbjcjGsn3SAoFhFhJ8lyp6E
 8JsV6ACG/l3gUlu5eko1O+ZVejJh9YYIleqrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730825639; x=1731430439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GT9r1EdL4TDYYetDadNeuAtH6/phyJsSIC282CB8SRw=;
 b=WTqS1J2bJs/X7pqG5qbh5yvsN2yG22CJQ0UsmhwciI+i2WtLO0uXal/ro5Y7MPuDng
 NpJ1+N2xarmcykjkWEOky4ok4ZFkt3Zqc4cNNEC3CbvMG6CE/1CtR3SI336zigOEnIAv
 BUXgRvXOmXiIl6x6v8azD2EanJLE5k2YZbrjBBGVmRNh2haaqtPzAqHQEUmBax4L86DJ
 pEQ277be9XfSuDhIAKAzkYmuJuTNrLsyxUY3JPw1ilU7MqOyyQWbx9DrVg4LXgB7cOn6
 Mio4jP8jV3LbsV8IJXz5p5wJ4sT7LZTbUYps/gQVXv17Y8G2AOUpgxyoQyK5QheobIZ0
 wY5w==
X-Gm-Message-State: AOJu0Ywf15a1m0LrCzbtSIyQC+OCvJB/5sv08EJT3buv0FAL4AgFYvU2
 tu297DvdAg6/Xq+cpwuwpmPndQbqFANsyGt3vnLuVyHkP93pPzDiwwoIsyqHLkp2wtg2Ob3DdNk
 r
X-Google-Smtp-Source: AGHT+IFF880lVxy9eEnqZ2s7vXypqCh04A6CMvy0b034jolhi+tkDcDjIUgyr36ceeohMyjoysUUgw==
X-Received: by 2002:a05:6214:4a81:b0:6cb:bfb5:6fc with SMTP id
 6a1803df08f44-6d1856fb9dcmr672566186d6.25.1730825639554; 
 Tue, 05 Nov 2024 08:53:59 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415b1edsm62103156d6.75.2024.11.05.08.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:53:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH RFC v1] Dockerfile: Have "sandbox" build with i386 toolchain
 not x86_64 toolchain
Date: Tue,  5 Nov 2024 10:53:57 -0600
Message-ID: <20241105165357.620796-1-trini@konsulko.com>
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

A long time ago, we had to use "i386" and "x86_64" toolchains for our
x86 platforms, depending on the target. We then moved to being able to
use the single "i386" toolchain to support all x86 platforms. At the
same time, we had been building sandbox with our "x86_64" toolchain in
CI. When x86 switched to being able to use a single toolchain we did not
update our CI buildman file to match. Do this now as we want to ensure
that sandbox is built with the same compiler version the rest of our
platforms are and not the host one.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

I'm posting this as an RFC to start the discussion as when I mentioned
this to Simon on IRC, he was very much not in agreement.

My main argument is this, sandbox needs to use the same toolchain that
we compile (virtually) all other platforms with as one of the points is
to be able to catch warnings and compiler behavior changes as soon as
possible in our CI. And just like how developers can use
distribution-provided toolchains today, nothing changes in that regard,
we only make CI be more consistent now.
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde8..e158bab6e570 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -280,7 +280,7 @@ RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
 RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
 RUN /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman;
 RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
-RUN /bin/echo -e "\nsandbox = x86_64" >> ~/.buildman
+RUN /bin/echo -e "\nsandbox = i386" >> ~/.buildman
 RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
-- 
2.43.0

