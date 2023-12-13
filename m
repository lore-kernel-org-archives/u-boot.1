Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46E6C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 08:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC0587463;
	Wed, 13 Dec 2023 09:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HAgnSjQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BAD874CC; Wed, 13 Dec 2023 09:48:29 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39FA807E4
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 09:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1702457306;
 bh=gsYfvc/lCedxsHUZzeesEOnnFtQL42HAyPYzWxm/Z2A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=HAgnSjQ8pdqCe7BXF6Xmt8DeYjVuU9zR788L+ocFulZv20oAAwGX8DxzIHcDK6/90
 oDKHqRK9Y9jrs3/W97weG3TNcCsbt1Vc/sn3f/0s2OqCvSXhrGsEIdkXqUINRbZ1OW
 4IBUpBlf5gw22H9XPCq/B10Jb+nHn5+eqVNLCbo87OV9Rf+nVRmp9gPJWz6jsUfwGr
 D4343dpFNfj2GrE+hH6PLY1a/XVUZL/WrLmeIYOfEHIgpRhAs0PF1va0+0qBel+y3r
 sIZ6fjmuA4kXC0XXBeK30G5eMmu2Qn4PQT8cCNBOg4rYpbyjtYuDUqzndDxTtKiPwD
 BAhdMS97mp84g==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 630A13781482;
 Wed, 13 Dec 2023 08:48:26 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id F11FA9862E0D; Wed, 13 Dec 2023 09:48:25 +0100 (CET)
Message-ID: <f7b9a398f05e690cb556e52e3bb7d6cd9f0f41f6.camel@collabora.com>
Subject: Re: [PATCH v3 4/4] configs: am62x_evm_*: Enable USB and DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>, Martyn Welch
 <martyn.welch@collabora.com>, Dave Gerlach <d-gerlach@ti.com>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 09:48:25 +0100
In-Reply-To: <20231213035845.m77fgbgik7pu6mdo@bryanbrattlof.com>
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-5-sjoerd@collabora.com>
 <20231213035845.m77fgbgik7pu6mdo@bryanbrattlof.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

Hey Brian,

On Tue, 2023-12-12 at 21:58 -0600, Bryan Brattlof wrote:
[...]
> >=20
> > =C2=A0configs/am62x_evm_a53_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 31 ++++++-
> > =C2=A0configs/am62x_evm_r5_usbdfu_defconfig | 111
> > ++++++++++++++++++++++++++
>=20
> One of the newer developments was the addition of config fragments[0]
> to=20
> try to minimize all the duplicate defconfigs for all the different=20
> evaluation boards for the same SoC we have in the pipeline. I'm=20
> wondering what people would think if we did this for the different=20
> boot-mode defconfigs for the 62xx extended family like this usbdfu
> and=20
> cpsw?=20
>=20
> idk how messy it would get trying to disable one of the primary boot=20
> modes like MMC and enable USB though... So this may be a idea for=20
> another day.

Nishanth mentioned the same and it's something i'd like to play with
(a=C2=A0beagleplay is on the way, but stuck in customs atm for some=C2=A0
practical tests).

However I think it would make sense to get this landed first and then
try refactoring with config fragments for a second step?


>=20
> [0]
> https://lore.kernel.org/u-boot/20231130115552.3580995-16-a-nandan@ti.com/
> =C2=A0
>=20
> ~Bryan

--=20
Sjoerd Simons
Collabora Ltd.
