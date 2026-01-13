Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F61CF45C6
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B79083700;
	Tue, 13 Jan 2026 02:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WCeNxzfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1C28391B; Tue, 13 Jan 2026 02:32:16 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4234B836C8
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-65cfddebfd0so3528548eaf.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768267933; x=1768872733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o1iGGnmIroFM79ZiypUJ8GxmIF55cpe++S5RoGtP3jI=;
 b=WCeNxzfZRwhhNpCByzpS/TQGW6J48BueqfYqbgyxReVOx4qrO5JcUHfo5eM83YT+cx
 aydfGDJ/jkJr7YRhUsNPtU9D5f6o/SLHcoX+u3gMHkm2sEkm4yxHILCdKcBd7EsgOD6P
 ECiEX6wxeGPve9zzxWsVCeMZlNnrWWL6gV8KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267933; x=1768872733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1iGGnmIroFM79ZiypUJ8GxmIF55cpe++S5RoGtP3jI=;
 b=e35J2GWTPSFvUpqKqoGbb7/8igthbfsd00+NIoX4ITodZreHtGmHQbG/nEFtleAFw5
 jZt+CXQk3AiG5QUujLvamjKCkIL0RNqv0FIopZefjGLnaZnyWQA71e/9+0WOXa1f0uQ8
 8ZzoXZT/RCSP9XmSO5G2MjZxGJVgUU7cFNXhYN9Ki+eFeBdThvSFzbSK+r6X/4RHZ4vh
 7WSiA3ZZN3hLAZFiEAxcMf5VzRfPFNtdB/tLW0St06zXf8u9xnpv/xFombVsYKjN0/6j
 QJF5EO9+7GoQvf+88iw0p0tIovNcn0EkzbfANb1bx8GYzVSpLQsMz1Obo0J91tVug+ol
 d3AA==
X-Gm-Message-State: AOJu0YwOJXyFQlpfzByhxy31y5ZmIZCRRNe/DOradGoJ712Qtvtz2SBF
 0Dnf8gA5xBxNuXXW0DORNFxgZFGFibUvIpt2Z2pcOZbBxHLpmh6gOQREMZN6f04bh/jgof22BD8
 xgMk6QsE=
X-Gm-Gg: AY/fxX7veUasfa0eheDEvFIX0uTHk4yZgsrUYR6+Him1TXtAOSOE+kAx7TJ4YyUNqLJ
 BUcF8Y4UXKYeVyWyzcsV+caJbOEEveb+R3IaX6TY0cI1xKzA6CrZcbsSNdrLR5FA5ykUGiTjOli
 zUzer9whZX/ZBjUQh4P0SwDU95g6qkG0h0isQyzaZ8Q6UmHaSa68syZQQu9qLjMLvBgqYpQ8yzY
 kHf0pBdUVjJIrvx1NNNHv9uxsSC2PQd8pi2j/DmGrf/FppqeVGhROF6jt9iHuXvtcYrD9Lc++Yr
 Q9AQRBNLwbplyPe/18xPNiF5pP6+PHYihf3bQ3YEFdsUM89614qk8C7o/8zaQ2x7tASlL6oSdt7
 BLfHKU7ME4MxJNaQSXQ7Vnx6NAjQB5M7rh2LgagXnK0HEVCKfVSTO7YN3O/smJDCaZCYpttJjcd
 qZ0b6VXXkw2rvX5Hl3hRpVg35nbUr9ng7wql+xn1/yEIqKRb7nYaLAx4PevhS0wTSuLMD65/Fg1
 bdRXkCZxYZJ7EopASI8puUbcygQwTDl0mY1be+ukQ==
X-Google-Smtp-Source: AGHT+IF+/iztg7XQ20NIbJ196qLTom3f6F4/xeVl2zw9j99Mhkm1S0oKc8YT3yJtyYTsz2/zzBpwNg==
X-Received: by 2002:a05:6820:151b:b0:659:9a49:8f3a with SMTP id
 006d021491bc7-65f550bd62bmr8970423eaf.75.1768267932944; 
 Mon, 12 Jan 2026 17:32:12 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4e3a7bfsm12974248fac.8.2026.01.12.17.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:32:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] gardena-smart-gateway-mt7688: Disable CMD_LICENSE
Date: Mon, 12 Jan 2026 19:32:11 -0600
Message-ID: <20260113013211.1947438-1-trini@konsulko.com>
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

This platform is unfortunately frequently very close to the binary
size limit. Currently it is so close that generic bug fixes can trigger
build failure. Remove the license command from the image as that frees
up nearly 7KiB of space.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 configs/gardena-smart-gateway-mt7688_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 10a595a1df47..a78eebd5fd87 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -47,7 +47,6 @@ CONFIG_SPL_MAX_SIZE=0x10000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_HUSH_PARSER=y
-CONFIG_CMD_LICENSE=y
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
-- 
2.43.0

