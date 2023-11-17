Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E60C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4DE87509;
	Fri, 17 Nov 2023 14:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4IiT+ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D6086FB8; Fri, 17 Nov 2023 14:42:37 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213F487515
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7788fb06997so120868385a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228552; x=1700833352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YRTXq2yOrKhqaGqzTeOKyIFjiPnt77OLdzvkrpFeAGw=;
 b=N4IiT+ETdt2v9G6NpE5JU8eDfveXy39AAg6ShXLBLFCVxQeWEsxeJS3TFtBU2z38qd
 vvIO1LyUmR2H6ue0KW98eUvbOjcCNERbUHDczbPBt8IDHBPhOQINua0OAu7MZUtwxbd7
 ALwcE26VrKqmsBsV5+U1Vt7cpIdmeQiHnZbns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228552; x=1700833352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRTXq2yOrKhqaGqzTeOKyIFjiPnt77OLdzvkrpFeAGw=;
 b=LI4bFD0jnBySnls5iqin17ilAWtQesrP4cO15V5c1JMnYyoHOxqg/OgTAh9GXFEVgj
 qvZtebG3r1Wbhwv5nTw1hcB7lHW57xcLA5iIMCbxnxqRD0vLp4kvuTUGMluZCg9snIUS
 VSSjFtJ0YlCymUwyH78L27Ha8eBW/WVGaHEx/Q3Aj6D2xE24apxqYBNejAMqmInwQmI6
 7hq5acbbwNtr72tWwQMdP+hYMYyv7elxEp9twDU0MWyam4Y95yjcZK9W0ja1hX/5cL21
 tSeMneFJaGAKO7p/r2A36SICbLoO4Hk/CCrWxf2TC2vVIImDuR+PA8gHj+JE18b7hW2b
 PGlg==
X-Gm-Message-State: AOJu0YwHbPnHuSEMWoezoCw6ddoooFndIcFdKhxZ4z0CW/j2lBGMOSpd
 dgzzVestm6Nt+heU9I7Dmx3vgQ==
X-Google-Smtp-Source: AGHT+IFqTHW34mFq33/+CI1tYiUwnAw5toslCNFArVkcgrfwjyDvLemRr5QwQeRuk+6Ca8IVFQMKNA==
X-Received: by 2002:a05:620a:424f:b0:777:74b9:219f with SMTP id
 w15-20020a05620a424f00b0077774b9219fmr12645652qko.8.1700228551933; 
 Fri, 17 Nov 2023 05:42:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05620a113500b0076efaec147csm603396qkk.45.2023.11.17.05.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:31 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v1 2/2] poplar: provide more space for kernel image
Message-ID: <20231117134229.GY170968@bill-the-cat>
References: <20231109223435.706053-1-igor.opaniuk@foundries.io>
 <20231109223435.706053-2-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DfcL0fY2ESafMU8m"
Content-Disposition: inline
In-Reply-To: <20231109223435.706053-2-igor.opaniuk@foundries.io>
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


--DfcL0fY2ESafMU8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 11:34:35PM +0100, Igor Opaniuk wrote:

> Adjust mem layout, providing more space for linux kernel image.
>=20
> This fixes the problem:
> ERROR: FDT image overlaps OS image (OS=3D0x30000000..0x32580000)
>=20
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--DfcL0fY2ESafMU8m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbcUACgkQFHw5/5Y0
tyxjyQv8DeZDTBcEI7RDEKGF3gZmY5yeEcJtSvXMwiJ7sE4x89RJAJOQaofMSYj2
SBzhJ9A4kdaoOg8KUDS9f7O+Lk1pcMbVV4lUwdc7RQhldFx3KCXD1qLKF6IPq67i
7gozvEYoQu7hv/PZWe156h6HVFmhuh5KM7/bc9WKLmR8Y5p1b8DakMje/2bup2KY
K6wV8jBKr3ASoWMlqIcH0hUQqfWi3QKcBsNdDiGw6u3k9rcq7F3t1d3+zaGDE9ZY
KFEqEA0oKdYWjqSCnsL1fSdE45ASv7i3jLUaLCVIEnPMDdaMx7zX/p3rsxo2xWgM
RxAwDF0MlPwmCLzPbyR/B90yyGw4JJIfELdV/8x9rexNMAiykZxblADFnjnL6uDb
GcyuNvm/txnz34Mm7njL0EaiRMSZ+u61kJgGXy+40x2ATYETZ+bPGJpPRnySOK2D
p4al4f9ki1c10yXDJFhpadPBq101koQE7YGlYAGVVIZvEqHTEzOkGCrBbFDP+CvV
Va1UbWGg
=yqK7
-----END PGP SIGNATURE-----

--DfcL0fY2ESafMU8m--
