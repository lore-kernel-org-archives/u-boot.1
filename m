Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D865EE77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 12:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9837B8947D;
	Tue, 10 Dec 2024 13:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJPh60Qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B80389787; Tue, 10 Dec 2024 08:08:54 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CAD897BA
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcus.folkesson@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53ffaaeeb76so2514429e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 23:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733814531; x=1734419331; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=abzXTgzyJi5h3EVT953bA/F/8mm6Cy0yi4rr5ZRwvCc=;
 b=KJPh60QoxquQGyV0up/K7+gwOQNkMRh4RkvJNrT27mitOWi46QzWiznfiCOKj+WVxn
 Gx4pR+0pBD5b1Em0rheNeBrehOufK7o03nNexAVAp3gsy0LjI/4oulE/f9+xnmHSn4+0
 Y5BdrWlNBkrRxJr6074Y9LE+pbV1mDhMb3YwBEDsY+gvwxSL4NPjUfRctxAyjVUcacsw
 TwfLZTJA+y4Y5WoJ5RCnOhK9hmyauRDL3+MlkPoro8M1jr6ZofTNlmPcfJTPc+j75/lt
 eKJGqsF63BhPVY3yqBMLWgGo/dh77IMZXgmA+0FZ6fLDgo66BptcFlNrbeBz0frDOuge
 PQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733814531; x=1734419331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abzXTgzyJi5h3EVT953bA/F/8mm6Cy0yi4rr5ZRwvCc=;
 b=QF0e6zWFfgWtqGaNBz/wz27FXxx/oIM2Y8u7rPu9aoBnScL85L+4q6es5aRqKCty4A
 Jtldaya/+hokj4+f8UH5Gs581SkHeIFhBGzc2kTOrLKeGEmvVOAe3xyma6RxM1y5lYMN
 ZA0FL5idiF5Jw58zPicS+NHS3ew/XfYhqkajJenScezLG/lA8UnJ64oZdjAwtG2/IzqH
 ZXun41R9UzQyDoaQhCYL9Z4U5owHGIUL8EpeKM+b7MX9rEAJ3rp2cpBXTR5mXsQCRkh9
 10r443ja/Kgi2T8raPA/aSsEgQofkju2b0NlbOYNiYe1LifJaIeB1ze3VBzKeFs26fGM
 Lu8A==
X-Gm-Message-State: AOJu0YxAGdNIeWikwEcXgXVG+Y8QUm/DV2WZtqnEww2Yx0xowyeC9XdR
 38of1W0JV1+N9GyVZX3O+fuoVKvor+D75+i5tBvwrf6xgLKqLsBb
X-Gm-Gg: ASbGncu/s+SLmv3Bdyom9w0DCh8/T0WSdnR3OkDs+DkmSQMORXzO+G8/G2/SR7aiceA
 smQMbZwohtosuIOJJKRwQWHkePSkAjEm9Bko74kgXv/ZJaWs/uDPlCUW8xOzBONig6d8JbFWZPN
 fWAWyvRNyLLtRlfDMrVMIQfZKjgs4x1BB0ngqWHn6AQWrpLLw9gyds0+J43rvzeUmjbzhR+vCwq
 Y9gaO99Jradca0SNQbgSnRecc1qmIX3rGZekSoS8I7WC/TuLbxAqkmSRfXsUCXGpikpVUAI6bx0
 WmKyJ86i8FTRcVQ=
X-Google-Smtp-Source: AGHT+IHLZJ1A0enlGWu3GvjbcCLJCY0Yf5bbwIBlaJqBs6Aza5MsCgmx8UPCBHpo7SRmbC1OvXUAVQ==
X-Received: by 2002:a05:6512:3b13:b0:540:274f:a494 with SMTP id
 2adb3069b0e04-540274fa588mr183225e87.42.1733814531046; 
 Mon, 09 Dec 2024 23:08:51 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e8e0b2d0bsm966232e87.47.2024.12.09.23.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 23:08:49 -0800 (PST)
Date: Tue, 10 Dec 2024 08:08:47 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
Message-ID: <Z1fo_xrE8jLve6pK@gmail.com>
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
 <ZtFt4rBOzF7Qgm-K@gmail.com>
 <CAOf5uwkhkCuW-st6ZnEVcQv6gDuRXSog_AQh_KQCUECFuyZ3sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kiMZ/VICOZYkidzs"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkhkCuW-st6ZnEVcQv6gDuRXSog_AQh_KQCUECFuyZ3sw@mail.gmail.com>
X-Mailman-Approved-At: Tue, 10 Dec 2024 13:51:03 +0100
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


--kiMZ/VICOZYkidzs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Fri, Aug 30, 2024 at 09:05:27AM +0200, Michael Nazzareno Trimarchi wrote:
> Hi Marcus
>=20
> On Fri, Aug 30, 2024 at 8:59=E2=80=AFAM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > On Fri, Aug 09, 2024 at 02:15:43PM +0200, Marcus Folkesson wrote:
> > > The condition 'ret' is always true as it is never set to other than
> > > -EIO.
> > >
> > > Remove 'ret' and the condition for copy.
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> >
> > Any more thoughts on this?
>=20
> Reviewed-by: Michael Trimarchi <micheal@amarulasolutions.com>
>=20
> It will be included in the next pull request.

Not sure it got included?

>=20
> Michael
>=20

Thanks,
Marcus Folkesson

--kiMZ/VICOZYkidzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmdX6PoACgkQiIBOb1ld
UjJ42w/9H2pgOlq6HJK0JpoQaz9Q8HioQEjqW79D8v3nAKaJcsuToQWGEY/VL1Wn
5o5wn3fdYWESQTmLRMDMtOO8JCLNx+L5CHkIh66FlaZr3Hdjolb8KyMecEmqN21z
DYmpPZ4PE086QhuXWMx1LBNnmceHOTUZMnycekw5ADBU5q4MMigSuGY/DeqJIN9P
j6ZWtLswqzZYYmrtIcU7mhV79k2Z/tvIefTQwPMhKSahSeZVpMsIF9/RJNMaus4K
J5jldZC03uBzV817Gwqyd/GDcEj2NJlTVwIj3KsEDdm28LYDTmdwfbVUqNlxQ7PP
u/n20znbOyFysF7APes/x3w8kmgMUfVI0I24FjmVCI2Ac4que2zkUKzJ0+IKoBQ7
rthn1nBp1nPkdpU9Dm3ACOvZ/XU7/E7+49UiMNkTiIB8O9UnnvEQl23nfbjj7uqb
46TgrTW6Gx9YEo9A5yR/or5xextvabdKBcMI4EVvclN1Lt/r7KsnoSey3ec2xoGO
7OLJntouIfE5dmLzMpl4IH2uX+Yx5xA7bdT6AriOw3cyB5mUP7eFOcbF063o4PaK
Q0BDUwROtpmHPu007KJSk2ndpEcOc+suYGdTZWjcKHze0lKpWzjXpy0GFB7uwXQC
Uu8ydLn58J9x0I06CSGbAVk8rh6mlI/zO/O2Ao+uhHK9Jm2H9O8=
=4rBP
-----END PGP SIGNATURE-----

--kiMZ/VICOZYkidzs--
