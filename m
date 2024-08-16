Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4338FC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 18:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9418788BDE;
	Fri, 16 Aug 2024 20:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eSpMx6b2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C01889E9; Fri, 16 Aug 2024 20:40:27 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9E088BE1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 20:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-26ff21d82e4so1240198fac.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723833622; x=1724438422; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zWTEJIJk1Zu6UwcwKVeGlrn21qooVzv2kgT9d7af/R4=;
 b=eSpMx6b23CR+E0yRf99mB6U7eqTnQCG/izHQprbXSeUWvaAPoGZCy46s5+IdMenzvk
 xxKOTne9mDRAHWxsIZNOfsToOOS+BDfz6YvCxDR41wLrUOjfYQw/zG0H7sNl2hrtBb0K
 FNROOjmptmZ08+qoZ6o0CgMqvKa6W+GQXc+Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723833622; x=1724438422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWTEJIJk1Zu6UwcwKVeGlrn21qooVzv2kgT9d7af/R4=;
 b=mY+G9qboxiGugQUnd+TVq8wVJJhmwVC5Qv6bUIHzaDgfk0YdDsDHWp8rJV/OVbE1iz
 fdg8C3Wu1mPQygWHPiacm00QWGVQdIEsmmoXSiS/wwTa/RMS5x+bWQdbduzc+fRDXyr7
 GEC0CRuVxtP+rYYRH3PnyunY9AvYROl0615Uy1oIojVm5AqppRg6rRD4b5iP8gI8TfV4
 vvkqnaq4D1kafCztXtB70pxeMDYYrMhX6T98u9E4UNN3ekFfVcv+9q6nE4O6vNOaka7x
 XP7wAQuw+gMntOhVX4gJ7thwLDxhm41GnBuEkjynAcseZ0M+H40GQHAw5wBT5qnpJx4s
 giQQ==
X-Gm-Message-State: AOJu0Yw7jT3wsEbEvT9k6XMy4wAM2inePvSOQq6DOgKW+KsTQW4I/68c
 VvrYrLiNteR9l8Sda3SkWCd/2ujJCDCCvHtKOUwMdTw35eYSZDiPr3Vs761IfRU=
X-Google-Smtp-Source: AGHT+IFZUs5hwsezkmsyUHqmD5fryB2tKbTqpzlqhjV/LMJKM3gw5vKtaeHXLTfzDQs2r3hsoQupNA==
X-Received: by 2002:a05:6870:2c90:b0:254:7211:424b with SMTP id
 586e51a60fabf-27033f2b7ccmr512738fac.6.1723833622254; 
 Fri, 16 Aug 2024 11:40:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm1019856fac.27.2024.08.16.11.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 11:40:21 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:40:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
Message-ID: <20240816184019.GD1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
 <d9fe273b-ab60-44eb-bef8-cbde3af8ab1b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qyrmiRHPggQZV7kb"
Content-Disposition: inline
In-Reply-To: <d9fe273b-ab60-44eb-bef8-cbde3af8ab1b@linaro.org>
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


--qyrmiRHPggQZV7kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 06:21:24PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/7/24 22:44, Tom Rini wrote:
> > On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >>
> >> Prior to applying this series, the lwIP stack needs to be added as a
> >> Git subtree with the following command:
> >>
> >>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savann=
ah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >=20
> > For v9, I think it would be good to do a CI run with NET_LWIP default
> > and seeing what fails from that too. There's a few problems still
> > leading to a lot of failures, in that case. Thanks.
> >
>=20
> See here: https://github.com/u-boot/u-boot/pull/635
>=20
> I fixed a number of issues, see the commit descriptions. As for the
> remaining ones:
> - There is no http server in the CI so the wget test I added fails

Ah yes. So the test needs some enable-me type flag, like other tests
that require external configuration.

> - tftp is super slow in QEMU (~145 KiB/s) which causes timeouts. This is
> for two reasons: (1) the tftp windowsize option is not supported in lwIP
> (while the legacy NET does support it) so the sender waits for an ACK
> before sending a new packet; and (2) the latency is very high due to
> memcpy() being incredibly slow in QEMU (I am mainly referring to the
> memcpy() call in tftp_write() in net/lwip/tftp.c). I measured ~20-60 ms
> to copy a few hundred bytes (!) and if CONFIG_USE_ARCH_MEMCPY is enabled
> it is slightly better but not much (~15 ms). Also it seems the QEMU
> networking emulation is fragmenting the UDP packets because with
> CONFIG_TFTP_BLOCKSIZE=3D1468 the tftp_write() function never receives
> 1468 bytes but only a few hundreds at a time (max 544 bytes).

I thought you fixed that? Or was that only for on real hardware?

But also, some of those numbers sound unusually terrible to me. We can
get some bad luck with the free instances, but, still.  Are you sure
there's nothing else going on?

> - The r2dplus_* tests fail for reasons I don't understand.

Consistently, too?

--=20
Tom

--qyrmiRHPggQZV7kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/nRMACgkQFHw5/5Y0
tyydIQv/R7sqYGdJHQuPeQ+xq9QEwTOlc/PyPdqnnbDkeNtE1ccMxe6I6pcn4JqG
ojjBirR7M4BWsDlP+lTffA/tPJ29Bfg6G9sHjdEIfJ7GOjawmL8RtoggDZZe85UO
VFE0dXjtJbsFD3bhsXUncHNU/I4MzC+Xj/ojen4lhHkz5qhU9a8ENh5et/ZTdQXP
f1F4KhwFdY6K0e9OOqO8ufN/4Y9Yb8hYn6Z0gDmUIl9sh6DBFkLGerCyg8LiJ/Ol
cVUPgSxeEdn2LSm53Ba6wMzX2JKscX2Pq0lYPh2kAPV4MYmeSYBRR0D/hEJ0asA9
SmJleBhNpDZW2Z6s2UHV285XJq3b9C7MRb9i2U0Tjl2l1zo8wRkrDGcbFEEqYct2
gzTdaBH6eTq2beBBoY0LYWT4MfjN1K6ybti6ZyJ8Xjy9cjtjPIzk8lxXKR1QFJzX
V4h/y6mdqdxBNQ8cCTrrtLV9qAVpMaAKDeG9nv7euWpMJ9eGWM81LveWoJURAP+L
FnY6lAOY
=qFic
-----END PGP SIGNATURE-----

--qyrmiRHPggQZV7kb--
