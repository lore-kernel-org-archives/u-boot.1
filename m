Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8164DC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 21:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93AC80C7E;
	Sun, 16 Feb 2025 22:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iTNKAUPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A149801B0; Sun, 16 Feb 2025 22:57:46 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62C080BA8
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 22:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so7625220a91.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739743062; x=1740347862; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=29ohFVoq1dQ5+/n/BYcPH4DiZOvjm5L5WHaJJbfevog=;
 b=iTNKAUPibh7YNETOfpobryealosLUlJyIlcsQejoCAhbcGHN3lbXrAtpm/MzBtGLzo
 JqMV+M29qU4fAMpz9lZJ45WqgwzVhTrsfdeg5oPvAgQVfG5aVFqUtVhtgMZ1heTtBMaT
 VdhArZnlwljCrhCxHSczrzlYfGl50hD6m3K+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739743062; x=1740347862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ohFVoq1dQ5+/n/BYcPH4DiZOvjm5L5WHaJJbfevog=;
 b=qGQWiisnk1cSNFiYSsBfLlNTpT37M2PQIilf/5Zm85cB/YpcrQ/fgwmdufGSsxG8nw
 n8T4Twqp8U/tkMGqdwdWN+0K8zH0ckCG4Z+IJBqDCJULleEokbYVdmsklSXWHzyiq2a0
 GC1QJMjJpQA3f9r37ImhBdhqa94XeNanwXFr2+fWl4/FSvo/TKlHJ5L5LEhvlEdCzWvx
 2+oSlN8PjZFJGFEcfoLwHZbxDTUOXmDzRikHI4z0tChaOUC/Y9wOD1ZK70Nkby+8O2k6
 4L/4fe0Ifq5H0+8hM2tIO5P83IMXi7VnqVWJY9ShZE5BVCgbWR1G0Wn0cJeDarkVZtjT
 WN8Q==
X-Gm-Message-State: AOJu0Yy6IC4Evxsm6pcbqMZTVqBaTfsJNcmHSdgPXd3EBJEn7TaYuRzI
 c5Vw/5P1d2MlqrDT+Is9cP+GRNJqym9e0GOq3YYoPVnHTL9VdwDfFqcXP+6ZNEk=
X-Gm-Gg: ASbGncuqhAIOPP4qDEyM7kmdjLVn30wgeb413Q92byx2WvvP+2396KiuApA7yeOoxaN
 fhoGvklGt7El75Crk3Ku6y5NUs65dqVQAhzlfRE6h64W8HK9pMlSLPHJ7hylnHw7frV9mORZcxX
 ObUbn7C0+5fHSpNYlaVFLTl9nvXuyN5A4tCUg0lwqyLI3tRbseYKmZbL/bb9meLZmxCJJhBXaV0
 lSC7zFPiFLIywXJHnCkVDnJX63TC/0EcwKBnc3j8SEtQbTqK/wSZcn9AKYqPLYDSRrEf4tnb473
 oRNgknQaNdmotQ==
X-Google-Smtp-Source: AGHT+IHysfB83LhJmODtNdD7fcd6LgrJTa8iuL7pEmYdLirQ9fYlsSJ8lwYPelpgh8YdiYYFGXChpg==
X-Received: by 2002:a17:90b:2fc3:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fc40f21c49mr10622367a91.19.1739743062489; 
 Sun, 16 Feb 2025 13:57:42 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13aafebesm6636582a91.4.2025.02.16.13.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 13:57:41 -0800 (PST)
Date: Sun, 16 Feb 2025 15:57:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
Message-ID: <20250216215738.GF1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nufO17mhAZ95TcDn"
Content-Disposition: inline
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
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


--nufO17mhAZ95TcDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64

This seems needlessly not against mainline.

--=20
Tom

--nufO17mhAZ95TcDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyX1IACgkQFHw5/5Y0
tyynAQv/Yw3vjXT5Tlq1/yRP1uPrvljHSWE9HJFfP/9yfKrxMqy5PQtys0gYUc9f
inD90JPn+OJfjcAkPWg4BI3v03+Izyb5/YMWPXK298MBniOURrMkEUBeRyDda8bk
1Z7jorHyefwj7HpNuYvh5tmalygJprWIOjwZrgaVQ2kMe3vUNHTlNXToD5yfPxJ6
sTD0qH+evlI+Qw/nbrehnH1uZfViOz+/e7KOkrYUPr3Z8ytaa8CIn+Lgo3FTVdBj
bhI/+1V6YYMVI4yv1PfphcrPV/oDd7mXYxvH/oMlfNWrdPpjaEAn860sQx1yxyYS
T/O+7f3bqNGzlMi3OocEkT4v36OnwR4l5PHllbfENHd6qLKuNgorHfH6UubUUf7J
B+Az6i02L8Hus2OB2rl1PRT57Wex0GvXsbwuT5f0DTI38PGdMSUyxGagS0UlOvQJ
+LUM6gkMddqbDbuLbJHpoxRGBiu8J7HDPZTHW9V0QIimEvFMsFQChV22Fw12y2vh
ZGoEZ2RY
=qeLp
-----END PGP SIGNATURE-----

--nufO17mhAZ95TcDn--
