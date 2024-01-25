Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3B5C47DDF
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 23:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AB2587447;
	Fri, 26 Jan 2024 00:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="diu5kzz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123348784D; Fri, 26 Jan 2024 00:19:41 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D041187447
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 00:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso6499569276.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706224776; x=1706829576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HyB3+MFRc+CXevMRbIV5T1heUI7kjAxFRQH0VJ2CWW0=;
 b=diu5kzz/EzpdI87eXGB1QjYHCKHWfVCODRsY7CzS3LHHzjhAKTKJqUiBZjEbjqkItF
 II8hz56TGDNLXFIFHLwnV0FXZjLbvEtzyZSvD3coAlqlj2gGHP1DgLOSaJLOlE4ElyY4
 639J6BTj8md+662wddNLgVwQz3sq3rOUl58M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706224776; x=1706829576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyB3+MFRc+CXevMRbIV5T1heUI7kjAxFRQH0VJ2CWW0=;
 b=r0s76UmC9kuGJDIHAaX8xqa3eKD/DTiYMMY550UVJlgSOe7YOrJrFBwhPTOk6K8zxv
 UJIsqDr77FmUQ5TpmG1VGmDPDvWY39WFy4JawfMAOwhIs5MUoaRCeAfE/7/nb+tJBA1K
 zFWVZVcoi36JO8oHHwgmL5HjoViW/WKY6BUf+8d3L61ihFulv4yqCy2iSbayVkMCaLT5
 P+uZV6LgjTI8MVOahM/SGLKPDwmdIdwtBKN04c5KQgY25fuszRC+/B+9l4usSIMfm8VJ
 vFHUM4kWB3sT6c5sxXfyH7IhosHw/3ntyVCP5cM/ZwW5mO1oUO8+R9fq5LP6oDRuBeKH
 XY/Q==
X-Gm-Message-State: AOJu0YxW23zKHcV+p5dr0GNcX3kBnFIWquRzNvnaI+cSbah2vXjgvImR
 eMdO3qfJLbei2+o7BtPiQyfphn8d4Hh7ZzMolpjrx6pH14yqTG3EBylD6dia4H0=
X-Google-Smtp-Source: AGHT+IFnV1Re2aoyI8LY5T3+HgIuxcnWMCo08BR7J6XzzRrMXTwjjT16cbm4q79QNSBSU1xWhFJu9Q==
X-Received: by 2002:a25:a108:0:b0:dc2:2666:efc6 with SMTP id
 z8-20020a25a108000000b00dc22666efc6mr498806ybh.11.1706224776488; 
 Thu, 25 Jan 2024 15:19:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 s2-20020a25aa02000000b00dbf3dbedd69sm3785941ybi.53.2024.01.25.15.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 15:19:36 -0800 (PST)
Date: Thu, 25 Jan 2024 18:19:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240125231933.GY3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hPfmvEEpyR1Haj/t"
Content-Disposition: inline
In-Reply-To: <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
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


--hPfmvEEpyR1Haj/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 05:38:23PM +0100, Marek Vasut wrote:
> On 1/25/24 16:04, Tom Rini wrote:
> > On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
> >=20
> > [snip]
> > > But at this point we have to move away from apprehensions about DT ABI
> > > breakages and provide real examples of the DT ABI breakages in the
> > > past. Are you aware of any DT ABI breaking change backported to Linux
> > > stable releases? This is the sort of information we would like to make
> > > DT bindings maintainers aware about.
> >=20
> > Well, how far back are we going? There was a serial related one, but it
> > was probably closer than not to 10 years ago and lessons have been
> > learned from it already.
> >=20
> > The real breakage comes in the form of (from the Linux kernel):
> > commit 37685f6a63eeca2135d1f704e7638409a071b1f6
> > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Date:   Tue Feb 19 08:46:33 2019 -0800
> >=20
> >      ARM: dts: am335x-evm: Fix PHY mode for ethernet
> >=20
> >      The PHY must add both tx and rx delay and not only on the tx clock.
> >      The board uses AR8031_AL1A PHY where the rx delay is enabled by de=
fault,
> >      the tx dealy is disabled.
> >=20
> >      The reason why rgmii-txid worked because the rx delay was not disa=
bled by
> >      the driver so essentially we ended up with rgmii-id PHY mode.
> >=20
> >      Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >      Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > And this is of the style "the DTS was wrong before so we can break it".
> > This is the specific example (as the board is in my lab) that comes most
> > clearly to mind but there have been similar examples in 2022/2023.
> >=20
> > The other just as painful examples I think may be where Marek is
> > concerned and it's around nodes being renamed for correctness. We've had
> > a number of cases where a - turned to _ (or vice versa?) and whoops,
> > platform stops booting. Down the line, tooling would catch that, and
> > it's a problem of not being able to use better tooling until we have the
> > updates that might break the boards that need the better tooling.
> >=20
> > And really this gets to the crux of the problem, how much testing do we
> > insist happens prior to a re-sync being merged? Do we want to go with
> > the whole of the dts files are re-synced, or do we leave it per vendor?
>=20
> I'd much prefer to leave it per vendor, with the recommendation to use
> synced DTs. Eventually things will stabilize and vendors will start
> switching over.

To be clear, every SoC (or really, board) has to opt-in to OF_UPSTREAM
to start with. With that, I see switching to OF_UPSTREAM meaning that
there's a commitment to keeping up with dts change in upstream dts that
might lead to issues within U-Boot. Do you still feel it would be better
to have the re-sync _also_ be per custodian tree? That might be a bit
harder to handle.

--=20
Tom

--hPfmvEEpyR1Haj/t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWy7H4ACgkQFHw5/5Y0
tyx4rwv+PJflPEzRznmjHsZwbLApxsJmQl4z10hMGt+h2V8F9aZZyD4fCnLavImt
cqccskA/sner+ZnQKVnPaKIL/p4GgWCWF4bkLyajEzYob9FjDaVA7LN+fMvuiLI9
ZtjkPoLcFFVXTKCSBRApQBZF0yz2l59jS8ncviad3qHGWDo6fKdz5nH+D+eSwtFS
v+QX0CwPoOacan3SdNERDcyRthuwETegrv9lvlpV26zDVSwsaWEyNP/qputwO/Gu
yqO3iwBkT1WFj2f/rSOWB1h/oT0Opt4WpxnYwxp7pc+M1YbgFvoI2TlWVYN7KMTt
FULLXAyNoJlsT6291HgqtNchxq234v/e6XrG+AswA2GOr1zwnfD4YwjJtMiojcYx
oqNc0hVj1Mu7vjcOagWHlxGfYWxUFmeU51ZazOqq/DJ0Um0U+NOqNZUjT3QocHU4
cak/+1x2PK6umgCnQ6Fzc7xG0lTycVYmmE6/Tn/lTT2Vjz9EwRjdKi30kTirHR8+
y2SkFfFc
=w+z7
-----END PGP SIGNATURE-----

--hPfmvEEpyR1Haj/t--
