Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC7E95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 14:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA9D86A02;
	Sat,  7 Oct 2023 16:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GW3EE+99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4C686B68; Sat,  7 Oct 2023 16:17:52 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21CB86A02
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 16:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59f82ad1e09so38605757b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696688268; x=1697293068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xFfCSkChEReN0X7tKkZjApDme9a4IoIjx8YgBIaJVYc=;
 b=GW3EE+99+q30IQ6tgumVXZfv4e/Qj53SxayYgCUx8Y9LkRyUHpL958OuruMc7nCMcx
 Dt1ypHND4aLhkkoizIw9PTkMe1vvlENhI5RWZYlnTcvu7jDJSsUeIMM87BMBFu3GpXmc
 MYyKZU9TrL1MtyJgMXcQPoq7o5zNDiqDfnqxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696688268; x=1697293068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFfCSkChEReN0X7tKkZjApDme9a4IoIjx8YgBIaJVYc=;
 b=eJxFyq1f+uIfHq/wfeh+a5iBOqfdDsMc3hMV2LAMpIrenJkYbPY7RPvjrL2BN2d6wm
 kLEudTFpWIMwwIl3qlEUSlnqPm4adpQpNXUxR/WeMUFNohwqA+yadMy56w7kDXcH6zY/
 KyxTSbWZBjM1b/6/xkCsR3ZhhF/36nkNvQ0wvLSdvxWb7uziOyyTVjhkkqoa3VKJXDIg
 tcZ8c1iwPYAcxon6++1t+/e8/0owI5Xhpb5m4BiHZRv4OYEZl3Vn4P3Z43hx1bR2qXwG
 MvTxkC7v58cDasQiPQouNXAHFS5DolUuUsZrp9elgfqH8anGixPlJT8cHp/KJT8jb/Nu
 b0RQ==
X-Gm-Message-State: AOJu0Yz3CLd28Cri9M4g9IvMssC9gDSWFpfiH75A7mpurnhm+3JfcnsR
 9uvKw//LoA4pKO046DzhbXtyFA==
X-Google-Smtp-Source: AGHT+IHAv60EmkEb4ooefZAuVIkTmhFjKqcWLNG4AGyayWvv8oemNQJDD1PlGq86E0cYY2tFtbfDaw==
X-Received: by 2002:a81:8345:0:b0:59c:a68:d36b with SMTP id
 t66-20020a818345000000b0059c0a68d36bmr12560425ywf.20.1696688268464; 
 Sat, 07 Oct 2023 07:17:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-429b-02e7-f294-8f62.res6.spectrum.com.
 [2603:6081:7b00:6400:429b:2e7:f294:8f62])
 by smtp.gmail.com with ESMTPSA id
 z124-20020a0dd782000000b0058ddb62f99bsm2113204ywd.38.2023.10.07.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 07:17:47 -0700 (PDT)
Date: Sat, 7 Oct 2023 10:17:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v5 39/43] command: Include a required header in command.h
Message-ID: <20231007141745.GF2227687@bill-the-cat>
References: <20230927142359.2965941-40-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wfMGeql5PDDDNh5J"
Content-Disposition: inline
In-Reply-To: <20230927142359.2965941-40-sjg@chromium.org>
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


--wfMGeql5PDDDNh5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 08:22:37AM -0600, Simon Glass wrote:

> This uses ARRAY_SIZE() but does not include the header file which declares
> it. Fix this, so that command.h can be included without common.h
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--wfMGeql5PDDDNh5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUhaIYACgkQFHw5/5Y0
tyxRcQwAqjXbBhV0APiEZAxRg7p//Uei8G2puYQTMaliSOsL6WTaCgb0AXRLYzD9
Ltw5Ky/3Bgfgy409UwWOV8vAfjsmsPwTx/uEc2u1DJFwWqO2z1yuGDd0rYC/wcJP
tPW7Badpm2e8GR7E0F7iaGGX5mGCCCFCqQj0JjeWNtJoxg0bUbCab6+8rT69D5dy
GSpF5oYCvPqdlbSuF+5miIyEj1wa7GNacIKTQxo57ByBtX1W4lgpK5ucSwSCY1LU
KHjkogQSPlQMIYKL4zr9O8GOGTzbmzcLnWxRsX2PP/BNFAJcfJdKjN+1hizqqhHR
4qkREZ9uRJDMZlBWBdueSlrtmjy3pU/3ZLxA+X2qr+efxoYDTFVzqeZLxCcq43Nu
5jiQUhv3YIYR6PpcUgwYIfOoF1/S8ELvIJb2SGNH9vEjnXlI3SpU3UXVDz6X1sOg
tWkntUtQOXtv3mscYGYWbtyRywUbW9NoOcyrf4EsF1ldWZMeMvnwn2DFNIbt/9SP
8azRKcBF
=HTVi
-----END PGP SIGNATURE-----

--wfMGeql5PDDDNh5J--
