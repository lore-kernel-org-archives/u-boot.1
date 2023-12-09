Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5CDC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20FD8761B;
	Sat,  9 Dec 2023 14:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TA240dTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF9C8763A; Sat,  9 Dec 2023 14:53:29 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E148759F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d74186170fso25242697b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702130006; x=1702734806; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kn/fNsIbxc+/IJqetBJo1R0Zfl4eL9IQPZKqlmNmdwI=;
 b=TA240dTQzUBF1vsPO9bDIPs/nWJPJyRrbIgyCCX6DUac6AWQv0pI4A4hMLEUn0D446
 zTc0CtBZ849cWAERgFFL1mZ62+pzRBw+W/yYQIhOJYk6mtDAoIFsrk2Bo1Y8M3OR7Su7
 mPMClzyyUHABQInkhKrfp61TBP4r/vZjQ7wrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702130006; x=1702734806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn/fNsIbxc+/IJqetBJo1R0Zfl4eL9IQPZKqlmNmdwI=;
 b=gU2um/45yJJMQ9opAKyTlvKHI0YIttECc1RPEcqCmONAO0TJDKrqBwT7229nJqKOU9
 6JkSTJ8TNwVt1pGju4E+OivZmHW3mCJYe6lSUx8nqSA+jug4U+nPAyKJ/KcXz6lsWGHw
 S/NoDOlw2zRDHwe0PcEiNk83oxD6a3CKqw8Ncsk2i5x+ArcnNZiSN6xp6fcEpulx91/q
 QYOX9tuioKLzMLHBXj6HMAJQwzChcy3xB+Yu/SMS4D6Q4KIAX6cDmuSM/NtLLbWmNrSz
 +kqPe18xsSBhPobmItU1lipaqZWDPzF6EsgJ+kS27t5NDZc88oJ+8hUokAEDkpGqv2qV
 /8Ww==
X-Gm-Message-State: AOJu0YznNHeFhaw/pmRa+WJFQ8JmFmAkiBHu9jXZdHJbD6UD3U+AFnc9
 w90GjY//Fya9eOec7JbIyFiwDGMGFSMEpilp2LrhLw==
X-Google-Smtp-Source: AGHT+IGgC0qwt+xm6VBuZyOjKXUv0HkMFueyqt9cZ3udD6AfeQpARA9f575Yffj230r/cacNBQcM9A==
X-Received: by 2002:a81:8447:0:b0:5d3:7ee5:d0db with SMTP id
 u68-20020a818447000000b005d37ee5d0dbmr989836ywf.20.1702130006156; 
 Sat, 09 Dec 2023 05:53:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a0de205000000b005d37278f973sm1475973ywe.36.2023.12.09.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 05:53:25 -0800 (PST)
Date: Sat, 9 Dec 2023 08:53:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-gitdm PATCH 1/2] Use Google LLC for Google
Message-ID: <20231209135324.GA3191433@bill-the-cat>
References: <20231203044719.667116-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dx2vmU3j3osS3X3J"
Content-Disposition: inline
In-Reply-To: <20231203044719.667116-1-sjg@chromium.org>
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


--dx2vmU3j3osS3X3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 09:46:57PM -0700, Simon Glass wrote:

> The name changed a few years ago, so update it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to gitdm/u-boot, thanks! Do you want me to do a quick search and
replace on the stats pages since v2017.10 onward or just for future
releases?

--=20
Tom

--dx2vmU3j3osS3X3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0cVMACgkQFHw5/5Y0
tyyTCgwAth+epMsPB7G+GCcxgNEHkufTXEXq+hWYKleB3UU0FeCO9DTOowqelMHO
bSOk7vPmnM3oSl2qadgwiC+y+wvlQ25oQKLwkZ2AoJyS6rFhkS5ma1M14GZc9zkT
yjdnSz7AwvOh+sMufwVilM5NdZgBcL+bPgQakync70ngR+mOkZCGOHM+3lYyRJwC
3Qd0Cm4r4/kIipGvkFO3svFMD/vaBLCqR/r/XsQ0gMAVjIx+2XADBUWuj+3g4Trb
Ttv/PUCQOJQXFAvAde4tFERNkEhxEUMSPdFzF+Kbf/Wn8bfL+hsS22oe2GmOZn3F
tKlm5Pj6iga9cVhfubxFMxL3VPYd3R9VmR6Nrvs0fY7i7Ac4nWkdYETDkUxsKpdh
h9eXI9vEuzP7cwh1MOqNQQGYmic5VO0vkhOfxOhpGVi47Tml4v64xd3QkxtdpljB
87TvF/TIDFa0zZzg/Civg9eT+mxyfmDuOoCGJrVba7WmwpAGHzYiWXnkxSDK6jUk
zhUUfbWO
=dVOX
-----END PGP SIGNATURE-----

--dx2vmU3j3osS3X3J--
