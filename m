Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E109CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7078A80812;
	Wed,  5 Feb 2025 14:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCa5Je0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C11880207; Wed,  5 Feb 2025 08:17:38 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9EB805D7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dce090bbe5so306644a12.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739855; x=1739344655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5GiEX4Ce7O5IXGdbInfpRUWzilsPXovczUoQbMqHaM=;
 b=LCa5Je0TLFQzOWhNiugWpFUEY41Ok05ka7S5IiNJrGH2luWGX11hxkhnC+MA5AFAaW
 5ZtEhgPJ5VGcjvB0saRTBlO39QHtKdGcmTRKPFq2wy2lSG2aEiwvUOnT8GuckvTSaKkD
 o4est/5/E62JMGgnVH47mfAouAXmyNsJUt9Ffj5Liq7l/JkwEYakjQCk8Pdp1Pgja/97
 70DYdMQpdW/HmHBziHsouKX5l67iddhav7Gp9wR4z6LVrpXeAeQKHQIuhonNpqO9BpG3
 MRDX+VKBleTlhUfC0RU9TX3+KIBj7iArlK/oDnbVDWG0GzMESXs9mrtnshK0fDRt9wwh
 00kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739855; x=1739344655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5GiEX4Ce7O5IXGdbInfpRUWzilsPXovczUoQbMqHaM=;
 b=i4l+C8a4Zo1W5XJX1UBVI/3/gJljn1ldilIdCwkNA4vqSQs5F5psImsDeW7VThbtBR
 1E4vfxgh99ZaLxRbL36xHjaKxxRf/9ETfmt3dbF+MIs3Tomo6v/AXXM+GSBZ5uBpyre/
 me9mkaFDF+B8Ja7dgqOi8WnM0zPOthrgyjsRpr96w8w236rWoWDjYeYcMa6Yf6W1tPlx
 p9nith2SBG1Tpx6cQBFIdNNIQKtRwCRiEXMaUw2+7/qbKm2dUVYc2/ICCUtv09eEXi+5
 bcXLheT0Yoc9VsO71KR3UuLVMBYNAGPgT6VkCi8gqE5mkti/WxOAApgTxzf2mXkP4qNY
 CIYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHMkUZckMV7QaimQQFbeCiy/r1cxVgd7IIzHoZZEKwJJCjd5/6hfANX0T2RtDwejuQXq1rdnA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5RsL1UPKd4LsLyighXEgFhUPm+b3iGxpBEsdDIPe3qFB4e4B1
 oHnJ/sU8Q3CBx9QG3zEbD091W/6fmdKikNR7cM/YZ+7XpdkTaFkFiG4DFkbTdRg=
X-Gm-Gg: ASbGnctBdxsjvtjVRrPYhfX2xZOsWrnpsi0MQISS+zMlg9m+UtrxKEhtaNNp9nZjGu/
 Z5DEoncU7369Ga1EEIoPDetBZaJSY26cCOb7UQu2WTYMLecBCV9L6oIyq4mnn0/ufqw4L0hFNqP
 A+MTRe60944p4NbhnM7ynDuq3TyBJnhsa4QsGG+D7uDqrc2ImDqq2t1t8NEF2pAsS21i6iZpY7W
 0CjvBTBFXps6JsMn4U7cNdUIaxsy2wgBDcfOaaAK1H0xEySTEAUXp/Dp7Yb9np+cMASBk67UBcV
 Nngd8YFmSxphUwBA+fSztRlTdqtApWp+TGh+LagfVk+5v0ZpibAz38NO66e/XIwfqyWG
X-Google-Smtp-Source: AGHT+IEW8caKd9iSiuTLlV1iCLEVCO9Uc73cheEpQzEwuBVvITrDVWPEGfbxgPjrxM2tf8XQ4WQe1A==
X-Received: by 2002:a05:6402:448f:b0:5dc:545:40a7 with SMTP id
 4fb4d7f45d1cf-5dcdb716df9mr2138064a12.12.1738739855360; 
 Tue, 04 Feb 2025 23:17:35 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:34 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 2/6] doc: update meminfo with arch specific information
Date: Wed,  5 Feb 2025 09:16:46 +0200
Message-ID: <20250205071714.635518-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Since we added support in meminfo to dump live page tables, describe
the only working architecture for now (aarch64) and add links to public
documentation for further reading.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/usage/cmd/meminfo.rst | 71 +++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
index 6c94493cccc6..cf123f653059 100644
--- a/doc/usage/cmd/meminfo.rst
+++ b/doc/usage/cmd/meminfo.rst
@@ -18,7 +18,8 @@ Description
 
 The meminfo command shows the amount of memory. If ``CONFIG_CMD_MEMINFO_MAP`` is
 enabled, then it also shows the layout of memory used by U-Boot and the region
-which is free for use by images.
+which is free for use by images. In architectures that support it, it also prints
+the mapped pages and their permissions. The latter is architecture specific.
 
 The layout of memory is set up before relocation, within the init sequence in
 ``board_init_f()``, specifically the various ``reserve_...()`` functions. This
@@ -26,8 +27,9 @@ The layout of memory is set up before relocation, within the init sequence in
 ending with the stack. This results in the maximum possible amount of memory
 being left free for image-loading.
 
-The meminfo command writes the DRAM size, then the rest of its outputs in 5
-columns:
+The meminfo command writes the DRAM size. If the architecture supports it
+(currently only aarch64) dumps the page table entries and then the rest of
+its outputs in 5 columns:
 
 Region
    Name of the region
@@ -99,28 +101,61 @@ free
     Free memory, which is available for loading images. The base address of
     this is ``gd->ram_base`` which is generally set by ``CFG_SYS_SDRAM_BASE``.
 
+Aarch64 specific flags
+----------------------
+
+More information on the output can be found
+Chapter D8 - The AArch64 Virtual Memory System Architecture at
+https://developer.arm.com/documentation/ddi0487/latest/
+
+In short, for a stage 1 translation regime the following apply:
+
+* RWX: Pages mapped with Read, Write and Execute permissions
+* RO:  Pages mapped with Read-Only permissions
+* PXN: PXN (Privileged Execute Never) applies to execution at EL1 and above
+* UXN: UXN (Unprivileged Execute Never) applies to EL0
+
 Example
 -------
 
 This example shows output with both ``CONFIG_CMD_MEMINFO`` and
-``CONFIG_CMD_MEMINFO_MAP`` enabled::
-
-    => meminfo
-    DRAM:  256 MiB
+``CONFIG_CMD_MEMINFO_MAP`` enabled for aarch64 qemu::
+
+    DRAM:  8 GiB
+    Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
+    [0x0000023ffe1000]                          |  Table |            |               |
+      [0x0000023ffe2000]                        |  Table |            |               |
+        [0x00000000000000 - 0x00000008000000]   |  Block | RWX        | Normal        | Inner-shareable
+        [0x00000008000000 - 0x00000040000000]   |  Block | PXN UXN    | Device-nGnRnE | Non-shareable
+      [0x00000040000000 - 0x00000200000000]     |  Block | RWX        | Normal        | Inner-shareable
+      [0x0000023ffea000]                        |  Table |            |               |
+        [0x00000200000000 - 0x0000023f600000]   |  Block | RWX        | Normal        | Inner-shareable
+        [0x0000023ffeb000]                      |  Table |            |               |
+          [0x0000023f600000 - 0x0000023f68c000] |  Pages | RWX        | Normal        | Inner-shareable
+          [0x0000023f68c000 - 0x0000023f74f000] |  Pages | RO         | Normal        | Inner-shareable
+          [0x0000023f74f000 - 0x0000023f794000] |  Pages | PXN UXN RO | Normal        | Inner-shareable
+          [0x0000023f794000 - 0x0000023f79d000] |  Pages | PXN UXN    | Normal        | Inner-shareable
+          [0x0000023f79d000 - 0x0000023f800000] |  Pages | RWX        | Normal        | Inner-shareable
+        [0x0000023f800000 - 0x00000240000000]   |  Block | RWX        | Normal        | Inner-shareable
+      [0x00000240000000 - 0x00004000000000]     |  Block | RWX        | Normal        | Inner-shareable
+      [0x0000023ffe3000]                        |  Table |            |               |
+        [0x00004010000000 - 0x00004020000000]   |  Block | PXN UXN    | Device-nGnRnE | Non-shareable
+    [0x0000023ffe4000]                          |  Table |            |               |
+      [0x00008000000000 - 0x00010000000000]     |  Block | PXN UXN    | Device-nGnRnE | Non-shareable
 
     Region           Base     Size      End      Gap
     ------------------------------------------------
-    video         f000000  1000000 10000000
-    code          ec3a000   3c5d28  efffd28      2d8
-    malloc        8c38000  6002000  ec3a000        0
-    board_info    8c37f90       68  8c37ff8        8
-    global_data   8c37d80      208  8c37f88        8
-    devicetree    8c33000     4d7d  8c37d7d        3
-    bootstage     8c32c20      3c8  8c32fe8       18
-    bloblist      8c32000      400  8c32400      820
-    stack         7c31ff0  1000000  8c31ff0       10
-    free                0  7c31ff0  7c31ff0        0
-
+    video        23f7e0000   800000 23ffe0000
+    code         23f68a000   156000 23f7e0000        0
+    malloc       23e64a000  1040000 23f68a000        0
+    board_info   23e649f80       78 23e649ff8        8
+    global_data  23e649df0      188 23e649f78        8
+    devicetree   23e549df0   100000 23e649df0        0
+    bloblist     23e547000     2000 23e549000      df0
+    stack        23d546ff0  1000000 23e546ff0       10
+    lmb          23d546ff0        0 23d546ff0        0
+    lmb          23d543000     3ff0 23d546ff0        0
+    free         40000000 23d543000 27d543000 ffffffffc0000000
 
 Return value
 ------------
-- 
2.47.2

