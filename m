Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF65C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 23:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF70587F4A;
	Wed, 27 Mar 2024 00:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MSxQ66uJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A836087E62; Wed, 27 Mar 2024 00:58:18 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9837888020
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 00:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-430a65e973bso38838501cf.3
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711497495; x=1712102295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rvOzd7NmO6SsFVyrg//rDXkRiGsVgNGt+JL4nDjx5oM=;
 b=MSxQ66uJIK7h86jEzhf97cH9zKUPdd9iClpJp2iMpp46+YTVaD2XLff3KTJKMYPO6y
 wpo8hZWnKYc2cT8/gP7SFpPft/xVuhfrSu3RWLCJEO4U5CuHPp+HLqtGLqrTr+CqU+ht
 jrx8gLIUAmeXJRMtKcvBT9ghY3fhGB8xD/yT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711497495; x=1712102295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvOzd7NmO6SsFVyrg//rDXkRiGsVgNGt+JL4nDjx5oM=;
 b=XcVbhw3YZCXuumTifzoM3mpRvd66p0b4aTHD6vwCJJImUAZ6/xne5ae/iDp/OduZsv
 mnBbp9kIMnDuZ1R4UBpgRF7wj0NsyrpXEuQrcnGYyVEdH5h8l4VPe9wgFq1MeuBl/8Yp
 ncL73KDDDXG4AmC7GLh1Ia49oEWc0Nk00TKjlxe+ZWamSb4BkiH60dNFA/Nc+lImgeEV
 vxoZBittC0G67WwYzHBU68n42LQop0F062JpCYMrntsxu/sgDLEoGJQKbI12obFExDuN
 E63BEtj4hsDZAqUdrhjI95dY20AdOTPrLzgD7SM9N80j0odmZMXS1wfxrVeJ5750+Ak4
 HnYg==
X-Gm-Message-State: AOJu0YzbvQm+HpvjtmkKRJqlDt11+CHICx3GgJBmWAQ/YN9ykndXoVRw
 jbTePQ8M0dTl2te+48WoqzkE3s+A1PN6yWsqlExq+Lw6/mlCphV53zAfg77bv0Y=
X-Google-Smtp-Source: AGHT+IHUNzFLm1BEci4lYCPW7BqZ6bRK0OFwcwH3YGmqaapW2Wl/AiYLgmRcUnGBAvE8kEh26or8Vw==
X-Received: by 2002:a05:622a:4e0f:b0:431:74f9:9794 with SMTP id
 dh15-20020a05622a4e0f00b0043174f99794mr2767848qtb.47.1711497495336; 
 Tue, 26 Mar 2024 16:58:15 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 c11-20020ac8110b000000b00430b423f06csm4175724qtj.86.2024.03.26.16.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 16:58:14 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:58:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Edmond <seanedmond@microsoft.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Knecht <rknecht@pm.me>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH v6 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
Message-ID: <20240326235812.GA2903316@bill-the-cat>
References: <20231122232812.823837-1-seanedmond@microsoft.com>
 <20231122232812.823837-3-seanedmond@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2dIsobCv0Kj4JF3a"
Content-Disposition: inline
In-Reply-To: <20231122232812.823837-3-seanedmond@microsoft.com>
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


--2dIsobCv0Kj4JF3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:27:45PM -0800, Sean Edmond wrote:

> This patch introduces 3 improvements to align with RFC 951:
> - retransmission backoff interval maximum is configurable
> - initial retranmission backoff interval is configurable
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>=20
> In applications where thousands of nodes are serviced by a single DHCP
> server, maximizing the retransmission backoff interval at 2 seconds (the
> current u-boot default) exerts high pressure on the DHCP server and
> network layer.
>=20
> RFC 951 =E2=80=9C7.2. Client Retransmission Strategy=E2=80=9D states that=
 the
> retransmission backoff interval should be limited to 60 seconds.  This
> patch allows the interval to be configurable using the environment
> variable "bootpretransmitperiodmax"
>=20
> The initial retranmission backoff period defaults to 250ms, which is
> also too small for these scenarios with many clients.  This patch makes
> the initial retransmission interval to be configurable using the
> environment variable "bootpretransmitperiodinit".
>=20
> Also, on a retransmission it is not expected for the transaction ID to
> change (only the 'secs' field should be updated). Let's save the
> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
> exchange.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

This leads to failure to build on some platforms:
+(imxrt1050-evk) WARNING: unmet direct dependencies detected for CMD_DHCP
+(imxrt1050-evk)   Depends on [n]: CMDLINE [=3Dy] && NET [=3Dy] && CMD_NET =
[=3Dy] && CMD_BOOTP [=3Dn]
+(imxrt1050-evk)   Selected by [y]:
+(imxrt1050-evk)   - BOOT_DEFAULTS_CMDS [=3Dy] && CMD_NET [=3Dy]
+(imxrt1050-evk) arm-linux-gnueabi-ld.bfd: net/net.o: in function `net_loop=
':
+(imxrt1050-evk) net/net.c:526:(.text.net_loop+0xa8): undefined reference t=
o `bootp_reset'
+(imxrt1050-evk) arm-linux-gnueabi-ld.bfd: net/net.c:528:(.text.net_loop+0x=
b0): undefined reference to `dhcp_request'

--=20
Tom

--2dIsobCv0Kj4JF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYDYQoACgkQFHw5/5Y0
tyycbQv/fRWjaBuuIiJ9qpLK65fYQpyWqCyPL1OAihi1F31Pr/7uTQH2gcUqqF91
KyFKsPZ/VgOA9hSePQ/w/+KCiGZXR1Un4JIl90MuLfM7zzHIf9J0HEjntMWOPvis
vizS1CxAcJXm9ws8hriQQQgOY4f5J9I58s8p7ZHns5X53bU46WhF440E7o/DeBxb
stzOwc0mK12qySBpP9mZ/eI6He+ojBEwje7VF/3bdfDDdaQ2U/d81d8NFJF2T0ZM
KLF467g9Z3nmLRzXdKwLHlcFTN08t8JgxJj9Q9bW7Egx/2I2JCA0bojc9k67gWEd
ZgwLTYiwAZkHVhUhRhVTJaApu11kZSMQ8nOZTkQ15hGJGsSMEQIHd39rm5s2ynWG
Nrr24JbseZVsq9nspd1MFrkveQe48i332wuNPBfkzLRk2nATYIvrr7Tv5uBzjBjK
Cpvmy7zd6GF5oSMp0Wz0n4eedsCOU9nxIOrTP9HE2cl9ZTRwZ65meU2fuDwwQ2SG
b/N1nMU/
=o1TQ
-----END PGP SIGNATURE-----

--2dIsobCv0Kj4JF3a--
