Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6629DC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D3B80F7B;
	Thu, 20 Feb 2025 22:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QXVRmvOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2BF80F5F; Thu, 20 Feb 2025 14:55:47 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1A88001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so6929285e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059744; x=1740664544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=QXVRmvOmXIxJY0NavCQHtSzljlx93O+UmrKjPX76kaBXhIoC3vS1YfB2hbEqabUpb0
 2cInTALQO1vke1e6VvKgHGOAlhIbIcMKOaxNwRPCwjA3794nloYPL2H/60kyx9yvHMjZ
 PDL2XSrazGcot7YTjPiJbIqwQxJCUkKeV5YJPLDTSvBhzrkVusuywjv3x+0Pwt3/3ZC3
 QipVLCVtgrlTyM0B9iRvs8LyveX0dTisPZE7LNuQPpWE3c29C2od7u3D8uXADDWdLpXw
 bmUqeFsN+4CzGcv9uvxNS9Qvg3rM2Ia7zyJd84LDsh4IpLeVBSKwE2y0Ll1m+enz+rFf
 JOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059744; x=1740664544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4GSS1ETVKQO5Boy5/n9bcml4EPCbjNmO/frH+vfBuQ=;
 b=M6bqeFfSLGjSvOPaWX7aLFjvVotxZ0lFKe+cJqAXiFw+nq9qoOXlee//ei5UIXNFyX
 PFZY6dYeD+ZsWzKw5Cizb6ns+LTRuGZKbJZGimS6xCIJWZWg/cu2gXVohZ6Ix0+IGgZJ
 MHl5kys0hen5EnYqa32NlHYmS7XtBDKMwCDUs5PdnSc9xWsXvpVQPe78JfN+bO5Vn/hB
 +TNsZ3FYAEGhpu8swJ5cvWSzC2UwwaGCOru8mapWJRpi7pEaDHkKBcz6cBnlRCpiWSk4
 UN0kRlQWCnShKHwKLwaM6ooCMmbWVAFDo5qBSx9LT1p/AjVBSAdUzjxyoyRRfTMslloI
 IaLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQEF/No+EULa/2f9S5Qc0qKRE75n/6sZwlWBfXhRcjrXIIJJOYi4/06aR+6EVIrRY/SBSZpg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7H3OJbl+GnsWC67wcELPJt/2n/9FZ1FGnBgyIUgmFFZngQbJ4
 lG/TSbtlA9MVg3hbiO7BYMCB6vHj67zy/as+MC1ilW1WPhub9kRcxDidYCLlbq0=
X-Gm-Gg: ASbGncv+/TFxRFgQUo+4VVPWvEsuHbF+Hb0gzHycBCmvfMsU0ydKYUshPuaxzPnyCxA
 haI6aJ6m8qb9/UAt+foExgSJlEcRx6fyhn1ejNuyBJHe+n6iIbZs9Dtrrs/W5vXBsV6amtFJfRX
 ulZ82q3MjCN1pJ9juC2k4I7b/3m7qi1eJGMBcc+QwtxmuUXXcDaMSRwTFLxmKrkDH6V3kKWkbE3
 rejFdO0pfGzomjXrVUQ8m6/XM/WzKfOCUTMqc2GDcI1ocBcpZZhFZBAOfp8xTi1vHfswu+bRn4E
 OaG7pRETgrKJ6/GT2wZiXRKn9Tcd8fKw1kdk6za1ZYlhwxM8+vawt0yOnadfo/Kcek6oOg==
X-Google-Smtp-Source: AGHT+IHKm+MJOJ5fiOEWsq/B1c8wBjuI/8ayIHUjcKP6gZPOnLwp9yFQ1h+LN3cPdr813gYDfEMJCQ==
X-Received: by 2002:a05:600c:450d:b0:439:9dec:b7a2 with SMTP id
 5b1f17b1804b1-4399decb9a6mr63218455e9.2.1740059744214; 
 Thu, 20 Feb 2025 05:55:44 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:55:43 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 2/6] doc: update meminfo with arch specific information
Date: Thu, 20 Feb 2025 15:54:39 +0200
Message-ID: <20250220135506.151894-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

