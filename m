Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650EDCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41888460E;
	Wed, 24 Jun 2026 09:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="ZCfrj68W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFC1848DC; Wed, 24 Jun 2026 09:11:52 +0200 (CEST)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2732180287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward500a.mail.yandex.net (Yandex) with ESMTPS id 52DB7C1B95;
 Wed, 24 Jun 2026 10:11:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id hBSoBXKgCeA0-cHgVbA4B; 
 Wed, 24 Jun 2026 10:11:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1782285106; bh=G920w1Z2FYEM85rPXuBwYNluZsEhWq50JymgDuFVr3s=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=ZCfrj68WfTIxIMAYrtVlQ76kPE/EfZSRa5SBITLVv9+b9D7e3EvykJAkm35ynVJ++
 wkul7NSR1zW90HYdH3TPOuWtuG5VTjSV285YniwXZqaGFn6d6MRO0PydOGuMZDjacj
 VIremLq7v5z3QbdnsA/iRr2d4Lf0a/C78KRaW8Xo=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <13e734c5efc59200779973e370b82f6fbd05357f.camel@maquefel.me>
Subject: Re: [PATCH RFC 1/2] image: fit: allow IH_OS_OPENSBI in
 fit_image_load()
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Quentin Schulz	
 <quentin.schulz@cherry.de>, James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Frank Wunderlich	 <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Rasmus Villemoes <ravi@prevas.dk>, Anshul
 Dalal	 <anshuld@ti.com>, Michael Walle <mwalle@kernel.org>,
 =?ISO-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>, Dhruva
 Gole <d-gole@ti.com>, Richard Genoud	 <richard.genoud@bootlin.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>
Date: Wed, 24 Jun 2026 10:11:46 +0300
In-Reply-To: <CAFLszTiF4Jz7d=PdXvXsusQZ5436qUaFMBYsa76CS_G6uHDwpQ@mail.gmail.com>
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
 <20260619-riscv-full-fit-image-support-v1-1-c6477cf4f410@maquefel.me>
 <CAFLszTiF4Jz7d=PdXvXsusQZ5436qUaFMBYsa76CS_G6uHDwpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
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

Hi Simon,

On Tue, 2026-06-23 at 15:47 +0100, Simon Glass wrote:
> Hi Nikita,
>=20
> On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me>
> wrote:
> > image: fit: allow IH_OS_OPENSBI in fit_image_load()
> >=20
> > Add IH_OS_OPENSBI to the list of supported OS types in the os_ok
> > check
> > so that FIT images containing an OpenSBI firmware can be loaded
> > without
> > error. Otherwise loading OpenSBI in full FIT Image is not possible.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > boot/image-fit.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
>=20
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > @@ -2258,6 +2258,7 @@ int fit_image_load(struct bootm_headers
> > *images, ulong addr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fit_image_check_os(fit, noffset, IH_OS_TEE) ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fit_image_check_os(fit, noffset, IH_OS_OPENSBI) |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fit_image_check_os(fit, noffset, IH_OS_EFI) ||
>=20
> Should be || not |

Thanks !

>=20
> Regards,
> Simon
