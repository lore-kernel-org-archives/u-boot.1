Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB3F33809
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6361484114;
	Tue, 17 Mar 2026 08:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PvoN2g5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844AC84118; Tue, 17 Mar 2026 08:46:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A55684105
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773733600; x=1774338400; i=xypron.glpk@gmx.de;
 bh=u/wOno3neA6sxo+SNjE6yv0BijVhTQCc4qtxB760EJM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PvoN2g5IH/611pzVSUVi1RADGqiQz8fkY++S4j4dY/ml+on1nFy92FhAM6Uk34na
 NWHdtHvd79MFeAkLUpj/FcugvAfkGNwnY5GRhjgJq1wNbtUlXBt8wMLNPSRIuQreS
 ArX/HAoqQXV2NxPzwhiv3b5vZUB2Z0aSxOCqxOvBPm2p+XUTJ2htYDQ9L1QC9hKBW
 XPvR5Fj/gLmg/DhAeahS2rOgZy+1nb+EbInmv6ZZ2hqHzywHOKWijqunQjXo5YJiu
 D2KvojbPOw+sfMk+eykcrzdGM/SGNfj8YLYbS8H3oZQirw8WFyoNv8Tv0C8GjYvqt
 j4g5epaOo4JTTSSWgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1vNriF3NQC-00piXM; Tue, 17
 Mar 2026 08:46:39 +0100
Date: Tue, 17 Mar 2026 08:46:37 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
User-Agent: Thunderbird for Android
In-Reply-To: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
Message-ID: <6AD955F3-6535-41DC-9F1F-B8FD663E7BEC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bgpQgSdXencwCjwdVaWZNist2SRspKsvOUelJYbq/DpqBkWyMt
 W5cXoCVuveBjgHs0uQwBMt3hefSddjq8kwjS45MQaxVI4eNEAAxTRaqUYubDJgvhVY3QxmW
 ERQ09ocYXdvTp0GXWDFQ3MtrWAaheksnY5MqBx3pH28Ra4AiymtcsU3+Q1d91JURkRFI6SW
 iwqBLq2wIovCLcndNikQg==
UI-OutboundReport: notjunk:1;M01:P0:o0H7tcgPHB8=;j+m/ljHKd8lXQCRklguP92ufJnD
 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
 o6LYM9ZJxRO
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

Am 16=2E M=C3=A4rz 2026 00:54:05 MEZ schrieb Marek Vasut <marek=2Evasut+ren=
esas@mailbox=2Eorg>:
>Introduce new mode of relocation which relocates only data, not code=2E
>This is mainly meant to relocate data to read-write portion of the RAM,
>while the code remains in read-only portion of the RAM from which it is
>allowed to execute=2E This split configuration is present on various secu=
re
>cores=2E

Ilias has been working on supporting RX and RW memory areas via the MMU=2E=
 Isn't this compatible with code relocation?

Best regards

Heinrich


>
>The result of the relocation is U-Boot running at its original address,
>data relocated to the end of DRAM, but with added read-write area offset=
=2E
>The U-Boot binary area is not reserved from the end of the DRAM in this
>relocation mode, because U-Boot itself is not relocated=2E
>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>---
>Cc: Casey Connolly <casey=2Econnolly@linaro=2Eorg>
>Cc: Heiko Schocher <hs@nabladev=2Ecom>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Jerome Forissier <jerome=2Eforissier@arm=2Ecom> <jerome@forissier=2Eo=
rg>
>Cc: Jesse Taube <mr=2Ebossman075@gmail=2Ecom>
>Cc: Peng Fan <peng=2Efan@nxp=2Ecom>
>Cc: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: Udit Kumar <u-kumar1@ti=2Ecom>
>Cc: u-boot@lists=2Edenx=2Ede
>---
> Kconfig                 | 17 +++++++++++++++++
> arch/arm/lib/crt0=2ES     |  4 ++++
> arch/arm/lib/relocate=2ES | 25 +++++++++++++++++++++++++
> common/board_f=2Ec        |  2 +-
> 4 files changed, 47 insertions(+), 1 deletion(-)
>
>diff --git a/Kconfig b/Kconfig
>index ce25ea24a60=2E=2E575ee3b574f 100644
>--- a/Kconfig
>+++ b/Kconfig
>@@ -474,6 +474,23 @@ config SKIP_RELOCATE
> 	  Skips relocation of U-Boot allowing for systems that have extremely
> 	  limited RAM to run U-Boot=2E
>=20
>+config SKIP_RELOCATE_CODE
>+	bool "Skips relocation of U-Boot code to end of RAM"
>+	help
>+	  Skips relocation of U-Boot code to the end of RAM, but still does
>+	  relocate data to the end of RAM=2E This is mainly meant to relocate
>+	  data to read-write portion of the RAM, while the code remains in
>+	  read-only portion of the RAM from which it is allowed to execute=2E
>+	  This split configuration is present on various secure cores=2E
>+
>+config SKIP_RELOCATE_CODE_DATA_OFFSET
>+	hex "Offset of read-write data memory from read-only text memory"
>+	default 0x0
>+	depends on SKIP_RELOCATE_CODE
>+	help
>+	  Offset of the read-write memory which contains data, from read-only
>+	  memory which contains executable text=2E
>+
> endif # EXPERT
>=20
> config PHYS_64BIT
>diff --git a/arch/arm/lib/crt0=2ES b/arch/arm/lib/crt0=2ES
>index d10c129705d=2E=2Ef2c5aa37a8f 100644
>--- a/arch/arm/lib/crt0=2ES
>+++ b/arch/arm/lib/crt0=2ES
>@@ -157,7 +157,11 @@ ENTRY(_main)
> 	orr	lr, #1				/* As required by Thumb-only */
> #endif
> 	ldr	r0, [r9, #GD_RELOCADDR]		/* r0 =3D gd->relocaddr */
>+#if defined(CONFIG_SKIP_RELOCATE_CODE)
>+	bl	relocate_code
>+#else
> 	b	relocate_code
>+#endif
> here:
> /*
>  * now relocate vectors
>diff --git a/arch/arm/lib/relocate=2ES b/arch/arm/lib/relocate=2ES
>index 6ee58f4edfe=2E=2Eb6a648708f4 100644
>--- a/arch/arm/lib/relocate=2ES
>+++ b/arch/arm/lib/relocate=2ES
>@@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
> ENTRY(relocate_code)
> relocate_base:
> 	adr	r3, relocate_base
>+
>+#ifdef CONFIG_SKIP_RELOCATE_CODE
>+	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
>+
>+	ldr	r1, _data_start_ofs
>+	add	r5, r1, r3		/* r5 <- Run &__data_start */
>+	ldr	r1, _data_end_ofs
>+	add	r6, r1, r3		/* r6 <- Run &__data_end */
>+#else
> 	ldr	r1, _image_copy_start_ofs
> 	add	r1, r3			/* r1 <- Run &__image_copy_start */
> 	subs	r4, r0, r1		/* r4 <- Run to copy offset      */
>@@ -90,6 +99,7 @@ copy_loop:
> 	stmia	r0!, {r10-r11}		/* copy to   target address [r0] */
> 	cmp	r1, r2			/* until source end address [r2] */
> 	blo	copy_loop
>+#endif
>=20
> 	/*
> 	 * fix =2Erel=2Edyn relocations
>@@ -107,6 +117,15 @@ fixloop:
> 	/* relative fix: increase location by offset */
> 	add	r0, r0, r4
> 	ldr	r1, [r0]
>+
>+#ifdef CONFIG_SKIP_RELOCATE_CODE
>+	/* Test whether this is data, if not, do not relocate=2E */
>+	cmp	r1, r5
>+	blt	fixnext
>+	cmp	r1, r6
>+	bgt	fixnext
>+#endif
>+
> 	add	r1, r1, r4
> 	str	r1, [r0]
> fixnext:
>@@ -126,3 +145,9 @@ _rel_dyn_start_ofs:
> 	=2Eword	__rel_dyn_start - relocate_code
> _rel_dyn_end_ofs:
> 	=2Eword	__rel_dyn_end - relocate_code
>+#ifdef CONFIG_SKIP_RELOCATE_CODE
>+_data_start_ofs:
>+	=2Eword	__data_start - relocate_code
>+_data_end_ofs:
>+	=2Eword	__data_end - relocate_code
>+#endif
>diff --git a/common/board_f=2Ec b/common/board_f=2Ec
>index df2b0dc899b=2E=2Ebd45669aef5 100644
>--- a/common/board_f=2Ec
>+++ b/common/board_f=2Ec
>@@ -463,7 +463,7 @@ static int reserve_uboot(void)
> 	if (CONFIG_IS_ENABLED(SKIP_RELOCATE))
> 		gd->flags |=3D GD_FLG_SKIP_RELOC;
>=20
>-	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
>+	if (!(gd->flags & GD_FLG_SKIP_RELOC) && !CONFIG_IS_ENABLED(SKIP_RELOCAT=
E_CODE)) {
> 		/*
> 		 * reserve memory for U-Boot code, data & bss
> 		 * round down to next 4 kB limit

