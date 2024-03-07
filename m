Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B5C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 12:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DB287DF6;
	Thu,  7 Mar 2024 13:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AWhkHctj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D248187DED; Thu,  7 Mar 2024 13:41:32 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD6F87DF8
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 13:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42ee7fa077bso3301791cf.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709815289; x=1710420089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i4xQ++4CUuC7+LoO6IP4vGRl+BLgjDEY4qr5E2PzgS0=;
 b=AWhkHctj0oG8UBAMxdsYodBRPIWgDC7YjyKGpDA1iKDC9zN5ZpP6jIhzeOeylzMAvb
 4dZu96hQE8Kn6cKMuIKq6n42mVXvgyp1zkgVBSDUTNLXqH1KBoznq42PyCxn8o5se0oc
 HwukhZqp1jYHLJhE9CWshHSSwwMsfQgmxpmck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709815289; x=1710420089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4xQ++4CUuC7+LoO6IP4vGRl+BLgjDEY4qr5E2PzgS0=;
 b=KujcaXS8JVfSDLioCKduFp2Lzd3DErmgD5TgjDxSCMeKjAmyeXXN+z6c8ZF8+C6CiA
 VZNFmLVJ0riVRraAH5yw8gFf4gEG9slITFQBxSy4n4uu2iZColPpedgpMP26/BAHx1iD
 zoi/kkBAtcHzEVBGx+xdx7i17lCqtS1X3Dvkj800TH8P14Chp//j41DYDWY/5np5+52N
 ftokksYhBp4mXwWg8E9jYF441znVRixwnbQlirU4Nn/1rQp0HVGdK1bU1b9rbPvDpqGh
 QqGtWQKvj0vIkOcZjCzjRljWCDE2n4rDeiskbkCJAn6ESYtTNIIe/S9DPGVEVQlg56DM
 gRgg==
X-Gm-Message-State: AOJu0YyBORf/XlycU6wyNqcb6i6s61wdmZog5KYAt6oGObNYTtJSqtwY
 B6A5Vp5pLtyPMqY+1IfDDy0Vcwi3NecWpijlqja6+CqpjViJH5p7RQIr5FqneKU=
X-Google-Smtp-Source: AGHT+IGbEz4edmhjM0w+K01dMC/7CGd6qxkxtF+Nfv/MK+Mri7FeMuXw6TQjDR4asB/kbC1K2kK5AQ==
X-Received: by 2002:a05:622a:1451:b0:42e:b842:751d with SMTP id
 v17-20020a05622a145100b0042eb842751dmr9456893qtx.22.1709815289017; 
 Thu, 07 Mar 2024 04:41:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 s22-20020a05622a1a9600b0042eda5f783esm5518345qtc.77.2024.03.07.04.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:41:28 -0800 (PST)
Date: Thu, 7 Mar 2024 07:41:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH v4] cmd: add FDT setup for bootelf by flag
Message-ID: <20240307124126.GA4077069@bill-the-cat>
References: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Trm30ZWyNjZZkmW+"
Content-Disposition: inline
In-Reply-To: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
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


--Trm30ZWyNjZZkmW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:35:53PM +0300, Maxim Moskalets wrote:

> From: Maxim Moskalets <maximmosk4@gmail.com>
>=20
> Added the ability to use FDT for ELF applications, required to run some
> OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for
> bootelf command.
>=20
> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
>=20
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  cmd/elf.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

This breaks building on a number of platforms such as
xilinx_zynqmp_mini_nand_single.

--=20
Tom

--Trm30ZWyNjZZkmW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXptfAACgkQFHw5/5Y0
tyxgfwv8DuDCWTot1f2+2m7KgKLdShYHifwtSREsk4jtQTEuEIuFCURYcHqtF9TL
jsBRCY3kvn68RfIyjAfEMX0ZqWaIeIRM+cBCI9U5Rzs9xTM8o4ElhwD4pJMBxaBj
dQL7OeGyRlaJWeQyAt6UkSCSQsDa7hsgAGa/ufArooviwWuY+Z7WkEin2Za4yNMz
SO2bJFgzBjZftypXd0UsEAN4jghf1N0xSiSOTjhVV4zsBTV/+SOgbReNGHe3ThNo
D1IfSB8N0VSwzl6PFs21gRgOo/x5114gory1Wlj21M+xCkDROOeE+4zCHQmsOKdB
neoi8+MSJ09PzIV+I9TXanNsByJBxecBK80MeqPjXid+LJdUJPSV9ifSD4FdHIiD
BbFB5rSky4LBWeD0fPCNCwKAlgl15qObb6N2CY6x6nFuVvG0YC1Ij7zzUxyh1Ean
y4shSe36IF7oysjLYzODlZVLYlbxI+ZNtDeF7IxIBhyC/wTeIS1VQIdCtj4jz8Q9
lK8ELYic
=/SNo
-----END PGP SIGNATURE-----

--Trm30ZWyNjZZkmW+--
