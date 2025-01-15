Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B5E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33F480703;
	Wed, 15 Jan 2025 02:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXvxPvz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493CB806D6; Wed, 15 Jan 2025 02:13:43 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1819880214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e9586b82so519933485a.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903620; x=1737508420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LwNQKJaxgUGnPPASFTPdp4tM4QhcJjWxmqwsTFus1Cw=;
 b=LXvxPvz9i25cg+E8p2W4z7EJTQHvDySyi6ruhjGTR2OiWd0YJkjh15qHD/Jwln/hft
 ndw36Q8gKMOEwEQqWvcGDyYm+pHdX3n5uIQXBtacyiPECGQUcwVoIWIFSKKNc5x6nnGx
 uyBbT7ToWtNFYgAfcRFTUmM/EUfe32i3lQy1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903620; x=1737508420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwNQKJaxgUGnPPASFTPdp4tM4QhcJjWxmqwsTFus1Cw=;
 b=LiCgs+JLdDTLfm9cCenHSwckIui4HP93pIc3pW4UrNYCPeg75CPze47kM23vkwlbHF
 aYNfC86KQo3YUxYBS35T4jymZAaefTx5dmopLHvkRqytR9C+I/Vr7aBk+lwwZ1JS4wHc
 YS6H20VHzkULvbaXDqmWG3X9bTveCh/UHTvWDrFFUlHwLQPWwYKxl6gqeBod0iWnQltU
 ha/y23muypUNZWGziHUzDTP1jsuMWDmpxVOUZCakULt3UHIEVhPzAN+KGFAGyweXdrcx
 EHgBSJtgrQLirZ4/eXwFW6Ch7HYYhATgHKiFcx9mmQ6hToQuIafQg5F/kZkl29CXZQk4
 YDDg==
X-Gm-Message-State: AOJu0Yx4/SLJ8+dR8FUdaJxJO8BVPa66lJ9Bw1inwTfgWhUyJcOBi597
 140idwFCb+hCORHjI4EGvvN5FlvTI7FY5dWHdQ3lBYilvGRbVX6vqdr6f7tfJZk=
X-Gm-Gg: ASbGnct6TK7aT+hyaAGOz/ubm1s6ZABcJf4ZbClmHgi2tVpBIT21DkVOyRG+nMk9DgB
 rwcz1CCfKTGt1a4MOVNxE/Jk1HgTAOciGY9bRPyX7OVg9NReGoXsdPai0y8mKQr4dPuOeOwcYRc
 +tPUDZN4Qw33FI2emILqwpwbDViNm1L+C+HQ2jPjZ0v/iM3/EvaO4l6K/4L24gUprztxTFnYfhH
 EbmCtFoZz5jkl9v8LmIoz8ElZIKcFm7p9Ks4gCtkcI1F1HeywaWcg==
X-Google-Smtp-Source: AGHT+IEOHDqIYDXJoArftTsC78qPMg6Hc1sa59XCfF/qPYVJuJ4gMGzWzHgksgcDF5w8CpR+SiKDjw==
X-Received: by 2002:a05:620a:4046:b0:7b6:eed4:695c with SMTP id
 af79cd13be357-7bcd971628fmr4556566885a.32.1736903619865; 
 Tue, 14 Jan 2025 17:13:39 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324830fsm660356585a.46.2025.01.14.17.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:38 -0800 (PST)
Date: Tue, 14 Jan 2025 19:13:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 1/3] arm64: Add late jump to kernel board hook
Message-ID: <20250115011334.GR3476@bill-the-cat>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gC8NIsN1QJT58y2G"
Content-Disposition: inline
In-Reply-To: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
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


--gC8NIsN1QJT58y2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 11:36:57PM +0100, Marek Vasut wrote:

> Add empty weak assembler function armv8_switch_to_el2_prep() which is
> jumped to just before U-Boot determines which EL it is running in and
> decides which path to take to boot the Linux kernel.
>=20
> This weak function is meant to be used by architecture specific code
> to implement jump to a firmware blob, which then returns right past
> this weak function and continues execution of U-Boot code which then
> boots the Linux kernel. One example of such use case is when U-Boot
> jump tp TFA BL31, which switches from EL3 to EL2 and then returns to
> U-Boot code newly running in EL2 and starts the Linux kernel.
>=20
> The weak function is called with caches already disabled and DM shut
> down. Any preparatory work or even loading of more data must be done
> in board_prep_linux(), this hook is meant only for the final jump to
> the firmware and return to U-Boot before booting Linux.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gC8NIsN1QJT58y2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHC74ACgkQFHw5/5Y0
tywtWQv/YEm+YWrhAAc10FOLB16CK2zSoPn3JK71KvXJxqny1DTIWaUt6Y+pRnC9
ZBtMPkyMEaI7CNRY7rCt2rT2yZY4fDU9OCIlIRcXIP+qI8so87RhSOEYHVe/xLTp
/M9WcjM4Q8Y9dNoudLzCDrni7OlBvxQRDUMVrkKv8dsdFvAi/cS5VmkssreZnMiC
Et/kDbDiVTqYRIisd720AcKPqRcBdneYbWdoVTwTsuBDdKvpveNNOQtTeO5eMHV4
htpKULuKV2F4EbszUYwCW2ouPxc03qAi6Ul5Ktboc23EtHOtMWfdlXPSe6jvEUAi
mnVftbk+zx/1m3S1Osk/EzN+0BG28QxEHD6m2GwEYY6q1mrAwqerkyJGdaMtns9W
FK8sFId7499GbVOiSN2843bmhX7XaS9ObQXgkyVVVp5ze+oF0dFa/lP8PvNmzP1L
1+AeErWfsaP3DZBW1+qDrBLuln4ZX4xqGlblDmogMynlOHxGzG4kAP9gUmfhGHZs
ZsKEx071
=sP+i
-----END PGP SIGNATURE-----

--gC8NIsN1QJT58y2G--
