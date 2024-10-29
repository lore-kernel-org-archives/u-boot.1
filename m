Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF4CD5B16F
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E558C89177;
	Tue, 29 Oct 2024 09:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E13D88BB7; Tue, 29 Oct 2024 09:54:35 +0100 (CET)
Received: from inet10.abb.com (spf.hitachienergy.com [138.225.1.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7092F88EF5
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.15.2.36])
 by inet10.abb.com (8.15.2/8.14.7) with ESMTPS id 49T8sTRc2635866
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 29 Oct 2024 09:54:29 +0100
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP2 HF7)
 with ESMTP id 2024102909542930-433527 ;
 Tue, 29 Oct 2024 09:54:29 +0100 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2024102909542965-13079 ;
 Tue, 29 Oct 2024 09:54:29 +0100 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH 3/4] board/BuR/common: split br_resetc_bmode function
Date: Tue, 29 Oct 2024 09:52:11 +0100
Message-ID: <20241029085258.1740289-4-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241029085258.1740289-1-bernhard.messerklinger@br-automation.com>
References: <20241029085258.1740289-1-bernhard.messerklinger@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 10/29/2024 09:54:29 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 10/29/2024 09:54:29 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP2
 HF7|September 06, 2024) at 10/29/2024 09:54:29 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP2
 HF7|September 06, 2024) at 10/29/2024 09:54:30 AM,
 Serialize complete at 10/29/2024 09:54:30 AM
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

Split br=5Fresetc=5Fbmode function to add support for reading of reset
reason in board code with br=5Fresetc=5Fbmode=5Fget.

Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation=
.com>
---

 board/BuR/common/br=5Fresetc.c | 129 ++++++++++++++++++++---------------
 board/BuR/common/br=5Fresetc.h |   1 +
 2 files changed, 74 insertions(+), 56 deletions(-)

diff --git a/board/BuR/common/br=5Fresetc.c b/board/BuR/common/br=5Fresetc.c
index 827ea6ba35..28fa87033f 100644
--- a/board/BuR/common/br=5Fresetc.c
+++ b/board/BuR/common/br=5Fresetc.c
@@ -113,9 +113,73 @@ int br=5Fresetc=5Fbmode(void)
 {
 	int rc =3D 0;
 	u16 regw;
+	unsigned int bmode =3D 0;
+
+	if (!resetc.i2cdev)
+		rc =3D resetc=5Finit();
+
+	if (rc !=3D 0)
+		return rc;
+
+	board=5Fboot=5Fled(1);
+
+	rc =3D br=5Fresetc=5Fbmode=5Fget(&bmode);
+	if (rc !=3D 0)
+		return rc;
+
+	LCD=5FSETCURSOR(1, 8);
+
+	switch (bmode) {
+	case BMODE=5FPME:
+		LCD=5FPUTS("entering PME-Mode (netscript).         ");
+		regw =3D 0x0C0C;
+		break;
+	case BMODE=5FDEFAULTAR:
+		LCD=5FPUTS("entering BOOT-mode.                    ");
+		regw =3D 0x0000;
+		break;
+	case BMODE=5FDIAG:
+		LCD=5FPUTS("entering DIAGNOSE-mode.                ");
+		regw =3D 0x0F0F;
+		break;
+	case BMODE=5FSERVICE:
+		LCD=5FPUTS("entering SERVICE mode.                 ");
+		regw =3D 0xB4B4;
+		break;
+	case BMODE=5FRUN:
+		LCD=5FPUTS("loading OS...                          ");
+		regw =3D 0x0404;
+		break;
+	}
+
+	board=5Fboot=5Fled(0);
+
+	if (resetc.is=5Fpsoc)
+		rc =3D dm=5Fi2c=5Fwrite(resetc.i2cdev, RSTCTRL=5FSCRATCHREG0,
+				  (u8 *)&regw, 2);
+	else
+		rc =3D dm=5Fi2c=5Fwrite(resetc.i2cdev, RSTCTRL=5FSCRATCHREG0,
+				  (u8 *)&regw, 1);
+
+	if (rc !=3D 0)
+		printf("WARN: cannot write into resetcontroller!\n");
+
+	if (resetc.is=5Fpsoc)
+		printf("Reset: PSOC controller\n");
+	else
+		printf("Reset: STM32 controller\n");
+
+	printf("Mode:  %s\n", bootmodeascii[regw & 0x0F]);
+	env=5Fset=5Fulong("b=5Fmode", regw & 0x0F);
+
+	return rc;
+}
+
+int br=5Fresetc=5Fbmode=5Fget(unsigned int *bmode)
+{
+	int rc =3D 0;
 	u8 regb, scr;
 	int cnt;
-	unsigned int bmode =3D 0;
=20
 	if (!resetc.i2cdev)
 		rc =3D resetc=5Finit();
@@ -135,13 +199,11 @@ int br=5Fresetc=5Fbmode(void)
 		return -1;
 	}
=20
-	board=5Fboot=5Fled(1);
-
 	/* special bootmode from resetcontroller */
 	if (regb & 0x4) {
-		bmode =3D BMODE=5FDIAG;
+		*bmode =3D BMODE=5FDIAG;
 	} else if (regb & 0x8) {
-		bmode =3D BMODE=5FDEFAULTAR;
+		*bmode =3D BMODE=5FDEFAULTAR;
 	} else if (board=5Fboot=5Fkey() !=3D 0) {
 		cnt =3D 4;
 		do {
@@ -168,68 +230,23 @@ int br=5Fresetc=5Fbmode(void)
=20
 		switch (cnt) {
 		case 0:
-			bmode =3D BMODE=5FPME;
+			*bmode =3D BMODE=5FPME;
 			break;
 		case 1:
-			bmode =3D BMODE=5FDEFAULTAR;
+			*bmode =3D BMODE=5FDEFAULTAR;
 			break;
 		case 2:
-			bmode =3D BMODE=5FDIAG;
+			*bmode =3D BMODE=5FDIAG;
 			break;
 		case 3:
-			bmode =3D BMODE=5FSERVICE;
+			*bmode =3D BMODE=5FSERVICE;
 			break;
 		}
 	} else if ((regb & 0x1) || scr =3D=3D 0xCC) {
-		bmode =3D BMODE=5FPME;
+		*bmode =3D BMODE=5FPME;
 	} else {
-		bmode =3D BMODE=5FRUN;
+		*bmode =3D BMODE=5FRUN;
 	}
=20
-	LCD=5FSETCURSOR(1, 8);
-
-	switch (bmode) {
-	case BMODE=5FPME:
-		LCD=5FPUTS("entering PME-Mode (netscript).         ");
-		regw =3D 0x0C0C;
-		break;
-	case BMODE=5FDEFAULTAR:
-		LCD=5FPUTS("entering BOOT-mode.                    ");
-		regw =3D 0x0000;
-		break;
-	case BMODE=5FDIAG:
-		LCD=5FPUTS("entering DIAGNOSE-mode.                ");
-		regw =3D 0x0F0F;
-		break;
-	case BMODE=5FSERVICE:
-		LCD=5FPUTS("entering SERVICE mode.                 ");
-		regw =3D 0xB4B4;
-		break;
-	case BMODE=5FRUN:
-		LCD=5FPUTS("loading OS...                          ");
-		regw =3D 0x0404;
-		break;
-	}
-
-	board=5Fboot=5Fled(0);
-
-	if (resetc.is=5Fpsoc)
-		rc =3D dm=5Fi2c=5Fwrite(resetc.i2cdev, RSTCTRL=5FSCRATCHREG0,
-				  (u8 *)&regw, 2);
-	else
-		rc =3D dm=5Fi2c=5Fwrite(resetc.i2cdev, RSTCTRL=5FSCRATCHREG0,
-				  (u8 *)&regw, 1);
-
-	if (rc !=3D 0)
-		printf("WARN: cannot write into resetcontroller!\n");
-
-	if (resetc.is=5Fpsoc)
-		printf("Reset: PSOC controller\n");
-	else
-		printf("Reset: STM32 controller\n");
-
-	printf("Mode:  %s\n", bootmodeascii[regw & 0x0F]);
-	env=5Fset=5Fulong("b=5Fmode", regw & 0x0F);
-
 	return rc;
 }
diff --git a/board/BuR/common/br=5Fresetc.h b/board/BuR/common/br=5Fresetc.h
index 999045b867..3bd5ac20ae 100644
--- a/board/BuR/common/br=5Fresetc.h
+++ b/board/BuR/common/br=5Fresetc.h
@@ -11,6 +11,7 @@
 int br=5Fresetc=5Fregget(u8 reg, u8 *dst);
 int br=5Fresetc=5Fregset(u8 reg, u8 val);
 int br=5Fresetc=5Fbmode(void);
+int br=5Fresetc=5Fbmode=5Fget(unsigned int *bmode);
=20
 /* reset controller register defines */
 #define RSTCTRL=5FCTRLREG		0x01
--=20
2.46.1

