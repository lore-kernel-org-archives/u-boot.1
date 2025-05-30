Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF60C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 16:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F368334D;
	Fri, 30 May 2025 18:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F2ndKaXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3231833AD; Fri, 30 May 2025 18:59:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8E983303
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 18:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-735b9d558f9so513890a34.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748624352; x=1749229152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gYXmn41v6UANtg0ZHcJAXfZpsSU0px56pdASlXhcZs8=;
 b=F2ndKaXq1zFqe0JaxGSUj6q4pTZ1lUJOM4OXlpwFbe+fMU5m2p2Tp0565YHIEmwDmB
 6E6FUx7HM56BH9abxwof8H8ERVMromsFLcWZGmeyzrU1TqDOKFtknJtZ2G8eNRo5g0pI
 3qpWQhO+xoveO75c/8r05vXK3r/5n6FNZWx1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748624352; x=1749229152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYXmn41v6UANtg0ZHcJAXfZpsSU0px56pdASlXhcZs8=;
 b=TIVY5V16JcGPN1hiS6wVwDFaHEE43MipBJT49kld4NhVZHUlvIM/t4gB1dObbEkSpT
 tU2ffJ3Z9MXjWbxrAh+kJl3uf3jr4M5RRBZA+umvJQnKwryNGO9d2UU46Oje27Xx7Dzd
 pLaO2uymmZaiyjhLzJy6Ub9n+Yn4JFuNQdwB46ew2SNJOx7uvtYLPTAzLHgzbSOyQA5+
 Om6/+KXlMNnpBPISQRKsdkJjF+EQL7EjHKarUWevZRFXQUQcyDbaCMnGZI71lFbudUGx
 log8b0iLDVSQHwu7A6F5vVvGsCZ6k24XE0E3vihmxcY7eZHGGPnFjvTtF5K+0aH3AxJG
 /Qdw==
X-Gm-Message-State: AOJu0YwVbop4DJJYWjNqgmhWugD5Pqu/qjr1Sc6cApoBXZClUE0fg+ew
 nB1zYySKWKYzuprAJMBBLg9dVN/ZtgWr/q5oiiPONVBDKg3Cc1ZtBSgh2BdrNSltomE=
X-Gm-Gg: ASbGnctLpekt+PkkkKp0gLK+rFEoBCxZIkIUo8Py4ezbyxx25ZudQzfxzTc/gfhjQ5S
 u6XAnPs/TsLWf9DEJ6q4QVYsU7RNnopVLAI2NJiarzLFAcbBjez7lH+SNJqoHU2cfa1eq3x26uW
 cMYYrsu23dl/srZ0+cySPIF08Z5phyH7lZA6llcgooCPae5Akq5Z+vUYj+xzwyVUxM5GlxLmMjE
 LWWKnKrBmCTpjpfQNqJYeKzJhYFgaKtu/pf/4QIwy9Em8wFYXNzEQdTy7rEjrbVbWs/zuw84j8W
 zO9RuEY9iM8DGrge/XTuRwktuHvZDX796vOAZcZhjTvSwS5eSF2NI3f2vliQ8kW4QCvwmlHv7Xo
 Ekr9uw24+boUL
X-Google-Smtp-Source: AGHT+IHEHf4FX23tiSFWegs+VDr7tGYqwuYDWOGwpreD5gpckzRBCoSdRF+dMC+nqJQMd2efK0MlaQ==
X-Received: by 2002:a05:6830:3744:b0:72f:ff8b:e123 with SMTP id
 46e09a7af769-736709f3a8cmr2595718a34.12.1748624351897; 
 Fri, 30 May 2025 09:59:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af855e77sm645095a34.23.2025.05.30.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 09:59:11 -0700 (PDT)
Date: Fri, 30 May 2025 10:59:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Azure runners
Message-ID: <20250530165909.GU100073@bill-the-cat>
References: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
 <20250530140650.GT100073@bill-the-cat>
 <CAFLszThB6uWQuAM2e3UP1_x1qRWjBU24cLYApjs8RSN7oSHHTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XXmd1pnaaHOgpdox"
Content-Disposition: inline
In-Reply-To: <CAFLszThB6uWQuAM2e3UP1_x1qRWjBU24cLYApjs8RSN7oSHHTQ@mail.gmail.com>
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


--XXmd1pnaaHOgpdox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 04:42:18PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 30 May 2025 at 15:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 30, 2025 at 02:31:13PM +0100, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > I have always found the azure pipeline to be slow, but I found that it
> > > actually does support having your own runners / agents. I set up 8 of
> > > them on ruru:
> >
> > I had not seen that before, can you please send a link to the
> > documentation you're working from? Thanks.
>=20
> Hmm, actually I used Gemini, but here is a link I found which looks
> like the source:
>=20
> https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-age=
nt?view=3Dazure-devops&tabs=3DIP-V4

Oh right. I think it wasn't clear last time I looked if you could mix
pools, and we also didn't have enough resources to replace or augment
the Azure agents along with Gitlab agents.

--=20
Tom

--XXmd1pnaaHOgpdox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg549YACgkQFHw5/5Y0
tyyT4wv9GdFn4lCMQ1fyyEItnZPU1MU+SO6dbOfniv0eFe2623JjJOs5Vmd0twol
K5iTxocZYFP77f9o/63raBlYG1u607yIjEXjeBzaSGQhTt6XtoM07QZgOM1udBmI
Vyfgp5KsPNjBD67Q784J0+PysiaxFLi1YyPd2309iRminDfe2kUgEhqG7DveudQ+
b5DXc76Z+Yd6KQXdED0K0fUoKfUHTzKW/8AHoU1NAu5p22IOyYnVOBhf5SEN1QsP
EI4cudZ+z84ubQRZMWvBYukjv31ZQjQ+WsTbgL1JOAkAe3Okn3UxAxIUUXutjI9Y
zrY+RThUA7yodcZ6wxmsslM7KQZxkMmtJ/PHvaSm7DPg1QCr+jRVa0Fq2u2q8KeX
Qrkjm4QKyunZ0jqE/wv8EYJGl/BEl7oEAoDyAP+9v5pwk0OBjaFCtO7M+I/amL02
DjCGL4xU5GJw3tTscD9JiH1bVOByK+d2pu4G99rvYaX1QwVoTidlXqAsEPqd7D1I
REPKFmLE
=W75a
-----END PGP SIGNATURE-----

--XXmd1pnaaHOgpdox--
