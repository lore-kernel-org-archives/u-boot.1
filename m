Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB6FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8D683AA9;
	Mon, 27 Apr 2026 15:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="Jb7T5P01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF0B8410D; Mon, 27 Apr 2026 15:33:03 +0200 (CEST)
Received: from pp0155.ppsmtp.net (pp0155.ppsmtp.net [132.145.231.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B8483C14
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2080.ppsmtp.internal [127.0.0.1])
 by pp2080.ppsmtp.internal (8.18.1.7/8.18.1.7) with ESMTP id 63RDUsSK001223;
 Mon, 27 Apr 2026 15:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps; bh=SUur+G
 Bm5+jTW/OjYookQkjsGU/Dc9HCh4sMgsxfddY=; b=Jb7T5P01c34jdbyV5If0Qh
 PryayjdECUu0elMSATcKxZ5gv8jDVPhFYKLVfxsFnysQFU6KW7x86cr2MIXykJ2V
 6Hkh0v/F8SmvE/6rxthrUhtEWQzvJgBsXeBA8XX/b+s8CbC+FBcfWOnc8+4FI1EX
 2mQBRhnbbai7HsPXeGItOFGUQQgZxlCiz/pdneqbaMZB65NZDAaBlzBQSflkyeyJ
 jmFL6ywJtxs0Dj5PLNrZRaPd6IzhaFjhCOnRJKQeNF3HfoVN0er5FDsASlXfOpRf
 R669557CaXXsK+hKzG31vnhrqWp3cpUJZleXnFNEbNVBCocU4VmEc6wd0b5oZjtg
 ==
From: <fedor.ross@ifm.com>
Date: Mon, 27 Apr 2026 15:32:50 +0200
Subject: [PATCH v2 1/2] imx: Add SPI NOR A/B switching support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-b4-imx95_img_set_sel-v2-1-b5d760ebc89b@ifm.com>
References: <20260427-b4-imx95_img_set_sel-v2-0-b5d760ebc89b@ifm.com>
In-Reply-To: <20260427-b4-imx95_img_set_sel-v2-0-b5d760ebc89b@ifm.com>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "Ji Luo" <ji.luo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, "Ranjani
 Vaidyanathan" <ranjani.vaidyanathan@nxp.com>,
 Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777296777; l=2189;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=jaquh9s509zrsu8+ldJ8b0HCncdm8d0kvbcz/FO8NgE=;
 b=doCJHzP5WRZQLYRQnq9xtsUFD1H3PllGn5dRsNd4ZXibhv8TgPzmuOq59mkgGBZ4ch/ScVyeg
 5yPaKtbDfobDyf0n4jkr8pWNxZ+7ZM3nd3x+N/RcbKDi77c7f0+/kLd
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.123]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4drntpc4nc QID=4drntpc4nc-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
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

From: Marek Vasut <marex@nabladev.com>

Query the SM via SCMI, obtain rom_passover_t->img_set_sel and based on
that, add 0 or 0x400000 offset (A or B copy offset) to boot container
read address.

Signed-off-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  2 ++
 arch/arm/mach-imx/image-container.c        |  8 +++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c          | 13 +++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index dead7a99a66..73df8715f22 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -23,6 +23,8 @@ int low_drive_freq_update(void *blob);
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
 int get_reset_reason(bool sys, bool lm);
 
+u8 imx95_detect_secondary_image_boot(void);
+
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
 #endif
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 7bfcc9d7e9d..63cf8596316 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -225,9 +225,15 @@ static bool check_secondary_cnt_set(unsigned long *set_off)
 			}
 		}
 	}
-#endif
+#elif IS_ENABLED(CONFIG_IMX95)
+	u8 img_set_sel = imx95_detect_secondary_image_boot();
+
+	*set_off = img_set_sel ? 0x400000 : 0;
 
+	return !!img_set_sel;
+#else
 	return false;
+#endif
 }
 
 static unsigned long get_boot_device_offset(void *dev, int dev_type)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..330b276b23a 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -745,6 +745,19 @@ void build_info(void)
 	puts("\n");
 }
 
+#if IS_ENABLED(CONFIG_IMX95)
+u8 imx95_detect_secondary_image_boot(void)
+{
+	rom_passover_t rdata = { 0 };
+	int ret = scmi_get_rom_data(&rdata);
+
+	if (!ret)
+		return rdata.img_set_sel;
+
+	return 0;
+}
+#endif
+
 int arch_misc_init(void)
 {
 	build_info();

-- 
2.47.3

