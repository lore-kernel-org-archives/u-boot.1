Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D75C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F22788302;
	Tue, 14 May 2024 18:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YGnkk/iI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F14F88306; Tue, 14 May 2024 18:15:03 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C7C88319
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso30223306d6.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703298; x=1716308098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XEbP3B+9doh2PB6PcL/FUNZnGRaMQT9WE4x2x8tmUHw=;
 b=YGnkk/iIWX8iGIvqp3NUptKeAMme5uddSBx3JvsoPgJ4UfeViLnSRAem0hIIzAKcnS
 tynUF/vzEOXPxCbcKwlDjmYeFp8MlguPt7qm9Atw4wwmlRNT1U5CNjM1XF24xrnCiI2w
 AZlcb4BxqWJ/vn2I13c81YmqFhO7N1dye3qxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703298; x=1716308098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEbP3B+9doh2PB6PcL/FUNZnGRaMQT9WE4x2x8tmUHw=;
 b=MqXdQQ3Jc5PmZ3Sl+Opf9irLaNPD93OkXUFesiQGn2GGXph/dTKOZHqy5e/kNwQx7g
 JKj1zppVyFcG5gPnIgSmFj7h+MKHY8uLp4Zi/ZPKvVk3Ovw0e/j2HA68UZlsTg07jxet
 4O3VGC9g3XHVtv1mxDScfZUcvSai7ZLDiXLmVOY6d7zj9FFbn32UCmjisAzTmrVwUAZW
 /Y63efKaM8ywPWl5hmE0DyjtdRHQBa0u0cau/nJNvhN9grtHBN1ZprnF61HZOC0Sh3E3
 hv3TO5UawDLncBRlfHE1sDl0R+XmVMy3gDW1RDddmMYMHkKC/bnkEvL2+WQB5NAq3qXJ
 Qm5g==
X-Gm-Message-State: AOJu0YxHsTSqJx7Nx3rivauiALoTAJzPWx5IOcJc2ZhnSaSmN7SLagUt
 YxQiqBkCR1lU7Y1QdF0xGCla/4wf9TRpxjpzaLjCjMLvf12KQP+7TNLp+8FXMiKP5m3Kj3mwR6a
 nowA=
X-Google-Smtp-Source: AGHT+IHDeHGl8vNKolGPR3a1OQfPOpH6D8TsnUcqHu6uX66+X6gX0ysZ9T1lHpjzCV+x3WGeJziPbQ==
X-Received: by 2002:a05:6214:3a05:b0:6a0:de8b:4bfb with SMTP id
 6a1803df08f44-6a1683769a3mr141466436d6.45.1715703298524; 
 Tue, 14 May 2024 09:14:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a1680b8840sm46207936d6.42.2024.05.14.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:14:58 -0700 (PDT)
Date: Tue, 14 May 2024 10:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240514161455.GJ2568172@bill-the-cat>
References: <ZkNnFj1klk0nCrTF@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UW0H77xzW/mwZsgM"
Content-Disposition: inline
In-Reply-To: <ZkNnFj1klk0nCrTF@swlinux02>
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


--UW0H77xzW/mwZsgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 09:28:54PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit c8ffd1356d42223cbb8c86280a083cc3c93e64=
26:
>=20
>   Merge patch series "arm: dts: am62-beagleplay: Fix Beagleplay Ethernet"=
 (2024-05-13 09:15:51 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 2b8dc36b4c515979da330a96d9fcc9bbbe5385fa:
>=20
>   andes: Unify naming policy for Andes related source (2024-05-14 18:50:4=
7 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/20690

Applied to u-boot/master, thanks!

--=20
Tom

--UW0H77xzW/mwZsgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjf8ACgkQFHw5/5Y0
tyw40wv8DOSQRG2TtPXaqwSnCi7gxHm2FxVVkEkz0Jdvv56MZm4ZN4ugVGcNUO8w
LIOWxKsfIRg4e2YZ8cFCUvZFblB4CUv4idGL+q5mxZQlxjMPIkMGbjP7PjdXqzmv
qZbg+JN/ReIRjj20bpdkGEazyOjmAT+HQkdELlfgytsjWh8BxzqQUbid+JqkxnzP
0/nELIna54zQGGkYtNZu9doe6OnnjjTtmIYOOAbnYICfnfSM1UTo9Gj6ZD4fIdbL
IAeLtcI+3yi2UdgxqOfgYS11NEOywfSBOvFofxPR4siQddFwZz96xl2CWJiKLMuu
eMaEDlIlpEc1AAHV2SBy4wcXvXfe5/S4XpfBwM3vuMYCpp2HWIeeCR9gCcuSLhGS
cy2cZ8Ld3tVzP5BdObCpFmGyvkUG3NKhhj/xWM8vGhTirDc4SBMnAcYb2rTIInNP
IuNypATG103LlwnKvjKIYtcQVWt7qd50gfuj+1bBY+DPoRJKG0LFhQIGssOHYRJI
J1LeETID
=6zxy
-----END PGP SIGNATURE-----

--UW0H77xzW/mwZsgM--
