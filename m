Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05517C4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CFC87D02;
	Tue, 31 Oct 2023 18:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uVKCdfoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D6587CE3; Tue, 31 Oct 2023 18:46:10 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E823F87CF5
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cd97d7272so39539771cf.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774367; x=1699379167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P16yFjKm94ga8xrrAc9ZuAa3Z4Pw74ja4Q8LnWgIvLw=;
 b=uVKCdfoK6FUe5VGug3RM6av/pJok2TQCxeKHy0ozgzS+3mKBA1IvYyNTyW3YVn3wxl
 TPxn1fQuad1JQeIZGWuD364FHRYQl1jFx7bMtBQVpj4V5HwrMQZZW9PoPkf0fSFD3gV9
 pXzvAS1UVlUiCNFiFxxa8nxFu1JroGKGujKZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774367; x=1699379167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P16yFjKm94ga8xrrAc9ZuAa3Z4Pw74ja4Q8LnWgIvLw=;
 b=Tnztka+2y40nxXw305EXAxVFqCvQq4AKKxtqN+QCa/l4+3UqrfANsGDf9wHH8MWb7l
 zjSKZYP1guia5INSlragVXQhUFo8ZNt5D3jyPC5SyVlgfptqOZXETi77OXcpOn7x3rov
 Ahmd4Hz0BgKddOnMWDJdJyDgpT3Wks3f57U1XXVPIQnml6VRsZ9nLLfQ1aBzOaM7Zo6E
 jBAP/TyX0ObLA4xpmshi4oG0TLFcRG4LAupelH1TVRwXLTba2zgpuKRnQaQINJV+cWPO
 Olne0uinG6091Ph2/lLb/+V128yUy/aBI6o2koP3Efp0JmZ2rAIBeKVmMfjlZqfew4Ck
 cGdA==
X-Gm-Message-State: AOJu0YwbCnvUBt66SUfaod2ua7etu0qCgKi13jq/1crO4lBo+DDxXN23
 gZf1Ez6e3rV6w9Ogf+C2IAfSwA==
X-Google-Smtp-Source: AGHT+IEAezUsbgZjG7tlAb1pyOYCC8MqB4gjRKIRJmFmaFO6N7NapvXsU+TcbGJoJctJHAUU7Irieg==
X-Received: by 2002:a05:622a:4d3:b0:41c:e9b9:5e10 with SMTP id
 q19-20020a05622a04d300b0041ce9b95e10mr15772739qtx.35.1698774366725; 
 Tue, 31 Oct 2023 10:46:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 gx5-20020a05622a27c500b0041ce9ebaad2sm687659qtb.43.2023.10.31.10.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:06 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org,
 ryosuke.saito@linaro.org, sugimoto.yoshio@socionext.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 1/3] board: developerbox: remove obsolete NOR flash
 layout definition
Message-ID: <20231031174604.GT496310@bill-the-cat>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-2-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TcsRkjGY5/eXIAfF"
Content-Disposition: inline
In-Reply-To: <20231025065103.3101666-2-masahisa.kojima@linaro.org>
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


--TcsRkjGY5/eXIAfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:51:01PM +0900, Masahisa Kojima wrote:

> There are two kinds of NOR flash layout for the Developerbox.
> Capsule update for the old layout is no longer available since
> it has small capacity for secure world images and can not
> house the TA such as fTPM.
> This commit removes the definition related to the obsolete
> NOR flash layout for the UEFI capsule update.
>=20
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--TcsRkjGY5/eXIAfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPVwACgkQFHw5/5Y0
tyxifAv/R/K1R8TDzU4zOlfiBsJD3xlbN2UCQI9O2rfkoR+3k3m9yj+GFAOZUY/o
kQxBNJ9jtxmOtCrWyeBZy+Dc7j+vR/gJLHkpexCPsrcspa24BQRZrfWM9/kOJA2W
sbk0zzNZAAEpwuYY78agFoppAEZD35I3nsW5/64tgHxf/O3fykYnGA4/O+uHa3Gp
FbYbZDmLkAvhGprvbvsCQdbu9ViCQ4EIqX0+LA8iVpN/DZdjuTwkLPtFTSRzbUg+
D2nF6cuxsaypRVSA3qGxOvl54Xu9VBTWsh4NJPOQYS7V0/rn/SQ/Ac53fQ0CmIS4
qaP6JLTU97XN1ZinT6JHf0RN3r+m9o0rqVN9kDDG6JwwYeDg5uW85Lrl+Fp3n2NB
kmeynVCymuMQoxLm3YOu6WmmKSvp66uITOoDwyWYpqHKAbpMLLdvnJsQGrnctyJG
Yc62mu1puhWBId3Wmgf/85cDohQDfY6gGNXbmQE81nuZM1ADFrIX3aw45ne1Qak6
VzituNUl
=58Cc
-----END PGP SIGNATURE-----

--TcsRkjGY5/eXIAfF--
