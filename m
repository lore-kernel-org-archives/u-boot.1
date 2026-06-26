Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F504CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 08:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3928460E;
	Fri, 26 Jun 2026 10:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="ioqNPcOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D54884894; Fri, 26 Jun 2026 10:26:45 +0200 (CEST)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [178.154.239.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBAC8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 10:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:3388:0:640:154:0])
 by forward500a.mail.yandex.net (Yandex) with ESMTPS id C407FC1366;
 Fri, 26 Jun 2026 11:26:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id bQVmcTIqTeA0-uxvb13Eh; 
 Fri, 26 Jun 2026 11:26:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1782462400; bh=xxKs+2ocwgMStYAo08kal8clc2AmjGdipUNEoXoYNlQ=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=ioqNPcOrGCHGxSWyx6oAPFzaQ3IK9B8I/H5jXuWrC1CyFTw+gsXDdMUpgzdpoIP7Q
 pHdIl+FHdLTsads4uif+2qvEPMrAALWHubT3jew+yf65hAH4KyqHacGAs16VdIWlPq
 Nm07jSgOpORf75BeH59QogIUm8wUHRvIOf7dK0gw=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <265dbef886c0cd6f8402101c1913a7a792e5388b.camel@maquefel.me>
Subject: Re: [PATCH RFC 2/2] spl: opensbi: fix OS image address retrieval
 from FIT
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
Date: Fri, 26 Jun 2026 11:26:41 +0300
In-Reply-To: <CAFLszTgi=hWWoEZVx9iKprQ6xkMb=8F115m-hW=bcqR2sJGBZQ@mail.gmail.com>
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
 <20260619-riscv-full-fit-image-support-v1-2-c6477cf4f410@maquefel.me>
 <CAFLszTgi=hWWoEZVx9iKprQ6xkMb=8F115m-hW=bcqR2sJGBZQ@mail.gmail.com>
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

On Thu, 2026-06-25 at 11:58 +0100, Simon Glass wrote:
> Hi Nikita,
>=20
> On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me>
> wrote:
> > spl: opensbi: fix OS image address retrieval from FIT
> >=20
> > The current implementation of spl_invoke_opensbi() attempts to
> > locate
> > the next-stage OS (U-Boot proper or Linux) by parsing the FDT blob
> > pointed to by spl_image->fdt_addr. This FDT, however, is the one
> > that
> > will be passed to the OS (e.g. a kernel device tree), not the FIT
> > image
> > itself. As a result, when a FIT image containing multiple
> > components
> > (firmware, loadables, fdt) is loaded, U-Boot SPL cannot find the OS
> > node
> > because it searches in the wrong FDT.
> >=20
> > Fix this by storing the load addresses of U-Boot and Linux in
> > spl_image_info during the loadables phase (spl_load_fit_image()).
> > In spl_invoke_opensbi(), use these stored addresses if they are
> > non-zero, and fall back to parsing the FDT only if no address is
> > stored,
> > maintaining backward compatibility.
> >=20
> > This ensures that the correct entry point is passed to OpenSBI,
> > allowing proper boot flow with FIT images.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > common/spl/spl_fit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> > =C2=A0common/spl/spl_opensbi.c | 33 +++++++++++++++++++--------------
> > =C2=A0include/spl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> > =C2=A03 files changed, 35 insertions(+), 14 deletions(-)
>=20
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > @@ -1020,6 +1020,14 @@ int spl_load_fit_image(struct spl_image_info
> > *spl_image,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &img_data, &im=
g_len);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret < 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +
> > +#if CONFIG_IS_ENABLED(OPENSBI)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (fit_image_check_os((const void *)header, ret,
> > IH_OS_LINUX))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl_image->kernel_addr =
=3D img_data;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (fit_image_check_os((const void *)header, ret,
> > IH_OS_U_BOOT))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl_image->uboot_addr =
=3D img_data;
> > +#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I don't like this approach. The real reason spl_invoke_opensbi()
> fails

Neither do I. That's the reason for RFC.

> in the LOAD_FIT_FULL path is that nothing populates the /fit-images
> node in the outgoing FDT - the simple FIT loader does this via
> spl_fit_record_loadable() / fdt_record_loadable(), and spl_opensbi.c
> then walks it.
>=20
> I think it would be better to fix it that way: call
> fdt_record_loadable() for each loadable (and for the firmware/fdt) so
> the OS DT carries /fit-images just like in the simple-FIT case. Then
> spl_invoke_opensbi() needs no changes, ATF gets the same fix for
> free,
> and we avoid carving out RISC-V/OpenSBI-specific fields in struct
> spl_image_info...I wonder if you are deliberately wanting the
> simple-FIT case to be different? If so can you please explain why?

Nope - i don't want it to be different at all. Thank you for tips -
i'll look into implementing a cleaner approach.

>=20
> If you do want to cache the addresses on spl_image_info, drop the
> OPENSBI-specific naming and guards - the loadables loop has no
> business knowing about OpenSBI, and the fields should be filled in
> both spl_load_simple_fit() and spl_load_fit_image() for consistency.

Agreed.

>=20
> > diff --git a/include/spl.h b/include/spl.h
> > @@ -288,6 +292,10 @@ struct spl_image_info {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ulong entry_point;
> > =C2=A0#if CONFIG_IS_ENABLED(LOAD_FIT) ||
> > CONFIG_IS_ENABLED(LOAD_FIT_FULL)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *fdt_addr;
> > +#if CONFIG_IS_ENABLED(OPENSBI)
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ulong uboot_addr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ulong kernel_addr;
> > +#endif
> > =C2=A0#endif
>=20
> Nesting OPENSBI inside LOAD_FIT is fragile - if anyone enables
> SPL_OPENSBI without SPL_LOAD_FIT these fields silently vanish while
> spl_opensbi.c still references them. At minimum the guards should
> match spl_opensbi.c.
>=20
> Also, uboot_addr here is the load address of the loadable, but the
> existing spl_invoke_opensbi() prefers the entry point
> (fit_image_get_entry()), falling back to the load address. Storing
> only the load address is a behavioural change for images that set an
> explicit entry property - please mention this in the commit message,
> or store entry_point instead.
>=20
> > diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> > @@ -81,22 +81,27 @@ void __noreturn spl_invoke_opensbi(struct
> > spl_image_info *spl_image)
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOO=
T))
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOO=
T)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 os_type =3D IH_OS_LINUX;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 os_entry =3D spl_image->kernel_addr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 os_type =3D IH_OS_U_BOOT;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D spl_opensbi_find_os_node(spl_image->f=
dt_addr, &os_node,
> > os_type);
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pr_err("Can't find %s node for opensbi, %d\n",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 genimg_get_os_name(os_type), =
ret);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 hang();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 os_entry =3D spl_image->uboot_addr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Using 0 as a sentinel for "no cached address" is dodgy - a load
> address of 0 is unusual but not impossible, and silently falling
> through to FDT parsing is hard to debug. A separate bool would be
> cleaner, or better, record loadables into the FDT as suggested above.

Noted. I think most of these issues (if not all) will be resolved by
taking  spl_fit_record_loadable()/fdt_record_loadable() cleaner
approach.

Thank you!

Yours,
Nikita.

>=20
> Regards,
> Simon
