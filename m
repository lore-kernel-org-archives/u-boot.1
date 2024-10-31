Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8BED767E9
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 16:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC32588E6B;
	Thu, 31 Oct 2024 17:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lmB1nAC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C971D88E5C; Thu, 31 Oct 2024 17:56:48 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF82892B8
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so7752886d6.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730393804; x=1730998604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gYTRvAXcjNzNjs4HGvBEhOXdNpjysjH0CXH+JRk64b0=;
 b=lmB1nAC18FOSiGTNw8Ak45oTN1Rp64odeuvmpL0hfykdAMKohy0V4sBFBgK3h9xCVZ
 pUQFugiWlrid3CsFgWCXW2WNTp0uEUCr5+5AaTJqbIP7hmKup6spkVjh8hr5IuNYdyRM
 ZQMF3hUUuU+SLfUjrqAiGMCVMAHh6gnDlWFeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730393804; x=1730998604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYTRvAXcjNzNjs4HGvBEhOXdNpjysjH0CXH+JRk64b0=;
 b=nkX1LXtKw30MWCCuRCbIuQ66Npx+0Uxgl45PsbHm3YQ0k5/7fwpzQt/thzz8p1nMls
 8KHYM+a6BjNdfVpgUkxfdUli6nCj3XSLuwm9oTpE5gJtpCfma7KOpwN+Nra46SG614du
 qY3njDAhE6HHQXlTu0wH14WOrKubmkB5Xk9EXdvJZ3FtM4COG0X04SFASwR9W0B95wLm
 Fl1lg1CDu21YmD/UUMxOmSXKc3v7l2dWWWRPBPnfviFFmHKYentYaOMiwAPLumsEUCDj
 UaD6qaK0HoxCaE3IP0Fow0CvfVVY3BvNyaXLQU9BMrW2uw7XVr++4tmpxFXtXxSOR9C4
 QYug==
X-Gm-Message-State: AOJu0YxX0DzUBKeK/ztvqCMXMILCKTN3VXgybyGKrxgrXLF4q8POnRQ3
 Js7HuN9S5mBY4Bspjtum7lEIbz8NlFXOyYlyEz0Wep78qURogQE5JAySXEon09g=
X-Google-Smtp-Source: AGHT+IF56XNG0YHciSdkt1L52FBG9D92MLqIH/NeMrVfssb2QBfUn+lUQGAB6W3rE9DZ00zfOzbEEQ==
X-Received: by 2002:a05:6214:570b:b0:6cb:9a5c:8265 with SMTP id
 6a1803df08f44-6d35c1af7aemr3935056d6.50.1730393804053; 
 Thu, 31 Oct 2024 09:56:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d354188e51sm9429176d6.141.2024.10.31.09.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 09:56:43 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:56:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: Pull request efi-2025-01-rc2
Message-ID: <20241031165640.GU2558755@bill-the-cat>
References: <4a9ac367-e504-4a6f-8614-0084047274ae@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V3xQM3M8OU3+PlhO"
Content-Disposition: inline
In-Reply-To: <4a9ac367-e504-4a6f-8614-0084047274ae@gmx.de>
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


--V3xQM3M8OU3+PlhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 08:01:45AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 5cca0e3f6e0ff17db92476235ea1bb9cd8cbc9=
eb:
>=20
>   Merge tag 'u-boot-imx-master-20241029' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-29 18:46:08
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc2
>=20
> for you to fetch changes up to 7596d77bc1b6be838e38af3fb4e73dbd0a0a078e:
>=20
>   lib: efi_loader: Fix efi_dp_from_mem() calls (2024-10-31 06:05:39 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23113
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--V3xQM3M8OU3+PlhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjtsgACgkQFHw5/5Y0
tyzqzAwAlLVbM+l+xG7/WwbgTjslyOlJ1ahPZt8t69WW98l/pFqKdkclfBKpof0V
GOKnxFMfGUukeVxYvQ7g60XSl3YgixcARyowHPt8BDbJ904ZS6T0oU3eZsi/Ln3N
yvTB9HEdzeFcXiPkB9mRKDwbuUo4GSmleHOToZ/hCufREsL9LCA1prT1JGnHhbRx
W5c8d4qdMKfhOo8qcjgIMlPD8CeEu8xN+qJIsSnJpk6DEOUOgCGZFj3iPSpyUZQo
XCyc2r7yQeh9//ZJ1RNe0k5tuAsN5XTpJyjWJHkP1TJqqDzxrFamt4xPrdcBK+C0
vT866+DHtqsOfbrgTxViGdtS+tI1tpiDbTTSRb0PAiAbK/JNduoOgCMpOY+EEkf6
HVJz0283X+1IFEzINXO30IOPtf6+crrI2vPECJi3JEsIppl+vssj1wwGFx4lrw0E
2x9sa55HSH5JZS/jwA1qR6n+mVww1MEqW92QUj8LVa2cKuzXzrhD/WmFuiwzUxVO
HlTiJfsw
=Ksza
-----END PGP SIGNATURE-----

--V3xQM3M8OU3+PlhO--
