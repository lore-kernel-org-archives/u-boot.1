Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D4C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DCB88829;
	Wed, 12 Jun 2024 18:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S6SkfOcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D698881C; Wed, 12 Jun 2024 18:00:50 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8608881B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so3492055fac.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208046; x=1718812846; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0oPCoEjJ7lh0B54ouVxLvuWlxgjsOUG6HBHyrGWmPb0=;
 b=S6SkfOcUdTgqruE8O9Lw2ORviM765r93UlIwtbxWIc3Tus/b2DKBgSdJ3wZTlwPZeR
 lEcVM1X3D53PsSouTOLZvt4E4Ck2QAgwp3Kh51jS/108aMB1AAeT086HHZm2uIrE7dUi
 GuNLlCluKhLFPogT3GB4BrJssLuJxQXqN5qGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208046; x=1718812846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oPCoEjJ7lh0B54ouVxLvuWlxgjsOUG6HBHyrGWmPb0=;
 b=FjxlaGuLDICeghAC9msfDIYnNBlELoGfx30ktfIWHeuQVqPQU8rDekUbPkqHclgrOc
 Je5hyxFDJVh28+apXMYFYpCIZJIcvWKvis4JLxbxUNOMQLrGthjzUN+5DEXBofMV1zn6
 RBL32MVcQZ2eBoFpuQcbEcNn6h1AUMn7KkdrGcW5BFL18AnvkdAm2+H3FBvXZQzPwIlM
 KMdxBmFGrjtDLOJ6WOe+vdJU/0zD31PZ/Nab/ORxErU85K8900J99l2u0trddIt203Rs
 soFORzmUUA5sv1bqrgMBJCwaPlrWu+KZ6JlXpdiB2WoZzks/30xlNXmnvP3ptxzGiNB8
 MBTA==
X-Gm-Message-State: AOJu0YzMcg5IWG2ClRG2eQEl+AGGrXY0BPwK2dTdE9juV4cUXYxWMg1T
 AfHqKoO2fFTB8TSKAMJbwkQzTkaLWMJR/zcRyp5xVNNTYpRULJRaHbzyTC+gz22TjwcfekLbPpS
 wmbM=
X-Google-Smtp-Source: AGHT+IFjywjE8eUSrC/pA+6cPuIHxH7jl/7H6mNcK5kV2K/18eWZsuJlcNwv/23If4ibfg9QRyHOKQ==
X-Received: by 2002:a05:6870:b151:b0:24c:b80e:ee1b with SMTP id
 586e51a60fabf-25514f20a32mr2363706fac.50.1718208046406; 
 Wed, 12 Jun 2024 09:00:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25498ff653fsm2273042fac.23.2024.06.12.09.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:00:45 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:00:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH 1/2] Create a common file for test
 scripts
Message-ID: <20240612160044.GQ68077@bill-the-cat>
References: <20240610222743.255386-1-sjg@chromium.org>
 <20240610222743.255386-2-sjg@chromium.org>
 <20240611160730.GJ68077@bill-the-cat>
 <CAFLszTjk894twWPzfX-=Xw06Z6f2hjdxDguinBxAQhmjQ7KYNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JxXORuTOsq/aGaLp"
Content-Disposition: inline
In-Reply-To: <CAFLszTjk894twWPzfX-=Xw06Z6f2hjdxDguinBxAQhmjQ7KYNQ@mail.gmail.com>
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


--JxXORuTOsq/aGaLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:07:26PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Jun 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jun 10, 2024 at 04:27:42PM -0600, Simon Glass wrote:
> >
> > > The top part of each of the u-boot-test-* files is common. Put it in
> > > a common script file to avoid duplication and to allow it to be
> > > replaced for the Labgrid integration.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > +++ b/bin/u-boot-test-common
> > [snip]
> > > +bin_dir=3D"`dirname $0`"
> >
> > So we always set bin_dir here...
> >
> > > +board_type=3D"$1"
> > > +board_ident=3D"$2"
> > > +hostname=3D"`hostname`"
> > > +
> > > +. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
> > > diff --git a/bin/u-boot-test-console b/bin/u-boot-test-console
> > > index 0b6b4ac..ad90040 100755
> > > --- a/bin/u-boot-test-console
> > > +++ b/bin/u-boot-test-console
> > > @@ -20,12 +20,7 @@
> > >  # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > >  # DEALINGS IN THE SOFTWARE.
> > >
> > > -set -e
> > > -
> > >  bin_dir=3D"`dirname $0`"
> >
> > But never remove it from the other files.
>=20
> Yes that was my intent, but then I realised that it is used in
> u-boot-test-console, then wasn't sure it was a win...
>=20
> Perhaps I could do this in each script?
>=20
> . "$(dirname $0)/u-boot-test-common"
>=20
> and that would allow removing bin_dir. The above is pretty clear.

If that works, yes, otherwise just drop it from the common file.

--=20
Tom

--JxXORuTOsq/aGaLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxiwACgkQFHw5/5Y0
tywY2wwAs6D77UpcvZX3nMA6aX/rIRbv4tVh94xEbp8KiMtheMUx9ABW1LOTVv5H
hctkdFJKUXcHPpGOa6uKH/tvDbweyM9udR7AJJH/WorMZQAixsSq7aQv4bg4esAr
eC2sUTYejqdzsYznWkR9IkQLJ7ucJyO9zRAdMS01O6yKgFrRFyngbfaL0FjYQ5Hb
I0Xbf5tyQGigTp/L35hNqIf6741VD0DatUPIN2FFiIJwy4ofuj1Sew2/NPpSYuch
YGyPF1FZJT+T5axlchqugbm6T8JZjeNhgGdzyuPDmMQRCBlH6ygMkjD9agoBu3Ck
y6ek27eLdpPEgWpgqPlxG7vQZ+gSFGCWVPzz/66Trfd4dmgv2bUqh3lLGaASs/FP
UHoBXHsYWQ4zQbeBV9HfqP9+W9vd/p0n1GDrmx4P0vF7f96CEbJfwknpJeCNpaQB
Cx54YlQdHYqTEE8OWesX/k/4j0NYZrIVJGguYIpq8k/qWHieoT+aPt4xv5MavqCH
Acq4y3xe
=yzp0
-----END PGP SIGNATURE-----

--JxXORuTOsq/aGaLp--
