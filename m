Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38AFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2E787A23;
	Mon, 30 Oct 2023 22:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BIkZnc40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A594879FD; Mon, 30 Oct 2023 22:36:03 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E08787AC4
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7789a4c01easo342406085a.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701759; x=1699306559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxCGGYW1BSJzWHNzQUE0eBv1CfhNi7r+bBpFLWINlqI=;
 b=BIkZnc40Yje7VIUukCz7obaHm42drwSwqlKITuWNFQj1YR1XWeqN2iaKFF2KLgjz1H
 QwiLiDivQzEr3djANQ1sMetSnhgbEB2mQKkBLlV+3J3YnZ4kZevsmjUj25gGPlhFqHrt
 DDiTY+iWwUElvZSMVBzMPAkHSY+3RcNmFRRLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701759; x=1699306559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxCGGYW1BSJzWHNzQUE0eBv1CfhNi7r+bBpFLWINlqI=;
 b=JSAtup909FRUDfv3+SBRQbnVfpDcjyrFvXxKn8co5emnBIdrT2JcTrpoCxf3zqq5Oz
 u98D39W30vkffXURPsZ/YRusUcE1KtZvHtHaknqionYDb9rOsCRkIzgn6Fmg1m7GH5I4
 93PsE8GwME0TYb0IRHInA4/ODnll+eojFt8NSUMHnQi7UMyGQMpzlht6G4sihgUwShye
 aJ6kObkA37d3Ck1zO5o2hzypoPooxiJyT0KO/p/IV7TEcOpxCNccNvVqchb/N0jInjV4
 U08ModhpcDhJeNidMd2V8+bPrAwigL7JcKIdb1uYSadfwFay/qeVWpvJ31e21YdEVl/P
 94ZQ==
X-Gm-Message-State: AOJu0YwYig3uycjJNEnfTDyfgB9c7MraXQZWFfJCu0WHQcjQXIPRRzTY
 vXJJkm/PL85I3rmb+z4oKR0+H7pWCI/00sCpimw8vQ==
X-Google-Smtp-Source: AGHT+IGVnpNY5yCymUZyXjYICtYuGUIbmNoWaIZS3GU82BV3ha74uBtMrgKw22Fw5CfmpcP6x7y+FA==
X-Received: by 2002:a05:620a:488d:b0:775:93aa:cb91 with SMTP id
 ea13-20020a05620a488d00b0077593aacb91mr10945002qkb.35.1698701759144; 
 Mon, 30 Oct 2023 14:35:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 m18-20020ae9e012000000b0076eee688a95sm3702751qkk.0.2023.10.30.14.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:35:58 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:35:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de, xueliang.zhong@arm.com
Subject: Re: [PATCH] arm_ffa: fix: remove deadcode in ffa_print_error_log()
Message-ID: <20231030213556.GC496310@bill-the-cat>
References: <20231020115747.GA141285@e130802.arm.com>
 <20231020131533.239591-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pBePY+5KhysEaU2k"
Content-Disposition: inline
In-Reply-To: <20231020131533.239591-1-abdellatif.elkhlifi@arm.com>
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


--pBePY+5KhysEaU2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 02:15:33PM +0100, Abdellatif El Khlifi wrote:

> address the CID 464361 Control flow issues [1]
>=20
> [1]: https://lore.kernel.org/all/20230821210927.GL3953269@bill-the-cat/
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--pBePY+5KhysEaU2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIbwACgkQFHw5/5Y0
tyyb5gv/Y8P3ORyhZX8cM5UM6K2w1ERHw9aMYyhPqzWQsExL9NiEFg+aiXd4SX+9
KlVRFTg4He4u1h1pV0OcB9WpV1ajBxar38978f4wUc4JvrZeS5Z4GQv86nUaUAXH
07BIdvaSwFnq3eRm2N/3oDOh7WsBr5Z+pl/otLMjoG/dmas18+bdc1hIDBRbzFs6
nlE/pq67ioQpueZ+Eb1CIdLATwE7VOAAj4d+Dg0xXg1TxRfAh0gT/CskycXiSy1+
VjjoHXdeC6E5b++FyiQU0zhHDxMQ3vKQvZEl1ovwRbeNAEKi4YRfSF0rxDXb4GZr
SCktJcepQWgHoLWgnY/p2XGHLeSOBeUdpcr76HtnfSUTfMBvhX42NKO7kpB6Hphf
aoQTRUjIdoFfZLRMp0CgpjLP6lfuH+1CMQwMEBm+V4+TPMvWDDHAxPTzKDd0nKCu
SdPHNL/1Jd3AC1ebHdcmMEhwecnTLUvuscOFFcgD4ddo7ZP2zBewIIWDZ4CSo/pk
Gwiaa5fB
=s7cB
-----END PGP SIGNATURE-----

--pBePY+5KhysEaU2k--
