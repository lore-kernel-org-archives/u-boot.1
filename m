Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712D7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F288F81E25;
	Tue,  3 Jun 2025 16:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="itSp+8YP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2367E82A76; Tue,  3 Jun 2025 16:07:06 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03CC80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4079f80ff0fso1961753b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748959622; x=1749564422; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BANHy8DNLj8wi4KYu0V8S5C0phAZhXaPHfV6dGCV3Ug=;
 b=itSp+8YPQOTfE1bC6UXDl6N6vFf2WDW0mKXfPZ8Zz/SkESzBICKBATXhTKPaBTRz7A
 gxx3xKaGu8INck1Ec4TUCyPJAApALaSFMh5Xec/AOfbb1/QifgvtEFE7qbAbm77XHzpf
 bDWAYaJ9T2w1IMEZltuzL4b9iPX7kmAThp4sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748959622; x=1749564422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BANHy8DNLj8wi4KYu0V8S5C0phAZhXaPHfV6dGCV3Ug=;
 b=Q+QzHUetB2v0aOF/cFFJgk/wb5AosztubaEt7BEue0YmadAmhhykh9nRvY5rKK8yxa
 ESiF1dYXGemXdz20y5MJ4BSCFkzFgKwFARogufVk6uK0k5cOZX2ZKAH6mcYs3Ya4NSIl
 R4u+iNNasdTbDlZUVldAxM+pOQkPbV43Ih6c1xyph84DI0r9tpj59juapitKFJp6NBDp
 GR7HqTL3wJ8FwAoQzfPz3f2fl8xOlBbSupelt72IaslEAlOulArDYqL54eYXmOZm/BwV
 1fLEcSk5mYiZFBYcuiqEkywEH61APF+nUlQFgCAz5h69xIvVXvgPQ1bz1W0qiPi/tY/h
 lxjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWovl/ZGuKv1w/Gwu+5DP9ypE/LWS9IADnVHVrabjdnzY32Kg+apTT4tiI3plCLUaYca5yuDcQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxwbhYdu3bacjQpkYWtrmXw3A2U8FhbeJ/xLbq7xWbrEPRSc+aB
 Shvk60VrQwBCgn8yjdaMBqUxSV+YYDHbEXItW6osAoV5e4tqMAmEDxRUVbV2Jx9yyKQ=
X-Gm-Gg: ASbGnctrXhXUmktB32epuHKhAYMKP1CAqDlO9OAbd8FoN2dIpyci0pQnybEw4YxikDF
 0jsJBOg4cJB9XDDYDl5PPd0prib1XolkNzt4X+4G5Pp0gIz4FsDht7NKdgF5O3M8KmUYf0RDwsS
 5gY1nCc8HGvnUnJvtJsbK5ne+zA8UutUNyGt/QK6yTTTiRrgVRcYUBrLTEumGILkL9U+QiBvql2
 dpApagi40Pby7oxAdFaz9JqvwoVtdqaNePriVBzxjminGtAC2iB4nfJoX/WDAre8k5ZUxyd+joV
 VUQtRxh9tnyfKVXf/8u8fNQxyQc+LgkudfL0cQs80UVFp9PrljQlTw4CtqesskHqK/lOo2ILoIo
 7OT5yAOJ00tq9
X-Google-Smtp-Source: AGHT+IHT9g+4LkZ4DyudkrfUUXYhe5/LLdC4e8viEYtJLFEiGk1gm5NFDBpT6y7gUMBEmhLUQQU8SA==
X-Received: by 2002:a05:6808:6f85:b0:3f8:93c5:6d9a with SMTP id
 5614622812f47-408e3af970bmr1724733b6e.15.1748959622533; 
 Tue, 03 Jun 2025 07:07:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678bf36f3sm1833012b6e.7.2025.06.03.07.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:07:01 -0700 (PDT)
Date: Tue, 3 Jun 2025 08:06:59 -0600
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
Message-ID: <20250603140659.GC1382132@bill-the-cat>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
 <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
 <3f6c6f3c-ac48-4f24-bb64-23e86fbeb5fa@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y/lvH0AM3bqKSL2e"
Content-Disposition: inline
In-Reply-To: <3f6c6f3c-ac48-4f24-bb64-23e86fbeb5fa@linaro.org>
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


--Y/lvH0AM3bqKSL2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 03:49:05PM +0200, Jerome Forissier wrote:
> Hi Heinrich,
>=20
> On 6/2/25 23:23, Heinrich Schuchardt wrote:
> > Am 21. Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome.forissie=
r@linaro.org>:
> >> Implement the sntp command when NET_LWIP=3Dy.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>
> >> cmd/Kconfig                |  13 ++--
> >> cmd/net-lwip.c             |   5 ++
> >> include/net-common.h       |  11 ++++
> >> lib/lwip/Makefile          |   1 +
> >> lib/lwip/u-boot/arch/cc.h  |   4 ++
> >> lib/lwip/u-boot/lwipopts.h |   4 ++
> >> net/lwip/Makefile          |   1 +
> >> net/lwip/sntp.c            | 128 +++++++++++++++++++++++++++++++++++++
> >> 8 files changed, 161 insertions(+), 6 deletions(-)
> >> create mode 100644 net/lwip/sntp.c
> >>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index f21d27cb27f..58f629e1c34 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -2061,12 +2061,6 @@ config CMD_CDP
> >> 	  and to retrieve configuration data including the VLAN id using the
> >> 	  proprietary Cisco Discovery Protocol (CDP).
> >>
> >> -config CMD_SNTP
> >> -	bool "sntp"
> >> -	select PROT_UDP
> >> -	help
> >> -	  Synchronize RTC via network
> >> -
> >> config CMD_LINK_LOCAL
> >> 	bool "linklocal"
> >> 	depends on (LIB_RAND || LIB_HW_RAND)
> >> @@ -2144,6 +2138,13 @@ config CMD_PING
> >> 	help
> >> 	  Send ICMP ECHO_REQUEST to network host
> >>
> >> +config CMD_SNTP
> >=20
> > The command should depend on RTC support.
> >=20
> >> +	bool "sntp"
> >> +	select PROT_UDP if NET
> >> +	select PROT_UDP_LWIP if NET_LWIP
> >> +	help
> >> +	  Synchronize RTC via network
> >> +
> >> config CMD_TFTPBOOT
> >> 	bool "tftp"
> >> 	select PROT_UDP_LWIP if NET_LWIP
> >> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> >> index cecf8d02555..2ffee64f97e 100644
> >> --- a/cmd/net-lwip.c
> >> +++ b/cmd/net-lwip.c
> >=20
> > Please, put every command into a separate file instead of duplicating t=
he #ifdef chaos of the old network stack.
>=20
> While I agree that cmd/net.c is painful re. #ifdef's, I believe
> cmd/net-lwip.c is not bad at all. In fact I took care of having only the
> command wrappers in there (U_BOOT_CMD(...)), so it's just 55 lines at
> the moment. The implementations are in
> net/lwip/{dhcp,dns,ping,sntp,tftp,wget}.c. So I don't think there is
> a need to change that. Or I could move the U_BOOT_CMD(...) into
> net/lwip/*.c as well, leaving only the non-net commands under cmd/ (apart
> from the legacy NET stuff).
>=20
> Any opinions on that?

While there are commands outside of cmd/ they are the exception (and
generally ought to be moved) so if we go the route of breaking up
cmd/net-lwip.c I'd rather see cmd/lwip/${cmd}.c instead.

--=20
Tom

--Y/lvH0AM3bqKSL2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/AYMACgkQFHw5/5Y0
tyyi5gv/RJkppPxlWr05rgZXNj9JNJy8Tzna7+HZqCFhivCkywruWB4JQrqrSl30
uTC1JpeZ7iXKOaGJCkq08FK0UQsIuDb8zMHWnYMhL5SmgMNKrPnyRl+Brh5eh/LM
IB77JGO5OEC0lv8ykYuWCRCdizPpGSTKyhSUx79hYrJsGNzovOEdtuSMcLnTcliV
bYS/h5kuWnkvGPOF4M8bcfr07d3AbuUxLxG0jSjtzftsQnO7Bk8iZvFDi9RLhiDL
mPSar57FaPTpZdO0mKdpNNjdHzOFFxw1JQl7Gx6t5+QSgTL1o3sRTTPY5JW1I/c9
elXzCcsbmcFB7atW7pFqzKEC/UiYNnx7CpdVF2CZMNHA4YuUROHfv6HM5Zv/RxU2
9Zuyr9U7fwLc979UVnEKkU0TO40ulQoHQOC8CQ3C54fEYiO/rfWf06RN6t2MN3Kd
lQvoy2RBN80Fa4w0kTuguxzX5hH5uCwqHGUejbXxktu9cvfN9GSzW2xq2ZgkhdBV
bX36GHqU
=TCBN
-----END PGP SIGNATURE-----

--Y/lvH0AM3bqKSL2e--
