Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0805E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 23:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D28E8056A;
	Sun, 22 Dec 2024 00:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fA4wwu6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55593805FC; Sun, 22 Dec 2024 00:47:09 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F13E80516
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 00:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6fc5bf609so218484585a.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 15:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734824826; x=1735429626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/kOAlspqQa7FQBeusooLIcSgkOSska9DeTP2q/81aZo=;
 b=fA4wwu6dEG1eu+4ZT2VQAAVotSTsuOmhm19XbBfYYjihGVp68Kyh9je/Wfvilt+Xx6
 mMYQv7UTlpI58+GWw+m5NvBJbFKMhpQkZ1ys25m7wJ5AYXIMlD9AVGZ8HunkLYr5rZwf
 fiXQz04XpaA325XDm6bu46uSEFxd3pOuQ1sIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734824826; x=1735429626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kOAlspqQa7FQBeusooLIcSgkOSska9DeTP2q/81aZo=;
 b=rEpTWJdCA0HJgfi0oxweuuDLpk1+3NaBiOE8qbxAN9IkNr4/LsmVTAFJVTkwh5h7fK
 ENp5pHAUXacp9DUp5horoD9ufXccKwjfgs5xW7jPChF/IU5iTrQkl9F2epieqWCRXMMV
 1FVuWzehL0fms45sM0ZvjrZuM76a+HrFbW/KM58L+ciq4Jpq1az8HFjWDQQI10Kt/zfj
 BXpiScoA/M9pnSKtrP+4IrSVFsgBKMFZdiXhmRjpEaKPqyeSYaetSBZNpmfVFta0/D+8
 XveLFkjI3YYARFvILiCg39g8btdcy8jVcZNaGMOqBS5doLHiGPK6GRXmjdVJ8MnEU7tC
 Ty3Q==
X-Gm-Message-State: AOJu0YwBU0ffZ1wSlbFuHizg9nfvqnR1oFH6/hWHp/JoxQzynksto87D
 YODJ944tlgChIYbULtTAHprxcOreor3OF23OkBSsjY9m4thipYHHSV0CyMjed68=
X-Gm-Gg: ASbGncsPZ9r0pgQDUxlSvul03IVUmCqIr6rJOfCEEEgNl2PxmU7oXEURQuBWOjIbYz6
 BRH2lOKjTDYRF9lhkdO6dN1zZAG8FWGNo6874BA88yi2iJAGcJmNSuc9r6/J9dF7UKlnTdcnvA5
 IjtraDBwWplXJVTR57G6CRUNMvOAX4S5kI7ZjXOR2McP4joEh0YM+UmASSob8mFwBHbnSnEk67/
 jOm4u0pwsF+J7wRVcREZM8ryKPUDAoCFro9MnBBXSyfqcd4347yURD08w==
X-Google-Smtp-Source: AGHT+IEGkgmDp9hdI0Yf9AhrL32H0+QjYPs962qxc1FYrWxpr3hCJttbkc/bDdtpEFNNpVsxB66ysg==
X-Received: by 2002:a05:620a:6008:b0:7b6:c2bf:3eeb with SMTP id
 af79cd13be357-7b9ba5efa2fmr1413504885a.0.1734824825929; 
 Sat, 21 Dec 2024 15:47:05 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480943sm258137285a.89.2024.12.21.15.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 15:47:04 -0800 (PST)
Date: Sat, 21 Dec 2024 17:47:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH 01/16] pinctrl: renesas: Add Kconfig symbol for
 conditional build of full PFC tables
Message-ID: <20241221234701.GP1505244@bill-the-cat>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cneT2/dXnDTYvr8d"
Content-Disposition: inline
In-Reply-To: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
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


--cneT2/dXnDTYvr8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 10:34:00PM +0100, Marek Vasut wrote:

> By default the pin multiplexing tables used by U-Boot are reduced
> to keep the size of the bootloader low. This option allows build of
> full pin multiplexing tables the same way they are included in the
> Linux kernel. This includes pin multiplexing options for Audio, CAN,
> CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
> U-Boot driver. This option is disabled by default.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[snip]
> +config PINCTRL_PFC_FULL
> +	bool "Renesas pin control drivers (full size)"
> +	depends on PINCTRL_PFC
> +	default n

The "default n" is the default when there's no default keyword. Please
drop when applying, assuming no other changes are requested, thanks!

--=20
Tom

--cneT2/dXnDTYvr8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdnU3EACgkQFHw5/5Y0
tywOlAv+ONHKvuBxMeon4CokdiDEoeFemGaLrq9xnCkonkxa2pkwxRERlMxcprhm
Rhvx+4xllgImjByWaighrBrTKxmF03/QbpjFF3bf8C+1QS7U/nBjALeGjEnGUpFN
EwzKs6bIF7wzXk58Cc2OH5NbZykc5KNXQq9LW5iatC0ZvII8yRqwtaIWysa4ma+i
9cOCdm3nCRl4b3jW44fvBJ89SPIcDxxcv0Zd9rxZ7s56V/klPasmRxQsSZhyiyNb
K/+p6CbhXQyeoYYqCzLjQ+eZUvLxsUCdMF+hyM6zmIaD5faSWRvhpSLhd0C3Y+a6
HHK3QPE7IAsmS/EFvtbFjPLM3WV8wq9/1cFun0WREGD0Wh48VmnyBZGBmg0WtarC
Qackx/44l25qTRXTNZ2IMjKqdSRSln7LOZMg8J5mmJKs2HIQW8muWWC+EfhIDK6s
7sHiwLD44xtDhb0vzRF8c21+28ovE1EFgZwVR+Iu9Cw86h+F4juHq8xEMlwbsntt
k6qvrLXf
=3hBF
-----END PGP SIGNATURE-----

--cneT2/dXnDTYvr8d--
