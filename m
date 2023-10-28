Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1826C27C48
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 00:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A078717E;
	Sat, 28 Oct 2023 02:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CP3LdQi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3681786F09; Sat, 28 Oct 2023 02:51:16 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB33486C3B
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d12b3b479so16864176d6.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698454271; x=1699059071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wBGg2+O2i5924t9s+cbw24TXL8IYAMxBUY7bTeSgZzA=;
 b=CP3LdQi7YjLb6e5aP8T+pyKnZgdVayri9kFUJDV6yOyhJ3usVc/kMK0LKRkO0t2W5n
 pAOGiAs11p+y3AdHqOnPm/hBt5vje+0ZFCAXJYPj4BMV0+PImn/pHqOnCbcN6b0RYTvp
 RLB6OtGZHfSDlInbfsC746qvNxyL/x9uiJUAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698454271; x=1699059071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBGg2+O2i5924t9s+cbw24TXL8IYAMxBUY7bTeSgZzA=;
 b=Q/+yto76VRhRsO6AbTV65JWAhk1TPzacPDcYMI56bURPhhgaMSNNyRCkrxQRdcCDaG
 T7iT0SJssOQP7WL+H46MkFJmHdjyoNruUSbqZI+chn2LOFzdZpd/yBELF1hdhBXqSNCh
 cz5HyfzNbkDCb0504kKm/M31Vr1NXrQTuyWuQNDb0GAb0a5hkYAkik96P1yFlVi4UNa4
 cBiOlc4g9FLHSO446O9VrgRPNZEo7AUmmaE+Gc5PUARtpkoRJWzAst3w72XFvwJk0rfJ
 vQoyzSyLuje1Pf5E8tBjYQvN/EiFvttdkehrP7YVIoCSHfDSjggI/WsXEtdEdMCSj1KT
 fjaQ==
X-Gm-Message-State: AOJu0YzvR+KtClIiCGYRV8Rai6kPKHRpb0mkFqk+21Xky2ZN3Rl7Jb0w
 HwUE9cqqaoBkIfKx01Yau6yhPw==
X-Google-Smtp-Source: AGHT+IEzTJfbMN/J+gLklF4NOLSGUEgTZkNQRGX9t3coJkytR1GqOoOyRl9V+DxsnaPvTm6S5yuXuA==
X-Received: by 2002:ad4:5ca9:0:b0:66d:2813:fd18 with SMTP id
 q9-20020ad45ca9000000b0066d2813fd18mr6089845qvh.52.1698454271589; 
 Fri, 27 Oct 2023 17:51:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a0cea2a000000b00646e0411e8csm1092138qvp.30.2023.10.27.17.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 17:51:10 -0700 (PDT)
Date: Fri, 27 Oct 2023 20:51:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>,
 Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: Pull request efi-2024-01-rc2-2
Message-ID: <20231028005109.GG496310@bill-the-cat>
References: <a400d609-3328-41c1-abad-7c395be64228@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6DtUE5QRhYmzqJRG"
Content-Disposition: inline
In-Reply-To: <a400d609-3328-41c1-abad-7c395be64228@gmx.de>
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


--6DtUE5QRhYmzqJRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 09:20:37PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> This pull request replaces pull request efi-2024-01-rc2. The two patches
> with which you saw issues are removed.
>=20
> The following changes since commit fb428b61819444b9337075f49c72f326f5d120=
85:
>=20
>   Merge branch '2023-10-24-assorted-general-fixes-and-updates'
> (2023-10-24 19:12:21 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-01-rc2-2
>=20
> for you to fetch changes up to e89827998fa47408f3d0be0384c7c19cfe8e2b3f:
>=20
>   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-26
> 00:36:07 +0200)
>=20
> Gitlab CI showed not issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18303
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--6DtUE5QRhYmzqJRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU8Wv0ACgkQFHw5/5Y0
tywrUAwAiD24MZ9tPwcza4wrTlcRk4SS9KSDm/YBXDhBx+7pdyVnKiqmz1hZNvA7
Hjpww+MrCXWc6s1QRY6jkkdqZMKh7+6+D5rQ5T5F7dVDuK/EkXYr1PMvWLwK7Ek2
KJsNr9Vs1kAcy3sK3kF8BRsDMCOMqU4FdgdOcWxjyHudf4g720TBavWpyb/kNAap
Nj+RnEgoTi0RQP65z535Ukkru62PXfCKo26HIXOz9xM7ppomTI0JoEUWLL3Lse8f
rrLbalTj/1g1TIGYAOWn1FO6TFPQG81jtKIZavuhFLvSDMmm5ofrqJbl4f0lrakj
QZ6xUCCoRJjs5voMUYlgMDLLdlbELZGFTjZdXevsN6rW/hUmEu1ZRl1qPM0oh1+Q
MUOj9DmsR5MKKTknZEdmTNs/zQ4c75yrNaufUmOCGw7e8EabXqND73R/2DT52kWl
dC4w0j9NMXTLoDq3RM1cCXMVQik4L+AHtMXCEfRB+0F/0UBnMqrsHlMbjSY5Xpbh
mMcV3d5L
=IedX
-----END PGP SIGNATURE-----

--6DtUE5QRhYmzqJRG--
