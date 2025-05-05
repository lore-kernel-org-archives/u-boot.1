Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF610C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5766C82982;
	Mon,  5 May 2025 15:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hOKXCKX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F274829EF; Mon,  5 May 2025 15:46:05 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A15082A2F
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c09f8369cso1356653a34.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746452760; x=1747057560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VifmXz5p/z+BxcWYvuKGZiKTPrMDTrzFi+BRR8J0mLU=;
 b=hOKXCKX+ChBJ/mrsNIdEVXIC5uO86LtbKgNqwS5KSVwp7QtZZcivFyIUVe0r+vPd6q
 R+wZFCkmNiEnenceaI1iEnLy5hJH2yDJ5g+7QbwBPUL7cwNAGPCbFn+Mf/T4HId7+UVQ
 UGu63uMFasZSZB8bXL/sBtU7PB+tsz+ujF0qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452760; x=1747057560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VifmXz5p/z+BxcWYvuKGZiKTPrMDTrzFi+BRR8J0mLU=;
 b=K8alH45bdR0Yb8IPddivZsZtFYXrdfTaTqyiWINVvEsXsoKlldnNkmtn9pV5dP4Nc5
 GU7ACB6kRRzYhHdQt5GMiBx73q0eyOAn5CEwa7zpJnwlBRAXCRQSsJfDL82GjrXEcROv
 KDqZQxKgY3g3zTr5D8XWQB+zup5/11474kdZ0BjKVPg9ujrgX6XuIqzr7/qK8yG3gmlS
 +36MfD4s9+pEDBq5H9JRm0iuJRynJRWgVebCRavtCsntMTxOEwWpLdpAdJkdX+hb+n7a
 fNVNB8p2UV4H9XVU5b57FBbeGZf9qPX6Cnqcf65SiO+Vs8yfzXIBq0WYdq4pbjQyWfnr
 Br8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVynQv7R5utPkoEKAB7WnwsVAt3u0gj+359RDSwXO+o1lBTVnk5dxb+jBq/io0lRh/idEL+SLU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6j1t5Zq64d5lQMI8nb/OP3boupoz5GMDDOzpZqPgRN+W0ju+y
 A6vlB70TRZsZgmUsKBhu+fBExG+iqWhnd7NQ9XFIuGmWd5i5tjxJ7N12iOEkaq4=
X-Gm-Gg: ASbGncuLT1ebSEZ7p6+m7U/rJU48DueexZZ5VH3ISeIcG6PfZDK/VT3uv8QX4m/Di26
 fjQOo1Ia8hin4W/2mIY7ImjYpv5oziTU//R8uL+wao+jJ6u+mYaenVovsJilHIpjpsBcslQpwE0
 DZH/VAYkI6V7Lxhd5SvRxOn05hxRnf/8tQFtOPpBw/7WRT+a8pcnQ+21gHSzLJkeDyCQh2Ttm1m
 01N73mBY4GePzk+uVpD85JiUdK3MUHfGINB7oi6/ZjLzQ45H52F4YFUtxLyuLGG+znpdliZhOxY
 iwvpd3V/T/NAejpzecHxpry4LtRQuZY4EnIrg+YRKe+A59Rsu4zAF5Wefj0YWkJn161tYw92s4K
 kXQ==
X-Google-Smtp-Source: AGHT+IGppz6zBhlR0t7JDapwFPoJwR0MOpLx82Sx0PZfMkYIvghC3bCg5+dzyCQU4m9NXXuw3TID5g==
X-Received: by 2002:a05:6830:648b:b0:727:3664:ca25 with SMTP id
 46e09a7af769-731e53e5813mr6586914a34.0.1746452760299; 
 Mon, 05 May 2025 06:46:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31cad40sm1509429a34.26.2025.05.05.06.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:45:59 -0700 (PDT)
Date: Mon, 5 May 2025 07:45:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] test: allow multiple config options in buildconfigspec
Message-ID: <20250505134557.GJ1261075@bill-the-cat>
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
 <CAFLszThvh+fzrDoODdj7kYqVKXkL6xvAFcz8biOh3c-LaD2CFw@mail.gmail.com>
 <CAM=mAOkNo=kuNNo9fDEfUNOXSE5cQc3zhx54BAWNy--tt1u3Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="osiqlqDOchzpkFiN"
Content-Disposition: inline
In-Reply-To: <CAM=mAOkNo=kuNNo9fDEfUNOXSE5cQc3zhx54BAWNy--tt1u3Lw@mail.gmail.com>
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


--osiqlqDOchzpkFiN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2025 at 07:27:43AM +0200, Heinrich Schuchardt wrote:
> Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 23:27:
>=20
> > Hi Heinrich,
> >
> > On Sat, 3 May 2025 at 07:32, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > In some cases we have alternative configuration options that supply t=
he
> > > same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.
> > >
> > > Allow to specify all of them as arguments for buildconfigspec() and
> > execute
> > > the text if any of these is fulfilled, e.g.
> > >
> > >     @pytest.mark.buildconfigspec('net', 'net_lwip')
> > >
> > > Update the documentation.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >  doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
> > >  test/py/conftest.py        | 10 +++++++---
> > >  2 files changed, 31 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> > > index 217ae447035..7dbed8833bf 100644
> > > --- a/doc/develop/py_testing.rst
> > > +++ b/doc/develop/py_testing.rst
> > > @@ -514,3 +514,27 @@ of the `ubman.config` object, for example
> > >  Build configuration values (from `.config`) may be accessed via the
> > dictionary
> > >  `ubman.config.buildconfig`, with keys equal to the Kconfig variable
> > >  names.
> > > +
> > > +A required configuration setting can be defined via a buildconfigspe=
c()
> > > +annotation. The name of the configuration option is specified in low=
er
> > case. The
> > > +following annotation for a test requires CONFIG_EFI_LOADER=3Dy:
> > > +
> > > +.. code-block:: python
> > > +
> > > +    @pytest.mark.buildconfigspec('efi_loader')
> > > +
> > > +Sometimes multiple configuration option supply the same functionalit=
y.
> > If
> > > +multiple arguments are passed to buildconfigspec(), only one of the
> > > +configuration options needs to be set. The following annotation
> > requires that
> > > +either of CONFIG_NET or CONFIG_NET_LWIP is set:
> > > +
> > > +.. code-block:: python
> > > +
> > > +    @pytest.mark.buildconfigspec('net', 'net lwip')
> > > +
> > > +The notbuildconfigspec() annotation can be used to require a
> > configuration
> > > +option not to be set. The following annotation requires CONFIG_RISCV=
=3Dn:
> > > +
> > > +.. code-block:: python
> > > +
> > > +    @pytest.mark.notbuildconfigspec('riscv')
> > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > index 5aea85647af..6c3ac67979a 100644
> > > --- a/test/py/conftest.py
> > > +++ b/test/py/conftest.py
> > > @@ -711,9 +711,13 @@ def setup_buildconfigspec(item):
> > >      """
> > >
> > >      for options in item.iter_markers('buildconfigspec'):
> > > -        option =3D options.args[0]
> > > -        if not ubconfig.buildconfig.get('config_' + option.lower(),
> > None):
> > > -            pytest.skip('.config feature "%s" not enabled' %
> > option.lower())
> > > +        nomatch =3D True
> > > +        for arg in options.args:
> > > +            if ubconfig.buildconfig.get('config_' + arg.lower(), Non=
e):
> > > +                nomatch =3D False
> > > +        if nomatch:
> > > +            argsString =3D ', '.join(options.args)
> > > +            pytest.skip(f'.config features "{argsString}" not enable=
d')
> > >      for options in item.iter_markers('notbuildconfigspec'):
> > >          option =3D options.args[0]
> > >          if ubconfig.buildconfig.get('config_' + option.lower(), None=
):
> > > --
> > > 2.48.1
> > >
> >
> > I ran into this problem too. Would it be possible to have CONFIG_NET
> > mean that we have networking (either option) and CONFIG_LWIP mean that
> > it is lwip? The current Kconfig seems a bit broken to me....
> >
> > Regards,
> > Simon
> >
>=20
> Hello Simon,
>=20
> Yes, we can think about reworking the network configuration in a future
> series.
>=20
> E.g. have as choice
>=20
> * CONFIG_NET_LEGACY
> * CONFIG_NET_LWIP
> * CONFIG_NET_NONE
>=20
> and CONFIG_NET :=3D !CONFIG_NONE

Just note that it's non-trivial to reach that state correctly, which is
why we don't have it today (some of the challenges and problems are
documented in earlier iterations of the lwIP patchset itself which did
try going down this path).

--=20
Tom

--osiqlqDOchzpkFiN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYwRUACgkQFHw5/5Y0
tyzu4gv8Dtk2oNbnNBkAk1t5MhZX2hsXguQ0RAB+OoS+iTV7B84MnNfthH5Y01mD
7O4vYdQbqS8rHs7cJx3ayQyJ061udOH6rCGwZWjLkmKul+DAKpQe3OWANcCv0NtT
d5S4OcO1BbwCZWuOfjIF+IrAEYxH0am4lZ30e4+yJ8vmSYGYDB2BOg+F9ZLsmQpK
D4xIxkp/1Hcd9xAY8CicumfgFlwkAblxgaDNF1EvgH6NMUugWhrHZH3661+eeMQz
gLyWE9+XwoNe+66AP1XbFLMp25v/P1eQzIxiFJFL20Sxsjh1wCp9pViif5ajoh4v
Gj13Wl/nt4PDMADujV0I3qXk9HaMNBagBlluNfKr+KW0xCIAS7sR2XxBKYzsQk5q
lYzUA/w5htrj8MSNFr3TbZOH9UtEgsgumpnCK17f2T/X+uPhbc7plAPJD4wcNSBo
P9aeI+JoKjbFlmbh4pyDIG+8XQ1aUAgy2v4GwW9hc/j9hZzk+cxOmOC9gHTC+ErJ
iOw3iY8n
=pIL1
-----END PGP SIGNATURE-----

--osiqlqDOchzpkFiN--
