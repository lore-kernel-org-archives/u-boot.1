Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF789D116F5
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F6B83D0B;
	Mon,  1 Dec 2025 18:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pMrgCm81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB81483D17; Mon,  1 Dec 2025 18:49:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CFF83C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 515B940F02
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611365;
 bh=GIwgyRGtSZOgUf90kJfDowhu4KjgEeQ2YthmkdKcSU8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pMrgCm81LjbGAKOIDZTQpvkBEVTWbrmJVNCMC6kq8kjHJSkYwV20X05pUIfICNuDD
 GSTu52rrV9QHX1OuwavgxDkr0+fcgMmPTddWUHorR8e8xcE0oio0pzZj7KdTbU7zJ4
 QKUcAI62g9LWovtji8LHKV0jPh1qO1TMmQdEtzjpFY7l8dbuhYKqSfRCv5tLcxMGEQ
 E9UTI7/fHPRTXsoNnKcNlQmYcZYHTOTLFrdcO1LtxFDRvsk6Zc5SMPdIHd9Ilm1xjW
 P6IjOsT06QXN+fDhk+kUg1vSDEQDqewLGwOK79MzWQPe/IAHgybwoctsxjZTovohjz
 y8mDRoo/kp+2XWArlog5B8CjmH5QEb+3As4xqrwL7+bXB8BTMZt1HLptHrfRkrODI2
 RI82ONUdLcXdul2enAQyHdRjxpw4epxRPRIZUiv6HDTjFijotRYEKkq7wPgG4eWzUW
 /XU3pfxeGH1zLjff9pGWZeokP2XVQ8UlKinKGTGRPPVxRP9tvyu1zC6wiu1ANi9THW
 9QMDc/OBZjGA433aAJjG3F3uVLPWOh1NoC6ItkHh/BpfFViw1ViLIPjagKyp6WhN00
 9cD/yBUEhuuMuSSbSJz/PwbDWdc4cevmeFHJTX/179MTowJIXYi+4VhzZ+Z0UwdiHw
 j13TGJuS97pvPzPFafm3fOoE=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47775585257so31765415e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611357; x=1765216157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIwgyRGtSZOgUf90kJfDowhu4KjgEeQ2YthmkdKcSU8=;
 b=vrfU+exGnw6+JgUw3jWSvhRE06qu5BcqzIIpkI1O1hF8Ojoe53hR+WAB4STLrSlC+a
 Y9Nd3IGato4nt+g9tQ42N8OeF09awjOr05FYUKdyb3zmsDgOwgvDQNSc7xZoiWgylaKY
 32aw9j2QINsIWafmGlUnlOvXaHR80cv45t5Okq3wucPWA+OXuLLJGRGfTa1hS4N6ROn5
 BI/D9eGqITOBltQ8nGpJ8DOZXWD7joHs0smFM27wYsVY7DnP+84dZksY5EwtwmKk+olP
 WiaH90mIWr4XNgMOttSIV9xdRegYCS89HaOiQ9UFKt5GyIKM6IGspv/GY/spayV5JIH0
 2r8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGk0ono0+3IClNwnx/ukcbpC9qSSQlJzpBccwuvq8eUlpjePYDpOs4YSnt6baD1t44PuQCPek=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvfpa29o9UgATbvcG5bm+xbcHlEk05OTgNHff3sssPI5esvJiq
 OhCzwKk7R5+X3unjQQ0W488gwmjzKQXFxhHdYs2O6WtHg07NIXYx+wtpCVNORO95ZdREuiHre2G
 lvW7HLTcWIBlxi0CAhPlz5R027xkE9lVSPyJYvR4LMAirdNMcZelUIWFQQ8J0ynVtnFHjP0I=
X-Gm-Gg: ASbGnctks342u0Rva8sdH4NtnpQiRJBJe0oTNurRdjzdkqK3rStvdCOuKUciYqEy2TN
 QedYQo8ZJefjrAYZq15sH4KVHVxxSy683bZ6Aga/I9NW4/E6IVWMvUGi0A06EoQGNbkrMdSg1h0
 y/T3m4wFQH1kwRur8pFAAkuuLop/QySsYkfTLqZxVV0RNu/aLO7oRZZiT397XR5rSJKkmiJ/zEg
 7yL8BXaTwz9Y36Ecxchk/XS2Mku6Kzhz2CUViwiEVIoA/C1rRLsFFMwcmVTHxFeAMpAhps/uX5j
 6iY5Oc2OQiwkBwSaDTCT8s2/rKJOJPjfANedH/g0OvYJXTImHc4FTpsluUzi+xt2E6Mnrtkimil
 B0KRDLsv0eiL/qr3Xw5Js7OQl8SnhlL+MUhgnwbC1DWZWeiO5iugOHxQY0b5VrXVgtQdmVPA6ey
 +A
X-Received: by 2002:a05:600c:1c98:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-477c10d4887mr359935915e9.9.1764611357151; 
 Mon, 01 Dec 2025 09:49:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETbMF5A6ISmL8lT4TB1ZKZMOsqYtH8uK3p/DtNudDLmcuj/uAQY+TV6/iIEPcNYuUqi0mauQ==
X-Received: by 2002:a05:600c:1c98:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-477c10d4887mr359935495e9.9.1764611356688; 
 Mon, 01 Dec 2025 09:49:16 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a1dsm324072125e9.10.2025.12.01.09.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:49:16 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] RISC-V: implement private GCC library
Date: Mon,  1 Dec 2025 18:49:02 +0100
Message-ID: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

We currently include libgcc.a when building for the RISC-V architecture.
For instance lib/mbedtls/external/mbedtls/library/bignum.c uses __ctzdi2().

At least the Ubuntu Linux distribution has switched to building libgcc.a
for the RVA23S64 profile. Using this library on RVA20 systems results in
crashes. We therefore need a private replacement library.

With the series a private GCC library and unit tests are provided for
64-bit RISC-V. This is enough to build for CONFIG_WGET_HTTPS as suggested
in E's patch

[PATCH] configs: starfive: enable wget https
https://lore.kernel.org/u-boot/20251112005451.41285-1-e@freeshell.de/

Heinrich Schuchardt (2):
  RISC-V: implement private GCC library
  test: provide unit tests for the RISC-V private GCC library

 arch/Kconfig            |   1 +
 arch/riscv/lib/Makefile |   2 +
 arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/ctz.c    |  97 +++++++++++++++++++++++++++++++++++++
 lib/Kconfig             |   2 +-
 test/lib/Makefile       |   4 ++
 test/lib/test_clz.c     |  53 ++++++++++++++++++++
 test/lib/test_ctz.c     |  53 ++++++++++++++++++++
 8 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/clz.c
 create mode 100644 arch/riscv/lib/ctz.c
 create mode 100644 test/lib/test_clz.c
 create mode 100644 test/lib/test_ctz.c

-- 
2.51.0

