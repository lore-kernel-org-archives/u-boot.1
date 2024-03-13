Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC35C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 07:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D712F870D2;
	Wed, 13 Mar 2024 08:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IscRYTJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A088792D; Wed, 13 Mar 2024 08:02:18 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9799865D0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 08:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51331634948so477396e87.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710313334; x=1710918134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9dAplZErS52flJT1ViXv3Siq/VMAmY9Duws8AyxeSMk=;
 b=IscRYTJghr/xfqWvXoSLBssCcr+MXMBDh1HEcSuudoQ15CaVgf9EloJ0wz2IrA0+9p
 keLzKnOpZLmtOLIn3MQRJxnP7OH+8a4N2Ym6VJvyZFekRSTvuIvbLc0TG7sI+GKJ0LRn
 jrBjNBFylzYcVmZe4q7bLYZGaKmanZ7ZKg4vzPjoBZOooI9eyTEe06QutGvrfD0fodRg
 k6aLBlNcqHzImXqO2BfW3ojPSm1OCUN+//aEQ+GeRdPbfNm32sq2wuSdK4vRXMiABw94
 yzoCy8NpXk7Oh8osAvEE51mJqIxieP4QkPnh83H+plyed5NRNnN7OYE7MfiBcsvlRp66
 aktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710313334; x=1710918134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9dAplZErS52flJT1ViXv3Siq/VMAmY9Duws8AyxeSMk=;
 b=lKkhsaxOj2ZaZs7pfWC85Rvtnq0OIs5wGmYX9UuSy+W7R776jFh27jfL+UZ+8EueEH
 9JcbM9xuDjl3vR04qLMMmaBfbR20PK2+7Ushed9lLtYlvjBPN1xpe6EYJALVnb87Ck00
 rP7AS2pIvjAW3jzxTk1pBZI2SQHZlKn7nCglzJvbxJRe2Icdap8rVUKrgN2ZvhUsZ5jg
 Ee+ZNJUZei68WGEQmPT53Yk9JXnXW/OqYsWw02As52+Y54sf95hl3NQgrsf3zfsrAvaL
 7tHezSYop6n6OgJ/wBaiHzPg8XU9i23irHdrDgzoVFfLItAk9USvXtpwZnAOPAW4Fo1e
 6E6Q==
X-Gm-Message-State: AOJu0YxZCarVZ884+Xytav1di6PO2aDVLzeO2MI/zOw3bcRqXdRZrFv9
 akTBkZvbknj+JnHBXba00OE/qErhwCMwiszFAWKwbuB4Wx5kTYlxKn+YKIM3zptqLNXrqSZRKV6
 jpuxAfOT3nhATkFwyZDofdLcDjiGarf21MnAXJA==
X-Google-Smtp-Source: AGHT+IFfBBncHfc8Fg3zHaZ/PLEGhlGOej1yKICaE2S6MQMeXKMCN1PaF1bRuYuRMfgO774n1k3CLqZqUxrIIXV4VGo=
X-Received: by 2002:a05:6512:2c99:b0:513:ade3:afd with SMTP id
 dw25-20020a0565122c9900b00513ade30afdmr674644lfb.8.1710313333959; Wed, 13 Mar
 2024 00:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
 <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
 <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
 <CAC_iWj+ZmoTWP9jfwupX4cXrf_36YLW+MiTwj0Wyu2e=dLOwRQ@mail.gmail.com>
 <8bcf60a7-ba03-4dfe-926e-f1a77ba4c306@amd.com>
In-Reply-To: <8bcf60a7-ba03-4dfe-926e-f1a77ba4c306@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Mar 2024 09:01:37 +0200
Message-ID: <CAC_iWjKahx0uJ35J-LcY=hzPnOK2cEzevTRwi0mpAFAgYvnDkA@mail.gmail.com>
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

On Wed, 13 Mar 2024 at 08:42, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/12/24 20:12, Ilias Apalodimas wrote:
> > On Tue, 12 Mar 2024 at 17:55, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 3/12/24 07:14, Ilias Apalodimas wrote:
> >>> Hi Michal
> >>>
> >>> Apologies for the late reply
> >>>
> >>> On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 3/5/24 16:47, Ilias Apalodimas wrote:
> >>>>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
> >>>>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
> >>>>>> much this is cover all systems which are using only boot.bin which contains
> >>>>>> all images inside.
> >>>>>>
> >>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>>> ---
> >>>>>>
> >>>>>>     board/xilinx/common/board.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> >>>>>> index 9641ed307b75..4f38b7d27684 100644
> >>>>>> --- a/board/xilinx/common/board.c
> >>>>>> +++ b/board/xilinx/common/board.c
> >>>>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
> >>>>>>                .image_index = 1,
> >>>>>>        },
> >>>>>>     #endif
> >>>>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> >>>>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> >>>>>
> >>>>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
> >>>>
> >>>> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
> >>>> that string is not empty. If name is "" it will return yes and second image is
> >>>> doing to be defined.
> >>>>
> >>>> But I found handling in the code like this.
> >>>>
> >>>>     36 #ifdef CONFIG_DEFAULT_FDT_FILE
> >>>>     37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
> >>>>
> >>>> which can be used in my second patch not to describe second image in
> >>>> set_dfu_alt_info() if string is empty.
> >>>
> >>> Yes, I think that's ok. The problem is that if we merge this as-is, we
> >>> would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
> >>> bit misleading
> >>
> >> As Heinrich said not just this if you want to do it like this.
> >> I think you will simply disable the whole SPL which will disable this symbol too.
> >> But from my perspective SPL payload name is driving this option. Data can end up
> >> on partition or in raw mode but for dfu you need to use the name.
> >
> > Yes, but isn't SPL selected by the Kconfig automatically? I can't seem
> > to be able to disable it for the kria platforms
>
> Not in upstream but via your/AMD build in meta-ts.
>
> Thanks,
> Michal
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
