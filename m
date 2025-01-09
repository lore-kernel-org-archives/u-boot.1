Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CC4E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 20:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C884E800C2;
	Thu,  9 Jan 2025 21:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bOjk01mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 207CC800C2; Thu,  9 Jan 2025 21:54:38 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A088001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 21:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso11275296d6.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736456074; x=1737060874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zP4MIht3ADOWpsiC+qJxk3TlPWsBdo4LBSNv0voifG8=;
 b=bOjk01mkRE4XfdBGhnEEOgFMiAErksFAzOTsJeXAgSbDt3fE04bqMsRueoNLvTuOUI
 ILNn0wkZT/eJ6y9xZErJcLbxA1w0zwZQo1tbw3qFvUmnBFTZ8FiOoc4gChgIFJS6hJt/
 LqsPPAO3fb6YjQH0x5yiQ9OAyEGYPxr5GWTA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736456074; x=1737060874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zP4MIht3ADOWpsiC+qJxk3TlPWsBdo4LBSNv0voifG8=;
 b=eCwbJdhcztCFf4YSLXzEBpJdnTZ0sxQvqyXsy/AzMRkMUR+urT2TnD1Y6AByxJBbF3
 y3uLZO4qNYlryhHeHnNe5SInEr7/TAmYuCGEuo8E0ReBx8VTOaPOs2clfQM+6aat+Lby
 Gbl46OznyPdDPDOyrKibV7U9WFqJz9xtLFTj3X/Np4dP2rAzpT07gXlNepW3S+cYwxj5
 ZtnQnSaux1caiS+cH5Hv0MjBp5DBlBhyQQa1QzGyH1ROruMOcMZY1fnmx4cHjCZv9wRU
 NM3gaY9NthE+e0P4gYU/hXdsG4oPFHJ8YkwLSpIeiLOSOWAYZ6OSGpvEOzWoWi2cQx9B
 mXnw==
X-Gm-Message-State: AOJu0YxZfJXrBKB5amkdG9+ik+dfVt73RS/Lxze7I9RSTSPzJtCGbwS2
 6AcBziW8IM2vJNBFNwXtirdjGat/WJPrX9me2S8UtQunGsOPJko5cHbc+qPVCyg=
X-Gm-Gg: ASbGncsuXS90ljCXpqJZ+Zw/UMsOC7Wt+DATaQnu7TFc3XMxbUyhDeq3yKBxi1ofpSM
 HNNc/Q1v30oSjN2/7H4FJyCKbvTBxOKdCpadMdWD2Ka3q80XlJ/U26w2UlTcdDtrii+87heUsGd
 /dIhRB1125L/a4HPgu+/uSiSj0HtQ3n5IzwnoXCYiLYrZVM8jhNN3R1F7q9JByU5wYHTkUsX3x8
 aWBxZo6IaJxx3uywUXyooLQbR9ZymkzaStzdwFFayemxgSLa1nXwNo=
X-Google-Smtp-Source: AGHT+IEJlcawupP7d/cPzBsETcbRub+MFOHoYvnD6JnAHnOtP1sjz8BvkdHMDK7if6/AIhT1EypcEg==
X-Received: by 2002:a05:6214:5293:b0:6df:97a3:5e76 with SMTP id
 6a1803df08f44-6df9b22e835mr114802946d6.27.1736456073439; 
 Thu, 09 Jan 2025 12:54:33 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad88dbc9sm2246526d6.30.2025.01.09.12.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 12:54:32 -0800 (PST)
Date: Thu, 9 Jan 2025 14:54:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, raymond.mao@linaro.org
Subject: Re: Pull request for tpm-master-07012025
Message-ID: <20250109205430.GD3476@bill-the-cat>
References: <20250108071933.2908136-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eEa1yjAfe7D9OL26"
Content-Disposition: inline
In-Reply-To: <20250108071933.2908136-1-ilias.apalodimas@linaro.org>
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


--eEa1yjAfe7D9OL26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2025 at 09:19:33AM +0200, Ilias Apalodimas wrote:

> The following changes since commit 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f=
72:
>=20
>   Prepare v2025.01 (2025-01-06 18:54:44 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-07=
012025
>=20
> for you to fetch changes up to 70a3f0efa1a8ac5e13bb06660f602deb75360dc8:
>=20
>   tpm: update descriptions in tpm headers (2025-01-07 15:45:52 +0200)
>=20
> The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines=
/24102
> showed no errors. Also my internal CI that tests replaying the TF-A gener=
ated
> EventLog passed with no issues.
>=20
> Please pull!
> /Ilias

Applied to u-boot/master, thanks!

--=20
Tom

--eEa1yjAfe7D9OL26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeAN38ACgkQFHw5/5Y0
tyyYGwv/XgfPPDGYiDcd5BvrB3BW95dPjzRW/TsQppibAISXdK/O2i9uUJEoopA4
n95F3Q4jRP8bNHbyyelQC55ksFVEakaqVciJcEbW5ipotGNIbxDV4QjGsa+OiC+b
LJJP9I9uBe/R0Rf4dkOYwUBhoYF6uS3dzu9jIX++2oCIqFgmgfqPK074F2CaNdhz
iPGJ2aU9me/r8PA4G3pv6i4FCNXXqC/tADmnjvvhqNx/SrMJQH6j8uL6bqQtZ9C5
hFhsnr8hFkrCgQ+n+O/yiU3SwIYiXula+BbGRM7aemgF7QTeeAt8us4ehIBDtEig
L1CrMHs1nRMo3bO/+Cw6LkhTQi2M3EwFemSiRHg2Cq5gZmVUjaoWBj08pmhLKiNV
oOByf6Dn9QCV4jdWnyZRi2B3Wj7NplPP5hzzv7KEjnra81aBoCt4r29CWdHQHlEK
CnCZ8CkC+D6FzJtBkQBmix9CIJf0Jaj8RtFyP3FDyGSFvdiXfIQsq7CRS2oJ4RuW
Y/1VGySe
=33wk
-----END PGP SIGNATURE-----

--eEa1yjAfe7D9OL26--
