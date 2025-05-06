Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5960C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577D082153;
	Tue,  6 May 2025 18:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FO/gogTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55AC82162; Tue,  6 May 2025 18:49:36 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C96EF81FAB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c09f8369cso1940183a34.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746550173; x=1747154973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wqGfO+Ssd5tnIPu21HHjKNCVKaUPNeFh+Fhd7yYuCZ8=;
 b=FO/gogTH+yLhfx2pniK6JBZ2EwU5THz8hmzrv7SiHDJ6ED0Kiz6rWvwLmtuBnM5Dcv
 Ik9WwBeiHgxdPzLgHU3Hu3qkk4OXzFn7rQHUmmiu7BhonfoAlaYauwtoiif6f/TiX5tW
 1TdMlDVwh1XIPd74G9goifkgicrejDDfxIw5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746550173; x=1747154973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqGfO+Ssd5tnIPu21HHjKNCVKaUPNeFh+Fhd7yYuCZ8=;
 b=e8TqD92n1g/dKqEfcuwvXWlby7c2QqELXEbgI/kSx1aMxUpeXQzcFjwXpWe0P7/E6A
 YHJF9EpT12rNGFVfaJtA9LLvCn8J8RmxJ65dBkzLr59n16GaxfbqJrY2TQzjqZZNsrv4
 KWS6oXgLOxW6mmP8Mu6D+qSoG62kR6krPTuGsvEfeyTMs20/KTQoY1Y71Y5GC5sSzzDV
 ky34oFB+ti+D/vZtGwiwAwfQMrOrysqZgX1diwa5lOyI0hJdvxt+QFPTD2yY908PnmQF
 W03RHyiCHxcqga+xlBuL9b6zNLgkwdlnlKyt3H+KLyG2D0DKQXZGT/PLHO6ngds+Teta
 NzvA==
X-Gm-Message-State: AOJu0YzzfYl8chCmZy1dQKljlgQkkVRkKZEiR/EE1AfsFMsy+6Pp/qyu
 wf6C8GcaWiRH/o7LlXz4gjzdqjvQbkLQisyyKv/6Mf/QZBEqUDdl96+eXpABLHKlMEKJH81Tu6P
 Y
X-Gm-Gg: ASbGnctoiMfGsy9XN5gToWa45Yd3jSrWLuuOYXPVWZKp324CaiRiVo620UhH6FKOc4T
 RqgBiNdlqB9hNJ2ElSoXAQAJTz8zM91++WeMbE1Ywz8a5+w+pGmhGt7dffrhQkZ/bSgMRflL0tI
 75HAGAQgJfP1v4calbrK7yqjFb+CvT6H9Y7AUiR3TV5vmJSJW8na2Qqk3d0zhJqejc8egx6LN3U
 +Pi+veLVyF07MtpPwQNpC2N4YmJQ+kBidvGHXhh82ruP/09jWxM4wRjL1ZCr8SXGe0QTmyEV2TY
 EusefMIK6grTTtDCGE2qeOaKDm+eE5EFf9j/SvzB19DUcacdqTk0OCtrMOW8uvXWUszKecZBPVZ
 GYQ==
X-Google-Smtp-Source: AGHT+IEldTDqypFVG7DgQPmALaIye75My/1aopU2Xc1MRs28UpdPcmCsPdDzIosNxSMlysZybLm4uw==
X-Received: by 2002:a05:6870:f21a:b0:2d8:957a:5178 with SMTP id
 586e51a60fabf-2db3cdf5603mr2063973fac.21.1746550173557; 
 Tue, 06 May 2025 09:49:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f8bcfasm2785352fac.28.2025.05.06.09.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:49:33 -0700 (PDT)
Date: Tue, 6 May 2025 10:49:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] cmd: test: add support for =~ operator
Message-ID: <20250506164931.GA5430@bill-the-cat>
References: <20250506141035.385756-1-ravi@prevas.dk>
 <20250506141035.385756-2-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rg5GAL2BgdyM24OT"
Content-Disposition: inline
In-Reply-To: <20250506141035.385756-2-ravi@prevas.dk>
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


--rg5GAL2BgdyM24OT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 04:10:25PM +0200, Rasmus Villemoes wrote:

> Currently, the only way to make use of regex matching in the shell is
> by using "setexpr [g]sub" command. That's rather awkward for asking
> whether a string matches a regex. At the very least, it requires
> providing setexpr with a dummy target variable, but also, the return
> value of setexpr doesn't say whether any substitutions were done, so
> one would have to do some roundabout thing like
>=20
>   env set dummy "${string_to_test}"
>   setexpr sub dummy '<some regex>' ''
>   if test "${dummy}" !=3D "${string_to_test}" ; then ...
>=20
> When CONFIG_REGEX is set, teach the test command a new operator, =3D~,
> which will allow one to more naturally write
>=20
>   if test "${string_to_test}" =3D~ '<some regex>' ; then ...
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

We should also mention here (and then in docs) that this the same as the
=3D~ operator in bash, which I only learned about now as part of answering
my own question of "Are people going to expect =3D~ to do something
else?".

With that,

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rg5GAL2BgdyM24OT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaPZsACgkQFHw5/5Y0
tyzjUQv9H/pFJMtVjNWhVhthqsCYwS/TbLugIEahcQlTOxhNgV8AYeBmqfC8XeL2
M+rgRUQMgaUPZ14kWmj9EyyJdOeJovUpNFCTgyixQp+sYTY6n5niHCb7vN4S0NQK
oyr9MfwseDjW47YsaP4fwWClxeAgz+wYurvS2YaYL4EvWDcmis9NdvzBtpaGJUJk
DcNv45Vw2dT1bnu/8Y0JgFldIAjmFfJVMrPibUxyJq5AARrI5RLyMhOSpYQpdRxM
MuvfOz86nxzPP+cY/ZJGIB7qFHKV3XydeJbK6ntUJTAaesHqEpZ3eHDtuUpMEleS
dRgO8t4PkE1MegWpLhnF4P/lguIqkUq6+H9sCvCek3hiSgcMxvpr1ljJXllcNnR6
cJJdVSIb8D3+rp9mUIYCpoPSWShOxP4D//J5wKf6Er6X9sIgPyTUeLbaaZ0ORwFS
ns205hYqqBvUVq2NQdNbQa931xuFgT/YKbjhxEqgmO6bC3V+lbyr3FUM3LP9xgVQ
VG+el7YN
=Vl2k
-----END PGP SIGNATURE-----

--rg5GAL2BgdyM24OT--
