Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640D0C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8630874B1;
	Thu, 16 Nov 2023 16:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b8ymWp5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4ADD874B1; Thu, 16 Nov 2023 16:48:24 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E8B863FD
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso5685281cf.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149699; x=1700754499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R388+YGwAwPuKg5N6VdRL6t17BujQWO9NtLCsDV5An0=;
 b=b8ymWp5r/BhRNmab1Kc+9PDzMzSGtfUzk/ZpwOzhyZx/MKNXwfYkBOcV3/xFxy8Pwk
 qLz+mF9hGKCHpNnjPwLS5lZaavkjJNFvvdX5JGZGEojcU5jEsmQJ6B4QQSZfG/z/V7KI
 zCKSlS1+aCo3j0FE4sPNDZ9ZDh+F5+dxMXKtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149699; x=1700754499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R388+YGwAwPuKg5N6VdRL6t17BujQWO9NtLCsDV5An0=;
 b=HUlbQyDsXRCETjYpX5WV7T/sj0A0/B9w/rx3/NprEmHT8oa6oxWO8v53GRO7sBvvig
 FBDmIfOAXhu9wX+Np443r63W+dIw0fFSb5vPy4bji3a5Lb1h8AwqaIBhHJq+XelIm9ic
 SKGja1EvTPABQvYTJ6uV5yb9m+tEfUOky5/+lFynIMMlWTe2FjgS8EaF3CaolHrz+zOx
 aKb11b9ZoStCmewA1Mnd+GgN1eg/2V9qNxY3vv2KuQK4FzS/LmyXqxo+2RA/wcaRpqgz
 F4vgiIkxWfeS/s3POa2ojBxrLiguSsbZHmTfmeTjBcmLJGiaEjyR1T5DSDHy1xG1rH9g
 Volw==
X-Gm-Message-State: AOJu0YwYnJXIN/Vrc98B/JOGZWgTgyX1I7w7OdYDK5a/SHGHYnQuTu6S
 9jQSFqj/7Ibye4qJ+7G0uKJBAA==
X-Google-Smtp-Source: AGHT+IGKTq1OGk4zsDNQKgp6X6uyj2Zda44n6ZVvLp3dauPLhtTbE/ODNeAF6Vxqzmxyhy2TnnzYaA==
X-Received: by 2002:ac8:5916:0:b0:40d:b839:b5ac with SMTP id
 22-20020ac85916000000b0040db839b5acmr8930674qty.15.1700149699511; 
 Thu, 16 Nov 2023 07:48:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 df4-20020a05622a0ec400b0040331a24f16sm4426308qtb.3.2023.11.16.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:48:19 -0800 (PST)
Date: Thu, 16 Nov 2023 10:48:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v3] test/py: net: Add dhcp abort test
Message-ID: <20231116154817.GR6601@bill-the-cat>
References: <a02d523a004e6c42c666dd0d90ace8cc44cbcee7.1699951058.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6k0A93pwg5863Zdo"
Content-Disposition: inline
In-Reply-To: <a02d523a004e6c42c666dd0d90ace8cc44cbcee7.1699951058.git.love.kumar@amd.com>
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


--6k0A93pwg5863Zdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 02:09:01PM +0530, Love Kumar wrote:

> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>  - Mark CMD_MII command dependency
>=20
> Changes in v3:
>  - Skip the test if PHY device not present
> ---
>  test/py/tests/test_net.py | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Can you try this on a Raspberry Pi, or other platform as well? With this
applied the problem I see now is that the next network test, ping, then
fails because we don't have network configuration now.

--=20
Tom

--6k0A93pwg5863Zdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOcEACgkQFHw5/5Y0
tyzoAAv9FDSrYr6gJsbd423u+EcbMsx6na7AZhe6S8ntV3T47Cyq/B4YKJPCPOTb
NGh7fYABDkiuS3uBasXG0M3qCUAflGVgyS7K2nrMyOyHU8DMRJ/qxqUTtHaE9Kmg
KDcUckWlIaSssAhAytRA9lAOqRHJ1Ylyj7Oio0pqkNmn4FTLJPe8YN4/j1u2ptLz
RdUMlAET8spdfD5vyuk+ojDloC9iHHO7F8BPv8Ck3kaWuU0vGVYrk60uJP2flG/9
ncd3iB3ge1ytE9p4rAJ5d6C/+zuqImuMoHF9ipQFjkCarcPcfnz9UTHuF5jbVPQc
etZE/7wbew44hKz/gMIVmmLF/fdjCW+szQX23dyjJ5xzAr+bcQODmfNLym0lLyLp
KnvrRp1YUFKzDblDbiEOypARsRXa0atHv7APOkTYRagEgUqBjDc2T6vD1qNdQzOp
+UWP/cXr/ZYey5L3cD2t6jOcjP70m/UwCM+Iqn2b3zYc0w0+Nmmeg7I1hltoHKyO
p5nVF/1G
=f6XE
-----END PGP SIGNATURE-----

--6k0A93pwg5863Zdo--
