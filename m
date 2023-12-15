Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88137C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A569087BCC;
	Fri, 15 Dec 2023 15:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="giPq7tMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F1587BB7; Fri, 15 Dec 2023 15:41:32 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C27875FA
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67ab16c38caso5049836d6.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702651289; x=1703256089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WDifocf9+imxTEUjtITXQDzH0m0xAZuvKlFENsjgu+k=;
 b=giPq7tMPpDBMzqQ7XkwbsNg5Vda/Tdu0lHs506v9O3uzwusinXeT+zw4HDCr8ueesJ
 gYajqbWuW9iZ1xvF89fTHCF5FcA7LD20O8t+5ZwSXz9uwxK1PWDM2qMAan0bXwJlphpP
 K28MGcHK2qdTrivchg3uYhuj1xwGJ3WBZwpvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702651289; x=1703256089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDifocf9+imxTEUjtITXQDzH0m0xAZuvKlFENsjgu+k=;
 b=YlpYSEwRqXSEWn2ay2b9TyLz6FYaVCY9DSV4nSwRv4RF8K4mUIH0ryf/pFA2uXuff+
 yalikIt5Lxtn4invfjEYv5je/wkwTqlXE40Jc+kVrRzZeIjVQsA/zblXOKDM5WMg5+cs
 IBqMzSGhD3RaJtQOwN3wOhejAJB4Knw66Hx5hZaCGL+8EYid7IN6xYkGL3hSiBWInoGh
 k2RlG5uX7yXDxOeSYi7SRhKpQ+5+k6NzVDQq1itXhRMoCRHmo9il2WcIhJlM/YPOGI7u
 Z0GvD16qFRa/nJlzY5m6WTPd3GjcpVC9k5J0IUihPqaKoj4HFAeociFT6rg/+Ktjot5j
 N/Hw==
X-Gm-Message-State: AOJu0YwDd4Gza2+MfQj3Fg00psMn7UhlGNzVSVRTzO7YAuleJZuiY4IU
 +rMdrPjiyFr3lyjHdJYpOXw/6g==
X-Google-Smtp-Source: AGHT+IFWIjQx8BR3AaWY+dBKl1+A11u40LiFyIC4v6g0WNuf8WWnkaQfZcOXKd7+RMlvONTuFDp9wg==
X-Received: by 2002:a05:6214:d8c:b0:67f:9e3:f128 with SMTP id
 e12-20020a0562140d8c00b0067f09e3f128mr4074633qve.13.1702651289045; 
 Fri, 15 Dec 2023 06:41:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 cx11-20020a056214188b00b0067ef50893afsm2492391qvb.115.2023.12.15.06.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 06:41:28 -0800 (PST)
Date: Fri, 15 Dec 2023 09:41:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Terry Lv <terry.lv@nxp.com>
Subject: Re: [PATCH v2 2/2] tools: fix build without LIBCRYPTO support
Message-ID: <20231215144126.GZ2513409@bill-the-cat>
References: <20231214121136.3286703-1-ada@thorsis.com>
 <20231214121136.3286703-3-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TQXXXYGeTHPKllxe"
Content-Disposition: inline
In-Reply-To: <20231214121136.3286703-3-ada@thorsis.com>
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


--TQXXXYGeTHPKllxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 01:11:36PM +0100, Alexander Dahl wrote:

> From: Paul-Erwan Rio <paulerwan.rio@gmail.com>
>=20
> Commit cb9faa6f98ae ("tools: Use a single target-independent config to
> enable OpenSSL") introduced a target-independent configuration to build
> crypto features in host tools.
>=20
> But since commit 2c21256b27d7 ("hash: Use Kconfig to enable hashing in
> host tools and SPL") the build without OpenSSL is broken, due to FIT
> signature/encryption features. Add missing conditional compilation
> tokens to fix this.
>=20
> Signed-off-by: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Cc: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TQXXXYGeTHPKllxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8ZZYACgkQFHw5/5Y0
tyxz4AwAi9lspzRlXHknuvpweGtgfjUcGPlGGihrQ/95svQmbXwN0XEKBmbUzK4f
CSx/fz8DkxT3t73Pnm6j7KZH8Er0fORbGOW8/RX33tKi5oq/Urhc/9pbcg9LMFGs
WHDtKO2zORVHqMMuPH+4fpkQ9ZNPn1jHDfN2p5decQom171k8UCtOIkzQ8qcVWxW
JTQEFe0/ePr8xfoVXG+su7rP2snt/jInF6sZka6mo/Kia6661ZjLiGurSA6ECIOu
sU6ZlDGpbpUxHB4wyiKSr1mZ/91+8uYA+OrBBfBktaMSes6gsFZvCojeQN/Ded5Z
l9I1G+LNA2IgKFCLxfuEXL5kWAUqjELXpE8nlea5ZkjL/wJ4RpbOk0IAJ3u1Nsxy
WiABKbpMsivtf+c0LM3wR62f4i8aKfiv7NpYkfWXiQ7Y6ceJ6/ix20nMrsckGWoD
YQQ96Ras+bba6RNxBLMG5DJkmh/iKwVHBuIFQl09a3ByJOXdZZehCg1i/XQZsT0x
JSNCkyAx
=9D/t
-----END PGP SIGNATURE-----

--TQXXXYGeTHPKllxe--
