Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6594E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1674283E7F;
	Thu, 19 Feb 2026 14:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/IefWns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB27283936; Thu, 19 Feb 2026 14:11:37 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCA683DF3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65c01595082so1196753a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506691; cv=none;
 d=google.com; s=arc-20240605;
 b=GO+Q/jI2suxR/G3XaY0rHWQbFy7ioL4h3y32eV9WWNuX7WWIM+v6uaC0z+hc9PcVJ5
 p0RBr2MGB+NcD8KJ9d3IObm+k8YNi2z5iV3PIpJpO0ymlp95PBtdV3RyYwV39L5SX6sl
 SdRtcGX/9dKnZy+c3L/S6uKyCXzxzg3kEFwu15SqsQbidQN/kQlzNzGD7Pa6ozN1r9FO
 i2ajtKetflNspzNOJcAJ4Z0/tZZyH2ue4FH2/AoY7eEj18HNzWTsU/8jfnDpQ/sp9VoL
 zJrRC0LglJ5HAVWoA7X72J1g345vgA+Oa8mazxwIRGMFtjtrbl8qt0En27VV0tOAwr7g
 DZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lWtLsN7NoPiuQWW3VqDyqFa5Wt8quRcCdiSe+R15qNg=;
 fh=/qylhtYtuBkLitSNodewGug8IfgZjvhW3g4XYMzCy+k=;
 b=ZSAG976gzht1d7tKXIcxbPvRc/9NcX3sup7z+9YZ9ZLMN94TDwWTo0eqT6QPDJd3MU
 LcDxj+resOk2orzurf2pR2ZGteOM5C+C+5eKLrPm3YbSSdpOTE357mNrEf6lMe5biZmV
 a5zQx8mu32U/FbmUJzuUFR5Gj5XQ1Lc3ed85Wx3Z7ekgEXt10Sn4V14Vu5mPEs/35cuy
 ddbW8WGm49SO0uniX817hsA2ihGv3bFLqAnHWhQnOmlcK6Yn0z8cybXD1wR8a6dsjVCx
 YCbz/w3BLOGSU46x0BzZ6E/YwVccoztogiPHnwmLEw648Aym/Eic4x5p4BLkhc5X6zF2
 PPTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506691; x=1772111491; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWtLsN7NoPiuQWW3VqDyqFa5Wt8quRcCdiSe+R15qNg=;
 b=P/IefWnslkzRmE9jOEUU1dZ+QCJtKWROK5d4iwo9W2oUdC/eYlB1P6fMHllT7oGs3R
 JYi8FVibw+eIXwp9r/r0quWYlyktsBbY6tbL0QRe4201fX5sQVSyeErLlyQmiya9fFh9
 rPNSpb2nxwy2nPvE5y0t/LuIWNe6qloR65jwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506691; x=1772111491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWtLsN7NoPiuQWW3VqDyqFa5Wt8quRcCdiSe+R15qNg=;
 b=bCzP61YJ4im5Ys2dmgVLuVaP53/sJh0tvlKPwXYpBhPPBUBqBTE8EBFZd9fjH059jo
 Dww/6YxpwNE/mqwc6iYcm0/NwiHUklZPkKPu8Qsc5wTxks/aD6Rwniw2GQo93nnqbcd4
 Gz2Gw2I97KTtWcKFKztKZukuwt5KdaxFZKxn6Mm3ysY3iuetd3T7AUqZdemPeoqUAV7C
 IH2uxB+dmWoIMvg2P9o+QyD4Sb/jdQOu3R7s8SKQVwn7EX5mLdOtZFJZUw/edORrRfc4
 Au8sR9+NLjQCqCkSZxf63teiG2/bRqMqvOLosfRrRPREGtqXjUwoVoy9dWFTfx1ys09L
 EGtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNo3C8aVJVKFV0RcBEivSmv6yqq3qcqVTlZ9pL/R4hoRH4M/oqF4kGGGH6Un9+C7HsOdv5LAA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf9ufHR+aIdCpBfpDKkLypEW4OZ9eqXiZ6HiFAML0Xkzdbm8FN
 RKZZabhr1AIRTwmfTHl6/qLlr7i+5bAKO5Kcq5i8OisPCoWCi5mRZ8MZ+OhGWgOYK9V3Rm3yT+9
 MV/kq4GEewedmWBPrjBmnLodszR/tDEKKIAFfwDqj
X-Gm-Gg: AZuq6aL8Z0vDM/71K70kfG8XX8PZML8whoPH8p2BPzjf1++hoSYf2WsVzR0KXTkPNZ6
 FUsGYMVnBqS6TNc9OdmJ/f+ow0FI641XDX/mI7Sz/l76mn8157oOiJCUzv4JO4xGnxbJLd7lKcd
 YjbgQAA+0cLZiaO/ByT9pTm/hh0y4zMV5umwjFDfiqlMBsqcAyE1740wDrm/AZhurubuDo3bFSa
 W5xeK74D1slsewGyy7ENssghEQoZKHHUmvNHOcBFi9Q3zjLElWrEFw5OdIEkHR6vx90FuYTPVre
 tSWKbA==
X-Received: by 2002:a05:6402:13cc:b0:65c:149b:dfea with SMTP id
 4fb4d7f45d1cf-65c149bfd4dmr8382462a12.15.1771506691187; Thu, 19 Feb 2026
 05:11:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:26 -0700
X-Gm-Features: AaiRm52-M4cx9OTicnSF49fgQw6kvK3oKHCuGN6upuFdQi93ebb2JCvcTNDVghc
Message-ID: <CAFLszTi3r_6VynzrZKkDNbcucntoEW=4nLCV_q8kv3+vQojLBg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/20] boot: fit: support on-demand loading in
 fit_image_load()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add an on-demand loading path to fit_image_load() for use when
> images->loader is set (storage-backed boot).
>
> For external-data FIT images, the new path avoids dereferencing
> fit + data_offset (which would point into unmapped memory) and
> instead:
>
> 1. Extracts the data offset and size from FDT properties
>    (data-position / data-offset + data-size) -- metadata only,
>    no payload access.
>
> 2. Returns early for IH_TYPE_FILESYSTEM sub-images, which stay on
>    storage and are never loaded into RAM (e.g. squashfs rootfs).
>
> 3. Determines the RAM destination:
>    - If the sub-image has a load address, loads directly there
>      via image_loader_map_to() (zero-copy).
>    - Otherwise, allocates scratch RAM via image_loader_map().
>
> 4. Verifies the hash/signature in-place using
>    fit_image_verify_with_data(), which is address-agnostic.
>
> 5. Jumps to the common tail, skipping the normal
>    fit_image_get_data() + memcpy() sequence since data is already
>    at its final location.
>
> The entire path is gated by 'if (images->loader && external)' and
> USE_HOSTCC, so the existing in-memory flow is completely unchanged
> when no loader is set or when building host tools.
>
> For inline-data FIT images (no data-position/data-offset), the FDT
> structure loaded during format detection already contains all sub-
> image data, so the existing path handles them correctly.
>
> Also adds a 'struct image_loader *loader' member to struct
> bootm_headers (initialised to NULL).
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/image-fit.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/image.h  |  4 ++
>  2 files changed, 100 insertions(+)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 3ed69b5f7bc..73d3bf7df08 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -24,6 +24,7 @@ extern void *aligned_alloc(size_t alignment, size_t siz=
e);
>  #include <linux/sizes.h>
>  #include <errno.h>
>  #include <log.h>
> +#include <image-loader.h>
>  #include <mapmem.h>
>  #include <asm/io.h>
>  #include <malloc.h>
> @@ -2166,6 +2167,100 @@ int fit_image_load(struct bootm_headers *images, =
ulong addr,
>
>         printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
>
> +#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGE_LOADER)

This function is far too long so this code should go in its own
function. Also use if() and tools_build()

> +       /*
> +        * Storage-backed path: when an image_loader is active and the
> +        * sub-image uses external data, load the payload from storage
> +        * instead of dereferencing fit + data_offset. The FDT structure
> +        * (containing all metadata, hashes, and signatures) is already
> +        * in RAM; only the payload is on storage.
> +        *
> +        * Sequence:
> +        *  1. Print image info (fit_image_select with verify=3D0)
> +        *  2. Extract data location from FDT properties (no data access)
> +        *  3. Skip IH_TYPE_FILESYSTEM sub-images =E2=80=94 they stay on =
storage
> +        *  4. Determine RAM destination (load address or scratch area)
> +        *  5. Read payload via image_loader_map_to() / image_loader_map(=
)
> +        *  6. Verify hash/signature in-place
> +        *  7. Jump to common tail (FDT validation, output params)
> +        */
> +       if (images && images->loader) {
> +               int data_off =3D 0, data_sz =3D 0;
> +               bool external =3D false;
> +               u8 img_type;
> +
> +               if (!fit_image_get_data_position(fit, noffset, &data_off)=
) {
> +                       external =3D true;
> +               } else if (!fit_image_get_data_offset(fit, noffset, &data=
_off)) {
> +                       external =3D true;
> +                       data_off +=3D ALIGN(fdt_totalsize(fit), 4);
> +               }
> +
> +               if (external && !fit_image_get_data_size(fit, noffset, &d=
ata_sz)) {
> +                       /* Print image info without verifying data */
> +                       ret =3D fit_image_select(fit, noffset, 0);
> +                       if (ret) {
> +                               bootstage_error(bootstage_id + BOOTSTAGE_=
SUB_HASH);
> +                               return ret;
> +                       }
> +
> +                       /* Skip filesystem images =E2=80=94 they stay on =
storage */
> +                       if (!fit_image_get_type(fit, noffset, &img_type) =
&&
> +                           img_type =3D=3D IH_TYPE_FILESYSTEM) {
> +                               *datap =3D 0;
> +                               *lenp =3D 0;
> +                               return noffset;

Should add a comment here about why you are not doing verification. I
assume the FS is protected with dm-verify, iwc should the root hash be
stored in the FIT?

> +                       }
> +
> +                       len =3D data_sz;
> +                       comp =3D IH_COMP_NONE;
> +                       fit_image_get_comp(fit, noffset, &comp);
> +
> +                       /* Determine the RAM destination */
> +                       if (load_op =3D=3D FIT_LOAD_IGNORED) {
> +                               loadbuf =3D image_loader_map(images->load=
er,
> +                                                          data_off, len)=
;
> +                       } else if (!fit_image_get_load(fit, noffset, &loa=
d)) {
> +                               printf("   Loading %s from storage to 0x%=
08lx\n",
> +                                      prop_name, load);
> +                               loadbuf =3D map_sysmem(load, len);
> +                               loadbuf =3D image_loader_map_to(images->l=
oader,
> +                                                             data_off, l=
en,
> +                                                             loadbuf);
> +                       } else if (load_op =3D=3D FIT_LOAD_REQUIRED) {
> +                               printf("Can't get %s subimage load addres=
s!\n",
> +                                      prop_name);
> +                               return -EBADF;
> +                       } else {
> +                               loadbuf =3D image_loader_map(images->load=
er,
> +                                                          data_off, len)=
;
> +                       }
> +
> +                       if (!loadbuf) {
> +                               printf("Failed to load %s from storage\n"=
,
> +                                      prop_name);
> +                               return -EIO;
> +                       }
> +
> +                       load =3D map_to_sysmem(loadbuf);
> +
> +                       /* Verify hash/signature in-place */
> +                       if (images->verify) {
> +                               puts("   Verifying Hash Integrity ... ");
> +                               if (!fit_image_verify_with_data(fit, noff=
set,
> +                                                               gd_fdt_bl=
ob(),
> +                                                               loadbuf, =
len)) {
> +                                       puts("Bad Data Hash\n");
> +                                       return -EACCES;
> +                               }
> +                               puts("OK\n");
> +                       }
> +
> +                       goto storage_loaded;
> +               }
> +       }
> +#endif /* !USE_HOSTCC && CONFIG_IMAGE_LOADER */
> +
>         ret =3D fit_image_select(fit, noffset, images->verify);
>         if (ret) {
>                 bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
> @@ -2325,6 +2420,7 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
>                 puts("WARNING: 'compression' nodes for ramdisks are depre=
cated,"
>                      " please fix your .its file!\n");
>
> +storage_loaded:
>         /* verify that image data is a proper FDT blob */
>         if (load_op !=3D FIT_LOAD_IGNORED && image_type =3D=3D IH_TYPE_FL=
ATDT &&
>             fdt_check_header(loadbuf)) {
> diff --git a/include/image.h b/include/image.h
> index 34efac6056d..ecb3fec26c0 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -345,6 +345,8 @@ struct image_info {
>         uint8_t         arch;                   /* CPU architecture */
>  };
>
> +struct image_loader;
> +
>  /*
>   * Legacy and FIT format headers used by do_bootm() and do_bootm_<os>()
>   * routines.
> @@ -400,6 +402,8 @@ struct bootm_headers {
>
>         int             verify;         /* env_get("verify")[0] !=3D 'n' =
*/
>
> +       struct image_loader *loader;    /* on-demand storage loader, or N=
ULL */
> +
>  #define BOOTM_STATE_START      0x00000001
>  #define BOOTM_STATE_FINDOS     0x00000002
>  #define BOOTM_STATE_FINDOTHER  0x00000004
> --
> 2.53.0

Regards,
Simon
