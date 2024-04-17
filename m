Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238F3C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 20:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8562E884DD;
	Wed, 17 Apr 2024 22:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h7AxtGlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3296B884DF; Wed, 17 Apr 2024 22:54:32 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3BB88134
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4349685c845so785981cf.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713387269; x=1713992069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qk0NdJG25qScj7UjJT7PZOEN+sIBVIBPSHVrn+OytxE=;
 b=h7AxtGlHfvvfNYvFFdxFYsRGl3B93aMeZ25/zDDO58N+wPVBHd9BQL3Odz1nBk4hnw
 yhzjCxtGhKzkscmP7Z5/frnAGvMHhPWVvNrMBVeAe0FeW3FkBGnVae9s4UFir3tVLhJy
 T5x+WMqBDZ8H7v8jKRKqmQHLv2FaTJ3Aod33I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713387269; x=1713992069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qk0NdJG25qScj7UjJT7PZOEN+sIBVIBPSHVrn+OytxE=;
 b=lnkIHYqRHmCU0p/x3m9tkNsRonuqvWK04IKjWsckoyWsp7nJ6h8bWfry9YmUR8J7Kz
 ewmALzYMS84n+aQAOHLrV9d373WcmSydOzroc3jAolShE9m82aBD9GRQhW7ZwEMHP23P
 0UCGT7SMv8sNVMci9eYKUXETVYZ3BQYCFBLdOltKnjiuYZV3mpOJYHV6X7guOmmGcVjf
 XorNwscI1YriUmsAzIPNlDlAE2kDO5yOzGKhtMAWFtL/xOq69ToOlOCCmWK3K/P0GZ4C
 cOsj/M8bIaQoB3b05dq8Ya2FPdrShYPq7Uc6pr+0uAPG44SZTUJhfrok2XwVxE9YitSc
 KDoA==
X-Gm-Message-State: AOJu0YxK8RgfLyS8OpADfIVj+fyG/l2SXOdtclv/3SW8NJ82lproQ9ar
 ddWGium/NoUTGhyvKIOpiWtL5aN1hp+1PYkiYmBkNHPsPr6RjwgVDLMIOra7E4o=
X-Google-Smtp-Source: AGHT+IG00f/ZwjAdug2E8Lz6sKUhfZyyP6QtRkRmgeQRmHjtYyLw6kTwl8ySiWHvmk6ZrroEAV409w==
X-Received: by 2002:a05:622a:1446:b0:436:f533:5f63 with SMTP id
 v6-20020a05622a144600b00436f5335f63mr822577qtx.14.1713387268938; 
 Wed, 17 Apr 2024 13:54:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 p6-20020ac87406000000b0043750412aefsm2520qtq.19.2024.04.17.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 13:54:28 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:54:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240417205425.GG1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416192340.GX1054907@bill-the-cat>
 <CAEfUkUJh27YaUM7kCJ-Y74zhm5VqzLD6Xbw=n1mZsVwjEhj+EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rWzOhgH83VMvHYK0"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJh27YaUM7kCJ-Y74zhm5VqzLD6Xbw=n1mZsVwjEhj+EQ@mail.gmail.com>
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


--rWzOhgH83VMvHYK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 04:48:14PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Apr 2024 at 15:23, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
> >
> > > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> > >
> > > Patch 01 and 02 are for introducing MbedTLS release package.
> > > I have to split it into 2 parts due to the size limitation of Gmail.
> >
> > So to be clear, for v2 you need to switch this to subtrees, like we do
> > for upstream dts files now. And a script to automate the "merge a new
> > release" should be done as well. Thanks!
> >
> Just to confirm, for v2, I don't need to send the commit that was generat=
ed
> by "git subtree add ***" but just state the command as a prerequisite in =
the
> commit message, right? Like what was done for the commit id
> "5b825032957c2613ef2f8f639e949ae02cb5bdff".

Yes, correct. For testing, people will be expected to either:
- Manually "git subtree add ..."
- Use the script that your series will add for syncing, to perform the
  initial import.

The script for devicetree-rebasing handles this already so should be a
good model, I believe.

--=20
Tom

--rWzOhgH83VMvHYK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYgNvsACgkQFHw5/5Y0
tyzjdgwAorOGl3KuIe6kIiArQD7CrCOdXq2lpUmKfv0qcK9WmD1Dao3XSgjR+2iC
yrzLMAYmlyVBQBtjAxl/TdOQaIYpciCO6JQxsnRth1UhJeMffRFgQ2wlbIdovL0y
PBWGGuPCVKCX6M1dXiRRVsGH0qg2hc6dVPIH+kz+uClSJjxBuMuGmuTfOo1mJDK9
92GoDQx6iWTYNSH4iGsW8Mq71mloGG5OcX+UY1WFwDlpMs1xaAT1OOEclgqqfST8
mtBs+2Gz5nZXXz+ztrwgtIXJwMqpYhH5a1QxrpU4duA0yU+EseY5OTFHR4rKaCFt
dk4vn1v3+iS2d0uD9hwlyfg71fisCTtC3kQQqWIRiyLwQppYuJB9nDrzjg1UcN7f
cz/F4tuUFhiTB4mzen0V7q6ekrRPICgpdVFV8Gf9FwgwH55Un7DrqD80UCS9DB1R
XIaXfXAnJVWEplJEWCm88sMNbhLSXFDXrBT0yBb9mo3e3mP+87lPiYesc1tOX6LI
y8bu8kQj
=Xien
-----END PGP SIGNATURE-----

--rWzOhgH83VMvHYK0--
