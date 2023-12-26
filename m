Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF6C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1FD8793F;
	Tue, 26 Dec 2023 10:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e6URVoA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF93F87922; Tue, 26 Dec 2023 10:48:37 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E8287946
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59496704246so562531eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584112; x=1704188912; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2ye1OJGiTG8bVZaaFqDi7g/QpBeFmMXcN2LGaPkxbA=;
 b=e6URVoA4sqqKWZ4LvAOhbJgTdh+DKKM41NuviYWwdCtSGAIDgQsXD3kBzTtNyiIad1
 WMXC2YzDueN0P/TXS9bnqCpQLTEpciBBH/gpPFdCyFfL/cF2Ks65wJbYV0aOORRn6FIE
 KW3rxcgRhE04Is75oL1fOvarLlqm1ubAJYcYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584112; x=1704188912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2ye1OJGiTG8bVZaaFqDi7g/QpBeFmMXcN2LGaPkxbA=;
 b=nbUAh2lmbttUh3agiztZwzoRamw95owp8BSPxAS0MVF08tV8635CsxSuvWn8ENyWjd
 mCJuG1Awhz1OEXa0Qy6jv9Xe+zJmeGKytx6uLrxmq04v3eBGddxlCPOur3Zo3WJ/ktr6
 g1Px2wnS00Lq4WzMfZX3yPo2QbplDAtZDkDZZUM/7Z9PYAOGeTT0X0MWMosuuJ+XKRjU
 4wGB6H81C8dV9Axlq1qtNQPfrQr9jJzRBLx5pEnyEDMsiW2Ph5n147X1bKCC/pXBm5jH
 Q3x+P8JatSmzYF1dXPn0sZ8qIU3NRNSMN5ZdrFpmPhuXJXk4B0sMoQ87+vCToFatp2g5
 alwQ==
X-Gm-Message-State: AOJu0YwijaPNxBMS3xqtmc9kVSlz1fLeY6AAV53EsLghLqLMgYtVglWt
 WzyPmTlD2yDVvdsk64HZ2w6arar10Cy0NsRYM0dezqCHc1yG
X-Google-Smtp-Source: AGHT+IEDJSl3Z7R7Lexf481SCzk+xKOULN2bz3xJEObXg41WzwKORMUBKEMTDsWApujSLqRz4m6mBa0GdUSgJ3QT5mU=
X-Received: by 2002:a05:6358:899:b0:174:f75e:f2a5 with SMTP id
 m25-20020a056358089900b00174f75ef2a5mr838619rwj.56.1703584112179; Tue, 26 Dec
 2023 01:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-8-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-8-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:46 +0000
Message-ID: <CAFLszThaqOzjxQdpn2y_s2eJWw1oXihJMPFxD4-02LBGcLq4Qg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] bloblist: Load the bloblist from the previous
 loader
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <sean.anderson@seco.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
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

Hi Raymond,

On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> During bloblist initialization, when CONFIG_OF_BOARD is defined,
> invoke the platform custom function to load the bloblist via boot
> arguments from the previous loader.
> If the bloblist exists, copy it into the fixed bloblist memory region.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  | 47 ++++++++++++++++++++++++++++------------------
>  include/bloblist.h | 16 ++++++++++++++++
>  2 files changed, 45 insertions(+), 18 deletions(-)
>

We should not be using OF_BOARD for this...particularly as I
understood our intent was to make it go away.

For now I would like to have OF_BLOBLIST, with OF_BOARD being the
fallback for when we need board-specific things. See [1]. It is also
very important that U-Boot reports that the DT came from a bloblist.

Perhaps I should send just that patch so that Ilias and I can figure it out=
.

> diff --git a/common/bloblist.c b/common/bloblist.c
> index 5ad1db137a..e66afcde64 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -492,31 +492,38 @@ int bloblist_init(void)
>         bool fixed =3D IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret =3D -ENOENT;
>         ulong addr, size;
> -       bool expected;
> -
> -       /**
> -        * We don't expect to find an existing bloblist in the first phas=
e of
> -        * U-Boot that runs. Also we have no way to receive the address o=
f an
> -        * allocated bloblist from a previous stage, so it must be at a f=
ixed
> +       /*
> +        * If U-Boot is not in the first phase, an existing bloblist must=
 be
> +        * at a fixed address.

BTW there is now BLOBLIST_ALLOC

> +        */
> +       bool from_addr =3D fixed && !u_boot_first_phase();
> +       /*
> +        * If U-Boot is in the first phase that a board specific routine =
should
> +        * install the bloblist passed from previous loader to this fixed
>          * address.
>          */
> -       expected =3D fixed && !u_boot_first_phase();
> +       bool from_board =3D fixed && IS_ENABLED(CONFIG_OF_BOARD) &&
> +                         u_boot_first_phase();
> +
>         if (spl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_B=
LOBLIST))
> -               expected =3D false;
> +               from_addr =3D false;
>         if (fixed)
>                 addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>                                       CONFIG_BLOBLIST_ADDR);
>         size =3D CONFIG_BLOBLIST_SIZE;
> -       if (expected) {
> +
> +       if (from_board)
> +               ret =3D board_bloblist_from_boot_arg(addr, size);
> +       else if (from_addr)
>                 ret =3D bloblist_check(addr, size);
> -               if (ret) {
> -                       log_warning("Expected bloblist at %lx not found (=
err=3D%d)\n",
> -                                   addr, ret);
> -               } else {
> -                       /* Get the real size, if it is not what we expect=
ed */
> -                       size =3D gd->bloblist->total_size;
> -               }
> -       }
> +
> +       if (ret)
> +               log_warning("Bloblist at %lx not found (err=3D%d)\n",
> +                           addr, ret);
> +       else
> +               /* Get the real size */
> +               size =3D gd->bloblist->total_size;
> +
>         if (ret) {
>                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
>                         void *ptr =3D memalign(BLOBLIST_ALIGN, size);
> @@ -525,7 +532,8 @@ int bloblist_init(void)
>                                 return log_msg_ret("alloc", -ENOMEM);
>                         addr =3D map_to_sysmem(ptr);
>                 } else if (!fixed) {
> -                       return log_msg_ret("!fixed", ret);
> +                       return log_msg_ret("BLOBLIST_FIXED is not enabled=
",
> +                                          ret);
>                 }
>                 log_debug("Creating new bloblist size %lx at %lx\n", size=
,
>                           addr);
> @@ -538,6 +546,9 @@ int bloblist_init(void)
>                 return log_msg_ret("ini", ret);
>         gd->flags |=3D GD_FLG_BLOBLIST_READY;
>
> +       bloblist_show_stats();
> +       bloblist_show_list();

Can you put those two lines behind a BLOBLIST_DEBUG option, perhaps?

> +
>         return 0;
>  }
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index c1dab11f78..2f4246576e 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -445,6 +445,22 @@ int bloblist_reloc(void *to, uint to_size);
>   */
>  int bloblist_init(void);
>
> +#if (IS_ENABLED(CONFIG_ARCH_QEMU) && IS_ENABLED(CONFIG_ARM))
> +/* Board custom function for qemu-arm */
> +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)=
;
> +#else
> +/*
> + * A board need to implement this custom function if it needs to retriev=
e
> + * bloblist from a previous loader
> + */
> +static inline
> +int board_bloblist_from_boot_arg(unsigned long __always_unused addr,
> +                                unsigned long __always_unused size)
> +{
> +       return -1;
> +}
> +#endif
> +
>  #if CONFIG_IS_ENABLED(BLOBLIST)
>  /**
>   * bloblist_maybe_init() - Init the bloblist system if not already done
> --
> 2.25.1
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230924192536.1812799=
-37-sjg@chromium.org/
