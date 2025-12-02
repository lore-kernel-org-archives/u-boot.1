Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8AED1171B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8A683E83;
	Tue,  2 Dec 2025 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="F11s5lrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 615DE83E92; Tue,  2 Dec 2025 18:41:33 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4782C83B48
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 953ACC16A21;
 Tue,  2 Dec 2025 17:41:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A681A606D6;
 Tue,  2 Dec 2025 17:41:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1E2611919F11; Tue,  2 Dec 2025 18:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764697288; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=U24MGW6PhUBxH6RO1EbiQNuGzAR5ZLmRZK9PUUCeuHg=;
 b=F11s5lrJO897GGHWO0sqb4tcAerBzFVkOTBVwa3iX9cOASMu2k5Pl9FrdnG+q/eWQ/3inP
 aySmcyLfdFpIayg68CoA4zTxmYqLiZjhDQis2p613KGP5Q6I4t/YGOBqx6IUnliekeEGzn
 HAHrtI/RKG/Kw+AYGPUmokZyv8azb2l5QTofYQx8zjnUQxiXyou0teH6VOipBfQ5/ljnIn
 4D9GZCUJEQDKOp0VyAPtD6Oij4Yc33at+wp3C1FyqHafroltGq702IrEQPZyedFa5cCd5S
 XWG6/lcRszbWNAu3bAzz7FlMDzi96aNLk8bLlwX2gFUx5RyWLJSNxcYAhKvHcw==
Date: Tue, 2 Dec 2025 18:41:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, Arturs
 Artamonovs <arturs.artamonovs@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>, Duje
 =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, Stefan Roese
 <stefan.roese@mailbox.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, Alif
 Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, E Shattow
 <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, Daniel
 Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Leonard Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH 0/6] Add support for fwumdata
Message-ID: <20251202184109.5268d840@kmaincent-XPS-13-7390>
In-Reply-To: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 02 Dec 2025 18:28:25 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add a new fwumdata tool to allows users to read, display, and modify FWU
> (Firmware Update) metadata from Linux userspace. It provides functionality
> similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> metadata, change active/previous bank indices, modify bank states, and set
> image acceptance flags. Configuration is done via fwumdata.config file.
>=20
> Made a few change to mkfwumdata tool along the way.

I just noticed that I should have added an output example:
$ ./fwumdata -l
FWU Metadata:
	Version:            2
	Active Index:       0
	Previous Index:     1
	CRC32:              0x1f21ff7b
	Metadata Size:      120 bytes
	Descriptor Offset:  16
	Bank States:
		Bank 0: accepted (0xfc)
		Bank 1: accepted (0xfc)

	Firmware Store Descriptor:
		Number of Banks:       2
		Number of Images:      1
		Image Entry Size:      80
		Bank Info Entry Size:  24

	Images:
		Image 0:
			Image Type GUID:  65ae85ad-1fb3-0b46-8c5d-285543aa6eab
			Location GUID:    51513491-da07-2a4f-9bea-375ea53b1b5c
			Banks:
				Bank 0:
					Image GUID:  cb2df442-f929-6a44-a374-672d92eb2aa7
					Accepted:    yes (1)
				Bank 1:
					Image GUID:  a839a18f-395c-484f-83b8-0354077c8f9f
					Accepted:    yes (1)


Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
