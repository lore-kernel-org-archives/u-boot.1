Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5853CEE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 20:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A5E870BF;
	Mon, 21 Aug 2023 22:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ll/MMeo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AD3870BF; Mon, 21 Aug 2023 22:18:09 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C38487110
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 22:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d63c0a6568fso3945406276.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692649085; x=1693253885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DnvmlYUNNUUpUfcxAQKHRoSW2aQauayFD+gPWDBg1ZI=;
 b=ll/MMeo4uzg7qUIvkVA+IvmvQF9dcaCVxvhuxsv2FJdREWqBssqCSxMAXsA1uxmjij
 TKbVfQp7kNPMvPd1RaCvAvd+e92oXP1KVDswr9XQEgJo3UBed1DCAR/CUh3jkRDewsG4
 vtlnyANLBtvBRQeO+lOLKM9Gb+1fiW8oh2SaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692649085; x=1693253885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnvmlYUNNUUpUfcxAQKHRoSW2aQauayFD+gPWDBg1ZI=;
 b=bREQf3iIWGg/XM1XUNPuXwaRse+sH++XHvhHLB75vCDxMMk/QfwuWGTVU6ckbbTVlI
 5YnhnIsLiSk8knCxnlOMo/9MDJlRsA+nzn9diRGNegH2XyO4hHWnQVEviJUeDpD0Ptwh
 tvrTiZ8IxfLZodZVRb9gvvXvjIBX2vR5s9QVwCDs8fLskVraZzQ42KZOlC4jv6nHe7PO
 jh67XN2ebzxqIrhSbBUrugKxTvS+6g04kIa5Sb4+DZt0J00+BsgQrAdlzRl20C0NPlkN
 A82mYDEM/79YRrbM8k5/T8Tr02jYT+Svesh+EE7snysnZCmbxkKP7GJy5ugpCzvuihXL
 PmPw==
X-Gm-Message-State: AOJu0YzZdRIBegf3MjNxVX6G3Kg7joDEMbhhiPLa0fINkRtCsXwYSwqE
 zD65Wl6XFagocAcBWJ2gRhUycg==
X-Google-Smtp-Source: AGHT+IF4emoPmUmXSuPSjnDPx0cKt99ag0lOBNLayl73fNuCDI2tQpwhCsDK3al0G+fiOLXExhM8Sg==
X-Received: by 2002:a25:bcc7:0:b0:d06:f0ab:e17b with SMTP id
 l7-20020a25bcc7000000b00d06f0abe17bmr7807841ybm.55.1692649084869; 
 Mon, 21 Aug 2023 13:18:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a056902000600b00d677aec54ffsm1921544ybh.60.2023.08.21.13.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 13:18:04 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:18:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20230821201802.GI3953269@bill-the-cat>
References: <CAPnjgZ3SvbMcbPWijcy3JCyh=Cp6X7MMC8vT2Ojk-miFa470GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hkXsJpCsjmaV1HwA"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3SvbMcbPWijcy3JCyh=Cp6X7MMC8vT2Ojk-miFa470GA@mail.gmail.com>
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


--hkXsJpCsjmaV1HwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 01:11:38PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17449
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D47&view=
=3Dresults
>=20
>=20
> The following changes since commit 17aad803551500e1a3d87339a6559e99b7fad4=
79:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2023-08-20
> 11:09:11 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-20aug23
>=20
> for you to fetch changes up to 25a9be71ec1ca779aac8bcb1d8a363725ff0ac7f:
>=20
>   test: cpu: Handle both 32bit and 64bit CPUs (2023-08-20 15:55:27 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hkXsJpCsjmaV1HwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTjxm8ACgkQFHw5/5Y0
tywOEwwAqaSqh76mrxanmkrlg5dl8U61b2g/5rwnKQTOOX5u8o0K5aXD/Yl3NUro
6NYd6x3KxTyl/snOPxB7sPXNi/ykO58xLwuF2JTXchbG4Kwf2E3hRh8NXfBT7suD
Z6b56jeDViOTJ5VkZpF7pU3eLTXdJQv3kGVoul1yqwmhJ6j/vuogZGIDbgVbKNcE
Tz/0AdL5pe3Pd1igYeLMrlku9eJftsdX+aWi+Y5LOLCpffyexL+P9V6rbtuqcgHH
bhrgzYu2m/KTQkuwlZ/JE+lDwE7guyJEPJbC9+82bx99tJTSCmrmg+tjvNBSH70F
6Sq0eCnHW647V7zkWiU9BwMjN+8oC8LdWhuXb7cYFURWXXQQkG9fKOTdliN/qOvO
6wErRz2XepEiaX7YWH1RxrVE3/X6TzLbT0Cki3xK4pS2WqiSW7wHrPk5PrD1VpUA
wi1gxdtjHDbSOYZrq9Ch7eIWZiGfF8HCa/UZ/x4Lc+IfCLIBaNBtS0+PrY0793oQ
kkhJJsRO
=dhUd
-----END PGP SIGNATURE-----

--hkXsJpCsjmaV1HwA--
