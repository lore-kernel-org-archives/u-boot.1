Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F24D0BB4A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 00:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EE0892DC;
	Thu, 24 Oct 2024 02:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dVVdIukv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784F1892DC; Thu, 24 Oct 2024 02:23:11 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5D5892F9
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 02:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7180ab89c58so235263a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729729383; x=1730334183; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HtYzWC8RSUs8SvO+Sz47iYj7xuMGO2YhlbHdtJvvpU=;
 b=dVVdIukv/23XB5DsiJRzw2nGmGU1jAywvhv0DOV2BVlWfA64CEe8pcxMh5CKvb5X3Y
 43KPjKT1nGCT2D+38cyC8ErrRIHJvcmI6LVId+8/tM9q8ynxXYtUQUNErjXRUDxuMehf
 D4FbE8OyyNa4qIw/M2+hMSAAWX4hi/ObkCZ5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729729383; x=1730334183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HtYzWC8RSUs8SvO+Sz47iYj7xuMGO2YhlbHdtJvvpU=;
 b=bKTIrEp+kLmHzGXCJG5ijr/0GJ0DkuAXsA0L80K/LsE3wM9PpxX0WGpuxXFXTgge03
 2fpiEXT5kmXNAgTg96TeVZM9xFJGiJ7ppKacbsgMjS1GpKu7FJOgFhrIwqGc2UlOfDWm
 AJPGdUqjfEwHk4joMFfqtw6KAIJDime+joB53pa8rOq0V307Bw802QByU/GVeLvFfT9k
 N0lnoci6rvikaB9snqka9AgVav/Otv1Pc/GnNlh8WZCiQnMtQ6oyPG2aI4REbMypyhaZ
 th+tYhXQXDlgxh9JbUrkSEbWHiQd+owrvAp1L1aSK2mEpfTP86IUl5dvAjmeBw42nKlI
 52sQ==
X-Gm-Message-State: AOJu0Yz5hScEPoTCfBNjtQEfJqhY1aGslHjb6RCPf+ZoJU1s4NV/3uVM
 mNSW3pJFMMCSrKlTsyqNkzDJP7+dI1Y2QS5TtOgxmM0Mei2SBqW69/dUH1gtCc0=
X-Google-Smtp-Source: AGHT+IE/SMGFGD9WTlDwm9H3RVLt/Z9TZhBKFmrbexbL0MHDFflKoS9GZvMULsz+pUf2wza7xC2l0w==
X-Received: by 2002:a05:6358:418b:b0:1b5:e976:9a2b with SMTP id
 e5c5f4694b2df-1c3d810a684mr342247555d.13.1729729382849; 
 Wed, 23 Oct 2024 17:23:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c526sm430380985a.78.2024.10.23.17.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 17:23:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 18:22:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, iwamatsu@nigauri.org,
 marek.vasut+renesas@mailbox.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 0/8] SMBIOS improvements
Message-ID: <20241024002255.GP4959@bill-the-cat>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7UcbVp9qhtt7wxZ5"
Content-Disposition: inline
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
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


--7UcbVp9qhtt7wxZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 01:05:21PM -0700, Raymond Mao wrote:

> Motivations for changes:
> Current SMBIOS library and command-line tool is not fully matching with
> the requirements:
> 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> 2. Only a few platforms support SMBIOS node from the device tree.
> 3. Values of some fields are hardcoded in the library other than fetching
>    from the device hardware.
> 4. Embedded data with dynamic length is not supported (E.g. Contained
>    Object Handles in Type #2 and Contained Elements in Type #3)
>=20
> Changes:
> 1. Refactor the SMBIOS library and command-line tool to better align with
>    the SMBIOS spec.
> 2. Create an arch-specific driver for all aarch64-based platforms to fetch
>    SMBIOS private data from the device hardware (processor and cache).
> 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> 4. Add generic SMBIOS DTS file for arm64 platforms for those common strin=
gs
>    and values which cannot be retrieved from the system registers.
>    Vendors can create their own SMBIOS node using this as an example.
>    For those boards without SMBIOS nodes, this DTS file can be included to
>    have a generic SMBIOS information of the system.
> 5. Add support for Type #7 (Cache Information) and link its handles to
>    Type #4.
>=20
> Once this patch is acceptted, subsequent patch sets will add other missing
> types (#9, #16, #17, #19).
>=20
> Tests:
> To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
> get a merged DT to run with.
> ```
> qemu-system-arm -machine virt -machine dumpdtb=3Dqemu.dtb
> cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/)=
 \
>   | dtc - -o merged.dtb
> qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb merged.dtb
> ```
>=20
> Known issues:
> It hits the image size limitation on R-CAR board(rcar3_salvator-x).
> ```
> u-boot.img exceeds file size limit:
>   limit:  0x100000 bytes
>   actual: 0x10049d bytes
>   excess: 0x49d bytes
> ```
> This board needs a clean-up to reserve spaces for the changes as SMBIOS
> is a fundamental feature.
>=20
> Below is the breakdown of the size-growth of the related functions:
>   function                                   old     new   delta
>     static.smbios_write_type4                  252    1052    +800
>     static.smbios_write_type7                    -     764    +764
>     static.smbios_write_type3                  188     488    +300
>     smbios_get_val_si                            -     128    +128
>     static.smbios_write_type2                  316     376     +60
>     sysinfo_get_data                             -      56     +56
>     static.smbios_write_type1                  380     396     +16
>     smbios_write_funcs                         112     128     +16
>     ofnode_read_u32                              -      12     +12
>     sysinfo_rcar_ops                            40      48      +8
>     install_smbios_table                       468     472      +4

Right, so here's the problem I see right now. About 70% of all U-Boot
platforms enable GENERATE_SMBIOS_TABLE and so "smbios: Refactor smbios
library" causes a growth of around 1.5 kilobytes. That's a problem.
There is a place where we're going to generate as full and complete a
table as we can, and a place where we just want maybe the basics. We
need to re-factor things first so that the platforms which aren't doing
detailed tables do not grow and perhaps even shrink because we can pull
existing code out.

--=20
Tom

--7UcbVp9qhtt7wxZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZk1YACgkQFHw5/5Y0
tyx8Pwv7BqKAGK1jKGUgxIHL5/bRmjGkpsnBkixWDYdwSx3QqeSkoK9CMuQoE47x
mm+vwTn+VTrv4dKQTvot8zRnxa7/ub744y6BWAQr+AGI2n5tggy1fUX7ScSxUUKQ
ZpKTwPF/Xpt4LO1hsMVvU9sgIYmoFVmAAPV4JIaoR+bx9/jZj8xUTItcEUyvFd0n
5qeD2x0ZCVEuLGvbcBqR9TZA2D+yXnfu8S7xYP2RkRxf/zcWx3o73IBaqz8q912c
MyBZgf6RYAlnL9kYGiDM+EMw08N1FUm+aL1/MI07r4eLf69E0W8fN1gBR/0xWCRl
Ce02HDUEuDC0bWmsMqs4hlxMKjyWN4fZoum9n3Vn4keJg3enLJ2S0hdkmNSXUNyZ
tPQrIxMq0oj812L5nOPU+NkAOca5Q4IEtonIFNA0K1wiam52QNnN9JhOy6ys02+H
UpqOynINuMIq/xNJeN1fx1EljhUcxGaHZJsUWuk3ijn5ryLIR0eGhny04CEOp8gQ
JWlLKTMS
=mnsb
-----END PGP SIGNATURE-----

--7UcbVp9qhtt7wxZ5--
