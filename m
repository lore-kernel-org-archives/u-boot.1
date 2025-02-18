Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B502C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4880E80BA8;
	Tue, 18 Feb 2025 20:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IzXGBHss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C283580BAE; Tue, 18 Feb 2025 20:25:32 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6FC80ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220d28c215eso85981295ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739906728; x=1740511528; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G8hcBNrJ/++GymDE8yU4fxX2LEfLh8sDUjVxxLeQPz0=;
 b=IzXGBHssRh+tmGQyEErBO3tpCaDsSvKSjZQJv+euhGX7fT+h4nSc/4lcsICAc3VN7B
 NdUA9uqEdtbz61VRmXiXccWgIZoqyGwl351GERY2bXKfcpuGQIL2vdqRjiIXf/zzjRt8
 3d+Evz9UMtZ3SZObxUIcZUnqn3mWmLAiGo5aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739906728; x=1740511528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8hcBNrJ/++GymDE8yU4fxX2LEfLh8sDUjVxxLeQPz0=;
 b=kArpnwMwzr8CYBxhiQed13p/z5S8gGdY2j4jt1+Oy4qxz38vHJjrwk9funUkLnI71X
 8HpKriNeK8mWM7LR5vl+5Ua/vbaDPz3fZBHORQJROzLlD/ktpqTdDJQixnOse6FgqETB
 5ZxK5Ht+eMiNNnLTW9qAGgR+WPZliJXHZJNEFV5wX/ZKkHsrgAAcVPiZFp4Vc9qsvd9T
 SCnSNCcnG7X630k3p8nLbcotaKZfNBCMM0bZt1DzRvtHpfQLemeYbFphUm54+wou4vt8
 dRB2v/R5JPtKk87V622IzrascbfgjGVcrErRkR7AYBwhQAgSjA+BJ2PyhudZKBA/OPG8
 D4Fg==
X-Gm-Message-State: AOJu0Ywlx42EmKXgqJgJ/VcDdIIjxRHtrCAEiL962Ce4h6zNVoDPc7Uf
 V8boOvvoMD1HJQ5hx56pEbrgSpJbutkomI0FZJC55QJ3FzedfAzdBkr8ZANFcvki2QfnnLSM/Kx
 s
X-Gm-Gg: ASbGnctZH2XB9IEblMAUub0lcI9uxFquhzz3h3SSEJPurl2fvdvQ1m9R15cvczpKeis
 8KkAqrXDDKM/OcrD1Pz0ee7j+J41ny/R/yFqaHPx82dzralGQArS9CZ+RiDKd6DflL/kki9BII5
 z/Tff8xwcCsz8gai85n/svjnwqLPAH07IceJ+eQNV4K0o5TAxDj2IaDJ4U2c3VMiHqJ7SYyGvr3
 FnhZNztLLu6pkZcU7lXG5yxN++CnIrvqSbfurL8a6pdCa8pp3UZrx47+1N0LF2pXWKRLqVcDW7y
 ujbkxR1l2F5yrA==
X-Google-Smtp-Source: AGHT+IGYyX+KG8JaP0B4/7ZxAEFWY1OHHm+mHTHFgaCFfGdM8cwKPfwZGuA5wVupVKK3bZ7PhLK/5g==
X-Received: by 2002:a17:902:ce0d:b0:21f:61a5:67a5 with SMTP id
 d9443c01a7336-221040b1342mr242744625ad.42.1739906728114; 
 Tue, 18 Feb 2025 11:25:28 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d43dsm93105365ad.158.2025.02.18.11.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:25:27 -0800 (PST)
Date: Tue, 18 Feb 2025 13:25:24 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RFC] binman: Handle some newer pylint warnings
Message-ID: <20250218192524.GH1233568@bill-the-cat>
References: <20250212222259.684336-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8aeIh1yatfe8PHk6"
Content-Disposition: inline
In-Reply-To: <20250212222259.684336-1-trini@konsulko.com>
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


--8aeIh1yatfe8PHk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 04:22:59PM -0600, Tom Rini wrote:

> With a newer pylint we have a few warnings show up now that are harder
> to handle. The first problem is that when we call self.Raise(...) this
> is no longer enough to have pylint see that we're now bailing out and
> won't attempt to reference an unassigned variable. This is all of the
> pylint disabling, with the exception of _AddNode.
>=20
> The problem with _AddNode is that before we call this function we set
> fsw as libfdt.FdtSw() and I'm unsure how best to rework the code.
>=20
> The final problem is in CheckSetHashValue() where the function only
> handles one algorithm but the intention is to handle others as well.
> Once another algorithm is added and then also error handling for no
> algorithm is added, we would not attempt to use data before it's been
> assigned.
>=20
> As I'm not confident all of these are the right way to handle the
> problem I've marked this as RFC and not split the changes up more.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  tools/binman/etype/fdtmap.py       | 1 +
>  tools/binman/etype/image_header.py | 1 +
>  tools/binman/etype/pre_load.py     | 1 +
>  tools/binman/etype/x509_cert.py    | 1 +
>  tools/binman/ftest.py              | 1 +
>  tools/binman/state.py              | 4 ++--
>  6 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
> index f1f6217940f2..a2b0d27fcc5f 100644
> --- a/tools/binman/etype/fdtmap.py
> +++ b/tools/binman/etype/fdtmap.py
> @@ -109,6 +109,7 @@ class Entry_fdtmap(Entry):
>          def _AddNode(node):
>              """Add a node to the FDT map"""
>              for pname, prop in node.props.items():
> +                # pylint: disable=3Dlocally-disabled, possibly-used-befo=
re-assignment
>                  fsw.property(pname, prop.bytes)
>              for subnode in node.subnodes:
>                  with fsw.add_node(subnode.name):
> diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/imag=
e_header.py
> index 240118849580..6d8db9eed564 100644
> --- a/tools/binman/etype/image_header.py
> +++ b/tools/binman/etype/image_header.py
> @@ -72,6 +72,7 @@ class Entry_image_header(Entry):
>              image_size =3D self.section.GetImageSize() or 0
>              base =3D (0 if self.location !=3D 'end' else image_size)
>              offset =3D (image_pos - base) & 0xffffffff
> +        # pylint: disable=3Dlocally-disabled, possibly-used-before-assig=
nment
>          data =3D IMAGE_HEADER_MAGIC + struct.pack('<I', offset)
>          return data
> =20
> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load=
=2Epy
> index 2e4c72359ff3..e2615e1c7d1b 100644
> --- a/tools/binman/etype/pre_load.py
> +++ b/tools/binman/etype/pre_load.py
> @@ -122,6 +122,7 @@ class Entry_pre_load(Entry_collection):
>          else:
>              self.Raise(padding_name + " is not supported")
> =20
> +        # pylint: disable=3Dlocally-disabled, possibly-used-before-assig=
nment
>          sig =3D padding.new(key, **padding_args).sign(hash_image)
> =20
>          hash_sig =3D SHA256.new()
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_ce=
rt.py
> index 29630d1b86c8..15d0766051c2 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -141,6 +141,7 @@ class Entry_x509_cert(Entry_collection):
>                  dm_data_ext_boot_block=3Dself.dm_data_ext_boot_block,
>                  bootcore_opts=3Dself.bootcore_opts
>              )
> +        # pylint: disable=3Dlocally-disabled, possibly-used-before-assig=
nment
>          if stdout is not None:
>              data =3D tools.read_file(output_fname)
>          else:
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a553ca9e5642..b6e58decb008 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -6387,6 +6387,7 @@ fdt         fdtmap                Extract the devic=
etree blob from the fdtmap
>                      expect_val =3D entry.image_pos
>                  elif prop_name =3D=3D 'size':
>                      expect_val =3D entry.size
> +                # pylint: disable=3Dlocally-disabled, possibly-used-befo=
re-assignment
>                  self.assertEqual(expect_val, val)
> =20
>      def testSymbolsElfBad(self):
> diff --git a/tools/binman/state.py b/tools/binman/state.py
> index 45bae40c525a..ca3f857f1943 100644
> --- a/tools/binman/state.py
> +++ b/tools/binman/state.py
> @@ -410,8 +410,8 @@ def CheckSetHashValue(node, get_data_func):
>              m =3D hashlib.sha256()
>              m.update(get_data_func())
>              data =3D m.digest()
> -        for n in GetUpdateNodes(hash_node):
> -            n.SetData('value', data)
> +            for n in GetUpdateNodes(hash_node):
> +                n.SetData('value', data)
> =20
>  def SetAllowEntryExpansion(allow):
>      """Set whether post-pack expansion of entries is allowed

Any thoughts on this Simon? Moving to a newer Ubuntu host for CI is
blocked on moving to a newer pylint. Thanks.

--=20
Tom

--8aeIh1yatfe8PHk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme03qEACgkQFHw5/5Y0
tyx4zAv+K12BgN3jXFd8PCcEJOFnJ1bLvdSBDvhD3l1DDyli+RwgyXED+9NikLmI
cuq09tFFkTQtm1/h2yCDO1+7xspU5P5l72A+jgwx0/o3jwnxaWUc4mDF2mqtWwDU
ujItD40/ipoSJbif25lDASm/PShCN8WXpSzhM+MsAYkcpFwPleepWakoKZ2XfXbh
O9fP4IiyLFbmrqaXTW3GPZrU1stYdaA2IBH9gHkGmaJ3fMP/y8YNuWZCmobLYSVv
TInSDg06Bnx8dXT244C8oMzh1fpGXV1Fr6X7d50PdEziT4EDXg4JSX0V4Bnf4ETp
4OV51vvqNrodrOElijs7wsBuzka3Ly++GTeiZEmjxAr/N3eobVqNJH/Ip4LM7t8p
zoDpP4CFpuRZM2sQzjQp3uY122vIcyIh4KeFgPkxQ0wcYjC+C+dQ04dvfWEnXM7+
r9k6nr1Qn/OONin3Wxd2eXik+HlmvudI/yleHPgOzU2KsifMYp/yl74Nub74EvtG
DhHszf+Y
=+OmV
-----END PGP SIGNATURE-----

--8aeIh1yatfe8PHk6--
