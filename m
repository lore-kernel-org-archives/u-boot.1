Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8551C27C42
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 21:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B83186A2C;
	Wed, 16 Aug 2023 23:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGDlLCvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4675B86A1C; Wed, 16 Aug 2023 23:27:01 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F01986A1B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 23:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58cbdf3eecaso11291617b3.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692221217; x=1692826017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gfl06WBoNAt1/TMaI/6s/8GxNEJ8pbLwOZscO53178w=;
 b=qGDlLCvUij9WFZzaziqHhGER3P/899GwaROH2VRSniMALMdfkHBwY/pVJaQZVQVF2O
 WTdwtuyO/g5s0wX1rvg7UbaiKh/7lnQz4Zgt9jvscgpZkbCtvExpgHlC0us345dv0AtC
 fIHKP9keWc/ZHW1j0x+VYBeyshSR2x8ln0XNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692221217; x=1692826017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gfl06WBoNAt1/TMaI/6s/8GxNEJ8pbLwOZscO53178w=;
 b=RG0mEx+O5SpwBbiAeo2tKtQ81TiYQsoGOamWCD/AFLiTrRNyqBDdyag+bQTmxYEy9g
 Tp0tiHEboh/U9wUDE0XKw7Pel50JlYLRAY48zdL7TUrFGR6L3lwy8O/qrm0rXlOa3CJf
 1ZiGuosMpI0Eby+XLlpyAkN9XaeCjtmVSYudjdROCF+ut2l6wmBDajjgpbQPq2si3eq7
 svlIwL5NMfY331Jsh7C9bZhFa4I94p/6QQaJOMdlhSXB6XaUzm1ByiVQrNG5u9IVwcbN
 V2LAEeQ7iXmVlSM3FYUk+SRRg0h7YHYgSfgYL8zVbH1EAsygc4NKcjnh1BFqc7R126XR
 +qnw==
X-Gm-Message-State: AOJu0YwGY792KrqNa2FXXrCnKTN7VRh2YIgPg4n58i0D9xrypHiMTp8C
 GbxZm8yvP8RVr6T1kYEMAQtAy4EVrJvZy2Yg2+aZgQ==
X-Google-Smtp-Source: AGHT+IEUczMRNI3jcIdaYfVpP/bhWIfj+ZUhojlKJglb1Kp4PPQUzDGeVW9v4/bvq9j5MNtnXMK+Bg==
X-Received: by 2002:a81:a1d7:0:b0:583:f5fe:d73e with SMTP id
 y206-20020a81a1d7000000b00583f5fed73emr3011277ywg.30.1692221216932; 
 Wed, 16 Aug 2023 14:26:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-83d6-b858-ec94-88d9.res6.spectrum.com.
 [2603:6081:7b00:6400:83d6:b858:ec94:88d9])
 by smtp.gmail.com with ESMTPSA id
 r69-20020a0de848000000b00589a5bbeb43sm4217871ywe.117.2023.08.16.14.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 14:26:56 -0700 (PDT)
Date: Wed, 16 Aug 2023 17:26:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PULL] Pull request for u-boot master / v2023.10 =
 u-boot-stm32_20230816
Message-ID: <20230816212654.GB1515023@bill-the-cat>
References: <2eff3bb2-ebbd-b71e-3707-c3ae29419bfa@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8Z+1ZtNwFqOMHWf"
Content-Disposition: inline
In-Reply-To: <2eff3bb2-ebbd-b71e-3707-c3ae29419bfa@foss.st.com>
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


--B8Z+1ZtNwFqOMHWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 05:07:31PM +0200, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related fixes for u-boot/master, v2023.10: u-boot-s=
tm32-20230816
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/17388
>=20
> The following changes since commit 9b54b0e37b72aa9bfff09cbbe13465abfa143f=
84:
>=20
>   Merge tag 'efi-2023-10-rc3' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2023-08-15 13:08:17 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20230816
>=20
> for you to fetch changes up to 9e8cbea1a74516235820ccd50d513c961e43cb70:
>=20
>   serial: stm32: extend TC timeout (2023-08-16 15:38:23 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--B8Z+1ZtNwFqOMHWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTdPx4ACgkQFHw5/5Y0
tyzrkAv+Iv7/cvM9DUnfnl7KHIsc92X8E6+/4uyadwR2FQHpIvy/JkSO9WsZCvFj
9TyhMBfQUMbaAWprGeY7PCdvFQn8NXtExUnQXxih80JegnhNRewGzWZC70S8zaaK
MFcUMvbxkSetT4L5Uuu6h2PH7YayWrSOjZO114+GtDjnYmuk30QNYXfwhnvU4COR
C9nN3Yfi2cNO61lShHLsfqnS371SWWfzD9qlldqr+BgLQrytGdKcEWIgCgBVKf0l
LGDr8XeMsxLD4I+/n4OTgLXBew/CqERkvZBW1ASFNZ0I0ddpDOjpxEXQeKh8Sy/J
1XpaCt6zQD+KOjcltgjBI2giS9DbD87tSl7ZteIYaCFNtWvtdsO7MQNNGoHyjqU0
JRthXvWr+i626VifhxgQlYUPPXHpdYxEcJeNW/9hOxXTqiR9+UA2B3kGBDLc/CtV
FbgogoA8shbRwmezMgz0Yef5kATRVL8SgbypDwkMtEMhcTpigQ6vuqytWODELR0B
dV/ON4n8
=lM4n
-----END PGP SIGNATURE-----

--B8Z+1ZtNwFqOMHWf--
