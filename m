Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4AECF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 17:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A115488EE3;
	Sun, 13 Oct 2024 19:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0g0u604";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DE488EE3; Sun, 13 Oct 2024 19:51:54 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA548898B
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 19:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7afc847094fso290801185a.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728841911; x=1729446711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uoenN7vQWQZYSpbSRYfNhRxGDhzjqbG+6v1FrQw6oRM=;
 b=t0g0u604r0ICTB8y/7giCeM94E2pmlz/jIUPd/ClVDkJnTNxPkXKw9oVD8AsFTY026
 xGmyTIiVY+mH25Qbt+IoJrlU3/EtaBuahnlUY806Hc2RcUkQQIqkjbo4oknyWjPdMH7u
 IqyCj9JZjOan76ZOPA00kPT+XIpWCfzBWm3+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728841911; x=1729446711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoenN7vQWQZYSpbSRYfNhRxGDhzjqbG+6v1FrQw6oRM=;
 b=EFRtIg6M+cZDuMsNEtaVHBFVTfju4Jr/URCFFr3HoFnR8Ij0iRuLZo+kY3QNqBdsD+
 cAS6SLBA1uqIjD5/5aBFRl5UmDJvQFdWcsFnvM62yp28pjoTWqesdWCj9sxk6ka1weAR
 ShVfRrNrJ9wSeW1/5Ex9X3mAPhWo4WVajCEekI0+bHtlQjg3c+BI2V13fJ/1ZTs/SFI/
 jmGWRgN22UxEA6CEGWqu/0bg7LyifYOupVt/j31pDtCM8+yZSWjBiLZ7U3OeYBfE9P2y
 Mi99TJ2U+t91/j1cUP/IHQwSFji/Em6+SUhLKQDoAYC2PtXpoTRAId0z0Wo/9+FUmPzP
 h5hg==
X-Gm-Message-State: AOJu0YxttCPhX1ekeNwHAsEyUXa6YuT+tyu3AaSxxlUsKmjOcVhXfjos
 My5cwoStI9E3rCE6q9Z8TJ3+h1RnFH6hS9oMwuT9xSNuLcIGNDr5tdSG+QyiipE=
X-Google-Smtp-Source: AGHT+IHphtRZs75KNljaqVwLusLmrLb51k9KQfpHlGTaFYiC/kz6z8OP1vsIgHn4qq6o+4BNsA4Zzw==
X-Received: by 2002:a05:620a:2904:b0:79d:69b5:aaf7 with SMTP id
 af79cd13be357-7b11a34b985mr1151103885a.11.1728841911539; 
 Sun, 13 Oct 2024 10:51:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11497d956sm335600785a.124.2024.10.13.10.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 10:51:49 -0700 (PDT)
Date: Sun, 13 Oct 2024 11:51:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 02/15] lmb: add a flag to allow suppressing memory map
 change notification
Message-ID: <20241013175146.GN14210@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sOyOJH+eBctaetHK"
Content-Disposition: inline
In-Reply-To: <20241013105522.391414-3-sughosh.ganu@linaro.org>
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


--sOyOJH+eBctaetHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 04:25:09PM +0530, Sughosh Ganu wrote:

> Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> reserving memory. This will then result in no notification being sent
> from the LMB module for the changes to the LMB's memory map.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Can you please elaborate on what we need this flag for, for example what
the valid situation for it is? We should be updating (or adding comments
such that updates are automatic..) to doc/api/lmb.rst as well. Thanks.

--=20
Tom

--sOyOJH+eBctaetHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMCKoACgkQFHw5/5Y0
tyyrCQv8C59u39Uzf+oBb7cFg1npWJWAJQObksb00aFScfhBnQlpwOVEvGNckElQ
uZDgxDxItgmWSex78zj5J0YUKaSObxzYkG5x5y3Bj95tY1ZqS8l4l0zcZRJWYQ+e
rsDa8A2CJjsoQOM7WmvsworWU7hnlSPbAv0Ekg4iP0N8FGuK9ZFoPni8pupnJMCd
g4riNB1RfL6F26jvbwkEFbTrqevmwi0/NkMqVYE4WWs7jmnd//7Mnz0jlXkU8PIp
r8tVI2aT9SLsN055ERPDLUkTaymxtw0i1PVOE2k8YY7AZsyFu0RXhECB6YDCid6y
EFC4ZSCJUs+7VFQWc84o25sIPZ3+08eDf7hSK6yWafDLFF/CU9ESPLDDHlN2US/N
962lfzcvWtycYb+wO4QHetkNr1yyFeCxViozaRMWMt6R8fxLxVP0KDUwpJGsib4S
TCyakc0MkYcyQX/LhX56xUgJBnRSx/0aew3kh2cQKeNCmx4VZqbPaCH3w4jJOHGY
44IDE3vG
=b0Dc
-----END PGP SIGNATURE-----

--sOyOJH+eBctaetHK--
