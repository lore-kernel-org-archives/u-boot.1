Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A0BFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676F9843C3;
	Sat, 25 Apr 2026 18:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="ht11/RbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594ED83FB0; Sat, 25 Apr 2026 18:27:44 +0200 (CEST)
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BB48435B
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
 by pp2023.ppsmtp.internal (8.18.1.7/8.18.1.7) with ESMTP id 63NBsBHD002802;
 Thu, 23 Apr 2026 13:54:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps; bh=R+b4RDdrcH6jlGlvmP1Zalm75p3W
 wjvoXirDbKld+tg=; b=ht11/RbYSTii2ZyWTrgXazD5y8m8Jjbe0delm2atN3SI
 Dx5g+VWTNH+Ebu3GdEm5eMgjQUD7CyBAhcmXz0WbydCA0cz/81gVTdc9p3KfNZnq
 r1wBob/JgB9E0sNjLBvkd/abFqYPafQ+Z3j5ojscdXTpaca5pJEuQIlQKObwI8Ht
 KpYVWcNpwqIhAIbRgc6nW2pER5Z1GHrb7W3HKeG5sw+qAJX/Q2daJGPOZXO6hcKW
 OoJ+SIldfW/NNrBJOQBPkWNpBIKVJ3mBRj9q/IscNm7I9MQvF5WxOp6SZhVZFrNw
 O1xY6t/2i9j4AkcqrK2deRz2qhf2OpD3eniujzTUAQ==
From: <fedor.ross@ifm.com>
Subject: [PATCH 0/2] Add SPI NOR A/B switching support and detect A/B image
 on MX95
Date: Thu, 23 Apr 2026 13:54:41 +0200
Message-ID: <20260423-b4-imx95_img_set_sel-v1-0-1681ea8b1507@ifm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEI6mkC/x2MQQqAIBAAvxJ7TjDZlPpKRFRutVAWGiGEf086z
 GEOMy8E8kwB2uIFTw8HPl2Wqixg3ka3kmCbHZRUWqKSYkLBR2zqgY91CHRndmGQ9IQVWlIGcnp
 5Wjj+265P6QMsyBi/ZgAAAA==
X-Change-ID: 20260420-b4-imx95_img_set_sel-74e6b414de27
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776945295; l=907;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=2OiXwLvbw9vrE4PKnFbRiFen5o/sdf+wgDdlmGVyFpw=;
 b=kLfdh+Gu6/J5WEO1fSXxcMcx/3QzizKOoGXWOzLWdZk8A6DzxAAdyEADLIVY9PS9HLD/HLMH/
 f2caj2RmVplC0ClBSu/IsGPWKgESiI5hCsNs4T4OmU6umz9f4krx+2+
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.122]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4dpjh9dc92 QID=4dpjh9dc92-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
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

This series adds support for SPI NOR A/B switching support on i.MX95 .
Therefore, add a function to obtain selected boot image by reading out
ROM data via SCMI. With this in place, it is also possible to implement
the getprisec subcommand of bmode command to detect which of A/B image
was booted.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Fedor Ross (1):
      imx9: scmi: soc: Add support for detecting primary/secondary bmode on MX95

Marek Vasut (1):
      imx: Add SPI NOR A/B switching support

 arch/arm/mach-imx/Kconfig           |  2 +-
 arch/arm/mach-imx/image-container.c | 10 ++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c   | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)
---
base-commit: e973fa5115e40f93bb1425db5b1cc1f3d9b8047d
change-id: 20260420-b4-imx95_img_set_sel-74e6b414de27

Best regards,
-- 
Fedor Ross <fedor.ross@ifm.com>

