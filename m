Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F89C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C3D87D83;
	Mon, 18 Mar 2024 13:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WMeBWGOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B214A87D83; Mon, 18 Mar 2024 13:28:47 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF3287D1D
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-789e2bf854dso153484485a.3
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710764924; x=1711369724; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mUAvDvcysuwTigX04qxlrTO39wWWPLQykIFq+d3dMAQ=;
 b=WMeBWGOhEL6aLLOOgobctB9sufCZN+3ENqewjFCjeJiURHhkPtWIJweJWqYpjtAbbL
 Kya8ZIT55CvjKgPy4bTY/p7S7OI+EXwO4hV7n1E7ojv8fpLo2K5y8Zz6tGwTs5JAdTFP
 V+uhOwRMKvCToeIumleuMXMXzfuJdTk0UCjOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710764924; x=1711369724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUAvDvcysuwTigX04qxlrTO39wWWPLQykIFq+d3dMAQ=;
 b=QDE6qYoNrtfIC8BqkzdjfoprI+3a9ZPJeljtbfsO7DO3tXoizcRHnnDvDgZjCcZ6q2
 bojCtlPsEZMjuM/W5le7J++5u5zSlzxjy4CeQl/Q2oWOWN3LyPoWP5LU4JfzX526fm0M
 CvKc/apDlJoiyv52A3JC2NB4LspmKw7gkbV+CVC+luGAAH33OeNorzljwqTJa1BXjIWV
 w3VnveJMftJRAjYk5ApWtGjzMP0dvqrR3sfythx02fZ7QGvhqp+YzeWYcmTPlbMe77Hu
 6T4s/AeeH1CGn1AweqOD1ZsdGSVvEZeQJdrLjGyed37n/mRZA59oTYAReH8qM7UQe/SC
 aVvQ==
X-Gm-Message-State: AOJu0Yz+k53kjo6YQ8RYTK9QCM/7OaEEIVFAG87bdoRtC/6ZKD23M82G
 YTqSS98GdCjebDFrVsyvjwQraWm4kctjRFxV1MSlTNPoN+t0CI8IBzzVjZeDyFA=
X-Google-Smtp-Source: AGHT+IHq3Td0gyPeOoWv57boIc7LgEOKD64qIyb14r7YEZg++MpCdpLpG4+yl1OSKQECuXlybAv2uA==
X-Received: by 2002:a05:620a:1035:b0:789:e93c:eeb0 with SMTP id
 a21-20020a05620a103500b00789e93ceeb0mr8297575qkk.30.1710764924064; 
 Mon, 18 Mar 2024 05:28:44 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a37db01000000b0078a07fc259csm292688qki.40.2024.03.18.05.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 05:28:43 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:28:40 -0400
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Vasut, Marek" <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Lau, Wan Yee" <wan.yee.lau@intel.com>
Subject: Re: Pull Request: SoCFPGA changes for efi-2024-04-rc5
Message-ID: <20240318122840.GB3442575@bill-the-cat>
References: <DM8PR11MB5592FA8A7E0B0164296FD4ECD22D2@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FFi2h77jPjyJN46F"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5592FA8A7E0B0164296FD4ECD22D2@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--FFi2h77jPjyJN46F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 07:17:24AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for master from u-boot-socfpga, thanks.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef4=
96:
>=20
>   Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-03-13 20:39:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git 386fca68960=
994ece0d9da8a69a14495b5f1aedf
>=20
> for you to fetch changes up to 386fca68960994ece0d9da8a69a14495b5f1aedf:
>=20
>   arch: arm: Agilex5 enablement (2024-03-18 14:45:47 +0800)
>=20
> ----------------------------------------------------------------
> Jit Loon Lim (1):
>       arch: arm: Agilex5 enablement
>=20
> Wan Yee Lau (1):
>       drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA

Please rebase this on top of the current next branch, and use a tag
rather than commit hash for me to pull. A short summary of the changes,
either in the tag or pull request email itself would be appreciated as
well. Thanks.

--=20
Tom

--FFi2h77jPjyJN46F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX4M3gACgkQFHw5/5Y0
tyzYQQwAi2D4L1M17x2dlB5gkyx5yJ99jQ8rtO+NcWalAyqSEH7Mt/BG2is7JUL6
8sMnfpMv9gQHozhkjjo34ruK9RQ1eLjrjJNUJnKyNJ7jnkU38S4g4zmpmlId7K1D
nkyTMJHLlNeUqV0WhRmWvdKfWyBrSTReWxHdoPmcdLRfNm+gTGjlvOmZ4xfgebJy
yQc5EZjsr4fWwEwq3HTvwFFZKKIirkU/LOuwOwEYijX+iG1Pyxo648qcML2wnDze
guSsoeLv7Y0n5A59jteOQjV8K2LJcmnwNBZ4cVoNZJ12RlZY5IQCELOrtbYaKVSE
TW8sFucVR4JF/FjvEJwcSv6Zp0wXBc1VqntPl8IjbwFpHLZ37nus0xR8xCsIGDHi
bBuTPczQGj++pnwE4iwWsKVeIDOdf84mNnBWgW4tOQ8JdLDaqs0SSBoVl+9YDJwv
FwHNHl/zlarb9ywsoyJqaUDzGDZdDUVUiP62zVpSA5G6jdxoy5IcpLp8MGVYvimT
Au9nMdG8
=H0G6
-----END PGP SIGNATURE-----

--FFi2h77jPjyJN46F--
