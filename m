Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011DBC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A893781197;
	Sun,  2 Mar 2025 13:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vG8w4bK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DC8810F6; Sat,  1 Mar 2025 17:49:59 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C00A810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abf48293ad0so164959066b.0
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847796; x=1741452596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=vG8w4bK9I2Bgn6wrWWwZyl1xJQFh3ETZqeSGCztUE48uho1DhGKaRuHb7M6I3z5uz6
 oR4RgQbNfwtgFZLsC2JoGR4TnolddzEKI85BXwipHL+uixV8miAoW9g/rDdqJz+6oyAv
 nrwwrbx9hsYrfGOsn+H2fGUZy920cVZ+jdHJPcflDLNCQ33vLObuW5JnwpD2dfLCoLcD
 dWVxAvlufcqNZcxbR2Ke2nyk5OTol0OAyntkXCo5wWwvJhWHw/VOIRYf+emgm3eWFM2Q
 iJVvYtcP0s0UbJ3eHL7njIU1Cl4biLKJevI+yksjZEswb6PqEMUFPncFLf01DrZzq2Y1
 oWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847796; x=1741452596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=o0K3KP/q/L9bhSQdq//pKT8SynnL1EcAu+hmwEghY0TZDrEDliVGxpEgcIzQDp/5jc
 DwRoKB5PLiaaN9GKjTCOJsVVFsY5OB+adSOlI/YqPpsWpYv1+f+N81EcPUdST0Cpgise
 RHS4b9yEJG+6VNYRwv6ekfm5QgSO98/Pnh8hJayFv8hxQVSYoeu1uEFsurNaV7evfsKy
 P5LJq3b8PHe6iThUxK8BcC7p6M5JYJd0NwoC/b6F3iF8Pwc18oGAy55H8H462vT9aHX+
 AH/bkO4iZB0OHgVEqd/pvXAf6y5vvjN0eskoFHfFMN5EWPHOoBaH3upKCP+smOUFk+fR
 0vvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHuD+50kmTnKADNqTCT4TZNfhhHu1WFH82+vtiwhlZ5dwFFoDwF9BIvW2TgZhbjDv9+7WkHrU=@lists.denx.de
X-Gm-Message-State: AOJu0YxkY8/FO3ehyXCyK0cpfXbPTQd0E10BCr3PeSe8OW0PpaSuO2P/
 c4LaFV+3pSSVG6gdh5fz9BQCKGFNjppmo/J00w4DTkIhFUSr3732jVc10W+F4/A=
X-Gm-Gg: ASbGnctvEl791xCZ7ijHhibEUabHkluQv9AVsP93gDZv43L6gVNP992eKcS2aY7DQkp
 xOGt6iunK2yuv2jBKrEwxZ6K7cP2gjakH4vJfNEIRT8lm82EKgjuHHOAFOt7tCjJ3iaB/BYUtVP
 xEC2I+QP06oGzzTdDFt/lyx35eHXlr3gkZXxMaZGda7cXWyKOjhOqJeE+Lx94C1DExExNR0OGuc
 N99vD7eQnXowKHL6xdNPpcl+GYa2HmUQbHVH66KNxB5Cs9PHzEO1JiI7SHL//aE7TVOx7XB0t7q
 ZJLFOxQ7SrfRe0iIml0O/qLqCm0TSqIwmZUDOZVmxeZ+eFwj3s7CJ5SwJYrhpxvC64IJIu4mPSF
 74BLgdNNiktqN0knLhtU6/q4=
X-Google-Smtp-Source: AGHT+IHRyVrRkoKDuVnWFdiz0IUdm8Us8ITo4seInSgiomDLcHi3Wp+XNRh8dyWS1kGMiTfQGcmWcg==
X-Received: by 2002:a17:907:7d89:b0:ab7:d87f:665a with SMTP id
 a640c23a62f3a-abf265a2a1cmr935887966b.46.1740847795982; 
 Sat, 01 Mar 2025 08:49:55 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:49:54 -0800 (PST)
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
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 2/6] doc: update meminfo with arch specific information
Date: Sat,  1 Mar 2025 18:49:00 +0200
Message-ID: <20250301164922.397441-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

