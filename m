Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D88C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC7B87635;
	Sat,  9 Dec 2023 15:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Sovzixjl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1E38763A; Sat,  9 Dec 2023 15:06:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E758759F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702130771; x=1702735571; i=xypron.glpk@gmx.de;
 bh=ZaF71SR6BqTmxJ/74wXYfOjiDKaaAJrPKCL1eoNlBnk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=SovzixjlOVpaBaffM2nhRSdsLHbCDyZ+5H7tZI15s5akkJ2cI4Kd0ODQP/KbIGc+
 b+8YpAIJEM3YYMHH4sYGklBdmjmL+ze7MyZFH/3P5Q+tzYlZL5H7NlE9yGFb/9ZS8
 PuXkjxbVPcyJaYWMAXzcp2v8c/rwy9pclarZCCN/JmZf2moVopx1GkX9OcXexwuQF
 TRS1Zy7R7akmnkb8s6ObO0Ce9nwIgdO2Kcbtlw5StmzyuBiUwP9zQm1hEC8U95CiO
 MWUBg55tonc8zleS2Bwoooq4GETiozr7B97T3UQHMBnUo3COl0rdJT/F6B/PJtZgr
 OKO4E96OEF3lpe4t2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1rJQ6q344B-017Hly; Sat, 09
 Dec 2023 15:06:11 +0100
Message-ID: <c949346c-228a-4733-87ce-14a8e62d6ca2@gmx.de>
Date: Sat, 9 Dec 2023 15:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231203044719.667116-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uHwek5yFPZ0IRc3N8bZQ5jgBWYez1HmVJVWexL37obqgtxNxcYg
 H09rjxCvXAw1uZif4CNMxO9sqbzIMTtrt3C6XYeUMw91DI48lxiAgI78TgWbDFN0SOriUzN
 39m9scfyif/XRzYsC7EE42k2akgc5LfXa/sPCB/LupKPkCM8K51AFxdG6I6S2e3Sn9yFJaO
 qr5jC4y6iAKCpcUnsNo3A==
UI-OutboundReport: notjunk:1;M01:P0:7V3ixT4bCtY=;/Fn73e3Tbmmm9hEeVi1w4ezPppz
 PJsHtOapIVM3Leln7dKLnXKBQ2EoNFbewcstMR0hN8JdxESfJalEgUv4wHtO8xuPE1i9JOu8q
 Za7Xca8fLAgjoKV7uF5vn6bKWXVgbMW4u65xzBSgdgKlRqNDBQuKq5w8dONy1PqVpmvk40Zxp
 KQiLVxCLNKLaReGbPAvNbdL9pakuFkwRHu2hjvBlRCRuU6svyCP+sRWfVmAVkZYP8XUPf4NEQ
 W011sN9jW8fNfqAROjDd+oHlNlsoggZlgrH6AzoQVJOSDEkOUYVq2i4T9am78m6T6WX57wVyB
 iSWkDtZTMtrKQSSehze1iN2YSyuN+q6XeBIfEvHxSq8PRjMVfqWDi255Gc/8DcNyPOsHBD06e
 V4hPrVqmLMx7BfD7jpL3mButymFCd2hVLu6yuXwsqOZwcjd900qNCgNVOcApnZ3IEFsrM28rE
 TmHse+A/T7VsRs+EW/Pcz/YwAyIH6iA5YwZJ3sS1fPmdkGRQYnP+j/0N9yaevq+QzGHfKuDKZ
 orRb+T4eVr4taT+OuvEzeecwXsNY2CfIRGuHwzer65t9H3TciqHA9OvpO4hx10UtmTKwXR7Fn
 cgjLlxBw6Hx/AlAZ8soIoiaUvnHQi3GrMqIEhgKkoVXGsKPcyXhVCFgEQqJqNwunzA4owrex0
 iVNhSUorLcWG0YT2DgS6wZuLz9JYREsEddxBHD7oB3IpGEQcrVxEu4TrmCPROHCxUuSLtlz80
 4H+D00nmIZT3w8DPPB4sKMWu5zjF0sLKquKA1Cj44lq1FN4M0l4y3iAQ5qcdczYSXxuC1ACU9
 NTkJRo7w44kvVZbDJcGmd200bEXmr1cWJXQ0gNnpJot+vWDvQlyfiou2gJ1QmJBobt3Esgfpx
 xNEoJmHg9AvGfJIIcoeNIK/qwYKrA0Nc/HckC81prH0GLMHILorQ0kKUZ5BvC9GHQg/y4BN88
 83FXAWJ7V9mu763IdRLMOhMLdLY=
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

On 12/3/23 05:46, Simon Glass wrote:
> This looks at the top unknowns:
>
>     git log --pretty=3D%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
>        sort -nr |
>     (while read count email; do
>         if ! grep -q $email u-boot-config/domain-map; then
>            echo "$count $email";
>         fi; done )
>
> It reduces the (Unknown) count from a third to a fifth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
> index 63cb60f..27f1a7e 100644
> --- a/u-boot-config/domain-map
> +++ b/u-boot-config/domain-map
> @@ -18,6 +18,7 @@ amd.com			AMD
>   anagramm.de		Anagramm GmbH
>   analog.com		Analog Devices
>   android.com		Google LLC
> +andestech.com		Andes Technology
>   arastra.com		Arastra Inc
>   areca.com.tw		Areca
>   argos-messtechnik.de	Argos Me=C3=9Ftechnik GmbH
> @@ -44,6 +45,7 @@ bluewatersys.com	Bluewater Systems
>   boeing.com		Boeing
>   bootlin.com		Bootlin
>   boundarydevices.com	Boundary Devices
> +bp.renesas.com		Renesas Electronics Corporation
>   broadcom.com		Broadcom
>   brontes3d.com		Brontes Technologies
>   bt.com			BT Group
> @@ -51,6 +53,7 @@ bull.net		Bull SAS
>   bus-elektronik.de	BuS Elektronik
>   calxeda.com		Calxeda
>   cam.ac.uk		University of Cambridge
> +canonical.com		Canonical Ltd.
>   ccur.com		Concurrent Computer Corporation
>   cdi.cz			CDI.CZ
>   celestrius.com		Celestrius
> @@ -58,6 +61,7 @@ celunite.com		Azingo
>   centtech.com		Centaur Technology
>   cesa.opbu.xerox.com	Xerox
>   chelsio.com		Chelsio
> +chromium.org		Google LLC
>   cideas.com		Custom IDEAS
>   cisco.com		Cisco
>   citi.umich.edu		Univ. of Michigan CITI
> @@ -78,6 +82,7 @@ cosmosbay.com		Cosmosbay Vectis
>   cozybit.com		cozybit
>   cray.com		Cray
>   cse-semaphore.com	CSE Semaphore, Inc.
> +csgroup.eu		CS Group
>   csr.com			CSR
>   cyberguard.com		Secure Computing
>   cybernetics.com		Cybernetics
> @@ -89,11 +94,13 @@ dell.com		Dell
>   denx.de			DENX Software Engineering
>   devicescape.com		Devicescape
>   digi.com		Digi International
> +dimonoff.com		Dimonoff inc.
>   doredevelopment.dk	Dore Development
>   dti2.net		DTI2 - Desarrollo de la tecnologia de las comunicaciones
>   e-coninfotech.com	e-con Infotech
>   ecitele.com		ECI Telecom
>   edesix.com		Edesix Ltd
> +edgeble.ai		Edgeble AI
>   einstruction.com	eInstruction
>   eke.fi			EKE-Electronics
>   elandigitalsystems.com	Elan Digital Systems
> @@ -119,10 +126,13 @@ feig.de			Feig Electronic
>   fixstars.com		Fixstars Technologies
>   free-electrons.com	Bootlin
>   freescale.com		NXP
> +foss.st.com		ST Microelectronics
> +foundries.io		Foundries.io
>   fujitsu.com		Fujitsu
>   gaisler.com		Gaisler Research
>   ganssloser.com		Ingenieurbuero Ganssloser
>   garzik.org		Red Hat
> +gateworks.com		Gateworks Corporation
>   gdsys.cc		Guntermann & Drunck
>   gdsys.de		Guntermann & Drunck
>   ge.com			General Electric
> @@ -140,6 +150,7 @@ hevs.ch			HES-SO Valais Wallis
>   highpoint-tech.com	HighPoint Technologies
>   hitachi.co.jp		Hitachi
>   hitachi.com		Hitachi
> +hitachienergy.com	Hitachi
>   hitachisoft.jp		Hitachi
>   hp.com			HP
>   huawei.com		Huawei Technologies
> @@ -164,10 +175,13 @@ jmicron.com		jmicron.com
>   jp.fujitsu.com		Fujitsu
>   juniper.net		Juniper Networks
>   katalix.com		Katalix Systems
> +kernel-space.org	kernelspace
>   keymile.com		Keymile
>   keyspan.com		InnoSys
> +kwiboo.se		Kwiboo
>   kiethp.com		Intel
>   konsulko.com		Konsulko Group
> +kontron.de		Kontron
>   labxtechnologies.com	Lab X Technologies
>   laptop.org		OLPC
>   laurelnetworks.com	ECI Telecom
> @@ -176,9 +190,11 @@ linaro.org		Linaro
>   linutronix.de		linutronix
>   linux-foundation.org	Linux Foundation
>   linuxant.com		Linuxant
> +linux.microsoft.com	Microsoft Corporation
>   linx.net		London Internet Exchange
>   lippert-at.de		LiPPERT Embedded Computers GmbH
>   lippertembedded.de	LiPPERT Embedded Computers GmbH
> +lionizers.com		Lionizers
>   llnl.gov		Lawrence Livermore National Laboratory
>   lnxi.com		Linux Networx
>   logitech.com		Logitech
> @@ -194,10 +210,14 @@ mandriva.com.br		Mandriva
>   marvell.com		Marvell
>   matrix-vision.de	Matrix Vision
>   mediamatech.com		Mediama Technologies
> +mediatek.com		MediaTek Inc.
>   mellanox.co.il		Mellanox
>   melware.de		Cytronics & Melware
> +metanate.com		Metanate Ltd.
>   mev.co.uk		MEV Limited
> +microchip.com		Microchip Technology Inc.
>   microgate.com		MicroGate Systems
> +microsoft.com		Microsoft Corporation
>   mimc.co.uk		Mercury IMC Ltd.
>   mips.com		MIPS
>   miraclelinux.com	Miracle Linux
> @@ -269,6 +289,7 @@ phytec.de		Phytec
>   pikatech.com		PIKA Technologies
>   pikron.com		PiKRON s.r.o
>   pmc-sierra.com		PMC-Sierra
> +prevas.dk		Prevas
>   prodrive.nl		Prodrive
>   profusion.mobi		ProFUSION
>   promise.com		Promise Technology
> @@ -278,6 +299,7 @@ psyent.com		Psyent
>   pwav.com		Powerwave Technologies
>   qlogic.com		QLogic
>   qumranet.com		Qumranet
> +radxa.com		Radxa
>   rdc.com.tw		RDC Semiconductor
>   realtek.com.tw		Realtek
>   reccoware.de		Reccoware Systems
> @@ -299,7 +321,9 @@ samsung.com		Samsung
>   sanpeople.com		SANPeople
>   sanyo.co.in		Sanyo LSI Technology India
>   savantav.com		Savant Systems
> +sberdevices.ru		Sber Devices
>   scram.de		scram! e.V.
> +seco.com		SECO S.p.A.
>   secretlab.ca		Secretlab
>   securecomputing.com	Secure Computing
>   semihalf.com		Semihalf Embedded Systems
> @@ -323,6 +347,7 @@ southpole.se		South Pole AB
>   spidernet.net		SpiderNet Services
>   st.com			ST Microelectronics
>   starentnetworks.com	Starent Networks
> +starfivetech.com	Shanghai Saifang Technology Co., Ltd.
>   steeleye.com		SteelEye
>   stericsson.com		ST-Ericsson
>   stlinux.com		ST Microelectronics
> @@ -343,10 +368,13 @@ telargo.com		Telargo
>   teleca.com		Teleca
>   tensilica.com		Tensilica
>   terascala.com		Terascala
> +theobroma-systems.com	Theobroma Systems Design und
>   thinktube.com		Thinktube
> +thorsis.com		Thorsis Technologies GmbH
>   thot-soft.com		Thot-Soft 2002
>   ti.com			Texas Instruments
>   til-technologies.fr	TIL Technologies
> +tinylab.org		Taixiao Technology
>   tls.msk.ru		Telecom-Service
>   toptica.com		TOPTICA Photonics
>   toradex.com		Toradex
> @@ -359,6 +387,7 @@ tqs.de			TQ Systems
>   transitive.com		Transitive
>   transmode.com		Transmode Systems
>   transmode.se		Transmode Systems
> +traverse.com.au		Traverse Technologies
>   tresys.com		Tresys
>   trinnov.com		Trinnov Audio
>   tripeaks.co.jp		Tripeaks
> @@ -536,3 +565,12 @@ sjg@chromium.org		Google LLC
>
>   # Louis Yung-Chieh Lo <yjlou@chromium.org>
>   # yjlou@google.com		Google LLC
> +
> +# Rob Herring
> +robh@kernel.org			ARM
> +
> +# Masahiro Yamada
> +masahiroy@kernel.org		Canonical

As I have a .mailmap entry maybe you need to add:

# Heinrich Schuchardt
xypron.glpk@gmx.de		Canonical

> +
> +# Marek Vasut
> +marek.vasut+renesas@mailbox.org	Renesas Electronics Corporation

