Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D289CE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 03:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06FAF80107;
	Tue, 17 Dec 2024 04:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GH48dfDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9511A801A0; Tue, 17 Dec 2024 04:56:45 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12528800D2
 for <U-Boot@lists.denx.de>; Tue, 17 Dec 2024 04:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46788c32a69so59643681cf.2
 for <U-Boot@lists.denx.de>; Mon, 16 Dec 2024 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734407802; x=1735012602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LB5T+nnUb47RV8hjeEx6l5Ag1Kwe5DQM3ndtTRORCp8=;
 b=GH48dfDG7WEq6NUcBXft1kDu4vKl1979Q4TX5XdTYrsRiV9rhH49wjgt/eO981kodL
 zSULImZcjkJU2bCUbjqr9z7ox6nx+ZY5QuTgm5ouY53KI5d9ZG+vE574BwiT3gogvu9d
 9nEXopp/CWAblTahdymNIVO8EKeiThnflDH0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734407802; x=1735012602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LB5T+nnUb47RV8hjeEx6l5Ag1Kwe5DQM3ndtTRORCp8=;
 b=fgc0IepbgHAio33geMOns8D1OPR/UQplYOvcVnyyJWZ6vIRaBNL3coiddWw/mg1Dvf
 5M/1qOVnySaE5iLExvlu/+XsUlod5KTgKrBaLkq4VnTjPgC2LhNLMxla4DTG6yIk7t1G
 QtW1tQHiaN94lrBrrcpTqOmTnsoC0OCYI+sBXbiy+5ixtMiPnUqzII1cw7xDC9NF3Bpg
 3tSs4BGb83ZSwQYP4arowTkFUHlEQxN+ISj1bjZRo3BL4/cqVV49oyIj+ZxWSJ2uDkxc
 28FlW5uFSLFM0s2ehXsU652HgURiGMUmq8F0td8gsvNLJ8yUCsLb+7rPqecAKishOPYM
 bb9A==
X-Gm-Message-State: AOJu0YxQuJo82sIAKsgbBzDf+MOxo+HnCCkjoS+LdVrmMa/tF7A321hZ
 ApwTJ7DGbi+lmOxz534pLSYQrQTaVHybMOtD401M54M4Q1OBc/TOqUDa+7UaCnA=
X-Gm-Gg: ASbGncuBCEXu+kZGzRo33O23gLcewZvzFeId3CGhLD8+WRj2fV8fBf9wIBI0FmI3nyb
 MeJbN5d5hx/9j/zD9TSxbnXllEYEHySDLuu4coV/wDruueHIAR6b3aTvL7ucqs5D/rQBISMO48s
 e0M59kMZurvK1JF0U4PbsWizLe8VVDt7Zqgrj5pKZ7Jf9eix0egkfhABcDA6dI6p/157kT9DunU
 5GURHE3k2EGFtzf/pDkM4389Vi70wYr022WGTnzxOz6GXVwsAYGH2K9
X-Google-Smtp-Source: AGHT+IFyiTsZHvLeH5Q5vfwLwsOIa31pYL8k2SE6BSw3FyOgqCcH0ZOwYFFSqMEjbaydM5LHwIDO0A==
X-Received: by 2002:ac8:5741:0:b0:460:90aa:ba8e with SMTP id
 d75a77b69052e-467a583bfb5mr315802821cf.52.1734407801801; 
 Mon, 16 Dec 2024 19:56:41 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bbfa8sm281495085a.84.2024.12.16.19.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 19:56:40 -0800 (PST)
Date: Mon, 16 Dec 2024 21:56:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>, ronald.wahl@legrand.com
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
Message-ID: <20241217035637.GI1505244@bill-the-cat>
References: <CGME20241216051037epcas1p12e4dcb7ac35bb120deebc9cd1300b504@epcas1p1.samsung.com>
 <ec1e7fef-d067-4d7c-b7ae-b45cf788f765@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WyZqHyS1fHgx/d35"
Content-Disposition: inline
In-Reply-To: <ec1e7fef-d067-4d7c-b7ae-b45cf788f765@samsung.com>
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


--WyZqHyS1fHgx/d35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 02:10:36PM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
> Please pull u-boot-mmc master into u-boot master branch.
> If there is any problem, let me know, plz
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/23871
>=20
> The following changes since commit 50334151c02077f16613b0a082d95640800ba6=
0e:
>=20
>   Merge tag 'fsl-qoriq-2024-12-15' of https://source.denx.de/u-boot/custo=
dians/u-boot-fsl-qoriq (2024-12-15 08:02:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
>=20
> for you to fetch changes up to 822afeb7bf84ca1c9289a61ea99604b4deb8e091:
>=20
>   mmc: Fix potential timer value truncation (2024-12-16 11:24:42 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WyZqHyS1fHgx/d35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdg9nEACgkQFHw5/5Y0
tyyMIQv+NCTgROKPWT5YjZn5a7N1/ZvFemW0DFNePzfYUvp5jrJrEsksibmHXK3J
irRN3WR6VZTMbvqSstDzq0zSNrJV+hMCQryb8+zlyXL9E621T/e8OaTsDRb4COMw
/txLIPXTFdlzMo9iBa+6akX4cGvdCSB7ydF3trNYgng2sgMxSrzIyyEKWV567w0D
yrMQ0ItO6KpFWBh5Ubb4U7LOJqXq0wnuXQd2UPu+FGYpK7bFW9qvA+9mGDnIs6LC
sYu2XL3m0POurPGg2YamVOlXjZDAICtHSc/ERACqbxQXf3+JL4DC0gJGpz2j71IJ
GnhICsTq1+58S6LZVFRtBkv46Ty4wmdTn3yRPQ9a8ZXNPmsZGjguygNPbvLb4ILB
6bagSZOnA9giolWI7+9SHBeK7t7HiY3zOBRJKMM3sn4WHWCDS/HtIj/wKgOT6L+c
IkhpGabMjiYUgxOiaU1aSUJTfZBlJGMY7nx1M1ycQRpkbb1xgmsxSdjBa96KvsxY
IJQ+q694
=zf6Y
-----END PGP SIGNATURE-----

--WyZqHyS1fHgx/d35--
