Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F7C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B354982958;
	Sat,  7 Jun 2025 16:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZM5eI/Ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FD682A0A; Sat,  7 Jun 2025 16:22:34 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77EB80E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40356cb3352so1931149b6e.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749306151; x=1749910951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vbO6fNIJAeUChfp4xQUJp2QrQ0lxGOP39WAedl2Jz8g=;
 b=ZM5eI/Army+tp00/EfzjhMRhmNnDNK88/KldJxf/eS/zyqjx8/qBZL/kFlVD+O2dT7
 s1MdHQKbhaXM7SUh63KJ0Edz70ReEoe75w9NCVgkt9ioIwJYXnFzWvg33ULRG+6FnGi/
 CG/9UJZiq/BifHmzQ4zzseg3D/lcQGihdEOvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749306151; x=1749910951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbO6fNIJAeUChfp4xQUJp2QrQ0lxGOP39WAedl2Jz8g=;
 b=D1qrONKJ4DYhtKfzdm5jIQ3IKyakuZ4KcT0o/W2lcefx97a5rfQeloLjVB6+FU+km8
 FR0mPsyAo9QP9gzKZOReu3oDpoeJKZT0Ku0sIBIMo29UNVH9YHG1Q5k1WqV4Ei3/lZY0
 A9rW4X1rSDWDdW8eKEmARZ1NyIQ3ZunKTUGxFEpsO6TxZIOQke8N6VP0fuqRTH9vaxLA
 ehbEshwKWyTYE5jHSEjRF8FAchgjZiDY8YiLhjrgFaFZvnngu2G/U9GDu8rL2ocKC6ZQ
 y3PgY6i2fRVhjJf7ZTJD/znI818jGwRJbk7aAQ5Fqhnrb74Cy8Lvjt/Sgq45xd0nMl8c
 I1zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4yqtdUIlW9nVnVJhetYQjAN4hpDeMKXu7k8Rj0iDIisdZSne1I+k0/JwI/F7M/8lMBThosUs=@lists.denx.de
X-Gm-Message-State: AOJu0YwYIrd53TBP40lbeLi8N2dJDckzlRyss8e3Q3KfBLOgF+lXoTSZ
 IDJbmXgiiudOOL81WJCF3FJj3bE0QNow//xBzN3JOW7gTqTJ1PVEqZGQR7AeJKxwCO8=
X-Gm-Gg: ASbGncvZKt6sBEkX9oD7n4UCtZ/Ch6q09d+VKxJHaXGh0Vv6ZlqSX4Q/zx/oapi4kkD
 P+vsK6frN5MvB8208rAezqKuARAMtdI4pwvOdXw9LrITR0srHODFQ+r+D1wN7aEDnMnQk96YRCm
 130heQcfQIvTgvp6sE53W5gQJVL9LmLNSLhrJZuQMk8Yo6hhtajfGJv+kNiFS7MGITB5bYRfagJ
 EULZMT0IYUcXbNITBbbpOWRfthdTqj2udotsIfoAG22L4FOGjGnM0OM/NYqMpi4u/XZlxhEVmO3
 Ab6Fj2VyLrrglvaWPGePlC2v4usOMVsJJpsLFmJGgdwFtRbmVnle0NUFelvc58KN05JDTb4OF8l
 bhGcoFU5K6fZg
X-Google-Smtp-Source: AGHT+IESTeDrH41S2luM8IysftTosvvnfoX1g3Y3n+bPZo4sN1C+BD5Y4Q0cvlXb2523aGDc/WAv9Q==
X-Received: by 2002:a05:6808:2025:b0:403:4807:3770 with SMTP id
 5614622812f47-409120e6ddbmr1537094b6e.9.1749306151606; 
 Sat, 07 Jun 2025 07:22:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea072e5ae4sm957762fac.32.2025.06.07.07.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:22:30 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:22:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] sandbox: align LMB memory
Message-ID: <20250607142228.GI1382132@bill-the-cat>
References: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
 <20250607114906.209959-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HuDkiIPWTwXTY8Sa"
Content-Disposition: inline
In-Reply-To: <20250607114906.209959-3-heinrich.schuchardt@canonical.com>
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


--HuDkiIPWTwXTY8Sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 01:49:04PM +0200, Heinrich Schuchardt wrote:

> To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
> memory.
>=20
> On the sandbox LMB uses addresses relative to the start of a page aligned
> RAM buffer allocated with mmap(). This leads to a mismatch of alignment
> between EFI which uses pointers and LMB which uses phys_addr_t.
>=20
> Ensure that the RAM buffer used for LMB is 4 MiB aligned.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/sandbox/cpu/state.c         | 6 ++++--
>  arch/sandbox/include/asm/state.h | 1 +
>  include/configs/sandbox.h        | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
[snip]
> diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
> index db2ac7f83bb..ee1ad21fd8d 100644
> --- a/include/configs/sandbox.h
> +++ b/include/configs/sandbox.h
> @@ -14,6 +14,8 @@
>  #define CFG_SYS_SDRAM_BASE		0
>  #define CFG_SYS_SDRAM_SIZE \
>  		(SB_TO_UL(CONFIG_SANDBOX_RAM_SIZE_MB) << 20)
> +/** define CFG_SYS_SDRAM_ALIGN - Alignment of emulated RAM */
> +#define CFG_SYS_SDRAM_ALIGN		0x400000
> =20
>  #define CFG_SYS_BAUDRATE_TABLE	{4800, 9600, 19200, 38400, 57600,\
>  					115200}

Can we avoid adding something to the CFG_SYS namespace? Since this is
sandbox centric is there something under arch/sandbox/include/asm we can
drop this in to instead? Thanks.

> --=20
> 2.48.1
>=20

--=20
Tom

--HuDkiIPWTwXTY8Sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhESyQACgkQFHw5/5Y0
tyzrXAwAlwqXB+oGiNotrKYKKjqMZPthprCO0Xwr/ksq/AWOANFb3AWNgmGJ7f25
rVabPhrW737IUtGXWZY2d5oUtGxFfuDuHnaB6fUGzTfEq2wq4BmMag+426yL4RxT
RDCUrtZcE6HCgoLL6U+Qtj9xQffcD0DS8uvk+t3EF4CyB5ozTnl4/+m1NvBJmoD7
o8UA7iEJeeNX2bDL9vEmqYRJPehCMNsYNoOZppNnorhUNuchi0yhqfTQeolp38jG
eDss7rahkYSFbYQEOIaID9IyqqgSp2gXZ6z3xV+JMtYLolgiWid5fi0Y0yoYy6Z0
l7tUtAy4XuEW35jnrmXw2WBhGJOMxO07MP9ttfRf3sX7tx5cazZW8orOZOil/ze6
wtLld2M20Uj92Z6W3MGtCu47tMDo5OkMh9jBoMCByWn+clWvhw1GnqoNUQTcAdX0
bS0GZL4d0KajprytMp6wAZuNvNX8Lqq2iqAdR+cyYesj/FgT3rahs/94NSSJrzFJ
/DG9v8h+
=gDY0
-----END PGP SIGNATURE-----

--HuDkiIPWTwXTY8Sa--
