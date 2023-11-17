Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C574DC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4B7871B4;
	Fri, 17 Nov 2023 14:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IBmBa6HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE54E86FB8; Fri, 17 Nov 2023 14:42:14 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D41C8743F
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66d190a8f87so10205966d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228514; x=1700833314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4cyLOnYA2G76cwMLrjgT9hkyBtOpTEZolDnKad42Wh4=;
 b=IBmBa6HAYIaz/6VES7idj1bGVR6xfadEiHPzlfCNzO6BNSiHT2VWonMUOexe/SdTXl
 You+eu0yqYyRL5vlb6FVTMGeAeO8QvTyX+85L9KOUqtMSQtc0iwQud0l3gqFvFPWWX+D
 s8MDwU4FJasv9w69QIFjCWVoPghBpw6guiHvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228514; x=1700833314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cyLOnYA2G76cwMLrjgT9hkyBtOpTEZolDnKad42Wh4=;
 b=xH0E5g0JQb9W7Y4L6SBPi6CfSeBD0I8zBDJ9YIOsmHh/mTpuvDQtRVyose2Ez0elEh
 9Kgmt5yUSRMoqM8UgFAsZEVyHo8hQtPScwr+adC+J+p3dJt6TPx9cU2WoEMSPEHDxIFc
 T+NZYQGCn6OyUnBkOacYXuwTJgMAX54xDvSv8XO/pkGbEaoSfKcKvhbxLZKqr7YWDn6N
 tit1v+91eOgp1CeGL0qEAsgoT0Ph9AAH0ZUz8tz6pZsdX38cWjdsy4SmZIwoIMPRIrul
 Knp8+IK79+52d7S+Ts+KJF4uyibM1E2oE0dsDodD7uMdxMi8LLryufmmtWfIr2iZKjEt
 3HUQ==
X-Gm-Message-State: AOJu0YwFxQuaqQZl2GWhyWbKmUTBRqdfeaQr1BN3rm0/orz/yIXqCo6U
 u5TPZWWf+hiv0gCft3yz9f6d//1dFWEA9zpym/4Xww==
X-Google-Smtp-Source: AGHT+IFlpq4RsFsVmLGGPQ9P3AuDFb/y5lKUCcScRedw1CwFYv76JvQB1KcBc2onGRDNGNYNmkNN6g==
X-Received: by 2002:a05:6214:10c8:b0:65b:2ad1:14f8 with SMTP id
 r8-20020a05621410c800b0065b2ad114f8mr10798588qvs.42.1700228514105; 
 Fri, 17 Nov 2023 05:41:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0066d132b1c8bsm625076qvs.102.2023.11.17.05.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:53 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH v3 1/2] dm: core: Correct reference to DM_SPL in
 SPL_DM_STATS
Message-ID: <20231117134152.GS170968@bill-the-cat>
References: <20231112200349.172779-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sVrwQQ4VRWRabgm0"
Content-Disposition: inline
In-Reply-To: <20231112200349.172779-1-sjg@chromium.org>
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


--sVrwQQ4VRWRabgm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 01:03:46PM -0700, Simon Glass wrote:

> This does not existing anymore. Update SPL_DM_STATS to use the correct
> Kconfig option, which is SPL_DM
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--sVrwQQ4VRWRabgm0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbZ8ACgkQFHw5/5Y0
tyzSgAwAt1uY1hmO8VRkIk5HEeFbzzTz+pRNS+rIKjxo0VdbE95FHusjh+AEVNiK
PPUjsDiHPfyAdr/wciOGW+9AUkdz2qRdL05Rfqjb0BN4pfCe+ucZDaZRjrpKV+24
kbRWCeCDZ42IcJnhrm+ar+oybyXtpXZOASBovoTlJmb5w5ws9dBB44x6Wjwj2zue
EZF8t3ufrpg4lpGyfeBCCmhvadkvvnAuQqlNeZYPfVU0sbOpsjyxxPnmn5WyfCxh
uGaceLiyxXM8fbymO9ZrpuF2IuH8oR3BLUv7PN9PAkFGjtIP3y85PNUSIWHEox2m
YfUUksgXBT67bEtYUHK2juDMgr/yInDxpjvnCN/U+K4R6zk1IQfJ6xBxPwIgiZMM
HrNok1u58EC947kP19m8hbbHtFoOOOYO7KZVjlrhFrxCt4mb0CTA5qOQLiFo8jRF
0X9IRf28bP/OOwuz6dgvNUkf4PrNcGd7+mBtNffmH8GJt0pwDZHI+s+g4kL/8+rF
o7tEa2TL
=Fmht
-----END PGP SIGNATURE-----

--sVrwQQ4VRWRabgm0--
