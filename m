Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dhf6o4kK;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=chRMhuWs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1645560ED4;
	Wed, 21 Oct 2026 22:19:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLwDqw4aAKuN; Wed, 21 Oct 2026 22:19:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33C54610BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621176;
	b=ZnjTPXnLx6e69KBznXL8Uja4N6hkSKC3y1Ild1rV+wCfz767uFgyZiUzhIDzr/2hYFGf
	 oaZwMkeg0nTqxW81M3RxpmLv7QiwrWZTq0w5fZTdbM2VA/rVANKyCyMyQ6i4jJuj6uVDK
	 0OEk1arqsLFi7em5z1wDKInvEy/oHMj3/7/S0I//eJZ8gPUpfJ3xbQzHBmdDpm1CjgCq/
	 IG8wXxWhO8tvG4BeYRhI/kCnuYJ16S7Zbphe0+WSnCDB5p79m55pTI45Ex0ULtuB4nuJz
	 v8fgmy5b9iEqMAB4c/mBo8dlvLjQ0DJ+eGVcjRbwnJuWs6Di2BwRCpUk+zCpYEa5gZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YqoYIg12mlUwp5H49QrNKDnYIc5gJUlZaW4EKlcKdYE=;
	b=KIGzuwYiqr6zlLmABQIdMzoTtKVCVBg0eqZ3q4eiP14SDDP+K47Aymkut5B6Ur1mEO9U
	 VK0dctkLYSrPSVe5GfjvGtdSBsaGc24PI1l2EUNDKZLLfRl0zxlCdrhbAY5EnMTt5PP0V
	 5YYJDW1ElSP/dEecv8USqQTxaUtNhWoF0dIIRd6gZnIvMUGEC+pLWmfqkkYdZNhulGge/
	 wvTGn1RDdc0X836q52MC9SFbfWWjRHpBvKUoDmeILvmdBCvd5sFAf1Hu1qyMtbYlCTiA6
	 6xdXbTpxTKioiAbjWjRpR34/QsjwZZlebP3+nTfKj+CRBWjw+40FRzWqSfnukRU9B1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=chRMhuWs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621176;
	bh=YqoYIg12mlUwp5H49QrNKDnYIc5gJUlZaW4EKlcKdYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dhf6o4kKfzzOikIBUW3psu/bO06TPBN1o1vTy2cCXLqwg4Hn0sp3M+lsenEP4gMZG
	 DM92bgK9Q/WuGWaD3MLpv/3tMuTlCNmifxKkVcIfLG0EUAe1STDOVDtba0dLOswyf5
	 umepSTSWzof3oCVBixTBmODHuGb5jNz4jYBRBUDbLWi3gE9njxk6NWt3t7noJcKVld
	 7qQ6zgMdoH8YrYVa0G3lzf2B87eXIys1/ogOa4T980UKd5R1O0mYOhYNkZUQOtGuDG
	 ZGjk59d2eB4FVnrf2qHo87COTxz9WDl/DcNos5ZFh4yc4uFKJ4+5Dop0SemS8VfcSe
	 vA8qGWaDdKiow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33C54610BF;
	Wed, 21 Oct 2026 22:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48BE91AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 397E660B2D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyckY38NOAD7 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6967160AED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620849;
 b=MNhR8YixT/oTlaXjMD2vgMLD/70FFur0ZAZAMzZpdEWt9QtQrz2Dhp+0px/ABsmgHhvB
 w0BxuFMd8Ajqx0SjIt0eJ9FIytopKH/vzcoHOyvd/bMhzVCrWI33W0MXEAqNrNdzgk83M
 LOu8t4eAxIzJd6gHTdC+qo9PApggN+HnYQ40w/lYwPZcNQ0l99CIEl8GzhQ/frtSmz6pO
 c30P/+ZYbyGSHpE6CszrT096Axn8MKp2xUcu2QNs8o1q5ezhy009eMYuJejxwTdlWGa7L
 HgGWHgmFGo4p1pkU/EajBT5OVjv55AaVUCug0ssjeDjxvvJVRxImHpxDapaORNZCg9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620849;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YqoYIg12mlUwp5H49QrNKDnYIc5gJUlZaW4EKlcKdYE=;
 b=TGPkebH4sqfUJPz74cd02XHGaJh0kvCiGuE3MCTCbIsLs2Y8DE38TJH1HVb1uQokV7VM
 2/zHJrbcjYfkd5YjkIBV2P7X3z/qgdkA3K6Alua6R7+EMLDcmqej3GUKFzIjMfcrL8Evb
 MJ94OwZQxFQX+Tws6mjU5/FBulrRQKt26uxn09yulhynInaO7QpCFuy+kHzrQeg3JNM8x
 WgtDVpjTfoEZ91bFxnc37qTnkyJCtMPblkX61iSNLZRSpCtplghn5O+97t1B+nIJT3iP6
 Q68wk6G37VGbE60XhZ1F8VnZ3Nuh89xHctTQvKr/ItvUW2TdgOoI1BAmXeEJkD+jMEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=chRMhuWs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=chRMhuWs
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6967160AED
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:08 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6cf995766a3so982461eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620848; x=1793225648;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YqoYIg12mlUwp5H49QrNKDnYIc5gJUlZaW4EKlcKdYE=;
 b=chRMhuWsmvnTiXwE8Q1f2YfEtxiTuN2lbRpZPCYv8FS/8jSHg6u4d6Rjx7TEnDumK3
 FDcarsL1apYb7pmTmJ0DNgE0BKIqkBJ2dEcS/vXx3ZgM1/tlGwDZ/982xWDVHk/9FKCK
 UR6A2bXAOTPh8fPmaM6Tj5QPjhzfOcclNMPJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620848; x=1793225648;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqoYIg12mlUwp5H49QrNKDnYIc5gJUlZaW4EKlcKdYE=;
 b=dZjZBAqSF3gjpNEyVm1k0gcp9gQemej9Ii9sRmiDx1hTVzyMjZpvSbp82j8lNXuwN6
 uBdONEnodhQW/1ng5/iJJW2UkUrhWIblNbny7RhxXZGzlBqHtWVV61hrVRYQET6lBNyx
 E05Xso2jeuFPH66mLP68bAaxZouQdLCYNYlcpQa9CBEAzn5+K1zU7dUyPe11Y1jLRSFL
 NzDysje0V5pg7F85iX373jr71CL/DOCVlUr2+iLCGMy8SWFhKWH9/sEQIZOo64GDiHvN
 IVLVPDP8QoJbWuv1XikA/kR3f5JIservVkNqVilEMAZmRBg27nGI/BDZjRPH4TW+M4nl
 COqA==
X-Gm-Message-State: AFq9FYI4j/LNpv7P5n3apdEgpsGNI4JGqMkXGaJTN1YcMq/rV3E6pGLR
 JyTUov6srYwtVAbv2W+sa9SSxM0WUzy71OsRQCbiYtDPaYSh5hJE9K+lVYgIyUdUnY4=
X-Gm-Gg: AYBFou2r6VtYd6VkyWZWRT1Z/Q4ojyD30iBGwKaJalk/tm4/8gIWOaG++ffgksVTSuC
 HKQHNmiXXaR+tIJhkgmjqSMeczVLMDiVqvnGqKKT7ZJZLCIwOndIGdXNmJEVx9M2WsopfnP9imo
 cHn4oXG5Eg1V+1TjCq58cJ89mEBeB9UnzygtJzGoDcKaHMkO8hN8cvITXpzQCnw2eVGvfwmVrvS
 9gBzw62dUF4LvGkiCU9e2SeDYZtWV3mlIeZGBI/Jx6qqjVdLzzpdhyB/IZM16JuPkndruoybFbM
 e2DijVlPQZ40I4n1m3sF8sVl3LwIfHRFlEfhBkJP4uisWUARJLPLQT9AKASzH8ZfJ4nwJ5Bctes
 WE6cC9Wa4uxG17Kze4Xtzv2IdoQFt+bmgMGjNpZXeV3qMqeect6suIb32qZv84/F4z9rO3tJM8k
 FafiJsyPq6NAUB+b5G9igMAyTcsXxXQ6cHoz3XYEri+61Mahjobxox/lJZD0wuVw1wz5o2gWZ5k
 jGWJKzjO3/f/wsn3jQGhkByppqEGtTCJLAbt5wpUkg4FdsMt9Am8sOwYG8fJjFi1zULC4TttMvq
 Psys0A7w1TBcdX8zU93G/K2w5BnpoOda2OEvyqa5Ij9pMvnKoQEWBDBlNKnT7NgUkItCm3KLQbW
 D
X-Received: by 2002:a05:6820:c2c9:20b0:70a:1787:2699 with SMTP id
 006d021491bc7-70a17873431mr1066087eaf.33.1792620847949; 
 Wed, 21 Oct 2026 15:14:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbc7d9b1asm3293888a34.8.2026.10.21.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:14:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:14:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>,
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v3 02/23] spl: fit: Stop reading the image type
Message-ID: <20261021221403.GK3275858@bill-the-cat>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="33bcadRbESJuf3sR"
Content-Disposition: inline
In-Reply-To: <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 21 Oct 2026 22:19:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--33bcadRbESJuf3sR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 08:40:49PM +0400, Alexey Charkov wrote:

> load_simple_fit() reads an image's type with SPL_FPGA, or with
> SPL_OS_BOOT and a decompressor, only to print it in a debug message: the
> FPGA path checks the type string itself, and the decompression message
> no longer names the image in SPL. Yet it links uimage_type[] for it,
> around 0.6KB on arm32 and 1.2KB on arm64.
>=20
> Drop it.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--33bcadRbESJuf3sR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatk5KAAKCRAr4qD1Cr/k
CoSxAQDfQ1CLrLXS1L3LOP2ieotPi7pfZ8U5UC74a46pxujMnAD/fE3gswFfBIlE
C2PUNgpFLlkJ1di+9Cf3OJQSvmdw3g0=
=be8T
-----END PGP SIGNATURE-----

--33bcadRbESJuf3sR--
