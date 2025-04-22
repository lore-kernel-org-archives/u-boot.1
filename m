Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0170AC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 07:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C0581026;
	Tue, 22 Apr 2025 09:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="noslMQzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A01810E8; Tue, 22 Apr 2025 09:28:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7749980FDA
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 09:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745306903; x=1745911703; i=xypron.glpk@gmx.de;
 bh=hL67qQ5avBjNMkmcgHDTn3ymP+H23neXoqzG8eAL92E=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=noslMQzHIqY4Mggfi0TSflVdKh+H5IpGLG+tvSyQrdQ8lzASrfmKzQ45hhs770kp
 94V0prqMhzi1gd6lZQet4O5DiL7ysaLZwXmQAYuNsxBjx9kBMprsLGEzEncGMTP/D
 5JXfb/W7rVpeBfV1GhCk2Y6libwG6NCRBi7u8vGSO8UuYog6uov6qWqhYBcKXfycX
 wOux3As7X8QStkctffb41D8wsOpi4SYoxp0mSktz68R1LjfSnMt2DQVOgRvqMJ5ht
 IOfX7eQBpfirpo899wjUymRGcu3UO1CuO0mL277oOnzz4oFGwl4W1cPR9bTJN8IF6
 1XInNkGJPjaeJnaOwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1v92Nz0R68-011LIo; Tue, 22
 Apr 2025 09:28:23 +0200
Date: Tue, 22 Apr 2025 09:28:20 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/2=5D_board=3A_starfive=3A_?=
 =?US-ASCII?Q?visionfive2=3A_Drop_setting_of_=24fdtfile?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250422064541.635210-3-e@freeshell.de>
References: <20250422064541.635210-1-e@freeshell.de>
 <20250422064541.635210-3-e@freeshell.de>
Message-ID: <7C8FD49C-EDAD-45C5-8800-104D9CAAB372@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZqlO66jOxXLzIZp5SaVcIWWp1XKR6bprMgjdh+fbJvpJwQdjTp
 8oVrI5vD1Ac0zRtSiASoZzM+fMOB1YmiSmDXSl2T8u/5s2VwaReTPQ6OsJk66eRCdI+JcFN
 fHsOCOSNGrnM+BBwzFkOW3NsSbGieKJxKhdRac1wqsmUWYwD9dZ7Ij+7nKaWJGoOJI7GKdN
 jjUKAse/CBKhoWJq4bLbQ==
UI-OutboundReport: notjunk:1;M01:P0:Fk7WKmJi6FM=;FzNLb17GV/wGdtHgP9nM35S+R24
 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
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

Am 22=2E April 2025 08:45:26 MESZ schrieb E Shattow <e@freeshell=2Ede>:
>Remove board detection logic from main payload that is duplicated from SP=
L
>and do not set convenience data into $fdtfile environment variable=2E U-B=
oot
>"starfive visionfive2" board target(s) now boot on recent upstream Linux
>Kernel releases without this manipulation since the JH7110 OF_UPSTREAM
>migration=2E Changes to $fdtfile by users (i=2Ee=2E following newer or ol=
der Linux
>Kernel releases) should follow the advice in general U-Boot documentation=
=2E

We cannot expect that users have a U-Boot installed in SPI flash that matc=
hes the Linux they intend to boot=2E

Linux is known to break device-tree compatibility between versions=2E

Without U-Boot providing a value of $fdtfile that matches the board, U-Boo=
t will not pick up the device-tree on the ESP of Ubuntu's installer image w=
hich matches the kernel version=2E

Please, keep U-Boot providing a value of $fdtfile that matches the actual =
board=2E

It would be preferable if that name could be based on the choice of the co=
nfiguration by SPL instead of duplicating the logic=2E But I am not aware o=
f logic that provides the configuration name to main U-Boot=2E Maybe we sho=
uld simply match the model or conpatible string=2E

Best regards

Heinrich=20

>
>Signed-off-by: E Shattow <e@freeshell=2Ede>
>---
> =2E=2E=2E/visionfive2/starfive_visionfive2=2Ec        | 61 -------------=
------
> 1 file changed, 61 deletions(-)
>
>diff --git a/board/starfive/visionfive2/starfive_visionfive2=2Ec b/board/=
starfive/visionfive2/starfive_visionfive2=2Ec
>index b8cd509bc89=2E=2E039a32f1874 100644
>--- a/board/starfive/visionfive2/starfive_visionfive2=2Ec
>+++ b/board/starfive/visionfive2/starfive_visionfive2=2Ec
>@@ -17,14 +17,6 @@
> DECLARE_GLOBAL_DATA_PTR;
> #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
> #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
>-#define FDTFILE_MILK_V_MARS \
>-	"starfive/jh7110-milkv-mars=2Edtb"
>-#define FDTFILE_VISIONFIVE2_1_2A \
>-	"starfive/jh7110-starfive-visionfive-2-v1=2E2a=2Edtb"
>-#define FDTFILE_VISIONFIVE2_1_3B \
>-	"starfive/jh7110-starfive-visionfive-2-v1=2E3b=2Edtb"
>-#define FDTFILE_PINE64_STAR64 \
>-	"starfive/jh7110-pine64-star64=2Edtb"
>=20
> /* enable U74-mc hart1~hart4 prefetcher */
> static void enable_prefetcher(void)
>@@ -45,51 +37,6 @@ static void enable_prefetcher(void)
> 	}
> }
>=20
>-/**
>- * set_fdtfile() - set the $fdtfile variable based on the board revision
>- */
>-static void set_fdtfile(void)
>-{
>-	u8 version;
>-	const char *fdtfile;
>-	const char *product_id;
>-
>-	fdtfile =3D env_get("fdtfile");
>-	if (fdtfile)
>-		return;
>-
>-	product_id =3D get_product_id_from_eeprom();
>-	if (!product_id) {
>-		log_err("Can't read EEPROM\n");
>-		return;
>-	}
>-	if (!strncmp(product_id, "MARS", 4)) {
>-		fdtfile =3D FDTFILE_MILK_V_MARS;
>-	} else if (!strncmp(product_id, "VF7110", 6)) {
>-		version =3D get_pcb_revision_from_eeprom();
>-
>-		switch (version) {
>-		case 'a':
>-		case 'A':
>-			fdtfile =3D FDTFILE_VISIONFIVE2_1_2A;
>-			break;
>-
>-		case 'b':
>-		case 'B':
>-		default:
>-			fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
>-			break;
>-		}
>-	} else if (!strncmp(product_id, "STAR64", 6)) {
>-		fdtfile =3D FDTFILE_PINE64_STAR64;
>-	} else {
>-		log_err("Unknown product\n");
>-		return;
>-	}
>-
>-	env_set("fdtfile", fdtfile);
>-}
>-
> int board_init(void)
> {
> 	enable_caches();
>@@ -98,14 +45,6 @@ int board_init(void)
> 	return 0;
> }
>=20
>-int board_late_init(void)
>-{
>-	if (CONFIG_IS_ENABLED(ID_EEPROM))
>-		set_fdtfile();
>-
>-	return 0;
>-}
>-
> int board_fdt_blob_setup(void **fdtp)
> {
> 	if (gd->arch=2Efirmware_fdt_addr) {

