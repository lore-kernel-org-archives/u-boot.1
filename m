Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0552AD2B941
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9354788F48;
	Tue,  5 Nov 2024 16:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qj3qgfO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF94588F48; Tue,  5 Nov 2024 16:47:49 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D4D88EC0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b147a2ff04so428979185a.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730821667; x=1731426467; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/rpo/wE4bvs+iWQTCUBr3li3CArZO4t7JmXl7yoCm8=;
 b=Qj3qgfO7bYHEFvy51YrbGDDBXwWJJurlsjxvT67Esv62Yh2qRd5Pis3xQDtxJW3rDW
 2wyYvWi217Dx+4fignoFBd9paqHGpn/MKTT/JJl/rIMBUbI3MAf8tQxgv9v2BkFaMjKj
 Bf5Lkw+SrpI5hAE/fH7TEZq1ozHF/iuBNBxSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821667; x=1731426467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/rpo/wE4bvs+iWQTCUBr3li3CArZO4t7JmXl7yoCm8=;
 b=EIZkQo32Vmf01GpJdIDLqWpjsH9U1s9w9gtOELwlD9KLYzj3NGHyBJgmUqQ1T4cd/j
 FxMwow1cNISK9RyuaJP6iwla6+gZF2hfAwwxTsjU1jMOYzlGzcaCEA0sJbc7RGtQjrgX
 47Dr7xWZiczi1o+sPfT446IfVkGeiPhq94ASlHxvoK9nIctmbzOkF09xRSZ6j1iCgs2z
 2IEbMetJIusMhcOrj1aLKuEqEHxzoW/63p41xa+542V+LcuLcs2erln4i0t3WgE7hqYC
 jftTo0X4pPWMb5wcV+RJQqHm74GBo7tQ+py12UT8iQicC2aOrrpp0zmHb8NALgkM6dal
 AN0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNRhFxsJXLRTccV+QTW3CnsmsR48FHVnTdinJmps9hBEho7/KrTUnwa+vCQ0zr8Ts1C6KA3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzbiS7UEd1dRJzhwGsIv+5zVXLu4VLgQUFLHYbyzH6ppPCVT2oO
 /3+/jdpzPgwv4olvdJcY9LQ+KmrGVGGCtRUzqZjKcpW2jqgkSYlIyKZHEsZm2vI=
X-Google-Smtp-Source: AGHT+IEkfw7X8PUrF79pUlZXTVOJtW6A2Vy9aKEZbslT2SscWFWPaSOD94kMqy715H9L0vKPUIWk0g==
X-Received: by 2002:a05:620a:4409:b0:7b1:43e2:712e with SMTP id
 af79cd13be357-7b2fb979a54mr1946878885a.17.1730821666275; 
 Tue, 05 Nov 2024 07:47:46 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a6fd30sm535033885a.88.2024.11.05.07.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:47:45 -0800 (PST)
Date: Tue, 5 Nov 2024 09:47:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
Message-ID: <20241105154741.GI3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AO7u54M/3qcMIF7w"
Content-Disposition: inline
In-Reply-To: <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
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


--AO7u54M/3qcMIF7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
> Hi Peter,
>=20
> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> > > >
> > > > > Legacy TCP stack is bad. Here are some of the known issues:
> > > > >  * tcp packet from other connection can break a current one
> > > > >  * tcp send sequence always starts from zero
> > > > >  * bad tcp options processing
> > > > >  * strange assumptions on packet size for selective acknowledge
> > > > >  * tcp interface assumes one of the two scenarios:
> > > > >      - data downloading from remote host to a board
> > > > >      - request-response exchange with a small packets
> > > > >    so it's not possible to upload large amount of data from the
> > > > >    board to remote host.
> > > > >  * wget test generate bad tcp stream, test should fail but it pas=
ses instead
> > > > >
> > > > > This series of patches fixes all of the above issues.
> > > >
> > > > I know Peter asked on the last one, but I want to ask as well. With=
 lwIP
> > > > merged, why do we want to add features to the old stack? I can see
> > > > fixing issues, but not adding new functionality as well. Thanks.
> > > >
> > >
> > > Let's apply this. It has tests and the old stack is still used by a
> > > lot of boards. At present lwip is only used on one. There is more work
> > > to do on the new stack, including finishing off the sandbox
> > > implementation.
> >
> > I agree with applying the fixes pieces, I do not agree with apply the
> > HTTP server pieces. This series should actually be split into 3
>=20
> But what is your objection?
>=20
> I would much rather just apply it ASAP. It has already gone through 12
> versions, during which lwip has been prepared and applied.

Yes, and to be blunt, the first bit of feedback I provided was "can you
please look at the lwIP series instead?".

> The HTTP server is a useful feature and we should be able to use it to
> test networking in U-Boot in a more self-contained and performant
> manner.

I very much do not want to add more features to the legacy TCP stack.
We're likely, long term, to still need some cut-back version of the old
stack for the limited SPL cases.

--=20
Tom

--AO7u54M/3qcMIF7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqPh0ACgkQFHw5/5Y0
tyxzDQv/YwZEPYa4U0gdN3WJ//kZBi0TbBMsZkpDCtlKoZpLbtB37A7Njwtt2ouN
fnoLtP+RjBvCwwNAH5h4wNYOoKSemLgMwj68HyBROsFc6Czoycm+5trm4lhkoz8m
JKEe+zzoSD3KLKFbFMncyy97HZZrbEdC8Zkbp38kjR/8bB7OCP4OukgcM/eim78a
pXFZGMCynQtX5qKtra+GpiJsjJVafEfOqm7rQcwIG5/Gd/kofgsmHYI2Hmn90ENC
JIcBIiLLToNHlFkpsGe2K/SnL56nROtC0syfYf2YMxAzlNL/UAD1upsXUqyyr1t9
vO2TtvDZv9tP1McVaVXIe73+aSc/7skc+B+SAbCKr5lFnfQSEReaOWJT9rS+t7vy
a4vcpVk5sAQQbXfrp0GpBqdUepi6w4HS2b7EMHYiKzlHVSaXKq71xLzwl+RM9y4f
ICoAl4LYMhte+ILdwM+nRu8EZ91tY/UuKd5t4k9cErIsk3gDjyXw5c7E3v0vjUin
12RZo2tx
=LAOu
-----END PGP SIGNATURE-----

--AO7u54M/3qcMIF7w--
