Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB2CD343D
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 14:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81FC88B4B;
	Tue,  3 Sep 2024 16:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkENEGuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D35887B9; Tue,  3 Sep 2024 16:56:11 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA84788B4B
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 16:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a80511d206so256986385a.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725375368; x=1725980168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GThZmA5pEJYFRjpoGeu6c0LmEXCijmLoFi4ePIVMt8g=;
 b=kkENEGuKz22vIsnTXWHVA/076AdUGyPdXre4HYs/uWQLOeyUl7Ej4S9Gcekpp8dpye
 smah2itxsX+vjIXo2TebRS3O9ymoe0jS8gRS47nUgTTJlVeaOtuvCjQ7QKIHCN9rT2FJ
 Ssh84nQzstzENbB/fgL5rtYe7e2Nt9W9SEjV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375368; x=1725980168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GThZmA5pEJYFRjpoGeu6c0LmEXCijmLoFi4ePIVMt8g=;
 b=jjpRRx/HvvbrkF0f6cFWXFV/+tNx1iQ3qNvDuSObMV57w/v90OS90TgOIozUf++R/0
 XYlAV1LTSxaTjsedFyYvNS3A0zFpmFEjBZh47ZNRQ8ZazZD8DJJ2Zc/By4I0NY+5yotm
 peM4tyK/iN6lFno5WhzAvl3bRZkJB9mbY6lnJFFifZzTrP889Gu9NpJL/MjODwt+I2tw
 MGr7AR1QNF07JkHae9seHeqMaGAUrrVgx+7fDn+VZ9ZOIylVK7yO/zNjQIJBGxz110In
 JSmXNmbggwrv45LJ9cyHuPrf96wq8TMF15iPpS9BNPc00D8S2iwi5v4Vul61fwcQPrj6
 5qyw==
X-Gm-Message-State: AOJu0YxADIwbEmSQtXP/pxiipvNGKdWEvvrfnMC2WLRhTo7UaQq/z2AD
 kl7ShdVgkPMPRTy/TQfpi5t6RoiwktM6gRo+38epzrQASdkhM0msHw76k7W6piI=
X-Google-Smtp-Source: AGHT+IGWjxfb3SkUpLyqSwU7l9eeczXDgWGFymNdXewwaHsnLfdz2MlHDkzFujkJRglX7A167iJHeg==
X-Received: by 2002:a05:620a:29c5:b0:7a2:ce2:55d4 with SMTP id
 af79cd13be357-7a8a3e3370emr1255848985a.17.1725375367537; 
 Tue, 03 Sep 2024 07:56:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806bfb8f5sm532947085a.12.2024.09.03.07.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 07:56:06 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:56:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [GIT PULL] usb hub changes for 2025.01 next
Message-ID: <20240903145602.GG2479150@bill-the-cat>
References: <cbf15d99-3869-4e14-813f-318ddfda9df0@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HJ76cyYI6nOkCCY4"
Content-Disposition: inline
In-Reply-To: <cbf15d99-3869-4e14-813f-318ddfda9df0@amd.com>
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


--HJ76cyYI6nOkCCY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 11:53:46AM +0200, Michal Simek wrote:

> Hi,
>=20
> please pull these changes to your next branch. Changes have been sent for=
 a
> while and there was no reply to them.
> Here is the thread.
> https://lore.kernel.org/all/20240605100221.3571-1-venkatesh.abbarapu@amd.=
com/
>=20
> We are doing the same changes on Linux side and they should be merged soon
> https://lore.kernel.org/all/1725192519-3867920-1-git-send-email-radhey.sh=
yam.pandey@amd.com
>=20
> I also queue them to gitlab CI and can't see any issue.

I see that Marek has now had time to review the patches and so I'm not
going to take this PR as there's been changes requested.

--=20
Tom

--HJ76cyYI6nOkCCY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXI38ACgkQFHw5/5Y0
tywM1Av/fDfbuvOV9R1lMnLslcb9GZvWRkBpGMSU8M7sg4ZvpWuL/cbV+/BehELC
XYGVdOKfroqKKvvarB4XAvgg9yJZQfFRBq82ffDw7/r8CcTFhu+O422Lq/q/ju9f
WJiWCCy4kWMYF57zjKVAxrWxuZy9mbc33yk+HZvpHCr1xxxUhzO9FB5+8xGnp8Qz
Zh6/V63qFq4tbyvUIXz4fNBgwE9S5MGkApYPkq9uFy/v0ut7kPfUu2BnFFyTZBEb
C63dYL9mYbj1eIBylhytl7BqSzmlCh5H8KZs/kgBZJ90JgMWSONhkinO+b6WqN4v
HrAIz421eHIkEoipPBdjcYhmjLwxCwuTPt0Enh+LafmpNQ6wZa4P7qSennvXdl6K
CNTAoWuPwFR/+6JteVH3LkQ3uTX3evQCyGawNBYyiOjgGoM8OvQz2Vcp82PIuThb
/3Q/ON9YNE17PCPDgv7/CPWdaVyEkxt3dgO8hJvU/pe20m2/2eqQLWmyXuVJzCpE
V476/kz/
=5zFM
-----END PGP SIGNATURE-----

--HJ76cyYI6nOkCCY4--
