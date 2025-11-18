Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEFCCEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D5883DA6;
	Tue, 18 Nov 2025 19:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bl2CIQLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6423B83D3C; Tue, 18 Nov 2025 19:03:49 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C6D839B1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso2650903fac.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489026; x=1764093826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DbJwrxZIVtCs2FkSQIabAPSohiK62ycUGmAJSyl92sM=;
 b=bl2CIQLx85g0E+9FdxIKvIo7LpvhlKHcyJA+vX4WoeGj4lLFr0f+gcvNyrtdqZCjiD
 ziR2/G7ANSpMCv2gdIBU9mhh3cAEmm8HKM8Yjw7dHxUK7mmfdnpdFc8cH1pok+dd9O//
 pcaxpSUm3nh8aa+FCgM+UA176fF8Xb3h5RDkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489026; x=1764093826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbJwrxZIVtCs2FkSQIabAPSohiK62ycUGmAJSyl92sM=;
 b=Ny4Z66IEKVItHM0trA81X7GZ580pP3AnE87DJObX3ePyKMyweVuY8AZ//6xv/126MZ
 E/ql4DkijFIinswozFQBpmLmdC9lseDJTMTm5iUsV8R/wspjMHbKheIdd+kL5vhQiq8q
 Q6vye+EQMlWONaqzq9VZlfaiwQVIUB3qkDCQr3HfFeaix5Ll3h+1iLb8jnPYbfpN14uP
 xDbc4zOlVG7pdiU2kCqIZuKz1NrqaXoY6Sd5EXFtKSpouCz5QHPaAnf3W1uwUHZFVDPp
 fFFGNVcyVJpRlJ4E3MFrQm2lrV4wHIXr1gmMYnLQLfxYa+9xSIwVJm+jxrcVtYxa42mf
 5tUQ==
X-Gm-Message-State: AOJu0Yxrmpw4n1cyfVMjZnmuZgU5mlGl0UZiZXT+Z0WDiq9VLlOXhm4m
 OT5BaaIzftBrwkVixiOIXwViiycof9GRV9wDF52pkUfcjo5pjiFFrYZEp6OY2FkePE4yW5939VD
 VHxpu8+BGxw==
X-Gm-Gg: ASbGncvTsZ6bSqrttb8Wt6KYgOX03u71KGqh1HtyyJkgqnxBiAyH8peNr3aHMbH3JFL
 FxF5Iy8yDfGgWEHa4EZyREOztDxbFFsy1YkKuMQhNlYFGireV4veqWHAB8kl7pmOuA594dGWBXj
 i9u5rJ5vjB02V+dNH7rW//TcSWUTBiTikFHmYWb9KvkEwRhIpxDbIBCFOWXBRbrkTpDhzNcKbPw
 7TH6QAFN6X715Zym+/z+vur9UsOwI6FfsaS8FS0xsiiVaQ6p3BsrhmvLWXuTX2L+cKHmoTOqzqJ
 4wm8VwSbvv3DDbVBdInmZMuDkbCXdfUZIWKFaHAM6yFhg/kCUTkA3pj3fBPcoNbsceYr9uZswQV
 sqvuR8j2hQHjHOVK6JIAIIJRFn2tOa1ihpGZWahkA/OaDccLw8kzkgfp6cacmHdObWR5hRs/d20
 alA0snSDERJ55E5cKc3fhV7wMqGj2a+coNmsLjBsFS516zEz1wGqp2
X-Google-Smtp-Source: AGHT+IHc3Du4dELPzXiqORhf18cmXNso3mdvSkiSGEQNbfiF6OZZ4HE5xb+Hdmc4Sj4Ce4Wq/SbZUA==
X-Received: by 2002:a05:6870:938a:b0:3ec:39fc:daac with SMTP id
 586e51a60fabf-3ec39fd1c80mr3501260fac.48.1763489025637; 
 Tue, 18 Nov 2025 10:03:45 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e85226391csm7293632fac.11.2025.11.18.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH] opos6uldev: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:44 -0600
Message-ID: <20251118180344.590898-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
---
 board/armadeus/opos6uldev/opos6uldev.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/armadeus/opos6uldev/opos6uldev.env b/board/armadeus/opos6uldev/opos6uldev.env
index 2e7b65968d1d..463d0984fbc9 100644
--- a/board/armadeus/opos6uldev/opos6uldev.env
+++ b/board/armadeus/opos6uldev/opos6uldev.env
@@ -10,7 +10,6 @@ env_version=100
 consoledev=ttymxc0
 board_name=opos6ul
 fdt_addr=0x88000000
-fdt_high=0xffffffff
 fdt_name=opos6uldev
 initrd_high=0xffffffff
 ip_dyn=yes
-- 
2.43.0

