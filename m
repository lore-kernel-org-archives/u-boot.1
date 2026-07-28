Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB06C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58D2607DD;
	Wed, 29 Jul 2026 04:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYWqBc1VSm4o; Wed, 29 Jul 2026 04:55:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1860E607CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300925;
	bh=bmCsf2XT749uJjUPoP0WkOKtoony8G8QRrdlfUTy4gg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLZ1/T151gWrs9h0uBNdY3hKAuaW1u3uajBB8AN9j8sNRv0kCtfE4ia2mULC1ie9A
	 XHBrLvL60P0GIA6RwpiCvaccpp27nnDfEvJSX6l+qCb3SOpw730JHGsWnRJRQSfG/E
	 RLtxf1T8O+YaW886+xJJ4StGVBXejWgUdhvuhfNMIcFNB3CmVvYbzr9Nx/ZoqFQz/7
	 OgmJvTIvGoqM0W1H6Vtvv9a8zjmC2E7y3mn98YnXgl04xFoumOhlZBgryR+pFVe6tS
	 K0nMLGfU5sl6YIY+TDmfUx+9oBcnTvELy9ITe7/2aFGsG3dKGHVyy333fK0z01mK2s
	 BNsg5scvybI/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1860E607CF;
	Wed, 29 Jul 2026 04:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19CA145B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 173084008D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Og2vbSe5Toid for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:22:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1CCD40029
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1CCD40029
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1CCD40029
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:22:43 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1x3y0o01yy-012ctu; Tue, 28
 Jul 2026 19:22:26 +0200
Date: Tue, 28 Jul 2026 19:22:18 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
CC: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Daniel Golle <daniel@makrotopia.org>,
 Dillon Min <dillon.minfei@gmail.com>, E Shattow <e@freeshell.de>,
 Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/2] doc: Switch from printenv to env print
User-Agent: Thunderbird for Android
In-Reply-To: <20260728133337.15916-2-marek.vasut+renesas@mailbox.org>
References: <20260728133337.15916-1-marek.vasut+renesas@mailbox.org>
 <20260728133337.15916-2-marek.vasut+renesas@mailbox.org>
Message-ID: <2C16005F-7F2A-4892-83CD-6EABDA3A53ED@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7jDNUQ/F2eXPVz8HGr+6ac5a4uyUpvU+J8p35ahiKB8rhpK9Tf4
 EHcJPwJBafx8tlfxVFNXvXfceJ/HKZ/d/f2wyDh9vBqJG9xB8xnJZcTBXhzAn7hWB9Z7F77
 dGFA27KBvJB4wcJPK+bKM+4LYVQcx1hCe/qKyTQ1x+LrE4muY3n4jA4tIJu++omzxCkGrqq
 tSG/TRmPUm7pv0qQiPa0g==
UI-OutboundReport: notjunk:1;M01:P0:kNBQy6lEiCg=;BvW4gA6fn9fC7TTvLdxVWjC0lOz
 +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
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785259346; x=1785864146; i=xypron.glpk@gmx.de;
 bh=bmCsf2XT749uJjUPoP0WkOKtoony8G8QRrdlfUTy4gg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UtbH61knPi5sC8ai9VE3YOCAK0ikwk8CJc/0iiJaitWIUzYQzpO7b7GZvk6vlGNr
 cMRkaXG1ZIBnQ2RRIjVHwTKo43OjY1EnJuRhCtYvSOJSeX3a7KblMDSUgRpWBF2sm
 rhshsXtNzeH17kSQMCgTkeRZBrxJQku0QO67ZLUlZOOf6L5o7ijuRGtarnA34Jsro
 UWnpTeM+0Jatgeff8Q60vCuAXtJkT8PYwT1B30bUeybQ3V6q3mP77I7ClvchanTt1
 eVD9IIsiha96MsDuVeb4wDmwN1CJA7Q+qktEnoibxX3uR8sdv9pZOdjum8T6Wmqh3
 jiR53mYCGvbGbIiPfg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=UtbH61kn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Am 28=2E Juli 2026 15:33:18 MESZ schrieb Marek Vasut <marek=2Evasut+renesas=
@mailbox=2Eorg>:
>The "env" command is the recommended environment management command,
>its "print" subcommand is the equivalent replacement for legacy "printenv=
"
>command=2E Update the documentation to use the contemporary "env print"
>command instead of legacy "printenv" command=2E
>
>Note that the "printenv" command is unlikely to be removed from U-Boot
>in the near future due to it being integral part of the command line
>ABI=2E
>
>Implemented using:
>$ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/)=
 README

Hello Marek,

An earlier version of the series was merged today=2E Please, create a patc=
h for the delta=2E

Best regards

Heinrich


>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>---
>Cc: "NXP i=2EMX U-Boot Team" <uboot-imx@nxp=2Ecom>
>Cc: Anup Patel <anup@brainfault=2Eorg>
>Cc: Atish Patra <atishp@atishpatra=2Eorg>
>Cc: Daniel Golle <daniel@makrotopia=2Eorg>
>Cc: Dillon Min <dillon=2Eminfei@gmail=2Ecom>
>Cc: E Shattow <e@freeshell=2Ede>
>Cc: Fabio Estevam <festevam@gmail=2Ecom>
>Cc: Frank Wunderlich <frank-w@public-files=2Ede>
>Cc: Hal Feng <hal=2Efeng@starfivetech=2Ecom>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Igor Opaniuk <igor=2Eopaniuk@gmail=2Ecom>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: James Hilliard <james=2Ehilliard1@gmail=2Ecom>
>Cc: Kamil Lulko <kamil=2Elulko@gmail=2Ecom>
>Cc: Lukasz Majewski <lukma@nabladev=2Ecom>
>Cc: Mattijs Korpershoek <mkorpershoek@kernel=2Eorg>
>Cc: Max Merchel <Max=2EMerchel@ew=2Etq-group=2Ecom>
>Cc: Michal Simek <michal=2Esimek@amd=2Ecom>
>Cc: Minda Chen <minda=2Echen@starfivetech=2Ecom>
>Cc: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
>Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri=2Eorg>
>Cc: Nora Schiffer <nora=2Eschiffer@ew=2Etq-group=2Ecom>
>Cc: Palmer Dabbelt <palmer@dabbelt=2Ecom>
>Cc: Patrice Chotard <patrice=2Echotard@foss=2Est=2Ecom>
>Cc: Patrick Delaunay <patrick=2Edelaunay@foss=2Est=2Ecom>
>Cc: Paul Walmsley <paul=2Ewalmsley@sifive=2Ecom>
>Cc: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>Cc: Sam Protsenko <semen=2Eprotsenko@linaro=2Eorg>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Stefano Babic <sbabic@nabladev=2Ecom>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: u-boot@ew=2Etq-group=2Ecom
>Cc: u-boot@lists=2Edenx=2Ede
>Cc: uboot-stm32@st-md-mailman=2Estormreply=2Ecom
>---
>V2: Fix up "env set" and "env print" in README
>---
> README                    | 8 ++++----
> doc/README=2Eodroid         | 4 ++--
> doc/android/ab=2Erst        | 2 +-
> doc/usage/cmd/askenv=2Erst  | 6 +++---
> doc/usage/cmd/memsize=2Erst | 2 +-
> 5 files changed, 11 insertions(+), 11 deletions(-)
>
>diff --git a/README b/README
>index 0e3c278e29d=2E=2Ef740188a4bb 100644
>--- a/README
>+++ b/README
>@@ -754,7 +754,7 @@ The following options need to be configured:
> 		directly type `$name' at the command prompt=2E
>=20
> 		Global environment variables are those you use "env set"
>-		or printenv to work with=2E To run a command stored
>+		or "env print" to work with=2E To run a command stored
> 		in such a variable, you need to use the run command,
> 		and you must not use the '$' sign to access them=2E
>=20
>@@ -1655,15 +1655,15 @@ The "bootm" command is used to boot an applicatio=
n that is stored in
> memory (RAM or Flash)=2E In case of a Linux kernel image, the contents
> of the "bootargs" environment variable is passed to the kernel as
> parameters=2E You can check and modify this variable using the
>-"printenv" and "env set" commands:
>+"env print" and "env set" commands:
>=20
>=20
>-	=3D> printenv bootargs
>+	=3D> env print bootargs
> 	bootargs=3Droot=3D/dev/ram
>=20
> 	=3D> env set bootargs root=3D/dev/nfs rw nfsroot=3D10=2E0=2E0=2E2:/Linu=
xPPC nfsaddrs=3D10=2E0=2E0=2E99:10=2E0=2E0=2E2
>=20
>-	=3D> printenv bootargs
>+	=3D> env print bootargs
> 	bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10=2E0=2E0=2E2:/LinuxPPC nfsadd=
rs=3D10=2E0=2E0=2E99:10=2E0=2E0=2E2
>=20
> 	=3D> bootm 40020000
>diff --git a/doc/README=2Eodroid b/doc/README=2Eodroid
>index f0592dd57fc=2E=2E8fe226cf4cf 100644
>--- a/doc/README=2Eodroid
>+++ b/doc/README=2Eodroid
>@@ -200,7 +200,7 @@ Odroid #
> Note that this automatically sets the many IP address related variables =
in
> U-Boot that is obtained from the DHCP server=2E
>=20
>-Odroid # printenv ipaddr netmask gatewayip dnsip
>+Odroid # env print ipaddr netmask gatewayip dnsip
> ipaddr=3D192=2E168=2E1=2E10
> netmask=3D255=2E255=2E255=2E0
> gatewayip=3D192=2E168=2E1=2E1
>@@ -256,7 +256,7 @@ Loading: ####
> 	 40 KiB/s
> done
> Bytes transferred =3D 46935 (b757 hex)
>-Odroid # printenv bootargs
>+Odroid # env print bootargs
> bootargs=3DPlease use defined boot
> Odroid # env set bootargs console=3DttySAC1,115200n8 root=3D/dev/mmcblk0=
p2 rootwait
> Odroid # bootz 40080000 - 42000000
>diff --git a/doc/android/ab=2Erst b/doc/android/ab=2Erst
>index 7fd4aeb6a72=2E=2Eb0123db28e4 100644
>--- a/doc/android/ab=2Erst
>+++ b/doc/android/ab=2Erst
>@@ -54,7 +54,7 @@ or::
>=20
> Result::
>=20
>-    =3D> printenv slot_name
>+    =3D> env print slot_name
>     slot_name=3Da
>=20
> Based on this slot information, the current boot partition should be def=
ined,
>diff --git a/doc/usage/cmd/askenv=2Erst b/doc/usage/cmd/askenv=2Erst
>index a8867ce4d26=2E=2E0aebc70214f 100644
>--- a/doc/usage/cmd/askenv=2Erst
>+++ b/doc/usage/cmd/askenv=2Erst
>@@ -44,7 +44,7 @@ Value of a environment variable env1 without message an=
d size parameters:
>=20
>     =3D> askenv env1
>     Please enter 'env1': val1
>-    =3D> printenv env1
>+    =3D> env print env1
>     env1=3Dval1
>=20
> Value of a environment variable env2 with message and size parameters:
>@@ -53,7 +53,7 @@ Value of a environment variable env2 with message and s=
ize parameters:
>=20
>     =3D> askenv env2 Please type-in a value for env2: 10
>     Please type-in a value for env2: 1234567890123
>-    =3D> printenv env2
>+    =3D> env print env2
>     env2=3D1234567890
>=20
> Value of a environment variable env3 with size parameter only:
>@@ -62,7 +62,7 @@ Value of a environment variable env3 with size paramete=
r only:
>=20
>     =3D> askenv env3 10
>     Please enter 'env3': val3
>-    =3D> printenv env3
>+    =3D> env print env3
>     env3=3Dval3
>=20
> Configuration
>diff --git a/doc/usage/cmd/memsize=2Erst b/doc/usage/cmd/memsize=2Erst
>index 6e99d7c1d33=2E=2E9ebeefc58fa 100644
>--- a/doc/usage/cmd/memsize=2Erst
>+++ b/doc/usage/cmd/memsize=2Erst
>@@ -34,7 +34,7 @@ This second example shows assign ram size to environmen=
t variable:
> ::
>=20
>   =3D> memsize memsz
>-  =3D> printenv memsz
>+  =3D> env print memsz
>   memsz=3D8192
>=20
> Return value

