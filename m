Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6856C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 16:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2934988CA1;
	Thu, 29 Aug 2024 18:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tTrVLOV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF27588C1C; Thu, 29 Aug 2024 18:48:55 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CF688CD2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-45677965a0eso4705851cf.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724950132; x=1725554932; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/xZh8RJYACUx1jDNIcq5rwpm2cPcm1rSM9FI8hinJ50=;
 b=tTrVLOV7uehvNLY3JP+lHg3WliyUCfJfjoHGM2cNzy/iXdhToe+Dt9ljJxj1CmlHIP
 FrC2zMTeJ6GNQpGt1JMBprJqWhOmHr/oKbpD7KU3u6pPWQEx2jsOmgakjTMmBaWanl8j
 quC9OHMvB+fSFecFku48oKgrKF3/Gy8UjhMKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950132; x=1725554932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xZh8RJYACUx1jDNIcq5rwpm2cPcm1rSM9FI8hinJ50=;
 b=wneekN68KYzACGSXhibgBfyv1pY7F7Y5w9pMjDX0tLEUk38msXH4pjM9sX/Ny+gTq9
 yfJ0jTkt3vfIMBWfVLRQKmCsJpvuExE1Yg+s/hjMIeXjEwM5dgGSgZzI3i5GqvcqvclH
 EQAOBcxam7oZF+RT0uozuxR+aKbGmboHBVRG/qppxQ9ylZCV1aTIEcbQve1YsRoAv1dV
 ksxxM/X8rwWbpbpYrB1FSalAHIeG1jZLJSfKnULZRIWq+N9RjS43XnYosMuKzj/JVTtf
 Zdd2vGoG5y++c7/UzUxFSGwVp2boS+/nMkMRbP3Oy4iL2i9bje3X40TnCDOlb3GMe6oo
 avAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBUSbEvmXh1JFvp2h1n6azff3zD9vEryRPBi+sEX8dQgUbc319QKUtckRD5h3ElM4GA6unuNg=@lists.denx.de
X-Gm-Message-State: AOJu0YwJXHOYS+kQWvy1AUiDmd3EYs2vu9qMulLGM/+fNyoX2eShm4xA
 qUkDvUAN8QH0yUjSr89Wx0f2+PqlYJRDc9p7dHdVsHtkhdkuUXKHF0ow4FfSVts=
X-Google-Smtp-Source: AGHT+IFGVPioqcPwxVkB85To0n9vUhABf3yjYeeNMoEE1Ug3CAgGmuK48LIYsm3HQiuEtHBKwHVJog==
X-Received: by 2002:a05:622a:1b0a:b0:451:d75e:abb2 with SMTP id
 d75a77b69052e-4567f5271e8mr38362301cf.19.1724950132221; 
 Thu, 29 Aug 2024 09:48:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682ce5b05sm6302101cf.51.2024.08.29.09.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 09:48:51 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:48:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 03/20] test: Pass stderr to stdout
Message-ID: <20240829164848.GF2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-4-sjg@chromium.org>
 <b2a176a0-f3fc-440c-ba59-8bb97fb858dd@linaro.org>
 <CAFLszThcq98op7bcJY=-tW8EtVe6yav43tA0WnoXRiybdjDgaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zb0xPCbwZLO9nSQ5"
Content-Disposition: inline
In-Reply-To: <CAFLszThcq98op7bcJY=-tW8EtVe6yav43tA0WnoXRiybdjDgaA@mail.gmail.com>
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


--Zb0xPCbwZLO9nSQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:01:11AM -0600, Simon Glass wrote:
> Hi Neil,
>=20
> On Thu, 29 Aug 2024 at 08:22, <neil.armstrong@linaro.org> wrote:
> >
> > On 29/08/2024 00:08, Simon Glass wrote:
> > > Some tests may output things to stderr. Ensure that this output is not
> > > dropped, by redirecting it to stdout
> >
> > Can't you make sure to output all labgrid output to stdout in the hook =
script instead ?
>=20
> Possibly. Do you mean having the hook script redirect stderr to stdout?

This gets back to one of the points I was making. In this case, "some
tests" is what? And then, what's even going on? Are we missing output
that we should be parsing? Are we not catching errors? Or is this just
related to how today we have for say the filesystem tests so many
try/except things that we inadvertently need a series of failures?

--=20
Tom

--Zb0xPCbwZLO9nSQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQpm0ACgkQFHw5/5Y0
tyxA6AwAhluxBz8wrPZc/Zs5qISPPYEKx4f7DFG0QYaNpUIG5XdsfujgxXNnLStQ
HJdZvM8Y//K4ZMoAZSCfcjgwLEL2XstmgtVJGv0aTKCjSsysDDoB94rnN/9dMKdz
6v7/Y1gfa4Z5/dd8+/1IqW9N42Vcuyw6NGwQ9qushWZ5X71HTAWN2Oc75G9K0Xqm
zgS2tunpBfd8u/lZ8sbInYp9YYD5kTID1Jr0T/Pcr9aFy/tGadH67m9wOZPvSP+T
6+B1fUcQ9ophCKCqR8Z0JZqsew4Ht0w+itYLnnO13gGqE6NuoJAU7lJgx5j0iXbH
oxtXRJU56CtBdjISb8kP4Q7XpH4G16PfGs7rsJB6PVIyW/fSUUT1zmreuKPXqKsH
JvllhuHVeYnxAmZz3qLEUIfLBMSo84p9sy/vKtJ0FhA8hfABDQ/kSI4SDVVwIKum
MknyvHr3OplsKdCj9DizXx9ccOc5IjdSNnsLqaGfOk9J9y9YhqUQkkRZGzzuHg/F
12UyOAoC
=jP+g
-----END PGP SIGNATURE-----

--Zb0xPCbwZLO9nSQ5--
