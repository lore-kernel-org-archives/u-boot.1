Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F36C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB15D884D5;
	Fri, 24 May 2024 17:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDFVDEgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9E388651; Fri, 24 May 2024 17:26:53 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631F488270
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6ab9dacc38fso5392726d6.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716564410; x=1717169210; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hlaXwHpX3LtDG0damQ4KXP+5C9lRMZVyPw9IzrjWUKg=;
 b=VDFVDEgvvap+rxi07940WemdOzTVuGQYhcoP4t6mv38GiIHpW81IGcvCsFiAOZDk3O
 C/a+I6LZAaXdVoTcv7rJqEsnsP0auWLmj3Sf5o4BW1BOyKI0Ra/wysuIFS7XXSlBoEVl
 r6ehIHUURUZaKiVEzFjioQKQGzaY+flLIGx04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716564410; x=1717169210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlaXwHpX3LtDG0damQ4KXP+5C9lRMZVyPw9IzrjWUKg=;
 b=V9NhcXyOqfWgZdabtm5iHlmhvTnpn5IdGWU3DDhR+MWxIMNWUwfOvHeKvaGr+Zudss
 SvoaVua0J75NU+L5fULaJWdUZBdPjG5OJGEebiluUCFmI8/6VZdN5jCsCB89pygkHczk
 EY7XPmbX9tQ10LMUmzFMtORrXaThKUosXdGFZWQm+lkW8Esk9YAuug2hH61V2Ga1H5rU
 COM6RkGmsIl/BJAOT31SNlQX65T/nFe1yfHlOE0WB2Bf9ND7WwVFHe/4Z33qmokdekic
 F72hDiWV4wRqoFf1UEGQJQnNKfCODsATtW2RzpcHZx11tOEKn7o4KG6yB9pmosZCKLZs
 vVEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/51EW3PGVYi2bQM0vr7TUga/lwgVLnGzRTpnHGnuk2800RpN0h6mYdb4aw3MJi3gRlx50A7Mwvy6JbADqSVel9+WRLw==
X-Gm-Message-State: AOJu0YyFvWZcBuxQRIc9TxY8qpsJ6rIG6OwuR87HtN00ouqCf/iPyFTy
 ttLf01DURcObzYWZ+jP+18Qf8XWZCHsHHjHwSL1uMBGcHBmhfXW5CXOGLS4rE+I=
X-Google-Smtp-Source: AGHT+IFxTGTN+t2kjg/rxlmxsNS1fp7n1epJ+aQpCS30nLNW332pCZZrsDlDzFUnHOy5VM2ugodaJg==
X-Received: by 2002:a05:6214:328e:b0:6ab:8b9b:aa56 with SMTP id
 6a1803df08f44-6abcd0d3dfdmr23959496d6.49.1716564410026; 
 Fri, 24 May 2024 08:26:50 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac070f05d5sm8210826d6.50.2024.05.24.08.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:26:49 -0700 (PDT)
Date: Fri, 24 May 2024 09:26:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240524152646.GA2568172@bill-the-cat>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20240507154836.GV2568172@bill-the-cat>
 <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gpn6u2Nm1VQeee50"
Content-Disposition: inline
In-Reply-To: <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
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


--gpn6u2Nm1VQeee50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 04:09:00PM +0200, Michal Simek wrote:
>=20
>=20
> On 5/7/24 17:48, Tom Rini wrote:
> > On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:
> >=20
> > > + Tom Rini
> > >=20
> > > Do you have any comments for this series?
> >=20
> > Seems likely fine. Jagan, do you have time to put this in a PR for
> > -next? Thanks.
>=20
> No reaction for quite a long time. Can you take it directly to next branc=
h?
> Or do you want me to send you pull request to get this to regression and =
see
> if this breaks someone else?

I will (am now) taking a look directly, thanks for the reminder and your
patience.

--=20
Tom

--gpn6u2Nm1VQeee50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQsbMACgkQFHw5/5Y0
tyw8igwAtk/vZopAIOkgenES21blUaej79u5rqRkLEXCQ9n3+3SeziwttAtdZK8V
3iL5Y1GmdB3qGsJx0pgIB4H52ENkfBGzeFko22PAd/HNIa8VDwQqE7UOnrQM0g2v
t6QvW9iFFyaHpOLEh7p4qRmU052qvqn7sSFGHYqK6kEJwjgaDzNcaTmeWcCMaSe3
IpfmTZ03EUPsd5MpJeOWMLGGwg0M1bMMfNjDvjvMZAbok0qSK6S6HDs4DH1N0SUF
q3efocdecMfOOSvn4thvz7kxjwk+3R0JE5MENwxJNMCr8IEr+1V0G8lCWoXqmS0n
lmZMo02bFDPfqp+XTPnAv/QboXGm6UiAqLhNKBqti0+Zi7JoCeefzJHQ5Xl5RGZB
2LD73mxQa3cXUExeA0xa2mhwf3FEA9mcR+nrhU0viekaCFR4gWGlnv6VZwIYoTVE
KA1yCXGZBxyI9fAjJ1itswWzYORlhtRrGSidBJXuUntQCP0y55Ei5LxO3uGWsXXz
U+iOvrWx
=sFa2
-----END PGP SIGNATURE-----

--gpn6u2Nm1VQeee50--
