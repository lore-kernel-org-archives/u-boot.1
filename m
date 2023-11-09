Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400E1C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7898765C;
	Thu,  9 Nov 2023 22:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S9GLt2s4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD338766C; Thu,  9 Nov 2023 22:26:45 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C288A874FB
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77897c4ac1fso84548185a.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699565202; x=1700170002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rv+FyuqiQBQUBfVXlxcLH9skcnh/xf4EINTVfpBJXzY=;
 b=S9GLt2s4TOn0Pnvf+Iny7VFL4n8T5sGho2Hrgr5JaQE3r99HDVGg1uDw9VU30Xr0Lx
 tO6oP2GxADs5AJ11fuqK/UUAIZFOdHsqVWquEH9YPYP7wjGh7P4zd5bmqD7WM7LyC2uz
 z3HjmvkSFgdn2VdDMMbSUhzvPX7ZNuajxLpQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565202; x=1700170002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv+FyuqiQBQUBfVXlxcLH9skcnh/xf4EINTVfpBJXzY=;
 b=MNqF21wBRAUDqSrxvmPh6CQBPMEjZ7L8+X63ejV3mk/pANipqaovpzq9bj5lpcJ2l1
 nC2nzTjjudpqHusLqxaAZRFUrmhMEEX+FK3H+jbN6pnGezlUAaTolegmzvUKAqtwJHU6
 fDesqh8NxstByI/bltPmcSvgPp5zOakFGujF9VYbFhXAYzuT/JdmkcN/+rrCqt0Tc7Bb
 f9OYI0vDuLKYnxEiSIMA5BI2IiTwE1JgwGAw780PrHfu8rdzpps0G89f7vTKftDFmy8U
 Rt6838YqP8VReRZrgxG6FDOWPmruwdcSXZ1bbXACpQT9Fx8okI5xjTBp4SNQAUFxjAHM
 9o3A==
X-Gm-Message-State: AOJu0YxMFBLnvnuPqo2oChgtztshqtRtaSohEJ2swFqvSFCp/Pm9TqAS
 HVef02BegueIFXuOsqgzbYYpvw==
X-Google-Smtp-Source: AGHT+IFjVzBizcDXwNW8loFzet7lk8a4WJASUBrE5+k8cCEEn+4zMNPfeSrY7JtYDNFcnN7JJCM0QQ==
X-Received: by 2002:a05:620a:3945:b0:775:446b:85fa with SMTP id
 qs5-20020a05620a394500b00775446b85famr734088qkn.3.1699565202510; 
 Thu, 09 Nov 2023 13:26:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 eb4-20020a05620a480400b007757fefea79sm199196qkb.130.2023.11.09.13.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:26:41 -0800 (PST)
Date: Thu, 9 Nov 2023 16:26:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 4/6] rockchip: ringneck-px30: only declare functions in
 U-Boot proper
Message-ID: <20231109212639.GN6601@bill-the-cat>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-4-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mnj4PmYrHRK4sG+z"
Content-Disposition: inline
In-Reply-To: <20231108-env_default_theobroma-v1-4-cb493bfdeffd@theobroma-systems.com>
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


--Mnj4PmYrHRK4sG+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:20:33PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> Those functions are useless in anything but U-Boot proper for now, so
> let's compile them out explicitly.
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/theobroma-systems/ringneck_px30/ringneck-px30.c | 2 ++
>  1 file changed, 2 insertions(+)

Same request as the puma case.

--=20
Tom

--Mnj4PmYrHRK4sG+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNTo8ACgkQFHw5/5Y0
tyzGDwv/TgRMTX68utsx/JzygPJ625W2PiVY3spUPm8lQDbev26ZGi7m6ihR2PpK
/4MkHkj3qDy5Iytr9i3FD82F0Y41BXUU5kgWOaEN9mBQrAgTO62BdWZ0GM7ZBu0I
AdH13QnnN2zOTacomr3LZkTlKgO2kEcmdfUopmfAm2HrHGVa3K0JpxN4mwutD/wz
WLvB1T/YBlJZEynqtgBsgwR9uucMDt5ILL3+ALbqCCKyrLwgY1j46ah9TyE3+j+i
kbaa3NpMVL3IcVFKTMtvh/OwoLaQssE7wZXnSilztT3NECrzKbXw4CLqqdP+VPJ0
cRUDMqVauJEVfYFAMPEPU3zV/btv/tviXjL3BSB/yG2GvdmTbZGR+NQDWZltob6q
Q4fLCRVYOnV+tBXljgSENSoJPXnzxE4sOLsXS7hvL4ggPvh61t1ydqmDbgpzbpW0
sCeRbQKHsaDDP0s6RZyo9gYXmRn0JdnfDDVSQg3hxq7ick/HD3hELx1dFFixKkpq
hzZVQ7vC
=KJxc
-----END PGP SIGNATURE-----

--Mnj4PmYrHRK4sG+z--
