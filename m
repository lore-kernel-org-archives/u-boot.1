Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D976EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B28587A2A;
	Thu, 14 Dec 2023 15:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V/I6FSq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494B287A71; Thu, 14 Dec 2023 15:27:22 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187D887A42
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5d05ff42db0so82003767b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702564038; x=1703168838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K1rT4X24RxFTVAeVxlohuRYtYsDoo/0UaWUuOpzhbBk=;
 b=V/I6FSq5bwa3uT8wTVV50fUqaRfsXOOq96qvqfo4UWxpcncL/uFrJebNDZ0l6F8W0/
 ZQ+E1EWuh6UvRPtQmYmaZsRvsfdLiWhynanKbhPkMvSg9hwq3GW27EPribGuRAQvQlmn
 Fofs6fWN/LMpm96fJCxpnYywi1lKI9E+L0sgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702564038; x=1703168838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1rT4X24RxFTVAeVxlohuRYtYsDoo/0UaWUuOpzhbBk=;
 b=gAb86yR+q8wFgjoP9m1DZ6LALr7XpRWjvGS6NforNZ8Jqci3BpSkc33Rf0+jHTZaFF
 UfjAK5B0q7GKurk6lD603tWHR46XKYWtExoi3OpGokyECgbuVskACH4yic3lK6GhxNH1
 lIZJ97WiHJzhw8XzHYpytegWrdhH0CnO0chE9+CknS9MKYLLN/mljUpmCKr9PnoB8Wz/
 2rUss+4f7OucyLtN5rZvedg4GHfspTYxqIPb1jWF5OOm1QdWm249oBidtd/3ydswj3YZ
 qnGJRN74shRPR1xUTC6DPMbG4VMor8BnA2cHbr459u5guG3pAzg55CS0iUYJeF9a1GTQ
 3kBw==
X-Gm-Message-State: AOJu0Yx49q1US6tqvH8XE3rI3Nlr8+Ge0Rd8+MhQmFh+ECjhD2Ql05Ku
 z4ER9+HhnoIpDht1DetR1tqAWQ==
X-Google-Smtp-Source: AGHT+IFdGe/aNYSRbcyQON5YvCW/CXqM+sNraLlFKAjTEj+yurI5A5iO+c+KLXW2v3xawcoT5QBHzA==
X-Received: by 2002:a0d:c044:0:b0:5d7:1941:2c34 with SMTP id
 b65-20020a0dc044000000b005d719412c34mr7893253ywd.97.1702564037744; 
 Thu, 14 Dec 2023 06:27:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 n193-20020a0dcbca000000b005e2e8b26925sm1200969ywd.61.2023.12.14.06.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:27:16 -0800 (PST)
Date: Thu, 14 Dec 2023 09:27:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for
 CONFIG checks
Message-ID: <20231214142713.GZ2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bWNVijVtr7SXCNTJ"
Content-Disposition: inline
In-Reply-To: <20231214135103.1606605-2-sumit.garg@linaro.org>
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


--bWNVijVtr7SXCNTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .azure-pipelines.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d6f3fa423c6..f100c4493e6 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -65,7 +65,8 @@ stages:
>        # have no matches.
>        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CON=
FIG_'
>                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasi=
ng/ &&
> +                  exit 1 || exit 0
> =20
>    - job: docs
>      displayName: 'Build documentation'

The GitLab tests needs an equivalent change.

--=20
Tom

--bWNVijVtr7SXCNTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7ELsACgkQFHw5/5Y0
tyy8xAwAkJMrVTvV1C6S5lnwh7Mmpy5A+CwcKAs49b6s2TLAISy2hgCMmzuNxm2c
V34luEX2TYSLP94sa8lvEHUUrr+59FTLa4FXMXQeme+9VfPtpMdVMIhk1uqFGvJG
J0Tpnaxjeh/x3Uu+TXwA/xWvtpQj1OwS39YNzS2DrK4zu1LTxZ/2sLA/siE3gQ75
mWjjgUFupW8t5A1qQOaYHeBhYI4nCwhY3525IIu3hLHpZyIHbsSw8uATR1h2afN1
f/urLS0FzpvN6HX3AZFkwlHHD9doxmPDIvej6HEZSlzk51wbAnxagnNT9mI70b+F
LEbhX5449eC4B+DRSMgfnJRwmZw5fQm2xQEgZPNz4iE/JC02ErXPX6VAmChtMpSH
E1LiFPIS2Tyi/X++Uya+yEioUL5Pe+ozNuOx6bzE2ggph2/nyHNaf3D6A+kQ3PVl
94QHPKsL5CKJQdH0WmzRMNVXWPjzeV+cnalaUX+d5NXjzjPBmLh4mu9pDzNh+AM0
pdf7z7VQ
=4UIP
-----END PGP SIGNATURE-----

--bWNVijVtr7SXCNTJ--
