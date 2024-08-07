Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA4FC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3466988B61;
	Wed,  7 Aug 2024 03:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WZZCKYYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEA088B58; Wed,  7 Aug 2024 03:56:30 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EBC889D2
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db35ec5688so736823b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722995777; x=1723600577; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RoJUkjsOb1e5fS1aRes+Aw7QC5hAPAZty+0FNmzfzQE=;
 b=WZZCKYYjrEuFrkfGPHhsPKBPpGcJt5P4HVY0gq5UoFDlB9iwOVJ4lg6BPysV/T1iuK
 az/IkXN1Za9+5/0u4OMGsnJOpXopW6IzYKXCJ2tCvI/ZFd/d0mTOEl+yvyLNxz/qAXtj
 VxrxKq+eynhm6Rbhy39/yKSe+Q5PRAWSA94Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722995777; x=1723600577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoJUkjsOb1e5fS1aRes+Aw7QC5hAPAZty+0FNmzfzQE=;
 b=OgQr4WZcpAtPJSt5H7u9U3KFVTcdYtw/QfBX2lowfYAL0WoocLRJOJ8uXMbPvzr5ea
 i7RAWKeRym9+7hWliARCoAMKeuQZ2omNCow0n/9NMNFnOVUb99H9K6OFdxCgbKru2YXu
 1zvPDq8oqkz8EPxQYjuEEXRW19m58eSg5lNWbVNPZozzEiCMvAWJYvrhOmCWdQydXNN7
 dhyMRiV8J5a+TqE1NlxjH4MgxY++jFDvy3JiZhb3IB2jpDxa0R0bBVnj/i7Sdy3yHHH5
 HnkncM7Y/BcmWJQ+JrpkgRS3mx5+6/6RmOHKaBuZ4pZFY6Us2N8y36JzvRzk4cp94d1b
 c59g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxdjKS6Bp09pF1iQ2oTA20LYyGYJAGFLnl08bKRhjCz1EAP44G/gDd896JQt0DdRVCtDZT3sHGIyRpRLJ+IoSsGA+L4g==
X-Gm-Message-State: AOJu0Ywz8j9JcvRE8Kovqfg/4QYEzr9UorbqvZzmnNMfcYPMXiynuPGu
 /pteNeuVTe2dlkx/L3cwuDbsYJg4rnAodu5jTl6C3Y7IkBEpOOJwVaSvq9WadvSMm0Z5E9BPzUj
 E
X-Google-Smtp-Source: AGHT+IFQ1gDaqRPzEqy+WSzdhjcObrEPNPZn6e08U+rjF+Gi0avgNq5rxgMlQg389iiPvU1VIEnj2w==
X-Received: by 2002:a05:6808:189a:b0:3db:5656:f67a with SMTP id
 5614622812f47-3db5656f847mr20970436b6e.17.1722995777061; 
 Tue, 06 Aug 2024 18:56:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361b99sm3857928b6e.11.2024.08.06.18.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 18:56:16 -0700 (PDT)
Date: Tue, 6 Aug 2024 19:56:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Message-ID: <20240807015613.GD1626301@bill-the-cat>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6y8zuQaVv/fxXpoM"
Content-Disposition: inline
In-Reply-To: <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
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


--6y8zuQaVv/fxXpoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt wrote:
> On 06.08.24 14:58, Simon Glass wrote:
> > While sandbox supports virtio it cannot support actually using the block
> > devices to read files, since there is nothing on the other end of the
> > 'virtqueue'.
> >=20
> > A recent change makes EFI probe all block devices, whether used or not.
> > This is apparently required by EFI, although it violates U-Boot's
> > lazy-init principle.
> >=20
> > We cannot just drop the virtio devices as they are used in sandbox test=
s.
> >=20
> > So for now just add a special case to work around this.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> > (no changes since v1)
> >=20
> >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 93a9a5ac025..2e1d37848fc 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_ha=
ndle_t handle, char *buf, int
> >   efi_status_t efi_disks_register(void)
> >   {
> >   	struct udevice *dev;
> > +	struct uclass *uc;
> >=20
> > -	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > +	uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > +		/*
> > +		 * The virtio block-device hangs on sandbox when accessed since
> > +		 * there is nothing listening to the mailbox
> > +		 */
> > +		if (IS_ENABLED(CONFIG_SANDBOX)) {
> > +			struct blk_desc *desc =3D dev_get_uclass_plat(dev);
> > +
> > +			if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> > +				continue;
>=20
> We should avoid depending on the sandbox everywhere.
>=20
> Please, fix the problem in the sandbox driver.
>=20
> If you cannot fix it, run the tests involving virtio on QEMU instead of
> the sandbox.

This is an area we go back-and-forth on but, yes, IMHO, if we can't
easily provide a virtio device for sandbox, QEMU is right there and what
this is for, so I see sandbox as more useful as build rather than
runtime checking in this case.

--=20
Tom

--6y8zuQaVv/fxXpoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmay1DoACgkQFHw5/5Y0
tyyjbgwArqBGj7oiQZJhxBz1zN+doXCnO47lq0iVH9ygvtvSyXD53yccNHCpeSdg
TJIb+6x9ed+RtFRzFJJEtQKzxugEH9obSgYSsJYfGuM8sVtH/kwn80jQ2v2NewIB
OeOQHaMKCT8oWSaTS20wlJtEWIdOLpK8SzXRXs+qUArpXUhkuWmxyjY1dLomfWLB
0beVQcXnTpGjDStCJxLCONwE/N/P37dcXwXezqDDh5MOjCuZI8hTenLLpHq84nAT
Hrgu0/zb7GCfCATcaSdCIdgEk+RWPQkBmDDtz8hiSfkoDE11qa2mtaJsSNGNB066
sBRx5V9H4z94TzigRljb/clNDavUKUyfEsJ92ep/XdOIRK43UNY7QU5dUubAslXM
Uy7zzj6nCUtaFD4NETkF9JR5AQgV0szphRi4By2ORzyXQU92QwOQKSokDCyHdkyS
Ot4nLJCMBkKejDNYOcop78DwHOzjey6LNVE8M3kQCR2mOzt2yK7Yi6BAz7jybbto
fzQ5Su4Y
=CC5C
-----END PGP SIGNATURE-----

--6y8zuQaVv/fxXpoM--
