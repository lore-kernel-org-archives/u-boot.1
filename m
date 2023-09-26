Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA9BE7E635
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD6E86BA6;
	Tue, 26 Sep 2023 16:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y1KkK5za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785BE86B93; Tue, 26 Sep 2023 16:05:47 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3153C86D47
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59f1dff5298so98420647b3.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695737144; x=1696341944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s8LfSD14UgM+TWYOvjTVwryZqmghpAfmbE0ngv9CA3U=;
 b=Y1KkK5zaFUzqVZ40UEjqdQyp9feyLJ7RGp9WAFvcGId51Fb/5wYeNCRvf6CLhi/U+w
 UamWLr+CUIrtHt8mw1+WZC7IpGl4q6UCHMHozkyMaLiXUkDN6KyLiGTIvFwCWgJUpFM2
 Baa4GSfqkBrxUhNgwNlMuqk4ILFpVF4mE5wVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737144; x=1696341944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8LfSD14UgM+TWYOvjTVwryZqmghpAfmbE0ngv9CA3U=;
 b=ZMAUqE6afWPGE4rdIJw7ksTU/vvxbBtEfwwAQsxYGWLR4wrQwxee8HPT/TYTgiBzAl
 0+g46/6W7omyKUjF2HeVGT3MebnoIosXgJupScN2/FyL8rCfcrsBL37AqQawU1wCFETS
 ZTdJPWo7m6Cskk+IC3Ossj15Epv7CrUih9qzqzvgPpOBtXsBZTFt30DjcoqxG3XBFerB
 XAGgfoGI/HYs8TonAejBEvpjqEMSsyQADZ0bNFoG8haPK7XPF4BOZ3+jbg49DloSRZA2
 LNBVqF4QKdQPFW/qIce+CWxWxoWihr8jMnePYvoT6mNe0wvQAF4YgdaPD8CjUrB5n+ys
 rF6g==
X-Gm-Message-State: AOJu0YxUZ7XXseDccDHAvaqqTZek68yvW5XWhdIv8l0yn+twQBWVzWKI
 lnB1I45w5jhINVgDiuAIRsruMmejkvOsd9tKdRGVrQ==
X-Google-Smtp-Source: AGHT+IFeMHNJrPhzZA9/UGLVwiz5KDAFZVl/Ik10IBhMY2CVlwxf+ZqQpBwlkfW/W1ycyUS7Xtkt8g==
X-Received: by 2002:a81:b3ca:0:b0:59f:7650:8fdb with SMTP id
 r193-20020a81b3ca000000b0059f76508fdbmr5356239ywh.33.1695737143792; 
 Tue, 26 Sep 2023 07:05:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 p188-20020a0dcdc5000000b0058038e6609csm3025299ywd.74.2023.09.26.07.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:05:43 -0700 (PDT)
Date: Tue, 26 Sep 2023 10:05:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20230926140541.GV305624@bill-the-cat>
References: <ZRJqblFTuKuSI1hS@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E3u2pVc45Yf88wn0"
Content-Disposition: inline
In-Reply-To: <ZRJqblFTuKuSI1hS@swlinux02>
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


--E3u2pVc45Yf88wn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 01:21:50PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 15155ab0a3d1f839509bcac620bfb38f950bea=
d6:
>=20
>   Merge tag 'u-boot-imx-20230923' of https://source.denx.de/u-boot/custod=
ians/u-boot-imx (2023-09-24 17:15:31 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
>=20
> for you to fetch changes up to 16dbe3d9d45527f67d479535a22dc4054ae93e99:
>=20
>   riscv: set fdtfile on VisionFive 2 (2023-09-26 10:43:02 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/17879
>=20
> However, this patch has landed in the "next" branch.
> Could we cherry-pick this commit to have this patch on master branch ?
> =20

Applied to u-boot/master, thanks!

--=20
Tom

--E3u2pVc45Yf88wn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS5TUACgkQFHw5/5Y0
tyy6uwv+LkACuq5shgIK0mGYyCEGtZ/re13yjj5/i7Jq/ks0sHtIgUNlJdj3cWjS
du7ed4bRRPsKBARNbvDHj9cCBdfGcTGGGsTPzoefgdGbEvGQwjXJcmXSkORKUpBF
NYgMf+Gpbna5UxAIAJUfUbTWCcXpH6CAOPNgjUSMCvQtH1NmtWcT5t1S44C4+K3r
Fn+RrvCf1Trrjf2hhfuWdYzgMQDik01jqZIe7oRqKlZqxblSmSuIWbsdZEPc1OKP
Vrn8fsRAdbnKmhEnsVjLo0tXapeLecJj63WdkGM5bwx/rq7PiGK+6jyQc3mCXKuk
I/WCulHaQSKEK44+kGCbpmH2auvs4Zi+0GbAmgTFEkWyiJ5TMsJX02yOSYQFPuko
h8KMYXJ2hkwOuA0noW4qOgMZJ35dXYM73GLDgx5fEeU3337YECWc56SeWAcpsNHP
1MIMFXob6yCieKYWwIYPV9Z4B+Cpn3k/MhYOUQFzqVCIiOydNZhs/PXGOrYQ+Vy+
s4IS2X6q
=AyAK
-----END PGP SIGNATURE-----

--E3u2pVc45Yf88wn0--
