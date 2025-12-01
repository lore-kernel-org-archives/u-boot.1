Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12926D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8915583CEE;
	Mon,  1 Dec 2025 18:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g3EHZICi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CEA83CEA; Mon,  1 Dec 2025 18:47:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E381183C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 873DB3F181
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611248;
 bh=GIwgyRGtSZOgUf90kJfDowhu4KjgEeQ2YthmkdKcSU8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=g3EHZICizQMvOHYYjKrCoB0fO8UNv+WPMiv6e9O/5nIG1/Qdm781+dBdpWrTHST16
 eyvKfg+SXVOBD3UxTtCnyUBhx46G/PW64twjEFrggdeKwB132ctfGz5l+JzaUC8Fwg
 JqhnYuwvCGaDri3gcWQs1UMeniMOF1qwD+tml/0Hi3qcNA7M5dMcaDpCNYRxNGoEMo
 XvVss70eRn2VqvBinAllXGpRYoYZQ4BxbjpAmXh1XwwvrWbfhHieLp/JxjKg6DNsLB
 eSCpq1GvZSdRKpI5GiG+icPZOOcdihtJL3AJsl+otLoq4lxv+M9vmrtlSxK0vi7gu0
 7Ct+mheUzxjmSLHYHZtF5N2FQeqlbUYvKWgxYZH027UbrKAnNYPHc6i1Eazxi8hUJ/
 qBU69H10qIdB/YELx88NT3tvH31jgX2FE2QdC5PUM44Pp30j40cqXiqYuTT5MXqFli
 UAGBb96fPg9+fvzLh07d2AmCaGPxYjXUzVWo4sjFqMYkyUTTRRqUDTVSH2rsZ9UyI+
 xNnK7OlYdqbB6+WuhZqVbeJ3TlcbPaPKqVsl6qxp1PbKzezdEHA0N4mFuFFMqtd0ov
 xklJqrhskPZWCMKWkREjbyEuNnrGRWLACz0wvZ7n7HFSAob+c0uhTZXIbLG5TFC43R
 NJFtlWdJR/cQXShWJSN1HJgI=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6418122dd7bso1592582a12.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611248; x=1765216048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIwgyRGtSZOgUf90kJfDowhu4KjgEeQ2YthmkdKcSU8=;
 b=JBmIfyJpLxp4+an7O3aKFXMX6IjEak4yjQAiPrIY7SF98MO0pOoXvGqD1xi8abtGRk
 6fpI4X0Z+zKXPwGVR+IVCk2krPYcHfWqAwylYO+MnW2cerPGpn0Wjju2E9Svr5/nIgSZ
 hWkQ5cR7D1tmo+0vjw8gTfdSMuDFXE6EF1DhDwpIxGYxnqvvZD07sgv+eyfbeNFmLswU
 qT3svPGps4PjSO81lpb4eTnSGxmn47UpsitibHqc3D2Ds7bsxNU/Ipv4BQCQF60AfHZv
 WEIFgCGqxerC49gseYMVKWMrg+Uo2xjQpk2J2WVEO/fnvwn6rBjud04Ww4KyfnqCkWVj
 Thng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3F7vmOP2YZxBPKWGqJuAHq6uxCCpjldtJvobbzBmu/J1Tmix0E9TlA1gD0G5Vt4qDaFYup2I=@lists.denx.de
X-Gm-Message-State: AOJu0YymgnmdzJtvgYQdRYI4x9Yc6U3xeUh6PGuwcrD1AVDIGHylRwOs
 piIXM55naZ2K7eRGn522HoIoIB+eh+LkOzi47Bln0qz8O934o6vA/Ua2hc3zriadaBRICCgXRz+
 WPq2hkD9DLaj4Y9rt7yr6A8ex7C1hqF9ly87FIL9S34Q5/QCBTDBlj1cPagokEgGMlj/3N+4=
X-Gm-Gg: ASbGncsl3jnW4P+1dacwUo4mBZIo6NRNNVu5fqZABsW+UYx8/ij4TqYBxRkO2JsixWO
 gv3KnJPLA24VOgLDKBJwXYl1Od3aveGl9b6BkX1pVABUt4d7/fbVYbAtPAwn3vBXX6buT9HcpT9
 iJf1lGHOh6GsxSF3HPKj1H2pZeMHeZhyVlxG+hED4bK2Mnqzz5Y6A/rlOr8ICaa4mvLVS1otZs1
 JQ0+AiPEmrTdykriBzLiU4V7GW3G4vR6eygexM4TSiUeJSvgBfULdvhzhBzbK4/eECwoIWHm2Gn
 m7GY+0H92ECdP5ciqK5OmwzwW3ilsyAt8NLeX+BK+Ts7NF25M2vO2q5PddpbvHU2hs8NzMmO1U3
 moGTTtSH3w+aXY8DawmfbGmzFOYwu9au+x5IliPrZ7bY7wnuMn4TgLbyK9g==
X-Received: by 2002:a17:907:3d89:b0:b73:9a71:13bb with SMTP id
 a640c23a62f3a-b76c55f3e48mr2955648566b.32.1764611248052; 
 Mon, 01 Dec 2025 09:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDu/aZhDpw6jQFO0ltgnxCqbEi8u/wY1M2sUIg9Kepkxy4UR1R91XnrOd5WjQtsGXfevSD6w==
X-Received: by 2002:a17:907:3d89:b0:b73:9a71:13bb with SMTP id
 a640c23a62f3a-b76c55f3e48mr2955646766b.32.1764611247693; 
 Mon, 01 Dec 2025 09:47:27 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c67e2sm1288993566b.27.2025.12.01.09.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:47:27 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <zfsdt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <zfsdt@canonical.com>
Subject: [PATCH 0/2] RISC-V: implement private GCC library
Date: Mon,  1 Dec 2025 18:47:03 +0100
Message-ID: <20251201174705.652626-1-zfsdt@canonical.com>
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

