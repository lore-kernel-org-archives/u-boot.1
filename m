Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB1D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6AA800AB;
	Fri, 19 Dec 2025 00:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MWKj6FVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E0A80433; Fri, 19 Dec 2025 00:22:35 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7E780077
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65cf050a5cdso1196161eaf.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100152; x=1766704952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O+tWoMK9fygtTQM2qOdvQVeS2gQIy7KaEV139RzFTx0=;
 b=MWKj6FVe7RIbXnafUMtZ09elFvxMndWQlEWyPqf/dvvQB2uy+Jvef2KFJ1jWYyXfSL
 6lo82ctlubO9fNi76ipHIncjwkWX8upq8aMhzZ+nwn1iRQ/ZY6fKshf3oJ+aJoEjEf4V
 GC2b3R5f5xh6482bJADpjJ/sSOpKKJ3uwYAcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100152; x=1766704952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+tWoMK9fygtTQM2qOdvQVeS2gQIy7KaEV139RzFTx0=;
 b=jBs5V9Fpv1Ap9leMljVa44V1wchZOEj7wFRpM2Q0C5wy3F9n3zfIQPo0N0dis1qtXP
 jbmINFUOH0HyfuWtleMKPHNGyb6X+Quf5D+4FrNP+59QaTZRDlSY4Ce54jHed1al/RxD
 OWGeAu7CrFcJzA7Q1n19+vKXQmiFB09H7PvUDneQ4xPcSjsGSDBV5ZLr8nMxkyB/7EbV
 aa9dRc7Niwk3sB3N6O9p+HMDCU00HFe4PErPuhR08/PscIAsg2SOHCYRaet3sVPKaEzj
 o0gSVQeE0YtQ706e/CI1QdP3/oqUxd28zIDkJmSf2YVxNp6hpnXrgcBmRdmFav9r8Lpp
 Hbqg==
X-Gm-Message-State: AOJu0YwsimZY9KveKHSddEOuM5es/cfPKrttL9VKsuRpqZYPumCiM+Ca
 U4Cx+0RovLoTj6BPVu1x8xfL7NITtSbR+Hp7miuqr55EmNuXteBhLY5aM/z9zSZSjYIWdmtauxW
 nesmFcSc=
X-Gm-Gg: AY/fxX4jYw4Pukxz1gcKy9594WZL0ohZhaajp2mShtpszjAuZYPOQeEQ/VCCgOVfI/l
 yBnCSiqcKwGFAfDHQqTELfN9mYZQsdas7L2IZKR9udfZDvV1qbeQ+68oWAU4e12aj6U3elDrY5V
 fHpeMiYPxdd5osgE7DST3rgFG9yuPnGrfoxtc+MqLvdAmqqEL7gUbjZTR6gf4ijm8jMdAp7/ZNi
 kYreAnquNp8p+lgNkBrW8i8/UiKSnZm8Y+1rT+A5DgFF22bUv+BkNNT9mQ8QP+XQKfhvnCaR7qN
 baXHiNBaq13+7WJKq9M1yZ0xwrepwHN23QhrSm3pNLUN/N/qcXb4Tr05E6zNCkPghBS/5eybUHA
 +KmR8n8vJZffr5OQDw29rkqqhhwrd6NepnpLiSBzLzrmmY0EspwcIrg9OSbExZmpKH800Ay+OCe
 +6iTSFTOTCgomJaAqaPu7goPEH1DPWexEaIqvzLV7IZFALmKPjsg==
X-Google-Smtp-Source: AGHT+IEtDz8nS0LnJuHg2bK2ibanvfajp8bOj0q14aBJnM9JYhajrER/8x/LumfPRlsgmbRO6gIg7g==
X-Received: by 2002:a05:6820:5054:b0:659:9a49:8ed3 with SMTP id
 006d021491bc7-65d0e1c0deemr565453eaf.7.1766100151801; 
 Thu, 18 Dec 2025 15:22:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f4b7c42sm440505eaf.6.2025.12.18.15.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:22:31 -0800 (PST)
Date: Thu, 18 Dec 2025 17:22:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] env: Add single to redundant environment upgrade path
Message-ID: <20251218232228.GP303283@bill-the-cat>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
 <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
 <20251217205610.GF303283@bill-the-cat>
 <bdfbfcbc-74f3-4191-b4e9-b4de0e8cbd16@mailbox.org>
 <20251218135853.GG303283@bill-the-cat>
 <0af71280-1b23-4439-9f85-89f4341b084e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="egSsFzd0ayVHA86B"
Content-Disposition: inline
In-Reply-To: <0af71280-1b23-4439-9f85-89f4341b084e@mailbox.org>
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


--egSsFzd0ayVHA86B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:09:28AM +0100, Marek Vasut wrote:
> On 12/18/25 2:58 PM, Tom Rini wrote:
> > On Wed, Dec 17, 2025 at 11:58:15PM +0100, Marek Vasut wrote:
> > > On 12/17/25 9:56 PM, Tom Rini wrote:
> > > > On Wed, Dec 17, 2025 at 09:12:33PM +0100, Marek Vasut wrote:
> > > >=20
> > > > > Add support for converting single-copy environment to redundant e=
nvironment.
> > > > > In case CRC checks on both redundant environment copies fail, try=
 one more
> > > > > CRC check on the primary environment copy and treat it as single =
environment.
> > > > > If that check does pass, rewrite the single-copy environment into=
 redundant
> > > > > environment format, indicate the environment is valid, and import=
 that as
> > > > > usual primary copy of redundant environment. Follow up 'env save'=
 will then
> > > > > store two environment copies and the system will continue to oper=
ate as
> > > > > regular redundant environment system.
> > > > >=20
> > > > > Add test which validates this upgrade path. The test starts with =
spi.bin
> > > > > which is pre-populated as single-copy environment and then upgrad=
es that
> > > > > environment to dual-copy environment.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > ---
> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > Cc: u-boot@lists.denx.de
> > > >=20
> > > > For merging, a cover letter makes things so much easier, please add=
 one
> > > > for v2. And, I think this needs a Kconfig option. I'm sure you added
> > > > this because someone has a valid use case but it's going to grow too
> > > > many platforms where that feature isn't likely desired. Thanks.
> > > Do you actually observe growth ? Because this is calling existing fun=
ctions,
> > > so the growth has to be in units of bytes tops.
> >=20
> > A good question, I was assuming so but checking xilinx_versal_virt (a
> > platform with redundant env) shows yes, it does:
> > 01: Merge patch series "fit: print conf node compatibles + use property=
 string constants"
> > 05: env: Add single to redundant environment upgrade path
> >     aarch64: (for 1/1 boards) all +96.0 text +96.0
> >              xilinx_versal_virt: all +96 text +96
> >                 u-boot: add: 0/0, grow: 1/0 bytes: 84/0 (84)
> >                   function                                   old     ne=
w   delta
> >                   env_check_redund                           316     40=
0     +84
> Correct, and the growth is minimal and gated by ENV_REDUND already.
>=20
> I think it would still be good not to confuse users with too many additio=
nal
> Kconfig symbols, but if you insist, I will add one ?

Yes, please add one, it's 188 platforms that'll grow and I do think
migration from single to redundant env is a niche use case. Thanks.

--=20
Tom

--egSsFzd0ayVHA86B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUSMsAAKCRAr4qD1Cr/k
CgDtAQDplaEGQ5s5yw/hAkC478vDmWgpwmGLxRkfFxu+5yHKHgD+JgwYpxVVL+cS
xOBou/TYs3Kj0vQ1xSY31ELhc7ZYHwY=
=xi4q
-----END PGP SIGNATURE-----

--egSsFzd0ayVHA86B--
