Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BCDCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D4C83C62;
	Wed, 12 Nov 2025 14:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="nPO9DYma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85B183C6D; Wed, 12 Nov 2025 14:50:32 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844F083C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d64Y21ggJzmH1;
 Wed, 12 Nov 2025 14:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762955430;
 bh=K1JccERHKRR+QHSPUH2VWN2L2nSazOd43qSFYArc6Bc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nPO9DYma+9huu0dEtA6k13ygCMxg/uDkzj7wjuA7SAwrtnQ176oKQf8m08s3OILCb
 u3lntBTzkX4/FmYouuEWz0ruLwyx58m+SFEiseVbiK/fWWjP9FBUWLzk8edfIeuLk7
 FgPcAuXWqBp0/EzT9J8C0JxKD9Mu2XdkRpVwBHYg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d64Y03nT4zHF6; Wed, 12 Nov 2025 14:50:28 +0100 (CET)
Message-ID: <372f7735a0d526055de4028d0d69636fbe65bba0.camel@pschenker.ch>
Subject: Re: [PATCH v3 6/6] remoteproc: k3-r5: Implement is_running operation
From: Philippe Schenker <dev@pschenker.ch>
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Cc: stefan@embear.ch, Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar
 Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini	 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Date: Wed, 12 Nov 2025 14:49:46 +0100
In-Reply-To: <03940bba-e496-4078-9804-1b9daf6f43ab@ti.com>
References: <20251111071756.1257488-1-dev@pschenker.ch>
 <20251111071756.1257488-7-dev@pschenker.ch>
 <03940bba-e496-4078-9804-1b9daf6f43ab@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-C7+z+hYETghwJbAjKOIC"
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
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


--=-C7+z+hYETghwJbAjKOIC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-11-11 at 10:11 -0600, Andrew Davis wrote:
> On 11/11/25 1:16 AM, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > Add is_running callback to query the R5F core halt status via the
> > TI-SCI processor control API. This allows the remoteproc framework
> > to determine whether the R5F core is currently runnin.
> >=20
> > The core is considered running when the
> > PROC_BOOT_CTRL_FLAG_R5_CORE_HALT
> > bit is not set in the control flags.
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > ---
> >=20
> > Changes in v3:
> > - Implemented Andrew's suggestion to assign size before casting for
> > =C2=A0=C2=A0 memory safety.
> > - Added Anshul's Reviewed-by, thanks!
> >=20
> > Changes in v2:
> > - Made sure there are no build-warnings caused by this series.
> >=20
> > =C2=A0 drivers/remoteproc/ti_k3_r5f_rproc.c | 17 +++++++++++++++++
> > =C2=A0 1 file changed, 17 insertions(+)
> >=20
> > diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c
> > b/drivers/remoteproc/ti_k3_r5f_rproc.c
> > index c6356729e9db..7326f5a4b30b 100644
> > --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> > @@ -573,6 +573,22 @@ static void *k3_r5f_da_to_va(struct udevice
> > *dev, ulong da, ulong size, bool *is
> > =C2=A0=C2=A0 return map_physmem(da, size, MAP_NOCACHE);
> > =C2=A0 }
> > =C2=A0=20
> > +static int k3_r5f_is_running(struct udevice *dev)
> > +{
> > + struct k3_r5f_core *core =3D dev_get_priv(dev);
> > + u32 cfg, ctrl, sts;
> > + u64 boot_vec;
> > + int ret;
> > +
> > + dev_dbg(dev, "%s\n", __func__);
>=20
> This debug statement doesn't do much other than note when the
> function is called, which can be done with other tracing methods.
> Either drop it or have it also print something useful like the
> status of the core (running / not running).

Hi Andrew, and thanks for also looking at this patch! I actually put
that dev_dbg() there to be in line with all the other functions in this
file. They all have this.=20

I'll keep it for consistency with the existing functions, but I agree
these could all be cleaned up in a future refactoring patch.

>=20
> Other than that LGTM,
>=20
> Reviewed-by: Andrew Davis <afd@ti.com>
>=20
> BTW this function would be the same for all the ti_k3_* rproc
> drivers, in Linux all these were factored out to common K3 helpers,
> might be a good refactor for here in U-Boot also..

Thanks! Good to know, if I touch it again I can refactor those common
functions out like on kernel.

Philippe

> > +
> > + ret =3D ti_sci_proc_get_status(&core->tsp, &boot_vec, &cfg, &ctrl,
> > &sts);
> > + if (ret)
> > + return -1;
> > +
> > + return !!(ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT);
> > +}
> > +
> > =C2=A0 static int k3_r5f_init(struct udevice *dev)
> > =C2=A0 {
> > =C2=A0=C2=A0 return 0;
> > @@ -590,6 +606,7 @@ static const struct dm_rproc_ops
> > k3_r5f_rproc_ops =3D {
> > =C2=A0=C2=A0 .stop =3D k3_r5f_stop,
> > =C2=A0=C2=A0 .load =3D k3_r5f_load,
> > =C2=A0=C2=A0 .device_to_virt =3D k3_r5f_da_to_va,
> > + .is_running =3D k3_r5f_is_running,
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 static int k3_r5f_rproc_configure(struct k3_r5f_core *core)

--=-C7+z+hYETghwJbAjKOIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmkUkHoACgkQjRDjR2ho
XxoTIwwAmK45BeS1tT1w5iLKcjvdNxtH7EueEpkP/grdSrVybmqyQDlt3mKWpBN5
kdAcF030b4W7VfRrwTLReL3XuSJKGgbLP0ffh5wTNzR3Gnf7Tu5KN/R0SgJEL0lZ
el/USUO8JbQAVMXc9/kBi7vLYo2sM281EgL0gU2eqC+DSj6jQP20Z7S9iIsnMZ8B
8j52Vjew5VBK5KHG6x4yhq6tZaMtJulwcThzJIWi15yICcgIrtdc0BgRN4fnED4Q
hI8IgU7E46KuqlovDzOcq0JestmdqWWNNus5KpkCQxtHkYmf1ZRvNGMinznFgscQ
gJfdcGnHRhhqAir7BmUpR41fOliBxwHvukIWMcIzV7X+yF4Ti4DPGeGKKB3mTLK3
BneoxuWCKIH0iDWPN7dp8nvZNwQkx5bRR7DYSdvrMcWbWUlQwKYEJ3ldykV+8gXk
eXZnMpUpy4kVvqv+8+EAVB7PMAnWMjcwrxKb1JV6TQ3TajhDLM0N82Ljm6X35Oky
hI50AbBX
=MAj8
-----END PGP SIGNATURE-----

--=-C7+z+hYETghwJbAjKOIC--
