Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E57C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 19:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C5487150;
	Tue, 12 Mar 2024 20:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="roROjSQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E673871A5; Tue, 12 Mar 2024 20:12:42 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602818709C
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 20:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d288bac3caso66011141fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710270759; x=1710875559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NMivZPzCn3Os1S9ZOZvr5x0D0W+sZ3Yb9R1Bi8G2x8Q=;
 b=roROjSQMRnmu4FToeWYXzQJt08YaF4xIs+d4a1pyfQ0elZlRLh6ynHIRmteIOKQBcl
 GJlyAXynkR05P7Us7sBJ4DQVA0dZs847O8YvqNjtq0HIpowOpn/ZrduotzwtTt/pLVZa
 /03UVs9pKYc1xwDbDnn4s1F8+z8WRUcR9CEnP19m/kuF/+Q2uf3qac8Isc83pam1VmXY
 JiJtEdaRHvDbEFcqhvfAh3NJndiFtcoZy71w9oaOkdsiucdlT0vy2n7fjeYkv9IBx3b/
 RPaO2Z02FJu3FQez5d2ccXSdUr7L9Lafr+hL0//pqKPwoPua9yCeFIqTe01RhwxiZ1UU
 ptrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710270759; x=1710875559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMivZPzCn3Os1S9ZOZvr5x0D0W+sZ3Yb9R1Bi8G2x8Q=;
 b=K6EK1Unz1zaXyl/IgiLOCjVJCTLYJfLdKW0DKhwH4OATV42B+8R9Nzihjgw+73R1SN
 ApCFBNV2mK3cmNbIkyTL1EUdNt4ehWD+MIgKF5LpZ4DYVv7xLsGTmS+qFF6xooq3F6g/
 SQcIe3fAUWTK23w/Y4i4gcmLG7/fNuvgxFp8xjPuWouIdnXopoqx9LizbeY38ggEyfuE
 +g++2Ht6zz7ssSLfgx8Q5vLddQtscp+StGm+waeegbuOTcI9+2GxxACrflPozcyKUZ5o
 aHK3koQULcm96GlZh7/gE+zZofCE413hybB1Wgm99KVj/fumVIE5kdEb2kGrmwPKJLYc
 u9jA==
X-Gm-Message-State: AOJu0YwBQG4IYhYyEItqo/wVg5T4WAPegY4fpxKZ6I8cJUJK0oSYE9ve
 P+x3S5Nn8ZB22UDjPWrSztAIzEuC7leva54VvjC1xqqA3BaHI9f0zgC/y7OsR8b+QX4ncgQrmOX
 EIRs369vXpKfIfd/aACqsmrddrXaJK1ROspO6mg==
X-Google-Smtp-Source: AGHT+IHlmXaotNOYHTL0YXK85VokPM7kdIFf0220LuHRFt0+XWzJYXJrM3WBeEpxtTf1FVDL2BrLdo+MCO+pil1a/eg=
X-Received: by 2002:a2e:b80e:0:b0:2d4:5a3a:de7c with SMTP id
 u14-20020a2eb80e000000b002d45a3ade7cmr811959ljo.32.1710270759593; Tue, 12 Mar
 2024 12:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
 <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
 <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
In-Reply-To: <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Mar 2024 21:12:02 +0200
Message-ID: <CAC_iWj+ZmoTWP9jfwupX4cXrf_36YLW+MiTwj0Wyu2e=dLOwRQ@mail.gmail.com>
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

On Tue, 12 Mar 2024 at 17:55, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/12/24 07:14, Ilias Apalodimas wrote:
> > Hi Michal
> >
> > Apologies for the late reply
> >
> > On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 3/5/24 16:47, Ilias Apalodimas wrote:
> >>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
> >>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
> >>>> much this is cover all systems which are using only boot.bin which contains
> >>>> all images inside.
> >>>>
> >>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>> ---
> >>>>
> >>>>    board/xilinx/common/board.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> >>>> index 9641ed307b75..4f38b7d27684 100644
> >>>> --- a/board/xilinx/common/board.c
> >>>> +++ b/board/xilinx/common/board.c
> >>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
> >>>>               .image_index = 1,
> >>>>       },
> >>>>    #endif
> >>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> >>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> >>>
> >>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
> >>
> >> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
> >> that string is not empty. If name is "" it will return yes and second image is
> >> doing to be defined.
> >>
> >> But I found handling in the code like this.
> >>
> >>    36 #ifdef CONFIG_DEFAULT_FDT_FILE
> >>    37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
> >>
> >> which can be used in my second patch not to describe second image in
> >> set_dfu_alt_info() if string is empty.
> >
> > Yes, I think that's ok. The problem is that if we merge this as-is, we
> > would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
> > bit misleading
>
> As Heinrich said not just this if you want to do it like this.
> I think you will simply disable the whole SPL which will disable this symbol too.
> But from my perspective SPL payload name is driving this option. Data can end up
> on partition or in raw mode but for dfu you need to use the name.

Yes, but isn't SPL selected by the Kconfig automatically? I can't seem
to be able to disable it for the kria platforms

Thanks
/Ilias
>
> Thanks,
> Michal
>
>
