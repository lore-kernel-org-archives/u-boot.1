Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754E2C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20E587D2F;
	Wed,  7 Aug 2024 22:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DZ+a+BLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C85088108; Wed,  7 Aug 2024 22:44:07 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B0087A55
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-261e543ef35so196421fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723063443; x=1723668243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZLRiW97ujcJFnX3I6PJNJCQH2cks/nVqUeNEJy4thE=;
 b=DZ+a+BLR0+cOdMhNvbpMotU80U72pd0JjGx6Pww09cpbkFHmuRTVNP8jYyncOQ9Pop
 /0mJMR6Ws3glQ0OcIsR/FA5xVV5UaxxBX170h7b6Svmf777Lv8K0ZfwHT09s2mVZlSzV
 azmozdzWWQnnQtAJgrf0/qCztHlvc9Fpek/zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063443; x=1723668243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZLRiW97ujcJFnX3I6PJNJCQH2cks/nVqUeNEJy4thE=;
 b=QpbNxL90sfEisb1VdAMbJDBMSRDRvK96kA8gXzoxbqto+ZIewqark/Ibdv4VL9Zn1b
 aHQMgvGs5n3j1VC3s8EJC6vG3sCOZyeOpgqHrLQKPwPe5fG09lE1ZWifn1tpUBE2nZv1
 sWL4chw6RwpSzSVlWlUdnTmL6sOsutd/3bQvq4CJa8t5phiktCYIrJ6U2Vmai98qo4cW
 DTPWzK8jgTBv+u61rISPBPKNdAiuT79nWjNFq23ur6/gGhFZCvUFGZHtkTOvXlEtA/uD
 vJcyHITLbjOFvstm/4/DECdmm8521i0dk4sMhWHt7rPl6vXO9pNM/DtQ7t9JuaH9Oh87
 5yxA==
X-Gm-Message-State: AOJu0Yx/Dzzu++Hr55BPqxiFeYsrpSv7R4eYbVOtwXmTGWxVAxiAYpG/
 7O2zglKGHQua5CkxlCK+AQ4ZCLhNUopZdwyB1DzacENCAWbH/IUNQbFyUNxlDQM=
X-Google-Smtp-Source: AGHT+IHUnNuIrq9wGasCLgA3sOSxT2TGeGH6YLP/YpJSl4SG30G5uax0PHoxZmTLKtp5Inmx0DSCGQ==
X-Received: by 2002:a05:6870:f14e:b0:260:fd64:60f2 with SMTP id
 586e51a60fabf-26891aa6250mr23551736fac.8.1723063443501; 
 Wed, 07 Aug 2024 13:44:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dd30sm4943804a34.15.2024.08.07.13.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:44:02 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:44:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
Message-ID: <20240807204400.GJ1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WMkN1U6uefC9TREn"
Content-Disposition: inline
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
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


--WMkN1U6uefC9TREn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>=20
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.=
gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

For v9, I think it would be good to do a CI run with NET_LWIP default
and seeing what fails from that too. There's a few problems still
leading to a lot of failures, in that case. Thanks.

--=20
Tom

--WMkN1U6uefC9TREn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaz3IwACgkQFHw5/5Y0
tyxGbwwAlGS85HMaiA3mTYozdR6TvoaxOUt+yLLQXLyQBBpIiAZYXj4nOerg9Eyj
gajUL0a9u8RKWol/UBjVZTsdMoa2mhJwx+Fwz3TSvUGdXDMUPyGc8jMebVn+eFP/
LwXWWBHYAHeXsGJlLAXl2k+e0UsbgrnoKDDpNod5WkQ2OmiLQzMnBPk3FiZ8xiJ0
tiMmPW83gJFPFflI4ESvmNvhWuVyHSiXHoWtPTNQrecoVCVXarcAMSSajtvy18NS
Ev6op6luAPZWhLe4ilz0+GAdS92pwM7r6RkU8cqBdi3tvqcHf7sF7jK6Kbr9FXo6
VBB4EGqrZzKvbWIeUrie9a9jpdzbahnn+LTEDtgwda+kg3N+vvFjO8qFyzozHZLq
lRmZEkHjJvV1X3MphdAqTD9Sp++IlFm+y8NoSb6ZprW8igPxVInPZ3nICAVpJy0I
TR20qSfSQmiETXi7fJgS4xCAneytMTOnxA8iUfeNZ4fJUcrqwPHo5qOElnbaLLvi
uMgXzXPg
=cdA/
-----END PGP SIGNATURE-----

--WMkN1U6uefC9TREn--
