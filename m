Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7803CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8D78442A;
	Thu, 27 Nov 2025 17:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XAKGVzwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF08484409; Thu, 27 Nov 2025 16:50:32 +0100 (CET)
Received: from mx-relay168-hz1.antispameurope.com
 (mx-relay168-hz1.antispameurope.com [94.100.132.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6796839DD
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0419b688bb=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate168-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=E3PY/9HNDAqh68W2X+X8zlY88SiMeHTkfdMPQ4QYm58=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764258630;
 b=ekXupFPih/Ho7I5VC7sr6gDI7n80hHj6nDuj+dBNYk/EAvMgvryCMXtLfK1m2bY7wg6xARzC
 g4CWkP1okGF3mjVnpz3k/8sieQRVhecl/DCauLeWd7VqDKuyb09yCY5hXngJHLEtULIR+q1bYBa
 lUfnsiu7lVY9iFPMlmw4UA2DwTNlVy8ONA5uASm3nutXMaKO8eEXnsz6GS6q9u0UcvZMiCF9Cgu
 zj23xqX3YuJXAmvxcany0nBgVrqSpFbuRNkv4pmLSm7W/qnRK73LGaJ4I5+0AgUCnUVcoxj2ddg
 3Qmw1l5Y+9spVbPlzJ/94s7Roo5TQd3cjT62QV1dD1edg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764258630;
 b=OYOwH4fQIgpwCtpIR6fkL3Du9CPk9PIH+M38246awYVl6EuiMuzkzvYaycBSYApNQTHdzwyM
 vkMvaetYhn4oNBeo2dX/QhWz/HmxsW28nEyDH6JrFqbSvmnXxUBEbpWTEx/ROG/mPsAFzNyAYO/
 V8ce6Yuxc3nJCQEDnHszo4NiQPdCAgt2Fa2X/4ZyTDt224ZGc/pzar5Rd8l4iioMSQJE/4Pnexk
 PiAhFb0tLZgAtvoCK21Ju4ehCNGWv3KKTjKYyr+0oQOK4Ew/c5uEeRhd4UDzNEKmaVltZEuV/Xe
 Uhat4mUolyZ2ffLqouaxPkV9zpVtXivMu56kUmxbiKjTg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay168-hz1.antispameurope.com; Thu, 27 Nov 2025 16:50:29 +0100
Received: from he-web01-hz1.hornetsecurity.com (unknown [10.1.31.91])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id E78E15A103D;
 Thu, 27 Nov 2025 16:50:19 +0100 (CET)
From: =?utf-8?q?alexander=2Efeilke=40ew=2Etq-group=2Ecom?=
 <alexander.feilke@ew.tq-group.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date: Thu, 27 Nov 2025 16:50:19 +0100
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
To: "Fabio Estevam" <festevam@gmail.com>
MIME-Version: 1.0
Message-ID: <302c38-69287300-35-2a0bce00@4807151>
Subject: =?utf-8?q?Re=3A?= [BUG] silent hangup when debugging 
 =?utf-8?q?lib/fdtdec=2Ec?=
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay168-hz1.antispameurope.com with 4dHLVN16vCzYcsB
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 45e14b6c17c12266d6bb84f7662ac0b1
X-cloud-security: scantime:2.169
DKIM-Signature: a=rsa-sha256;
 bh=E3PY/9HNDAqh68W2X+X8zlY88SiMeHTkfdMPQ4QYm58=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764258629; v=1;
 b=XAKGVzwy1et4lm9lnICKibGBuT3EnViFUHmD44d9k1aQ4CjAoCvSykLY68btOhwoyOIPN5Ez
 ZBqpIeS3OILajqwlNUzJXnG+ovuRk0vx+m6ypOJZulVt6pMF7dCeW0a5DGCswm23VyHRHJgSKgm
 GEjNOm8TidBx6DFg4jZ95PhoROwnHshNkyxVTm0y2vkYXmmMzRMqa46iB3HJ3cfd7fZT5zfsHqA
 RMUPAHSnpC8uogIkBAtxpwHueiXfnTiL0qVKH+E4+hN+GJdlzuaQdnAW6/qh/uWWkKViWPgQv5V
 ti3nYKi72QL4/sSKS0NCldHUHQzhHVE0o0MM6djy4WaMA==
X-Mailman-Approved-At: Thu, 27 Nov 2025 17:04:13 +0100
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

On Thursday, November 27, 2025 15:02 CET, Fabio Estevam <festevam@gmail=
.com> wrote:
> On Thu, Nov 27, 2025 at 9:33=E2=80=AFAM alexander.feilke@ew.tq-group.=
com
> <alexander.feilke@ew.tq-group.com> wrote:
>=20
> > I also have a mx7dsabresd but I cannot bring it to boot with a mast=
er build unfortunately.
>=20
> Just tested booting the top-of-tree U-Boot on a mx7dsabresd and it bo=
ots:
>=20

Thanks! When using 0ae3dc6809ff like you I can boot and reproduce the h=
angup issue on mx7dsabresd:

<debug=5Fuart>
FDT 8787da38 gd 0091de20
top 87887538 sp 87800000
sys=5Finit=5Fsp=5Faddr 0091ff10
gbl=5Fdata=5Fsize 000000f0
FDT overlap
resetting ...
System reset not supported on this platform
### ERROR ### Please RESET the board ###

This is the patch that enables debug uart and demonstrates the issue:

From 9ee6e3244f15c8a1d9cb86130186cc9f221721c6 Mon Sep 17 00:00:00 2001
From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Date: Thu, 27 Nov 2025 16:47:23 +0100

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/freescale/mx7dsabresd/mx7dsabresd.c | 6 ++++++
 configs/mx7dsabresd=5Fdefconfig             | 5 +++++
 lib/fdtdec.c                              | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/board/freescale/mx7dsabresd/mx7dsabresd.c b/board/freescal=
e/mx7dsabresd/mx7dsabresd.c
index bef4f901ff7..1fdd39d437c 100644
--- a/board/freescale/mx7dsabresd/mx7dsabresd.c
+++ b/board/freescale/mx7dsabresd/mx7dsabresd.c
@@ -25,6 +25,7 @@
 #include <i2c.h>
 #include <asm/mach-imx/mxc=5Fi2c.h>
 #include <asm/arch/crm=5Fregs.h>
+#include <linux/delay.h>
=20
 DECLARE=5FGLOBAL=5FDATA=5FPTR;
=20
@@ -233,6 +234,11 @@ int board=5Fearly=5Finit=5Ff(void)
 	return 0;
 }
=20
+void board=5Fdebug=5Fuart=5Finit(void)
+{
+	setup=5Fiomux=5Fuart();
+}
+
 int board=5Finit(void)
 {
 	/* address of boot parameters */
diff --git a/configs/mx7dsabresd=5Fdefconfig b/configs/mx7dsabresd=5Fde=
fconfig
index a5a562af0c0..9f0631fe868 100644
--- a/configs/mx7dsabresd=5Fdefconfig
+++ b/configs/mx7dsabresd=5Fdefconfig
@@ -10,6 +10,11 @@ CONFIG=5FTARGET=5FMX7DSABRESD=3Dy
 # CONFIG=5FARMV7=5FVIRT is not set
 CONFIG=5FIMX=5FRDC=3Dy
 CONFIG=5FIMX=5FBOOTAUX=3Dy
+CONFIG=5FDEBUG=5FUART=5FBASE=3D0x30860000
+CONFIG=5FDEBUG=5FUART=5FCLOCK=3D24000000
+CONFIG=5FDEBUG=5FUART=3Dy
+CONFIG=5FDEBUG=5FUART=5FANNOUNCE=3Dy
+CONFIG=5FDEBUG=5FUART=5FBOARD=5FINIT=3Dy
 CONFIG=5FIMX=5FHAB=3Dy
 CONFIG=5FSYS=5FMEMTEST=5FSTART=3D0x80000000
 CONFIG=5FSYS=5FMEMTEST=5FEND=3D0xa0000000
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..dff471228d6 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -9,6 +9,7 @@
 #ifndef USE=5FHOSTCC
=20
 #define LOG=5FCATEGORY	LOGC=5FDT
+#define DEBUG
=20
 #include <bloblist.h>
 #include <boot=5Ffit.h>
@@ -35,6 +36,7 @@
 #include <linux/ctype.h>
 #include <linux/lzo.h>
 #include <linux/ioport.h>
+#include <system-constants.h>
=20
 DECLARE=5FGLOBAL=5FDATA=5FPTR;
=20
@@ -1276,6 +1278,9 @@ static void *fdt=5Ffind=5Fseparate(void)
 		 */
 		if (top > (void *)gd || top > (void *)&stack=5Fptr) {
 			printf("FDT %p gd %p\n", fdt=5Fblob, gd);
+			printf("top %p sp %p\n", top, stack=5Fptr);
+			printf("sys=5Finit=5Fsp=5Faddr %p\n", SYS=5FINIT=5FSP=5FADDR);
+			printf("gbl=5Fdata=5Fsize %p\n", GENERATED=5FGBL=5FDATA=5FSIZE);
 			panic("FDT overlap");
 		}
 	}
--=20
2.34.1

