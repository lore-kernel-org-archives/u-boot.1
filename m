Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6FEC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E451809A5;
	Thu,  1 May 2025 17:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LCLH3uZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11548809D4; Thu,  1 May 2025 17:30:22 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6FF8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b82c8230aso317410a34.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746113418; x=1746718218; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SFXUoC3FjB5NBaQoXiREV2pGyPNGD/Wuil222Sxgcuk=;
 b=LCLH3uZbxXMum7zccBEZ/c5ghOPZehrO6YRSB8otWp70SlE4yG8fQCBvqWX6D6lFgw
 v0ulM0IPOn/EYfgyiwMrOWLTpgaeN9DmE9aFfWmn7N212k1J3EpvaiQHRRB8PXi6T4+e
 7W112ZPKfDGry0XLzhaHVFVtB9BkwMf/G/E/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113418; x=1746718218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFXUoC3FjB5NBaQoXiREV2pGyPNGD/Wuil222Sxgcuk=;
 b=Pd7XWopHSyv7NSHi1fc8z677l83WFfRz2Fy4YD9DrAIv5e4/ma4YpzZM0gu3YBSmVZ
 y//LaMabAZrZ+DDQD0rXrRr9L7Znnj9ISWCTqWSySAYYyKa3MDACeLgWgW7xawfBx5Ss
 GMctZMykPachbkzqugfYwKj/EcY+1qJ8YdDw4d3Wzw7N0U+LZrx/rnAnvF9bBe/vEVoD
 ChBFGz4u3jxrpFlxIS3mja7epQQWwnU0SeqQCqYd+FNaHAcIBCBf9R14GxcrSqkWqYw4
 C18TGzg7FC9j5AUTBxjnOy02/pU7jQyP0TkEkb1BLtEq4c8sjWQn+l49C9KbBMAWhOID
 CBIA==
X-Gm-Message-State: AOJu0YxeZfcNxY71wkLHiG60rnCjZgBZa42FfNbbRlSG/851G4BAWc+p
 L5vypMSS20G/OVZyxYqmbJXI9801RRCRwCph4yz6cyhG04Lu1Tvw7kGfZxIo9rk=
X-Gm-Gg: ASbGnctxE24vG4WaxQi3nfcC3+onJPlu42IuWQ/xTrt/I2OMAdCZsrfD+sI1227wWJo
 m0fSzWXf3CKzuv7qBr0VrDwMu7Z1UzkkwCt7jMi99JbQwx9KVbmnAwuFU7mS47UqfypzJj1ZXr5
 iJfo4m6Uwkep7bsl/ep251k0M67Pb/WfcFOC7MYTcTcxdd3J/rZraY8So4WmzlaEsCGUtVcUxXt
 n3K57OLLw4hPc+XoAd/JKYEOLlSYlO1RJY9Hd1nslnmAiHyyeFOwMaGtLpk1cjhCQbKLdM+pLmw
 h/DCB7Ih9Y+xeQEMU4gRDDHWcRSxP6Zj2hw8gq7coRFwWp+7ALmZ+1uTkFjs8PMWjL/GVztDCJ3
 NoA==
X-Google-Smtp-Source: AGHT+IHeN7vofmr19wEnu9jRLUhweXeRAexAoqH/nweQUlhJMm7wSgKrDP0JGt7pSfpr1KEm+BgHaA==
X-Received: by 2002:a05:6830:8207:b0:731:cac7:364e with SMTP id
 46e09a7af769-731cac7422bmr2669979a34.22.1746113418148; 
 Thu, 01 May 2025 08:30:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31cad40sm139168a34.26.2025.05.01.08.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 08:30:17 -0700 (PDT)
Date: Thu, 1 May 2025 09:30:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] CI: Update the CI lab
Message-ID: <20250501153015.GG1261075@bill-the-cat>
References: <20250501012530.3954999-1-sjg@chromium.org>
 <20250501140354.GC1261075@bill-the-cat>
 <CAFLszTgKbsE0N1AEkwydiQQLMrMRNDtivQWVKmDsESYqZE-4VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sMJiER7wWbP5XLDD"
Content-Disposition: inline
In-Reply-To: <CAFLszTgKbsE0N1AEkwydiQQLMrMRNDtivQWVKmDsESYqZE-4VA@mail.gmail.com>
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


--sMJiER7wWbP5XLDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 09:03:15AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 08:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 07:25:24PM -0600, Simon Glass wrote:
> >
> > > Update the boards in the lab to match the current situation:
> > >
> > > - bbb and pin64 are working again
> >
> > And were never disabled in mainline (since iirc I never saw them not
> > working).
>=20
> OK good.
>=20
> >
> > > - samus and c4 are still broken, with no end in sight
> >
> > Good to comment out.
> >
> > > - new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo
> >
> > Except the imx8 board doesn't work in CI in mainline and had it's own
> > long discussion that petered out.
>=20
> It has been fine for me.
>=20
> https://sjg.u-boot.org/u-boot/u-boot/-/jobs/49094
>=20
> >
> > Please v2 where you drop the line about bbb/pine64, and don't add
> > colibrimx8 until you or someone else are ready to work on the underlying
> > issues this exposed. Thanks.
>=20
> Do you know what issues?

Yes, can you please look at the thread from your initial patches?

--=20
Tom

--sMJiER7wWbP5XLDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTk4IACgkQFHw5/5Y0
tyxLRAv8C1LDow/LPzH2/TgYGbX16V1peOKrTVsFTnd/C9fTBewaoiEAa4tWnMna
wsJayLwhUKv3eZtoWTm1+yQzP9PF+eEiIWBF5qIk3ixwg0mKRXGphUExwI+tENFc
OnqoRTSY5SBGuHp/x0eiI8h0hMkDmRB20TKQDF4vR+S3DTIk1IpLUUTLwSyj0od+
dgxaW1YlAmn6I+ZgAToAGr8muaJiRiCnjqneA9aOf/S5KX3lLGwQp6VwQVCCVZn/
eRZ8NDd9n5HGdUJ4oZDJSMV6Eqo4lTjrqkHS6Jrm/y00OU3bQENkGJ4PHRif53DO
OC/mqcV8yCFA1RF4d0YnSY+Qa/NedYsPs86tsDLPn4x2O43clh7iOqwHDzceLrJa
3KvFPQu+zv+7POHrORpz7AwiPiFlykXt1dkfsgyeFSFkqWTmZa2tO5XTUDHyHQIR
gyz979ZzheCx90vjP9tHKVOjjjwGZ7KZbrIq3N2JTuiPYM4vjwaDZDBuQhG7Byif
N12uHGGr
=fplZ
-----END PGP SIGNATURE-----

--sMJiER7wWbP5XLDD--
