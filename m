Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC95C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4AB84A5F;
	Thu,  2 Jul 2026 16:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YtgIOJ5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DC584A5F; Thu,  2 Jul 2026 16:29:46 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22FC84A65
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-446f87b6de1so820621fac.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783002583; x=1783607383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e1Ki/P37oEMNFfstcY8TNv3CWrd43qM/nzlM1VsdIqU=;
 b=YtgIOJ5LE8xbYTsrlG1zMre4I5Xx8FiYJe16cJcPGoR8B/S3ZHylMA01OMBeOcHWuE
 QjDoksNGHaSkf9yAJ4vGB1ngX8s4TTTB6sB4zdHcEFulji0yWB/2iHEwWq+zpfIVk6M4
 BZy1McTn998HN04VK0jV0ekV3H3ikoql8bV80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783002583; x=1783607383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1Ki/P37oEMNFfstcY8TNv3CWrd43qM/nzlM1VsdIqU=;
 b=hW4TgpWesRNjNT/eWAqpeDLek5crdfXbHChdK2uRnxlwz6Fo8AiovRYLI/AnI4RVgb
 U5s27D120t4YRXK1uuxKd5iJ6sQUEQJt+4kvcTCqa8dkFFz5DAJRIZJMjkinrh+0zesv
 U/TIrelenNpkDZBkmMjKJeWBpcQMG0xEBpwXA/LgF4IvhSHdU5LJDeQ4Luve94/ummXH
 RZEsDz5xbrBseoEF5gM8YJFLduuKSCbYGt7lHNoCiEXLDLVP5yQxlKxuWTy33GQw4tTm
 pjIrA5+2WDR08Ud7tJ7N6nD+g1jzTa7zfvIFbzhhfESlDhQflrNgqVTt5+PVeTmzMJHS
 sP2w==
X-Gm-Message-State: AOJu0YwxTcJkBv5LWsAgTf1QZn6EVHWjISd3h2DtXWk16BfSoEoy1fnT
 dWHl19UGx37ktdaMKYodkjdvutaF/b/27n0YFXqLM5hc6TUnPATHP9ZYbN9137x7eX8=
X-Gm-Gg: AfdE7cnj7ZAZToEAjIUlKCz1MdLKtYy2hpSVdBi6LCwNH+4dBS8JZ/Oyo9ETr2aL7vC
 5Rorj+sI0B+4173Q+Tz6D5sjtmjAiml4eF+8Xf+pUO8Dflb/J7+WztLsVTWvSmwlnzwv3klcMDR
 LUMWTuDmvqWVn3lMtJ1GisV063VwB0h8xMqfr+eaEtgkeIzV9ZgObvKN3oYoZZhkUrIlVkfCA1i
 fo3qybBaFKiQbDWrlDsjXLnorHuPHhK631YNNJJIysCW30yw9D3T8I2oYrzkyFeoR2/Bqynr3ip
 MeM7EvcTdwx13v3/4xQHYMvM5HzLTNgab0R+Y/hyMfKb5OnFZDPJseiN1CheobJSBvb27pvS7wo
 4WwMtyc8HQTZk8xigPjTNVZYFSB80uRj93E0qbsJmiQGieV1qA6rey4YzyU9NtOsVxQw3qLxig5
 SsdkewlWPb+Ygd9tfwBvP/C51DatAeRKfJ62KzifoUl38eLIu5QxK4Zf3fMSQB6P5sFC4vGhByU
 8RaUw2N5wq0kddiOxfawzmiA+QGcAdlBbJ0Kg==
X-Received: by 2002:a05:6870:2b08:b0:41c:de1:b21e with SMTP id
 586e51a60fabf-44cab56b8e6mr4225898fac.11.1783002583342; 
 Thu, 02 Jul 2026 07:29:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe8d9c13sm2822572fac.7.2026.07.02.07.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:29:42 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:29:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 2/2] qconfig: Rename the doc link in help text
Message-ID: <20260702142940.GZ749385@bill-the-cat>
References: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
 <20260702-qconfig-check-for-db-v1-2-f0b96bf8fa44@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CrFp9HX+1NB3MMxJ"
Content-Disposition: inline
In-Reply-To: <20260702-qconfig-check-for-db-v1-2-f0b96bf8fa44@baylibre.com>
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


--CrFp9HX+1NB3MMxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 04:04:42PM +0200, Julien Stephan wrote:

> This was missed during the renaming of the tool. Fix it.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Fixes: ea4d6dead372 ("moveconfig: Rename the tool to qconfig")

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CrFp9HX+1NB3MMxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakZ11AAKCRAr4qD1Cr/k
CuZGAP4v6EcSuOw5hNpP8sUWlm7PcCXNP74RqlLSE+8Y1yXRngEA2i413v0QdEHe
zR+1bOjfecFK6i9WPYoaPK42QsFF4wc=
=mPT7
-----END PGP SIGNATURE-----

--CrFp9HX+1NB3MMxJ--
