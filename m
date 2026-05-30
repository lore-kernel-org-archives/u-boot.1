Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0526CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 07:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB26883DA6;
	Sat, 30 May 2026 09:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ybg4EzUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE59283FB0; Sat, 30 May 2026 07:25:53 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEC1805D7
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 07:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rmandrad@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso88794545e9.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780118751; x=1780723551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=Ybg4EzUZbta7aDADDe4spatL71Xr98Z+WAMYgK1pVfcMLWxuSzfWwzi/19/O++QUCq
 kCDcJhbcFLAdEvPtIgtxp/y7nz+FSnrLulw8WvqWaVWW5kfzhVsNecnOIbSO/f8J8TtA
 h/PDaAHMknl5FV9Enhh4BeA0ApvHYRJ5eS7ViaUdLZUJTseOZYvVNA+Hqoo3hRGxrrcN
 cVAQhyE+dTEZI4pjwqk2x/VxlUUCGRFGuZBgLKEAHc//Kur8RN7Zxf8BTytyRS7pPXTv
 2RY5owTyk45Sz7onEE4cgUcjlCXDGPbJL9pUuZfIHP7zyhpnpc6AVNq1+pfs7LUp91Jt
 jW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780118751; x=1780723551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=f0Ebtb859/uUwJIkN4hCzQ6ZrSvMgSpGAIAFekXimWmqruR4lpVS7WI1Vo9AdsJ8Xx
 LWDfx74cE4BSa77FC/MfAES9hF4Ivq8UdvhKhzc/TZHtjJczWTaTApa6tsEWZ0m+Jsh+
 D0pAdBwfnNtg5VZoeVtSREoK3jWnXooVR6ZKydcaU6e04tZTH7m8duTEf30qqINt6ph8
 /H/F19RMkGE50Fp/rSfhbi2reSHgo/MVF75pdmjEMULtnG+md6QrlslaeHLx9dnCoPdM
 BgbYAFkkiaB0dxjiLVxv0qHe5ihXpjO+SjzxadM4+JxnX+7spEeBi7r0TSMcw/Qv8zH6
 lEZQ==
X-Gm-Message-State: AOJu0YyfM7mVOvNDwCROPs32g9pPcVDX+ZpSoClYZvpwGdpnoqadHiJY
 Lvvel6V0aVxOFdVMBV4n0RIZxT/j3wB12ZHkN4qUeFqFIR/+xAE2wSqKoXR06F8=
X-Gm-Gg: Acq92OGTpAN5yzXpAUyu5NPBRv48HVwmY10EGc9l4zJPugRD3ZNvOT7zJreviqgTrzz
 CIwEcsTp2rR26QblAngWi9BI+z6lI/vdSL3gchDZx7RBNiv9mgbOnWz69XiXOWKyJ/xQ2NaxC0K
 CKx0DTVr6fZ6IFBOi6S9MoK6hBhtHgHRg1kUIDNcDAqEB67jcrPapI7fGHWV8oWY/JlDK1Nufip
 CxXC32ZMbhzsxBr+TRPZXxPI208uy0unqMIe6x4qWSq9TOudH3lPQk0aoYGRgFI4EbsmOt3Mo1P
 IWS6cRTcu+MssIYRh/UraYQrXT2AOEJrOVwdmZ+OV945t0i+xzztH/EHB2DGkDZulCfwxTxVJIv
 9+CuEQfOEzM+QuV1FFRXvyynZv16k7xnR4heyOgjgVQdzVBSbxAo51mRnMuxbBtR+S4+7N0e9A9
 I9sPVHHc+BbMHvTu58XTuSCDofx+lli9YUBS8tOJ13GyLnCh56YDIeBGdUSTYZuU/OkLbThsV6h
 /YiHGY7
X-Received: by 2002:a05:600c:8706:b0:490:b07:5fd1 with SMTP id
 5b1f17b1804b1-490a497e947mr10060955e9.11.1780118751034; 
 Fri, 29 May 2026 22:25:51 -0700 (PDT)
Received: from nuclin (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net.
 [86.18.22.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d696f25sm122910605e9.5.2026.05.29.22.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 22:25:50 -0700 (PDT)
From: Rudy Andram <rmandrad@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com,
 Rudy Andram <rmandrad@gmail.com>
Subject: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
Date: Sat, 30 May 2026 06:24:19 +0100
Message-ID: <20260530052419.2139556-1-rmandrad@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 09:05:21 +0200
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

MT7988 detects the full installed DRAM in dram_init(), but after
commit bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
it fell back to the generic dram_init_banksize() implementation.

That generic path populates bd->bi_dram[0].size with
get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB is
installed.

As a result, U-Boot reports the full DRAM in gd->ram_size but exposes
only the low 3 GiB through bd->bi_dram[]. This truncated map can then
propagate to later stages through memory handoff and DT fixups.

On a Banana Pi R4 Pro 8G (MT7988), bdinfo shows:

Before:
  DRAM bank   = 0x000000000
  -> start    = 0x0000000040000000
  -> size     = 0x00000000c0000000

After:
  DRAM bank   = 0x000000000
  -> start    = 0x0000000040000000
  -> size     = 0x0000000200000000

Restore the MT7988-specific dram_init_banksize() implementation so
bd->bi_dram[0] publishes gd->ram_base and gd->ram_size again.

Version tested
U-Boot 2026.07-rc2-bpi-g6a1580973a11-dirty (May 27 2026 - 14:39:18 +0000)

Fixes: bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
Tested-by: Rudy Andram <rmandrad@gmail.com>
Signed-off-by: Rudy Andram <rmandrad@gmail.com>
---
 arch/arm/mach-mediatek/mt7988/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 7f4d934bfe9..08eb73d42b1 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -26,6 +26,15 @@ int dram_init(void)
 	return 0;
 }
 
+int dram_init_banksize(void)
+{
+	/* Report the full detected DRAM size to later stages. */
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
+}
+
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();
-- 
2.54.0

