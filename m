Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5C5C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BBC879FD;
	Tue, 16 Jan 2024 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JPzmM8Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42153879FE; Tue, 16 Jan 2024 17:49:18 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4B1879EE
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc236729a2bso78034276.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705423754; x=1706028554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f12krigyrUJtsV1CGFcgLNlC2SqeYDJLWOdVcMdGbeg=;
 b=JPzmM8Zxflz7j4SUeLX6Hht9Cv5nG1xR92gNZfJwYgZMnvjKXzJedLkqEDqvK8v1Lo
 L1nm9jmw92rVZ5KdTj52KWHg8HkLQYiMnVQhZoMQyQBSsAtLRDwrKfXb5PTfFJ3Awy5+
 N7kOFn8YCPEbgSk8B/ZqydkQB2yPnrz45oFMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423754; x=1706028554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f12krigyrUJtsV1CGFcgLNlC2SqeYDJLWOdVcMdGbeg=;
 b=DIbnLgOjPTX1XU/6xDx2bnbyhQtalESiNGHPW9tK2SZ+zBaEG/daG6awPBEOHYf+se
 xQs0C2cP56G9nRNd/phf2cDOCuicd7U4Tu9Td88LywcXNE9qXHorXyZp46WvPek/gsBo
 jxxodT88X8IiF90sb/WBdWwYE2z9KD6A/xdBID2TT6Hqr2Ng/6Mz6MB/JwFLNCQMc5Ep
 KeJlXm2CFZWnYyatX3z+cSt5/4lcyW3EZeLaO47M8ygHjiIP31NvwvOppXyt4tnf8hgt
 3H8YSLWMkqpRSfaJ8ffw5lfWjDfWxJQ1oDLAPfyTfIOanKybTfZlAwSye5GWNef6epHG
 4TQQ==
X-Gm-Message-State: AOJu0YxtMWpLVHvY2Ecqixa5JBYaPXtKtm1ELkmooV5FN2zie8xexWf2
 cTvjdx9DRpDy/rAAix89YkSQ9hqXvWUajQ==
X-Google-Smtp-Source: AGHT+IE8AJRf+FbJpvALI0T1kuhQrgoo54SQO+34Gb1rJNVRO5NKEUcxZmpmYK/NlVhoJ9sRfLN/uQ==
X-Received: by 2002:a5b:c4e:0:b0:dc2:207b:c903 with SMTP id
 d14-20020a5b0c4e000000b00dc2207bc903mr1082090ybr.94.1705423754444; 
 Tue, 16 Jan 2024 08:49:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 124-20020a251382000000b00dbf3dbedd69sm4474731ybt.53.2024.01.16.08.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 08:49:13 -0800 (PST)
Date: Tue, 16 Jan 2024 11:49:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: Please pull qcom-2024.04-rc1
Message-ID: <20240116164912.GF12635@bill-the-cat>
References: <20240116123343.1038689-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Stg0vlQsdTonP5Q4"
Content-Disposition: inline
In-Reply-To: <20240116123343.1038689-2-caleb.connolly@linaro.org>
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


--Stg0vlQsdTonP5Q4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 12:33:18PM +0000, Caleb Connolly wrote:

> Hi Tom,
>=20
> The following changes since commit 697758e7c81131da6db0e3b10515019fe3aca8=
c9:
>=20
>   Merge branch 'master-sync-dts-663' of https://source.denx.de/u-boot/cus=
todians/u-boot-sh (2024-01-14 18:07:49 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git tags/qcom-2=
024.04-rc1
>=20
> for you to fetch changes up to 4c3dfa1b8babf9fc0575ce08eed99f950d3bab84:
>=20
>   sandbox_flattree: enable button support (2024-01-16 12:26:54 +0000)

Applied to u-boot/master, thanks!

--=20
Tom

--Stg0vlQsdTonP5Q4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWms4gACgkQFHw5/5Y0
tyyr/wv+PoTOX+RZppKXCpBYu8HH7vM0DMoZGnvCoN+gtBMaeF5fjBXFrMsDFBSR
OpCkG+XrPlLVPmBs4UHOryH/pDK0jOWWhnbaNp+WBS2FMppSrWYxE/LNZsCqxPL2
/5iKWU10hkOOhUdPHCAmy11GeKsg/qhtxBcdEvalAm5jy2pWa7uu58aNlj94EU8+
wcVYMLG5624FJ4UUxfaHCgTrMPvH/mUl6OSynf4GfIAuPnFxnZWkotRYTZYTQbCV
3g84tNpsUzxgKjBY2SrGopzLKaih1KeEEjOk85i39sPhFhfy/NoxVr+CTfll1k+f
aZn8XeyEYpVLboOZXGTB6TdTmOc7x3uQi7+Hj6qKMokJF0V7griB46kQkxibxc9A
I8LzzbcTT6BNnt/wre5V++g3c2Cn5ffGIYRWR5hKSo5OnaOH1xZwhiEQNFmcrNjw
u4Ydg6EEkwYdULd5dauyUogziLgSR5kra9/pTXLJZZ63g9tq/SvHvDq9W4gdRqVt
npSaVQ0v
=6P8s
-----END PGP SIGNATURE-----

--Stg0vlQsdTonP5Q4--
