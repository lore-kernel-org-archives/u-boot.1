Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6CC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A7C81DFA;
	Wed, 19 Mar 2025 15:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ArOZursY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDAE81DED; Wed, 19 Mar 2025 15:52:27 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0EE81DCC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso6659172a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742395943; x=1743000743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/ib0xLUUxVUPUYeCKaAnc7b27TS8of0vdHuy3F0Qpg=;
 b=ArOZursYQGMiPPHss7DnKyyrAEjGLdrwxrhf58wq43UFurmp1zRkP11IVs42uycUf+
 xf2bThMRXl3LbGlHDxVzWxsWNamXVFEQmfG65jl+lA01ZZAz1+3j+5zupep1cL0l0rLb
 R/sC4hBGquZH0HPtCf5ukZ22YbLv7mK/X6wKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395943; x=1743000743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/ib0xLUUxVUPUYeCKaAnc7b27TS8of0vdHuy3F0Qpg=;
 b=RM36R6AZlTJbDDkJmvtMgc1tbBL4TDtmnIajWJ3qwtKIl0MwQShJ/Y6DcmZUlFzt0a
 cGH2g2BMOJuzU08AFM0faxFP9rqz1tGZw66ydwprS7Bl81yo7SiEhH95Ji1uHaJrS4TC
 G3IA8pKOkl4bqoPYyMPCwMJXydwAkdgxijFSUutOjvt1xmDWGYifpaN6yIJ7WxhYhdbD
 8jvd3MfeM3DmEFOXrH5I4FYUNGaTKjho5e0dpbT8BIDksqTUitDqD74L4Qk0U3smsF4u
 nUqsxyml+xgUJ25MVwM4bVdnZv9D6dVkVgnHBdLzZrZwuVN0A0Axl516SYY3IQfIzSaH
 wbPw==
X-Gm-Message-State: AOJu0YxXmdepLfDe1NbkO0ynbHdoQcODOm5xUYsL8coFxb4ArnZPYiUK
 /dUf0/Wh9mCV4qz2g3dZkKdiOkLZow9+WDytJdUO7Iusn5oMWOS4dQiOpA22fkE=
X-Gm-Gg: ASbGncuoM2yEid6tCZwTn9KX3jqm+OJjbmNy0QYM4E30bOiAp+7LFfGPmrmZLq/baDN
 UsYAg/c1gpPRwdX2h9+HkNEtE5ywQzLszCS4vEVD3PhhSdxi2rpvNYrY0TNTd5Fnqk08xN1FmWX
 8qpvfv7erFWReV1fJivVKTxq9XOhCFqs48ochzkQEBvQGYgF2aMQ0Ic/46SY1y0IYggAUEhEwto
 mvsZQilobEiozNqTskk/kzzLiB1qtey1WOckgIcQXxUQ8OiROvqKOPv6O1HqGVKdu2aobtvvvfD
 hixKqtjL8Mh+S/DlJsdrthBdgqE3Iz5nuHmbbJdZU8+7zw==
X-Google-Smtp-Source: AGHT+IHwud6aSn9hOhQHIyd5muZrMKfUDqw4Ai4/53s6p8PXidRZWDLcZWkG+02QdH0KBb/EG6e2QA==
X-Received: by 2002:a17:90b:55cc:b0:2ff:698d:ef74 with SMTP id
 98e67ed59e1d1-301be205905mr4165598a91.26.1742395943480; 
 Wed, 19 Mar 2025 07:52:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5a1b6bsm1673359a91.29.2025.03.19.07.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:52:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 09/17] test/py: Add a test image for Ubuntu
Message-ID: <20250319145218.GG2640854@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aogxCqBkuuZ4fd5F"
Content-Disposition: inline
In-Reply-To: <20250319143820.2385092-10-sjg@chromium.org>
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


--aogxCqBkuuZ4fd5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:

> Add an extlinux image that contains a few Ubuntu entries.
>=20
> Increase the number of sandbox-USB-hub ports to permit this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I don't understand what this test adds. In neither the current Fedora
test nor in this new test are we actually booting something, we're just
taking a sample extlinux.conf and making sure it doesn't fail. Is it
that we're testing in a useful fashion now having two labels?

We should probably be clear about what we're doing in the tests and
instead of adding seemingly arbitrary distributions add an extlinux test
and testcases.

--=20
Tom

--aogxCqBkuuZ4fd5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa2h4ACgkQFHw5/5Y0
tyxnhQwAnp7TZK8L2yP/mlvq0cPV7Czbqzs9YmQjtuO/Zj4ADr0mpJgU69PgorxE
/aDF7pSsR1Zv8jiSWvtaZ0w1omsUWS+o2Vq175blTFgj5gAbnLDMSODWUOiSOnhh
cBrobJkqJEIGUaNPKZeFuzqjEVBwttBWRxt1XhGz7I8YxeK00ZDUwqcDBdIZLkKy
o9Di0AaQVlD3nMkvxjaUz6aP2gDAj6QsdsUtvna17oIdQ9dvtcxJj5eWA7pZgoHl
n7Yu+t3k2/rEb/Kw0nkjjXKzUlJaK+Kb+d1/TzPlTg86E6QWB+fn6c/PwyAt21ja
/gq0lJhNFZKk1LiLrcNMSyY7R4zhT9yTQe7W60ASq7Mmiqm/j73eW1PRC9Bh5d32
iqCyxH1BCwvQChmM6oN5oQITypdCBIXoMcAMGNcndsQPz+HMP7abcH5z3IS4O8uw
Whw2Wm4iSRmVlb/JReaOY979xrJXDSiUE6mULqVD6SWGhf9nXg5oVIG9W2/TWYdW
SBh18MHy
=Xlou
-----END PGP SIGNATURE-----

--aogxCqBkuuZ4fd5F--
