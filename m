Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A095CCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 18:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AD180422;
	Thu, 21 Aug 2025 20:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K+0eIekF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D8C80B9B; Thu, 21 Aug 2025 20:33:02 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187A68004F
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 20:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3111c59720dso771694fac.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755801179; x=1756405979; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPDVt4Nw4OJzAhv+uPqLzm9B/0O2lotIK+dcyOITAUM=;
 b=K+0eIekF2ekZBP3qdRC2dBpiezYbc8uKtpxmXIltRyrygzKjOEQGGq8Q8rp/jK94QR
 CtgOjgd+7fwt5yJ58466B4sILxAvVZB6kcYtJjHEQ2oeH91OwxOGHCa1Rv2lmwlf65XT
 YTSHuqPA6IIUhcwHlnmPNKRmGVhsd5NHHzDWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755801179; x=1756405979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPDVt4Nw4OJzAhv+uPqLzm9B/0O2lotIK+dcyOITAUM=;
 b=rpFImdOY5i1DEfOWmDNyHKIrfS6Yh529SVpKuaho5t2YRlgUPvDwIIDN+Cq1gN1EGz
 ii5avqVm27yL375IvoJJBIDXfMefsHBc6RyQwDc5mAMYgJLwTvfrcuGFjdyhMNws3daE
 iTVqeBVcDca2NIPVG6HQ7NvVfhFdXyrb3hMTgGIbvzc5YQ948eu9cOg9+YaxOcTu5JLT
 F61FMjs3PbgOrU9jXaqo1+X4mNPvvznMCusj3A6HoNt3GdvAZuPNyhDkZMhd92qP0k3p
 vvap00kul4/PpYEMIx4rY+j4kIQOoQYEvq45FuxIsLCnIHBusQIyai7mBpvdodCNAZ7w
 ADBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZpOisQf8i2s5BvlMy02E3nWQ/Lkiwd5wjJjaN1WImxFWtUX84qAjiKZwJRX9vwrZQXiBje3U=@lists.denx.de
X-Gm-Message-State: AOJu0YwHclMDTtE38e3j5xII7+iqd+qwfrWP2iiqCz2kdAtz6P7oEFGt
 GcjS8dUdaQdtxNyYuNKkjCvGyv6RV7B1j2Xu8eoABo5KqlbtAUmowoLnw/VK4aayIKs=
X-Gm-Gg: ASbGnct6tgIi9ui76wkTNSroL6gPNkBGx7G2ntBQ30wNlKWIuougjivvAm12hgkHZ8H
 yAJv7Ivbi/eEpNo+3cHF0sxcSITMbj9PiT7WqsKBzvMfRn1v0i6fj4erhWEa7yvxIsuTk+iAf+d
 mTw30jWe4q7I9v9ZImFIazDoY98MY20xm2IJFS/iSN5/jYLwVk/2GRBNJdPXjUv52kC5nXW0zRO
 /pUHsocbr5VHrFkKF/EhTh9w3xxpTrF19xLRc9NAPHNKDS0cr67kzBKxVdNiJu+tX54u6um6vOZ
 cnM5V9w4dGR7isIk30uMgHUA+/osL3wHJH8SuaODMGNOjVhV1BjjUGiG84mHlSSlYlQtqQYBNQn
 GMRGIERuYBeDhrRpxFbSFzQAqird0LUCZqKHrX1rqBg9tg7AUB2bxh/Qh2EfyQM18VXI=
X-Google-Smtp-Source: AGHT+IHCroJ2Gu25FvF3vLPne5Dr3nVNye25mfqdZD3FvdSKDrWZTfXpcHeMvFoX8ZZui9GEOKozTg==
X-Received: by 2002:a05:6870:3308:b0:30b:cb2f:bae4 with SMTP id
 586e51a60fabf-314dcb54479mr127750fac.12.1755801178729; 
 Thu, 21 Aug 2025 11:32:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310abbad019sm5077179fac.25.2025.08.21.11.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 11:32:57 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:32:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 David Wronek <david@mainlining.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: dts: pxa1908: convert to OF_UPSTREAM
Message-ID: <20250821183255.GM124814@bill-the-cat>
References: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
 <12753632.O9o76ZdvQC@radijator>
 <20250821150404.GL124814@bill-the-cat>
 <5032885.GXAFRqVoOG@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2DSnuLg+QXXNXMMw"
Content-Disposition: inline
In-Reply-To: <5032885.GXAFRqVoOG@radijator>
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


--2DSnuLg+QXXNXMMw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 07:18:45PM +0200, Duje Mihanovi=C4=87 wrote:
> On Thursday, 21 August 2025 17:04:04 Central European Summer Time Tom Rin=
i=20
> wrote:
> > No, sorry, I mean you literally do
> > ./tools/update-subtree.sh pick dts commit-hash
> > And then send that patch to the U-Boot mailing list. That will make it
> > easier to manage resyncs later.
>=20
> Ah, sounds good. I suppose it's fine for that patch to be separate from=
=20
> everything else?

Yes, thanks.

--=20
Tom

--2DSnuLg+QXXNXMMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKdmUwAKCRAr4qD1Cr/k
CjQyAQDco8BDDpBwE014HCml+gWChwlVZ0BANUikqsH5PYMnpAD/YapiOkMsX6PV
QzOT9voqmUT5M6Wf9h1vVVvuqlPn8AY=
=Knbi
-----END PGP SIGNATURE-----

--2DSnuLg+QXXNXMMw--
