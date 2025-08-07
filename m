Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D72C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9839084612;
	Thu,  7 Aug 2025 17:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDYhgvJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8B4845F6; Thu,  7 Aug 2025 17:54:16 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A5D845F6
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741ad8d0c15so859738a34.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754582052; x=1755186852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QDnnjKInbkqTT3zt9SvHYxD6wRsTSQmIzL2JtRrh0lQ=;
 b=DDYhgvJc/ZnKB89ojolnmzlobxEcDTcJP7OLsfiRKk/hi8EaIFHCxAl6nBISiCCl0b
 vMjm9CVm2spLJB8Hf35KhI4kxXJLYLerViqPtLKHWiF38CGLbdmMuVIx05BnOuoxhKQe
 efiQX1UKSjCNU5R6IkCZrayiXc7oG0RH2xMYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754582052; x=1755186852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDnnjKInbkqTT3zt9SvHYxD6wRsTSQmIzL2JtRrh0lQ=;
 b=Wvq77G1ZFIH5E3+uesY8zDjH64wUgPxhLJpJehKX6wgcfJ6gsw+uF3gft/6MT2eyI/
 L+m/GaeEYtCPE7FLkUcX/kaf+KP/zy/zIwUOX7ZlZexTgdV28kXTToTLQNJJoxD5aTyL
 liy+DpLUn8gmJ0HpLGDoGSJQKOsxEWjMVdZEJfQomYDya3dHOQmZPAiLSgTNQTYvjQMv
 Pl9lmM0C067oHXs8F9ieT6vrKCOquUS3/nVQ7vW94p7nIWzLrEIAmMOIC5lAGlNe0VeV
 VkgzYEctyoW2Dmmqcicy/I3+zTSNOj0fXsUZBVsOInK9hoZvs2ZUpuPdqcCCGb9s3/5g
 GKBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTo64ZMSTTFs97KEVcIzL+koVEMfYscNLUmolySId+v3iMSms4JUqTzL2zJmnfWaq+sngGXqU=@lists.denx.de
X-Gm-Message-State: AOJu0YwSsXswZhuBUbNezpbrqlKGTjTgQbmNATu7HvwfLnJbMhqmigZU
 3EmBEq6eyf4rLuzGrVlwvnc4HhOkat3eQySiPyMVCE8v5GhH2HAnzAMpF/SkFZTbr/A=
X-Gm-Gg: ASbGnctKvTSku2WVSIeNWsprkqpa4e7AkibTa9poAzOlAGcHP2N8VK6hnEFuzDFZC8d
 VSNS/1a+ZDr9ydhFaaRJv1BW8VweytauF0lb9KZ1slaTVQbHbRKKDOkHDNoFZEN8tNHdnGAUmJg
 PuVDNlAcCsaneWPcTXOrD37RzK88IiSm1RUARwsSrI5oI2UdEfDX8b2WPlkeE4T4eiN/VRQ43tB
 ArojMJYPNvvvhqXKsDQxSdnY0fLpVIoRdWY7PDJCvNPbC0RyScbV2gc7nqSFx/ZAo6Tz4khqxeK
 zMT0b8Hsyi+c5Fb3baHJ2TAnXyw3HDanD2rkZJ3NJByy0fqtKaSjG44lizCW4GVjhUrjZKCXFde
 G3BiPUs0Dhq50y+I6qdXqChT4HAE0EQpEU+cg634nqK8PiCORrchp3fsh
X-Google-Smtp-Source: AGHT+IEzh7mGNbUtk6u2C8ivVFMdmMyixtlNqDSIk1Rg9JkAfm79+87P3r2B7Aw301h7zqRL8YzNvg==
X-Received: by 2002:a05:6830:4394:b0:73e:643f:5b29 with SMTP id
 46e09a7af769-743288de6f1mr320170a34.3.1754582051930; 
 Thu, 07 Aug 2025 08:54:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a41aadbasm3013058a34.49.2025.08.07.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:54:11 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:54:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] test/py: Correctly restore the DT after capsule tests
Message-ID: <20250807155409.GX124814@bill-the-cat>
References: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pZC9/rh/K08twnZq"
Content-Disposition: inline
In-Reply-To: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
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


--pZC9/rh/K08twnZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 11:08:14AM +0300, Ilias Apalodimas wrote:

> Some capsule tests are changing the sandbox DT to test various features,
> e.g authenticated capsule updates, versioning support etc. However, no one
> restores the original DT and the CI pops errors looking like
>=20
> /u-boot
> Bloblist at 100 not found (err=3D-2)
> Failed to find FDT file '/tmp/sandbox/persistent-data/scratch/EFI/Capsule=
TestData/test_ver.dtb'
> initcall_run_f(): initcall fdtdec_setup() failed
>=20
> if sandbox is restarted.
>=20
> So let's restore the proper DT after done with the capsule testing.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pZC9/rh/K08twnZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJTMIQAKCRAr4qD1Cr/k
CvHvAP9mlM4c53coNxQSqZXIMR9Fe1N91CLBCFQOG9p1o6lOpAD/fsL8b1mDJY+I
2/udLVuCKt/3Zudu5Nf78eW4725rJwk=
=9yIj
-----END PGP SIGNATURE-----

--pZC9/rh/K08twnZq--
