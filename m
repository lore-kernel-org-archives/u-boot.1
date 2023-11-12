Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0E9C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 18:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D5E870A2;
	Sun, 12 Nov 2023 19:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VfzydEOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9C286B75; Sun, 12 Nov 2023 19:23:04 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B89186958
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7788ebea620so258423085a.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699813378; x=1700418178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BzepqfNM84jQYG2oLRhMt8QStTmnEmT4TRvZ89WnWb4=;
 b=VfzydEOv4k895EepsVn4LbdIU6GaQGgdNDtx7b6nWzVrcU8o7YigG3Fn9uSY1K7BZf
 JyJ6RYGPmgQayg9n88wCsCPz+24xItLg0k01Qsa71A4uIqpofDFRyfWMUAXUNVe9bh7a
 KF8U7iYTCpyTLaJj/cnsLac0fF4uZfA5/B3EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699813378; x=1700418178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzepqfNM84jQYG2oLRhMt8QStTmnEmT4TRvZ89WnWb4=;
 b=DZg/UeAM+N53NZwtEqIs9wf0F7BvSQxnH7ePwzhj2ux7W19nc2LhFNwsAkGt5beSbt
 5I8WyIIY7ATjpKCk2SFNfLXC6Np1m9+lVkmo1Lz2ywgUXKSuSWMpYL4hlDm5aFZhKhQv
 Y/ECi6bQyRqGJJIxArI4BifNOGsj580IALkNodb6HOUHN2XMZL/7XOV6wfB6K2vqD2K+
 r4o22+JjM03Hh+nFXkJADQ4Qn/9ULsKEg8TBAjypTzSRbqxxFQWjlKPpFWdIKdVOdI1s
 UsE4ijHqYDQiJ5tQbTznkd1E505o372S2A2n4JBgps/LyHG8oURLTNb5C901mwjICMxD
 0srA==
X-Gm-Message-State: AOJu0YzaJtqO6sJGOSmpMPenqbeEL6azJ1/148RbPYS0Ion09Gip/XR1
 4y1hsdapb+Lo8Hh3/8RuQljzfA==
X-Google-Smtp-Source: AGHT+IG+hzHEHfVvWm9l7uvkgJ0Ge5JYDHzCL3RJgzB5kJn66XnpmNUVEsxXoXM9UlgFR6PGh0D3bw==
X-Received: by 2002:a05:620a:40c1:b0:779:de1c:e547 with SMTP id
 g1-20020a05620a40c100b00779de1ce547mr5829075qko.3.1699813377766; 
 Sun, 12 Nov 2023 10:22:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8be2-1560-728c-e0db.res6.spectrum.com.
 [2603:6081:7b00:6400:8be2:1560:728c:e0db])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a05620a27ca00b007770673e757sm1294313qkp.94.2023.11.12.10.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 10:22:57 -0800 (PST)
Date: Sun, 12 Nov 2023 13:22:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 1/7] boot: Drop size parameter from image_setup_libfdt()
Message-ID: <20231112182255.GF6601@bill-the-cat>
References: <20231112152754.130399-1-sjg@chromium.org>
 <20231112152754.130399-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cI53KGqLI/CfTei9"
Content-Disposition: inline
In-Reply-To: <20231112152754.130399-2-sjg@chromium.org>
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


--cI53KGqLI/CfTei9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:27:44AM -0700, Simon Glass wrote:

> The of_size parameter is not used, so remove it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cI53KGqLI/CfTei9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVRF/8ACgkQFHw5/5Y0
tyzgTAv/ceFFg6SC4zgz/WZ/K0iHVv54aD+LhobphiFoSt8ZqGPvGAV98JHW4ilB
Olyo1PdNfPUZVXUw8QnOOEoLDAy77Y0ESz/Jmz/qYFITCbA+aG324Zj8DAP5/wpR
8ZEJpuwFhqDnf9Nm8M0vChYLoanfFAARXvFNKKb6T7HdMUiNZo+R2LW5sTDGVE+I
wES+mV++jgvOthFreIC63Svc6fjECGYm3ZoBd3ymkz7lRLyzrXKwjhZMENavMfmX
G9v+ohoFSrflS5av+4pzQjLmzCukJz0AEbt2ojoNQbSeCUT4tTTAmo8yYtxiMbxb
H67sDcCLY3CHNbJY+deMbV2f6aISQBpa4FOw+94XJC53QtU6H+Vdgyynju57DYr5
5KltAtmG81hQcXf0BHa35gjIJeVskD3JPQBGEd0ez5WpKGVUbYrrZjD8teBOYAp5
IR/kCLwm51MNiLCgoRyYbPhQP35Z/hYZbHoaMpkkKrBl0eADAKwoBfk86dno7F6/
RibeTXgC
=kMOR
-----END PGP SIGNATURE-----

--cI53KGqLI/CfTei9--
