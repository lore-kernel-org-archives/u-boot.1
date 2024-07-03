Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8688AC3271F
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 18:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA24A88405;
	Wed,  3 Jul 2024 20:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bKDDo74h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7AA88679; Wed,  3 Jul 2024 20:22:46 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3683388864
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 20:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-701f397e8ffso3186912a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720030963; x=1720635763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6I3NqkI3GDsJSllPGkLWLpigUCqlTfnRENM5IWZ050A=;
 b=bKDDo74hIKDWdEQYNjWbZsvcVHEqlAKWwdgTY+jLOvu6GVppWXiaCY39IwBlgk+C84
 76fTalDz2k+wP/JpR9ezxqAOZ4QdoJqVIAsqlBq8XAN7dTgghgUkGrvSMTc4Gpb44L08
 towRZRf8EHEuiISVCT309pao+D3F77gI75hX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720030963; x=1720635763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I3NqkI3GDsJSllPGkLWLpigUCqlTfnRENM5IWZ050A=;
 b=eR/Va9p/FNCVZulHd997YGjR3goF0Pt6FTsVqBNcxc4Fht/2mvv6uDR1W7+Hx/gv9l
 pNetkaVScsSAD5qD4cKpg1BFSkA34iBK9NnzgX7ehib+F0RRl4J7MfBxj7X9THc+PKdy
 8MxtKmlXI/0zPQqS4o4jhAhBQtYXW1ew1RrtTSdAqW2lH+G6+6v0s20skE289FJd94mR
 vm3u2CD3eXJyibbzY79vdnq8NQefj8GCKivSetRXEDAMqQdD8VGAnm1dWRv0ezQEsHAU
 UXSAUUOz1RstL+oX1aPnGEotDT9lVOft9M8gsXrVdN1izD7L7bQM6h9cpbnxs1NtCim1
 YDZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZNmxgsrTOvPVRf0TSJvFUdaos9DUqqYOLcjwuMpc/3hzIAuBiZ9gWtXfWd8NR1GPkH96gV21z+PAUe/cXCkyUNAqo4Q==
X-Gm-Message-State: AOJu0YyE5j4yyw7dCluAiMsaCiLTHm0aylyLh94M4bP1P48/vmoSQfhw
 zs2G8eJUKxcg4CgO0qG8XEn2HwjOEiBKyivn5dCk6nOxRZ2cTSkM7XXuZIB1siE=
X-Google-Smtp-Source: AGHT+IG+MrKb+DtxOjDdLtlmvY6erR6ish1iEwoKbix6raqUKZZI/G5aTYXLk+nR7Y2dKtNrJwFJ2w==
X-Received: by 2002:a9d:7413:0:b0:701:ffd6:9499 with SMTP id
 46e09a7af769-70207709b09mr12700846a34.35.1720030962858; 
 Wed, 03 Jul 2024 11:22:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b20a0dsm2052091a34.55.2024.07.03.11.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 11:22:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:22:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: ian.ray@gehealthcare.com, sbabic@denx.de, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] msc_sm2s_imx8mp: Adjust the initrd_addr location
Message-ID: <20240703182238.GC38804@bill-the-cat>
References: <20240703175727.446205-1-festevam@gmail.com>
 <20240703180355.GB38804@bill-the-cat>
 <CAOMZO5Dej12iA7mX9MqMrrsj6oQ4SrNCAFN2vGuvOA_sq186aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LXLNQqmIf7Bipf9x"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dej12iA7mX9MqMrrsj6oQ4SrNCAFN2vGuvOA_sq186aA@mail.gmail.com>
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


--LXLNQqmIf7Bipf9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 03:07:47PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Wed, Jul 3, 2024 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > Shouldn't fdt_addr_r change too? This is making me suspect the whole map
> > is too small for safety, how much memory does the platform have at
> > minimum?
>=20
> It has 2GB of RAM.
>=20
> Changing only initrd_addr and keeping fdt_addr_r unchanged allows a
> successful initramfs boot.

How is the fdt at 0x43000000 not being clobbered if the initramfs at
0x43800000 is? Is it because it's just enough of a bad spot that we
relocate the fdt out of the way? With the kernel at 0x40480000
everything else is too low. kernel address + 128MiB for fdt address, then
+512KiB (or a bit more, for nicer numbers) for initrd.

--=20
Tom

--LXLNQqmIf7Bipf9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFlucACgkQFHw5/5Y0
tyxaVQwAsiY7PnNmuD3+h9kzPoYKIze4Tt6M5AeLcGHO8sTwyxO7SS3KQ4LisNZW
ZkijbNeFAleWGrMowyTzQTX1adZF1Txxeq9ap74s7gv6ro50oWdCfsB7VK44FBDR
bOhfAV/LySmD9vvN0HK7kScJVG3O/QwlpLUkWG+FZb4jKShIgaD46n+u61S9dlil
4Sqz06knY41weioGtFJw4mgRVlu3Jzfsyuco2wv89tgM8gcJvIGdYNcccP/G1mqH
18YomOYtweGR4ikgouj931dMBL7PvjESu6xBjOYCuCgfRhkTQNoHECPF/RrOVhbS
OFKwhRtLAt/HSy8APObH0235uLY6xoQ3cQoU0xTxB1gDPEw4QPLxqMkVTKJ3h7z5
YJVtgsVR80dX339zLYI0XYFAUa69g6Zm8O0so0XSMKOXkIFPqCaohp2ph0+6j8DW
7vqXWMfLB/Phv02L3LnKodgsLI53OvSjQVDYyx1x1oHl+bFrmzLjwU5S4hEdsaA9
HCg0UXBD
=wCCK
-----END PGP SIGNATURE-----

--LXLNQqmIf7Bipf9x--
