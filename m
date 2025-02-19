Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF3C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB65800B3;
	Wed, 19 Feb 2025 01:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YaVttClj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C83800D7; Wed, 19 Feb 2025 01:19:56 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5001A80077
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220d39a5627so89948995ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739924393; x=1740529193; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VdSCDz2paS7DfP45wPXv5Bh1/4VlqYcQRyNRDpnd3+8=;
 b=YaVttCljnXaD0hWAU/YEDALfJ9PjXsTXtgj1oi5SY+bFNN6ECZju+alA8mQUG0hCmB
 jTwRgn1ntc5QdB9WpudLpR4UK948MTPNkqe7WxuFFu9KpVEtUXa+jkd4sep4kxZ1xWts
 JVOAQLuQ/cVIq0J5LqqRTd5Xxs8Go6SmhvcLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739924393; x=1740529193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdSCDz2paS7DfP45wPXv5Bh1/4VlqYcQRyNRDpnd3+8=;
 b=bcT0bJrLouon193VzgeZoIOLWcJlN1z7Zf4WrfbssolzBoesd7v15gw9nwhgsqqCF1
 PNy+9+zbEzPjZUjFTLj9w+v4MDDwhU4anmQq8ScL/f/+ZkIzgmwL8pgaY7Fzwr19/nA9
 fgL3isnGN4j0lkzFGX6gs5m65C6sal8P0t/59UsELv5ws53TVwM8WYZ3rR+D8X6kdhCJ
 lQoK12RbLCcNvxGMhBYKbDLAF0wNvqzojXIoecumKfY4ksqlOqoBFt70oDhLlDzjuV2E
 PeNIkLF7uljVu1+MbJ6/A9RLSmvXTUeXl4kour7JwbTlBg3YNHDJ0TvxNCQ7W78/FCLQ
 qRGA==
X-Gm-Message-State: AOJu0YzWkGnufWDABCU2S/f/FJpXTw8EDWLHNJ3HZbnF3f+VhINzAmn8
 /Z6SQPlfnF4HLa+cADE19yberhIbDLy3Tte0y6RD2fanwCTvJYJdIYZNXnaN6E8=
X-Gm-Gg: ASbGncs48jUdFicMIeL0plWoL6+7ahXtqFHqsM2/s95ww16h7CCk4Ljv0XkAZ4Zg+md
 KfQhv79kxfJiRJqaL2IzdY5TPruhzOK8ejiMEx6hIrb3Wu+AFxQ43DuV/KBooeKGSLNDZpXB7SJ
 JXa9NYzw8f7W0Egg4Oa8FXfFWZ7kaZqC+Dwyyd1QHqVZJ/Svr0/RwIhGLFzRzeauqsoJ+HHpLfD
 d+WBTsAlxjoQgBMlVdBoWvBQsi8LH4ZdgmLbWF1eVxQCyc4N+VqSfFDSvYffiz4zfqI7qM6+Cet
 c/ea8vQezTbRUA==
X-Google-Smtp-Source: AGHT+IG3hxTT5zeGOz7UN4ltQV7nFgU5wz47fhKxWFwbRdGRfbGJQpd2w9u5no3dMcHnqHLKN83jlA==
X-Received: by 2002:a05:6a21:6da7:b0:1ee:5d05:a18f with SMTP id
 adf61e73a8af0-1ee8cc25a7cmr29787360637.35.1739924392642; 
 Tue, 18 Feb 2025 16:19:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732814ebb76sm4351692b3a.141.2025.02.18.16.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 16:19:51 -0800 (PST)
Date: Tue, 18 Feb 2025 18:19:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH RFC] binman: Handle some newer pylint warnings
Message-ID: <20250219001949.GO1233568@bill-the-cat>
References: <20250212222259.684336-1-trini@konsulko.com>
 <20250218192524.GH1233568@bill-the-cat>
 <CAFLszTgErKoqM1t+WrguW1hpMpQdeF=CmZ7RqVeYEYNUiquaJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9/JEeUmsQwYB3F7"
Content-Disposition: inline
In-Reply-To: <CAFLszTgErKoqM1t+WrguW1hpMpQdeF=CmZ7RqVeYEYNUiquaJg@mail.gmail.com>
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


--j9/JEeUmsQwYB3F7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:04:18PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 12:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 04:22:59PM -0600, Tom Rini wrote:
> >
> > > With a newer pylint we have a few warnings show up now that are harder
> > > to handle. The first problem is that when we call self.Raise(...) this
> > > is no longer enough to have pylint see that we're now bailing out and
> > > won't attempt to reference an unassigned variable. This is all of the
> > > pylint disabling, with the exception of _AddNode.
> > >
> > > The problem with _AddNode is that before we call this function we set
> > > fsw as libfdt.FdtSw() and I'm unsure how best to rework the code.
> > >
> > > The final problem is in CheckSetHashValue() where the function only
> > > handles one algorithm but the intention is to handle others as well.
> > > Once another algorithm is added and then also error handling for no
> > > algorithm is added, we would not attempt to use data before it's been
> > > assigned.
> > >
> > > As I'm not confident all of these are the right way to handle the
> > > problem I've marked this as RFC and not split the changes up more.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  tools/binman/etype/fdtmap.py       | 1 +
> > >  tools/binman/etype/image_header.py | 1 +
> > >  tools/binman/etype/pre_load.py     | 1 +
> > >  tools/binman/etype/x509_cert.py    | 1 +
> > >  tools/binman/ftest.py              | 1 +
> > >  tools/binman/state.py              | 4 ++--
> > >  6 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap=
=2Epy
> > > index f1f6217940f2..a2b0d27fcc5f 100644
> > > --- a/tools/binman/etype/fdtmap.py
> > > +++ b/tools/binman/etype/fdtmap.py
> > > @@ -109,6 +109,7 @@ class Entry_fdtmap(Entry):
> > >          def _AddNode(node):
> > >              """Add a node to the FDT map"""
> > >              for pname, prop in node.props.items():
> > > +                # pylint: disable=3Dlocally-disabled, possibly-used-=
before-assignment
> > >                  fsw.property(pname, prop.bytes)
> > >              for subnode in node.subnodes:
> > >                  with fsw.add_node(subnode.name):
> > > diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/=
image_header.py
> > > index 240118849580..6d8db9eed564 100644
> > > --- a/tools/binman/etype/image_header.py
> > > +++ b/tools/binman/etype/image_header.py
> > > @@ -72,6 +72,7 @@ class Entry_image_header(Entry):
> > >              image_size =3D self.section.GetImageSize() or 0
> > >              base =3D (0 if self.location !=3D 'end' else image_size)
> > >              offset =3D (image_pos - base) & 0xffffffff
> > > +        # pylint: disable=3Dlocally-disabled, possibly-used-before-a=
ssignment
> > >          data =3D IMAGE_HEADER_MAGIC + struct.pack('<I', offset)
> > >          return data
> > >
> > > diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_=
load.py
> > > index 2e4c72359ff3..e2615e1c7d1b 100644
> > > --- a/tools/binman/etype/pre_load.py
> > > +++ b/tools/binman/etype/pre_load.py
> > > @@ -122,6 +122,7 @@ class Entry_pre_load(Entry_collection):
> > >          else:
> > >              self.Raise(padding_name + " is not supported")
> > >
> > > +        # pylint: disable=3Dlocally-disabled, possibly-used-before-a=
ssignment
> > >          sig =3D padding.new(key, **padding_args).sign(hash_image)
> > >
> > >          hash_sig =3D SHA256.new()
> > > diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x50=
9_cert.py
> > > index 29630d1b86c8..15d0766051c2 100644
> > > --- a/tools/binman/etype/x509_cert.py
> > > +++ b/tools/binman/etype/x509_cert.py
> > > @@ -141,6 +141,7 @@ class Entry_x509_cert(Entry_collection):
> > >                  dm_data_ext_boot_block=3Dself.dm_data_ext_boot_block,
> > >                  bootcore_opts=3Dself.bootcore_opts
> > >              )
> > > +        # pylint: disable=3Dlocally-disabled, possibly-used-before-a=
ssignment
> > >          if stdout is not None:
> > >              data =3D tools.read_file(output_fname)
> > >          else:
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > index a553ca9e5642..b6e58decb008 100644
> > > --- a/tools/binman/ftest.py
> > > +++ b/tools/binman/ftest.py
> > > @@ -6387,6 +6387,7 @@ fdt         fdtmap                Extract the d=
evicetree blob from the fdtmap
> > >                      expect_val =3D entry.image_pos
> > >                  elif prop_name =3D=3D 'size':
> > >                      expect_val =3D entry.size
> > > +                # pylint: disable=3Dlocally-disabled, possibly-used-=
before-assignment
> > >                  self.assertEqual(expect_val, val)
> > >
> > >      def testSymbolsElfBad(self):
> > > diff --git a/tools/binman/state.py b/tools/binman/state.py
> > > index 45bae40c525a..ca3f857f1943 100644
> > > --- a/tools/binman/state.py
> > > +++ b/tools/binman/state.py
> > > @@ -410,8 +410,8 @@ def CheckSetHashValue(node, get_data_func):
> > >              m =3D hashlib.sha256()
> > >              m.update(get_data_func())
> > >              data =3D m.digest()
> > > -        for n in GetUpdateNodes(hash_node):
> > > -            n.SetData('value', data)
> > > +            for n in GetUpdateNodes(hash_node):
> > > +                n.SetData('value', data)
> > >
> > >  def SetAllowEntryExpansion(allow):
> > >      """Set whether post-pack expansion of entries is allowed
> >
> > Any thoughts on this Simon? Moving to a newer Ubuntu host for CI is
> > blocked on moving to a newer pylint. Thanks.
>=20
> There is no need to disable these warnings so far as I can tell and it
> sets a bad precedent. We should just fix the code. I can send a patch
> for this if you like?

Yes, if you can fix the code please do as I don't see how to and they
need to be disabled for pylint_err to pass with current pylint versions,
thanks!

--=20
Tom

--j9/JEeUmsQwYB3F7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1I6IACgkQFHw5/5Y0
tyzb6gv+I6KjHuKzHjx3dmeEVbrxSxnGT1m/7D0HU6w3jBi7BCMlS3FQgRk9Fr9g
2N/I8iBgOdTjT4Z7FEVfDK7QhSQ9NHQApkopcplE0LJhSZfbCmAFc1i7KLGQSvoa
1jcHLbyZ8skgWLUfrjD1GLb4MjKIGpuxcCp9QK/oy9Rcj4U9vpe636vRgfn2ELWI
0GevCGJJhnuGnL909aclb7Y46CGK1RnAe++xq+czgmikU87t/CO3FPxjIn5SBgbY
wDpzzYnrvwkx1fNx6W1XtJQ01XXJ5bYkd8MQ3JmEAVVVS132BIBTZYhcFoAEBN5u
2xLxIzjGN5WmM8jxSoUBXy4rdMEpUHD32l17yaoN/wGLYS6a2O3eBi77+5dBlARY
y9AC2b31hEq2Q0q08uBI7ftD78+MUFuP0W09EsiDXGWG5EAru8lxPvfD1yEUknFd
r8TfahTslpe9VYp66q7ArJ64eIwFChIW1j8pfjxo03BgsU1Q3kiLuMea2qF9RLGe
gq08czlw
=mqT8
-----END PGP SIGNATURE-----

--j9/JEeUmsQwYB3F7--
