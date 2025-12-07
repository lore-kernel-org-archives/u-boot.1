Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BB6D1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 13:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A940A83A2D;
	Sun,  7 Dec 2025 14:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FPdkLraR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF7383A5B; Sun,  7 Dec 2025 14:59:42 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D26C800AD
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 14:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e7f68df436so2517141fac.1
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 05:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765115979; x=1765720779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T288ZfF5sY/onDJED7jipCf3HyCwhv5rdl00r5OEbwY=;
 b=FPdkLraR8BxeSCmupBTKMPM6PmUC3nNb1EUFmc2ZlJ+yJarx9peLLgQpN1QRm5TR1P
 2P64nRbxyQLJlqcEShQIAd2TqB2vM/EoqylvEmul3fEhBi5ZHuPjVfTSsJS2dLyjFqk4
 y3AGfWELr7jmHEctHNtNaGNKgKgAWFl1DdSl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765115979; x=1765720779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T288ZfF5sY/onDJED7jipCf3HyCwhv5rdl00r5OEbwY=;
 b=EoVNnAZ19AuyejIhqiKKkzcL/KXWCtnkGZpwGXjjysg3vmTH5pBBFIWGvFtB3K55p/
 hce+cJgnMz8Xj471TeezIETzJQJ0ou6/Gj0mS+aKQ+rJ86iKsYDFv3ukg5GqaNx7tYha
 YgGN3jOf7Na42ggTokg32VfcEfDlOu3kMVeGKYoLeSlQy/bGgzHUD9H6AHybrAfby/FY
 3Rmv1VEioaPP8Kg04d40FDL8vgOCYRGT2EGiiapPikbXSTuSSpYRd3Tw8FdhYYIvvbEk
 Xbnw6kMUebNkUIIzGvUjJvF+kx0uDSPlwUMPT0J4fpJ0Z4ZGQuLqiLN2UU1LIPLvj+ru
 cI/w==
X-Gm-Message-State: AOJu0YyFF3/EYComgkr47isYDC+uSzGYiiE/oHNnkZJN9zjs9IZo9eZl
 WOK4AmQ/K3r1LZVSdn0VreN4lRqUGUHTnw9lZ0a8IYKKBaAwxaDUMn+1wO32QJLgTt8=
X-Gm-Gg: ASbGncuqARC7JY5AO+ibLcObPDf9Bn9AbuSNNhgUqaG3g3HsYMiWu/8HX6De4jR9EnL
 9TFjI9UGqq3guXYXessG7WeL0LZHXaGb/fbJ7TAS8kh292Z0gSMThlYNoAJqUPhUOBUEvbNsDbg
 C7dZZV1d6ULsXk1GLyTUbjbh14MFsJ1bM6kmhov5jFEAd/4XscvVN/STl1sEFIM1KeznhBYv4rd
 LXUGaNT5DhtFceYD0lllRsBOudA6aLbTWGo4PNrG6imYnepszWsrcZ5QJdPCcLvHL7YpO4UJ1Cr
 F+BsTD1GyXyGlk2SqgBgEdJUbAFCm4z7o5KY1pj7oRXfWUoF2qE8vV5ixWxpc/UIoBkQJRYnVEc
 4et4fyOYMYrxBRWXtwZdDTg/upQEfs2zIhkoENQjfLvQ7y9AEG1DLQBmNxXeLMEeNalP8ooiZxs
 Xz3eT0Hm6w1rLM74KSFURPteE6CyYYLz+yPzhzMBJpRNElDpxFYA==
X-Google-Smtp-Source: AGHT+IG3KSduO6F7yOhqkcUk0qKj0D8UXayaFH9qoztJ7L+fIwTqzA2FRkQ8NCY4LIme/grZaXAtQg==
X-Received: by 2002:a05:6871:4c8:b0:3e8:4730:bcb4 with SMTP id
 586e51a60fabf-3f541d66f12mr2412842fac.1.1765115979070; 
 Sun, 07 Dec 2025 05:59:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50b512417sm7263628fac.14.2025.12.07.05.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 05:59:38 -0800 (PST)
Date: Sun, 7 Dec 2025 07:59:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Update urllib3 version for building
Message-ID: <20251207135935.GN303283@bill-the-cat>
References: <20251206165034.2621363-1-trini@konsulko.com>
 <0DC1498F-9066-41E1-9B9D-CE45CC9F4849@gmx.de>
 <6879b570-57d0-4dd3-8c6a-29f15e830fe1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xO2P1gM4Hja17W71"
Content-Disposition: inline
In-Reply-To: <6879b570-57d0-4dd3-8c6a-29f15e830fe1@gmx.de>
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


--xO2P1gM4Hja17W71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 07, 2025 at 10:06:06AM +0100, Heinrich Schuchardt wrote:
> On 12/7/25 08:17, Heinrich Schuchardt wrote:
> > Am 6. Dezember 2025 17:50:34 MEZ schrieb Tom Rini <trini@konsulko.com>:
> > > The GitHub dependabot tool has reported two "high" priority bugs with
> > > this package. Update to the patched version.
> > >=20
> > > Reported-by: GitHub dependabot
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > ---
> > > doc/sphinx/requirements.txt | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> > > index 8572c15ef68f..dd433e2bb156 100644
> > > --- a/doc/sphinx/requirements.txt
> > > +++ b/doc/sphinx/requirements.txt
> > > @@ -24,4 +24,4 @@ sphinxcontrib-jquery=3D=3D4.1
> > > sphinxcontrib-jsmath=3D=3D1.0.1
> > > sphinxcontrib-qthelp=3D=3D2.0.0
> > > sphinxcontrib-serializinghtml=3D=3D2.0.0
> > > -urllib3=3D=3D2.5.0
> > > +urllib3=3D=3D2.6.0
> >=20
> > Please, add a reference to CVE-2025-66418 to the commit message before =
applying.
>=20
> The other CVE is CVE-2025-66471. Both CVEs are related to excessive resou=
rce
> consumption caused by downloading from malicious URLs.

Neither were listed on the github page at the time, frustratingly.

--=20
Tom

--xO2P1gM4Hja17W71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTWIPAAKCRAr4qD1Cr/k
Cu8vAP94ZiMt/rQnk5z/JCYU+WwrTa4ZNxw/IxXiTN23Se+NygD9EX+Yxex0UbCB
rr2zBpL+meks5MaROWqeWdWPyAd3JQE=
=E2Mv
-----END PGP SIGNATURE-----

--xO2P1gM4Hja17W71--
