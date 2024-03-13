Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39987C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 21:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F63187EAD;
	Wed, 13 Mar 2024 22:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uRzjbWZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD31387EB4; Wed, 13 Mar 2024 22:44:21 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7941187E1B
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 22:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513cfd48224so62277e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710366258; x=1710971058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/xaDncwcrkoLVHaMEFfmNHdTBtdv+GXmo1OBZ6bC6s=;
 b=uRzjbWZOCVsGuDgkHRUu/c4k+Tqz/m/ri3adTZrG8A3/X4T1K61oPn64Cr+WXOHNHM
 qFAXQtn8mH1QPVrQlx/Vk5ZiupcOqZsjQO0wQ1pN7/3yT6FlOlw45CrZxu0lWxah/t6w
 qJMQ2uGE8FXw9SGPSBtBgdE1StqaOLTDddioVw+BCjbDtvdUQIXTC1JKHT2Ehsud++Oz
 Rbf/xQZt2aCwinfH/mkkNiZBErDpF1K6+dInrfqDdRRnNbUOeReTXF3OVr6D4JGBl9Tu
 ZddAsYyA6lqfezt7+UfTX5X8UXmZZ9wpis0h9vvX/GSfYA3zS728gA5GFlIhzZwe6bck
 oxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710366258; x=1710971058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/xaDncwcrkoLVHaMEFfmNHdTBtdv+GXmo1OBZ6bC6s=;
 b=XK8OXHpozyvaD30eFPRnbOoWTtUyLug6EtaCDF+MmzaDEVqLWEGrnF/umQcyYkyCKQ
 TbvBY8/NhWg+WggeILrkaXaVWWEy5+NN4JayE3RGthOfNWXRNPS4RrkdnaaPylV6rXfL
 n77HunWAWuXhwM5/jyuMS4neQGsMGZLfOEgtB20L0Jw4gZVQ+eXgk1I4FxYn8E5LfuoB
 Rx4NpxzpgX5n7L4LoQywVgoE7FdcUPDi8U/GXoECq234fkuDZrDQoTBVM1aOLcBArSbf
 clp/IX84NSD1u8+8BgAjrVx7CvZy94bZK10MKvPznhmA8nIGCzhSCI1oQ3fsHVgawKZ/
 VfZg==
X-Gm-Message-State: AOJu0YxnAtcpDjBj0KYSoPhPWizKfpgRu+xu5hdCLXuJexFqC/VmHqGF
 wfvn2gNjDme+W90hIbuyFeB3VWxHFVu3AaKivKEY27/GQlZrFtVGivb154X7RtiMsjKHJswLTaQ
 9WN9IGZ/783uTa2Fj/WQYeCm3oVP30NU/8LedzQ==
X-Google-Smtp-Source: AGHT+IE/hRF8RGvPdBamBqyx6KA0PkEC+W6R0aEdqXaYx8UutL0j11NkDT+dM6omJqSZF23oiUe6JMf3BUK0jGESt+A=
X-Received: by 2002:ac2:58e5:0:b0:513:c886:2b85 with SMTP id
 v5-20020ac258e5000000b00513c8862b85mr2119173lfo.26.1710366258608; Wed, 13 Mar
 2024 14:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
 <e1fabe14-0c0e-45f3-9d5a-1452cb9b954e@linaro.org>
In-Reply-To: <e1fabe14-0c0e-45f3-9d5a-1452cb9b954e@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Mar 2024 23:43:42 +0200
Message-ID: <CAC_iWjKhM6Ono+C-t-3g=OSo=5wF8jAYzoZ-NUyNUt7MHTMy=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
To: Richard Henderson <richard.henderson@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Hi Richard,

On Wed, 13 Mar 2024 at 22:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/13/24 06:23, Ilias Apalodimas wrote:
> > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > @@ -63,18 +63,11 @@ SECTIONS
> >
> >       _image_binary_end = .;
> >
> > -     .bss_start (NOLOAD) : {
> > -             . = ALIGN(8);
> > -             KEEP(*(.__bss_start));
> > -     } >.sdram
> > -
> > -     .bss (NOLOAD) : {
> > +     .bss : {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -     } >.sdram
> > -
> > -     .bss_end (NOLOAD) : {
> > -             KEEP(*(.__bss_end));
> > +             . = ALIGN(8);
> > +             __bss_end = .;
>
> Still missing the alignment on .bss, previously in .bss_start.

Since this is emitted in .sdram memory I can't define it as
.bss ALIGN(8) : {....} since the calculated memory will be outside the
sdram-defined region

I could define it as
.bss : {
        . = ALIGN(8);
        __bss_start = .;
        ......
}

But instead, I added an assert at the bottom which will break the
linking if the __bss_start is not 8byte aligned.

Looking at the output for xilinx_zynqmp_kria_defconfig (which is a v8
board & SPL) looks identical and correct since
CONFIG_SPL_BSS_START_ADDR=0x1000 for that board.

$~ readelf -sW spl/u-boot-spl | grep bss_start
  1550: 0000000000001000     0 NOTYPE  GLOBAL DEFAULT    6 __bss_start

Isn't the assert enough? Or do you think adding the . = ALIGN(8) in
the section definition is better?

Thanks
/Ilias


>
> With that fixed,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
