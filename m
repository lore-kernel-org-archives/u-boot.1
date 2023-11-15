Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E3BC2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79CCE8748D;
	Wed, 15 Nov 2023 23:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a6t6Mrez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF9587485; Wed, 15 Nov 2023 23:37:46 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EEC8748C
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7788f513872so7117985a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087862; x=1700692662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TSpMTBsTQtyT4XFPCQxdQEX8s51+bhsO2Ey9ZPn5caw=;
 b=a6t6MrezjkLRXGxpKSQik0oyc0RoV+dizqcTeuaq/v+j6HTiKjVYm40UVGrjJ42Jpz
 FJBFgteI+yMbGX854+qwAS5P2fFBn36InzoRpJWLyKmPZVrwkMjPye1n6gi1SR7ewIOH
 /4CmhR9d9bJUWRZyKlqndx/YXLmzQChoY3GF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087862; x=1700692662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSpMTBsTQtyT4XFPCQxdQEX8s51+bhsO2Ey9ZPn5caw=;
 b=v7LRgytNZslxV4BGfugZ9G0OlMdwwGxenFwrPctomcUlahkQ9Q9YFyc70C9czUEniC
 ipfYejqcdJ+xuQimo1OnnksQoWy2J+++eXz/APVQNXAdvsNuqAMva1NEj9ggw1iXUuVg
 b42vssvQ00Piscm8RZPaSSua6GSDHMfAjhLz9hlB+IWrVoNi7dTNkaRyvTGZ600+kxKa
 qGKE02ezGXmfr7vjJRMbUB1vnuz1dXbkFnFP8ta0zgQRow67AUiNgn+OK44OMFTEIyqq
 5xETBVS1fTBetYcVYTsAZwVsetE6313jrz4tK9HI0LydV/JnXb3+JAH40DYs3olHi3fi
 t97Q==
X-Gm-Message-State: AOJu0YyasBT6NXDIt1pcIvWCbHqPlV+pMKit7dnLIoLmsMk8Rh0pTvx4
 4Q5HCL049ySR70GX/IDtovoqCJQnIH0Okm45i/I6uQ==
X-Google-Smtp-Source: AGHT+IHVkcp3bsa4GRb2rRpK6xufCBkJXuhFl8oqXX+hkLN+9nDf1E+JZxe8ptad6qsJWVROuMvyZA==
X-Received: by 2002:a05:620a:347:b0:775:9040:cc69 with SMTP id
 t7-20020a05620a034700b007759040cc69mr7217473qkm.60.1700087862471; 
 Wed, 15 Nov 2023 14:37:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 bl16-20020a05620a1a9000b007757868e75csm3809847qkb.117.2023.11.15.14.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:41 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 22/29] bootm: Reduce arguments to boot_get_fpga()
Message-ID: <20231115223739.GB6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qdqPPnteonMcwNjc"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-23-sjg@chromium.org>
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


--qdqPPnteonMcwNjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:07PM -0700, Simon Glass wrote:

> This function only uses two arguments. The 'arch' always has a constant
> value, so drop it. This simplifies the function call.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qdqPPnteonMcwNjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSDMACgkQFHw5/5Y0
tyytpQv9HPwU1noTMJqRbVgEWZ+miVOeiaBYErFf6/KijEYsYOHEcEAy63PBFnlx
n7q5AZ0r2zdrFqVAuUmnuJiBAD6kngW5/ovFQPsQUon3bb2IawWHB01ucQJ88z36
B95rfJy3bjjgc7qO17sYygjMgvtZeNCmW9EfOYix0af35X9jGW1r/y2JU6WwiBnG
Kh9rs93BbdfhQOez1dZmT7kX7qtJG5jhJp60ZOCKsDTTiZb0PzQIlcq6AHgK8UJ0
efXjnmMSuXMZqcCXR+L91b/fdQpX9UkJYyz2y0ntfPK+ssS22BBXeDjjYJFjwVMl
rZ69cq0+QrHng9GLgycHBNM+qSJjEyKIYZ3otHDT+MzdkjgMi3YVhT/h/GcFVIdE
gdn5OwkmrK3JdGT641OBlGQJU/xZ4FJKkZLHfB7gQ0VKEy6cTGjO5q3Qv8QhYeUi
ms4/jfwod2heEhgYgLFtOWKuggPnAGBpH9PvjbGFV5gjQfTdz3MEOaW5dR5cLp0/
SyPMmVrB
=uUdi
-----END PGP SIGNATURE-----

--qdqPPnteonMcwNjc--
