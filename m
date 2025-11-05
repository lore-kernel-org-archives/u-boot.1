Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA329CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 13:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDB483A32;
	Wed,  5 Nov 2025 14:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p5zPXqKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD62E83A3B; Wed,  5 Nov 2025 14:09:22 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB8F83A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 14:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-781014f4e12so88801867b3.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 05:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762348159; x=1762952959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lCrC/ea5RELBuvdefY3XO1j7ON1IHnfVzBQ9OVY1Ofs=;
 b=p5zPXqKjhoCtGSRLriA6pA54zakYth6uGUjtN1GtnywhPiFG/VLHTghlbX+0ZcV/Bi
 wg9VlUrYHWI5IZHX7TLtIyacdJveuwWB6KXZEWo9gGx4CIPFKwE3XX4FfUn+1WRNoC8z
 ocjeQIL//QHu8FHI6oKPIFxI4rHZWjY8R9e+t+rySkWyIfgi5nxmumMY2PXymBwZOQFz
 A8bap0zwkhXkCBxnxGGqtw/zUiEAVkXUkcOqwtgpM9SLQDQ7xMjqrp5bUDY36uq/9xCo
 VEmyVhzyAq6eOUtKijRNLMjEjGsdh2tn2Us13TDVpf1rvWdtRDDoGTH1F+d/5wyeD8QM
 ItMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762348159; x=1762952959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lCrC/ea5RELBuvdefY3XO1j7ON1IHnfVzBQ9OVY1Ofs=;
 b=ETNUKRHsMTLgCYj48lmmSK39Ij+FoFabc3s9xj3Z9OjXX+VJ/0KXSTlo9uYIMAKIeN
 qCxBN6OeJdhmwXFZVAfqSc154DrwVXRDDrKMcYbjjFTZgNVp9p9DDREmn5e/l1bsL425
 ++ceuQrM7NtSpBo8nL83T5AaeM/mprVBiiAt1mb4UvnpYHpZGWFci15DzRTgVO+OKnGL
 XQja8OqYs2OLETzB/LXM7A4QHwzq8exBAMyh2AbQRdrOvuzs6z+1Y35bvbWZbg2tdd9Q
 kJzKnfuZAJvcHKbMQlm/BG82dOqsby00niNf3Sllf74qAnm+1InCx3MY0hNRqdvXaBZy
 D6Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb6T/JB02tIRS/z/zg3QqIpzBI64XUaesQSYRe49QOaAmukCUgdQIvZq71fxz2IZIOREQovb4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqd/bXnVCOmL3Y+Sye3siTtvZ4AxFPz8z6XSP7BDV0P7h6JhrN
 yzdhyay+DZpepTmWpm9s4dZRZucch8Bnu4zoQn4oPz9xuuaJPI2v/p1f8UZuBRe4e4RongHqGbd
 lwYxe6eY/MYwE0+qLZMZHAEmLpRN/Gm5q8mPZ0gJ8Ew==
X-Gm-Gg: ASbGncs7ToLsZ07Fy0ypoe7x3/KQpEZDMyW0DYEYpGu5D2+buAseOfH74Gc6hc4njTh
 vqTKW/xDU78Ys3SyR4vLAxZO0W24h7rTAKrNkKxTQfvovc09QF7IoPBFw/39GpGbY+AwuYb3Phv
 Y4kYRHRQKKqEF3QFMXgkFMOnZmo/j8+OXI5QJ5Pa5EmWQz2k41i+6fVgVwhf8x8ZpAODYSesbrH
 X8oRyAgDPNMEKojFmtY1BWEa5vFu9AstEyl3EZm7WaRnZL0OUMK3e/zyztp1DmO6MgDMkbcpZRU
 lgdFwsiLJVTLbzV4I6YEQ+gSAS4Up6TUiYur2lysJw==
X-Google-Smtp-Source: AGHT+IFg2dOXVNatV7IY1MIbq8m+nBLlxJdZXqWtsxNQvW+t+qtFyv64J06K9Llnw/eSDkZVRjp2MEVept0DPXql5GI=
X-Received: by 2002:a05:690e:4368:b0:63f:aadb:397a with SMTP id
 956f58d0204a3-63fd35b061bmr2148090d50.55.1762348159266; Wed, 05 Nov 2025
 05:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
 <20251104204246.GG6688@bill-the-cat>
In-Reply-To: <20251104204246.GG6688@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Nov 2025 15:08:41 +0200
X-Gm-Features: AWmQ_bnGxrVxwiE6pNQHZSLuL98xM_WUdjUJHMyZ2blgBjOff_jcQmnNqi8QX-o
Message-ID: <CAC_iWjJBRDLA0Cw8ir4saL0tmkEiNF+_PB22rRdOcb=1SLpPzg@mail.gmail.com>
Subject: Re: [PATCH] armv8: Fix transfer list passing with KVM
To: Tom Rini <trini@konsulko.com>
Cc: raymondmaoca@gmail.com, Xu Zhang <423756212@qq.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de
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

Hi Tom

On Tue, 4 Nov 2025 at 22:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 04, 2025 at 05:04:02PM +0200, Ilias Apalodimas wrote:
>
> > When loading U-Boot in a low memory address, the adpr instruction
> > to preserve saved_args[] end up within the memory space of QEMUs
> > mapped pflashes. As a result the following store pair instructions
> > lead to a crash since instructions that modify more than one registers
> > can't trap into KVM.
> >
> > This problem can be solved with loading U-Boot with -kernel
> > and defining a different text base address. But when running with
> > -bios we always start from 0x0. So let's postpone the calculation
> > of saved_args[] post relocation, where we will have an address that
> > doesn't collide with the QEMU flashes.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/start.S | 8 ++++----
> >  arch/arm/lib/crt0_64.S     | 4 ++++
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> > index 40c342e97e9b..ef335de16b79 100644
> > --- a/arch/arm/cpu/armv8/start.S
> > +++ b/arch/arm/cpu/armv8/start.S
> > @@ -387,10 +387,10 @@ ENDPROC(c_runtime_cpu_setup)
> >  WEAK(save_boot_params)
> >  #if (IS_ENABLED(CONFIG_BLOBLIST))
> >       /* Calculate the PC-relative address of saved_args */
>
> This comment is no longer correct. We're saving a few regs in other regs
> that can't be touched until later.
>
> > -     adrp    x9, saved_args
> > -     add     x9, x9, :lo12:saved_args
> > -     stp     x0, x1, [x9]
> > -     stp     x2, x3, [x9, #16]
> > +     mov     x0, x19
> > +     mov     x1, x20
> > +     mov     x2, x21
> > +     mov     x3, x22
> >  #endif
> >       b       save_boot_params_ret    /* back to my caller */
> >  ENDPROC(save_boot_params)
> > diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> > index 3e7627aa389b..d6246010f368 100644
> > --- a/arch/arm/lib/crt0_64.S
> > +++ b/arch/arm/lib/crt0_64.S
> > @@ -132,6 +132,10 @@ ENTRY(_main)
> >       b       relocate_code
> >
> >  relocation_return:
> > +       adrp    x9, saved_args
> > +       add     x9, x9, :lo12:saved_args
> > +       stp     x19, x20, [x9]
> > +       stp     x21, x22, [x9, #16]
>
> Here is where we should comment on what's being calculated (and is it
> safe to do this without BLOBLIST?).

Nop, it actually blowed up during my testing, e.g compiling without
BLOBLIST, but I didn't respond in time.
I'll send a V2 moving the comment and adding an ifdef around this

Thanks
/Ilias
>
> --
> Tom
