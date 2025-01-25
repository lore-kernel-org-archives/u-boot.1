Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D381C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F9480F4B;
	Sun, 26 Jan 2025 00:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZGqArnx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1090880F56; Sun, 26 Jan 2025 00:48:06 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DCF80ECD
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7be8f281714so325643385a.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737848882; x=1738453682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7Jp0Bjvsci8SWi8mv/jxtUuNIV6JSoplxo0rdNLol0U=;
 b=ZGqArnx8dWYsUugNyFEvplocrCwYVD/S+MJo99k3jQytr209XJ1pnF8P7vdmmO9Iq+
 m0kWRM73gRUT988qTfTyeYjHDQsg8PkDbvOJ0aPvhBiU/breqvuY3WXXgvujHskZRPEL
 cw8/FVGnOFNVgKfaAP99iOlFGTRvyQJWn6Nzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848882; x=1738453682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Jp0Bjvsci8SWi8mv/jxtUuNIV6JSoplxo0rdNLol0U=;
 b=ar2oqwKXVd9lEdj1CheXXfD/8K7dNvC8Bj6yqLL0r5TlnVCO3tiY2iBgonO9k5MZzp
 LnTkiefSz0chr3RzPcgNdBZs4nk0Ytho0a0ry6LlHs5UPfBuKYqcaj1CTzy6Dqg0QsRr
 t1PnayrUuTFBfNVBZoXY4/HSm5BOpm0md1ekZCagV0Ggd4TwxfUp1jCpFDwCTy1n5uZf
 sOUyPXvDqdMuCwC2SetdID/4DhjfSNwWPvnUrZEnxA2LDzL2F2yOfZoTBpWOj3Nr/Bqv
 AU4yvMPKiKOEpshdEpUQyfOounmXUjmmx1mRB73q23/9L4D5YDuQadsgEBANvk/QlWb0
 lGag==
X-Gm-Message-State: AOJu0YyyLBcT3oMLYQafLxFo1ift/oUNlQqHn+NZJ/EpfOzIOAisJ/zG
 cKOeX8Hgv+IYz4ruMu1VJxmgCLz2WgZFYGgBrdxgJ2Kfq9db3tpgOuzfcEGtxuQ=
X-Gm-Gg: ASbGncuSaIsBFR8vG2keyGYO4EQvuvtC4cit+u2ZkYEvabgL+KMcxcJyjn2DrJA66WV
 sZOPOOiRCWpzf1JiyQqZp4fEyyfkRyvOyFTTT1zxXAhL4ok3nTaxwVxk0rSfKMnNJ+0qo1012b0
 17npZwqqBxbaArI1oNq3HH98CdejwsiuB8/ebwVHBPmtCahWZUYQvmFmqQe8U5KJEAY/y3U9Ntt
 KR8xXTa/ofOchl+dAaIRcnWjizSMNWUDRLJJ6EIke9GoFIr+X/vvCf3eUY/JN2PP4VTsCadSl2V
 dw1w
X-Google-Smtp-Source: AGHT+IFczDJYHIjjIuBKjIDZZNcqONjRVstyR2DvNpxVBm2t4uuQfFuzjdT+JnUMJvu9dJIHbT/zyg==
X-Received: by 2002:a05:620a:4449:b0:7b6:d710:2282 with SMTP id
 af79cd13be357-7be632893a5mr6538681185a.49.1737848882055; 
 Sat, 25 Jan 2025 15:48:02 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af11709sm237610385a.112.2025.01.25.15.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:48:00 -0800 (PST)
Date: Sat, 25 Jan 2025 17:47:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3] led: add function naming option from linux
Message-ID: <20250125234757.GO60249@bill-the-cat>
References: <20250123114906.80724-1-hs@denx.de>
 <20250123143302.GI60249@bill-the-cat>
 <18a3d5e9-e630-d59e-e305-faba75c8f6d1@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jJ3fWjmWAWxwo43B"
Content-Disposition: inline
In-Reply-To: <18a3d5e9-e630-d59e-e305-faba75c8f6d1@denx.de>
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


--jJ3fWjmWAWxwo43B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 07:16:36AM +0100, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 23.01.25 15:33, Tom Rini wrote:
> > On Thu, Jan 23, 2025 at 12:49:06PM +0100, Heiko Schocher wrote:
> >=20
> > > in linux we have the option to create the name of a led
> > > optionally through the following properties:
> > >=20
> > > - function
> > > - color
> > > - function-enumerator
> > >=20
> > > This patch adds support for parsing this properties if there
> > > is no label property.
> > >=20
> > > To be as close as possible to linux import the following files
> > > from it:
> > >=20
> > > include/dt-bindings/leds/common.h
> > > include/linux/uapi/linux/uleds.h
> > [snip]
> > > ---
> > > as we introduce a new element in struct led_uc_priv, may we should add
> > > this functionality through a new Kconfig option? (Which also would ma=
ke
> > > this optional and save some bytes for boards who do not need this...)
> > [snip]
> > >   arch/sandbox/dts/test.dts                | 37 ++++++++++++-
> > >   doc/device-tree-bindings/leds/common.txt | 28 ++++++++++
> > >   drivers/led/led-uclass.c                 | 70 +++++++++++++++++++++=
+--
> > >   include/led.h                            |  6 ++
> > >   test/dm/led.c                            | 22 +++++++-
> > >   test/dm/ofnode.c                         |  2 +-
> > >   6 files changed, 158 insertions(+), 7 deletions(-)
> >=20
> > Getting things out of order slightly, sorry. The commit message should
> > be updated a bit more still since we aren't copying files in. And we
> > should delete doc/device-tree-bindings/leds/common.txt in a pre-patch
> > because we have that from upstream now. As for size, how much is the
>=20
> removed! And updated commit message
>=20
> > growth? You can use tools/qconfig.py -b, and then -f LED to find some
> > platforms to size compare before/after, and if you've not used buildman
> > for size checking before I've put my script up over at
> > https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/trini/=
u-boot-size-test.sh?ref_type=3Dheads
> > now for easier sharing.
>=20
> Thanks for the script!
>=20
> Here 2 examples:
> $ ./u-boot-size-test.sh capricorn_cxg3 --branch led-mainline
> [...]
>    aarch64: (for 1/1 boards) all +886.0 rodata +230.0 text +656.0
>             capricorn_cxg3 : all +886 rodata +230 text +656
>                u-boot: add: 1/0, grow: 1/0 bytes: 416/0 (416)
>                  function                                   old     new  =
 delta
>                  led_post_bind                              220     516  =
  +296
>                  led_colors                                   -     120  =
  +120
>=20
> $ ./u-boot-size-test.sh aristainetos2c --branch led-mainline
> [...]
> 01: Merge patch series "add the support of sha256_hmac and sha256_hkdf"
> 40: led: add function naming option from linux
>        arm: (for 2/2 boards) all +557.0 bss +20.0 rodata +161.0 text +376=
=2E0
>             aristainetos2c : all +557 bss +20 rodata +161 text +376
>                u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
>                  function                                   old     new  =
 delta
>                  led_post_bind                              128     332  =
  +204
>                  led_colors                                   -      60  =
   +60
>             aristainetos2ccslb: all +557 bss +20 rodata +161 text +376
>                u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
>                  function                                   old     new  =
 delta
>                  led_post_bind                              128     332  =
  +204
>                  led_colors                                   -      60  =
   +60
>=20
> So, may not worth to add a Kconfig option here... or?

That doesn't seem too bad for non-SPL growth. Thanks for checking.

--=20
Tom

--jJ3fWjmWAWxwo43B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVeCkACgkQFHw5/5Y0
tyxxJgv+ORhBu5uSIqJubINWWqyafdEHwmXmGzgOgfV5KRdEFMmnoY7cQMjWA5qL
a0oClG/Wj+BA4Xk42Y8azWfTRvwAduT9RFejOVdQ5zWr3nTTZlGIW9AY5biPUmGN
bM3bZ7S2DB6RUN27JF5Z7R8XOrk/oT1HkqTImhU/Jpl5LcMENnpOSrCpTW4Xq5OR
wfO3C1ZDLn1L6ZNyrNoMYOsetMllb+zXGY4Rpbp/ncclUmeEw8PE1xQsXigPCe0/
ekr1qI4nqBYD9EIDHDxPvp8h7LY1UzmFRtmbJ9Wa1gSuY5tXsnnS/jG5SqVDgCAc
giy7KnHcYHKt75WNthYHE2emLjUXbujyfjoe4k7ySS6FBHsMh+p2KJP77vGmLho6
UCp7UEHKg0dWQPuUuJ0Kne6wZr/zJyy5O9vd2Fy+VmMfg7GrzSVUVECtgxbkYthH
mkmYKM3lThUvwLbBVmSjdySG3e4SkeY1ca+nl3VaW55ToMGZJuFTzqJovQa39e7w
1BowUDHY
=Uaoz
-----END PGP SIGNATURE-----

--jJ3fWjmWAWxwo43B--
