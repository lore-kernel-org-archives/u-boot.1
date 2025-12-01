Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E3ED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7A683B81;
	Mon,  1 Dec 2025 17:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="jRuflT+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AB183BC4; Mon,  1 Dec 2025 17:08:58 +0100 (CET)
Received: from pp0155.ppsmtp.net (pp0155.ppsmtp.net [132.145.231.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0568683B7E
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2080.ppsmtp.internal [127.0.0.1])
 by pp2080.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 5B1CYhVY022460;
 Mon, 1 Dec 2025 17:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps; bh=//cZQMdmG9/IgfHMk+RQN36dc/at
 DMPj9BCFPq1ZDpU=; b=jRuflT+6tLS8YsZj+1clSmXqniadEQcBU7E4cc53B7me
 6PX0a6J6MtVOHieh4zXg4pCs59nNp9ZyRgxenMBUtGgVHu74Zo1oBUdzvOBQ9+aJ
 aa1o0hn+Rmt8NzEixe4iJ05xVr6mCNT3rh5AQKC4cSTzHseDYf+R98cqpWUb4k5/
 6GRG8lBT2+qMmm5Rgt8WQUm8ay7BJJ8fRK6Oo7iwVx6CI1/qMn8q5pbosaukRtC+
 0gk+EjSOb/GcqiHbwgk5bihC+5pvHel+BAOPe3vKg2PRCsq7kq4sHPB00Ps9F5SS
 vpNvdjHZaVMNA0U3RWpSrzn2MJsux+Vv3H9BOXJhug==
From: Fedor Ross <fedor.ross@ifm.com>
Date: Mon, 1 Dec 2025 17:08:06 +0100
Subject: [PATCH v2] imx9: scmi: soc: USB instance number change for silicon
 revision B0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251201-imx95_b0-v2-1-7bc9851b7456@ifm.com>
X-B4-Tracking: v=1; b=H4sIAGW9LWkC/23MywrCMBCF4VcpszaSmRJvK99DijTpxM4ibUkkV
 Ere3di1y/9w+DZIHIUT3JoNImdJMk816NCAG/vpxUqG2kCaDCKdlYT1ap5WKzYXxJZRk7NQ70t
 kL+tOPbrao6T3HD+7nPG3/kEyKlTetXYg26M1p7v4cHRzgK6U8gWqfraRngAAAA==
X-Change-ID: 20251127-imx95_b0-e58113e102cb
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764605333; l=1477;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=GNuNgTpb6Vv8eNqCdVQ4Vxd1T5X9mgSN7mw5gLeSB4o=;
 b=pqWQUVxUewCPNILVYIo2UlaFE8H3thjzM/x3lUWsB8EW+gCC3PRTPkPzxn+25fZIAgENEeSBr
 GRbnw5/LqP3Bqxjmki1bqIZ2M5+rl4WEB+gZE7IzVQ1Nqd+jlkl1sC3
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.122]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4aqqk54vpf QID=4aqqk54vpf-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
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

For silicon revision A1, the USB instance number for USB1 is 3 and for
USB2 it is 4. This changed for revision B0 where the USB instance number
for USB1 is 0 and for USB2 it is 1, which is the intended instance
number. Select the correct numbering according to the selected SoC
(IMX95) and its revision.

This patch is based on the information provided by:
"AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .

Reviewed-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Changes in v2:
- Changed conditional to be more generic, based on feedback.
- Updated the commit message.
- Link to v1: https://lore.kernel.org/r/20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index dbaa19a9e6e..c1458ccca3c 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -921,7 +921,7 @@ enum boot_device get_boot_device(void)
 		break;
 	case BT_DEV_TYPE_USB:
 		boot_dev = boot_instance + USB_BOOT;
-		if (IS_ENABLED(CONFIG_IMX95))
+		if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
 			boot_dev -= 3; //iMX95 usb instance start at 3
 		break;
 	default:

---
base-commit: 31bf4a1c308773895a8e7ea047b3cea037e4c922
change-id: 20251127-imx95_b0-e58113e102cb

Best regards,
-- 
Fedor Ross <fedor.ross@ifm.com>

