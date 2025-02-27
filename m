Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C284C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9568D81112;
	Thu, 27 Feb 2025 13:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hhevTgc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C57810EA; Thu, 27 Feb 2025 13:15:42 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1308C801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so150401466b.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658539; x=1741263339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=hhevTgc0U9Fofcod5UW1LIzpmGpC3zOsphO3Vmmd/NgMqGWgFXk8Xz23egpapi/gmh
 xeZPodP/W8vMA3uLe0NwCKACT4366zOuXwqtIn4op5OWdLY/rzQipvEIaERsMbU3UG5+
 EIiokrNtSlE0pgTZHzNCuegtzYR/RZ3LHiBiGKMd8rFW7twcJYaA7uh3wUoUmTg+r80Z
 ewLJzSIBL69tz0qwTbwg9Wt0oBxuLcHhi1SeBsDqgywFbTNukLXK0+t+yzZOMDulhsDb
 dLpPKzypc8TERyV5gInpxIap6xAqOY0OCGhQM1HVtz5Fjx4L+oiVGITIEs4FM3NoorER
 75kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658539; x=1741263339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=dBN5gC7yPrSA83RqMomZigGF3NHdB0aMA+9JFMlqYr4z/k1UWFTaD6jG1rSwKwnoQ3
 nakqgwj2mU/ZCa35Z/YaD2lsmu8leMWCh7+eY1E3huJY0SHuaWbZUJlB1XUMTiJhb6Ba
 nNuGmF7bbRBTCJgJb9VuKOlp5GQkQlhVcTeleak92Bu3VaHJJmuEh+ZxUd0GhypUCb/B
 lxfzY4fH2LurKziCmtR5G8BqdPNeczTroe8leZ35g8V7HH9GZDgNoVxCzs7iQNmUD6D6
 BJqrajpMELtNOb+kn+XcQ5UwruoQH59bPKMLzrlGrHIVRhypsQNwcWnDB9E0Dr6RfA6z
 CdhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9qC1ghsZvtluc0FO768a2nncUhWhl0VhxMk1i5OgRUgcZf/ivKsGa5iHpNHzpuXBmxh8EXUw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6PxiTzefy2ESiM8QdUlHM7HIMkQPKGfptb3J8tZdp0dx/GwfG
 Px7tD04xdGEHFUx7NBtPSVcNfW9mY6Nakw7wkMuEZXUp2DbRX19ySA01aHdB+c8=
X-Gm-Gg: ASbGnctjyJ+mGHYKF2h8dTWhhISZeYURCrXM2AenbeajxopkCkdEW+qM4840zEPTV+y
 MqDVYbIhTYD1BRlp4E+3+M4NsxqfPdHuwXg8s66TXZMRsBSi1h8Kx8KpWOGSBNd0wYNsKX1l3zU
 rsV/bcWKmbVXJQYZvLG1G+945JR8/PW4VYFh1w/leS9YieA2gTcawXMTB/fnhYFic14gzvcRNCM
 QHKGfNqrh0ract/QJ96zTwtxDjosS/fvt/eMWLKhihSAH3onIwQSKRum2LRoSmiZ8HKSI3ry65O
 1jxWo5ksK8SMy4HL8ZRbIHKO1gM/XB/rg8fRGn1kQOLP1hov5LXRQtGb3DwZQ5y58geo5dLga5d
 G5jdA
X-Google-Smtp-Source: AGHT+IEEoBaUT42v5rYlMBa3TTJVc0E3Blz7iBOWipG0i9F9TRGWxQA/n6q9HvgQT4TsxmqSiSb3hA==
X-Received: by 2002:a17:907:1ca0:b0:aba:6385:b46d with SMTP id
 a640c23a62f3a-abed1079d36mr1479598766b.50.1740658539282; 
 Thu, 27 Feb 2025 04:15:39 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:15:38 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Joshua Watt <jpewhacker@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/6] doc: update meminfo with arch specific information
Date: Thu, 27 Feb 2025 14:14:52 +0200
Message-ID: <20250227121515.232996-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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
index 6c94493cccc6..e10bdc6832cf 100644
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
+The meminfo command writes the DRAM size. If the architecture also supports it,
+page table entries will be shown next. Finally the rest of the outputs are
+printed in 5 columns:
 
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

