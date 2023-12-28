Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69609C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB19687A92;
	Thu, 28 Dec 2023 14:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzA80U/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0BF87A01; Thu, 28 Dec 2023 14:37:52 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C004B87A61
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-594faa235e3so213743eaf.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770669; x=1704375469; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2Wueqh+gYEsEyYUtNgwNsUEFNpzfMBqbrbno1ULJjk=;
 b=kzA80U/SNn/DHrNBRbd78ru4rcMVcdVDgzle3UK/aNgj5CLcOfaW2Vat4Fnwxzx5SD
 gkAgaohrkcSCzEgTNb+6iETrqmYLzpTmqsmBlOTUA2a5eypavUD/wYXu3zy1Kbe7kyO3
 GtGq3oDvMzzZM8mKykEBv/o075Bf4T+0gnWEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770669; x=1704375469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2Wueqh+gYEsEyYUtNgwNsUEFNpzfMBqbrbno1ULJjk=;
 b=u6a/c71HlkF1t5MMvdZXb0KrDn0A5uxYLbic9NE5vBObPIIT2Pcpp1jyjDaPV5dI7l
 O3eMERvrRRCvLtb1itf2qR4WssiCcoKu+a7Atypl5kXDYAYUyF09AufJHYri2DLnruzv
 FTgTX0OgutIT9Lt7HT94r4GiCE4vnRkKuydjbvKzCyCreBxw2gjSUsklGB8c2Wr6pbaA
 9SVx6MSMHRAhx0KVTy5iQQZ3enGHl3vZ4tpFEOGh0maLbKiqPpiyej/V6Yf2xNdv56C4
 kD1pXU5/yRUaSyXK7iScO1koNtckEs3bTi1HQZjKQd+5twDRlAWPo9g0TpvDffI245Fm
 KZ1w==
X-Gm-Message-State: AOJu0YwCKyBcKQ/ZvcWXgkrOcYiaDrQIDGIWZ+0W/YAZHyxC7a4Fw36Z
 ZgLDaTJgYa7S7jjfpZQZOsCcc6+AJrOw4NmjwXFzsjcYjxMefRqN0LHKGzU=
X-Google-Smtp-Source: AGHT+IEVqzlcjhNnA55dS+rvQ2fIHuLYTT5PtWpLfkDSAu06n5Ab//ZMc0TG0cF4aXPqgGeLiCkByUxP2+1sWmF61Wo=
X-Received: by 2002:a05:6358:514d:b0:170:17eb:9c45 with SMTP id
 13-20020a056358514d00b0017017eb9c45mr11333072rwj.38.1703770669363; Thu, 28
 Dec 2023 05:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-7-raymond.mao@linaro.org>
 <CAFLszTjoViZAxZy26k4aXuoBhvzt_P8zBwqx8Kr8wPHFns1RRQ@mail.gmail.com>
 <CAEfUkUKfC380JOkuz+x_vRVr2R2KXfJQ6gzKaS4fW55BkW5EFg@mail.gmail.com>
In-Reply-To: <CAEfUkUKfC380JOkuz+x_vRVr2R2KXfJQ6gzKaS4fW55BkW5EFg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:16 +0000
Message-ID: <CAFLszTjg3nomL7AU-3_+-DdG4_=aS54g9GBzx6fPZvbTSwH4WQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] qemu-arm: Get bloblist from boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
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

On Wed, Dec 27, 2023 at 4:21=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Simon,
>
> On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.=
org> wrote:
>> >
>> > Add platform custom function to get bloblist from boot arguments.
>> > Check whether boot arguments aligns with the register conventions
>> > defined in FW Handoff spec v0.9.
>> > Add bloblist related options into qemu default config.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Remove low level code for copying boot arguments.
>> > - Refactor board_fdt_blob_setup() and remove direct access of gd->blob=
list.
>> > Changes in v3
>> > - Optimize board_bloblist_from_boot_arg().
>> >
>> >  board/emulation/qemu-arm/qemu-arm.c | 30 ++++++++++++++++++++++++++++=
+
>> >  configs/qemu_arm64_defconfig        |  3 +++
>> >  2 files changed, 33 insertions(+)
>> >
>> > diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qem=
u-arm/qemu-arm.c
>> > index 942f1fff57..e225011bf0 100644
>> > --- a/board/emulation/qemu-arm/qemu-arm.c
>> > +++ b/board/emulation/qemu-arm/qemu-arm.c
>> > @@ -4,6 +4,7 @@
>> >   */
>> >
>> >  #include <common.h>
>> > +#include <bloblist.h>
>> >  #include <cpu_func.h>
>> >  #include <dm.h>
>> >  #include <efi.h>
>> > @@ -102,6 +103,15 @@ static struct mm_region qemu_arm64_mem_map[] =3D =
{
>> >  struct mm_region *mem_map =3D qemu_arm64_mem_map;
>> >  #endif
>> >
>> > +/*
>> > + * Boot parameters saved from start.S
>> > + * saved_args[0]: FDT base address
>> > + * saved_args[1]: Bloblist signature
>> > + * saved_args[2]: must be 0
>> > + * saved_args[3]: Bloblist base address
>> > + */
>> > +extern unsigned long saved_args[];
>> > +
>> >  int board_init(void)
>> >  {
>> >         return 0;
>> > @@ -144,6 +154,26 @@ void *board_fdt_blob_setup(int *err)
>> >         return (void *)CFG_SYS_SDRAM_BASE;
>> >  }
>> >
>> > +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long si=
ze)
>> > +{
>> > +       int ret =3D -ENOENT;
>> > +
>> > +       if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIS=
T))
>> > +               return -ENOENT;
>> > +
>> > +       ret =3D bloblist_check(saved_args[3], size);
>> > +       if (ret)
>> > +               return ret;
>>
>> What about saved_args[1] ?
>>
> The magic and version of register conventions cannot be checked now since=
 there is
> a bug in the spec. PSB:
> ```
> X1[23:0]: set to the TL signature (4a0f_b10b)
> X1[31:24]: version of the register convention used. Set to 1 for the AArc=
h64 convention specified in this document.
> ```
> Signature (4a0f_b10b) takes all [31:0] and no space for version of the re=
gister convention.
> This needs to be updated on TF-A and OP-TEE as well after the spec is upd=
ated.
> For now I will just skip the checking.
>
>>
>> > +
>> > +       /* Check the register conventions */
>> > +       ret =3D bloblist_check_reg_conv(saved_args[0], saved_args[2]);
>> > +       if (!ret)
>> > +               /* Relocate the bloblist to the fixed address */
>> > +               ret =3D bloblist_reloc((void *)addr, CONFIG_BLOBLIST_S=
IZE);
>> > +
>> > +       return ret;
>> > +}
>> > +
>>
>> This should be a generic function, e.g. in arch/arm
>>
> I didn't find a place under arch/arm that is good for connect with the sa=
ved boot
> args. Do you have any suggestions?

How about arch/arm/lib/bloblist.c ?

>
> [...]

Regards,
Simon
