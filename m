Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6301CC2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1950487285;
	Wed, 15 Nov 2023 23:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0U05w5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916CD869F7; Wed, 15 Nov 2023 23:36:45 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B018727A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-779fb118fe4so6354985a.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087802; x=1700692602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rPB6rrnzOyOZC4ik+CSIHk4v9ZhwYFje8/0ojYeOiaM=;
 b=e0U05w5nw830XaZeTAUmzr9tS1i7XIWFXjwUDJ5zzHYZpwFZk5pqG7H4qGCfaXRFvS
 xi3lX5uz0iP8bUCzIkZz+KNBkuN4SR8WM1Qsgd7jMgvLLCAimdtUSrFdoE9kVpEIAgUT
 Jmv7xqCAOo5ersYd9AjyF4k5fYLIYZRR2IErA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087802; x=1700692602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPB6rrnzOyOZC4ik+CSIHk4v9ZhwYFje8/0ojYeOiaM=;
 b=dRyAwLEjJycQNnRzWa+F2m3c39HOWEButTAG/RvtKK8sUsO8mhcdbBlIzBrxmVlRTC
 wT1ETB9QyrG4EOycfaUxrDaoL+7kZ0+Wv4S005fe7eE7lV5WY36afm8Rg3btCYvBMzzQ
 X9Zcf5XxFz/K/FbemqIdvw8YCxbXFh8JJQD2OSvv7wycaTYp8vO7MhxUfjh2JhIomUyZ
 CcVGd8ZDSD1+u+wBvUqSWx2a3uITRAV2WK0Tu6aAqetjS+xqzF8PN60jg2ylH06ZARRZ
 L+ZtJOE2mlt17eudvcAReWFY/01d6OdIZ4hUy+r5bJyE4dW8/cTRCLTrbYusgNagDRgA
 7H9g==
X-Gm-Message-State: AOJu0Ywu+uMOcx2Nf9NFIAV6MFaT47ga+Z0gK57Ahsd82cz4QvuMC2iH
 oyMVy1bGbsrw4vAPq30izO7ewQ==
X-Google-Smtp-Source: AGHT+IFc/CMLR+ffP+6ftZI6Tj65Rdu20e9ugojPehrBegJG1Sv+3a97BK1mZs1kGbmSd/F1RMWN3w==
X-Received: by 2002:a05:620a:2801:b0:77b:d668:dfce with SMTP id
 f1-20020a05620a280100b0077bd668dfcemr8266197qkp.16.1700087802347; 
 Wed, 15 Nov 2023 14:36:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a05620a271700b007759a81d88esm3783366qkp.50.2023.11.15.14.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:41 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 10/29] bootm: Reduce arguments to boot_get_kernel()
Message-ID: <20231115223639.GR6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hT3/YEAzhfgdkf6C"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-11-sjg@chromium.org>
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


--hT3/YEAzhfgdkf6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:55PM -0700, Simon Glass wrote:

> This function only uses one argument and just needs to know the name of
> the command which called it. Adjust the function to use only what it
> needs. This will make it easier to call from a non-command context.
>=20
> Tidy up the function comment while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -312,8 +316,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  	int ret;
> =20
>  	/* get kernel image header, start address and length */
> -	os_hdr =3D boot_get_kernel(cmdtp, flag, argc, argv,
> -			&images, &images.os.image_start, &images.os.image_len);
> +	os_hdr =3D boot_get_kernel("bootm", argv[0], &images,
> +				 &images.os.image_start, &images.os.image_len);

Shouldn't this be cmdtp->name not "bootm" ? The eventual use case is
reporting back to the user that what they tried to use with
bootm/booti/bootz isn't a match.

--=20
Tom

--hT3/YEAzhfgdkf6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR/cACgkQFHw5/5Y0
tyzAxQv9EJ4jdq16lH2DlIrAW9OhKj/oHYtvepKKweTId3ZheBFQ3aBsgf/DF9Lt
fvBRKFSXIEycJrie86rgfJjyX5t4tGxVLX8bfDGCf+eHyPfkPzUwmgna9mE84NGs
gOYVppgJ6YPEOKTM/aGFSu3Sw3zFaS1ThcBMB4ZwlM0wUuBSYk4+B1ck7eN/MAAx
iJFf+LLUX/xO0K7u/DthlKjjRMtjIa1LOmKzxI628csI/Jby+bn4C+JA5j8bnxQ4
w2+qBdb4PE6moD38mo2NUgVh9JUTeEvke35fQwPoQ7+AgKv101pknZLJIkOKJ7V3
mBPhBL7SWczxO+au/z89LkZuqh6VzXky3IR5s6GOPtFoFJCDIQXsafvy6CxhoDCt
9DW89UX3lKmOkw1URdOK9n2mCMbo/69WEq1zGMaveeNxAmxSxqQaphe37rK5GYoo
G/eUrzmuyXINxiscOxFv0BWU27xvw9uwd1znmq0lWG3tfLN/2Z3Gu/a0vTAcnMwe
/ur4haEa
=cwRo
-----END PGP SIGNATURE-----

--hT3/YEAzhfgdkf6C--
