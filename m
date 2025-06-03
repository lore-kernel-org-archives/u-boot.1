Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D01C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50674829B2;
	Tue,  3 Jun 2025 16:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9nwMyLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 714BD82A76; Tue,  3 Jun 2025 16:19:51 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0DD82998
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40337dd3847so3600223b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748960388; x=1749565188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v42m/m4fI+aGLzLMT3zuJcX4AydUlIt3nnGuQ12FFSo=;
 b=M9nwMyLHy7eNk+Q2Z1dUJe/2K5cPHKdGw+777K3EYt/0PoGCmORR2N3ypHfSjOVap3
 UDzPV+fVeUR6mE4j3G4RlpDf0M8C1QDEZjM0hORqfayB9VT7QB1OPOP60IfnagX6+mkh
 IxIxMEm1bdaUCITyUl9vOSH1Vu+pv8YTjd6UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960388; x=1749565188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v42m/m4fI+aGLzLMT3zuJcX4AydUlIt3nnGuQ12FFSo=;
 b=Un7vgmYFhc8z3XyPv84j5Kz04ZrgpS5+L98aWW0iCXrAit/KqW7CVTltBpa4Medxyk
 3Qc1nFMZSPxxW6VRCj+Xg65akbAqZAbVcZ8VnzeTM2E8zTrCgLPE3gH54uz3KtInb1G7
 35Ttjz97PNO3SU0Xwd/oVZDJCzxbqIzS4W3lXcWUTqQrUwDHV49EojFj7jDddqXaR1++
 a2+DTOD81sGZ0VRJI6oRGor0Jxd5BCSFXXwNrRpjx396ITEINAWptsFwcDC5+VPYL5uX
 VS0cBie04JCCTcw6QuEnwLpVHtft5kEWFNl7R5blH0M6DnR0T91B1ayNs09iHaVZQlHl
 bUmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Kcb8AkBM5FDhxzSNXYc/+WLiVfunRnJH69tvVHPxHieEMUzPLXODJ7FM+pXZdQUgimIdMUw=@lists.denx.de
X-Gm-Message-State: AOJu0YzO1OrVhb2ebr5so13IK7lZKxMwRZ9ZUcE3sk8J3XBvV5nvuOcS
 76z0jFREwnJxwFKeJAKRUR4QZzglANw7Y/fd69T3p+1BTlQu6iwZCCMPEiD+wyM4Icc=
X-Gm-Gg: ASbGncsQLqqyUQ+KSc+k1VvmJXJzdKg/UQC9Pzo6ZRZz4gGATHZzD5Yt3uo4jf3rgoh
 ZXolo35U2fLyNd7A8d0UdaxqkG21pNz2rAq7o8SxonEuFTHv5J7qctOwfP1lRKQ94Amlkp/hcv2
 3Vyr1ui6SdsBxlXiZYqYYu5gX1ymJOJfs5nkcRtPSPL1H4JvnirKd0l5FFreM0unQWRABcLyoYZ
 U13WB8ephkSvB7ZnFzZWdCkWv9OapenuTlqponzYHIHeQY6n6hrL1jFfiy1qr7jQKBuFPp4/uV1
 ZNhyzPZh2f7C2OLL91shIej0aSsQhMXBhBpYrQvcUDXPETg2p8rhgQQgjlQuPwpS4M1n4ytHL/8
 XM+eiRc9vB+Ye
X-Google-Smtp-Source: AGHT+IE1FSCQd1EpeqnqqW8ZIHn/ZB6WIIoDLDBc4xSMsAozNKpW0OcCEFAwP1CXHJwOGL2dhZQAIw==
X-Received: by 2002:a05:6808:3992:b0:401:cae9:4dc3 with SMTP id
 5614622812f47-4067e5414ddmr10044901b6e.8.1748960387902; 
 Tue, 03 Jun 2025 07:19:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c40ad2sm1801575b6e.25.2025.06.03.07.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:19:47 -0700 (PDT)
Date: Tue, 3 Jun 2025 08:19:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/3] net: lwip: add sntp command
Message-ID: <20250603141943.GD1382132@bill-the-cat>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
 <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
 <3f6c6f3c-ac48-4f24-bb64-23e86fbeb5fa@linaro.org>
 <20250603140659.GC1382132@bill-the-cat>
 <9be491bb-ea4b-4643-be20-39c3f9961cc9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BxUJBzfmnYGGIJFO"
Content-Disposition: inline
In-Reply-To: <9be491bb-ea4b-4643-be20-39c3f9961cc9@linaro.org>
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


--BxUJBzfmnYGGIJFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 04:13:32PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 6/3/25 16:06, Tom Rini wrote:
> > On Tue, Jun 03, 2025 at 03:49:05PM +0200, Jerome Forissier wrote:
> >> Hi Heinrich,
> >>
> >> On 6/2/25 23:23, Heinrich Schuchardt wrote:
> >>> Am 21. Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome.foriss=
ier@linaro.org>:
> >>>> Implement the sntp command when NET_LWIP=3Dy.
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> ---
> >>>>
> >>>> cmd/Kconfig                |  13 ++--
> >>>> cmd/net-lwip.c             |   5 ++
> >>>> include/net-common.h       |  11 ++++
> >>>> lib/lwip/Makefile          |   1 +
> >>>> lib/lwip/u-boot/arch/cc.h  |   4 ++
> >>>> lib/lwip/u-boot/lwipopts.h |   4 ++
> >>>> net/lwip/Makefile          |   1 +
> >>>> net/lwip/sntp.c            | 128 +++++++++++++++++++++++++++++++++++=
++
> >>>> 8 files changed, 161 insertions(+), 6 deletions(-)
> >>>> create mode 100644 net/lwip/sntp.c
> >>>>
> >>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >>>> index f21d27cb27f..58f629e1c34 100644
> >>>> --- a/cmd/Kconfig
> >>>> +++ b/cmd/Kconfig
> >>>> @@ -2061,12 +2061,6 @@ config CMD_CDP
> >>>> 	  and to retrieve configuration data including the VLAN id using the
> >>>> 	  proprietary Cisco Discovery Protocol (CDP).
> >>>>
> >>>> -config CMD_SNTP
> >>>> -	bool "sntp"
> >>>> -	select PROT_UDP
> >>>> -	help
> >>>> -	  Synchronize RTC via network
> >>>> -
> >>>> config CMD_LINK_LOCAL
> >>>> 	bool "linklocal"
> >>>> 	depends on (LIB_RAND || LIB_HW_RAND)
> >>>> @@ -2144,6 +2138,13 @@ config CMD_PING
> >>>> 	help
> >>>> 	  Send ICMP ECHO_REQUEST to network host
> >>>>
> >>>> +config CMD_SNTP
> >>>
> >>> The command should depend on RTC support.
> >>>
> >>>> +	bool "sntp"
> >>>> +	select PROT_UDP if NET
> >>>> +	select PROT_UDP_LWIP if NET_LWIP
> >>>> +	help
> >>>> +	  Synchronize RTC via network
> >>>> +
> >>>> config CMD_TFTPBOOT
> >>>> 	bool "tftp"
> >>>> 	select PROT_UDP_LWIP if NET_LWIP
> >>>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> >>>> index cecf8d02555..2ffee64f97e 100644
> >>>> --- a/cmd/net-lwip.c
> >>>> +++ b/cmd/net-lwip.c
> >>>
> >>> Please, put every command into a separate file instead of duplicating=
 the #ifdef chaos of the old network stack.
> >>
> >> While I agree that cmd/net.c is painful re. #ifdef's, I believe
> >> cmd/net-lwip.c is not bad at all. In fact I took care of having only t=
he
> >> command wrappers in there (U_BOOT_CMD(...)), so it's just 55 lines at
> >> the moment. The implementations are in
> >> net/lwip/{dhcp,dns,ping,sntp,tftp,wget}.c. So I don't think there is
> >> a need to change that. Or I could move the U_BOOT_CMD(...) into
> >> net/lwip/*.c as well, leaving only the non-net commands under cmd/ (ap=
art
> >> from the legacy NET stuff).
> >>
> >> Any opinions on that?
> >=20
> > While there are commands outside of cmd/ they are the exception (and
> > generally ought to be moved) so if we go the route of breaking up
> > cmd/net-lwip.c I'd rather see cmd/lwip/${cmd}.c instead.
>=20
> To be clear, you mean moving net/lwip/${cmd}.c into cmd/lwip/ in addition=
 to
> splitting cmd/net-lwip.c?

Yes and I think that will make things clearer overall, thanks.

--=20
Tom

--BxUJBzfmnYGGIJFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/BHwACgkQFHw5/5Y0
tywjqwv7BI2yFccMhQ59HwjaXAliZdFveBdYjb72qQJHM5Hz5PrSc2i36HAt/xb9
PwwwZzOv+fwB8Qdw7k/cQJ349I/oKNOE/wZIER8G/cYhOnYvx81MfmnOrhZ+gQQ0
97QXqW3YktwzpOhj0ttx+LJ+Qtkhfpv4Afj0l1Vvw3xuy4UmeTTFGqSK+U4Dxhlf
IFuztxcGRpn8pvddtY4EdSVoKXTAHCIvyPQiOHBI4/Q0x4GWaJfWnbaWbMeb7V18
gXNq54wxEpFDh3t5GWLoeHi/SyUOqeEF718P2FjF3Cmkia0s4W9xCx1Kt0j2azYW
s1rPylRlsFhCcjhZvw81kg/uO+HYMA916mHB92EP5smQ13JNk+pcqujRZBkG3Hsa
lDkqRli/Qe4m3nUYjH2TuwkIoy81KqvwlIQFV/fk79EsqaYurygB194xu53WN5eH
lNE19v5ik2pO5tsRjerYG62L4VsgANhp6bCAw8RRbD15hf3sqj6yLlkTr6UW7NN5
8r8z76ry
=+nOW
-----END PGP SIGNATURE-----

--BxUJBzfmnYGGIJFO--
