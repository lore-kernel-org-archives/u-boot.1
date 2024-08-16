Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CA1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 16:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B0688618;
	Fri, 16 Aug 2024 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tK1f5vOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53E988B6D; Fri, 16 Aug 2024 18:15:15 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9778852A
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5b986a806so1784394eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723824910; x=1724429710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dzP2Hfsf8yW4ss7IZsf1CxiFCgDg9Ud3DkKHnE4dtRo=;
 b=tK1f5vOcfb1r/IT8NpvyAjLuoB/N7v5Fqph21zD66pUXf4GabCRNeFC/9zXUTl0ENc
 JSj3rYVs4yoAcRlSi6efiZufvLPhzhx7eXPhnCwlaReBynGsuI0SHrIVY0VsDq9+nwZ2
 JBQQgHglQ/HTzOmHci4f7QaTOjwhGz6z4MTvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824910; x=1724429710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzP2Hfsf8yW4ss7IZsf1CxiFCgDg9Ud3DkKHnE4dtRo=;
 b=RXG2IbmepZfLQW5VpQoSDyygT7M4HXmxu88ZGuIAGCCeQoDuiCFdjKzXNhQ1oiYa0o
 vhPHvuPbGLzwy0JTRVwhN/YX6Jz7A3o0ZvVp4bm3ArYC3zCq2YLPoKAOeF2b4TcTlFrX
 7neJVYxkKHrakZ4KLh6aBumgYtfBP6kbYI1BiG6baCZs4/OuQvSS/oikofw3AN6uB+k2
 V7AWK4hOUBccEhrZb/3sz1geDO5F9+tOTTnrQe8MjFKeICr0jhOdkoB+Q4EyEXW5DTzy
 C02v7BV7+ewMq4IjjtSCx4BTnWycH+GDQWY19z5UQeaVCEJj7EC59gXOmdQXuh0RoFmY
 UZ6Q==
X-Gm-Message-State: AOJu0Yx9+2IfDrcA9L+7lym90xl1ngPXh6VAcMW2D7YDJzkuLSte3V7g
 InGlzq9nyw+Q8JQi/gAArma3AQUng8NnyImvollP6hPfzgwkPbjXpn1I/twDXJw=
X-Google-Smtp-Source: AGHT+IEyGE4k+e8VJzs3mtF2tcpXliFNFNLDjvYBLIuBenjCadipTnxjsg1wkK4bZEzX/HpAs4VvvA==
X-Received: by 2002:a05:6870:639e:b0:25e:b6c2:3bcb with SMTP id
 586e51a60fabf-26fff0423eemr2237932fac.0.1723824910531; 
 Fri, 16 Aug 2024 09:15:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046c0082sm950175fac.31.2024.08.16.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:15:10 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:15:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 04/24] test/py: Fix some pylint warnings in test_ut.py
Message-ID: <20240816161508.GZ1626301@bill-the-cat>
References: <20240815202535.767869-1-sjg@chromium.org>
 <20240815202535.767869-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2p4alcVjsgEb7CwK"
Content-Disposition: inline
In-Reply-To: <20240815202535.767869-5-sjg@chromium.org>
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


--2p4alcVjsgEb7CwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 02:25:15PM -0600, Simon Glass wrote:

> Tidy up most of these warnings. Remaining are four of these:
>=20
>    R0914: Too many local variables
>=20
> which can only by fixed by splitting things into functions, so that is
> left for another time.
>=20
> Part of this change was done by the flynt tool.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> -    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
> -    u_boot_utils.run_and_log(cons, 'sudo sfdisk %s' % fname,
> +    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
> +    u_boot_utils.run_and_log(cons, f'sudo sfdisk {fname}',
>                               stdin=3Dspec.encode('utf-8'))

This should be re-done on top of Richard's work (once he fixes the
pylint issues it introduces) at
https://patchwork.ozlabs.org/project/uboot/patch/20240802093322.15240-1-ric=
hard@nod.at/

--=20
Tom

--2p4alcVjsgEb7CwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/ewwACgkQFHw5/5Y0
tywRnQv/ZcC2aoU0t9pBxza71YBf1OndE5ibgRSDSDeD9gwOHnhM9HaOVdV5AN+F
5ROhtZ0YQ6dUxotYa1Ejq7CH5KWYqE22iZFZj1qpIkqFYffFREgwIE1C5sErt2F1
aW3EGOX/aCNffkEnTx5TPST5chtWqxMKHFPFe3mwW2Ek7cRIQxMbuP+IZEUAfMQD
pOeLdfnLnI96z/eQ1CPI8HKyi6QkA2YLp352TFmW3kMgeeRAkVhUVx58fjNaYEuT
cPFs7qPxMfylNR6drrlCncehD7WNCEzX2N0gSNZhfKBdWzSgTuTuvnYPJIfZpN82
C25KHTu+ATrjunYM0XDQSYMtCHgrnoYG7E3JUrQ++avhJkwCC6Zg5nTSSMQ7vTo8
ZsfMZMG3wHFnSCyvhuhNza4mHKAGFdNyn0/Cj8zWQVbraM4ftwhpBTh4tCG7D11d
ob3Jwta74x8NY704quWGj3Q/PDQahfsBTgMz5Zeh3b2IkXdl/dWcLNMqk2wVBSYb
2LmxV5Nc
=8MXp
-----END PGP SIGNATURE-----

--2p4alcVjsgEb7CwK--
