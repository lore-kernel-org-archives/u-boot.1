Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994D3E909C0
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 15:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40BD83AC5;
	Tue, 17 Feb 2026 16:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HQ9kLDLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C9E83C32; Tue, 17 Feb 2026 16:03:43 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF0F83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 16:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40438e0cba6so2931603fac.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771340619; x=1771945419; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gXoWokyFVmXTU59jP0Z7RgDHsZiRRBNiYhc4bA1J4sM=;
 b=HQ9kLDLwooHCvTs+aDwpY2cXbkcGJhwTgGVb/0YPW+KzKrZu7BR+ybNPZGmfiMYQIG
 yLO3P8O8EBLDsw1lrj4G5q+I9wZRqWYp1DiHBg5ldZ3P0B8oDmwuMTyI+j822ieXUgVS
 KSIzh/c3YAB3yeKTHcJj0t9FLTR67jMs7EuYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340619; x=1771945419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXoWokyFVmXTU59jP0Z7RgDHsZiRRBNiYhc4bA1J4sM=;
 b=rNoaMNNDnQV0M15nsVYkqyR78UmiznesrT84lnXKoSYMWF4+JGrSu3ooqd90wdvVOq
 7vJ+RrTOMdmpPdfq8CZBBrI/0gftG6g9S+3Mzs4///yB/mfjpN71+k4vQkQ/HYzFi2BU
 E5cXV2NlrEvh4YfW3ErDKPqojOYRryZvXMsEdGRy8khgptM8myv3el+FexZ3lC3JVo4P
 wTzIgDHfSnXp2k1z1ANdoQTv4+qvE2NbFwVakJIMIpKBn0Qk/Cg+wuRD+RqHY4SXkr5O
 9SSfI7Hd9jH+tEZI295x1vqt9+XrLuoRuvhVYKtosbe6rM3o7SDkEFN06BJrczWJikG1
 25BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBPOLyq0OgGPbix5tEHHS3KN1sQPK1jCswNnlAyTKWA2NSt+Bq8VjEJRiVTotY8UYVLkF/5Jw=@lists.denx.de
X-Gm-Message-State: AOJu0YxUNSWoLt2cmPTPnhns895zdn+9fDBkvj+K4qa2a4wSXgGNoBFs
 aFB7Ihs1ZxOF2qfFEvUTo3V3MVR+yW8XlXvMR46AXZb2+bJIihbyLhpG7qT4LLXx2Ds=
X-Gm-Gg: AZuq6aI/4wJv+8RUUvi17tu3iGVcWZ5jIR3jUVkBjbQeDJU32+eiOWjsSKOR5UlQ9Ul
 bX02i/x3ZYNr+OylGrg7+ZUEo6RxblzlUSlw3vknwx0+Ijb4wh8P8nIVZV7MU4Koypt/4MnsTIV
 S/bDD5bouu9cP+GCykfI3/+d/6enRVuBw+Mbbw1X6RkvWHBGo0xbmj+n4YQyWvQZGpYnTfMvOMI
 dNvhDXRtnFGLyai8+iRO60pVi1HAItHIfixLoLR1nCjrSOiosqWdQVA+Ve+mHWC0e0etrDMUkt3
 9+YzriLh3p4RLwnwZYAM6/JN/ulCi3nX4Pmu67d05C3RvHbZEIjX5RhtSKgBI+42WS1nSYQa/zP
 aQ8uLyJjmz1yySSrsxb/ojp9Ak9HmqXrpiUkqOuKtYBZSUJ7D4fSop6DmdcUiquPY0u1kNnvdmT
 mlctWcpt1XMeb2N6M7GfF8RdyJx3F5JOSdfNuQA0ArK7lNevZCLjRbUYUjF0UePYVlZAJPpxxRh
 YVX/fsHaYy1BJm2n2FnIkG/oJisicJmjZnh2kpb0GIL73568jg=
X-Received: by 2002:a05:6870:171b:b0:409:99bb:1eae with SMTP id
 586e51a60fabf-40ef4054999mr8008191fac.53.1771340619315; 
 Tue, 17 Feb 2026 07:03:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaeb42708sm18463787fac.0.2026.02.17.07.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:03:38 -0800 (PST)
Date: Tue, 17 Feb 2026 09:03:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: gabriel.dalimonte@gmail.com, u-boot@lists.denx.de,
 caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com
Subject: Re: [PATCH] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20260217150336.GA2747538@bill-the-cat>
References: <20260217035643.2383088-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nf873Bm0k0oIuFOc"
Content-Disposition: inline
In-Reply-To: <20260217035643.2383088-1-varadarajan.narayanan@oss.qualcomm.com>
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


--nf873Bm0k0oIuFOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 09:26:43AM +0530, Varadarajan Narayanan wrote:

> Do FAT read and write based on the device sector size
> instead of the size recorded in the FAT meta data.
>=20
> FAT code issues i/o in terms of the sector size. Convert that to
> device sector size before doing the actual i/o. Additionally,
> handle leading/trailing blocks when the meta data based block
> no and i/o size is not an exact multiple of the device sector
> size or vice versa.
>=20
> Tested on UFS device with sector size 4096 and meta data recorded
> sector size 512.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>

We have two sets of problems here now.

[snip]
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 9ce5df59f9b..a725d924fd9 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -45,11 +45,13 @@ static void downcase(char *str, size_t len)
> =20
>  static struct blk_desc *cur_dev;
>  static struct disk_partition cur_part_info;
> +static int fat_sect_size;
> =20
>  #define DOS_BOOT_MAGIC_OFFSET	0x1fe
>  #define DOS_FS_TYPE_OFFSET	0x36
>  #define DOS_FS32_TYPE_OFFSET	0x52
> =20
> +#if IS_ENABLED(CONFIG_SPL_FS_FAT)

This isn't the right way to test. You want IS_ENABLED(CONFIG_XPL_BUILD)
to limit this to when we're in an xPL phase. The test for
CONFIG_SPL_FS_FAT is always true on platforms with SPL and FAT support,
even when building full U-Boot.

The second problem is size growth in general:
   aarch64: (for 1/1 boards) all +950.0 rodata +14.0 text +936.0
            qemu_arm64     : all +950 rodata +14 text +936
               u-boot: add: 0/0, grow: 4/0 bytes: 936/0 (936)
                 function                                   old     new   d=
elta
                 disk_write                                 132     596    =
+464
                 disk_read                                  100     544    =
+444
                 fat_itr_root                               428     448    =
 +20
                 read_bootsectandvi                         408     416    =
  +8
       arm: (for 1/1 boards) all +686.0 rodata +6.0 text +680.0
            tqma6dl_mba6_mmc: all +686 rodata +6 text +680
               u-boot: add: 0/0, grow: 4/0 bytes: 648/0 (648)
                 function                                   old     new   d=
elta
                 disk_read                                   48     368    =
+320
                 disk_write                                  76     384    =
+308
                 fat_itr_root                               300     312    =
 +12
                 read_bootsectandvi                         272     280    =
  +8

So nearly a kilobyte on ARM64 and a bit more than half a kilobyte
otherwise on around 1100 platforms. Is there some re-factoring / code
sharing that can be done here?

--=20
Tom

--nf873Bm0k0oIuFOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZSDRQAKCRAr4qD1Cr/k
CnMLAPwKZL3pd4N6p9tL9wcAJkiNcsRRsBgSf6XT4QAim5rU7wEA6/JckQ7zyCAK
TgFEhoY/5dvDDpDPQ6JJAAL+p482tAc=
=Ea5l
-----END PGP SIGNATURE-----

--nf873Bm0k0oIuFOc--
