Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED82C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 609AE87501;
	Fri, 17 Nov 2023 14:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JXsGW8XA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9E9874E4; Fri, 17 Nov 2023 14:41:55 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E39874F6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d190a8f87so10205636d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228509; x=1700833309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F2J4LQfr3vnVkK43eS2S4hfRGmCYQls8wkL69DMmwQM=;
 b=JXsGW8XAHnmcZ0Bh/WB+P+dP61BQ55a2qMnEL4WpDzYPogVNCLs844eYWeblhNe0tX
 GHnjZZQHe04MRXHogaLZnPpc+M7/j+snTPJIVfXEWvX8bpdTRyKyUvoDToep/trrHye4
 LMyjDUa7QRQaWUmk6fjudosmeDzJEhclUDsrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228509; x=1700833309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2J4LQfr3vnVkK43eS2S4hfRGmCYQls8wkL69DMmwQM=;
 b=hnHVa2F3Qj27biBABIa+eMPpiBy2xVWm2wXS7HrH+OEouG6nCJyMnxTEvML1tOGW/I
 K8bIXi1urSe0OFjf41xDfvZOllXSARSjKQP9st/fAH8cYbfJl6lkBjnBNbDvxRN8GmjN
 idg7RdAF9C/oJnmv7bsEhuHZSWPUNmURd2Pfk9zIZn04hlm2ZZPWmAvgz+xJHKNhIHET
 ptSkoEiChoiGctYTGEV/S+Va96pRjW4+6mXaJ/R8BjR/qINEkWaiirAcZQPArDeR/MRu
 FR/TTjo5ES7iFIsewtDxyAv9jMRcfjDGsU+H5qOt5RpX3OYt9Ca4DdB+ifIpe1idFfPz
 ks2w==
X-Gm-Message-State: AOJu0Ywoz08652w+9sMW2dU1UBGgqqG16DEkdu9BBoQhlj0pM2s39x1Q
 7EBYapYNBEtSE7QJrGWme5SSiA==
X-Google-Smtp-Source: AGHT+IEb3L9ifHCZ9jQOtG3igDhruWR4uK+jKV0zNi5Zh7yN5T1k7DCFqrNwky5iMBtdDAO5bNo7tw==
X-Received: by 2002:a05:6214:2b46:b0:671:b379:525e with SMTP id
 jy6-20020a0562142b4600b00671b379525emr12710817qvb.32.1700228508986; 
 Fri, 17 Nov 2023 05:41:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 di6-20020ad458e6000000b0066d1d2242desm630263qvb.120.2023.11.17.05.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:48 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fs: btrfs: fix reading when length specified
Message-ID: <20231117134146.GR170968@bill-the-cat>
References: <20231111151904.149009-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t/i/c43drBOURaNZ"
Content-Disposition: inline
In-Reply-To: <20231111151904.149009-1-CFSworks@gmail.com>
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


--t/i/c43drBOURaNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 08:19:04AM -0700, Sam Edwards wrote:

> The btrfs read function limits the read length to ensure that it
> and the read offset do not together exceed the size of the file.
> However, this size was only being queried if the read length was
> passed a value of zero (meaning "whole file"), and the size is
> defaulted to 0 otherwise. This means the clamp will just zero out
> the length if one is specified, preventing reading of the file.
>=20
> Fix this by checking the file size unconditionally, and unifying
> the default length and clamping logic as a single range check instead.
>=20
> This bug was discovered when trying to boot Linux with initrd=3D via
> 'bootefi' from a btrfs partition. The EFI stub entered an infinite
> loop of zero-length reads while trying to read the initrd, and the
> boot process stalled indefinitely.
>=20
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/next, thanks!

--=20
Tom

--t/i/c43drBOURaNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbZoACgkQFHw5/5Y0
tyw7awwAmU+2x/rZl4O8K6XGyw8xiYdJSdjBTTEZgpVsy68pXLgmiu6N6Xp0UwKH
z1lv83Kbdp9p3TJSTXcyW7bH9H7GVaRAbWzul5zX05k2cHs27+9zHPBdVaJl/heS
Hceb40C7niCnvxavmCNo17IMJli9nWyhT93eDQ2qRdNuQAJV0aGHYh8Aw6CDK1FG
Z80vshSGkKGtA9lkAGbs/brzKtKVB4k4VUvfo7XJIbt0LGqCUCaBuzfMATAZ30Z4
H7rxnsSUdj/nJVKSMDgwQ3Mn8Re3c/88cQsa7WtPjrCFKhiXS5TqG3EIYQGz+6Gp
nu1Yq2otsS1D+h09pyet7Uvv9Ote5IWgNOaH1gCmLZlMUWcQGo5nIWYGl69hU21c
SUId0YeSTREw7AsY5HqEioLmEIGKO1h/5SCTXw2HcYbd1PcElxZmbNxL6eKNBsT6
hJ3MRIK/wqlP3MySp/frXnkjRA8th6Nq6mkxqMqRIq4lzZJQWLNwnLkacVnfNLLx
ykLJk3Ms
=OSoN
-----END PGP SIGNATURE-----

--t/i/c43drBOURaNZ--
