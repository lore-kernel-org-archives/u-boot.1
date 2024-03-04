Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C9C54E55
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF43888009;
	Mon,  4 Mar 2024 16:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iJZ2H5Ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B02E86FCE; Mon,  4 Mar 2024 16:27:54 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B2888039
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-429f53f0b0bso33676421cf.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566071; x=1710170871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1VjkKqgGdIkwWXnwjL8on9B4pXcGZv/0z8EtzvC4Cb4=;
 b=iJZ2H5RoxfPxMBw5CmlnFist1WYkoJUJF8sh1h64Yl/UFEo/640EOVL6iLwtCW2fUF
 /E+BpFGB8XN71/BL0cwJEboisSM5M56OpU/9hpvykVW8LwnLYQDkJBjj4ma/Ix6Hs8Wo
 T66lVE/68BAYXhP83wj+hU8hWUXu4isB3cCTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566071; x=1710170871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VjkKqgGdIkwWXnwjL8on9B4pXcGZv/0z8EtzvC4Cb4=;
 b=DBKhBt2kxz/JkpfiOSH9j7xf7G69/qF152txPyUfPJ3aiM27+K/UFe9QeHuGJbC0D8
 MFWoqzOxmuXsHxigCrqpAMT04bGkeUIsKNwRbQ64SZHohMr5Ebgk3Knp/2XsTiDmQGXD
 SxXOXp7yV3Y6vI/XHgHUn+D2DcyWefpBhFF+MphTOT9JPnEg6EsvGN/4HRtmrjEsgYPN
 i8Rb8BzJnneGDh7DvDB5HW6k62kPZiIbFAOMYu33W37Mr5GvppttIS/FFAfyeC5ia1lO
 rY6b2Br7qSn5qOWpF01Nm6bO7YwA65ncGw8a6EEMXcX4WkAAjQANVAMHuGDBQyQ9PXq7
 oBbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdWhqL5bT4opQpf7kHSeHFDtdGsrEd03Rq9L/5FFxdoixovWA+vYkqtKScboxgYb3OHq2jePS90C43Qy2edd0VgY255w==
X-Gm-Message-State: AOJu0YxBQQUlMQKFgZs3RB12v/S85a6YPGhcyZmECphSgKFqCslzLVCu
 11qy82yuqYkgHxMw+INiBGf0soCfwCLfoF/ipwUUtYqE6lGmpwDGbRIKByII8rU=
X-Google-Smtp-Source: AGHT+IH8ocC2aZNKYEKUDUV6qRbs3EZcYEadaVn4t/HsF9cgqaNXcu5g5WtrYxBsZSCpGaF8gEcvTA==
X-Received: by 2002:ad4:58a9:0:b0:690:71e:d18a with SMTP id
 ea9-20020ad458a9000000b00690071ed18amr9703992qvb.13.1709566071279; 
 Mon, 04 Mar 2024 07:27:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 oq5-20020a056214460500b0068fa52f5f7esm5205682qvb.7.2024.03.04.07.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:50 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Nam Cao <namcao@linutronix.de>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, mibodhi@gmail.com,
 xypron.glpk@gmx.de, caleb.connolly@linaro.org,
 mkorpershoek@baylibre.com, i@shantur.com, u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: support scanning a single partition
Message-ID: <20240304152748.GW1523872@bill-the-cat>
References: <20240221124144.168711-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RKLqFXUKLQzgooF9"
Content-Disposition: inline
In-Reply-To: <20240221124144.168711-1-namcao@linutronix.de>
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


--RKLqFXUKLQzgooF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 01:41:44PM +0100, Nam Cao wrote:

> The "bootflow" command currently doesn't support scanning a single
> partition. This is inconvenient in setups with multiple bootable
> partitions within a single disk, but only one is desired.
>=20
> Support scanning a single disk partition. Specifically, support the
> syntax:
> 	bootflow scan mmc1:4
> which scans only mmc device 1, partition 4.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Applied to u-boot/next, thanks!

--=20
Tom

--RKLqFXUKLQzgooF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6HQACgkQFHw5/5Y0
tyxUFQwAh/qck6/ZTGn0eBlMl+faJhcohYDvJr5ndX+GlLeaIYopp0V71TGKL0vO
Z8l79Er58nWlKbWXTUXzJHMqJ2gPS94O9dKv0MOCPLDElSKGNerxVhR2/qzuPhcu
aqoFIPBEjzTxtwcXLVsUOKW3ARboj34246ADtC8kjClUZa8upzw3DRfdzifdAQRJ
AXHXW0vRNG555aZCMlvcQvvfUizX4dC9+LmtGtmKCEW7R889uT19XpoFjkB9iVSF
XR/j8QYa+F+ll6ygwMc8kPCnQZqKfI5qmY04NtPaMSaTx+zsE7gdwtcY/Tj4SuAL
NphunW7kC0qthvx79SGNKDRCh4TYP3XbrJVzKw4se7Fk5kC4eSXHT00Lq39OV/F1
SmQeyb0UFxqLI+5Y6LQW5I+B/kjtIjqzsj9212AbrFKj34mYAeaGp3rwktDlXXT3
N4olr+3q+d5UAOy08FWIoLS3bZ5iFMRD4kBfOHh3BGIfbVMkZYfRkl8YCJh4Q0X5
YgjRtScf
=h7Wp
-----END PGP SIGNATURE-----

--RKLqFXUKLQzgooF9--
