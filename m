Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C54FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768E3846E2;
	Wed, 29 Apr 2026 08:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJ5JkBl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F61D846E7; Wed, 29 Apr 2026 08:20:26 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE69846B2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c7ddf514so11324210d50.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777443622; cv=none;
 d=google.com; s=arc-20240605;
 b=PEM/yhCAVovSUrJIebiUpJwidn7crCza6DR1dIpEJTX73bxctnjSR8MU+fKUgV6Im4
 fTp+MS4CVikhG+2VM6RPRylCftRQsfWTnIYi0g+wilp5+HbJPY6LaJFRH6aIbwRMq9gE
 26kNzuTlEQfk+ZSCYB44soo4/jhfcnsxivb5T9cR+urTAAjufS8yoKFfPvLTPRt51zp/
 066W6atdVxsmWU5tMm8WLuBeoyrQBgnQ0f1HAbQGsY+VCCcF8MZM4UsjmQgw3EVknI/p
 yqR/e/1PfJp+I/yFG5q4E+F6IhXqB7DixsKWjrrz0PJiWZ5eUOjf377vsln9XrfBr7eU
 pOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tfCqy012SjjofleOHOP8NM2i8Oi7saAteA8Z1RkLfvw=;
 fh=f3FRT4vY2wGON2EN/Vjn7YytSppGp49bVv1WvcjxkYM=;
 b=Mi/Y8IXlHZbX2v+9yEmo4l6X7Yh57fqo2ufg5zW2OJBpbKGGHyfN9YQZtA7qfXfXNe
 2dFz3aCV6sprTeuh+LWME4vD+TXS+xCEFiBfzml9ycimOmf2uf7DLLG9VGCkkvRXByQ1
 DYh6Z847V3RSybNlngjVBvC2IueuxMAjN/08Zm17494Chq1zEb6VXLB4Bo39uzrjMU+c
 B+yZiBFLztuTmWDTEdRQS/Wbyg4HuQSGH6089C2+OAH3yNiwCkrn2bm2ozaDsQ55I1Sl
 7Cc6lw/wsUStjM09zueu0znQF7mHPLUhqubQ1SmaqpKBZqqptQKYGG3YsL2DKY8uzK1l
 bV0w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777443622; x=1778048422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tfCqy012SjjofleOHOP8NM2i8Oi7saAteA8Z1RkLfvw=;
 b=eJ5JkBl8ab148oCf1G38TQ8HjSF2YlO3SrnQ4kwjcuZ8p+8x3rng+WT8VniYECjq6P
 Mch7cT6NhUXWgAkFEyaUbwOCa8dzsZ6R8mYhonlSUZrDEAIgNqR5GRvCYR9KWq9zsNF/
 HE7RtuJ2W+PLulXMwET5rmdZsPL29gifMiqXzkyjauX7Joi4eVUz34I59o8GFgQAQVPH
 245FYHq8PC21AKx1rAESJWQMvFcp82jFY8jHiFxcJUdx3tc6/lPosGofYJ3T/TAFouvN
 cObtDcSUo1U3xK3ceTKAA+OVrF/479oDEOpE//1/5COCBiPeqqv9+zeOuFWeMLBtZvaZ
 b1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777443622; x=1778048422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfCqy012SjjofleOHOP8NM2i8Oi7saAteA8Z1RkLfvw=;
 b=YrMaI88eVx2u8U17wuOmEvxqy3/i1ActKaaa9WLRMnZgZ4JO8aLEcQczcJwupL4kmr
 2n0ftvPBIb29BotOn5pj/9n8HmjbVitzjTrGMevqoE2rUZQE9rhZRP99cHFsSYCa/eZv
 FjQKzXWd+X0kXo77JSHAQDYVD6jZbRrXJeznrb4gDWeVDY+mQgx6heHQSsGXUcaNRoY6
 DhoaymQ0++cjggyqvBXKaSGwZx6HB76rJzJZvLISr2urNchHDnM0htz5/TDslC+rcEh3
 tHmaly63InEP8ZKeCKkujXVHS2GegRnnV3nz77yIvczs95eFPIt4fWzqVr8q+lsEu7zS
 WAUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MFJQp1aTZoNqGkXc/YvzzCpLcLE+x7UONbmh3/HNdWrVN4R+ejcpqfrrvzrTDZzxsVXIrhjQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+pAJhfVscSCZ+eKVWuRpm/gFSg3rdcE21Ih1AIsAidJ8mXzhj
 os3lWf6e2YkARM+TZp4OfQm6+CiP/7H+8OGD/66aSbCqsALJE6wpjLZwkic38X0Yi+LLleHzFdH
 OZR0t/SQDyXYPu5+G4JU7IfMZrA0ssoz9+Paj5h8m/Q==
X-Gm-Gg: AeBDievX4TtmVv9w/UemU7nfWKf3/lWczJfMlM0qBHIcFo/u5UkUuWf/kYD51gAnRwZ
 4c6spbq+Xy0BNP3Ex/RrTFaMNDxMEJSbI2uYRsV1YYC44AyOPbmNHLSjkeAgYZwKRsmYquTazdd
 kVOeBI9uKAjtWs5cvZC5fiugFJL72Oww77ogPKRFc5CdMIy2DWBKJC3xR0uTS+Xsvbc2bEHGRzS
 IuaeJ52mbcOyV7VGBWJvX96H8UiLcN/Un9b+DNJ9xpcrhjdW1+EtCGnW1bSLi/HfGiSOwSpUfVq
 jer+LibGJHsono5Q9fo8vG7c6vzroPJqsZVRL19DLRiO5sFsCG6iJgH7pjr4cfpyDs7bB1Xnnt1
 HzMxNtxOMI6CYqPpLajYLTCVTMieSvD7VPHpNIODLIs5tVkqXrLdORUoKrqHgAYlzUNap4YyXU8
 nw8qsguM066958l0ynl3TGzXsJd1CCYmEKultTALSX85w37OCOrvo1QUnnGMs4V879WmYaPGxh9
 zMaukd9Hv7+sDbly7ogyguPN0icPgSEuWs7Ze+p+KDstv2Ou5u918wIMX7qkaNmqAxJTiZ94LxX
 mXgHSQ/P4OQr2rUL2lxculvldZBURqOBSOkBHZ9S4Awy/WUcOwAA/Yz5EOPTrZeIvfKmfvpKIf7
 0so+GyxpC8krNHyf78F/XSoxODaQ=
X-Received: by 2002:a53:b3c5:0:b0:650:4936:5975 with SMTP id
 956f58d0204a3-65bfb894af0mr2041280d50.64.1777443622276; Tue, 28 Apr 2026
 23:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
 <20260427100832.581887-4-ilias.apalodimas@linaro.org>
 <CAFLszTj2wr3DY0cZC6bcCJMt-s7CeOMGk8w0XA-K1TB2UwkD3g@mail.gmail.com>
In-Reply-To: <CAFLszTj2wr3DY0cZC6bcCJMt-s7CeOMGk8w0XA-K1TB2UwkD3g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Apr 2026 09:19:46 +0300
X-Gm-Features: AVHnY4JewPwFcOs-2V-7eJWivaqohAbSzbLNJJ42YrKac0Mij1XtpnXVNzEtSE8
Message-ID: <CAC_iWjKfr3fwBcagYiN45MO55bTTOvd7KXpVSj915aDfGLsyAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] treewide: move bi_dram[] from bd to gd
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

On Tue, 28 Apr 2026 at 16:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > treewide: move bi_dram[] from bd to gd
> >
> > Currently, the bi_dram[] information is stored in the board info
> > structure (bd). Because bd is only valid after reserve_board(),
> > dram_init_banksize() must be called late in the initialization process.
> > This limitation is problematic, as it forces us to rely on a variety of
> > bespoke functions to determine board RAM, bank memory sizes, and other
> > early setup requirements.
> >
> > By moving bi_dram[] into the global data (gd), we can run it earlier.
> > This is particularly convenient since boards define their own
> > dram_init_banksize() routines, which do not always rely on parsing
> > Device Tree (DT) memory nodes.
> >
> > Additionally, U-Boot defaults to relocating to the top of the first memory
> > bank. While boards currently use custom functions to override this
> > behavior, having the DRAM bank information available earlier in gd makes
> > relocating to a different bank trivial and standardizes the process.
> >
> > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > [...]
>
> > diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
> > @@ -59,10 +59,6 @@ struct bd_info {
> >  #endif
> >       ulong           bi_arch_number; /* unique id for this board */
> >       ulong           bi_boot_params; /* where this board expects params */
> > -     struct {                        /* RAM configuration */
> > -             phys_addr_t start;
> > -             phys_size_t size;
> > -     } bi_dram[CONFIG_NR_DRAM_BANKS];
> >  };
>
> The mediatek boards recently started accessing this field, e.g.
> arch/arm/mach-mediatek/mt7987/init.c

Where? I can't find anything in -master.

>
> > diff --git a/include/init.h b/include/init.h
> > @@ -74,7 +74,7 @@ int dram_init(void);
> >   * dram_init_banksize() - Set up DRAM bank sizes
> >   *
> >   * This can be implemented by boards to set up the DRAM bank information in
> > - * gd->bd->bi_dram(). It is called just before relocation, after dram_init()
> > + * gd->dram(). It is called just before relocation, after dram_init()
> >   * is called.
>
> Since you are touching this, please use gd->dram[] - it's an array,
> not a function.

Sure
>
> Regards,
> Simon
