Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25BCD10F2E
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 20:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE948914D;
	Sun, 17 Nov 2024 21:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QoIc+ge+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC92890C6; Sun, 17 Nov 2024 21:52:42 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9A388DB6
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 21:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d40263adbaso21056666d6.0
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731876758; x=1732481558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=11ntTO52gal76n8bWg9WejiRet1e9zYLcp++lt9hKao=;
 b=QoIc+ge+SbmBVuN1yrKQO+mXk+QCgSDRkBQnicslJynZWUsrGhnnpZUX6shwW47Lkq
 5LMOVSLT2Z4/9ZrYG2Yir6X5RCru49plcIN+Tqp3UE0/xknD0C3fTSzA973PX7rSid0k
 /w49J5iVf/MUuB696K2O1dW1js2Vzcggav7vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731876758; x=1732481558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11ntTO52gal76n8bWg9WejiRet1e9zYLcp++lt9hKao=;
 b=BEtaVPwy1oBjLsERxoaFQdTfkK6RwplabVjVh/OHTDW0QdfOeIQQ+9bzmNWGNFX0xx
 Mn6t5u+VGXyji7CzRD5ZqDQXT4SpLlrjuVAtRm4qT9zFNYhLUPu+H4YVLhsP72dFyNWR
 NiHvePYlrZ1Y52r26CeZi0Q3fYXqnvHvrMcd3H/SZkel3EmIOqX7PJXnsS9At9RwJumn
 Brh83Cp+hhvkSGXwYvdVLOz52OO8Wy9unFC0cEMnr/weXniUjlV1i9XCzf67SaxXccam
 vsrbSuqLHiHCW28goPAKs4s15BcSA8BBv0ObWRMwNgcMIIgQdWvAXaL3D6qE0X26oSVH
 Gz2g==
X-Gm-Message-State: AOJu0Yydp42EjOYym3/Vgjf5s09v+FCIAXpnRokgu8GhdnAZF+og8eZJ
 B5GNq9dGgQu3e+CKAgVbb4kYMMjbl6adjX1kvCObl496D9MhM8V0nXVMsJvFACWLIkYq8VjQZvn
 IVXY=
X-Google-Smtp-Source: AGHT+IGzPvIabHm0VkPUAfqD5AVqkSCSgDSaMAiWMwo5sXUA/E+6x+orokYBa+TZh162VaC3771yMw==
X-Received: by 2002:a05:6214:5411:b0:6cd:f6de:8ad2 with SMTP id
 6a1803df08f44-6d3fb8acb9emr176523306d6.45.1731876758415; 
 Sun, 17 Nov 2024 12:52:38 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd887b6sm25521556d6.99.2024.11.17.12.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 12:52:37 -0800 (PST)
Date: Sun, 17 Nov 2024 14:52:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
Message-ID: <20241117205234.GM3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
 <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
 <20241113222016.GZ3600562@bill-the-cat>
 <CAFLszTivnmnB+1p58sZ_VSZBWpL1Kt7QJ=mnnEvHZswAeEZc0g@mail.gmail.com>
 <20241115144412.GV3600562@bill-the-cat>
 <CAFLszTjqJ5dr8_qm6y2pv+76kBEgv5BbwLigB2YfYWHmD2h-3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pf8S70X+A3ssuBnk"
Content-Disposition: inline
In-Reply-To: <CAFLszTjqJ5dr8_qm6y2pv+76kBEgv5BbwLigB2YfYWHmD2h-3w@mail.gmail.com>
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


--Pf8S70X+A3ssuBnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 12:48:14PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 Nov 2024 at 07:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 15, 2024 at 06:37:18AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 13 Nov 2024 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Nov 13, 2024 at 09:03:35AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > It has become more common to use config fragments to extend o=
r adjust
> > > > > > > the functionality of boards in U-Boot.
> > > > > > >
> > > > > > > Propose a format for how to deal with this. It is not impleme=
nted as
> > > > > > > yet.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > I think that the first problem is that this patch series is an
> > > > > > inappropriate method and place to start the discussion.
> > > > >
> > > > > We had a discussion a year ago but it trailed off.
> > > >
> > > > OK. Still an inappropriate place to resurrect it.
> > >
> > > What do you suggest? I am trying to solve the problem, not just talk
> > > about it, so patches are often best for that.
> >
> > Well, in that there's a problem to be solved, it's that buildman makes
> > #include more painful that it should be to use.
> >
> > Or, we validate config fragments by building them. A requires-buildman
> > solution is not appropriate. That:
> > https://patchwork.ozlabs.org/project/uboot/patch/20241114115049.2070780=
-2-patrick.rudolph@9elements.com/
> > doesn't use the acpi.config fragment is because of the parsing issue
> > buildman has.
> >
> > > > > > I also think this gets things backwards as the common case is "=
make",
> > > > > > not "buildman". We need more defconfig's that are just base +
> > > > > > fragment(s) if they're important enough to be a combination tha=
t needs
> > > > > > to be tested and work. A board is not a time-expensive part of =
CI. A
> > > > > > pytest run is, a new job itself is.
> > > > >
> > > > > OK, that would work too. It would also avoid the problem of combi=
natorial
> > > > > explosion. But I am not seeing people actually doing that, with r=
are
> > > > > exceptions.
> > > >
> > > > I think it's the exception, not the rule, where config fragments ar=
e not
> > > > being put to use in a defconfig. And that's possibly because not a =
lot
> > > > of people seem to know about the #include option, and then when I
> > > > explain it exists to people the next problem is "Oh, I have to do w=
hat
> > > > so that buildman also works?".
> > >
> > > Are you looking for any feature in Buildman for this? This series is
> > > intended to fix [1]
> >
> > Yes, the part of this series that, if I read it right, causes buildman
> > to read the preprocessed config file, rather than the raw defconfig, is
> > what should fix that, as the final patch in the series confirmed.
>=20
> Are you saying you want a validation solution that doesn't use
> buildman. If so, why? CI relies entirely on buildman for building
> things.

Because (a) fragments should be used as a general rule and (b) it will
introduce a new failure mode for new platforms, platform added with
fragments, whatever-table not updated.

> The first 7 patches of this series resolve an issue that you filed.
> Above you say 'because of the parsing issue that buildman has'.
> So...should we fix it?

Yes, patches 1-7 are good and I'm leaning towards picking them up for
-next soon. They haven't quite had the general 2 week waiting period for
others to comment on.

> I don't like having fragments in the tree where we don't (at least
> programmatically) know what board they relate to. At least I think it
> should be an error to add a fragment with no in-tree defconfig users.

Fragments don't have specific relationships to boards. That's what I
keep saying. And we *intentionall* have fragments without in-tree
defconfig users too, as I spelled out in another part of this thread.

> In any case, I think the file format I have come up with is somewhat
> reasonable. My main concern with it is that it might greatly increase
> the CI load.

Yes, but I don't want the thing you're proposing and don't think it will
have value and that it will make life harder not easier because of
introducing a new CI-only failure mode for submissions.

--=20
Tom

--Pf8S70X+A3ssuBnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc6V4sACgkQFHw5/5Y0
tyy8Pwv9GLjuJpsXolAI3yQtoGl1s+15zn6cVAEtTc8CzN7BZPaKGQCkrseX412B
OxeZiXcXthvqjVvRpcFqwMiD57sz/lDIYD1aFjrqHIcBqCP8uyCPgY6Hx6N6E3rT
VafkzOLGteMohNv9XGEsS7Rm6Y3CyF1tsBrzhXp91eLY45BfN1fGEZvPaCBOe10w
u004VrtmteUdTXZCMKV5RZw+ZOKA9gN9o4fz4gw1fzsh9JgO2TmA3p2SicXwFE8b
+eHTvtzSpEF61SS3Fc7nWSMAlAuvbSOG/wEsUCXjopczkBKQSYuIUEkygWTijb+Z
k6GLuG2KcFtY+fOq69gqIrEh/b24SiOPKn5gF1ITYmAdkXwHaO+dzsWdBmCaqKo6
W2e1waWrJw7CDbtQxgzRkvxjkmHqCWPPQ1UBaHks31WIaqnOeJPBIGAs0awY9Z9O
LrkiylmKhljsicLP8fc6hbRV8nwagGAOPz4nOPWn8ayo2GjW4ReQX+IcZ/TXbWb1
O/GRC9/n
=rOJm
-----END PGP SIGNATURE-----

--Pf8S70X+A3ssuBnk--
