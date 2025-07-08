Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958E6C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 23:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD08083390;
	Wed,  9 Jul 2025 01:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MfLRAGsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729A083394; Wed,  9 Jul 2025 01:31:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F320583371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 01:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735ae68cc78so3287227a34.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752017468; x=1752622268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bpfHl5DhlooFVOke8j518L2tx8nekgXnxuTk9kNicvs=;
 b=MfLRAGsniVrV0aLoA6J8TOndmfcfC0D7cY0f5GopLdGO2QSvRa2qXG/mrJgdrfG3o7
 ozvzldj0UymcqXZzdxNLrc4YRNRqD+eFex9DR64mh1s9/jhkwhHRUMTlZ9xorrBuDxbm
 WUp3BgdspUuMtWiAsGqYGiRs6g/5DomaeP3nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752017468; x=1752622268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpfHl5DhlooFVOke8j518L2tx8nekgXnxuTk9kNicvs=;
 b=AMoowTVg1tZXRwtMgaZX4Wl2k3rgjYGfwKOl6BpO//Q94XYTxT/XuEdrTVEIey0poW
 LaJ2OxJ9Xv6DRYS45tvlVrjdKdDZACj6qn7k4tz7w951FZoSEf9D7MZArP+eh9nEgAHd
 1axRVmG+papqi7CrG2g33kpBBSVCCxDo1x0CSJyhteEjQSfNL5sF51cNvTMXUxck2KC7
 xLkdckGXJFMV6DYQwKhkaVQkXrFnRWNh91MZq1m8kGHIocGJ4npg9O0Ql7nQPr9iX+xe
 TzAxOMseP8lz5jFBoRSwO0POGOxtGYSc+kD7bYFiD47NUSKUHZl8LsjajXViTtk8wiW8
 01FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3KMnE2/ah1VpwRmyVzbxElFcZdkIb+CwzD+GTctybK/1yteHAwpQC2k21W3t5u9LcEhF1uIU=@lists.denx.de
X-Gm-Message-State: AOJu0YwTj8cfES7AfvtQlVj1e4ZYR+IZFFLRSC6mzjOD9SDubUFGbEjB
 fIUzGR3HBJLzp0Q5/3cGvZmw8WTcqlqXAJy3TLMvvqxUc/F7XMZxmdm9Rblg0wDdmaE=
X-Gm-Gg: ASbGnctR8EOrGjXvCyg6B+4tR0CFbfDZuP9jLck8WknSazGm5iilom+1owNGQsnsdus
 Gpor3dllXWwUN6RsfQQiDfxg5eq0qlJ/YT/P+oXEvigwtfcQbVIgZu53dR8wugs7ENDa5gZ47w1
 9DhCJ7EsT1ej+UQ2XWvmAxqFpoLNDbPca/mxJQ7UeXZu4rOw2cLYtrxMtlVtBy1tseAUaQa2r9+
 WcrFChUSO5pdhwoCSU7LuRe3G1n0+KP769+Dub8Ldrmyu7ddw1JIdHQ7/2btaZ6NSjv6iQbDchM
 IdH0TJGTQcvo1c7ocYEv/dd49q1KiP1pawG6YD/QXqvwvVfH4PobZih3Ec8o3TISYUhNmuS+hzj
 AaqTghLuUrrvMXR4EG6Ct
X-Google-Smtp-Source: AGHT+IFxvGNBCKVdMQrUmrwXXDR8jDl27lf0jWcv7Uh7dmn2/sEBEXWNCjMo6JVIXdaXsYPN9LLhzw==
X-Received: by 2002:a05:6830:90c:b0:72c:320b:fc8c with SMTP id
 46e09a7af769-73ce635d585mr420402a34.21.1752017467586; 
 Tue, 08 Jul 2025 16:31:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f92e5c4sm2179845a34.47.2025.07.08.16.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 16:31:06 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:31:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Gokul Praveen <g-praveen@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, casey.connolly@linaro.org,
 tien.fong.chee@altera.com, sjg@chromium.org,
 patrick.rudolph@9elements.com, 1425075683@qq.com,
 Oliver.Gaskell@analog.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] configs: KASLR OPTEE RNG support for K3 devices
Message-ID: <20250708233104.GA1456905@bill-the-cat>
References: <20250627092224.36325-1-g-praveen@ti.com>
 <20250627092224.36325-2-g-praveen@ti.com>
 <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
 <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TabzYBkQI2tKuJIl"
Content-Disposition: inline
In-Reply-To: <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
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


--TabzYBkQI2tKuJIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:50:09AM +0530, Gokul Praveen wrote:
> Hi Manorit,
>=20
> On 27/06/25 15:52, Manorit Chawdhry wrote:
> > Hi Gokul,
> >=20
> > On 14:52-20250627, Gokul wrote:
> > > From: Gokul Praveen <g-praveen@ti.com>
> > >=20
> > > Add KASLR OPTEE RNG support across K3 devices by enabling the required
> > > configs.
> > >=20
> > > Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> > > ---
> > >   arch/arm/Kconfig | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 7282c4123b0..cd27e5a5422 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -805,6 +805,9 @@ config ARCH_K3
> > >   	select REGEX
> > >   	select FIT_SIGNATURE if ARM64
> > >   	imply TI_SECURE_DEVICE
> > > +	imply DM_RNG
> > > +	imply TEE
> > > +	imply OPTEE
> >=20
> > Does it get enabled for R5 based defconfigs too in .config? ARCH_K3 is
> > enabled for both R5 and ARM64 cores so wondering if we are ending up
> > enabling it for R5 too which might not be required ( or is it? )
> >=20
> > Regards,
> > Manorit
> >=20
> No,it does not get enabled for R5 actually.

That's not what the size growth on R5 platforms I see reflects:
               u-boot: add: 11/-2, grow: 8/-2 bytes: 1584/-692 (892)
                 function                                   old     new   d=
elta
                 try_load_entry                               -     596    =
+596
                 static.fdt_kaslrseed                         -     200    =
+200
                 handle_random_req                            -     180    =
+180
                 getrng                                       -     120    =
+120
                 rng_getinfo                                  -      80    =
 +80
                 _u_boot_list_2_uclass_driver_2_rng           -      72    =
 +72
                 efi_init_obj_list                         2304    2368    =
 +64
                 static.uclass_get_device                     -      56    =
 +56
                 label_boot                                1316    1372    =
 +56
                 _rproc_name_is_unique                        -      52    =
 +52
                 gen_rand_uuid_str                          108     144    =
 +36
                 efi_guid_rng_protocol                        -      16    =
 +16
                 dm_rng_read                                  -      16    =
 +16
                 static.env_do_env_set                      272     280    =
  +8
                 fdt_chosen                                 172     180    =
  +8
                 efi_rng_protocol                             -       8    =
  +8
                 cli_readline_into_buffer                  1716    1724    =
  +8
                 parse_pxefile_top                          928     932    =
  +4
                 bootflow_scan_next                         272     276    =
  +4
                 vbe_req_aslr_rand                            8       4    =
  -4
                 serial_init                                316     276    =
 -40
                 static._rproc_name_is_unique                52       -    =
 -52
                 static.try_load_entry                      596       -    =
-596

--=20
Tom

--TabzYBkQI2tKuJIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhtqjQACgkQFHw5/5Y0
tyzKsgv/b3DHg2GBHL5+SdEQE2a53X9Cl43lm350xjEJ/DZRQVOnf76MAF/8YzMQ
TiCZVeIBRVviJYCMEv0kmY85xvWqrdQWYsJ5wrlmu4GPzaXFi7kEjMJSTMREtkrN
5ZRky9B6WzspK673fAyAFOXm8pNmYrJkM7aEsI2ZIBX6+sOHS55CJlOPI3LPl97V
oXvW96rufef34KwW9A85bkVvcW2oWso1XBN0yRV97R+zvM6UTIw5eHkoaMFPI8sr
F+x+T6AAOplxvfLcIZeW3vBobtsS+x6HRX4yfqj7eIS53TS5xxhn9lGdLpY8s/N6
+xsYWlzowRtCykqSgT1qYtH57K9uOeFBiv7EQ7bfcIIqHSSAtyGgh8f8n/pO9tqP
JIVyi2dKWSAfickpEw63ZNd7DfYnQTlJVbKfVh8GsHBulRn582WDXsqQ8eowJdlX
sUNRA31FB1Fvqb2knUOZXi3ZiPRCqKVPx3MZ0O1K9xLTth/frN4inCiwNO+l0nbv
d3/q8WcX
=eSRO
-----END PGP SIGNATURE-----

--TabzYBkQI2tKuJIl--
