Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C568C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 17:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DB882952;
	Mon, 19 May 2025 19:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hoYE47MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5933782991; Mon, 19 May 2025 19:44:11 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD660828F8
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 19:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-401e77e5443so3110151b6e.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747676647; x=1748281447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ry3xKU4N6jhJ4/AN81brCxCSQ6jeqNQkhXfxjQtxlps=;
 b=hoYE47MUvb80su7fvaTNLIk4YaaBhT7KpbIfdIrTvK3Bva5gLKHB7rNNfXRno/WhxS
 /1H8mzkECIDIbQo3XH/siDFsL+YUoMFaCs9Dyz5irYOJcMOA6cWJRODACYMnRyn4CBzK
 WpThzXq9o8vZIP/e06Zq1uBroXQcQgYwTYjuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747676647; x=1748281447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry3xKU4N6jhJ4/AN81brCxCSQ6jeqNQkhXfxjQtxlps=;
 b=Ugz52eCpKvfeHtPImFx5PxQY2bxWhaSg8Q5BwIdbM8aZDR9MZkW8lmhNKFhSd3ZBX1
 huijXkPZ0uiw2in2geSH09lB/lUW6pt48+D9Vqp7B0r9+0gBoBtoz6mXTkZ5sugkwtAg
 NOCuf4H5wFWf9XlVgp3PcpkOSi67zrT0Y3BjntprR3s/itFfD1B19+cklj7gk2/mNLMs
 mbcIhsNS7D6UELc/i/INiic/snECA0BQZIobRKyfdqlrQ4dmp5afidWKwDL1IHTOPqjc
 ZrLZG37Cw+birncGjnkxHRaBL00Z2F6OgKp+y8EbY6a63jaLOMPMuEbwJoFuRig0wdCe
 BedQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1FrceiWKp6Egbs2XaTKFzGCM6x4U4okLXfTpmJBuMwpnCk5iYfwrdHfTJ0Zp4KuRYpw59qzU=@lists.denx.de
X-Gm-Message-State: AOJu0YynZRXMvJkklembhiCSInIUT8oSZHg0ThF/MK4Yr8l7yXdYtjWE
 apHrwoJdYfR+8Qnc/BhQPlKAuRK6jOExGXQPjtrDFv+WQmnAkgjay2mc0F7iTJIsX+s=
X-Gm-Gg: ASbGncsZZZxmLdbzkzLl72UQj1fJjGfo/QygHiw2/X2x716VOPdK6v3xMtWiDw6GbnH
 k79nIuWXmVnsQKnaSOj7E+Fyy6IEeJJpTyUB7YeBraWK/apELf4YJ35MReqV6TrynFCA4htgsi9
 Kbfhl7jUMVXy22UoMjpqjAH4dHaWLqi1PZN3NjJe5wjOaztKp6xZOh7+654gk2ceyGlxNR0+ZeF
 yM2HzlGsx1dtQv4zTBFK+y+NmP8KMG5omWRQFlscwq0CpSQTSuQ2z6mJMPJ9MXrBejdexj5egXd
 EzyUKd/UuAlmpZU5wnTDRAvLhoJPiCl6HPwFKDXgC6/M/CO2q4voCmWSsjL82afvdtJRkX0O2DJ
 lCAsOgeoQ5BAl
X-Google-Smtp-Source: AGHT+IEwM1B0hAi6ZnMLXCoJGfKWf7xP8YopnuU9Js1/LuKb2coY65UXoj1HEIYxUbgfgOYcz9V86Q==
X-Received: by 2002:a05:6808:80a9:b0:400:32b9:7926 with SMTP id
 5614622812f47-404d863751cmr8701282b6e.6.1747676647486; 
 Mon, 19 May 2025 10:44:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f41a3ec2sm1612382eaf.27.2025.05.19.10.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 10:44:06 -0700 (PDT)
Date: Mon, 19 May 2025 11:44:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
Message-ID: <20250519174404.GS100073@bill-the-cat>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
 <20250519144835.GB3396848@bill-the-cat>
 <c90e00c2-ffea-4221-92a5-2cc8e1923dc8@cherry.de>
 <20250519154304.GR100073@bill-the-cat>
 <d41b216d-4e59-4bbb-a723-d0260e238b56@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V2biw02h3f25bKDq"
Content-Disposition: inline
In-Reply-To: <d41b216d-4e59-4bbb-a723-d0260e238b56@cherry.de>
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


--V2biw02h3f25bKDq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 05:49:12PM +0200, Quentin Schulz wrote:
> On 5/19/25 5:43 PM, Tom Rini wrote:
> > On Mon, May 19, 2025 at 05:09:07PM +0200, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 5/19/25 4:48 PM, Tom Rini wrote:
> > > > On Thu, May 15, 2025 at 05:55:44PM +0200, Lukasz Czechowski wrote:
> > > > > Initialize the debug uart only in case CONFIG_DEBUG_UART is
> > > > > enabled. The _debug_uart_putc is used internally by debug uart
> > > > > functions, so it must be also included inside #ifdef block,
> > > > > otherwise it will cause compilation warnings.
> > > > >=20
> > > > > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > > > > ---
> > > > >    lib/efi/efi_stub.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> > > > > index 40fc29d9adf7..5172cd78a7c0 100644
> > > > > --- a/lib/efi/efi_stub.c
> > > > > +++ b/lib/efi/efi_stub.c
> > > > > @@ -83,12 +83,14 @@ void puts(const char *str)
> > > > >    		putc(*str++);
> > > > >    }
> > > > > +#ifdef CONFIG_DEBUG_UART
> > > > >    static void _debug_uart_putc(int ch)
> > > > >    {
> > > > >    	putc(ch);
> > > > >    }
> > > > >    DEBUG_UART_FUNCS
> > > > > +#endif
> > > > >    void *memcpy(void *dest, const void *src, size_t size)
> > > > >    {
> > > >=20
> > > > I notice that this, and the uniphier implementations are the only
> > > > non-inline ones. Is the problem we later conflict with your changes,
> > > > perhaps because this wasn't marked inline? Thanks.
> > > >=20
> > >=20
> > > https://lore.kernel.org/u-boot/d63d53bd-3f63-430d-b0bc-2379b7bded81@r=
ock-chips.com/
> > >=20
> > > so essentially
> > >=20
> > > lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
> > > used [-Werror=3Dunused-function]
> > >     86 | static void _debug_uart_putc(int ch)
> > >=20
> > > I tested by adding inline and indeed it fixes the warning.
> > >=20
> > > Somehow the non-inlined _debug_uart_init doesn't seem to be triggerin=
g any
> > > warning though.
> > >=20
> > > Would you recommend to inline the _debug_uart_putc function instead of
> > > guarding the whole thing with ifdefery?
> >=20
> > Yes please, and also fixing up uniphier for consistency (it won't have
> > the warning because it doesn't descend to that directory unless the
> > option is enabled).
>=20
> I actually added an #error in the function and it is compiled and doesn't
> show a warning, so not sure what I'm missing?

It's on efi-x86_payload32 and efi-x86_payload64 where the warning
happens, and in that case inline also fixes the warning. So yes, please
lets go with that for consistency, and also to match up
include/debug_uart.h says it should be written.

--=20
Tom

--V2biw02h3f25bKDq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrbdwACgkQFHw5/5Y0
tyz+FgwAkl68tcVnkI6ZtRp9rZUuN9/L0kmZP0P/q4QTN+7OusvBKvwAiqlUhxMf
P2IhcgMOsCPkbsvOktgIWFXkekzblf9TSVNyyEqgLEEK/DadUXsbZ394foOYFymS
NdlwIFuLtJFK5KCw4yteUhJJCQEws3TYnhL511R+LCpvC1TbFwtp0fKzK8wHPHNw
epd1HjMjlOdE7lYxEPBcHAWHYWaeUWmd76SvFodyr34MNd9zP74R3LTyu1iC+ZKi
h60gCc9H1Xmld8SevplyG4B1q2xX0LEXPE7bjuu4kM4JE8uSzIMMxf4Vd43zyI0S
aeuv9Xc4gOWIADbicYBwBDTtaktaHuskdseTXvbpjDGBPgpmBPe1lUgmKuz8UyTN
RDG5LPUdhoBIjF99GMUXoEuYN7PSKbyBRPlF18Wr6oImJi+uusmHCRZQy1SfN7Zo
rLFUxJwG/8wYXGyckZu3gobQh6z/SRQoK6wF+ZrUzeFwBc7L//P4S6OjnrJnGLlx
PugxgSNg
=pKW7
-----END PGP SIGNATURE-----

--V2biw02h3f25bKDq--
