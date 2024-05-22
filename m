Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A33C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C34E884D7;
	Thu, 23 May 2024 01:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hvGsgI3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F28E884D7; Thu, 23 May 2024 01:10:54 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40986884DC
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-792ce7a2025so74114485a.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716419451; x=1717024251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tzn6VPjWSWcw6Sym8+SKxjFlaboVBt/IVWBZaaLVkXg=;
 b=hvGsgI3sKr7ndiCItbw/F5kva94kiFy3El0B0s/Bbixq9J61mKai8vtAYS3QGxOu7X
 wggWFQqGsSddzjvJZQbPA9nnyMeB6gaut1VqrN4lOn9E8RmFnPVfQXgryd3ntARQY8w4
 1rol1P9H6hZv/94llDOZ0QkybnAcDf84GcZUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716419451; x=1717024251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzn6VPjWSWcw6Sym8+SKxjFlaboVBt/IVWBZaaLVkXg=;
 b=ewIHx8Fhl5Rw3m1BSH+eKorSZwqSK5oqbRkXT+ZG3RqpAeBDdj6uWsZDrh9+9kKkBb
 ykUFntzkRsGfdKp/3ecum+jHAALYtNTUjZiwY5ZKDSszoKxqIVEKWbhpZGC5NBWhBUp+
 gsWMxzj3M2gA9xWnINwH4KRkgPJQIpvVkKYJIabiHDvriAM1NOJODLz8S1BVPAEjuwwk
 jHcIVn7QtVHjsSzHtLKsJywrF51T1gSgJL4RwSBJ5TZCxDEZhkK5dJY5nycrDYLj2Es2
 pJRZJdMmNKeTHUMv2QeiG07Nh2HlwsJ6HWKtd1/4Wo3I/xiUIA7CVSxGh2wo7D3OPQo8
 N0Cg==
X-Gm-Message-State: AOJu0YxpmtGBNhQAZhYqgKqv4JSgi28jVEcOwEoJcmk66MZHBX+RUWe1
 tyUt2KGUzNuqeVw948Ytn/aHzF/bL09BVKofsk1QEdkRZV6CeCmunJmUvYDsuAY=
X-Google-Smtp-Source: AGHT+IGPorljzHmrySEiwnbOGEClCEnjGcSxroY0yhfceiRYRRsH9F0c8Ckn5Rd2HEh+AwybWw7jpA==
X-Received: by 2002:ae9:c203:0:b0:792:9da4:9edc with SMTP id
 af79cd13be357-79499454edcmr322437185a.34.1716419451065; 
 Wed, 22 May 2024 16:10:51 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2ffe59sm1431552885a.83.2024.05.22.16.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:10:50 -0700 (PDT)
Date: Wed, 22 May 2024 17:10:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 10/15] test: dm: dsa, eth: disable tests when
 CONFIG_NET_LWIP=y
Message-ID: <20240522231047.GL2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CVeiqGJbXySCsTGs"
Content-Disposition: inline
In-Reply-To: <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
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


--CVeiqGJbXySCsTGs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:00:10PM +0200, Jerome Forissier wrote:

> Some sandbox tests make strong assumptions on how the network stack is
> implemented. For example, the ping tests assume that ARP resolution
> occurs upon sending out the ICMP packet. This is not always the case
> with the lwIP stack which can cache ARP information.
> Therefore, disable these tests when CONFIG_NET_LWIP is enabled.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/dm/dsa.c | 2 ++
>  test/dm/eth.c | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/test/dm/dsa.c b/test/dm/dsa.c
> index c857106eaf..147e2a4afe 100644
> --- a/test/dm/dsa.c
> +++ b/test/dm/dsa.c
> @@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state *ut=
s)
> =20
>  DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
> =20
> +#if !defined(CONFIG_NET_LWIP)
>  /* This test sends ping requests with the local address through each DSA=
 port
>   * via the sandbox DSA master Eth.
>   */
> @@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
>  }
> =20
>  DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
> +#endif /* !defined(CONFIG_NET_LWIP) */
> diff --git a/test/dm/eth.c b/test/dm/eth.c
> index bb3dcc6b95..cf97b1c1ab 100644
> --- a/test/dm/eth.c
> +++ b/test/dm/eth.c
> @@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_s=
tate *uts)
>  DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
>  #endif
> =20
> +#if !defined(CONFIG_NET_LWIP)
>  static int dm_test_eth(struct unit_test_state *uts)
>  {
>  	net_ping_ip =3D string_to_ip("1.1.2.2");
> @@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state *ut=
s)
>  	return 0;
>  }
>  DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
> +#endif /* !CONFIG_NET_LWIP */
> =20
>  /* Ensure that all addresses are loaded properly */
>  static int dm_test_ethaddr(struct unit_test_state *uts)
> @@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state *ut=
s)
>  }
>  DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
> =20
> +#if !defined(CONFIG_NET_LWIP)
>  /* The asserts include a return on fail; cleanup in the caller */
>  static int _dm_test_eth_rotate1(struct unit_test_state *uts)
>  {
> @@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct unit_t=
est_state *uts)
>  }
> =20
>  DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
> +#endif /* !CONFIG_NET_LWIP */
> =20
>  #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)

This seems like a lot of test disabling to me. And since a medium term
goal would be to then drop the old network stack, a more nuanced
approach is needed here. If not if/else'ing within the test, rewriting
tests to cover the concept being tested needs to be done I think.

--=20
Tom

--CVeiqGJbXySCsTGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZOe3cACgkQFHw5/5Y0
tyztYwwAsBYPRy7sBBS7soy2KC8oNglK5yupHxg1JhNNIU8Zy9U5dKxevuuqUk0M
uEBLWqwXOYb4SeiwMVKSoIH65uPzoXJqhWDvknWE/pU4uqbJvokgbc1395ediYYg
DpecH/oHc+bhmkJ2UUtoy1JLmw59d+XvF1QgXqeOovSIkutqkYAf2xcLznhPZLSC
j79C9TpT9z40K9OPb9csmw4Xih/xt3fhuzu+G7Xm7IHzFCfYly01cNj974fVRyT8
zqwbgPcf8P1DsbWvndapLley8F6PLZ05B+Sw08Cj7XWLOSD+1EKG7P/LH68STPNK
d0XELC1woQQhtlxBm4MfzmL7c9H+wpOS6Abjc233FaiPQptpC9bysS5YdMxeWJVC
M9fCMoKRW+aO+YpanBpmjZTARTxK6V9ajV0WKRryI7Ty3hGg0N9GaKtXJkiho84g
iYTUu3sekOfcFp1jAmnIddWul826Kzg5KBynRf27xU6ShHVxI+hWad89pmgYS9mG
UPpPXO7o
=IcFj
-----END PGP SIGNATURE-----

--CVeiqGJbXySCsTGs--
