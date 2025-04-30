Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA228C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C1B8210F;
	Wed, 30 Apr 2025 16:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzINBMoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C90C82B45; Wed, 30 Apr 2025 16:36:18 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1668210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c0b4a038fso4838223a34.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746023775; x=1746628575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ybq7dNTwICRz319m6N9i+nMkKti0iVRXZQo44fZEDx4=;
 b=XzINBMohT9ht1anjLeVgj/UYjru76CNxaASmm1TD6MbTA4Lh7Vdnwxb7P80hStACJ7
 EI8nMORi7r3SmdXjFWX/Qxgopi5p/98RU65ea4hstNbZ7YPZ621OtciP2AWSAbf/QXYb
 75MHzU82ipYISTyvJzmTMJB7mbRhOzMD8z/v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023775; x=1746628575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ybq7dNTwICRz319m6N9i+nMkKti0iVRXZQo44fZEDx4=;
 b=GB4yaH97AQhBJ5A/o61h2xjDSIcx0xboBM6v7WkufpR8BnIPT5MAzWlGyzmSEXpuhw
 MQlt2Dacn/FaMJKAUgTCO1fSlLxh7r3sjCpg33kcf1dGzt4BsAx2S/xxH94MGfT/tIJo
 x4Iod46rDIuUJi7Pl2fT+X2/uDnm/IJsEC/IT2L5paZJUVCA2obf8cFegEwEbcu0D2Lr
 8+bDwgBwy59sa0JSDSGxVd7QMU3xfczbWIZqCnOE2OdVubewSo3DBvz8ECBsWcwg87re
 Ee95KIruk4p++2ljA9VjzLgPI4tQlCYz7YeS2NMWSMH/WbMUNJ95Bmuz9N0VJvf7qnfC
 /bxA==
X-Gm-Message-State: AOJu0YwpUyfo/eZ8+CVFnPdUbG1RnxRa79OrLxzf6IMVRdcsNNN/Is+F
 uyNvJx4dRmJWLOcqCFWuAdhBSDbSKhN5XULRiN6M7RoYw7DteEcL+sy2wLA4LqE=
X-Gm-Gg: ASbGncvHzAN9d92+Lrsf7FBt9n3WwI7rTLyCMqjLK+67ob/4E0mJ0xnU21vaUzHAz6B
 sXem/p2NuPIAjF7a5ydhmUkqhbPzaoMCsjbuj3oubNuyjnVghPOmvJ7P74y71tfN0+3dPAagS1w
 bwbiB6rFuXTwARCyuno1OAgZ9RNPZJvoNx5RIaQxJoDfsjKDLnq9vUOPHQtLsn3XHaiuSvE36Fh
 Me1f0mxMnapAMJktW/chKucTaHsAjadYbjKk+f6eFBOzY6NRsQnOX9n4DQkbjDQb4skxC/9TriX
 0qzPPPhXms34rR+onKmZqdtQHqhTj/s5okqCJPifY0SSFWMSVOvIt6fu6Cd5V8zzeOT/Py0iyt9
 CsQ==
X-Google-Smtp-Source: AGHT+IG7h/27FLpD2jDYt+sYrrVNqwSP91l+sfx0UEsftGv8IvKHbYglv5mNGI7OJsV6ZnlMl5dUyQ==
X-Received: by 2002:a05:6830:641a:b0:72b:81a8:dea5 with SMTP id
 46e09a7af769-731c0a7cd52mr2293349a34.17.1746023774827; 
 Wed, 30 Apr 2025 07:36:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b2ef3f3sm888256a34.54.2025.04.30.07.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:36:14 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:36:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: Re: [PATCH v2 1/1] bootm: improve error message when gzip
 decompression buffer is too small
Message-ID: <20250430143611.GR1261075@bill-the-cat>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250430022325.156922-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZdmFtpFB4ZT7GExU"
Content-Disposition: inline
In-Reply-To: <20250430022325.156922-1-aristo.chen@canonical.com>
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


--ZdmFtpFB4ZT7GExU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:23:25AM +0800, Aristo Chen wrote:

> Currently, when decompressing a gzip-compressed image during bootm, a
> generic error such as "inflate() returned -5" is shown when the buffer is
> too small. However, it is not immediately clear that this is caused by
> CONFIG_SYS_BOOTM_LEN being too small.
>=20
> This patch improves error handling by:
> - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> - Preserving the original return code from zunzip() instead of overwriting
>   it with -1
>=20
> By providing clearer hints when decompression fails due to insufficient
> buffer size, this change helps users diagnose and fix boot failures more
> easily.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZdmFtpFB4ZT7GExU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSNVsACgkQFHw5/5Y0
tyxcVgv1F2AHebfemivrRa1j4aaL5KOaoo2gM9W71Bs6G1paCxQCuBuByzT3Cckq
j2KO9KSOv/T7NahUQmVvhjG4+LM1MBhEQv2TgnGRQJ1uC5Z2c+U8lwwPSKimZ+36
/zK33ypw3BWknsr/gyXjVcI3oeWRc/dKLfi9Qfwr+2ab6Z7ay9tDmRdkD3uXKFlw
YNLikcmkdEk81n9ATPhjRJWq/CqKbZqIXsIKXeOgSCtQF5eXzNYJ/eMsGt+CD5PP
yrs/TBlZlyT32JoPssX1/H+t/dSLynE2AVDYSKVMD+EioPr1Qm9Wd9mlUEDg3xYa
Yj6nzERLrKHWS0R7hxe86NM5GZO13eP4FFV1ZdfGZZhynPFCh3MpkHJB8x5DSfse
46blbjJVnYPWv1RwGkTM3kuOcimiv3JICpCSKCqaZhUoFyC7H4tREC6y8AJ7Ku/o
ntI9xvq2iSetdwTcvgy+kJ6Y163DXy5956T+yYv98IOesHBcJ6OR8+B4NRsvS8gZ
wpqeDm4=
=teFs
-----END PGP SIGNATURE-----

--ZdmFtpFB4ZT7GExU--
