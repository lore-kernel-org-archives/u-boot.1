Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C679C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96B88765B;
	Sat,  9 Dec 2023 16:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFwQY9Zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FC387660; Sat,  9 Dec 2023 16:58:44 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897EF87645
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5c8c26cf056so28507087b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137520; x=1702742320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GAbRN/TrNNDc3Mch5292EpvVrdqjUIRVCCxDfxeGx68=;
 b=XFwQY9ZbqCmeiUBmXUtrwPM5GCjMBKhkNPCp+Xwg/pxfq9telAON7UR+Z4/CC+Azww
 Ppm4JOOp9dW+QnxC1Dfxl2VO1ehtpW6MlYYZTNSVrMFMIY8E3ksigLd4HHD7Zmql2vf+
 hxY3TAaOKxZQWXlNvBdDDboziwgs3T3sbyyeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137520; x=1702742320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAbRN/TrNNDc3Mch5292EpvVrdqjUIRVCCxDfxeGx68=;
 b=pe9gbBRR5UmiuMWczt3dIdSsrsHFv1J/V5pdKSxDSJDtZayt16yTum/7GUlBk+Gp7j
 4hkstqQfY0Ad+Of4epZi9902M8vzSvUzetQrbd0U8bQ91Je0qJT9GmloIedIoKIDuOdF
 Vx2OyioTqPGmyBt7mWt6hDWdzqCI/fKO3rEz3z1nhW6lzuB7M9W5FIofvuu5cjnsJoKP
 /9jMPPQYMHcuiVUb2e8Dq/wHpuEU37XNIYIg30AkPQzIXKGY48uBWIDq11IvoxIbAE3I
 qojU1pLn5XGfFyeSx4Wp3O/0aKVXNba8saPYkrxrXQliBvm9Cun96U2mP8eAVI0WmOlF
 AAeg==
X-Gm-Message-State: AOJu0YzcYqowsR5AUlfBnvVeo9fQ+Gyo8HBVdiAqqCubFvsSskcRum3k
 79BNc1UcJL4cMnNv8OgGiiKUiw==
X-Google-Smtp-Source: AGHT+IECr1cU3Ml1cfAXQ8uOvIYi34GMNhWQNNC8+Tbwi4Vhjm2YCbXUo+NJqxqKTbLDvGlS8HeO1g==
X-Received: by 2002:a0d:c486:0:b0:5d7:1941:2c2b with SMTP id
 g128-20020a0dc486000000b005d719412c2bmr1367018ywd.88.1702137520193; 
 Sat, 09 Dec 2023 07:58:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 c128-20020a0df386000000b005d395bf0ad5sm1533846ywf.64.2023.12.09.07.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:58:38 -0800 (PST)
Date: Sat, 9 Dec 2023 10:58:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 06/18] bootm: Drop arguments from boot_selected_os()
Message-ID: <20231209155836.GO2513409@bill-the-cat>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KzpsCApLK7DH7fww"
Content-Disposition: inline
In-Reply-To: <20231204002642.895926-5-sjg@chromium.org>
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


--KzpsCApLK7DH7fww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:26:22PM -0700, Simon Glass wrote:

> The argc and argv parameters are not used now, so drop them.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This along with patches 1-5 depend on what the answer is about how
NetBSD certainly already expects to use things.

--=20
Tom

--KzpsCApLK7DH7fww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jqwACgkQFHw5/5Y0
tyy/Mwv8C+DraijIGQuAS7dS4tN4iIcliyCGafsrF/Wb2KDjdoWDz27BXjsz7RaT
q7gGspHsB8yla5SQ+a623skOrX/o8vtEYpz63QpHNqolT9g2BR2OxFTyDUBrnhjL
pvBHmM2V0GHuzgXrSBc+CpIUiFIstPP2CVHaFcM/J6aFvXsFSHWVhNR8hTmjX4Ar
PBmQ3lr7BslUYpJmCIfCsfmSXWguPfXcbaoVGFgvgrczjAYcdO8/hHm9mIirD9Ws
cbyQju3IlCSqAP/IwrT3136KXzT3ehVCf6CF1lJ6vIIlQH0yJiQL+6Cg4+j9Bd7o
pA6le5CqOW5ybQC8r2lhCnXlZ4GRf/WJRN6mTjKe743BZMYRa5cDB1QN+YQepIIE
rEMI6vAIIDXh3zjnYbSOLZCHoLU+Z5044K33D3pFT8R6esTgO8BoRZEbvCgqE0Au
AIhAlivJUDF4XW5ojmKrwnllkM8rBZL9cQnz50z7j9DDSzxr2wcXJ4baiyzTQgDK
kWCT4PAE
=YoCg
-----END PGP SIGNATURE-----

--KzpsCApLK7DH7fww--
