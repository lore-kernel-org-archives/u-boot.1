Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01943FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F408416F;
	Mon, 27 Apr 2026 15:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="xYWhD9ZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E68A583C14; Mon, 27 Apr 2026 15:33:05 +0200 (CEST)
Received: from pp0155.ppsmtp.net (pp0155.ppsmtp.net [132.145.231.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DA78407D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2080.ppsmtp.internal [127.0.0.1])
 by pp2080.ppsmtp.internal (8.18.1.7/8.18.1.7) with ESMTP id 63RDUsSL001223;
 Mon, 27 Apr 2026 15:33:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps; bh=59rb21
 6GxlhWZb5exiJ8NGa2kPkOqWy+vsrjn9Pmsw8=; b=xYWhD9ZD4iRzliMaksEN6i
 tJNWop02BOd6IkKhZgSqwFtQV2XSS81bNNlvXkstjr0wIOXnVBHacoOw1zCquum9
 y1alVt+ONYKJgs2fvC+LZ6+eLsXPToCWOXPh+YmdfVrnKxIVZX9uD0/aYAu5X1sY
 iNYg1jtlqlsPv7GU1Y5ZYy2aFnMa4YKTtC/DXmGTn5EgZ3CTVRnrRklnlIAXeqvC
 Kj5QImbxdyx64AyXdU3QSohW/fjqdmq0DJ2h+2/iP3udSfiyK6/XLNPpxOzEvnV3
 tLzQZoVWoP9Fdrjt0005mIVg5fZwEOjG0H4P5oquYTAKkr9ZjusGCwY53XIF48Kw
 ==
From: Fedor Ross <fedor.ross@ifm.com>
Date: Mon, 27 Apr 2026 15:32:51 +0200
Subject: [PATCH v2 2/2] imx9: scmi: soc: Add support for detecting
 primary/secondary bmode on MX95
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-b4-imx95_img_set_sel-v2-2-b5d760ebc89b@ifm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777296777; l=1355;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=e0LTwSzlJVgqyHHT12HOhszgEQKJpdtWUHxV+V2tO2c=;
 b=H4LwALXjeyDR/7bfyZb9yOF+/2BvBLd/zEv5AXBkKvB3UbfP80h3h+4NXyD12tctSIJlZ88UT
 HpCoogRXb0eAeSZflKgk7Lbxy4CSSx3Ud/bCjrkhP21cEmyH2VMxP7f
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.123]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4drntpc4nh QID=4drntpc4nh-1
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

Implement the 'getprisec' subcommand of 'bmode' command for i.MX95 by
reading out the ROM log events. This event is set by the BootROM if it
switched to the secondary copy due to primary copy being corrupted.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 arch/arm/mach-imx/Kconfig         | 2 +-
 arch/arm/mach-imx/imx9/scmi/soc.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e4014226582..259f4a4ce99 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -74,7 +74,7 @@ config CSF_SIZE
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
-	depends on ARCH_IMX8M || ARCH_MX7 || ARCH_MX6 || ARCH_MX5
+	depends on IMX95 || ARCH_IMX8M || ARCH_MX7 || ARCH_MX6 || ARCH_MX5
 	help
 	  This enables the 'bmode' (bootmode) command for forcing
 	  a boot from specific media.
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 330b276b23a..47e8fc247df 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -756,6 +756,11 @@ u8 imx95_detect_secondary_image_boot(void)
 
 	return 0;
 }
+
+int boot_mode_getprisec(void)
+{
+	return !!imx95_detect_secondary_image_boot();
+}
 #endif
 
 int arch_misc_init(void)

-- 
2.47.3

