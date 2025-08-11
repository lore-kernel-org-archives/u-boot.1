Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5346CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 07:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF088334A;
	Mon, 11 Aug 2025 09:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rudi-horn.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=rudi-horn.de header.i=@rudi-horn.de header.b="xYf7i/py";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D498E83381; Mon, 11 Aug 2025 09:35:25 +0200 (CEST)
Received: from mail.rudi-horn.de (mailv6.rudi-horn.de
 [IPv6:2604:9a00:2100:af04:21::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8C88334A
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rudi-horn.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dyn-git@rudi-horn.de
Received: from [192.168.178.22] (dhcp-82-220-85-57.bbcs.solnet.ch
 [82.220.85.57]) (Authenticated sender: journal)
 by mail.rudi-horn.de (Postfix) with ESMTPSA id AB3DE1A04A4;
 Mon, 11 Aug 2025 09:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rudi-horn.de;
 s=mail-vserver01-rudi-horn; t=1754897722;
 bh=1Yab8s95ynLEsEXIOYGfFJtLICuwk3HqXaICbKzz1Ys=;
 h=Date:From:Subject:To:Cc:From;
 b=xYf7i/pyH2ay91Aq09LtoexVuGsPphym7JeEoouYH6DiEisOQB0aHjVX84kAXrtzS
 YasO2UtQK9g0EMAy5atVr5GTpha3+Q6pwb6y7c2KQ5SvbLqKtuXE1vRELeAp0r4FoO
 1gkmQ/cRI+eEsDO5i3IQ5mT8QRsoOdwn1sur7mUpY8Ho/jyleMvzZG+5i5v4N0WRKk
 Wj2hv2R5oz9wdA6X7ste+TNRSabmFih3lAdMEZZ/vow7wf0bYXnSb1Ask2E7zuFvA+
 JjA+Eky2Iv9y+Tbq3YL301MXZ0HgwZQJrFN7Ohwysxgm9R8hT3+/XQjVfgjGmBE7/N
 nP8/3K/yXhDMAeguvPOzT60naX4enIGo+d6xOHCrd55OptuFnHUDA+1qZClOx5XDKG
 FZ5M+ILLwCj38vDciXLeuUJOvMPUEnuEr6oP2ngK01OlSDsdgIAxHI+l9CWL7yCOGM
 /DnCNHaMHYo8WvOSkq0K5uJc3ZiOLBGLxXmJEkRsOvt26I1pcXrqaDV6O4KCEHsCOV
 mijELU+KOC1aeTilOu0Cfa0mAI5HJe3EHOHqDZnp9Pfkfy6HjKVIRQgjq+SEFSNmPf
 CAnFc12uIwPUXISsAKp5zcFkA60gScm3NCpPM4Y2ATZFiVqMqcYj2YM4d/T/a/liN4
 d9f/RKQXVfNRvG0f0ewx0keY=
Message-ID: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
Date: Mon, 11 Aug 2025 09:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rudi Horn <dyn-git@rudi-horn.de>
Subject: [PATCH] Fix detection of odd memory configurations on sunxi
To: u-boot@lists.denx.de
Cc: jernej.skrabec@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 09:59:48 +0200
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

Hello,

I encountered a bug where u-boot detects that my OrangePI zero 3 (with 
1.5GB)
has 2GB and crashes. The orangepi u-boot source code contains an additional
modification in the `mctl_calc_size` which removes a quarter of the 
memory the
calculated last address cannot be written to:

https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arch/arm/mach-sunxi/dram_sun50i_h616.c#L1365-L1368

I'm not entirely sure if there is some specific logic that applies to this
modifier, but it does fix the issue on my system.

I propose the following patch, but am open to any further suggestions.

Thanks,
Rudi Horn

Note: Submitted in my personal capacity and is not affiliated with my 
employer.


 From 2199f3b28e5fc853ed1921586358c33f3f1502d3 Mon Sep 17 00:00:00 2001
From: Rudi Horn <dyn-git@rudi-horn.de>
Date: Mon, 11 Aug 2025 08:58:34 +0200
Subject: [PATCH] arch: arm: mach-sonxi: Fix detection of odd memory
  configurations

Fix detection of odd memory configurations. Previously 1.5GB devices were
incorrectly detected as 2GB devices, causing u-boot to crash.

Signed-off-by: Rudi Horn <dyn-git@rudi-horn.de>
---
  arch/arm/include/asm/arch-sunxi/dram.h |  1 +
  arch/arm/mach-sunxi/dram_dw_helpers.c  | 10 +++++++++-
  arch/arm/mach-sunxi/dram_helpers.c     |  8 ++++++++
  3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram.h 
b/arch/arm/include/asm/arch-sunxi/dram.h
index 0eccb1e6c28..7580421ca77 100644
--- a/arch/arm/include/asm/arch-sunxi/dram.h
+++ b/arch/arm/include/asm/arch-sunxi/dram.h
@@ -44,6 +44,7 @@
  unsigned long sunxi_dram_init(void);
  void mctl_await_completion(u32 *reg, u32 mask, u32 val);
  bool mctl_mem_matches(u32 offset);
+bool mctl_mem_matches_upto(u32 offset);
  bool mctl_mem_matches_base(u32 offset, ulong base);

  #endif /* _SUNXI_DRAM_H */
diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c 
b/arch/arm/mach-sunxi/dram_dw_helpers.c
index 24767354935..5bcd2672465 100644
--- a/arch/arm/mach-sunxi/dram_dw_helpers.c
+++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
@@ -146,5 +146,13 @@ unsigned long mctl_calc_size(const struct 
dram_config *config)
         u8 width = config->bus_full_width ? 4 : 2;

         /* 8 banks */
-       return (1ULL << (config->cols + config->rows + 3)) * width * 
config->ranks;
+       unsigned long size = (1ULL << (config->cols + config->rows + 3)) 
* width * config->ranks;
+
+       /* some memory configurations such as 1.5GB rely on this to 
compute the correct size */
+       if (!mctl_mem_matches_upto(size)) {
+               size = (size * 3) / 4;
+               debug("capping memory at 0x%lx\n", size);
+       }
+
+  return size;
  }
diff --git a/arch/arm/mach-sunxi/dram_helpers.c 
b/arch/arm/mach-sunxi/dram_helpers.c
index 83dbe4ca98f..68c75fa07a6 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -61,4 +61,12 @@ bool mctl_mem_matches(u32 offset)
  {
         return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
  }
+
+/*
+ * Test if memory at offset matches memory at end of DRAM
+ */
+bool mctl_mem_matches_upto(u32 offset)
+{
+       return mctl_mem_matches_base(offset - sizeof(u32), 
CFG_SYS_SDRAM_BASE);
+}
  #endif
--
2.43.0

