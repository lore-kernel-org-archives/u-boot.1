Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D3606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jgrH5Ekv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FEiSQ2uq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C06C180E51;
	Wed, 21 Oct 2026 17:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hz0_3ZZkPGo6; Wed, 21 Oct 2026 17:49:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6F2080DFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604945;
	b=CBTmS+dBRd2M7OReeoajQaf8aNROnTyWgOs0jz8yiCpq80PiRsxgAt41jJA1I0yRAvAo
	 YmE7oVFVa1yO9PQ2ZfefH1X6tzGMihMp2jEDy0NInhIBKqP/fTKRT6Jpl5CPgADmKh98L
	 FZAPSJ+z3Xu2Sxspw7/bopSfaPFMyWiA88VYvi1ITxnpcEURIm550IpdajYMrhp0UZYRD
	 Kl8JenuSDbqqGEzqINRcYsgslr/Dkf8mRfruARbjmM4f2tRuovp9mVTW/3h/oXjZIaSze
	 RVyd1Mfe7nhj4/wD4tjAA+FNvMVLWbK3JPQGJPq0so83xtW750aL2Lv+dIQpvUY3ZHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lf0vsPl42hNO5urmWE1BhSqNDuiLV6jbeo06ZZSCbuE=;
	b=CNrScoX9pSgcc7JJXViYFF9OtHr6TParCs06vNx20WtNVVtabQZHmO+2uLVhpJVdi6FK
	 OnHmBrdX/R1jrl8LCYjjNppQ1CzUqh5ydpqXZ4J+iaCLCJK6iv1lJ33CK/owaDhNCOe9B
	 t5JJ+AQtYQxvD8sozCLaHcEyexKT9L+v9JhJ1QjmOfUKXtUC78g3dWxEtcgZPARMwlgIZ
	 Z6VC8QHeydppSHRx5U//jhv7sT1mgAJCnrPuDyzIetm1z7ywiJCeaTxSXgcQjuklqjZsd
	 dFka7t/YYFzsltW4su4rqxxh8FweCiUq0qN0XZIvj+64vM5+HrOssOtW0NoUTS8dMWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604945;
	bh=lf0vsPl42hNO5urmWE1BhSqNDuiLV6jbeo06ZZSCbuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgrH5EkvufotpeMUW0G5SF/Zx/GJSA6i1Hgar0ZgO9nNx3mtKlKeUjk0UuTyhwDdD
	 mY+2qvODZ/9e4zVI676Yw0P9Wt6yOGdFgwW2CP+E/RVPLLFtz6641b06hvvQqjI/pT
	 UeMYyYhFn6Oc9SnlnQnEmWPBeNDqlEqiII66p0uby6hJXdEfzc/g8d+jwz3j/K09d8
	 5EnCGP5cdtPMfPVuA8J+JUWJbBVKPW46KO4F/ircIzDWJ2FsyA/GeStC735mm1s3w3
	 AfZLDF6yVAhQ7QmKBhfnYXIC+7yhO1IjO5haF+HaPWWu+vLZaE+LWFaiuH6L1gzU0D
	 XrWoH+Myh1S2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6F2080DFF;
	Wed, 21 Oct 2026 17:49:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5AF61AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABBB760892
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6twj_PtY6yT7 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC410606B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792604942;
 b=mQ1/uy8nLyAYNalnsCHz05M8haETQOPT3bVWtuL1lsS2erykx7ccrC487aT085dwMmQ6
 sf5sOZjx2lMHNpm/jJBcmCsbA9Q4YTvsZdT8MrLV8hx5eqwN2yGcD0CiIDGu2mrDcIqVx
 4Rh/py3gX0R7ZgJINgjuYXTC68+nqsogNfWID624rD3kW4HboEhzrj8qp3f3rPtBmVzFn
 akvvYt56J4oGS+HneSJlVVV58X5LNatKnvpUx7hw5GFo7jgVlqNghWAriJmqmUg+jKB8P
 a6XV7a11UfGEvuBR2DbXywRiDSdSfNShi2r/xABpPRrV2TkrMav3BP0iVNnNcb+G2fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604942;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=lf0vsPl42hNO5urmWE1BhSqNDuiLV6jbeo06ZZSCbuE=;
 b=evkERvJZGxbM/j90jR77uBMvczbG+LFHZb6Y35ZmFpaVXZ2iPYrRelXhZ+J4xADnnFDZ
 MR3VVMDg02pHm3chzjZMaX17oM78+ta5iG/xnYnz8IkB4tzU1K67sYgGT9srGZMB9TbIw
 K3fbHJJi/hNHsDabBFd47z4U9CA8r0NYKKeDfZXzErex+WH5/ri6xEw3oRFxAPpx6yESt
 MN4kIv1c7dMZc7NvWWHnWH/nzzfFEmEq0SHYrdFuFU3JZ3VRZTW+IVofNA0a/T4+AvSay
 AQvEAmlkeZUAzAu6jnWWoE/S8lDohj4tmsl64GvfMLN2pvkjolDiXWIinqpE0Qw94lQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FEiSQ2uq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=FEiSQ2uq
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC410606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:49:01 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f436312596so356702eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792604940; x=1793209740;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lf0vsPl42hNO5urmWE1BhSqNDuiLV6jbeo06ZZSCbuE=;
 b=FEiSQ2uqQSTlEBVgnrgkYjsbUzfy3X4+gxELS2mSQ1YyD3HyhKOaopHDMJXgUspjY6
 bgkgkQPiXKk0eDRI7nNfdk4eLrKtYye97v1VtV/mTLbGcRCwHBsrGWjAJvD5LbjT2Syg
 loKqSFqsGn670vddwKrL08BDidwho3gnm4BTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604940; x=1793209740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lf0vsPl42hNO5urmWE1BhSqNDuiLV6jbeo06ZZSCbuE=;
 b=VPuYwfDjM5EWCUmgVgwbdxJhGIKk4qUzilIv1IW73M6i0uL6wQ/6YMvun55iU2ApvS
 IRMI2xg27cam1wHqX50NBo3CAXcc57LFAz8OpGRDoRm4YCSJK2B22zK/jjcjfQZ7531n
 5E90xiSN/xz9alkBy7X5ZdC66war6ciohzRh4mfUErypxjC3jQ2bMBJTO9wvwESJC3dx
 Dm5B8iIsaae7bJ6sYCSPTgpAVLcDo+VHSdQTv6WJF5IpTV+pN+9b+sNHyh5+xsr9ZHtz
 Ck7bB/OPTkqvvqTKNtuZn9zbS7wekqwRgeXoLYc6MCys8j+p7xeOtbs9P1waBaZ/54MX
 9GDA==
X-Gm-Message-State: AFq9FYIQz3zFq6Sbr9TcBa83jbQwwhbkBdtKOtD8omrasnRqJCw+F7Iw
 TIEpG6AjFltp4W8+sZTyX93yF5tD50XPtyk7KXMHOWLcPJ5pnAgMDduuamo9OYlkd9s=
X-Gm-Gg: AYBFou1L845/2pJioV60R89cGe+tPQkLYRwS5UXNVDJvrMA1ghyL0BYJpg4Cxz7rb4l
 4yMz4q89iuL2MLsQ8VlgEtStoD1Axz9DftkFKp4h8dKIH/LaMrnfikDH+MhQzS4yy9GkweOzEAL
 hz7EloyklbAF724/ynMco1ZsUFn5LHrVpajUHBizHeST1rh0RIToTaCd4OCJPQ1acFRBBfoCucI
 PhVr3SEv+V7x7yCGrMqYFF0lxX1FZpwUt/X3vxxohOT1fyfGbALIjoHHXpEmzUVAikksI5gjycA
 +0+K0/09cZBZfkFRFzbl7tGmhFTA1Rs45tdFL+c8tXwHBmVNBG/lnXGqBGOpzwAdDev0E90+LBu
 QPGRo3P4OXQ0KuC60WPT0udYRYYtEIY7zzwTY9XBk6bUan4CLu4JM64dYcJT+vikAbgotqyC+6p
 Gl/2ENW5YJGozjFg3GNnbK8HI5Woufx2D6fOTu35IWibLDsp+MHpBNIZQoCtX4rckh6sGS4WpbB
 9knIUMoWwTjlS582FaGabf5JBNNl2n4rJ08cnjVc21rxgsDLhCuW0etprcbutD2b0+KWUcYllKz
 SvhBTP8kAz+dWYUfs4P6bYiJ0oKOj8B3KIPZ/ez1qv8HGaif7AIrW1ypJ+6qJsBG4I5Qnnm+MIF
 4mw==
X-Received: by 2002:a05:6820:4c02:b0:6de:ba4f:af00 with SMTP id
 006d021491bc7-70940d63912mr1760145eaf.63.1792604939681; 
 Wed, 21 Oct 2026 10:48:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d6174dd6sm2557528fac.10.2026.10.21.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:48:59 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:48:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v9 6/8] arch: arm: dts: remove Lemans EVK override DTS
Message-ID: <20261021174856.GE3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-6-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NFKc+l2+Wk777ta6"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-6-18ce3e431320@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--NFKc+l2+Wk777ta6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:25PM +0530, Balaji Selvanathan wrote:

> Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
> provided the following SMEM modernize series is picked:
> https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-4723914779=
88@linaro.org/
>=20
> Memory node is not required as we can read the memory info from SMEM.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

The series should say it depends on the other series. That other series
should probably be deleting this file, too, yes?

--=20
Tom

--NFKc+l2+Wk777ta6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj7CAAKCRAr4qD1Cr/k
CvmPAQC5RVNTxRanAB360hkTv/gfmk8BYtUoZzaue0kYQ5K1TgEAhDblfTpM7oK4
mwHhnDCN0OIeUwIcSTBwetnnRyiWbgU=
=vNqQ
-----END PGP SIGNATURE-----

--NFKc+l2+Wk777ta6--
