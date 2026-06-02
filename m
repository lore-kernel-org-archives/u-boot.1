Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2294CD6E68
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 16:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE7884855;
	Tue,  2 Jun 2026 18:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkw3Tu+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75738485F; Tue,  2 Jun 2026 18:24:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD5284852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 18:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rmandrad@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso105281855e9.2
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780417497; x=1781022297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=gkw3Tu+iDXmaxfIYIknocnmsU1WcwyV+BHodx2SgvxNPiMsXHVgeNGV0TOE65wsks3
 klRbSo05OA+CarZAt87QZ67WImmbWhJaxQlZjQXiEfLUQ1daShzMQwF0bJW7sgaEhFKp
 TFOH0ITD7C8K6koRlaeYDz50iWxpth5048vMM45EYtxXQ3UCT66FLTZW1tUygMWbuu/b
 d6FFuNNT1uWtsOIXS/ZcSUjGxYnHh99izITt3ik4uJwEFJ3rqbitcLq4X+RmKvv8nPd9
 To/BxS02E3uf7tJsO4zRIBUBqhzgncpzhPbJvj9fkcveOH7HHIY4y9O3F6bWLI3cMWsc
 QT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780417497; x=1781022297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=cqMytCTcUHAIIawpx28PKohIWZ3moukmTX0Y0GWP7hOIeynciwFayGeimlb6ig1kVb
 BfqevIgszNK7yiVTPH7yhSsvWEgwbICHtNIPhfP4uySsMqxirOV8BFZpf2hwejemCoUR
 8SVP0PoI3gc/IBc7bnAz3mLccTE5E4zf0yBodqxY4P2x6AAjPr1SE0ZnulvmLX5QvZiR
 IIXpIpZWWFir8+v9rVFfMMs2CTJpSSn3viaVo/BLxPXNE27GKyVMBX3Ncga2g60Rh1Ja
 VHWzgYmG3nR3WtrcQ7vO+vfHx7E+ZqBLMHt9Hne/xFaPFzEP1908S4R/EsuzY1gG2hg4
 OD1A==
X-Gm-Message-State: AOJu0Yze+3Q/SglQUDgZxlnZyYx+Kp2rXDjAg6Bw/McIoef/rzFx061C
 UDwD/bkqy7GCzhkOVzXQQcJfN4o8iw3Lwe5X6kvek76N4k6ew8c2FmLeS6dfgFY=
X-Gm-Gg: Acq92OEGl8Id6hd2KopK7r0o+u9LGZyAA5GG9Am8OrAYE9MmTabPzGRc0qwX2ELkSX/
 OrPFkLZR6uZJcHTuBHX8EfqAmBWlA8PRcje24b86eIVCcrCQyoK78Y+P11rUuguGZ9MlUadu8+/
 jxNdZtxkqhCgdGIuqZ7MGyckemZqABks5j2uN5Gmnp1sqEwI7taG9SV1YD//pJfRm6i54RHsBSp
 RoAru+f33rijTEKnhSbtbHfdT2Mt5noKfHdO/w59YVTiF/uCCYjAh/52znn/TRv9pjLXcoh7Uvm
 wE9vImj2DSaHHxJprSGcey5ndG5fq5K4kZStOjEzsu89eGvMga32Sf98vOpCdb5Q1vcphw/Vql4
 4o/HdX+b4kcWpC988uZx3OYQ1rLRfxJylmH8VVr8BXKmEC/bhzyLyLQdRx6CiLeNERW9CnOnx+0
 EXJmokk2/U/lFMzwiQ4wZSkh1vAD+gTrt+qx64H5AfNgm+evYgak8+iYCF6pFky8kyKm8W+80KZ
 BDOT41M
X-Received: by 2002:a05:600c:c4a5:b0:490:b432:6f1e with SMTP id
 5b1f17b1804b1-490b50bb1a9mr7190325e9.33.1780417497137; 
 Tue, 02 Jun 2026 09:24:57 -0700 (PDT)
Received: from nuclin (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net.
 [86.18.22.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e76feasm76394935e9.9.2026.06.02.09.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:24:56 -0700 (PDT)
From: Rudy Andram <rmandrad@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com,
 Rudy Andram <rmandrad@gmail.com>
Subject: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
Date: Tue,  2 Jun 2026 17:22:33 +0100
Message-ID: <20260602162233.2418471-1-rmandrad@gmail.com>
X-Mailer: git-send-email 2.54.0
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

