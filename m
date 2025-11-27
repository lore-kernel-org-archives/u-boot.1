Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6FCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 20:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F306C844C5;
	Thu, 27 Nov 2025 21:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="GVLvwnM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18C08437F; Thu, 27 Nov 2025 18:51:11 +0100 (CET)
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6CF83B2C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
 by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 5ARFiXZF030236;
 Thu, 27 Nov 2025 18:51:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps; bh=ntyPEAtf6TLJehQWeVROIe0d7LaN
 gveB7trjWQCErvs=; b=GVLvwnM8mrDTmsEhj6S3lPgu1KiaUk0PgbNpwunew0l5
 nxjrckqMjObg7Oa/jA6eM7SEOpIBb6dUCVl5DxG5Ax3LVyjXS6u8BJDr1mwnVD6q
 ldSTaUFVT+sxufNDDsiup5+Ab6i1e0n3+E6ptEg/mT9LZfhfi0/ecDrcWHpd3bCs
 hd1fU9UFAFKAwIZrYLkBI6MTJEbo3+M7WuI6Y3/eATXrUD6fOvhwVf05I1uxDvre
 oayScQ5pinK9Djxuxt0FtJhVYGwhfRPWcceGwQkeEf814XH3Fn+AJeal3i5RLjcN
 VNSN0DZNGel/Eh3eq3bPoFZBXd2JLSTqK+swuKmIkw==
From: Fedor Ross <fedor.ross@ifm.com>
Date: Thu, 27 Nov 2025 18:50:47 +0100
Subject: [PATCH] imx9: scmi: soc: USB instance number change for silicon
 revision B0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com>
X-B4-Tracking: v=1; b=H4sIAHaPKGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyNz3czcCkvT+CQD3VRTC0ND41RDA6PkJCWg8oKi1LTMCrBR0bG1tQC
 vNMJVWgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764265865; l=1286;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=YKHmPmbmM7DBE0CrqDHxx3AbxuyK0metB+IKIOlpiBo=;
 b=tk0j8QLTYw9pR2ck5MX+ruVP+Gdk/ROzwDwlHBFIt9XSnYG2NbkJ65Jv62KZaCk2oU57gScGy
 zBaxZHJ8jMKCyxHHrnW8m8jYgEXQK/y62bTE+Cb42bfKzz+SCJWDR1z
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.121]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4ak3x55yd6 QID=4ak3x55yd6-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Mailman-Approved-At: Thu, 27 Nov 2025 21:15:28 +0100
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
number. Select the correct numbering according to the selected revision
in the defconfig. The config for the B0 revision is IMX95 and for A1 it
is IMX95_A0.

This patch is based on the information provided by:
"AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index dbaa19a9e6e..354df7d88a4 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -921,7 +921,7 @@ enum boot_device get_boot_device(void)
 		break;
 	case BT_DEV_TYPE_USB:
 		boot_dev = boot_instance + USB_BOOT;
-		if (IS_ENABLED(CONFIG_IMX95))
+		if (IS_ENABLED(CONFIG_IMX95_A0))
 			boot_dev -= 3; //iMX95 usb instance start at 3
 		break;
 	default:

---
base-commit: 962711498ddac6179f1d1f3fa123397ba02a381b
change-id: 20251127-imx95_b0-e58113e102cb

Best regards,
-- 
Fedor Ross <fedor.ross@ifm.com>

