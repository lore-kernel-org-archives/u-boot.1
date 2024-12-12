Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE6EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11AD7800A5;
	Thu, 12 Dec 2024 23:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X7TV/i3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B12801B0; Thu, 12 Dec 2024 23:43:52 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B61F80092
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6ef81222aaaso12239907b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734043429; x=1734648229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIKOoGpm3jA0IjSByx5Io7aLMpyr7y6njGmZXevjdac=;
 b=X7TV/i3pPxpqjhVZPxdWj5LScxz7vKeUU7mbp/dJAIXWdVbFkv2W2BavKXiupZ0YuP
 jPC0ENo/BxK1SjpPHd5bUt1Wt+UsJwfBQ/auO6M9ANNnyKMVH10Kj0qDT1dVTGY5bCKj
 nCiRPNsKqKaoqadwBWuF+CwAG6/+KthrO1IHXy2udQJDW38Nmo8qjJ3BLG6HitGJeKRQ
 9ZrX+X3IRZdvA7xzjGakfSo4nD/3SanLkxP8ihzQzuqR83JMxeXWMPQSu6ilEZtsKRnU
 g5N2CE1WQBN3ziKmNbi7R634tjhbpA+j0J4kHLPu//YiKkwdzAVcVP9mMl8MQNLYGdw/
 /0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734043429; x=1734648229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIKOoGpm3jA0IjSByx5Io7aLMpyr7y6njGmZXevjdac=;
 b=dwjmVmja+cHQHH/xqmQcYdJZlXojp1amedWjMBLXECvpoRtCSy/x4cNWamn4nEzfcC
 9EKiKlYaBGe1UIsFjH8WcHiCPGtKDQFetIh/x0Q2K0cWcgn2oYlgihFFWIOkt2C6kdV8
 +3rNBxEU6tMPKLzjzHbC7Kpw/lui/IuI6VHC/bewZIpRlUMYFnhQ94Iil6DArOYJ/cyI
 luiAhok6xdwph3AAtIsqq7Al5PBEltsn9wXiSn2hufEzqQcJ/s1ZqnfgJqlUqdH0uQHD
 x12IoliJvsCkL3Ij9JVU7PcqIpGQcdZ49Rf3CHfS8ZFPgkzRhsqcL/hv5W1A6quAWJIs
 oYDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+UDtreD3IWzyBYiZ6pbfaq3LCG8EQNlhHbU1yNUMvzvJ45N4l+sWZbaPKNF7vU/maTiiOlCQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtr2a09YXDDY/BA7KorYkKReV/0mo3IdM/v1W4wQ1qEwXABjq0
 19DVaPF9NO9JDqF50QXNkd8jzkarvGA4qSxFqPaMNJz2nbTq4PqDQht85AzJ+jHaFb7dgKHdoVB
 73xevCD+T1Tt9VnplN1YxNIpjVzfEG9PBPaHmSQ==
X-Gm-Gg: ASbGnctisHDAlJ5K/qxftjiA+Tru9rECXTlZU5NWtbY/tfNdPykoCZ62MGYE7ttlnSx
 1Fv9VOdlKS6Qk4yZaRvd0nFhNQeLiGyXJBrkIBw==
X-Google-Smtp-Source: AGHT+IHFpxzR++A+Gc/EJlDRfZvYv5bcrTVs7MnibGq7E1c4J78qY1zc5QKTJ549wJk6/+Uw94eQW8jOpt50ltzb2Ss=
X-Received: by 2002:a05:690c:450c:b0:6ef:5119:fc2e with SMTP id
 00721157ae682-6f279b9e618mr4088327b3.42.1734043429000; Thu, 12 Dec 2024
 14:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-8-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-8-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:43:36 -0600
Message-ID: <CAPLW+4nmm-r78qXgi7Ynj1RnoyXfC9+Gt18FTbVu_L5_1_psEA@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] lmb: Remove lmb_alloc_base_flags()
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
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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
> lmb_alloc_base() is just calling lmb_alloc_base_flags() with LMB_NONE.
> There's not much we gain from this abstraction, so let's remove the
> former add the flags argument to lmb_alloc_base() and make the code
> a bit easier to follow.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  boot/image-board.c          | 18 +++++++++++-------
>  boot/image-fdt.c            |  5 +++--
>  include/lmb.h               |  7 +++----
>  lib/efi_loader/efi_memory.c |  4 ++--
>  lib/lmb.c                   | 19 +++----------------
>  test/lib/lmb.c              |  8 ++++----
>  6 files changed, 26 insertions(+), 35 deletions(-)
>
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 070ada007185..4e86a9a22719 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -565,9 +565,11 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, u=
long *initrd_start,
>                         lmb_reserve(rd_data, rd_len, LMB_NONE);
>                 } else {
>                         if (initrd_high)
> -                               *initrd_start =3D (ulong)lmb_alloc_base(r=
d_len,
> -                                                                     0x1=
000,
> -                                                                     ini=
trd_high);
> +                               *initrd_start =3D
> +                                       (ulong)lmb_alloc_base(rd_len,
> +                                                                   0x100=
0,
> +                                                                   initr=
d_high,
> +                                                                   LMB_N=
ONE);
>                         else
>                                 *initrd_start =3D (ulong)lmb_alloc(rd_len=
,
>                                                                  0x1000);
> @@ -839,7 +841,8 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end=
)
>
>         barg =3D IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_B=
ARGSIZE);
>         cmdline =3D (char *)(ulong)lmb_alloc_base(barg, 0xf,
> -                               env_get_bootm_mapsize() + env_get_bootm_l=
ow());
> +                               env_get_bootm_mapsize() + env_get_bootm_l=
ow(),
> +                               LMB_NONE);
>         if (!cmdline)
>                 return -1;
>
> @@ -872,9 +875,10 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_en=
d)
>  int boot_get_kbd(struct bd_info **kbd)
>  {
>         *kbd =3D (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd=
_info),
> -                                                      0xf,
> -                                                      env_get_bootm_maps=
ize() +
> -                                                      env_get_bootm_low(=
));
> +                                                            0xf,
> +                                                            env_get_boot=
m_mapsize() +
> +                                                            env_get_boot=
m_low(),
> +                                                            LMB_NONE);
>         if (!*kbd)
>                 return -1;
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index d717f6690729..9d1598b1a93c 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -187,7 +187,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_=
size)
>                         lmb_reserve(map_to_sysmem(of_start), of_len, LMB_=
NONE);
>                         disable_relocation =3D 1;
>                 } else if (desired_addr) {
> -                       addr =3D lmb_alloc_base(of_len, 0x1000, desired_a=
ddr);
> +                       addr =3D lmb_alloc_base(of_len, 0x1000, desired_a=
ddr,
> +                                             LMB_NONE);
>                         of_start =3D map_sysmem(addr, of_len);
>                         if (of_start =3D=3D NULL) {
>                                 puts("Failed using fdt_high value for Dev=
ice Tree");
> @@ -216,7 +217,7 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_=
size)
>                          * for LMB allocation.
>                          */
>                         usable =3D min(start + size, low + mapsize);
> -                       addr =3D lmb_alloc_base(of_len, 0x1000, usable);
> +                       addr =3D lmb_alloc_base(of_len, 0x1000, usable, L=
MB_NONE);
>                         of_start =3D map_sysmem(addr, of_len);
>                         /* Allocation succeeded, use this block. */
>                         if (of_start !=3D NULL)
> diff --git a/include/lmb.h b/include/lmb.h
> index 5e59915340b7..d481972a6686 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -91,11 +91,10 @@ long lmb_add(phys_addr_t base, phys_size_t size);
>  long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
>
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
> -phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr);
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
>
>  /**
> - * lmb_alloc_base_flags() - Allocate specified memory region with specif=
ied
> + * lmb_alloc_base() - Allocate specified memory region with specified
>   *                         attributes
>   * @size: Size of the region requested
>   * @align: Alignment of the memory region requested
> @@ -108,8 +107,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
>   *
>   * Return: Base address on success, 0 on error.
>   */
> -phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> -                                phys_addr_t max_addr, uint flags);
> +phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr,
> +                          uint flags);
>
>  /**
>   * lmb_alloc_addr() - Allocate specified memory address with specified a=
ttributes
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 34e2b9e18ef0..1212772471e3 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -472,7 +472,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,
>         switch (type) {
>         case EFI_ALLOCATE_ANY_PAGES:
>                 /* Any page */
> -               addr =3D (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE,
> +               addr =3D (u64)lmb_alloc_base(len, EFI_PAGE_SIZE,
>                                                  LMB_ALLOC_ANYWHERE, flag=
s);
>                 if (!addr)
>                         return EFI_OUT_OF_RESOURCES;
> @@ -480,7 +480,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,
>         case EFI_ALLOCATE_MAX_ADDRESS:
>                 /* Max address */
>                 addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> -               addr =3D (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, ad=
dr,
> +               addr =3D (u64)lmb_alloc_base(len, EFI_PAGE_SIZE, addr,
>                                                  flags);
>                 if (!addr)
>                         return EFI_OUT_OF_RESOURCES;
> diff --git a/lib/lmb.c b/lib/lmb.c
> index ffad7ec12eb5..bdaaa634abd1 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -731,24 +731,11 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size=
, ulong align,
>
>  phys_addr_t lmb_alloc(phys_size_t size, ulong align)
>  {
> -       return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
> +       return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
>  }
>
> -phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr)
> -{
> -       phys_addr_t alloc;
> -
> -       alloc =3D _lmb_alloc_base(size, align, max_addr, LMB_NONE);
> -
> -       if (alloc =3D=3D 0)
> -               printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx=
.\n",
> -                      (ulong)size, (ulong)max_addr);
> -
> -       return alloc;
> -}
> -
> -phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> -                                phys_addr_t max_addr, uint flags)
> +phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t ma=
x_addr,
> +                          uint flags)
>  {
>         phys_addr_t alloc;
>
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 971614fd8314..fcb5f1af532a 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -128,7 +128,7 @@ static int test_multi_alloc(struct unit_test_state *u=
ts, const phys_addr_t ram,
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 2, alloc_64k_addr, 0x10000,
>                    ram_end - 4, 4, 0, 0);
>         /* alloc below end of reserved region -> below reserved region */
> -       b =3D lmb_alloc_base(4, 1, alloc_64k_end);
> +       b =3D lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
>         ut_asserteq(b, alloc_64k_addr - 4);
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>                    alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0)=
;
> @@ -138,7 +138,7 @@ static int test_multi_alloc(struct unit_test_state *u=
ts, const phys_addr_t ram,
>         ut_asserteq(c, ram_end - 8);
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>                    alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0)=
;
> -       d =3D lmb_alloc_base(4, 1, alloc_64k_end);
> +       d =3D lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
>         ut_asserteq(d, alloc_64k_addr - 8);
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>                    alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0)=
;
> @@ -163,7 +163,7 @@ static int test_multi_alloc(struct unit_test_state *u=
ts, const phys_addr_t ram,
>                    alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
>                    ram_end - 8, 4);
>         /* allocate again to ensure we get the same address */
> -       b2 =3D lmb_alloc_base(4, 1, alloc_64k_end);
> +       b2 =3D lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
>         ut_asserteq(b, b2);
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
>                    alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0)=
;
> @@ -363,7 +363,7 @@ static int test_noreserved(struct unit_test_state *ut=
s, const phys_addr_t ram,
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0)=
;
>
>         /* allocate a block with base*/
> -       b =3D lmb_alloc_base(alloc_size, align, ram_end);
> +       b =3D lmb_alloc_base(alloc_size, align, ram_end, LMB_NONE);
>         ut_assert(a =3D=3D b);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
>                    ram + ram_size - alloc_size_aligned,
> --
> 2.45.2
>
