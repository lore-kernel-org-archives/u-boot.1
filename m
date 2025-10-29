Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2ACCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 09:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD7C8004F;
	Wed, 29 Oct 2025 10:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5D480422; Wed, 29 Oct 2025 10:22:57 +0100 (CET)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B5D8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 10:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms02z.xe.abb.com (Postfix) with ESMTPS id ECC35C222;
 Wed, 29 Oct 2025 10:22:54 +0100 (CET)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025102910225421-44094 ;
 Wed, 29 Oct 2025 10:22:54 +0100 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025102910225458-21276 ;
 Wed, 29 Oct 2025 10:22:54 +0100 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] arm: dts: brcp1: Move SPL partition to offset 0x8000 in SPI
 flash
Date: Wed, 29 Oct 2025 10:22:47 +0100
Message-ID: <20251029092252.115582-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 10/29/2025 10:22:54 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 10/29/2025 10:22:54 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/29/2025 10:22:54 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 10/29/2025 10:22:54 AM,
 Serialize complete at 10/29/2025 10:22:54 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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

The ROM code of Xilinx Zynq searches the boot flash for a "BootROM header"
at increments of 32k (0x8000), beginning with 0x0000 for a
configuration without authentication and beginning with 0x8000
for a configuration with authentication. [1]

Move the offset of the SPL partition on the brcp1 board to 0x8000
so that both cases are the same, e.g. a board that is configured
without authentication can boot an SPL partition with or without
authentication.

[1] Zynq 7000 TRM, section 6.3 "BootROM Code"

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

---

 arch/arm/dts/zynq-binman-brcp1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynq-binman-brcp1.dtsi b/arch/arm/dts/zynq-binman=
-brcp1.dtsi
index 3cc8ee8b810..c853e8c7b15 100644
--- a/arch/arm/dts/zynq-binman-brcp1.dtsi
+++ b/arch/arm/dts/zynq-binman-brcp1.dtsi
@@ -15,7 +15,7 @@
=20
 		blob@0 {
 			filename =3D "spl/boot.bin";
-			offset =3D <0x0>;
+			offset =3D <0x8000>;
 		};
=20
 		fit {
--=20
2.51.2

base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
branch: us/brcp1=5Fmove=5Fspl
