Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD9C5472F
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BA288B36;
	Mon, 26 Aug 2024 20:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cda+zEdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B018D88AA8; Mon, 26 Aug 2024 20:23:53 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A72088A74
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5dc93fa5639so3670780eaf.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724696630; x=1725301430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1iVtoq5BUNJscfrNoz/JU/ZvrlppVLN+ydpr4mNgvgo=;
 b=cda+zEdIsLZ/dqLQNJraTTViW1/t9+JVcqWl8Oh/N3M9j0vEeNadvcXJ21+3p6x8Xb
 5fg/VW6PoiYWmLSuWNCspZUkYKVH8LGV/5fLuLgTyiJqAwWA38IxgvczXGjScNiU3fg5
 Pv4V8l/7V0BDuoLB0GykIOHfM+RLRcLafYYEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724696630; x=1725301430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iVtoq5BUNJscfrNoz/JU/ZvrlppVLN+ydpr4mNgvgo=;
 b=poqGvgc/qCeSSXn1k+bGiuuDZjgtSAtKfSycuNA8QYSXMgawPPq2XTEznIgbmifHLO
 iJgGTs0fsN8ih8CdJXEVXVQdru1MX4b8rZLKQy/p5MMXpB8FTHhLGEKP6QcNlpPln40d
 IXBuyTMgD7ANkAClPcCMRIgr8GNHX7TvAJpRJtBp7Gok07bVAGsuxdS0dPs6Dt81eAnJ
 OoSU1mVPOqXWeqJkay0OgJQkd6aMiYuyQmlZ/Zki9cnIbkfXZq9ZZggMtEQtb3WWvtE/
 U3m1UMTV6HBTtN/rMgIlnUFdc0J6D6gy/aAJYiVr6646flgdvsEocdy3boiGGksJOgg1
 52ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfXYL5vs78UKbsUoEp4C/mSX0L5Nsg/lWeK+4ash2kAFU1QIBYrkU+Tn4XcdhgqOeDekewTe8=@lists.denx.de
X-Gm-Message-State: AOJu0YyrvOx7v/JJu5zbgKERYxNR4CpN5n6gmHJS5i9RewgoRlIE2uAv
 x16buDzDneTpy8My+82byFehfnH+eWImSjlo9oWADNH8MgynHBsR9hGM/qxV9dc=
X-Google-Smtp-Source: AGHT+IGy9IHBa/3zvpXPuzNd3xKMs6MOcUVsvP9Ou6naC6iHRIiuP1jZLIy3A26gdpmjGvwhSdaPpg==
X-Received: by 2002:a05:6808:22a2:b0:3d9:509f:221 with SMTP id
 5614622812f47-3de2a86d9bamr11926750b6e.7.1724696630079; 
 Mon, 26 Aug 2024 11:23:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe196a4csm45796371cf.66.2024.08.26.11.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:23:49 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
Message-ID: <20240826182345.GJ2479150@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hIZU4L8kyi1Vq9Rk"
Content-Disposition: inline
In-Reply-To: <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
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


--hIZU4L8kyi1Vq9Rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> Hi Caleb,
>=20
> On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
> >
> > Hi Simon,
> >
> > > As a general comment, this is adding a load of code which is used by a
> > > lot of platforms. As more and more aarch64 platforms are created, this
> > > data grows. Why not use the devicetree for this hardware information?
> > > That is what it is for.
> >
> > This data does not belong in devicetree, the various system registers
> > exist to describe this information... Putting it in DT would be
> > duplicating it.
>=20
> I am not wanting to duplicate info which can be read from system register=
s.
>=20
> >
> > Using DT for this would additionally require having bindings accepted
> > upstream and for all SoCs to add them. To what end?
>=20
> To get the correct information in there. How are boards supposed to
> add SMBIOS info? Do we end up creating a whole infra in U-Boot just
> for the driver to read it out? It just doesn't make any sense to me...
>=20
> Let's put hardware info in the DT where it belongs.

I'm a little confused here because of some older threads on this overall
topic. Part of the issue here is that in user space, "everyone" has
SMBIOS-based tooling today, and wants to have that work, rather than
inventing new tooling or modify existing tooling. And you were concerned
I thought that we had tied SMBIOS too much to EFI being present when
indeed it should be possible to pass the location along to the OS
without EFI, but at the time Linux at least only supported that notion
on MIPS I think?

--=20
Tom

--hIZU4L8kyi1Vq9Rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMyDEACgkQFHw5/5Y0
tywY4gwAi+Rj2JcIY/TUKxj1BpBU+0XPjRwnrwQkB5ezBqVMjeZWYx70Qmz2CrZY
aYYiZ9JU7lhnGD/hCEzDlGywL//rfLcfjWIYKIzLVWU5Ajd4HIRTqY1e4el8vK8n
HnDa6LJrLivJRw44xg954Qkiclt6Y64CsnCPcqg9gn8mJGby0SQWlzDHqrsIwFJu
lwTLnanQQiAO+i0L8xn3JwLjn0YJWLaZkGZFRK0ndvE4gZa7Ywk5iNxVx0+GTLAY
Qqs66ILr/MwqTUsE0iNHFF3U8S7Sbem15VaZ80pkLK7Fcr+I3oKq6u4bea7WO/fe
/lapmjcyYcpk89OhHriX0uuxQAGTNv5ySLHVVC3lOs3Tu47MsFu9D1XXr5v30zrZ
fCriwxkaES//h9xrNUelj2sNYxbdnwYfdvUic09SCPauADjdhtHQlgHUeziGO4DW
9o1bpdtvqezqZeRTo0Pl7Lf49iSmcoNRUoUv1sJFfsIT6PSMMYaZBfbi3iVsT8wP
fgRDqvHv
=CiLQ
-----END PGP SIGNATURE-----

--hIZU4L8kyi1Vq9Rk--
