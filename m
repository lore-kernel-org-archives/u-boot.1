Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7DCC02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 04:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5867B801CF;
	Mon, 20 Jan 2025 05:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="SN6oMFCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D783805C5; Mon, 20 Jan 2025 05:29:43 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFEE80085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CEEE23F965; Mon, 20 Jan 2025 04:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1737347379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOxCEfmPS6XtTYuvyCWI61cmyl+LjclyzYzBg4mfuJk=;
 b=SN6oMFCdeLTJcLOrUjlzS8Vumkxjh2YknUmn425JEQ6UosXAuCR9ToLyioHqOdtKsGjihX
 KF2l82/jjIja89NbOupluAWk0J0mtieDVO9ODzbI1yM5J6c52wnsffT6gwaqZptzrEnYM0
 jO6a+WaLFZ3qNqy+eBdqU6dx06igP2QfGSf72Zrn24m2msdgGsMhQGoob+4XDAuQeuQRmg
 0I6oYA9Vjd17z2/lsNasUONdSIWSw8j0xq7Zsj/ND/9ATfCuPTPxr86xgGzs23TLAueFyM
 zcWPlKia1kjKgFm5veDCbAdfqez29w/urFXVkJW5Qb0QiOTpbfR1LHB/4f9ENQ==
From: Huan Zhou <me@per1cycle.org>
Date: Mon, 20 Jan 2025 12:29:20 +0800
Subject: [PATCH v5] riscv: spacemit: k1: probe dram size during boot phase.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-get-dram-size-v5-1-2ad4f2e7a270@per1cycle.org>
X-B4-Tracking: v=1; b=H4sIAB/RjWcC/33MTQrCMBCG4auUrI1kkkwbXXkPcZEm0zagrSRS/
 KF3N+1KiroZeAe+58USxUCJ7YsXizSGFIY+B24K5jrbt8SDz82kkChAGN7SjftoLzyFJ/ESXYM
 7CygFsLy5RmrCffGOp9xdSLchPhZ+hPn7SxqBA9e1JSXJNRWWhytFcA93pu0QWzZro/wQQK8Fm
 QVbW7TSAOXzTVB/BZUFozw2xgBqr78J+kOQYi3oLFClQShSpS/rtTBN0xvf2hEhdAEAAA==
X-Change-ID: 20250108-get-dram-size-65cf59a15201
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737347363; l=2870;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=EyhydsQem4mqyduZ2k5rYfyf+pv0MkTrubI+azSFHnk=;
 b=HhAGK8eg9xQR+PTUCF6mcxmLzktbpQ9+L2wu5yJ6nUNHQkHd4WFBzUi6iQ76JOZLDonWQg8Y9
 kTrnyhpIlSCAJDNDOIRFhp1oNAhrctQKEP5BAttyMHfeCtEo5nXzTN/
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Implement functionality to probe and calculate the DRAM size
during the boot phase for the RISC-V spacemit K1 platform.

Tested-by: Marcel Ziswiler <marcel@ziswiler.com> # BPI-F3 16G
Signed-off-by: Huan Zhou <me@per1cycle.org>
---
This patch introduce improvement for get dram size on spacemit k1 platform,
retrieving the dram size dynamically.
Have tested on Licheepi LPI3A 8G[1].

Links:
[1] https://gist.github.com/per1cycle/e4eab66ebb6f83fe5118e823367fce28 .

Changes in v5:
- Fix the dummy typo.
- Link to v4: https://lore.kernel.org/r/20250120-get-dram-size-v4-1-e74103e36d6b@per1cycle.org

Changes in v4:
- shorten the commit message.
- More proper way for `map_format_size` -> `ddr_map_size`
- Link to v3: https://lore.kernel.org/r/20250114-get-dram-size-v3-1-83d5f88154d4@per1cycle.org

Changes in v3:
- Remove the inline attr in arch/riscv/cpu/k1/dram.c map_format_size().
- Add detailed commit message.
- Link to v2: https://lore.kernel.org/r/20250114-get-dram-size-v2-1-aba5a281ea28@per1cycle.org

Changes in v2:
- Fix bracker and return type in map_format_size() function.
- Add test log in the cover letter..
- Link to v1: https://lore.kernel.org/r/20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org
---
 arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..cc1e903c9dd6ed79796730c25b2d365ba102ad75 100644
--- a/arch/riscv/cpu/k1/dram.c
+++ b/arch/riscv/cpu/k1/dram.c
@@ -4,17 +4,53 @@
  */
 
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <config.h>
+#include <bitfield.h>
 #include <fdt_support.h>
 #include <linux/sizes.h>
 
+#define DDR_BASE 0xC0000000
 DECLARE_GLOBAL_DATA_PTR;
 
+static phys_size_t ddr_map_size(u32 val)
+{
+	u32 tmp;
+
+	if (!(val & 0x1))
+		return 0;
+
+	tmp = bitfield_extract(val, 16, 5);
+	switch (tmp) {
+	case 0xd:
+		return 512;
+	case 0xe:
+		return 1024;
+	case 0xf:
+		return 2048;
+	case 0x10:
+		return 4096;
+	case 0x11:
+		return 8192;
+	default:
+		pr_info("Invalid DRAM density %x\n", val);
+		return 0;
+	}
+}
+
+phys_size_t ddr_get_density(void)
+{
+	phys_size_t cs0_size = ddr_map_size(readl((void *)DDR_BASE + 0x200));
+	phys_size_t cs1_size = ddr_map_size(readl((void *)DDR_BASE + 0x208));
+	phys_size_t ddr_size = cs0_size + cs1_size;
+
+	return ddr_size;
+}
+
 int dram_init(void)
 {
 	gd->ram_base = CFG_SYS_SDRAM_BASE;
-	/* TODO get ram size from ddr controller */
-	gd->ram_size = SZ_4G;
+	gd->ram_size = ddr_get_density() * SZ_1M;
 	return 0;
 }
 

---
base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
change-id: 20250108-get-dram-size-65cf59a15201

Best regards,
-- 
Huan Zhou <me@per1cycle.org>

