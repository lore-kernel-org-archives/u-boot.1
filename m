Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD807E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAD780107;
	Thu,  9 Jan 2025 16:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+68ikp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508C2805EA; Thu,  9 Jan 2025 16:05:05 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3800C800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so176135285a.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736435100; x=1737039900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bfz0EfuFckdgq7nOcoBXEQ03BKcQ1akDtlGAjUGj1KM=;
 b=l+68ikp2/y1Hc8xo5mLmz14ry/8Pglx0QGNTqtFDrxLUs4DAqxwzZtvZuuUPZh+oxA
 Xb7w6B0wqvfv5F7fWfj6nKh8oHSVbS0zmADScnvG6nx4gj3kKwMZ7e8f6avGrUErWFfm
 eQdrvZ2HVOOLGnWVD717LxVfDJCZRhfqeQSfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435100; x=1737039900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfz0EfuFckdgq7nOcoBXEQ03BKcQ1akDtlGAjUGj1KM=;
 b=egZ0HlM4GQNwGSEzylocOF35lSb5RjUDNO7saJY6V5y0uY04eVYNnB3HfNLB8HYwDK
 zryunAi/n9E7ybXMbcona36PzzatvWHoKGubxsPaBLdvxkqg/ljVm5yv4iy7njrLWLpv
 b6+YF91RrDQrjMyvhOBlBrerKCHzGmWZgWnZMFPFaYxrZEK2eY/hySLv0ky24/fpS2jL
 HjMh3dyu/fhYP+6Q/wV5h7xNDe9KgBNrn7QinGYepHsHQXwZQCfZtiFGgnQrJE5v90fm
 LFWQzXfmEC6XY/qx0akZCDPZDe5wPmEjVH9lQog3OcoG9Zeb7sJRTng8UTO3hrrH0FPp
 uiEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8/aHsFFfsAF7kCyFLJJMGovqsVoZyUU+5yde/aodNATCJymamIUUUq6kw5ojugIcoYeyonrc=@lists.denx.de
X-Gm-Message-State: AOJu0YzuCsZDC264gm3wCYrzZQnGwqAsIJzbEmG9OX4EAFPZaOQF3d0y
 o39ck2OIS9ZYyGFadWmH0VC1tThzq2At4tghbQXNbnqUNMlPYh7AjS1z3IU48jg=
X-Gm-Gg: ASbGncvTDW5MVRpmzkOqNDcmrWCmO/qXFl6hygBRrAuhc/NKfm/frufiOIugnL+In8N
 k/5ihlxHbAg80aNthCj8yaBb3r19ppxH+HdmJq6yFNgEpiOaRswwx/LAIXnWmptMU6ymCWQguTF
 4OCaP88hQ3CpK7cHmOcK5kIb/7zHWbyl9KR9h9mEM4uaUtxNnFlejWjFE55MlxAiKvneoGQzQ9W
 wQJdO97nV6Lez16xrCSPt6CLf0VTflSZ1xVQ11rnxBiUJ1d6YqUFKk=
X-Google-Smtp-Source: AGHT+IF/lC6wOOmDAwdfIu7u+5lkHAXwkv00RD7ozARoMUijuj0NVio+AfU2K4BDP8S3IGny4VBRAA==
X-Received: by 2002:a05:6214:1d24:b0:6d9:15c3:42c9 with SMTP id
 6a1803df08f44-6dfa3a08d30mr48741406d6.7.1736435098751; 
 Thu, 09 Jan 2025 07:04:58 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e65181bsm207319751cf.7.2025.01.09.07.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:04:57 -0800 (PST)
Date: Thu, 9 Jan 2025 09:04:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
Message-ID: <20250109150454.GT3476@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OQYgYQcYOIj2zO0w"
Content-Disposition: inline
In-Reply-To: <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--OQYgYQcYOIj2zO0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 11/13/24 16:09, Simon Glass wrote:
> > > This is another option to fix sunxi booting with bootstd, which may be
> > > better since it will work for all boards. We can then figure out how =
to
> > > automatically and deterministicaly decide when bootmgr should be used.
> > >
> > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > If this patch is applied, we don't need to drop bootmgr for sunxi
> > >
> > > (no changes since v1)
> > >
> > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > >
> > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > index 23ae1e610ac..095fa74fc60 100644
> > > --- a/boot/bootmeth_efi_mgr.c
> > > +++ b/boot/bootmeth_efi_mgr.c
> > > @@ -14,8 +14,6 @@
> > >   #include <command.h>
> > >   #include <dm.h>
> > >   #include <efi_loader.h>
> > > -#include <efi_variable.h>
> > > -#include <malloc.h>
> > >
> > >   /**
> > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, str=
uct bootflow_iter *iter)
> > >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootfl=
ow *bflow)
> > >   {
> > >       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > -     efi_status_t ret;
> > > -     efi_uintn_t size;
> > > -     u16 *bootorder;
> > >
> > >       if (priv->fake_dev) {
> > >               bflow->state =3D BOOTFLOWST_READY;
> > >               return 0;
> > >       }
> > >
> > > -     ret =3D efi_init_obj_list();
> > > -     if (ret)
> > > -             return log_msg_ret("init", ret);
> > > -
> > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > -     bootorder =3D efi_get_var(u"BootOrder", &efi_global_variable_gu=
id,
> > > -                             &size);
> > > -     if (bootorder) {
> > > -             free(bootorder);
> > > -             bflow->state =3D BOOTFLOWST_READY;
> > > -             return 0;
> > > -     }
> > > +     /* To be implemented */
> >
> > The EFI boot manager can boot based on:
> >
> > * variable BootOrder
> > * variable BootNext
> > * an existing file EFI/BOOT/BOOT<arch>.EFI
> >
> > It obsoletes bootsmeth_efi.
> >
> > >
> > >       return -EINVAL;
> >
> > We must always run the EFI boot manager if it is enabled. So -EINVAL is
> > wrong here.
>=20
> Well, I don't believe you have a solution, then.
>=20
> You did suggest putting bootmgr later, as we discussed on irc.
>=20
> For now, I think we should apply this patch (and series), while we
> sort out how to make bootmgr more incremental. It should not be
> scanning every available device before it starts, since that can be
> very slow.

Heinrich and I talked the other day, and we think the right path is the
"later" path, where we don't try and use efi bootmanager until
everything has been probed, and also drop the single "efi" option. This
should mean that by the time we would be trying efi bootmanager most if
not everything that needs to be probed has been probed. It doesn't make
any sense to have "efi bootmanger" be more incremental as conceptually
it's point is to show the user all the options.

--=20
Tom

--OQYgYQcYOIj2zO0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd/5ZYACgkQFHw5/5Y0
tywaXAv/STKuuBEsHLydFVHom4DU8JV/VLSmnsfi8hpEPkpVGoX/H6WNZfL6PSSx
dPg20miyFrq/U547qd130RBpJOCPyiuLog12wAzBC5taztB1SD6qwa2iTTQUWQ9W
bvkkQwgQwxnreci2iNXduejdOnCREjtd1PrQ0lpVdDBilvH+ff9OmgIKdmR2TBPS
D2niLu8zz5/RHZT79491gNX9N3ImYqvSwGKwRUpmz67q+knBSEoFqq3M/zs3UhF8
F82VnzlwKxx1EAsO2Jg6lfMDsx3E0ScCFPY+k2/RZEk6Ni+ck3OOe3r+kN0Ggi3K
lcP9Aj5FBSDVYYGyiElxrueXptK0jYtiKDT80cZSztEqQN8SiK0U51M5pfIJLz3V
yQVa6E7u7OXh11GlJTguOcW+//Mm0Z+jE4rMFzlx9a/hpckglKVLDN3FqUBU0/BB
P7JhAWhHTbVcZyjOLIKU3faENUjgSjoaO4S3TBtj1VF/5qJXD3SSrWkyKQQEMsqc
LXObReZe
=pBsJ
-----END PGP SIGNATURE-----

--OQYgYQcYOIj2zO0w--
