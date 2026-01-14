Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4486CD29FE3
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 10:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6219180081;
	Wed, 14 Jan 2026 11:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="t7dXNYV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1217C80325; Wed, 14 Jan 2026 11:31:29 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB84A8003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5174E4E420D2;
 Wed, 14 Jan 2026 10:31:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2372C6074A;
 Wed, 14 Jan 2026 10:31:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B5AC103C8951; Wed, 14 Jan 2026 11:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768386684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9P1v2N0wyT/A6kKthn69RC3ccH/J3XBqIsnoj4kK1BU=;
 b=t7dXNYV6j5MoQBmB94gArdNjzJIeBFmiu0C4TEo1sKuNKDj0vRU0cmkBB00q/z//MpBn1L
 Kao2iTTO/SNdgOI8KVZT4qBD98xJSdaMufsC9iOqkZ70WDSHsbYsKY9QQjTDBZ1ZMruvdn
 BZsNm2mwKn6GOuFP28oyAofKUJb21GXzdLuPNwCq07D9zt5DNtN2fVU3yXwHgpS5Fz7FnB
 xNO+ItwNNG4gcosd6I4b7C/q5P15UyNGxd5nUOkVmGZuxhm6Xi8Zy/zg4c0Z3qv5IXga9k
 MmYQ2+5osC7NzUEruWEa/58feonS9aEmIgyezPOnbXJBQfPDQtnqswpvk4Q3NA==
Date: Wed, 14 Jan 2026 11:31:15 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, Arturs
 Artamonovs <arturs.artamonovs@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Stefan Roese <stefan.roese@mailbox.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, E Shattow <e@freeshell.de>, Raymond Mao
 <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang
 <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>, Leonard
 Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH v2 0/6] Add support for fwumdata
Message-ID: <20260114113115.01a0f1fd@kmaincent-XPS-13-7390>
In-Reply-To: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
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

On Fri, 12 Dec 2025 17:23:25 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add a new fwumdata tool to allows users to read, display, and modify FWU
> (Firmware Update) metadata from Linux userspace. It provides functionality
> similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> metadata, change active/previous bank indices, modify bank states, and set
> image acceptance flags. Configuration is done via fwumdata.config file.
>=20
> Made a few change to mkfwumdata tool along the way.

Hello, any news on this patch series.

It would be nice if someone could take a look at this and help me get this
merged.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
