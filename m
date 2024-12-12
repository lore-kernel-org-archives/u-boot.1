Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C541E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 21:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31D280192;
	Thu, 12 Dec 2024 22:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GI+RPEda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27D980196; Thu, 12 Dec 2024 22:58:48 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B818018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 22:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6eff0f3306fso9138307b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734040725; x=1734645525; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vap7Ezli9H2IsG2Yn3N7fVrtVMQ0LG3GrVbPZd08cKY=;
 b=GI+RPEda9uz+ui6xPnPWrlios4WgYhwjeYK0Z6MuJu6KEA9ZCVmcsrrdlvTqa/QZ3u
 uK43qqDN/rn0NXY1tAWqiF/xYTUKGiIqL8mmNxf75s7nG6S/YttS4T6dbnZv7u9OF/B+
 SA8kEU/n+dYLK075CuEOwD+gX7yr5WQzMD0CrVH9whPK2RzS8lCYJLuEgK0wIdkcME9K
 Bb4mORvbLnuwUt3OPvv/rUjyv1nR/k18Eo+SOi1WZQ45fXTAMxORfPf35XEr4dZN/uaK
 3FFKoVSr77oDSAlarwqfejwjjVHdE6fTkzefs3HOeEfqdXjwwy0rmF2kPCN6KJTwRYH4
 fHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734040725; x=1734645525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vap7Ezli9H2IsG2Yn3N7fVrtVMQ0LG3GrVbPZd08cKY=;
 b=liYKcc1y75jBxHsOEFnMNI5vSQYM2kO8NpNZe2S/5pHa2VSy2T83bJdIp/Pfj5uUdf
 MRT2y8NmW/mnAF/Ml4rjhpMxTaoOQ71xHehJrdCeaPcxzIkiZEFSUk46jW1E3FGgbJB2
 4recU6j4sn1iLJNslP6KM6IuXFUZrSyvWBxduRBAf9I2HTCrwVZ7LmDJHVJVnaFy3dLp
 tI85eUWm5uoK8uJDheJd8733/uymlYYIemYm6Is++ACyoCd4wMUCIU1x8EReyrQ10kmg
 1ikXsIv5hZgpX+x4Fcz4e1UcX8C4+pnnUyY4OYpCRRSiU0Anq22Am7T7DjFIOfBYfZxJ
 3HdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB82cKtsNTNLbtjEdOADVKp0QARGS4HWiCQamFlrNahYB7qFOkD3UA7/fYnxGP1HFGNAndv3Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyF40fGRESg5ABXPpbeolLY+sn0AWUAZ69OmdB79cLvur7/acz3
 L6OOK8ChmxH878BwA4Nb3bC+MtrTgfrTyZEkepAThL2eoKLqcFpV19G4YJOaJUKAR+56qxQ8LlO
 X+fkYH4xvwZodB5a4I2iwu3aqbko9ymJIW3JWZQ==
X-Gm-Gg: ASbGncuSfV7Wk0JTgtOy/tQQx2s8ZC1XT8MWnctS/6cVYag4fdFvjLDBQJU3cStswNj
 369o6NP3Bx12ikn5Xb1Q9C8WwXEUQqv0mdKXVLQ==
X-Google-Smtp-Source: AGHT+IFasLUSqtB/4vlVnV89WWp8mGODVNAtok+AYBAJ+5E+4g0RIHBz1Q8AkC8LnOpxkmgcoKuRDmoUyG/MAHYBMo8=
X-Received: by 2002:a05:690c:6382:b0:6e3:37a7:8a98 with SMTP id
 00721157ae682-6f279b1f5e0mr4166997b3.14.1734040724713; Thu, 12 Dec 2024
 13:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-3-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 15:58:33 -0600
Message-ID: <CAPLW+4=yQRE+3PzrhRC2vJ9vqBjhviYWKq2OPOHWjqXA3NxLRA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] lmb: Move enum lmb_flags to a u32
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> LMB flags is not an enum anymore. It's currently used as a bitmask
> in various places of our code. So make it a u32 which is more
> appropriate when dealing with masks.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  boot/image-fdt.c  |  4 ++--
>  include/lmb.h     | 25 +++++++++++--------------
>  lib/lmb.c         | 18 +++++++++---------
>  test/cmd/bdinfo.c |  2 +-
>  4 files changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 73c43c30684f..cda7c3aa9e38 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -68,7 +68,7 @@ static const struct legacy_img_hdr *image_get_fdt(ulong=
 fdt_addr)
>  }
>  #endif
>
> -static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags f=
lags)
> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
>  {
>         long ret;
>
> @@ -100,7 +100,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>         int i, total, ret;
>         int nodeoffset, subnode;
>         struct fdt_resource res;
> -       enum lmb_flags flags;
> +       u32 flags;
>
>         if (fdt_check_header(fdt_blob) !=3D 0)
>                 return;
> diff --git a/include/lmb.h b/include/lmb.h
> index 03d5fac6aa79..7db9e0b62840 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -19,18 +19,15 @@
>  #define LMB_ALIST_INITIAL_SIZE 4
>
>  /**
> - * enum lmb_flags - Definition of memory region attributes
> - * @LMB_NONE: No special request
> - * @LMB_NOMAP: Don't add to MMU configuration
> - * @LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
> - * @LMB_NONOTIFY: Do not notify other modules of changes to this memory =
region
> - */
> -enum lmb_flags {
> -       LMB_NONE                =3D 0,
> -       LMB_NOMAP               =3D BIT(1),
> -       LMB_NOOVERWRITE         =3D BIT(2),
> -       LMB_NONOTIFY            =3D BIT(3),
> -};
> + * LMB_NONE: No special request
> + * LMB_NOMAP: Don't add to MMU configuration
> + * LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
> + * LMB_NONOTIFY: Do not notify other modules of changes to this memory r=
egion
> + */

This causes a kernel-doc warning:

$ scripts/kernel-doc -v -none include/lmb.h

    include/lmb.h:22: warning: missing initial short description on line:
     * LMB_NONE: No special request

Suggest using DOC stanza in this kernel-doc comment, as described at
[1], like this:

/**
 * DOC: Memory region attribute flags.
 *
 * %LMB_NONE: No special request
 * %LMB_NOMAP: Don't add to MMU configuration
 * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
 * %LMB_NONOTIFY: Do not notify other modules of changes to this memory reg=
ion
 */

That's helpful if you want to keep Sphinx generated doc [2] for LMB
subsystem tidy.

Other than that, LGTM:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[1] https://docs.kernel.org/doc-guide/kernel-doc.html
[2] https://docs.u-boot.org/en/latest/api/lmb.html

 */

> +#define LMB_NONE 0
> +#define LMB_NOMAP BIT(0)
> +#define LMB_NOOVERWRITE BIT(1)
> +#define LMB_NONOTIFY BIT(2)
>
>  /**
>   * struct lmb_region - Description of one region
> @@ -41,7 +38,7 @@ enum lmb_flags {
>  struct lmb_region {
>         phys_addr_t base;
>         phys_size_t size;
> -       enum lmb_flags flags;
> +       u32 flags;
>  };
>
>  /**
> @@ -101,7 +98,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
>   * * %-1       - Failure
>   */
>  long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
> -                      enum lmb_flags flags);
> +                      u32 flags);
>
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
>  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b9c26cb02e10..edecdb8e9cbf 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -188,7 +188,7 @@ static long lmb_resize_regions(struct alist *lmb_rgn_=
lst,
>   * * %-1       - Failure
>   */
>  static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t =
base,
> -                                phys_size_t size, enum lmb_flags flags)
> +                                phys_size_t size, u32 flags)
>  {
>         unsigned long coalesced =3D 0;
>         long ret, i;
> @@ -201,7 +201,7 @@ static long lmb_add_region_flags(struct alist *lmb_rg=
n_lst, phys_addr_t base,
>         for (i =3D 0; i < lmb_rgn_lst->count; i++) {
>                 phys_addr_t rgnbase =3D rgn[i].base;
>                 phys_size_t rgnsize =3D rgn[i].size;
> -               enum lmb_flags rgnflags =3D rgn[i].flags;
> +               u32 rgnflags =3D rgn[i].flags;
>
>                 ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>                 if (ret > 0) {
> @@ -430,14 +430,14 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t ba=
se, phys_size_t size)
>
>  static struct lmb lmb;
>
> -static bool lmb_should_notify(enum lmb_flags flags)
> +static bool lmb_should_notify(u32 flags)
>  {
>         return !lmb.test && !(flags & LMB_NONOTIFY) &&
>                 CONFIG_IS_ENABLED(EFI_LOADER);
>  }
>
>  static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 =
op,
> -                                enum lmb_flags flags)
> +                                u32 flags)
>  {
>         u64 efi_addr;
>         u64 pages;
> @@ -470,7 +470,7 @@ static int lmb_map_update_notify(phys_addr_t addr, ph=
ys_size_t size, u8 op,
>         return 0;
>  }
>
> -static void lmb_print_region_flags(enum lmb_flags flags)
> +static void lmb_print_region_flags(u32 flags)
>  {
>         const char * const flag_str[] =3D { "none", "no-map", "no-overwri=
te",
>                                           "no-notify" };
> @@ -495,7 +495,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst=
, char *name)
>  {
>         struct lmb_region *rgn =3D lmb_rgn_lst->data;
>         unsigned long long base, size, end;
> -       enum lmb_flags flags;
> +       u32 flags;
>         int i;
>
>         printf(" %s.count =3D %#x\n", name, lmb_rgn_lst->count);
> @@ -669,7 +669,7 @@ long lmb_free(phys_addr_t base, phys_size_t size)
>         return lmb_free_flags(base, size, LMB_NONE);
>  }
>
> -long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flag=
s flags)
> +long lmb_reserve_flags(phys_addr_t base, phys_size_t size, u32 flags)
>  {
>         long ret =3D 0;
>         struct alist *lmb_rgn_lst =3D &lmb.used_mem;
> @@ -687,7 +687,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
>  }
>
>  static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> -                                  phys_addr_t max_addr, enum lmb_flags f=
lags)
> +                                  phys_addr_t max_addr, u32 flags)
>  {
>         int ret;
>         long i, rgn;
> @@ -774,7 +774,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ul=
ong align,
>  }
>
>  static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> -                                  enum lmb_flags flags)
> +                                  u32 flags)
>  {
>         long rgn;
>         struct lmb_region *lmb_memory =3D lmb.free_mem.data;
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index bb419ab2394e..014391b38ac0 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -104,7 +104,7 @@ static int lmb_test_dump_region(struct unit_test_stat=
e *uts,
>  {
>         struct lmb_region *rgn =3D lmb_rgn_lst->data;
>         unsigned long long base, size, end;
> -       enum lmb_flags flags;
> +       u32 flags;
>         int i;
>
>         ut_assert_nextline(" %s.count =3D %#x", name, lmb_rgn_lst->count)=
;
> --
> 2.45.2
>
