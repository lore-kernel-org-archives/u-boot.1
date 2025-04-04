Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B74BC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 17:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBD482A81;
	Sat,  5 Apr 2025 19:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F114082A86; Sat,  5 Apr 2025 19:47:05 +0200 (CEST)
Received: from inet10.abb.com (inet10.abb.com [138.225.1.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE97D82A76
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 19:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet10.abb.com (8.15.2/8.14.7) with ESMTPS id 5349uFwa2087272
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 4 Apr 2025 11:56:16 +0200
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025040411561540-93721 ;
 Fri, 4 Apr 2025 11:56:15 +0200 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025040411561583-31491 ;
 Fri, 4 Apr 2025 11:56:15 +0200 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Ashok Reddy Soma" <ashok.reddy.soma@amd.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Pratyush Yadav" <p.yadav@ti.com>,
 "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Tom Rini" <trini@konsulko.com>,
 "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>,
 "Vignesh R" <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for CONFIG_SPI_FLASH_BAR
 defines
Date: Fri, 4 Apr 2025 11:56:07 +0200
Message-ID: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 04/04/2025 11:56:15 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 04/04/2025 11:56:15 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 04/04/2025 11:56:15 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 04/04/2025 11:56:16 AM,
 Serialize complete at 04/04/2025 11:56:16 AM
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

At the moment a mixture of ifdef(CONFIG=5FIS=5FENABLED) and
CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR) is used in the spi-nor framework.
This leads to misbehaviour in the SPL as there is no Kconfig option
CONFIG=5FSPL=5FSPI=5FFLASH=5FBAR. This commit standardizes the use of
CONFIG=5FSPI=5FFLASH to get SPLs that load U-Boot proper from the
SPI flash to work again.

Fixes: 9bb02f7 (mtd: spi-nor: Fix the spi=5Fnor=5Fread() when config SPI=5F=
STACKED=5FPARALLEL is enabled)
Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation=
.com>
---

 drivers/mtd/spi/spi-nor-core.c | 22 +++++++++++-----------
 include/linux/mtd/spi-nor.h    |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f352c5c0e2..a8865bbd37c 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -655,7 +655,7 @@ static struct spi=5Fnor *mtd=5Fto=5Fspi=5Fnor(struct mt=
d=5Finfo *mtd)
 	return mtd->priv;
 }
=20
-#ifndef CONFIG=5FSPI=5FFLASH=5FBAR
+#if !CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 static u8 spi=5Fnor=5Fconvert=5Fopcode(u8 opcode, const u8 table[][2], siz=
e=5Ft size)
 {
 	size=5Ft i;
@@ -739,7 +739,7 @@ static void spi=5Fnor=5Fset=5F4byte=5Fopcodes(struct sp=
i=5Fnor *nor,
 	nor->program=5Fopcode =3D spi=5Fnor=5Fconvert=5F3to4=5Fprogram(nor->progr=
am=5Fopcode);
 	nor->erase=5Fopcode =3D spi=5Fnor=5Fconvert=5F3to4=5Ferase(nor->erase=5Fo=
pcode);
 }
-#endif /* !CONFIG=5FSPI=5FFLASH=5FBAR */
+#endif /* !CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR) */
=20
 /* Enable/disable 4-byte addressing mode. */
 static int set=5F4byte(struct spi=5Fnor *nor, const struct flash=5Finfo *i=
nfo,
@@ -930,7 +930,7 @@ static int spi=5Fnor=5Ferase=5Fchip=5Fwait=5Ftill=5Frea=
dy(struct spi=5Fnor *nor, unsigned long
 	return spi=5Fnor=5Fwait=5Ftill=5Fready=5Fwith=5Ftimeout(nor, timeout);
 }
=20
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 /*
  * This "clean=5Fbar" is necessary in a situation when one was accessing
  * spi flash memory > 16 MiB by using Bank Address Register's BA24 bit.
@@ -1141,7 +1141,7 @@ static int spi=5Fnor=5Ferase(struct mtd=5Finfo *mtd, =
struct erase=5Finfo *instr)
 					nor->spi->flags &=3D ~SPI=5FXFER=5FU=5FPAGE;
 			}
 		}
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 		ret =3D write=5Fbar(nor, offset);
 		if (ret < 0)
 			goto erase=5Ferr;
@@ -1175,7 +1175,7 @@ static int spi=5Fnor=5Ferase(struct mtd=5Finfo *mtd, =
struct erase=5Finfo *instr)
=20
 	addr=5Fknown =3D false;
 erase=5Ferr:
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 	err =3D clean=5Fbar(nor);
 	if (!ret)
 		ret =3D err;
@@ -1630,7 +1630,7 @@ static int spi=5Fnor=5Fread(struct mtd=5Finfo *mtd, l=
off=5Ft from, size=5Ft len,
 				offset /=3D 2;
 		}
=20
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 		ret =3D write=5Fbar(nor, offset);
 		if (ret < 0)
 			return log=5Fret(ret);
@@ -1667,7 +1667,7 @@ static int spi=5Fnor=5Fread(struct mtd=5Finfo *mtd, l=
off=5Ft from, size=5Ft len,
 	ret =3D 0;
=20
 read=5Ferr:
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 	ret =3D clean=5Fbar(nor);
 #endif
 	return ret;
@@ -2016,7 +2016,7 @@ static int spi=5Fnor=5Fwrite(struct mtd=5Finfo *mtd, =
loff=5Ft to, size=5Ft len,
 			}
 		}
=20
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 		ret =3D write=5Fbar(nor, offset);
 		if (ret < 0)
 			return ret;
@@ -2090,7 +2090,7 @@ static int spi=5Fnor=5Fwrite(struct mtd=5Finfo *mtd, =
loff=5Ft to, size=5Ft len,
 	}
=20
 write=5Ferr:
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 	ret =3D clean=5Fbar(nor);
 #endif
 	return ret;
@@ -3791,7 +3791,7 @@ static int s25=5Fs28=5Fsetup(struct spi=5Fnor *nor, c=
onst struct flash=5Finfo *info,
 	int ret;
 	u8 cr;
=20
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 	return -ENOTSUPP; /* Bank Address Register is not supported */
 #endif
 	/*
@@ -4577,7 +4577,7 @@ int spi=5Fnor=5Fscan(struct spi=5Fnor *nor)
 	if (nor->flags & (SNOR=5FF=5FHAS=5FPARALLEL | SNOR=5FF=5FHAS=5FSTACKED))
 		shift =3D 1;
 	if (nor->addr=5Fwidth =3D=3D 3 && (mtd->size >> shift) > SZ=5F16M) {
-#ifndef CONFIG=5FSPI=5FFLASH=5FBAR
+#if !CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr=5Fwidth =3D 4;
 		if (JEDEC=5FMFR(info) =3D=3D SNOR=5FMFR=5FSPANSION ||
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b8b207f7b5c..4eef4ab0488 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -569,7 +569,7 @@ struct spi=5Fnor {
 	u8			rdsr=5Fdummy;
 	u8			rdsr=5Faddr=5Fnbytes;
 	u8			addr=5Fmode=5Fnbytes;
-#ifdef CONFIG=5FSPI=5FFLASH=5FBAR
+#if CONFIG=5FIS=5FENABLED(SPI=5FFLASH=5FBAR)
 	u8			bank=5Fread=5Fcmd;
 	u8			bank=5Fwrite=5Fcmd;
 	u8			bank=5Fcurr;
--=20
2.49.0

