Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75ECE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 18:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51E38909B;
	Wed,  4 Dec 2024 19:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q13Ujm9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889DC89416; Wed,  4 Dec 2024 19:38:12 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED8C8904E
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 19:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8a2d0588bso1401816d6.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733337489; x=1733942289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+SwEyuaDfy4EdEiK9BtcF8UrYpekmj7+PwONB0SvKZE=;
 b=q13Ujm9KfKQgFpX6OBgcDn1pSPsDBcHDTHZ6PZimhdcnKwyT2vrK9Ej6XjjIfDKkI/
 5R+nlPsPuYnNiJTMINe5t43WzmSYjxqkvYIJwGAeyB9CcgsOhiJ+Umv1dQMjpX02tRsj
 Jwp5owpnRE7nqR7VNYV+0nNlF38SJNuPFjr5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337489; x=1733942289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SwEyuaDfy4EdEiK9BtcF8UrYpekmj7+PwONB0SvKZE=;
 b=YyPd6BkgIzycWpyZC2jSs1S3Gvpvp7za3uibSeFmrCYvFALU+IonhSWkLBbu1ZR9Kn
 ps7ik5ENX6Wk18dpQdQqkKMxLcaQFfqOTAy32YpFWB6Sa6pB22qzZjmW9W+wGl3C+Pun
 ePxgoR/aTEC9+yOubcE5mU7hkLa8mBkPPBCIZ0VnZZR3B7vVWuxj0mz08ZJROHlJPLJ6
 O6Jx0jlGT9qfPkJsDR1gvZgxnXUwYAqnVrxWCaRFRKh09woAB4JGMCVvRjy5mysKPOTY
 OYNYIDscp3siiDipObxuoCUWlhy9hINvhbQ6ESpPaF5hLw0ye1YxAY0Ku8WZC+Qk/9f7
 IDlg==
X-Gm-Message-State: AOJu0Ywma+JodBkVQ/n5r9beg6EmKNKFcaNLA/qcOkkW+oAW3oMzK11s
 lLY6SwXkO/drFySLYe2+UpFevUnlFpCRYqOpjkNDRLHb28bbSHK1H9TVqiAmPJGZz12lznUpNHP
 aQj4=
X-Gm-Gg: ASbGncu06rukw0n1/m0O4tCUTaZ4w4n7F1vogC1Gl8mPQXJDJrYm9R3PfgWy1IyEsYG
 QCXmwvIMDRixNldCq/+vrKZgPRYZKFTyjCkcnV6ntG0if63p5AX6Aznk9Y0XeQMBw5Wd5nvYawy
 02rRjEHzW3tQbiMA4sW7zObourVanvTrWjkId7FZY5obeh/27b7hDVY9Mz6x2CmuXJttwbjfBbC
 Ra5uDH6L/nJhFe4c0BHZs3EbqNb3Z9luRbFmAX5hHuoWsS6VQ==
X-Google-Smtp-Source: AGHT+IFE1h0JCPXXaAm8l9o+0vp/3jxZlphrmxW+zpV14Bh0M9LE/7tsVdMsoKbDNeYnPLEB8AMBOw==
X-Received: by 2002:a05:6214:3014:b0:6d8:a091:4f5c with SMTP id
 6a1803df08f44-6d8b742cf9dmr136620956d6.33.1733337488949; 
 Wed, 04 Dec 2024 10:38:08 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d883839882sm67621386d6.13.2024.12.04.10.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:38:08 -0800 (PST)
Date: Wed, 4 Dec 2024 12:38:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: Re: [NEXT] Pull request efi-next-2024-12-04
Message-ID: <20241204183805.GH2457179@bill-the-cat>
References: <08f00178-cbba-44f1-b9d0-170963b31940@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r4BhPE2+yKXPQR1Y"
Content-Disposition: inline
In-Reply-To: <08f00178-cbba-44f1-b9d0-170963b31940@gmx.de>
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


--r4BhPE2+yKXPQR1Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 01:53:16PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit df863c4aa30ee4e624058f64132b7243c6370e=
f5:
>=20
>   Merge tag 'xilinx-for-v2025.04-rc1' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze into next
> (2024-12-03 15:51:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-2024-12-04
>=20
> for you to fetch changes up to 6caec797d5c453ccba5eeb0bc9194c5939094cb4:
>=20
>   efi_selftest: add test for IPv4 Config2 protocol (2024-12-04 12:24:38
> +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23707
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--r4BhPE2+yKXPQR1Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdQoYYACgkQFHw5/5Y0
tyycFgv+JkmD8NliH2B/3BZRYHyZ48N9m49ACTTxGpsZkQKihI/rgAdswGw6LArD
LJPC2VqujvRmCxrv6Ve9oWmcSoX+KKGste6hfw1CBblVxsMRQFxbCr5RYqIIowYv
xmUsYTAVxHv03bSc+gU/uxrEuTGg4zkwz+237rXHY0bhoCYaPJl1d09NPSaHyhnU
4VQwOBjzlbCY8mHBvTNQ7KPuymNLgCBC5jIcMph4/lKV+U7I1mUa+SXk+e2IMO5o
zBzn1NSuijrNu1E8TeZNul4ef2UvQcqNNorGLvuMnLnSyXULofHXKqMBiKXp6hCk
LVzb2cnEb5ZLODINMYNTs8x9spzM3HsY4/8Tjip4elRZyMKZKK5+Bmrbm4Ma08KZ
OZ7R4ITNX98x8OeesBwyr9tDxd2WmQHz5mRCP3/Pt1fufu1Mcodl5rxkBEH9y4CY
Udeu+KrRNYHasGxj8V8ZhpsE4bs7tUDoLzR86qbM+67QTn07asKKYNk1OqFah3kB
3pE3ulIc
=D07H
-----END PGP SIGNATURE-----

--r4BhPE2+yKXPQR1Y--
