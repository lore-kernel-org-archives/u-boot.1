Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D017AC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 08:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E28687F01;
	Thu, 14 Mar 2024 09:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="neJ4LVFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA4E87C61; Thu, 14 Mar 2024 09:35:13 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE8887EA8
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 09:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so7472391fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710405311; x=1711010111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2R/m/CNPuU0lgHGQDWwqvcUZWvrFR0HMS7J2dsiOkA=;
 b=neJ4LVFHTePB76LUR3xUHXS+ULimy6EL2NZiCEvC4Ww0B7bcyEwCbEWXmxPZTTgS+e
 mxtusOpMuUIhPxY0IcWJEPSxvl2sMn6EFKbfJThrl0QJYBlTikJEiQh3qV4vKwyF6QeV
 bRLsMdXqtpsyzBC+2tUVo93438xm8pw740IhrQ/NbZzfA4Kf25mM1dxctbz7KmnwKzgy
 e7fxOFJEx7l0ZyfFtaU8F3Wo0uzzGbAw2ikcMA/B9M5W/FceyYRShAcpyyN+cfHFOUDd
 ybXqwgn1bp2yV3wiE/nERPsNI8VfcbiVg16kwOyMiuwWPBGVaOpO3pMFIq4dbLV8B/I3
 uP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710405311; x=1711010111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2R/m/CNPuU0lgHGQDWwqvcUZWvrFR0HMS7J2dsiOkA=;
 b=eBpT8y9hkx8OXz1OMOCZ7sGGMf6EZYLxxM5ZO046nEXmR3Vid5WkxIPjmbywcg6xCV
 rObxJai9+Dv1QiyEUgfQw7goSW7eSGZdibBrksaqPtUxLEoiadJ4AJMELIrS1J+q1f+V
 SYzWPFkT8cS2kV3wUqF9Hj15WWTdeGY500t0ihWLW3beLfda2V07/vV69fontbXDbrwu
 lGKI72TWR/oFYk/eQyD//l40QiEBBrMuTeWKgyosGGvBGV8rv22KP8jZgCNWmA7Eqo09
 nH91hE6tbYWHXk6nfkJ3TBuDS56KA2onZTwP2qSkDGBXcSEnkvIuOFZUKRSTtDkiV22A
 e2/g==
X-Gm-Message-State: AOJu0YxpJPqjiWpTdgo6r8ACS8cymZtWaTTzgkqaRfhIoH0wno03LO3z
 0k+h9/BTm+4UBuJ3xi6k7yhVfChg75o6b5ezIh3Cjmo6EwYRc6DxCpUOT8fQgIo1Fe3hOIyco8m
 picqUxcABpbchkVxdvINnCn8tIrxBTjiZO5iz2Q==
X-Google-Smtp-Source: AGHT+IFQ2S/VrdQ3pIkYYo9ku4W0SoFACXtGos2kDpEH3X4OcLluSKYFnQwnVcOrLindt/leE6vgkP24gIAhZWwRk7s=
X-Received: by 2002:a2e:9c07:0:b0:2d3:ada4:1228 with SMTP id
 s7-20020a2e9c07000000b002d3ada41228mr657444lji.18.1710405310675; Thu, 14 Mar
 2024 01:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
 <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
 <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
 <CAC_iWj+ZmoTWP9jfwupX4cXrf_36YLW+MiTwj0Wyu2e=dLOwRQ@mail.gmail.com>
 <8bcf60a7-ba03-4dfe-926e-f1a77ba4c306@amd.com>
 <CAC_iWjKahx0uJ35J-LcY=hzPnOK2cEzevTRwi0mpAFAgYvnDkA@mail.gmail.com>
In-Reply-To: <CAC_iWjKahx0uJ35J-LcY=hzPnOK2cEzevTRwi0mpAFAgYvnDkA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Mar 2024 10:34:34 +0200
Message-ID: <CAC_iWjKB1qL732uDocmpQx6trb899=4=Ljk4avXMSWzwuZbSaQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Michal

On Wed, 13 Mar 2024 at 09:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 13 Mar 2024 at 08:42, Michal Simek <michal.simek@amd.com> wrote:
> >
> >
> >
> > On 3/12/24 20:12, Ilias Apalodimas wrote:
> > > On Tue, 12 Mar 2024 at 17:55, Michal Simek <michal.simek@amd.com> wrote:
> > >>
> > >>
> > >>
> > >> On 3/12/24 07:14, Ilias Apalodimas wrote:
> > >>> Hi Michal
> > >>>
> > >>> Apologies for the late reply
> > >>>
> > >>> On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 3/5/24 16:47, Ilias Apalodimas wrote:
> > >>>>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
> > >>>>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
> > >>>>>> much this is cover all systems which are using only boot.bin which contains
> > >>>>>> all images inside.
> > >>>>>>
> > >>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> > >>>>>> ---
> > >>>>>>
> > >>>>>>     board/xilinx/common/board.c | 2 +-
> > >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>>
> > >>>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > >>>>>> index 9641ed307b75..4f38b7d27684 100644
> > >>>>>> --- a/board/xilinx/common/board.c
> > >>>>>> +++ b/board/xilinx/common/board.c
> > >>>>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
> > >>>>>>                .image_index = 1,
> > >>>>>>        },
> > >>>>>>     #endif
> > >>>>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> > >>>>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> > >>>>>
> > >>>>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
> > >>>>
> > >>>> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
> > >>>> that string is not empty. If name is "" it will return yes and second image is
> > >>>> doing to be defined.
> > >>>>
> > >>>> But I found handling in the code like this.
> > >>>>
> > >>>>     36 #ifdef CONFIG_DEFAULT_FDT_FILE
> > >>>>     37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
> > >>>>
> > >>>> which can be used in my second patch not to describe second image in
> > >>>> set_dfu_alt_info() if string is empty.
> > >>>
> > >>> Yes, I think that's ok. The problem is that if we merge this as-is, we
> > >>> would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
> > >>> bit misleading
> > >>
> > >> As Heinrich said not just this if you want to do it like this.
> > >> I think you will simply disable the whole SPL which will disable this symbol too.
> > >> But from my perspective SPL payload name is driving this option. Data can end up
> > >> on partition or in raw mode but for dfu you need to use the name.
> > >
> > > Yes, but isn't SPL selected by the Kconfig automatically? I can't seem
> > > to be able to disable it for the kria platforms
> >
> > Not in upstream but via your/AMD build in meta-ts.
> >
> > Thanks,
> > Michal
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Trying to compile xilinx_zynqmp_kria_defconfig with CONFIG_SPL unset
blows up with

 HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  COPY    u-boot.its
cp: missing destination file operand after 'u-boot.its'
Try 'cp --help' for more information.
make: *** [Makefile:1405: u-boot.its] Error 1
make: *** Waiting for unfinished jobs....
  HOSTLD  scripts/dtc/dtc

Cheers
/Ilias
