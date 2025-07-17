Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D2DC83F22
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8E8833FA;
	Thu, 17 Jul 2025 16:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AfoKhV8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C69833D0; Thu, 17 Jul 2025 16:46:08 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F50F833FA
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73e810dc4cdso10201a34.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752763565; x=1753368365; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tZGA1cI46K3vnMV+qSxue1lBjEWvmpyW5W2O3xg2eDM=;
 b=AfoKhV8FH3esKZ0N7iIfpuycCmpFCGZUFm/U8hNbjLHxqZXokb4BABQBxzc+GXsCNX
 YeHldWvdJFXNql7T2Cy728vhPlshJ567WWZmpqxc4mxyMHMnWdanmQ87M6arL3BRfLQd
 ZvmMcR5Q4jobav2KFS2CNLb+uM8FfB3IAWEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752763565; x=1753368365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZGA1cI46K3vnMV+qSxue1lBjEWvmpyW5W2O3xg2eDM=;
 b=YlkBCJzS3EhCLFWDquFQi+zq+PYjLMRHHvdeCrx9kY8f2JCYw0FYdVDO2XELQCi3jf
 fvSA/zcBbjlulriX2196E8sscnUgXZx0IQDzVKF1oEl+hzEoLjGuZX+Qy1VR82Y2xXCo
 D2ZwRxrEgvM6BCQ0o+2ZA9ixy3sYjPLnBoGlopa7iPhzJF8b6/H3JldJh6f1W9ZrdIfF
 5Uc5KJZRkhZJ7L+SxvTC3+hdKfzvks1dwVGyoQU0imxkdyiQYKfk12qg3YPeIzJXIRq3
 r/bwXaUIBMTb4B5MvdrqyiJ7CBitT+6m3w/RaqtvRq0BQMxLWZxBCKU2qyyjHlPhwwgP
 YnOA==
X-Gm-Message-State: AOJu0Yy4nhyGCYqz4fDKEd+Z4ds6VTbUdhqBnkoYARHbTHHTXhl7VO2p
 KmQlF8fcBwLHtxWsiCbQsin2Qp24UUh7yJx8v7Bd9xqgcj5vUWbSVLUJJk5+vglJ8q4=
X-Gm-Gg: ASbGncsdx+H9ix9adBWBAlj9OTDc1e9uF3yzgFka08xynzt5qfnMpIJ61HIEAs0BiAU
 LsBpFzJRQeuczprgqLT7Xlrus9qjkqPahigRb3xnzTHoqyr9lRQEZcu0ccG+nKx6pEZ6T/n5Vt/
 NFEoJa89Y1AopMBjRa+uoxgCsR4Z11TLwmlWurp9bizjrzYUIn9ga2v8e+4cKWBwZ1b+aqw+bvB
 mAdAXJskLDCvH8CmfvDb5cD/Yr/q/ZDkoB2/pbKStEBDKLE6pztdFEBb5nzL4KasUaYd3+TPZYt
 gMcf/VHHOTACCk4v91OkHyckia++10wmdkg+JedUtjuo+07vFfY8G1vBDDH1t1jSQ+ww3S0N+YX
 jXlHkkjUh6DFbW/Yhmd3XwDXeDilvHjvPGnP9BaNxadlBwL5JsLs+nIi3
X-Google-Smtp-Source: AGHT+IE13NC2KV4dKkmUOVJHF38md2JYZoElis+Rom+IUOZUdl5wGOrOKXDdKK0KueF8eTuj5begJw==
X-Received: by 2002:a05:6830:d07:b0:72b:84a7:47e0 with SMTP id
 46e09a7af769-73e649c8a5dmr5660507a34.1.1752763565180; 
 Thu, 17 Jul 2025 07:46:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e568d9181sm2351034a34.36.2025.07.17.07.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 07:46:04 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:46:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] fs: exfat: Remove unused label code
Message-ID: <20250717144602.GM193579@bill-the-cat>
References: <20250717-exfat_label-v1-1-e15f28fd6c6b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+xzd6QPIEfkbqy8i"
Content-Disposition: inline
In-Reply-To: <20250717-exfat_label-v1-1-e15f28fd6c6b@linaro.org>
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


--+xzd6QPIEfkbqy8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 01:04:58PM +0100, Andrew Goodbody wrote:

> Smatch reported a possible buffer overflow in exfat_set_label but it
> turns out that this code is unused so just remove the function as well
> as exfat_get_label that is also unused and the helper static find_label.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  fs/exfat/exfat.h |  2 --
>  fs/exfat/node.c  | 54 --------------------------------------------------=
----
>  2 files changed, 56 deletions(-)

Since I think this is just pure upstream, we should guard it with
#ifndef __UBOOT__/#endif like other parts to make future resyncs easier.

--=20
Tom

--+xzd6QPIEfkbqy8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5DKoACgkQFHw5/5Y0
tywzGAv+L/kHHNQQUy5CBo7eobI8dwSV3htfcZTFdX6UMaBGo0pu3k1iM5SfJamC
NLqAiwG8eGTCz6z+e8N9VzgZZFeymYr51v/BGFhf+Q0Gbx4Ddfv/6j4lH2wvV+gs
SW9sglF7fooBc/fXmBuJQyqnkwUmMSCS/3Q4rVX0N4N6LoRTQQn0c80qekT79EEM
/IhbP3r51KzC330ISdsoDaY4n/AKQvE6SOa94e49/MAJtRTZOLisn8wwUFTyolck
sBWmBJEqnI0Q64hUHpacvg7Jt2LAFU2DHU1ygLziKgo1raGSiBpgPUFgs9xZKfBc
PNBjG+cmE/vJxEsEwl3Azxlbce7UKsWxWOG/7EI+kHI468/U0ndS0gnIE8WJ2+W+
ENqek3yYuagKw/spvymaxAuyeXXoSAlfz1oxs34NFQJfje1EQN2DdjFK+1m77bRU
fxk4y7ZpcXavHC42uM7hFe7QI30Db2c0Vfz7G3Cdh4f54kx0Uxk4Meg+jySErlsz
uqgVC9PG
=XDC6
-----END PGP SIGNATURE-----

--+xzd6QPIEfkbqy8i--
