Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA01CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB4F83C62;
	Wed,  7 Jan 2026 00:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UTh1SYpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173D383FF9; Wed,  7 Jan 2026 00:22:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767DE83C08
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0cbd=7M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767741727;
 bh=vW/O1UPNRrVK9BcAfdeoifaKBA1DrXyTs/AVhbm6eqA=;
 b=UTh1SYpIv0Hb1JnEx4ksAdRda7E3luqjR1LV+E2/hNmvbQLVEcg3bqpOs06c2X3h4IkBmvohb
 5FkXrNIwfjsVFOjuBMKIvX5ImVe8Q1UIb1o2bROGSQKmjC2IPIqZTBddz858X7vgkRUevloSTEw
 hu4ZS5YnTIFYH5sA9BihbPeuwWMM2X/ipECFOZU3hBsuduthhOCd5eF5dUaHS+68OH9Qhx6bTsA
 Ac553VxOWBJPxBddCC2QP7PHfqV6B2GBto3T5ioRDihqzKYNWEUPXSLGVmCAFLJnOcyHFSFBfHe
 ftW1xuJSbEx6Tf/xJSJI2BEb6wVvAzsbzTGa4h3/xipQ==
X-Forward-Email-ID: 695d991a4c4fab46c299b2e5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH v4] rockchip: sdram: Add fallback that fixup DRAM gaps on
 RK3588
Date: Tue,  6 Jan 2026 23:21:51 +0000
Message-ID: <20260106232154.3178240-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

RK3588 has two known memory gaps when using 16+ GiB DRAM,
[0x3fc000000, 0x3fc500000) and [0x3fff00000, 0x400000000).

The vendor TPL blob encodes this information in the DDR_MEM tag data
passed to later boot phases. U-Boot proper will normally use this
information to configure the DRAM banks.

When a DDR_MEM tag cannot be found the fallback is to use the entire
range above 4 GiB. Something that will cause issues when OS try to use
memory from the two known memory gaps.

Add a weak dram init banksize fixup function and implement it for RK3588
to fix issues observed when trying to RAM boot RK3588 boards with 16+
GiB DRAM into Linux.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v4: Collect r-b tag
    Drop already applied patches
v3: No change
v2: New patch to fix booting into OS on RK3588 boards with 16+ GiB DRAM
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 27 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/sdram.c         |  7 ++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 55d2caab4fec..6324c6f12867 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -211,6 +211,33 @@ int arch_cpu_init(void)
 }
 #endif
 
+/*
+ * RK3588 has two known memory gaps when using 16+ GiB DRAM,
+ * [0x3fc000000, 0x3fc500000) and [0x3fff00000, 0x400000000).
+ *
+ * Remove the [0x3fc000000, 0x400000000) range to ensure OS does not
+ * use memory from these gaps when a DDR_MEM tag cannot be found.
+ */
+
+#define DRAM_GAP_START		0x3FC000000
+#define DRAM_GAP_END		0x400000000
+
+int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
+{
+	size_t ram_top = bd->bi_dram[1].start + bd->bi_dram[1].size;
+
+	if (ram_top > DRAM_GAP_START) {
+		bd->bi_dram[1].size = DRAM_GAP_START - bd->bi_dram[1].start;
+
+		if (ram_top > DRAM_GAP_END && CONFIG_NR_DRAM_BANKS > 2) {
+			bd->bi_dram[2].start = DRAM_GAP_END;
+			bd->bi_dram[2].size = ram_top - bd->bi_dram[2].start;
+		}
+	}
+
+	return 0;
+}
+
 #define RK3588_OTP_CPU_CODE_OFFSET		0x02
 #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
 
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index d560f90e873d..ea0e3621af72 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -289,6 +289,11 @@ static int rockchip_dram_init_banksize(void)
 }
 #endif
 
+__weak int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
+{
+	return 0;
+}
+
 int dram_init_banksize(void)
 {
 	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
@@ -342,7 +347,7 @@ int dram_init_banksize(void)
 #endif
 #endif
 
-	return 0;
+	return rockchip_dram_init_banksize_fixup(gd->bd);
 }
 
 u8 rockchip_sdram_type(phys_addr_t reg)
-- 
2.52.0

