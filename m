Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36401CAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C219834EC;
	Sun, 14 Sep 2025 15:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HRQPTMrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECBB82A9E; Sun, 14 Sep 2025 13:01:35 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AF380B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso2747512fac.1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847691; x=1758452491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lh5UeoOjjm7tv+vdMHYq8/yNCF9jxyBv0fAf4MtmWBw=;
 b=HRQPTMrXIkVFe4MQmJTElD9UYpgitUFnoQhXMM90kj8S8t9ApLaqRwBTaFEKiy52W0
 YPc2TQ79sczE+47HPpf1rnDFu5Jk+SIa2so6egLUZXhvp/usZou7aKkNk1XTH+tu4bdX
 s4ulBSr87QN/POctNtxPP2Ry/UQi2x/tgEOQiHSWI90Fa3FmFgZlZoJ3jMA2EjwMi3Io
 yh/xw/9GyniGCsF3eQHdvT6v7Y08sR0yxL/IT9jww9uztaICE16dBPgblPoKLGAL8izz
 /AUeX3+FLlaC7ICMW6BT8/pv52ranNnnmQtWtr1ydxi3qo/F7t4AL0PjacqJuBIcx8nZ
 SoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847691; x=1758452491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh5UeoOjjm7tv+vdMHYq8/yNCF9jxyBv0fAf4MtmWBw=;
 b=OWmIAaMDute1Zy2U65MHWUu2SoKXnEWanxUMt8brHT0iq+gDTBOIIiE7FOVcwSHDW2
 HmOMVgpDGUhiQ5vfyckL30/QmkhJ0B0748YtJfK0hF32OCyzMgqIoxJagevPYoXJdKmz
 XpaZiErBhaVpCv1vvLaFeB1aaqbipss94vGdl0JXNTeKEeJKfbxIxQP1cYJfmKClORRv
 jxnC4JJlDP68PFKZsYZm4w9GI7B2+bxu5eES1zx8Ox/eElo7WxjWhuJdwc7J2NCXe50l
 kcRRT/FXr237hOpr88UegMzxqik1nL617IX9r2Lqmks1G0mDXWmZtAaDAdqpeGdt7OBz
 BAmg==
X-Gm-Message-State: AOJu0YyOxlZ/grlJtMR/YFr94rlrRTHWyHwLcuYvvmDF6QFCuG+63mjJ
 wBbmsguSoRjOGU9uc43sFJMOxR+RaXgYgMkESW8yiig05ClDO+lmyGzkFI/Znais
X-Gm-Gg: ASbGncu0c8010sM22F//CmwJOfeu675kRX8l1IBiPlk6bc7JhCHm9z3LTTKa20cb+Jo
 dVio88evzqXiISrVF8BaHwmR7imDfFd3jRdcC2uuwUleARpghmQQDHlsUPLJRN1/WjU7l8KhQjb
 6khF5oofoSn5i6bfQPXncUQkg6CovVTt79OcE2d1pa6F+4Vxo+95WRGbCWIzd+vZ3Snl4D2Kn8p
 ShQW3s2DjPJAjUU9ZfzDn5y/kisNxYU2LPtbT6MPI0bX78jIz56aU+cx68rqQVFZp1IOMydDwBC
 8CA9HEGTAgcIA04NpouQcuCZx8XNRsqQoNnpKtSUwFIxZ8F0bVjVQOPMb/URVLQBrvLodWTC5Yv
 7ENnj9csyU59WEWlSI4sM+yFkTU+n2eW3gfRu6sh/Hio/MOSTVRdVp0c0+TXMegXFK2IN3FFTPi
 jHDziIWg==
X-Google-Smtp-Source: AGHT+IF8qZTjrMpC5sgrVq/VytkS3ulmI30h1oQXEhfeMRCWUBfWMUM+BboF0Mok36wo61cj32NQ2w==
X-Received: by 2002:a05:6870:9e04:b0:315:2bda:851d with SMTP id
 586e51a60fabf-32cc802ac7cmr7181113fac.22.1757847691363; 
 Sun, 14 Sep 2025 04:01:31 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:30 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 7/7] doc: binman: Add guidance for determining ELF load
 addresses
Date: Sun, 14 Sep 2025 10:59:32 +0000
Message-ID: <20250914110021.4103-8-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Add documentation to help users understand how to determine where ELF
files will be loaded when using binman's 'fit,load' property. This
addresses the common confusion about how load addresses are determined
from ELF files.

The documentation explains three methods:
1. Using readelf to examine program headers
2. Checking the linker script (.lds file)
3. Using objdump to see section addresses

Also includes a specific example from binman tests showing how
elf_sections.lds sets ATF load address to 0x00000010 and
elf_sections_tee.lds sets TEE load address to 0x00100010 to avoid
memory overlap conflicts.

This helps users debug memory layout conflicts more efficiently when
working with FIT images containing multiple ELF components.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/entries.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12a39d070e4..f6a5465ca44 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1050,6 +1050,24 @@ split-elf
         Generates a `load = <...>` property with the load address of the
         segment
 
+        Note: The load address comes from the ELF file's program header or
+        linker script. To determine where an ELF file will be loaded, you can:
+
+        1. Use readelf to examine the program headers:
+           ``readelf -l your_elf_file.elf``
+           Look for the LOAD segments and their VirtAddr (Virtual Address)
+
+        2. Check the linker script (.lds file) used to build the ELF:
+           Look for the `. = <address>;` statements which set the location
+           counter and determine load addresses for different sections
+
+        3. Use objdump to see section addresses:
+           ``objdump -h your_elf_file.elf``
+
+        For example, in binman tests, elf_sections.lds sets ATF load address
+        to 0x00000010, while elf_sections_tee.lds sets TEE load address to
+        0x00100010 to avoid memory overlap conflicts.
+
     fit,entry
         Generates a `entry = <...>` property with the entry address of the
         ELF. This is only produced for the first entry
-- 
2.43.0

