Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA9606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l1V93Tkq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWP1noMT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4566C6065A;
	Sun,  1 Nov 2026 21:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id selNvcRkJyty; Sun,  1 Nov 2026 21:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A4136066A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567130;
	b=jtyok7Gfq58Hj7MJVcrz7Ixckx5YrKfl9ABwqzHLE0lD0xsoAV+T9vDLkWi/7af10/NJ
	 xFRE44VFLyFRKMFCEk1ifm1a5FK/3LEDy5ylzPB6edaJTO3P6WZTarwEtMVTZTQU5NJ01
	 r/OeEsg2TFmabMpC+zLE0LF7uOnuE0V36tXRFJoFf+8C+18TNsv7eSQWJOAUgok3BS2im
	 mIMyrHR+V9RYdLIpMIVFprwA+VuvYMr3kuHzMyaF+efTgrboAngfvoFqoj8VJRLOyViF5
	 2TmfIElOdW2cIFfQQLuNTHnU5LLBeLFg2xNUV7q+heSmnmrq08QrZLbxCnB28Hiaxhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cskILEOFBvsCfkOEs8tP3Mj0fACqDWfujI2HV3hkyVI=;
	b=MlSH4rr0hN9H2iM1T7bzqe72Vtp4kWCosaIVxHOhF1B7wo2U80P3me44CoIRlFIysqUe
	 kfEkiWTWHNBmVZ6MMLS8XYQ8dOtBQuyAmzAJcnwJdajMfl4ILlFOFpJNLGZsUEWSYVgG4
	 d6O8DgUyqtKLP8YeEJ8EpQnxOFfem2N0hEUrszDInG4+Y+3fEkchgBes79/JB65KfjJcB
	 RMQJTqjPnEAdESqFBuW719F+PUmG1r8xyg6UO4YwDyhn43sNuebC4ytFaF5dBHf1LVxVQ
	 PWRhi5c2otGYpmsQqQGvbNibW7hbf/eLMKZTOOiuC9ecOHV1MjEe+ZlCUpF4Z1RWoSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWP1noMT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567130;
	bh=cskILEOFBvsCfkOEs8tP3Mj0fACqDWfujI2HV3hkyVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l1V93Tkq2es4POLt+cIxqGxUlsdKfGby107tYV5bDf5kbk0+G7e7ZyKBq1lt4BFZT
	 ozZ4HADEX0mzK05kwRvUdHI9uLRZYNhOPGDo+wyo1A1aD0MqtsdSFdpKL1hoG+9fFy
	 PJEP7sq8rZCBSJtTJ+lsWN3CiJFR4d3drsctHyF7M5YLTMrGK5k1YGnaQ1pUUQuZf3
	 mjKE258PNAZOyCXhxNm3BEnUOhnti0EGnBmkbLUGD252Hggw83he3R8x0xA9BpeLDL
	 1orOrN/tqK1XWCEIFSiQrttcJtRQ6wQu1UlWlmY0fLkq/ZDAjbxulOY+LchkY0f0PK
	 dTzN2PsQOMbYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A4136066A;
	Sun,  1 Nov 2026 21:05:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D1A1435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BC3A6065A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHzZTzJd2WzI for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 16A986066A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567127;
 b=FYjNAMhxp9ATzmSmDHWWQIUbe52piAj3IU5vvPkov+nrWAmc03UKHJN2DbhliQ8x/lGS
 eNOFhfhoz/6sqjla/RTFBhpdCXXTwPsD+dy2aXo8lzclyBl7hIoRN/ENE4MqxGWhMS7HJ
 q55Ns9O24dAoJBwEHmgxOGcorTDpqGmPl2ghcgrPl2iAn3OJRYNAFPtJKeWQLrh93uPvn
 UaCcuUuZZ6o14tEZ14UQNU3FWh/RowT4ZZ3+0/92RS1HZscmzv96qwRXm2c/bfYDJT42f
 +LtS+6/YrlSC8+yuuFisZVY9pzXqYdf5swnQ+Qb4ZJ1YKXJO8SMEU5Mf4PpmYsGzJDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567127;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cskILEOFBvsCfkOEs8tP3Mj0fACqDWfujI2HV3hkyVI=;
 b=K3by5+OO6yJdQSWoxsiAYvby4BnMqAbZLRoVadLI0bnxLzC3fxjAETBRJ93pj6p6Ln8g
 760Hagde6H+1FAIDQ/agPYzAFV+atIr5va7KlXTXia9B/x4QtDg9LrFl9KRsjP5Gdstcu
 Xw4xHyPc0sJpHO45hpo29PBWrETGWIdouolyFqHkcYKa9Vm00kmXtwCnW/MaZuD5Gc+Xg
 ETIbfnC2mrecICdfNVXiRqaX46rpaBzrfjcOEGx4Eb5GSn1BQAyf6dkM7+2MnJ1eHGxe7
 sRnmN80ZA6e8xW+aWyC2Sdl9uLp4MpsQ6mUVA0u4k+SfY42etfG3e+Eakudq9L7wxag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fWP1noMT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fWP1noMT
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16A986066A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:26 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3acc7a0b558so7326101fa.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567124; x=1794171924;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cskILEOFBvsCfkOEs8tP3Mj0fACqDWfujI2HV3hkyVI=;
 b=fWP1noMTl43MDwlJIDONZL/s14OTs/uiv3ZY5CeEcvH3WMazy5FILW6nFfrR5aVPjd
 IqRVz55/Wz6M8/LBDmSEdkcnsu6YHN0uzyR7ClGilkZoQeJuvSR9HgBSX4cZJaoy5egS
 mj2c3uuGCLp3X/UUU4UnHpVn198dYNxd64LxlhYcRBmCNSCt0gyOp709Oq++rChcYFWc
 BFUbB4O/ywBqNTjMjHyOg3CptfFNDC/SrH4zUYyLT4+YH+OBVTwzikJ0RfybRo+OkKDb
 vke/xo/F77VAMAF2Byg3mJPT3xGaP6o1v/iosNbSKM8eeHzqZGl4ZULXx0YZV+TZLs9Q
 MaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567124; x=1794171924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cskILEOFBvsCfkOEs8tP3Mj0fACqDWfujI2HV3hkyVI=;
 b=iT4askkr+gMUPfLmXIdd1bbv/5xOc8WhS36NATqgKeHYyZqwxDr1cQHBjz7fzEcT70
 W5CSpVIddEQeCYcjiYiBgihOE4loE689S859mEfArx+dwi1cxvBP/bM2BTm0LCPdAekn
 qp3L/6JwXvXVe9VnEZzLwr15dJElI2bbXYIgj36wBHzFa0sy+eKTN4VNaAfCz+JBVtRE
 yj5g+hcDqX2R8drU/LkZc+3W20LQrAwuw/e7oBRCWMpiTRF6V2eE5A5zjaxbFkMMM9OL
 uICmLlLr9C24+vX2c1bj1kCmiwWAg31QivQqrqCyd8FYdKN/jcNkGaUCzlmsmUmUk58M
 04QQ==
X-Gm-Message-State: APuU4Z+jh9JRF70DJZDvUEOWbXZAv8qNA7yn5EYEkJBrvyU3kS/d+eV2
 jPIoPMni1lAnZfd7gH0CSQXT5TV10b89x8CWJRkACipuVZBN8dNYYiQyyP68goI4
X-Gm-Gg: AYBFou1d5/8raOaRJrx7aoQ2lAC1ilYVLA1z398aHCU1bvMnxMgowXLKOVRZyDZzNxG
 zqkJGTOWHUT2Zl/fFkEiQiSEZgfWVLHsq/fQYfgjx038PdGEh3EghzXynExCndbpZP6LtrFIqkK
 uDZmuSouc8EU0MnpA+6l6EsBlFVR+lNTzbKEhVR9rTMG8Ei0beaha05bOfSeTU0XH5jjAv7Rh6z
 oiQPV4rCXODrbVAtoZJE0G3rptQk9iSV4Inihkcak6+tsX2IwyAAyMtRgCVYcnwZiyRFNXEUUPy
 aTgZpFb7JoUm2NcdVaeDASGP/ndGvHRkzEGx+8PZaqBgLZfz+F4tQcUWkC8jCazaxZLQSPh7cNX
 vxWn8g6CXOxbcUO9PmL5JvKCYLPey7sT5oo6W25OJ7p5BfSrH613KYh026dCl1TVeLdV9NISFIt
 O4jeTmf4P5Z2YhtIYnKsmhB9nxxmWuYg3WMT28wEM72gTvvgY8JDX/1I4LSymN9sRMy9hsHqxbV
 3PXHAmmN5XY5P5qswiOyduTLTlyBWx8BgyhQZP1I0vLZEV14cf8lsYidFNnwoZXQn4NVppSSZ6z
 XdpNDzAcQ1hkmjtJ9ck0Ap8xGBJ/eKv8ukCI3wmbrhcfEXNjfw7EAHxdrAWGvY5LhKg=
X-Received: by 2002:a2e:a902:0:b0:3ab:4814:6129 with SMTP id
 38308e7fff4ca-3acb7adb1fbmr18042821fa.18.1793567124053; 
 Sun, 01 Nov 2026 13:05:24 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:22 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
Date: Sun,  1 Nov 2026 23:04:40 +0200
Message-ID: <20261101210449.1235102-2-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the C906 support for the D1/D1s(F133) SoCs:

- T-Head cache operations from the custom cache instructions
- harts_early_init() programming MXSTATUS, MHCR and MHINT
- cleanup_before_linux() disabling interrupts and flushing the caches
- dram_init() from the device tree memory nodes
- the T-Head CSR, CCU clock and memory map headers
- SUN20I Kconfig (cache line size, T-Head CMO support)

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/cpu/sun20i/Kconfig                 |  6 ++
 arch/riscv/cpu/sun20i/Makefile                |  5 ++
 arch/riscv/cpu/sun20i/cache.c                 | 88 +++++++++++++++++++
 arch/riscv/cpu/sun20i/cpu.c                   | 44 ++++++++++
 arch/riscv/cpu/sun20i/dram.c                  | 21 +++++
 arch/riscv/include/asm/arch-sun20i/clock.h    | 71 +++++++++++++++
 arch/riscv/include/asm/arch-sun20i/cpu.h      | 18 ++++
 .../riscv/include/asm/arch-sun20i/thead_csr.h | 29 ++++++
 9 files changed, 283 insertions(+)
 create mode 100644 arch/riscv/cpu/sun20i/Kconfig
 create mode 100644 arch/riscv/cpu/sun20i/Makefile
 create mode 100644 arch/riscv/cpu/sun20i/cache.c
 create mode 100644 arch/riscv/cpu/sun20i/cpu.c
 create mode 100644 arch/riscv/cpu/sun20i/dram.c
 create mode 100644 arch/riscv/include/asm/arch-sun20i/clock.h
 create mode 100644 arch/riscv/include/asm/arch-sun20i/cpu.h
 create mode 100644 arch/riscv/include/asm/arch-sun20i/thead_csr.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..14c8ca817fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -144,6 +144,7 @@ source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
 source "arch/riscv/cpu/k3/Kconfig"
 source "arch/riscv/cpu/k230/Kconfig"
+source "arch/riscv/cpu/sun20i/Kconfig"
 source "arch/riscv/cpu/th1520/Kconfig"
 
 # architecture-specific options below
diff --git a/arch/riscv/cpu/sun20i/Kconfig b/arch/riscv/cpu/sun20i/Kconfig
new file mode 100644
index 00000000000..7f459518cfe
--- /dev/null
+++ b/arch/riscv/cpu/sun20i/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SUN20I
+	bool
+	select SYS_CACHE_SHIFT_6
+	select SYS_CACHE_THEAD_CMO if !SYS_DCACHE_OFF
diff --git a/arch/riscv/cpu/sun20i/Makefile b/arch/riscv/cpu/sun20i/Makefile
new file mode 100644
index 00000000000..556aa842ec1
--- /dev/null
+++ b/arch/riscv/cpu/sun20i/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += cache.o
+obj-y += cpu.o
+obj-y += dram.o
diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cache.c
new file mode 100644
index 00000000000..c961eded109
--- /dev/null
+++ b/arch/riscv/cpu/sun20i/cache.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * T-Head C906 cache operations for the Allwinner D1 (sun20i).
+ */
+
+#include <asm/arch/thead_csr.h>
+#include <asm/cache.h>
+#include <asm/csr.h>
+#include <cpu_func.h>
+#include <linux/bitops.h>
+
+/*
+ * T-Head cache maintenance instructions, emitted as raw encodings because the
+ * assembler does not know them: dcache.ciall (write back and invalidate all),
+ * dcache.iall (invalidate all), icache.ipa (invalidate the line holding the
+ * physical address in a0) and sync.i (wait for the operation to complete).
+ * They only decode while MXSTATUS.THEADISAEE is set, which harts_early_init()
+ * does before any of them is used.
+ */
+#define THEAD_SYNC_I            ".long 0x01a0000b"
+#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
+#define THEAD_DCACHE_IALL       ".long 0x0020000b"
+#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
+
+static inline void sync_i(void)
+{
+	asm volatile (THEAD_SYNC_I ::: "memory");
+}
+
+void flush_dcache_all(void)
+{
+	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
+	sync_i();
+}
+
+void invalidate_dcache_all(void)
+{
+	asm volatile (THEAD_DCACHE_IALL ::: "memory");
+	sync_i();
+}
+
+void invalidate_icache_range(unsigned long start, unsigned long end)
+{
+	register ulong addr asm ("a0") = start & -CONFIG_SYS_CACHELINE_SIZE;
+
+	for (; addr < end; addr += CONFIG_SYS_CACHELINE_SIZE)
+		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
+	sync_i();
+}
+
+#if CONFIG_IS_ENABLED(RISCV_MMODE)
+
+void icache_enable(void)
+{
+	invalidate_icache_all();
+	csr_set(CSR_MHCR, MHCR_IE);
+}
+
+void icache_disable(void)
+{
+	csr_clear(CSR_MHCR, MHCR_IE);
+}
+
+int icache_status(void)
+{
+	return csr_read(CSR_MHCR) & MHCR_IE;
+}
+
+void dcache_enable(void)
+{
+	invalidate_dcache_all();
+	csr_set(CSR_MHCR, MHCR_DE);
+}
+
+void dcache_disable(void)
+{
+	flush_dcache_all();
+	csr_clear(CSR_MHCR, MHCR_DE);
+}
+
+int dcache_status(void)
+{
+	return csr_read(CSR_MHCR) & MHCR_DE;
+}
+
+#endif
diff --git a/arch/riscv/cpu/sun20i/cpu.c b/arch/riscv/cpu/sun20i/cpu.c
new file mode 100644
index 00000000000..503d6fc4a9b
--- /dev/null
+++ b/arch/riscv/cpu/sun20i/cpu.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * Allwinner D1 (sun20i) SoC support, based around the T-Head C906 CPU core.
+ */
+
+#include <irq_func.h>
+#include <asm/arch/thead_csr.h>
+#include <asm/cache.h>
+#include <asm/csr.h>
+#include <linux/bitops.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
+
+void harts_early_init(void)
+{
+	if (!CONFIG_IS_ENABLED(RISCV_MMODE))
+		return;
+
+	/*
+	 * T-HEAD ISA extensions -- the cache operations in cache.c decode only
+	 * with THEADISAEE set -- and misaligned access.
+	 */
+	csr_set(CSR_MXSTATUS, MXSTATUS_THEADISAEE | MXSTATUS_MM);
+	/* Branch prediction, return stack and the D-cache write policy. */
+	csr_set(CSR_MHCR, MHCR_BTB_C906 | MHCR_BPE | MHCR_RS | MHCR_WA);
+	/* Instruction prefetch and way prediction. */
+	csr_set(CSR_MHINT, MHINT_IWPE | MHINT_IPLD);
+}
diff --git a/arch/riscv/cpu/sun20i/dram.c b/arch/riscv/cpu/sun20i/dram.c
new file mode 100644
index 00000000000..91007c0a3d3
--- /dev/null
+++ b/arch/riscv/cpu/sun20i/dram.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/arch/riscv/include/asm/arch-sun20i/clock.h b/arch/riscv/include/asm/arch-sun20i/clock.h
new file mode 100644
index 00000000000..8496c0e814b
--- /dev/null
+++ b/arch/riscv/include/asm/arch-sun20i/clock.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2007-2011
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ * Tom Cubie <tangliang@allwinnertech.com>
+ *
+ * (C) Copyright 2026 Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * Allwinner D1 (sun20i) clock register definitions.
+ */
+
+#ifndef _ASM_RISCV_ARCH_CLOCK_H
+#define _ASM_RISCV_ARCH_CLOCK_H
+
+#include <linux/bitops.h>
+
+/* MMC clock bit field (common with H6 generation) */
+#define CCM_MMC_CTRL_M(x)               ((x) - 1)
+#define CCM_MMC_CTRL_N(x)               ((x) << 8)
+#define CCM_MMC_CTRL_OSCM24             (0x0 << 24)
+#define CCM_MMC_CTRL_PLL6               (0x1 << 24)
+#define CCM_MMC_CTRL_PLL_PERIPH2X2      (0x2 << 24)
+#define CCM_MMC_CTRL_ENABLE             (0x1 << 31)
+/* H6+ doesn't have these delays */
+#define CCM_MMC_CTRL_OCLK_DLY(a)        ((void)(a), 0)
+#define CCM_MMC_CTRL_SCLK_DLY(a)        ((void)(a), 0)
+
+/* MMC module clock config register offsets */
+#define CCU_MMC0_CLK_CFG                0x830
+#define CCU_MMC1_CLK_CFG                0x834
+#define CCU_MMC2_CLK_CFG                0x838
+
+/*
+ * MMC gate/reset register. The "H6" in the name refers to the
+ * H6-generation CCU register style that the sun20i SoCs share with
+ * the other Allwinner sunxi SoCs. The exact symbol name is dictated
+ * by drivers/mmc/sunxi_mmc.c, which uses it from asm/arch/clock.h.
+ */
+#define CCU_H6_MMC_GATE_RESET           0x84c
+#define RESET_SHIFT                     16
+
+/* PLL6 (PERIPH0) register offset and bitfields */
+#define SUNXI_CCU_PLL6_CFG_OFF          0x020
+#define SUNXI_CCU_PLL6_CTRL_N_SHIFT     8
+#define SUNXI_CCU_PLL6_CTRL_N_MASK      GENMASK(15, 8)
+
+#ifndef __ASSEMBLY__
+#include <asm/arch/cpu.h>
+#include <asm/io.h>
+
+/**
+ * clock_get_pll6() - read the PLL6 (PERIPH0) clock rate
+ *
+ * Returns the PLL6 output frequency in Hz.
+ */
+static inline unsigned int clock_get_pll6(void)
+{
+	u32 rval = readl((void *)(SUNXI_CCM_BASE + SUNXI_CCU_PLL6_CFG_OFF));
+
+	int n = ((rval & SUNXI_CCU_PLL6_CTRL_N_MASK) >>
+		 SUNXI_CCU_PLL6_CTRL_N_SHIFT) + 1;
+	int div2 = ((rval >> 1) & 0x1) + 1;
+	int p0 = ((rval >> 16) & 0x7) + 1;
+	/* The register encodes the doubled PLL6 frequency; the NCAT2
+	 * (D1/R528/T113) PLL_PERIPH0 output is the plain (1x) rate.
+	 */
+	return 24000000UL * n / 2 / p0 / div2;
+}
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_ARCH_CLOCK_H */
diff --git a/arch/riscv/include/asm/arch-sun20i/cpu.h b/arch/riscv/include/asm/arch-sun20i/cpu.h
new file mode 100644
index 00000000000..d20c0139426
--- /dev/null
+++ b/arch/riscv/include/asm/arch-sun20i/cpu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * Allwinner D1 (sun20i) memory map.
+ */
+#ifndef _ASM_RISCV_ARCH_SUN20I_CPU_H
+#define _ASM_RISCV_ARCH_SUN20I_CPU_H
+
+#define SUNXI_CCM_BASE			0x02001000
+
+#define SUNXI_SID_BASE			0x03006200
+
+#define SUNXI_DRAM_COM_BASE		0x03102000
+#define SUNXI_DRAM_COM_BASE2		0x03202000
+#define SUNXI_DRAM_PHY_BASE		0x03103000
+
+#endif /* _ASM_RISCV_ARCH_SUN20I_CPU_H */
diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
new file mode 100644
index 00000000000..4d6e15aab1c
--- /dev/null
+++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
+ */
+
+#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
+#define _ASM_RISCV_ARCH_THEAD_CSR_H
+
+#define CSR_MXSTATUS            0x7c0
+#define CSR_MHCR                0x7c1
+#define CSR_MHINT               0x7c5
+
+#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enable */
+#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory type */
+#define MXSTATUS_MM             BIT(15) /* misaligned access enable */
+
+#define MHCR_IE                 BIT(0)  /* icache enable */
+#define MHCR_DE                 BIT(1)  /* dcache enable */
+#define MHCR_WA                 BIT(2)  /* dcache write allocate */
+#define MHCR_RS                 BIT(4)  /* return stack enable */
+#define MHCR_BPE                BIT(5)  /* branch prediction enable */
+#define MHCR_BTB_C906           BIT(6)  /* branch target prediction enable */
+
+#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
+#define MHINT_IWPE              BIT(9)  /* icache way prediction enable */
+
+#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */
-- 
2.43.0

