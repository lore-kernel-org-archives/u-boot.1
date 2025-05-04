Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FF0C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 09:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EBF88210D;
	Sun,  4 May 2025 11:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="csQztUKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6BF8219D; Sun,  4 May 2025 11:16:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C743480F6B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 11:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746350171; x=1746954971; i=xypron.glpk@gmx.de;
 bh=9q4VBHa8KU4IVxT02CSj+3wmv7eALS7lvwoh4x0Le78=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=csQztUKU5ltr3ojjZ3QMKpmwUOFLaZa0SITBMOQizpAedN20XWrq9wLCo4NRRw+7
 fJZfH6lO/eiRlZ8Ac45rCoU8R6TvVKv+F587I0mGcPNqfgjBTomsJkJfmkKF/hs0u
 x0XD1ZQTuXOvmoA+/A9/c7zW0CI2oYRgM9TvFKuuuwqe3P0L+bREveaLDh/7QsbMC
 14MklQW1pFJmugAHhK2PtqVZvdBoei802z7UWI4Xbetj26rY+XxeguL/IpgrWEc1T
 nhAuUOprwxZd+ySJ5syNJRlMiDdo1gYSW2MTyAoPQEXlQsBvrL6Po5us8wG3jQejC
 ELK55Vkyc8LUvlRKgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.109.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1usEnu0gOj-00lsu2; Sun, 04
 May 2025 11:16:11 +0200
Date: Sun, 04 May 2025 11:16:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?ISO-8859-1?Q?Fran=E7ois_Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Xu Zhang <423756212@qq.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_10/22=5D_passage=3A_arm=3A_Ac?=
 =?US-ASCII?Q?cept_a_passage_from_the_previous_phase?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
Message-ID: <30F80A76-8600-4747-A277-83A3D997BDA8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vHyQh5l45TNAU+2LJw79E+3hy80ixVq0ridms0Ql5/rL06qXE1V
 DdAbEqXAYv0BC2on6vF6e21TTmUoeTtAD4zHBJp1L/TEI8H/RYMCNBuyjxsM/rKbUqtS78K
 VflnUrPqyqSuWZrpN7Xs3FvMVPQEsZK0qTsyRgshyBc+NBFfuafeaWyaS+7n2MpU2KsMn/8
 J8ycuqPVlkSo1V6lEkuWA==
UI-OutboundReport: notjunk:1;M01:P0:8n4mN+Xp4mM=;1FdAhDOLicCT4ZtT0Lb1VV666dD
 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
 sVueUfl8ci/I9bAqqbjrhlGcnlxj1rljqh
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

Am 17=2E April 2025 20:15:52 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Accept a bloblist and control devicetree from a previous phase in
>registers 0 to 3, as documented in the Firmware Handoff
>specification[1]=2E
>
>[1] https://firmwarehandoff=2Egithub=2Eio/firmware_handoff/main/index=2Eh=
tml

Creating an interface that is only defined on a single architecture seems =
not to fit into today's world=2E One would expect a specification team to r=
each out to other architectures=2E

Please, adjust the wording of this patch to match the specification which =
speaks of a transfer list and not of a blob list=2E

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v3:
>- Add support for aarch64 also
>- Update registers to match the Firmware Handoff protocol
>
>Changes in v2:
>- Use three registers instead of two for the entry
>
> arch/arm/cpu/armv7/start=2ES | 10 +++++++++-
> arch/arm/cpu/armv8/start=2ES | 12 ++++++++++++
> arch/arm/lib/crt0=2ES        |  6 ++++++
> arch/arm/lib/crt0_64=2ES     |  6 ++++++
> 4 files changed, 33 insertions(+), 1 deletion(-)
>
>diff --git a/arch/arm/cpu/armv7/start=2ES b/arch/arm/cpu/armv7/start=2ES
>index 959251957de=2E=2E81cb20987ad 100644
>--- a/arch/arm/cpu/armv7/start=2ES
>+++ b/arch/arm/cpu/armv7/start=2ES
>@@ -40,6 +40,14 @@ reset:
> 	/* Allow the board to save important registers */
> 	b	save_boot_params
> save_boot_params_ret:
>+#if CONFIG_IS_ENABLED(PASSAGE_IN)
>+	# Keep passage information in case it is provided
>+	cmp	r0, #0
>+	moveq	r6, r1		/* mach */
>+	moveq	r7, r2		/* dtb */
>+	moveq	r8, r3		/* bloblist */
>+	movne	r6, #0
>+#endif
> #ifdef CONFIG_POSITION_INDEPENDENT
> 	/*
> 	 * Fix =2Erela=2Edyn relocations=2E This allows U-Boot to loaded to and
>@@ -123,7 +131,7 @@ switch_to_hypervisor_ret:
> 	bl	cpu_init_crit
> #endif
> #endif
>-
>+	# Note: r6-r8 are available to _main in case standard passage is used
> 	bl	_main
>=20
> /*----------------------------------------------------------------------=
--------*/
>diff --git a/arch/arm/cpu/armv8/start=2ES b/arch/arm/cpu/armv8/start=2ES
>index 829a620faeb=2E=2E75d2fd1e271 100644
>--- a/arch/arm/cpu/armv8/start=2ES
>+++ b/arch/arm/cpu/armv8/start=2ES
>@@ -57,6 +57,18 @@ reset:
> 	b	save_boot_params
> =2Eglobl	save_boot_params_ret
> save_boot_params_ret:
>+#if CONFIG_IS_ENABLED(PASSAGE_IN)
>+	# Keep passage information in case it is provided
>+	cmp	x2, #0
>+	bne	no_passage
>+	mov	x19, x1		/* mach */
>+	mov	x20, x0		/* dtb */
>+	mov	x21, x3		/* bloblist */
>+	b	passage_done
>+no_passage:
>+	mov	x19, #0
>+passage_done:
>+#endif
>=20
> #if CONFIG_POSITION_INDEPENDENT && !defined(CONFIG_XPL_BUILD)
> 	/* Verify that we're 4K aligned=2E  */
>diff --git a/arch/arm/lib/crt0=2ES b/arch/arm/lib/crt0=2ES
>index a50dde60e8b=2E=2Eab758ca900f 100644
>--- a/arch/arm/lib/crt0=2ES
>+++ b/arch/arm/lib/crt0=2ES
>@@ -113,6 +113,12 @@ ENTRY(_main)
> 	mov	r9, r0
> 	bl	board_init_f_init_reserve
>=20
>+#if CONFIG_IS_ENABLED(PASSAGE_IN)
>+	str	r6, [r9, #GD_PASSAGE_MACH]
>+	str	r7, [r9, #GD_PASSAGE_DTB]
>+	str	r8, [r9, #GD_PASSAGE_BLOBLIST]
>+#endif
>+
> #if defined(CONFIG_DEBUG_UART) && CONFIG_IS_ENABLED(SERIAL)
> 	bl	debug_uart_init
> #endif
>diff --git a/arch/arm/lib/crt0_64=2ES b/arch/arm/lib/crt0_64=2ES
>index 30950ddaf9b=2E=2E498fe849f50 100644
>--- a/arch/arm/lib/crt0_64=2ES
>+++ b/arch/arm/lib/crt0_64=2ES
>@@ -94,6 +94,12 @@ ENTRY(_main)
> 	bl	debug_uart_init
> #endif
>=20
>+#if CONFIG_IS_ENABLED(PASSAGE_IN)
>+	str	x19, [x18, #GD_PASSAGE_MACH]
>+	str	x20, [x18, #GD_PASSAGE_DTB]
>+	str	x21, [x18, #GD_PASSAGE_BLOBLIST]
>+#endif
>+
> 	mov	x0, #0
> 	bl	board_init_f
>=20

