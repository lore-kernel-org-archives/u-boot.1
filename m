Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC50C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5681180F9C;
	Thu, 13 Mar 2025 17:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B2K5DFs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D6980FF7; Thu, 13 Mar 2025 17:02:41 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6CB80540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47691d82bfbso22232331cf.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741881755; x=1742486555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E2vqljNtB3gCatFOy2vtZvJ7gjyiY2Cgh2apkPNiiZc=;
 b=B2K5DFs57W5aYjaJEHvyMi0QjilQwUqyIc1G7YlRmBpKa8y/53RfFLdCXeyZ/VON8k
 1iZlmyYqva/QqQK1uXJobx3yB+FRackxBDvBurSkzOxk+UUh5+oX34bfVtLRMOhtbxt/
 jx4B/V8Fe5OKGaIJeK3mJb1e0fA012IIbeszc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741881755; x=1742486555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2vqljNtB3gCatFOy2vtZvJ7gjyiY2Cgh2apkPNiiZc=;
 b=fPGBS6xZBC3IckGKg7tkpM58oniSYvkT4gGcvwIdw+MFNjL2JFW6EEp8qmbB9+Hz1t
 Ad1v0wyfp1GpHzqegIWdExpdKu+tWG/AFaj6kY6eq+p+KsrbxjibtCKE1orbl2evLt6W
 k6v9xxYj6mlajVx5NPUuELbIuUTh09x0cTAdPkUO7wx2Z7kiFyvsL9u/52sbAOAZ86fS
 SJK6QO/jU1li8CIy7vCTyqqOsb2H0D+U5Xg9+eWf0vhJdaafybADnQYD8Cb4XhtwzoZk
 W1GErHklCSoFQRtuxzYK81d+eXxCV2Vdi8Bjw1jy9Am3gM9uQHcnNsTt7DMOhdKjWC/3
 sCag==
X-Gm-Message-State: AOJu0Yz5SJpyhPbXyTg9RPNj6ELBqbb1kzGST7VNkuVQPME16zg5cFe6
 7z46R+zTT6v04j8RAcMoDDnJZFXqKMsQDDEAtap5uyAVjQ4sLukSdoSrsQgs8vIsoyCMWraEqSq
 l
X-Gm-Gg: ASbGnctVlz0MqXgIV4gmOllQC9wI9SS0tKMV3Iil1ABhRrLJ8ixCI5bNlSG8L5BGV2k
 kGveNKZnepe9nf7jnMZLUhDu8oYkoEvcjuOp3Rdkmo5WENGc0G+AAH/3b7+IAus6C6KyuvtGtl4
 4vnY3zx8/C6OElL8nhSbSWsqyX+OkwMvrIMdXoC38s7DNA+lN+8glxx7B3GrPUqbnlc5imcufZW
 KoOSL5cLLPpQV6VT9sXGv1ys46+qWI/yQGmGfcmpwygs3jMx2izWSMT6o/rGyUduDedhD2ob0lY
 MxgYYpJ7XhiHLH8h7dfYsSeoqmEHvsU2vhBee0jry9pE+w==
X-Google-Smtp-Source: AGHT+IF+Zi3hqakoNVS0t8B/nEGejwJBJELSk20PCJmMIDghEUvdqvwIe25Os5X2JE7MsY/WUvi7HA==
X-Received: by 2002:a05:622a:5e8a:b0:476:bb8e:a90e with SMTP id
 d75a77b69052e-476bb8eab30mr46376131cf.20.1741881755347; 
 Thu, 13 Mar 2025 09:02:35 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb2f4704sm10864971cf.0.2025.03.13.09.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:02:34 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:02:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] Kbuild: Always use $(PHASE_)
Message-ID: <20250313160231.GA2640854@bill-the-cat>
References: <20250312010021.1671010-1-trini@konsulko.com>
 <82d9ca8e-14e9-45a0-ba09-9101d6264585@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/XyQinPjJfH9kbcK"
Content-Disposition: inline
In-Reply-To: <82d9ca8e-14e9-45a0-ba09-9101d6264585@cherry.de>
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


--/XyQinPjJfH9kbcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:10:28AM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 3/12/25 2:00 AM, Tom Rini wrote:
> > It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
> > Makefiles as part of the macros to determine when to do something in our
> > Makefiles based on what phase of the build we are in. For consistency,
> > bring this down to a single macro and use "$(PHASE_)" only.
> >=20
>=20
> Haven't gone through the whole thing, but caught a typo at the end, see
> below.
>=20
> I assume you did a simple sed here? Or was it more involved than that?

Yes, it was just doing a grep/sed.

> It doesn't seem like any driver has code guards using $(XPL_) so that sho=
uld
> limit the number of fallouts if any.

There were two problems this exposed, I linked to them in the RFC but
not here as they're general fixes.

> [...]
> > diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> > index abc49fbe6c93..43f27874f9fe 100644
> > --- a/scripts/Makefile.xpl
> > +++ b/scripts/Makefile.xpl
> > @@ -58,20 +58,18 @@ endif
> >   export SPL_NAME
> > -ifdef CONFIG_XPL_BUILD
> > -XPL_ :=3D SPL_
> > +ifeq ($(CONFIG_SPL_BUILD),y)
> > +PHASE_ :=3D SPL_
> > +else
> >   ifeq ($(CONFIG_VPL_BUILD),y)
> >   PHASE_ :=3D VPL_
> >   else
> >   ifeq ($(CONFIG_TPL_BUILD),y)
> >   PHASE_ :=3D TPL_
> >   else
> > -PHASE_ :=3D SPL_
> > +PHASE_ :=3D
> >   endif
> >   endif
> > -else
> > -XPL_ :=3D
> > -PHASE_ :=3D
> >   endif
> >   ifeq ($(obj)$(CONFIG_SUPPORT_SPL),spl)
>=20
> Should the same be done in scripts/Kbuild.include ?

Yes, now that you mention it, I had missed it.

> [...]
> > diff --git a/tools/qconfig.py b/tools/qconfig.py
> > index 259adbe1bc9e..544254f6e78f 100755
> > --- a/tools/qconfig.py
> > +++ b/tools/qconfig.py
> > @@ -1220,8 +1220,6 @@ def scan_makefiles(fnames):
> >       >>> RE_MK_CONFIGS.search('CONFIG_FRED').groups()
> >       (None, 'FRED')
> > -    >>> RE_MK_CONFIGS.search('CONFIG_$(XPL_)MARY').groups()
> > -    ('$(XPL_)', 'MARY')
>=20
> Can we update RE_MK_CONFIGS re as well to remove \$\(XPL_\) from it? No c=
lue
> if applicable, just stumbled upon it and wondered.

Likely so, I'll look at that part before posting v3.

> >       >>> RE_MK_CONFIGS.search('CONFIG_$(PHASE_)MARY').groups()
> >       ('$(PHASE_)', 'MARY')
> >       """
> > @@ -1321,7 +1319,7 @@ def do_scan_source(path, do_update):
> >               spl_mode (int): If MODE_SPL, look at source code which im=
plies
> >                   an xPL_ option, but for which there is none;
> >                   for MOD_PROPER, look at source code which implies a P=
roper
> > -                option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
> > +                option (i.e. use of CONFIG_IS_ENABLED() or $(PHASE_) or
> >                   $(PHASE_) but for which there none;
>=20
> You can remove one of the "or $(PHASE_)" here.

Oh hah. I did review this change a bit more manually than the rest
(hence the first part being a remove, the 'sed' just made it check
PHASE_ twice) and missed this, thanks.

--=20
Tom

--/XyQinPjJfH9kbcK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTAZAACgkQFHw5/5Y0
tyxyUgv+KpqUQgbXlJTl3K30V2pnQ4aFs1BrnjGqZ1rIKu6iiqJYTQrW00ybBxC4
eKhPyR8NznFRlGF+vau2CDgOJ/g3vHtpSzAdxgqXtw8D37LPl5KDp7G5iABN7x/Z
LnoP8DSlY3pXHUNcb8lRc/tUKDUfCEO7xCUm1auC6vuNaDu+975DfH7KE97oMtvm
AMel7zIczl4CIXR74LuQgR0TAg9sczvx3jK6GeaFc6PLxu1kaGV024X/yom51AzU
5fYsNE0s/Qat3/YzsPGXBOoZhPxZ4F8uyTpzf6iR9gLQpw/wGwks72RR3dofyT2h
XvMZubrVTahaaGQLOBTTwBpD8/hzGFB1vGzQY276lCqpZsiRlGTaGFQSuhyYKm8u
E8FON6k/+9ObBpddIXjEmgk5Ps0LzZu6K/2/ecUnzCdQGOxYnElm5faMIdS3pA8A
zb+2hSQB02vUs51NUozDDQoIYL6ORprcaSd+d1fcI8gINlhC25ZZs3+AFwGkuj6d
w0FFngIU
=icCc
-----END PGP SIGNATURE-----

--/XyQinPjJfH9kbcK--
