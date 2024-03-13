Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2BFC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 07:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E658792D;
	Wed, 13 Mar 2024 08:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mvK2bQek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFF887DC4; Wed, 13 Mar 2024 08:08:37 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6D2878E9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 08:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-513b1e1724bso634418e87.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710313714; x=1710918514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnHxsdRP3QJhnNbpPjtHZ7MGYxSUSDPFY9VCsrlV4kk=;
 b=mvK2bQekE4Yfffh3cE5QhptgiNHZSBC/7LvfKmiB234XBN52QSZA1D0ADHUsUz3Xzl
 7NIAnAqQv7x8OTkeMU3LZMDIpf7dNvMRUDcH4lwXmyyF7FnXSE0IKIcdVwNab+YQzVel
 DY+aHQ2VsPK7QTkp70haIvUZo0fRqLVw3duGRpq/QriyAbakoxWM+uTIjZFXN3XeZGY7
 5oWNbU/aYn+oIn2ZUmOFXaYjE4Q1KrDZoFNAeFNQw4h2+PnkddLCNfJqUd6jUKIrmhSn
 QPSubYF6UUf6GTmgdOJQzP0/0FAQBNLRX9YziU3BRyEWHtjQgu8mgFXd8gch1pLo6ZWo
 uS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710313714; x=1710918514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnHxsdRP3QJhnNbpPjtHZ7MGYxSUSDPFY9VCsrlV4kk=;
 b=tBioZfz3a6fFz/7G6zqTtJvVavvZoQvnbyjGD4hOCbWSAm7UWgPHXmUA9EVthrcaZV
 e1LEVlgYikTxi7GFcpbxTkDxr/0OnpcPZHnXtCQZqrR85s8za6kdjaGglaN9DWyCGJv2
 l3Rn0tRER1q+Die6ph5Rn53Xn5jIyeA+GewvA2l6/4fzoe6pCmAw3ABR1iOEP4VWla/G
 aU91NvIJzB7knMnlAsA6VrlXyD4zEuHRyCC/Fthaq+I6hU1BdhMk7J4GoLT7uWqSgCbN
 3o4ULun3pn8g3Ydc2Xi7HL4FMKO/DYZEnwma55QpK0y0Yj8pWhKzYeUSJPPDmNH2vjlq
 eyCA==
X-Gm-Message-State: AOJu0YwXyeegmHyhGUO6SG0/Ty9Kwfdlk48m8Ey+at0X4YCJo24yJpsa
 fSggxKjung6WJ2Qee9AvFXrkupTnAx3sp7KOS4Ga+8Ixbuk1fkTErtl1wnR1AIxRtI7R9ddVh4t
 SfM9+i9irwi4LrCTYi9Gw3jsqLfJUUfgn/UubHQ==
X-Google-Smtp-Source: AGHT+IHpitNU1KfaQlKIRBqQnEBJo6fWiqGQGlmnc+exy1jvfwYINiKTwe057AiOT7uo/HuBy0iAw+hxtgPjNLSV3KU=
X-Received: by 2002:a19:6909:0:b0:513:a9fa:dd5e with SMTP id
 e9-20020a196909000000b00513a9fadd5emr549820lfc.14.1710313714528; Wed, 13 Mar
 2024 00:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
 <20240312140832.1968215-8-ilias.apalodimas@linaro.org>
 <1b42d645-d4cc-4c42-900f-ba94bf857d87@linaro.org>
In-Reply-To: <1b42d645-d4cc-4c42-900f-ba94bf857d87@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Mar 2024 09:07:58 +0200
Message-ID: <CAC_iWjJLZHuQ+znhZyxXmRnX_HcMeneM__L50yX4_mtE+tf_JQ@mail.gmail.com>
Subject: Re: [PATCH 7/7 v2] arm: remove redundant section alignments
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

Pasting some of the discussions we had over IRC for completeness.

On Tue, 12 Mar 2024 at 19:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/12/24 04:08, Ilias Apalodimas wrote:
> > index 33f4624b561d..ccdd1966cfbc 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -132,7 +132,7 @@ SECTIONS
> >
> >       _end = .;
> >
> > -     .bss ALIGN(8): {
> > +     .bss : {
> >               __bss_start = .;
> >               *(.bss*)
> >               __bss_end = .;
>
> The code in arch/arm/lib/crt0_64.S assumes __bss_end - __bss_start is a multiple of 8.
> But that could probably be replaced by a proper call to memset fairly easily.
>
> > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > index b6b19a4174fe..a9fcbbf22e96 100644
> > --- a/arch/arm/cpu/u-boot.lds
> > +++ b/arch/arm/cpu/u-boot.lds
> > @@ -155,7 +155,7 @@ SECTIONS
> >
> >       __image_copy_end = .;
> >
> > -     .rel.dyn ALIGN(4) : {
> > +     .rel.dyn : {
> >               __rel_dyn_start = .;
> >               *(.rel*)
> >               __rel_dyn_end = .;
>
> Because of the overlay, this affects .bss too.
>
> The code in arch/arm/lib/crt0.S may or may not be configured to use memset.  When it
> isn't, it requires __bss_end - __bss_start to be a multiple of 4.  Why does this not
> always use memset?

I think it's due to size restrictions in SPL. Since I can't test all
affected platforms, I prefer leaving it as is at least for now.
I'll explicitly align sections to 4/8 bytes in v3. Once we get this
merged we can try and clean those up as you suggested on a followup
patchset

Thanks
/Ilias
>
>
> r~
