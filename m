Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FC5C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3633381FFC;
	Tue,  1 Apr 2025 15:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gKMRcpE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D2A81FAA; Tue,  1 Apr 2025 15:53:08 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09AE818C7
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c787506611so1652054fac.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743515579; x=1744120379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5xITvz1futXLy6adseGkqVaeiAsvk7yqvP6YP135I2U=;
 b=gKMRcpE520UNUZUylupYFdGXVLrx2rRoDd2VGItSRaLA1ISlrDViRBBMhffs7nQS70
 CSfZEfAT/EbznOymaHYYU2XgpoL37ibVXO0g0xRXcPgmptQjiHePASLLHA3LzS4ZxHA1
 CM6wzGsjHk+o/WaHrYKSMpBRChLe58ExPNkXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743515579; x=1744120379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xITvz1futXLy6adseGkqVaeiAsvk7yqvP6YP135I2U=;
 b=WGDrtqCDFjHsFSzR/oGWwfD6r1cBKd6qU2Fg5HbWQG2Asx89m9pd3SFznoZaIIdwXd
 LxecaPjRQi2XuSKrxAaYDOImEp18uoWVVaiamhF9IrbQJcI+BmjxlU5MhiJI3lmsVL9B
 GVYYZwmzNZ4jRNPs6FMH8EzamRwVfq9roIaVl2VqehddMtmSBWCNswXtkr+gdjz91xtQ
 mLmkkwOQrvf5sZE3yIg4nRiDQ9K4DhIk6cbZpKOXsSOVgyZl3I8cJuB6xLfNrUr6DQqY
 4DcOjzX5d4EKKDzTwqfVQowBWgnnGjme2h9vYkJOQo0NckN6oZzD24LacS5850tqqhzN
 Lymw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl325PUJ0pmyszP88wT027M+BnhdyazTPclrPaav8JhPz0Jfz4qmGSlcEIHYahFipKV+zenFo=@lists.denx.de
X-Gm-Message-State: AOJu0YxtDfB3zpGLrxoX3dOB/h9W8p0dBK3KPdX4P/xADpcOmOTH4Qx7
 Sf6Mc7hCTb6ZS2hMLwOJUNGCMEe0aNf3XIIKzUUNmNIJ8AKCC4SGyliS9lwZa+k=
X-Gm-Gg: ASbGnctOFc+PjF6rvBsfaUfHVsjP7MnnD77S2BDk06wax2L13OAWHVj3ghit6nfGQ8Z
 H5dGzxQDH5N/RicbmlEyr9kfWR0KGGa+69528KTahVjZZ4WWwXCu8p7IDg75Ka/chIGmQqZPqAy
 OjDw7YGCYdAVcqZAyhzuiiZK7wrAxz0fmeRq5rbhsI21dWpPhdO7y8BVYOjdq7jENrSZlv101Vi
 nN5wSPeQTXes/Pb4W1VQ8eJZ9U3AcqwB/fsXFTJ5sQc0ldMoYaV6mF5ArKY0DmgOAnoVMNE/6po
 il0E8qzEQHyy08DgHPSJQRVs71Cn2eQP7+HdbmLPLrIANTnyc7DAiD3kKh/IWHzswhQ/V10FGFg
 5BG7BCg==
X-Google-Smtp-Source: AGHT+IE+svpgWtH1gEmYRyonYhxVRn4vBHtXeDcB2WsmWEb7Pfm8LP87lmNo5cl4b2zRf/jlwGFawQ==
X-Received: by 2002:a05:6870:b149:b0:2c2:5c26:2d8e with SMTP id
 586e51a60fabf-2cbcf51534cmr7643356fac.16.1743515579078; 
 Tue, 01 Apr 2025 06:52:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cae8d4422fsm1971227fac.35.2025.04.01.06.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:52:58 -0700 (PDT)
Date: Tue, 1 Apr 2025 07:52:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Leonard Anderweit <L.Anderweit@phytec.de>
Cc: "festevam@gmail.com" <festevam@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH 2/2] CI: Build missing binman tools before binman tests
Message-ID: <20250401135255.GB5495@bill-the-cat>
References: <20250401084642.216933-1-l.anderweit@phytec.de>
 <20250401084642.216933-2-l.anderweit@phytec.de>
 <CAOMZO5AzKUUt3YpVWteiwb-DaqPdBjxXKwhXOo_5aZtacpkXzA@mail.gmail.com>
 <5eb9bf4c4b30bf09fab544081f5733bf278103fe.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KqJbCzWouULa/R0p"
Content-Disposition: inline
In-Reply-To: <5eb9bf4c4b30bf09fab544081f5733bf278103fe.camel@phytec.de>
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


--KqJbCzWouULa/R0p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 11:42:35AM +0000, Leonard Anderweit wrote:
> Hi Fabio,
>=20
> Am Dienstag, dem 01.04.2025 um 08:12 -0300 schrieb Fabio Estevam:
> > Hi Leonard,
> >=20
> > On Tue, Apr 1, 2025 at 5:46=E2=80=AFAM Leonard Anderweit
> > <l.anderweit@phytec.de> wrote:
> > >=20
> > > The CI image does not ship with all tools required for the binman
> > > tests.
> > > Have binman build the missing tools.
> > >=20
> > > Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> >=20
> > I applied this series with Marek's patch on top.
> >=20
> > I get the following CI error. Please take a look:
> >=20
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1084138/raw
> >=20
> > Starting build...
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0 /1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (starting)
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0 /1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to=
ols-only
> > Completed: 1 total built, 1 newly), duration 0:00:20, rate 0.05
> > Fetching tools:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootgen bzip2 cbfstool cs=
t fdt_add_pubkey
> > fdtgrep
> > fiptool futility gzip ifwitool lz4 lzma_alone lzop mkeficapsule
>=20
> binman now fetches the missing build tools.
> > mkimage openssl xz zstd
> > Fetch: cbfstool
> > - trying method: binary download
> > - downloading:
> > https://drive.google.com/uc?export=3Ddownload&id=3D1gxNxRuJgD0Iiy9LAPCS=
B_0959eJCp98g
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [=C2=A0 4%=
]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 9%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 14%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 19%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 24%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 29%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 34%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 39%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 44%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 49%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 54%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 58%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 63%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 68%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 MiB=C2=A0 [
> > 73%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB=C2=A0 [
> > 78%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB=C2=A0 [
> > 83%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB=C2=A0 [
> > 88%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB=C2=A0 [
> > 93%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB=C2=A0 [
> > 98%]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 MiB
> > [100%]
> >=20
> >=20
> > - writing to '/home/uboot/.binman-tools/cbfstool'
> > Fetch: cst
> > - trying method: binary download
> > - trying method: build from source
> > - clone git repo
> > 'https://gitlab.apertis.org/pkg/imx-code-signing-tool'=C2=A0to
> > '/tmp/binmanf.enbq4kln'
> > - build target 'all'
> > Exception: Error 2 running 'make -C
> > /tmp/binmanf.enbq4kln/code/obj.linux64/ -j 40 all OSTYPE=3Dlinux64
> > ENCRYPTION=3Dyes': make: byacc: No such file or directory
>=20
> byacc is still missing here. To solve this, the ci build container
> needs to be rebuild with the first patch of this series.
> Then we need another patch to reference the new ci build container in
> the ci pipeline. After that byacc should be available and cst should
> build without errors.

And updating the container is on me. Since this is for -next, I'll pick
up this series in the next day or two along with some other Dockerfile
changes.

--=20
Tom

--KqJbCzWouULa/R0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfr77QACgkQFHw5/5Y0
tyw1Vgv9G2NEPV4JqEKU9rUSWhhCIrUe2TQoE8MAQdW7kfKXtQqDrbuN8gcHCAUl
faBjQCYlOTDU+unBk85VxLIkRwvrHF+5iCtT4M+/mrYYCwK+mRNUk7W48RAEzBFW
Bup/oNgXjp0ATc0tkdKTuga2l4JKPAbXlPMqn6SBpTVwo0nlyQYrAeBjjTSQCsPt
UBD1C1ODfJnHY0rxCzOMqSPARO5GK7a1/jM7w9XKAMpABsNEJceJPcDIM3aJ2sM6
ohW2Hey8+YRmcSHrBdI1pDPhDhIWIa9AKc4oQ5djQQk4E1n48b9ZIPPVBP7GjfJK
98gvnKGJB26khesCOCJ379GcTjnhAVJw1aSZCc15GNimVdnpZp+KXDp20VGi+p4X
17TVT5RDrdZM9geae3FVKt1HQlmM64OnszQawQMYnlC3YYlE3OfuPKiTYtCloQ1x
49GEV6iRxhEE8KZxjGL4KITKl6YhoOnuH1LzQHZQW63uJCMllt5vkpjmFoU1LoWT
PyiqEU9x
=4kOw
-----END PGP SIGNATURE-----

--KqJbCzWouULa/R0p--
