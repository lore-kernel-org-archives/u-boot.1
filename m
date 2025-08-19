Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD9DCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F23282E37;
	Tue, 19 Aug 2025 21:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EwBzj59P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48FBF82E67; Tue, 19 Aug 2025 21:56:01 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284F882E34
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e57002bc23so28780555ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755633358; x=1756238158; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KgjFcO6nw3ImhxBAZqEfGWDVwuwfHALemP+O490gh/0=;
 b=EwBzj59PnAStGfP1wY5zqRDruKpA4LcepItxJ1KFrSbS8kCn/DBSHiE9CQngl9Iumb
 7rpOuNxZE5Jt0blOcCZWmsNoMnf/oYf/40x+lztyH+Kl4ohu7qgxTh6QJmBVhgHqLyl3
 eKdKnGIGB8N4NV1yWE/YaKZa107koQnaJnHhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633358; x=1756238158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgjFcO6nw3ImhxBAZqEfGWDVwuwfHALemP+O490gh/0=;
 b=GBcZeevZeMQXPQqvQogDkX0MCv/+qS7nUfQaQpVRDHcTO5sx003uQN3VAkdqzs6gX7
 NkSIslohY2XZ+UdhGN1nVrPO+PdGtB3Vh95p8hAuNrEkoq5oQova2psy4q4sGL1TgZYd
 aAlzgCG58/LnP2nbHiHDzHWetp9MSjBj9m5LQrEspDcik+LO5R1/Y0oC38/jJmZqqq1q
 3F/HMIRC31yT9wH48H4qEFJ3/b72hHiTiHIgpaG/xm5K8bglptTAabRRKoQss6m+vDXI
 rA9SUEvTCIyx0BEP9McykIQLkG0p+VAh6GdOrT9oSSuJy/Ie+130O8ZO/bweWKbgjXud
 GbXA==
X-Gm-Message-State: AOJu0YxLAwEiA7olvqdj4OL2BYP51onVcVWbb8ksPpr2MEJUU5AWZnHz
 jvGxSFZ7VpNhwW8ZRz3q5/wSmaoQ4hT86/vOpphkb2mnJWKXXxC5JPVF+V44zhVDBn/Il+1/Slr
 KeEBzAAE=
X-Gm-Gg: ASbGncsxMsDMkm3e/Giv0jMh5MFt8/rOlBWWUHaZyzDZ9LMhSsavxzfD1rLeZIJ48f6
 Hk0vXafgjiZONX3JZoevWbPFqtn5T+m5vZEmcTCaBIVok148/jnrdXiPxEkzQ/bgCO97AMT/RBV
 6aG3lx/NgjTzz+oJYn4AVSq5E8cvX3oQqDgkq8JM3tgMW+zgq6o+CLNZTbTEv3Pb3LMCAchCxYH
 oE9uxKxyxrF2Vbfb0ZKOgVcoJvcMH67MfDhzlKREvIFa4hfrWVPAxItfeZfliW5oOsbmLxblXdH
 A7oBLSVRferCym7W5Di/dAEFFVD1qfWzhq0ex+TEQ1d+aTperJO+E2+ecKUjDJMl0yvXdfyoPEq
 eDIp0LvYP3rPa2zFBgdyCNwUYB4ndVcypvSt7W5AyL7KK77dYbspGGfi6
X-Google-Smtp-Source: AGHT+IGpERrZdEu5xP80hwXqiiSFnAlue0Hb6KMeAs6vePP8QUXJaODs00sXh1rLQDJEmstRBZ8k7g==
X-Received: by 2002:a05:6e02:1a66:b0:3e5:6645:e78f with SMTP id
 e9e14a558f8ab-3e67c9e6c4emr6557835ab.10.1755633357575; 
 Tue, 19 Aug 2025 12:55:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c947b397fsm3599496173.23.2025.08.19.12.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:55:56 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:55:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-ID: <20250819195553.GH124814@bill-the-cat>
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
 <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
 <20250819153522.GE124814@bill-the-cat>
 <CALeDE9Nt9j7Hq-C1Etxh5EpdD-r09+XYeafL=U4O5cV1rvejHw@mail.gmail.com>
 <20250819174415.GG124814@bill-the-cat>
 <CALeDE9MMah7DndMf8TrF9yXPHdk=LtefX5=uM6qV4ZSW6baiFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lRMfvjaERuj7spPL"
Content-Disposition: inline
In-Reply-To: <CALeDE9MMah7DndMf8TrF9yXPHdk=LtefX5=uM6qV4ZSW6baiFw@mail.gmail.com>
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


--lRMfvjaERuj7spPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 06:46:19PM +0100, Peter Robinson wrote:
> On Tue, 19 Aug 2025 at 18:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 06:38:46PM +0100, Peter Robinson wrote:
> > > On Tue, 19 Aug 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Aug 19, 2025 at 04:33:07PM +0100, Peter Robinson wrote:
> > > > > On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > > > > > > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > At this time there are still major Linux distributions whic=
h by default
> > > > > > > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this optio=
n to
> > > > > > > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> > > > > > >
> > > > > > > What is the legacy image format exactly? Does select make it =
non
> > > > > > > optional, can we use imply or similar here?
> > > > > >
> > > > > > In this case "legacy image format" is uImage-style images, rath=
er than
> > > > > > FIT images. And no, we can't imply it because then we'd break D=
ebian
> > > > > > (which doesn't boot on a handful of platforms now which do have
> > > > > > DISTRO_DEFAULTS but don't have this).
> > > > >
> > > > > The distro boot stuff, which if my memory servers, is what the
> > > > > DISTRO_DEFAULTS is used for, never used the uImage style kernels.
> > > >
> > > > The same uImage-style header is what's on top of a "boot.scr" type =
file.
> > >
> > > The distro default scripts never used that either, the whole point of
> > > them was to move away from manually crafted scripts and custom formats
> > > to boot a device.
> >
> > Maybe we're talking past each other now. If distro_bootcmd never would
> > have found /boot/boot.scr, erm, OK. But the resulting U-Boot image could
> > still be used by Debian (and I think others, perhaps armbian) that would
> > still rather write their own logic and set the bootcmd, and relied on a
> > set of standard features being enabled in any board.
>=20
> The major concern I have here is not being able to turn it off for
> boards that are constrained, which is typically the older/smaller
> boards like BBone, Jetson Nano etc

Right. But the initial report here was for BBone :) Given the relative
few platforms that didn't already have this on, I'm not sure how much an
issue it is. But that gets back to the trade-offs question too. If
you're super size constrained and can't find something else too to do,
then it's time to manage things more directly.

--=20
Tom

--lRMfvjaERuj7spPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKTWxQAKCRAr4qD1Cr/k
CrhYAP45lCFNe1C7d0pILuZx37CyDLUMoAhTA2X5dtZ9eBS6SQD/XBrtKVkhiBUS
bN+1dzKIWDXAdT7CXbM7r5NZgsFWYAQ=
=Bsi4
-----END PGP SIGNATURE-----

--lRMfvjaERuj7spPL--
