Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3149FD15DBD
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38FB88EAF;
	Mon, 21 Oct 2024 18:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QWtkpBOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C2388CBB; Mon, 21 Oct 2024 18:50:06 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B7588E94
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b14443a71eso431562385a.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729529402; x=1730134202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MuVl+21HDY6+4RGk0zo2stJYM+Qsqn2EG0F1bSMc3I0=;
 b=QWtkpBOdVs8HW/f/2ym4UnUVUulT8A1XUaMhFsb3DxTT/5fWX0MN70URuO3SwYB9fZ
 msHR4dvCWDRRtZNKoKhBM+Mc54MSpTnVDICMz6nx7S+devyU31gmsef/Wiv+eAu0RVcW
 SGA18C3+WlpSEBzRkLySheu4nftT8qqP/MCmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729529402; x=1730134202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuVl+21HDY6+4RGk0zo2stJYM+Qsqn2EG0F1bSMc3I0=;
 b=nzF1X5wfhWzBgGKF0EhV07QvgIaXJ9EQkuT8jyIWJZky2n0AcqailLgpNC74OKRgVw
 Gw9IQn0tpp4ScaVCPLO+SnCT1U9/6e3KTYMRk9UeBuITs1jZR3/BwuUEm8O5HKtfDTsE
 W61aCDseeIbU5Sn6nuOkT50TzfGvk8s989piSioJlUqfFKPFTsmkMqxaPUeG5DlV2WoF
 +sY0fqafiIOFaCeNyxnvay4LqtoKyT0DcQ53F1S7y0xScmtqpWGqcexmgoo7lj6unuEJ
 vbjf7P1SC9rVptaOa5iFs5GXspp2f7SnMiGe0jROsWWmxs2Sc1uF3GU2h+mox6OGOAgG
 z2MA==
X-Gm-Message-State: AOJu0Yy73VU+YmVPfA88jhwqJCpCiWBZRDmA7xD5LwhCHcSRHeuC41nB
 eFY3ivy6xHkEuB3WmpkfXkswtk+VfRn3SyJJUJpJAVuo+VttpwEzqa7dVVY1il0=
X-Google-Smtp-Source: AGHT+IE4QBxgpUyWmfZGTeS6nBlAa/tI0hIKpDRdehLiJ/bEQw7/GSmA+oFsVK2O/bGQb9yevOOiBA==
X-Received: by 2002:a05:620a:4692:b0:7a9:afef:33e6 with SMTP id
 af79cd13be357-7b157b670e2mr1568357885a.34.1729529402140; 
 Mon, 21 Oct 2024 09:50:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fb7c3sm19286526d6.35.2024.10.21.09.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:50:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:49:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
Message-ID: <20241021164958.GK4959@bill-the-cat>
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="te2/zbMfJPBXe1W1"
Content-Disposition: inline
In-Reply-To: <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
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


--te2/zbMfJPBXe1W1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> >
> > > Something this breaks, so add a test to keep it working. Since sandbox
> > > enables a lot of options, it is a good board to use.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  .azure-pipelines.yml |  8 ++++++++
> > >  .gitlab-ci.yml       | 11 +++++++++++
> > >  2 files changed, 19 insertions(+)
> >
> > I don't like this because "sandbox" is one of the longest run-time
> > build options due to all of the tests it runs. And given how we break
> > down the jobs this will make a further bottleneck. Can we just disable
> > CMDLINE in one of the existing sandbox defconfigs instead please?
> > Perhaps sandbox_spl since that only does SPL related pytests?
>=20
> Actually we do boot into U-Boot proper as some tests need to check
> that SPL did the right thing.
>=20
> Note that this patch doesn't run any tests at all. It just tries to
> build sandbox without CMDLINE

Is there no existing thing we can put this in? And have we had another
problem with CMDLINE=3Dn ? It's not cheap (wall clock) to add another
stage, especially in Azure, I'd really rather figure some way to bundle
this in with what we already do. Heck, following on with
qemu_arm64_lwip_defconfig I'd rather just add
sandbox_no_cmdline_defconfig and use #include so that it's just a few
lines of defconfig anyhow, but merged in with existing builds.

--=20
Tom

--te2/zbMfJPBXe1W1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWhjUACgkQFHw5/5Y0
tyzi/wv/e/LIKWoG7fGLohktlA7P3DM4ayktUWEWLltrY5WcdHYEtooxA0BzDHF0
lNrQ1jR9oLWwvW9DF4mudprIEAcakjlJDlfrsl/YChsSeEhxvekE0FFL3t3ASkEk
9SETb7SkwkM16djTtCZ35bN2QDIuXX3215ogkvhM7Mql5Jd1g5B0AyXABb6SGWhm
ZEGilJbHBXfWNihvvxBvkcL6As9QEj8Q6vvkP7SbeudHuoKfUozIDyqC4at09cjF
b6GzeUO5ry+KD2ANnt6V79mVbYivOeYKkUxraK/DNvH3VtGUHGTMtc7xYYxvkxUo
nXl5jcnvtRBaoyYtmtML4UKxypwbKB62H5s8IF0MWrcOTOig/BXumjnScUdU8Kxr
xFtW1CrBAv1cnoiFLoIQADxbCrbm3ftIUT/kClgzPa9cmQFjFvV89c7HN7IT5quq
VNq/UEV2CoNlBU9z/rztmjFVr+2oKBtLGhxX4TUNHXNlo9mdYg6swyQCliMb0voD
TRoC1GA8
=iGNo
-----END PGP SIGNATURE-----

--te2/zbMfJPBXe1W1--
