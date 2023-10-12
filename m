Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54919CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C6C83414;
	Thu, 12 Oct 2023 23:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A672sYOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE0E86EA8; Thu, 12 Oct 2023 23:08:31 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE64486EA4
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7bbcc099fso18296647b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144637; x=1697749437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=geUUjA1M279C/83qje5Q7yQa2J94AerzIW4sSiybi9w=;
 b=A672sYOEAo9I6e4CAGtGKbTnhssNlF/KTn/aabhQObR74xjfqgesYI5/aJo7c6lO/q
 K6IGVxA6uQC79FELbSLHe3LGKfIcTpGEIA14vwpAfJilDS/h6PoidRNRnDqgMyMIKL/J
 NcTXAXr9JnvtorfDncPxQsuGYOy77V0x9rLfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144637; x=1697749437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geUUjA1M279C/83qje5Q7yQa2J94AerzIW4sSiybi9w=;
 b=ulrBXOwxF2u24JMTw2USeWb2AkGWZQr/x5ZR78uhEqC1dc0xcLmYh5aIjs7WvMMdut
 1q6YYbHlREjU0B3nQGudOIXyAcOZGGBlPVgJ0WDSXKc7AIVFzQq4yEGzyFwKYiqTJ4Nc
 kGsqWDsv1SHqneASfLF3sIJkWmPEV+ZGGsqbQx6oaXOzfI1VkRRSHOEBx0uRFAIy7ZrM
 Ie3eQk9Tk22Q+1YdJA925ijAVCKKx+UsslaWLRY4MLMlyuMjHapGaNcV5TUHcWyHOldn
 3Wb2e8ozZ01C4VpDGwAE86Yn5s/AMIiHWQOPn78Ttl/1UvOM1xH806d31WDQ/BkBfbMI
 t2Vw==
X-Gm-Message-State: AOJu0YyAsHJ52H3PzpMuXOntS3mtj1ijVfGAE8V2uWZ3f/QlkuKTHPtx
 rBusE32NvNgTPr7fbnMuu6AxzA==
X-Google-Smtp-Source: AGHT+IHzOJcdBow7tyyOZ801KmdR4r7LGNXUuFHjn24bp0othIkPSghb5nvi9jxcqCfHhz8NkJDMVg==
X-Received: by 2002:a81:62d7:0:b0:576:fc3a:3ef5 with SMTP id
 w206-20020a8162d7000000b00576fc3a3ef5mr28058987ywb.47.1697144637662; 
 Thu, 12 Oct 2023 14:03:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 w83-20020a0dd456000000b005a1cc37aff1sm218601ywd.20.2023.10.12.14.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:57 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Reid Tonking <reidt@ti.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com, nm@ti.com,
 vigneshr@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH v5 1/2] arm: mach-k3: j7200: Add mcu_timer0 id to the dev
 list
Message-ID: <20231012210355.GY3119521@bill-the-cat>
References: <20231005181258.1004539-1-reidt@ti.com>
 <20231005181258.1004539-2-reidt@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/XeqZ8NuQqsWpr5c"
Content-Disposition: inline
In-Reply-To: <20231005181258.1004539-2-reidt@ti.com>
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


--/XeqZ8NuQqsWpr5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 01:12:57PM -0500, Reid Tonking wrote:

> mcu_timer0 is now used as the tick timer in u-boot, so this adds the
> timer to the soc device list so it can be enabled via the k3 power
> controller.
>=20
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Reid Tonking <reidt@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--/XeqZ8NuQqsWpr5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXzsACgkQFHw5/5Y0
tyzH+AwAo7r2DUvGoO7YSN/OqlwLA/Tc3h+wN0vujkZuLRIdR/bTeon+x36h1fmk
40FcQDnjYE7DDXzm/GQmq7BnV4O30DwQIcI1n1pP7z1dOGax8XglhGs0ZhSKMhTC
57Dflon/P76ff5yWcuW1M0ipes7TKUX4qv4e3FDPqIADl109fqU+SvxntnMtNsFR
04M/1w+Ksza2/hWzMSPkmvrDLxROoze7uUqARnGIg9XFu2J3Q4frYqTgFymTIbdE
EmOOFhOHlQ+sYV1OKR3babjl3d/CgIqUgZ2GkRhRV6w2mVu/4b8OKtFVXX6r5DIX
32SGDMu+G9JK2vcPEPzfQg+//2HdTCFdIrUSmf5V81obhkmz7mjxZxsqu99F4dvb
bnpijjJM7sikGANO7WQrwrdXwA/86AMC3TpADCsDfwh5BuLtfRHRjQ5TNxI4C7qq
tNd9krJb/luN5lEpRSk9zuGgVcvz1riVOlj77v/nfEBtd9/J/PtbTs2GGPymStry
VzskseU/
=qCvF
-----END PGP SIGNATURE-----

--/XeqZ8NuQqsWpr5c--
