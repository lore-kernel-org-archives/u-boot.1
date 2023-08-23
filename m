Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A5EEE49B2
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B19286467;
	Wed, 23 Aug 2023 16:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KJqbENAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266F8864D8; Wed, 23 Aug 2023 16:42:24 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2103386467
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d650a22abd7so5640681276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801741; x=1693406541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2xnzkmbJZ3Vqg4m/ABnTq60P6KNeA0kI8CZH/GwFJrg=;
 b=KJqbENApjd2WhoWBy46BUuh1rIiBPSE16aWyD54EO79U49GtL2/eqH/wjJyNIKZDpY
 ZrDR1yYGkd9bnfLaoZT2oWsi7liM6R0p/IMY6Z04lqbf65B1idRkNKTaZ5lRMSt5220h
 oLXQqXS+ab1/tClgNBoTcOmgHt7Ul8M2W4dRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801741; x=1693406541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xnzkmbJZ3Vqg4m/ABnTq60P6KNeA0kI8CZH/GwFJrg=;
 b=bzmKYsvkQkFo5eCBy425VXO9GYhmVuwonYo8AV5CxU4FMRQfLtyi6IbOgMM7Y4CjL1
 J6+K/pMvRkWrzUrA6pofTJVz9+GRhsRhCPnc7x2j0VbNfG0YMGF2YdPLxU7hy3yGOxPr
 4/XyTcz+l8BINWtowx8X4icDLdFlvEkqFJkvfPx9uML4OxQfDcYhMjDr0yK25Afu8vIy
 JDR7LaibeJ8bqcIJFrGZFnMGeHYKDewCcO4qSQ8WF/EEkj0BIsbZ3EQB/kg/A6FoJulH
 xJgPfhtWlGYakixkrpDTe+K/NNsITfoUJDe+Bv4/5SKPC29VeDDw3K1/43ttOANd6b92
 7/4Q==
X-Gm-Message-State: AOJu0YxRry0TbIk0iMg6opmdYRzd9m3NFniJ3I2oAXubFsVxrglIFqs+
 aSBSHo9NSign+hs4isOZdX3XIg==
X-Google-Smtp-Source: AGHT+IF3gpSLvEjsUqxk+HFa517cw3CX5jnvFhYWHHzAEe1ZpNSjU1gFVY9Xd1YVMFtHkHLEXblaAg==
X-Received: by 2002:a25:40c5:0:b0:d72:80bc:d3b2 with SMTP id
 n188-20020a2540c5000000b00d7280bcd3b2mr12677751yba.32.1692801740741; 
 Wed, 23 Aug 2023 07:42:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a258207000000b00d607f70d762sm2747520ybk.32.2023.08.23.07.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:20 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 5/8] disk: Extend disk_blk_part_validate() with range
 checking
Message-ID: <20230823144218.GW3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-5-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eIwd0uGEGj52UKGu"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-5-marek.vasut+renesas@mailbox.org>
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


--eIwd0uGEGj52UKGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:45AM +0200, Marek Vasut wrote:

> Check whether access is out of bounds of the partition and
> return an error. This way there is no danger of esp. write
> or erase outside of the confines of partition.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--eIwd0uGEGj52UKGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGsoACgkQFHw5/5Y0
tyyAuQv/doUEy3nF34FzcKdHQzyYp1icAmBEMrRvOIsHDGxb4FMozYsqgTzPnq9B
lDOj445oi+HCC2MfdVmrymRIS/bxVlMmHAZ2wGTAzMgUcysvI8y+tsVe2AQC+aU2
mAQJWDxZDAMRWB6KxF1g/Wcoo5ArnRMqlVUvAKS7E0/JT6JJU1BRpXOvZHqxlV0S
2A1KwyfyBZMrV16oIYm1EQGdSDgR7JlHAPFjyv88/ZpyvYYMkhpoyQto20a/F5xP
FiC2ZzjNe06YZrY2+K++O3uOlD32CI2zwbHqyBqwe6G6k7kf5WU0dZ5348avyKcS
u08Sw7wU6VFOU7vtwXQr3t2q908g6LifTRnpZ/xm5bCjB65tjG77dcY6C4iS+ehw
zUUbMKJTQYchaxQcTGCvev8HejB63gaYwwsOOTXQLwREyuMZ3zEHj2e9Y1ZQos7x
F2LZYmxtLdx+9jdgdRLNz6lNW46KungPWU+Z6Wvi25qcj92gRQZv8lpZR1JWC80D
5i99zGkk
=3bIN
-----END PGP SIGNATURE-----

--eIwd0uGEGj52UKGu--
