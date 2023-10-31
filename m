Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090EEC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCD886E9E;
	Tue, 31 Oct 2023 14:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N0j5zSPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C17686E9E; Tue, 31 Oct 2023 14:06:34 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509CD86CF2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7789a4c01easo379537085a.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698757590; x=1699362390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk0lA7XDwS28Uqc7WbRk7UN3guBrypVuJMchuwy07cg=;
 b=N0j5zSPq5IltEcufRSn+Gn3xxe50yxodtdlnwgtkk9lr5TmQgqF9CUcrNRFNS93+K7
 FEh5mascbPBHHWmCZgOBPUptcG+ElgnZOcubMKz1Ft32lo19RFmNiKOolbq9kZyMI8OY
 xg6TzVKhLIOlOFcJ60WJaVCWih+/GEO0F3FTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698757590; x=1699362390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk0lA7XDwS28Uqc7WbRk7UN3guBrypVuJMchuwy07cg=;
 b=TBVzK+HpYf88hTZQfTXLk20UI2CPIeMnZAkKnqmMP2lvb6jsJiwZAoIm4OcdPHkoTC
 HYZ74zAeI6gs76cSHCuRNwNDdjyxWXNo21Ln+t3TYoIwhOYmA4KbZlY3D2P4tGk2+Gsp
 UONw3hcmownHlk9gvrOjb2nrlYn3EVLPawp8HjIzEOm23RA7HDHlOEr/1Yh0GuGNI2TG
 qIBTig4+q4ALT4yipmz25GWQBHnSsiDdADVxUFzBT1TzQttjfu4vdXAhzIgMeZSSNAV/
 Bf3k/phXBqu0CvrCIod3Tl7UDV4/YiBCvyvTegr4DXORNiXChtFsrHgpnieWKPc8Mn3t
 OxuQ==
X-Gm-Message-State: AOJu0YxCPjXGrtiX8tcj0L/EX8iMlAS8Zurh9SY9CNE29PVjOJofmcRf
 JnJlsssx1QRZabdNt/wH89NwOw==
X-Google-Smtp-Source: AGHT+IER3vF6XNU6LxwhAkbaA7hCFqJNxttXnAI/B1WLwumlPcrmYGvnzsW7Ywais5HLgFTC81rD7w==
X-Received: by 2002:a05:620a:8404:b0:76f:456:3916 with SMTP id
 pc4-20020a05620a840400b0076f04563916mr11312590qkn.43.1698757590001; 
 Tue, 31 Oct 2023 06:06:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05620a12d100b0077412ca0ae1sm478672qkl.65.2023.10.31.06.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:06:29 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:06:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v2] test/py: net: Add a TFTP put test
Message-ID: <20231031130627.GJ496310@bill-the-cat>
References: <cee2db4bbaf9656499f7f7dbf29b1b6738822d1a.1698756564.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gzFCjPmX9Q59SGfV"
Content-Disposition: inline
In-Reply-To: <cee2db4bbaf9656499f7f7dbf29b1b6738822d1a.1698756564.git.love.kumar@amd.com>
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


--gzFCjPmX9Q59SGfV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:22:29PM +0530, Love Kumar wrote:

> Execute tftpput command for uploading files to a server and validate its
> size & CRC32.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
> - Add marking for cmd_tftpput config
> ---
>  test/py/tests/test_net.py | 72 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
[snip]
> +    fnu =3D "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), =
fn])
[snip]
> +            "tftpput $fileaddr $filesize $serverip:%s" % (fnu)

I think we need to have the filename to upload as be part of the board
env as well, otherwise this is going to fill up the tftpserver over
time. I use a 1MiB file and that times boards times number of iterations
I end up doing means I'll start noticing in a few months that I've got
less free space than I expected in that format.

--=20
Tom

--gzFCjPmX9Q59SGfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVA+9MACgkQFHw5/5Y0
tyyX3AwAsn1y9mZSaGByflBagO+z4GNMDgREILt53k8TBum4Y6+PLWHh/VrojWgm
Sd89RmTtlSE3eN6IEWBAmRb4l8zuwWIepuJ8KMmKBF/wGGGggt/53+mLWPlyDzkl
AG5v7ptUnCwX5ZP8tXvIHJI42GLm7WqVC19c08ELCU/rGkjAQHvOA8N++EBmCTxl
2OIXyxjkG+UsdjAXE3OzTMnnKtjockJtT9yYrIUsih3QjWGZI+CM3Wk0X69C3Qhb
bx3MGyutj/HICVo4vhn95EdW+EX9zT+oqX7h7qOUMrF6ySzWr5H39XXBp7Yy2bmH
yDmFH8VLpd8cWHdFEC+YE4ltos5orhH2/VMHEY53ofAxhubto4zLw5u8bUVXC/Su
6GJIYhQlvygbtUozBrgDIQTFDznIPbnDLpShU+shAj4RuP37YaqKsKjNrYaHVJfR
l6umk8gqywECfx655hGakc7td6+BZF/AhCwwKHl5wJDdCvTcX3zmHC4xP/PKozcI
x/77QzjC
=9Wga
-----END PGP SIGNATURE-----

--gzFCjPmX9Q59SGfV--
