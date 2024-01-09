Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE5FC47079
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1328878C9;
	Tue,  9 Jan 2024 18:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K7K2DDZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8016E87913; Tue,  9 Jan 2024 18:49:44 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD00876F6
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7811db57cb4so254207185a.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 09:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704822581; x=1705427381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DYTTjb9J4mRglvW7JCX1SjkcoDd7mF3Yn1PRPm3cX+4=;
 b=K7K2DDZbjp4q75zrq36TPdwlMax35ZrfizpzPbKmdsUk20jWN1zf1YKiKW17I0I31W
 EkYrbLxtcI997ESoTW8WLekquokqdOfwkaMyeN7qjoSAIeYfUsIlAc4cKzFiYZ0wr6rY
 gkq4wqYht5IiaFuFXlGgyvFNb8dancLOt8xyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704822581; x=1705427381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYTTjb9J4mRglvW7JCX1SjkcoDd7mF3Yn1PRPm3cX+4=;
 b=NLvk/GfQcjYvzmTKiCoiGsEkB6QW6I0OPbmSLHQey+bGb7YCV2EHIaX4da0ivRjBQR
 vN7HHkDPhZeXEocHzfbK+gpw1Mne25+WfRmwQZSL+LJ3jRuFyrIKCR7mYXApns/Ad+qV
 bxyidreOkqc85nYHsETNHH7IQqvWcV40HOUGbQQLSliY6qaFr/lxcUdN/8n88jaHE1U/
 fjlneD4uFKKk80Ac+qvZuZJ5I84um98tU7HXeH1bjK+at5FMmB19WUgj5Aqbiyzi83UV
 DTYdhwq2fxHq6eNtTqyzG3bFM+Oe46aECBoCyFM8XdG5JMpCGCK8cNthbJ0Owk8982Ro
 pfTw==
X-Gm-Message-State: AOJu0YwSIK00jEw4CtDt76ywqgHI+Mw51lL8XB9kkt0J7jt1ln/hyHxB
 a82BxYsV/U0LMdaTjsjyY5OIwsLOZoL6iA==
X-Google-Smtp-Source: AGHT+IEudZfNuehTjoBjgBrHuLfziUY6R8KuvcU2qluSHbi6HfX0vHjTmM4OTOvzIgpC+DUcz+9iow==
X-Received: by 2002:a05:620a:d88:b0:783:216f:7623 with SMTP id
 q8-20020a05620a0d8800b00783216f7623mr1566416qkl.78.1704822580813; 
 Tue, 09 Jan 2024 09:49:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 a27-20020a05620a103b00b007825f50eac6sm969852qkk.122.2024.01.09.09.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:49:40 -0800 (PST)
Date: Tue, 9 Jan 2024 12:49:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: Pull request rng-2024-04-rc1
Message-ID: <20240109174938.GU1610741@bill-the-cat>
References: <44bea48c-b453-452a-84d1-9a5ae88c5f15@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tftKKEV0FXQLRzdx"
Content-Disposition: inline
In-Reply-To: <44bea48c-b453-452a-84d1-9a5ae88c5f15@gmx.de>
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


--tftKKEV0FXQLRzdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 10:07:37AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb=
4d:
>=20
>   Merge tag 'u-boot-imx-master-20240108' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43
> -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/rng-2024-04-rc1
>=20
> for you to fetch changes up to 1351cd3b4b1b18cafa4893a44378ca6b1d091c8e:
>=20
>   rng: detect RISC-V Zkr RNG device in bind method (2024-01-09 07:37:05
> +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19241
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--tftKKEV0FXQLRzdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdhy8ACgkQFHw5/5Y0
tyzf8Av/fveyBmRXZrnVm0nafx3reHo7bBQKAIqCAveSr3iljySTjFkhIdUya1ZK
eZJ9kUW6HB1mTfDUg67KWwGFPUYAw4tSPVTR0voCP+nirL6wnzB/CXc3xqSbaTRG
GYaQTxCifwXSLBVZ0d9U4A/VCR7ru02xvelUpMZZ6BfuL2+flX1f4KqSaMxZHLBV
Lvzx0MMCocGhFyV4L75wPK1Vbfku8D02rzvzlBieK3B7tSzbh90/b7r59k3CtqQQ
Cv4MIF0Y7HQsDtyDd9JXK03BcxXGrR2z5v7f/z9M3jmwrQby315VYULGjzCbKqEF
E6iLIf4fKA9AI+9UodLblr62rvDzsB1SrPDQxpMT10eyV3qJQfl7bKBGgGxg5fUH
48sag8uMN1q2t2WSxpCKTOGh6EWMRuVIs2h9FGMAYkjevIVV0ckom3QdhxHLodcX
MWh+X/+M9VgzsJ06xX5CYIG0LM53/WuJG+B3N2EU1Ke/wk1ixHfCxuEnx4Nm0hEf
DAWXCMNw
=/O7Q
-----END PGP SIGNATURE-----

--tftKKEV0FXQLRzdx--
