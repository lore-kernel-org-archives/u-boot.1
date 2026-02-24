Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AD9F357C5
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 17:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA1383642;
	Tue, 24 Feb 2026 18:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UWHpWYVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9E583981; Tue, 24 Feb 2026 18:05:58 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08CE82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 18:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4638fe85a7eso2195333b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771952754; x=1772557554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pRlp7ykSozMxlvC+OkpgyROIp5CVRTfY2BqNnY8jezs=;
 b=UWHpWYVRuilWs/4PNT96ZXVYW2mBR7V0Zhzmu7fiyW8keSUOo1VMQXfbRxxci0nr/3
 sTZA+l+JgBDAptIHQIh9AK5mVtSyfn1K780tgOj1t/1fNuaTM7Kt0W0eL33bZ4swOYsy
 reBYb4EVXPgg3k6BiB846Jocx6CHnvR4V0eQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952754; x=1772557554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRlp7ykSozMxlvC+OkpgyROIp5CVRTfY2BqNnY8jezs=;
 b=gYqfI4tjXDgw4CxiNTlwbKoIUOvDjzqZVRZ0sR26RF/kQn6dCqud7sZEXPO5vE0T2j
 /oLWjJkjGnnM+E2awe5QkvCb0+tpx5kZE/1+N3RNB83KXeNcD32Pu8g+luDZG6RY2coY
 rTi8yGv7YVisQH2/hsx9aBMzHG3J71OSUP3EtZytut9zB0gSBSp8A/VPphntHw8Mqbol
 E+QhBGAF0wVY7UERVad8jfQvu+JTgTKbFcAP4HRSDwS6FyxYPlOuX9DZ+vqvKTn3YaK4
 nW/WteMG8oFcI3ffaP4Rn4YDejKtZsz1XTe5SSa7dctPk0CQZUEaUo+ipHVV7OxC65tx
 sdtw==
X-Gm-Message-State: AOJu0Yxtap6rO/cUujW2MjMeSDhPoWefhZTgQ0danZN6laV7qUhBmaBp
 gL4W0O6Et9EYYNqy2Dr7/Ou0sRTWavDwQojuiolSHK6j9BWjiCoM5I/wxHWvjLcfGQg=
X-Gm-Gg: AZuq6aJyeRPTCNNbx/V+bZnVXmwOOHz33ZxOaFaow/5WtWaOesbcEx51A9XA/Nc1YWe
 IAE2+trsTpx99BcqMid8oBVR32YGBDZDg0BWHcw0Xe9KWmu1jcuzn9rKhE/vIwLiZLmv3z1HGQl
 JqNBMIgJIeSBFcLZmy7vPmwSjBdx8DqKwYLHVoMAHf+z1tFvYsFwVxZbKa3s47+YU4pZ5K5vW3i
 0qLnSG+/BVOxwl3Mswq8PUrBUldbkRaDmEUsHiHJGQWRfqSG5VzmcXSzFmRiFDyC7o8ecO+btqr
 ubatHOS+ZA9I4YLEqiW5B6Ni6rhjOkiMuXIxTblNcLg2tm18Ecc25vqlC3e/fd1xIssdHbp/WaL
 2nRcf8Z8cvc67yV/vITZwgHD8XxDhbKvqzIThb1AxvttFR5MUO3XIoeW1nqCp7hDerkZUKloYni
 KhSHra0ZoiJQP4L6zR1m4HAMsgS/p8aS7A5cH3epXSjXQ1aiofTIyWtFsxSwEqoZRVkvZow1S4S
 bWmdjBFDtg8FoYolVXAYoNjiWaMI8xweQZxxq3r37m6SkXsEKU=
X-Received: by 2002:a05:6808:30a4:b0:45e:63d9:a678 with SMTP id
 5614622812f47-464461421ddmr6690872b6e.1.1771952754515; 
 Tue, 24 Feb 2026 09:05:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1efc76sm7351552b6e.18.2026.02.24.09.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:05:53 -0800 (PST)
Date: Tue, 24 Feb 2026 11:05:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootm: fix booting kernel_noload image
Message-ID: <20260224170551.GY3233182@bill-the-cat>
References: <20260224155712.286317-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FSdD+HjEwzr7rYvn"
Content-Disposition: inline
In-Reply-To: <20260224155712.286317-1-ludwig.nussel@siemens.com>
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


--FSdD+HjEwzr7rYvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 04:57:10PM +0100, Ludwig Nussel wrote:

> FIT images don't work without having to explicitly specify physical
> load addresses. Digging into that it looks like a flaw in
> bootm_load_os().
> It duplicates images->os for convenience. However, the code handling
> "kernel_noload" images then updates the load address in the copy with
> the value lmb_alloc_mem() returned. Later there's another call to
> lmb_alloc_mem() that uses the old value. This leads to havoc due
> to subsequent calls of lmb_alloc_mem() picking too low addresses.
>=20
> The "fix" is to mark the local variable const to avoid accidental
> assignments. This works but IMO the logic is still flawed somehow as
> this leads to overlapping lmb reservations. I guess the fixed
> reservation should only be done when the noload path wasn't hit.
>=20
> Without the change:
> + bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'kernel' kernel subimage
>      Description:  Linux kernel
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         Kernel Image (no loading done)
>      Compression:  gzip compressed
>      Data Start:   0x402000b8
>      Data Size:    12227440 Bytes =3D 11.7 MiB
>      Hash algo:    sha256
>      Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55c...
>    Verifying Hash Integrity ... sha256+ OK
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'ramdisk' ramdisk subimage
>      Description:  Initial ramdisk
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         RAMDisk Image
>      Compression:  uncompressed
>      Data Start:   0x40da9528
>      Data Size:    1067114 Bytes =3D 1 MiB
>      Architecture: AArch64
>      OS:           Linux
>      Load Address: unavailable
>      Entry Point:  unavailable
>      Hash algo:    sha256
>      Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
>    Verifying Hash Integrity ... sha256+ OK
>    Booting using the fdt blob at 0x40000000
> Working FDT set to 40000000
>    Uncompressing Kernel Image (no loading done) to 13a400000
>    Loading Ramdisk to 400fb000, end 401ff86a ... OK
> device tree - allocation error
> FDT creation failed!
> resetting ...
> Bloblist at 0 not found (err=3D-2)
> alloc space exhausted ptr 400 limit 0
> Bloblist at 0 not found (err=3D-2)
> [reset]
>=20
> After:
> + bootm 0x40200000#qemu-arm 0x40200000#qemu-arm 0x40000000
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'kernel' kernel subimage
>      Description:  Linux kernel
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         Kernel Image (no loading done)
>      Compression:  gzip compressed
>      Data Start:   0x402000b8
>      Data Size:    12227440 Bytes =3D 11.7 MiB
>      Hash algo:    sha256
>      Hash value:   7ea661fdecdd1127edd419cfbf8bff52e2d5ac55ce...
>    Verifying Hash Integrity ... sha256+ OK
>    Using 'qemu-arm' configuration
>    Verifying Hash Integrity ... OK
>    Trying 'ramdisk' ramdisk subimage
>      Description:  Initial ramdisk
>      Created:      2026-02-24  14:10:09 UTC
>      Type:         RAMDisk Image
>      Compression:  uncompressed
>      Data Start:   0x40da9528
>      Data Size:    1067114 Bytes =3D 1 MiB
>      Architecture: AArch64
>      OS:           Linux
>      Load Address: unavailable
>      Entry Point:  unavailable
>      Hash algo:    sha256
>      Hash value:   2a711dcb5f58615187645ccec615c67eddcfbb3138...
>    Verifying Hash Integrity ... sha256+ OK
>    Booting using the fdt blob at 0x40000000
> Working FDT set to 40000000
>    Uncompressing Kernel Image (no loading done) to 13a400000
>    Loading Ramdisk to 13a2fb000, end 13a3ff86a ... OK
>    Loading Device Tree to 000000013a1f8000, end 000000013a2fafff ... OK
> Working FDT set to 13a1f8000
>=20
> Starting kernel ...
>=20
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

Interesting. This works fine today on for example Pi 4 (with a few
additional options enabled):
U-Boot> tftpboot 200000 v6.13/image.fit.arm64
Using ethernet@7d580000 device
TFTP from server 192.168.1.10; our IP address is 192.168.1.119
Filename 'v6.13/image.fit.arm64'.
Load address: 0x200000
Loading: ##################################################  27.3 MiB
	 8.3 MiB/s
done
Bytes transferred =3D 28574720 (1b40400 hex)
U-Boot> U-Boot> crc32 200000 $filesize
crc32 for 00200000 ... 01d403ff =3D=3D> 8513595c
U-Boot> U-Boot> bootm 200000
## Loading kernel (any) from FIT Image at 00200000 ...
   Using 'conf-243' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel' kernel subimage
     Description:  Linux-6.13.0-dirty
     Type:         Kernel Image (no loading done)
     Compression:  gzip compressed
     Data Start:   0x00200138
     Data Size:    14546728 Bytes =3D 13.9 MiB
   Verifying Hash Integrity ... OK
## Loading fdt (any) from FIT Image at 00200000 ...
   Using 'conf-243' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-243' fdt subimage
     Description:  bcm2711-rpi-4-b.dtb
     Type:         Flat Device Tree
     Compression:  gzip compressed
     Data Start:   0x01136f5c
     Data Size:    9334 Bytes =3D 9.1 KiB
     Architecture: AArch64
   Verifying Hash Integrity ... OK
   Uncompressing Flat Device Tree to 3afbfc00
   Booting using the fdt blob at 0x3afbfc00
Working FDT set to 3afbfc00
   Uncompressing Kernel Image (no loading done) to 36400000
   Loading Device Tree to 00000000001f3000, end 00000000001ffb11 ... OK
Working FDT set to 1f3000
Starting kernel ...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
=2E..

So one thing I'd like to know is what makes your case different, so that
we can catch it in testing in the future.

> ---
>  boot/bootm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 4bdca22ea8c..280efb26e90 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -602,7 +602,7 @@ static int handle_decomp_error(int comp_type, size_t =
uncomp_size,
>  #ifndef USE_HOSTCC
>  static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>  {
> -	struct image_info os =3D images->os;
> +	const struct image_info os =3D images->os;
>  	ulong load =3D os.load;
>  	ulong load_end;
>  	ulong blob_start =3D os.start;
> @@ -631,7 +631,7 @@ static int bootm_load_os(struct bootm_headers *images=
, int boot_progress)
>  			return 1;
> =20
>  		load =3D (ulong)addr;
> -		os.load =3D (ulong)addr;
> +		images->os.load =3D (ulong)addr;
>  		images->ep =3D (ulong)addr;
>  		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\=
n",
>  		      req_size, load, image_len);

With a bit more context, the first thing we do after declaring variables
is check for the noload case and set all of "load", "os.load" and
"images->ep" to the location lmb_alloc_mem allocated for us which is the
code here in the second hunk.

This part at the end of bootm_load_os:
        if (CONFIG_IS_ENABLED(LMB)) {
                phys_addr_t load;

                load =3D (phys_addr_t)images->os.load;
                err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &load,
                                    (load_end - images->os.load), LMB_NONE);
                if (err) {
                        log_err("Unable to allocate memory %#lx for loading=
 OS\n",
                                images->os.load);
                        return 1;                                          =
                                  }
        }

Is indeed a little odd looking, starting with I would have expected the
compiler to complain about re-declaring "load". But yes, this part here
should not be re-reading images->os.load.

I'm guessing in your failure case we're doing some huge allocation this
second time here and that's why there's not space later on for the
device tree? But it's also a little odd that in your ramdisk is now
being moved around, but perhaps that's because we detected an overlap
now? Can you share how exactly you're making this failure happen please?
Thanks.

--=20
Tom

--FSdD+HjEwzr7rYvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3aaAAKCRAr4qD1Cr/k
CjceAQDDKmXHK0j6NI8RJFH0hewrma7Ys48GRsfkmyLFta5z5gEAjwKzTN7kWc0n
ff5eA5tu0YM10S0Wj+w/3ENjO9kzUAA=
=SpHl
-----END PGP SIGNATURE-----

--FSdD+HjEwzr7rYvn--
