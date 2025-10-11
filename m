Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0280CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 16:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9F98385B;
	Sat, 11 Oct 2025 18:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMbfpstN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EE583869; Sat, 11 Oct 2025 18:24:45 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B3183829
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 18:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7bcfafec537so2397526a34.0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760199881; x=1760804681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uDwwGXzMmARGTV9QATOwiPUbPYne/sgDFUOCeX4fe24=;
 b=HMbfpstNimkcqqjqyl/YX79G6yuhx40PG3+gs+su4WHEnHXa8mMjA9AXKYzziWhlhf
 5cd6+bRkSs9P5ac8RqIuzdrgRRW1PuCkxiwG19Ql0Y5oJuF+vWE5E3/7H3jyMSlnDqUE
 pM/Q9WQSr4TAusBSJPsNOgvhaiASPH+R2bWK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760199881; x=1760804681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDwwGXzMmARGTV9QATOwiPUbPYne/sgDFUOCeX4fe24=;
 b=xK2lIel9i63+GIW5KgVY0xbHR7QszC56YWzR+yZ30f6UyZurgnGp7+5JwQHI8gb8IB
 t/9OJCjSvtaRNlqjt/NQV+OV81plMWStcg22D5DvVTphk2cOGJ7ZuUtQaj5CImPuHc8y
 e8n8Zymt3ahZ/zLIN8uxx7tojg4IBCZej8QsNZ+UK02OnfAEh6gJaSpK9I2I+t2ABwFW
 huiTyBJID9R3L9FCRoOruSisQlIGDA/e/nAnWdv69FSAka8oBULJ/r3X/sS1UM+IW6s6
 QET3a9XOcESC+jCzM4mjwK3bzb4ngM2zuDcWk7xBDyMZKGW1jbcQxg8Ugeau3Qjsb4O8
 UPqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGPNqfzfhriQc1AvB5md+UCp0LDjaib9mXST0gZkOnJIUGoFEPDSZL4l26RoPXbwdRPOsCmQg=@lists.denx.de
X-Gm-Message-State: AOJu0YzvC8DDCrPMt9w6jUKTbccL5apMhkoFPgbL50jPtBKmQHsnMeG5
 kKeq/3Mwn3eOSwkBZIPQoltJAy0H58JiHyhIiSs4aubEpTAMKMXOEL3eLpoKiSEGk5k=
X-Gm-Gg: ASbGnctAbsqs8bWe5qyj8sd/9CgHknMoD29dJxjurOWl8J8WIwCwIXohDnswr/I5BLu
 8U4O8OOnNgniJFeK9JuvQ2sVke8OUetZz8YUPHv/g1cEmtMpUweY/IKMq99B0q6MFX+mEYBFuYa
 KfoquBqo4nj/BCjM/jz++iAqPsKMJqcBe2xoe0RekIoCWBxlVZLOXtAu0g9lqJjxj/WVepPA/DW
 vjdDvgNp8WrUUjfEkoSnMBQHAgD5tFEWHaMsWtQnyDDpimcefDT7j5TO18FGTtQ1yzCCIM7w0ng
 7YgW+syDcCLE6APu1JEoyufgjUiCcgPxrHiFnchZ2lOVPDgU3tOY0F59kBpRlquT0QIz0JFksj1
 SQu5j9vqxx8TW5mLbYQNdkjLQmPFlUsxPAmFqMhBANvOR0PNlyiUHp91U7axAZqAOppsjWiuO29
 cmyIEY8/GaRqpARDY=
X-Google-Smtp-Source: AGHT+IEQYwmWZONnGUNncuANbVR14QixXIt4aVh6c+sqtstEEMUp+4QA56dQrXjQTFTB8e80DN13vA==
X-Received: by 2002:a05:6808:f0f:b0:438:3680:d66a with SMTP id
 5614622812f47-4417b38f362mr6842404b6e.32.1760199880958; 
 Sat, 11 Oct 2025 09:24:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889fe9dsm1330465b6e.9.2025.10.11.09.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 09:24:39 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:24:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
Message-ID: <20251011162437.GJ298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
 <20251009172428.GP298503@bill-the-cat>
 <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
 <87wm52vobc.fsf@kernel.org> <20251010143950.GB298503@bill-the-cat>
 <CAFLszTiYNZpuKpA7JyyjrvCysN3KCsQcv0UkU+RhvLb05u=Vzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bVOH9SdBncN0Rqjk"
Content-Disposition: inline
In-Reply-To: <CAFLszTiYNZpuKpA7JyyjrvCysN3KCsQcv0UkU+RhvLb05u=Vzg@mail.gmail.com>
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


--bVOH9SdBncN0Rqjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 08:21:15AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Oct 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 04:11:51PM +0200, Mattijs Korpershoek wrote:
> > > On Fri, Oct 10, 2025 at 11:35, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > On Thu, 9 Oct 2025 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > > >>
> > > >> On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:
> > > >>
> > > >> > The 'bootflow list' command supports looking at the EFI device-p=
ath when
> > > >> > available. Move this piece into a common function so it can be u=
sed
> > > >> > elsewhere.
> > > >>
> > > >> The point of this was to enable the show_bootflow->bootflow_show c=
hnage,
> > > >> so should be dropped.
> > > >
> > > > OK.
> > > >
> > > >>
> > > >> > Use 'usb' instead of 'usb_mass_storage' for usb so that it fits =
in the
> > > >> > column space.
> > > >> >
> > > >> > This updates the output from 'bootflow list'.
> > > >>
> > > >> And this is unrelated and should be its own patch. Wikipedia says =
USB
> > > >> MSC or UMS are the common short forms for USB Mass Storage devices=
, and
> > > >> we should use one of them to have the output be more precise (sinc=
e we
> > > >> support USB networking devices for example).
> > > >
> > > > Ok I can move it into its own patch.
> > > >
> > > > Are you wanting this to say 'ums' instead of 'usb' ? Will anyone kn=
ow
> > > > what that means?
> > >
> > > Search for 'ums' gives the following U-Boot documentation:
> > >
> > > https://docs.u-boot.org/en/latest/usage/cmd/ums.html#ums-command
> > >
> > > Where the acronym is documented.
> > > This is also the acronym used by the cmd (to configure usb gadget as =
USB
> > > Mass Storage).
> > >
> > > So I'd say it's a reasonable acronym
> >
> > Thanks.
>=20
> OK so I'll update this to show 'ums'.

Thanks.

> > > > Re the second point, at least in U-Boot a USB Ethernet device shows=
 as
> > > > 'ethernet', i.e. the interface doesn't matter. We don't have logic =
to
> > > > look a level deeper, at present.
> >
> > And this is unfortunate and confusing then because it'd be really good
> > to know if I'm talking about the USB ethernet I plugged in or the
> > ethernet port on the board. Made more confusing in turn by the platforms
> > (more historical than modern I *think*) where that ethernet port on the
> > SBC itself is wired in via USB.
>=20
> A user can only tell that with something like 'dm tree' today. Perhaps
> this is outside of the scope of this patch, but what would you like it
> to show if it is USB Ethernet? Are you asking for code which checks
> for this and shows 'usb_ether' or similar?
>=20
> I still know of boards which use on-board USB for Ethernet, but more
> historical as you say.

It's certainly outside the scope of the patch here, yes. And it may be
too much effort for too little gain as well. But it would be nice if we
could be more descriptive than "ethernet". But it's low priority and not
worth worrying about right this moment I believe.

--=20
Tom

--bVOH9SdBncN0Rqjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOqEwQAKCRAr4qD1Cr/k
CnanAQC//15+y5bbHOVmaN5ZrsXLlmptgs6T1oBuHALuiXdOaQD9Gt35r142eW02
a+zVwbrkIhVoriqkYaFOn+aVYhNtkA4=
=7EeS
-----END PGP SIGNATURE-----

--bVOH9SdBncN0Rqjk--
