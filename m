Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1833CC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 20:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8ABC8070D;
	Thu, 16 Jan 2025 21:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rvRU8crw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE29180312; Thu, 16 Jan 2025 18:22:09 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA23180214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 18:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b700c13edaso60515985a.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 09:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737048126; x=1737652926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WEDYapmV/Zu7cr0UM1m5DIsWHlUBNMAd/dVRvQF+jkQ=;
 b=rvRU8crwYwznd8343uMTwzop26/AWb59ii0Z+RpEUgtmaqkDbVDQJvFDZh3wPMafeg
 Z04S/hmDh+k7K/21v4qXx6mvUI1TnsUBuFnuTkAx411NtDNOev5Cz1lV2tC1p++4T/Y9
 6JIhNtY1DF05dvj7/nUlzbuUjsWZuhSEpdylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737048126; x=1737652926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEDYapmV/Zu7cr0UM1m5DIsWHlUBNMAd/dVRvQF+jkQ=;
 b=S8b3eIc5qnOiOJeubqRK/K3NVTcfvXHn+ZxrNAcpeqeBbF6k0b9NMTvwYhUwmxgyrm
 t4Rh2fGruqAkefKBT5c3/RqZrqFoGsn4wpeh68V0cmCjnpJjlJ9lRR9lNCTp7I3v95hx
 xLYX+XFx0HCToyCG1grJ8H/bNlrvjlVginYu0k/QqynW3vYHpYlydoQxtvJmZrQBhF8W
 gSBHHonZEd/cBc7doE5zBWpj2+HjdCea5Nju9yPYlQrSWJrE0Hu30hWvVQEp3NQrQw1n
 Eiy99iOdPuGs9WWmqYuycqMRxqpLj/zPpTGpauRzXrRi12hky2L3zDdhezeQfgbX+uFI
 jHFA==
X-Gm-Message-State: AOJu0Yw3VoZoTt2bJMmBfqU/3XfocMjUTbqoxOkue9BdNSJDguobAMT1
 hJeWaCwYICzR6Pa1F4lYMYqKsz4jYKo9BlNeQMnbEvuY2r2v39CwN6qdUHr++F8=
X-Gm-Gg: ASbGncu6IqQVgFxyNDDklzUU4xRfPp3kK814S9mx/7oA6Dskfz5Xx0jOTa88RfjGIkK
 EhAG3VsNSdIK3HhDk3KwEAYDcQ+uKkUO89/Eb6qdKnvFWo9EHcLuxCQMKfG1Ew1ar6Hn4WCLkkf
 uRpBO6cV6Akc123VLFMLsdHvpT726krV/l3lXA9R58so2DBfWaJz2/g/wOfkZjQg3My2Q5xbrnk
 L+//4ZH8vu9iqlNnUizj1c3wcJJwVpYRhhdogHf3Qkb5H37xQSerA==
X-Google-Smtp-Source: AGHT+IFG2OzzqTdIfBkhYrxMs/hKFS7w3UdJ0/BZN3oV8WrmDDwJHmOeO9cVzj/ACKJdlQMFNOSQlQ==
X-Received: by 2002:a05:620a:2589:b0:7b6:dc0b:8ffe with SMTP id
 af79cd13be357-7bcd978a807mr5908668285a.53.1737048126350; 
 Thu, 16 Jan 2025 09:22:06 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef631sm23154585a.109.2025.01.16.09.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 09:22:05 -0800 (PST)
Date: Thu, 16 Jan 2025 11:21:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
Message-ID: <20250116172159.GH3476@bill-the-cat>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5qx5x/s58kfrDl+7"
Content-Disposition: inline
In-Reply-To: <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 16 Jan 2025 21:47:16 +0100
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


--5qx5x/s58kfrDl+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote:
[snip]
> > I'm referring to the whole bootmeth/bootflow/etc thing. Is this going to
> > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit ARM is
> > a harder question there, which is also where this particular overflow
> > was.
>=20
> I'm still not sure what you are saying. Are you wanting to disable
> bootstd by default / go back to distro scripts / force everyone to use
> EFI_LOADER / ?

Yes, I'm asking where it's appropriate to enable this new functionality
by default.  It certainly should be enabled on arm64 (there's new
designs) and riscv (there's new designs). It still ought to be enabled
on arm32 because we otherwise lack a easy way to say "new" arm32 (say
i.MX7) and not "old" arm32 (say i.MX23). What is the point of enabling
this on PowerPC for example? The active users there are (generally)
supporting legacy hardware and I have no idea how much they want to
change their boot process, once bootstd supports flash for example.
There's similar questions for everything else under arch/ as well.

--=20
Tom

--5qx5x/s58kfrDl+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJQC8ACgkQFHw5/5Y0
tyzYWAv/UF6b0z+o1emP51P+BdRJ3gkr4zM84dc7SXEMGY/Lpb/GHgFkcKQy6edA
dW1eCQ5T/V5aUxktsYS4r+h7GKKCeYUAZuea7xmeCNcoSWhuGwdtM3oSUI6mVCMe
5GGjJTBfyASr31kyhCgj9Z6Lqxm25Iy2WgYSFxBRVygH4InM789Ybwrc4pf4Zf+h
taqQT/eGm8Yo9EQoKVyHt1t9FQW1N9b6pZ8I5nDBdGFhiPuRaer+ixlVX025x5bt
MiqaAJDMJTjcUDJ0SFgFrN/hpfzYa/NLdW/DOl4u8SzfgEmkyLvDOza/Px7xKVYQ
X5wYNrbs7K/ixN6ZvNcLjXYEDjU4FVgTADSDxSZ/944cPyRoyIUrl8DVtSbuh8Gf
ynL6qft7GkuSKHzp4rJOrjtWKx5PEfYpTit03lvSbYDG8n2gaVE2KO3SXjBp5gLz
8L8pxRCrgTAmoYaxM6RnpiywSfAC2dvIaevpMWGt3PjbvnA65vXB2+yBSYfGYDgg
U1wM5K4d
=dbLU
-----END PGP SIGNATURE-----

--5qx5x/s58kfrDl+7--
