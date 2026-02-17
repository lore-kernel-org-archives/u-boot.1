Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AC9E68149
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 09:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078EA8063E;
	Tue, 17 Feb 2026 10:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NOPqR/Cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A38683981; Tue, 17 Feb 2026 10:25:07 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD03802C1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ada2c30a1so3595803d50.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 01:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320300; cv=none;
 d=google.com; s=arc-20240605;
 b=e+MhFyXBxockl8RxsLVS7EVYVw+ys0PdD0gtUjgqdth1gCY0IObWT0lNSYxYSLz6cg
 Cu+WjrWyMXIJA2uZVup9lWAbEdeEdngSf0XOsRk/1ZrxNhL2GoSUP/g9bx8Z/miz893v
 4/fTt739vtN0AaIRXkuVNs1TRkXFx2Q7xdbtiqxvDQ9eusngvcBFCHAVIQAVco4RDIoP
 V/VRf00mWOJ6yelP1SISiFqcBHuq+xI0HIUt7UGUCu+EK0Q8SXB+inKoeHvLHXVc+ltz
 QLiSOLNoBWbBBs0TzxA6uHAvAEDon6MJJoN2sWjayswqigvT0gQXg08pDC2z+FRa2xOf
 ArPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6aiBL9K/AWueFT++vzZ/lUUxijDs1QX2I3UWSVOt7/k=;
 fh=rZnstkCmyEL/uC9L0xSbuGK72fc2pzF803Z5hmhMx2s=;
 b=fzgXmhswUcpaQ4dWHJTcS8lqq7v0gYEHwGYz4oL4lC3OPg5Vwk9YZgPOdzCjJnhGRN
 sUefijDxHYcegaHav7YBC7QpJFzKOqtJFg+g6Ugm+REBcHUSLUvSn5kFNBJ2SWS23rmH
 9GqrKp1fOcE/GQ67VCLUF5c1fmMgjBSBEcZdB+KUiv4iF1/ozhEzfJiWkkbONPNd3fmI
 jf8J98ArPCKDQdCu2Uiwes/ujUA9ev9pHV9mpmB8atVxDjLdNY08oIeDQqRQ7vAmhfxN
 McjF0511CECOTOF72Aka+vWz2qW1CVWxp56o4GJCeSN37xD1SHHO2fW8DxA29anLapcL
 t3KA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771320300; x=1771925100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6aiBL9K/AWueFT++vzZ/lUUxijDs1QX2I3UWSVOt7/k=;
 b=NOPqR/Cgf1tRPBA6Qa6M2/RtNOEQXq7kQfcNCEzGlyLu62F5Y2UIFItiXDXAY4Hyxc
 evVzJsR/tBM7vzlHkMfqulytpaIYSZcee5BqMdFoqzaBnllTbQM1Yqzv6+7FtMCO3eru
 1O47/GPo79TGLwqBjsztmR+2b4AFMY9U1xOmR4QglUjxPA89w83+MCkUkYnUhHgRIeXu
 HFH3iaGdOEdm5FR3ganhyfUMLTcEHn9/xW3pgm/eZNSyWPOZIQqztHGabwo3fZvv08NP
 TSeZvfwxESDcLKZCPS+2aV5wkeU2ky5MC19G6bXPxjV2y8NRyq0iLS/D0zQavgwIVbd5
 yDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771320300; x=1771925100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aiBL9K/AWueFT++vzZ/lUUxijDs1QX2I3UWSVOt7/k=;
 b=MmyTahT+PB1xgQdKUKGKrqS9yFxzBtYh1od3NpYfcZ8mP1HdauFaY97dw0yGuBFsCi
 W64oDfH3l4b2vJAcP2I+TrP9S6RX5JQVkEb994cgtK9Azsi6f21uwaSp95T2qwUgF+Un
 v5uR0TImW6svav7MHu26pXj0w3qv76I1fsEO3khXSY5iHWuXY2LyFc34npd7OrtkpE0X
 V5yGP4LfpOtvzJvEkf3PNvNe/cOLY0c4okiulTkqxyNVwWwzCTko7MNXRxByf6HPxbau
 PdYN8DyqU0dz6x/l6nNueaIzeoA0uKJcF6afDBAorUeSbB4RBdRqZjnCQTlYbR7yvaef
 iE5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL0lkmplPHKvLXcgDpOYlvo1ZJStaRK5AuFona+zaXfNRoArWW1X2139m1cPyeipQJh0Ydgr8=@lists.denx.de
X-Gm-Message-State: AOJu0YwpjwgPFrHJSAbsZzXN0RGWcJp6rc/d0WMglBE1YuksmMUB9DOP
 /KjgdUohKLOf7MUVAhZuuHGobFISfyzWueGlOSrXp0zkKvuCqpzN/1M84jYJxroQobrI/X+t1Gc
 PCc4kDm3X1vQOw3CCHME+iBryzI2ZWzJud5uPD8rnvQ==
X-Gm-Gg: AZuq6aJaeAvlMNTvM1MptNj50JhxJMXBisNxoVz368cYzIWEb/GwQvViBJBvOGZRHAn
 NSgp2JCQjdnSzsyfteHUXrc8jZi13JjqkNBmDxxQXt70ULFxoXwgvsLMVusvK9mgLRtj828ChEV
 UW6nXmiLZNls6l5O+Kl5vfwRY1pqfeqzOoMa3fq8tSAqIAYhKjFRLk9+6NgbmnYrYvseatYM2E8
 lnO6pRTOhIA3l6ULxNpLIDsblH0HOUdniJwEaws/UdOwQHKFAqc2rlpX/m9eQJTb5DD4Sx8zGnr
 3v2LnFUyIqo7CCF0kOSGgNJ5reyZuwFPxsg2KCod9m4pLKfDkgjD7Bj9GVTiEPl6npB6lH4NwSm
 LY384WcLFXdz73O/CXuqwnXU+GrNyxS5Bg/0nlVhGjX/8hPBgscCMNbF2+q8FeFnv+Y4l9mUEtb
 Rrho4g5vfQBfVkcdVo5vlEmuUjsHdnCfq2tJn1FkhUn1pFOlDZwgiz+y2IABWAW+tyZc18y9I8w
 XUA40i3QDKwyuSAbhkykqGW2NW2XNjOPkQgVtW6d7xtONoPVWha99bDwt3+Or8936VfxmkKbw3U
 HeQt4b0UAjRxwbO6La5X+X19B4j8IgQS0nAEXHxsyUzl
X-Received: by 2002:a53:d10f:0:b0:649:df15:ae27 with SMTP id
 956f58d0204a3-64c19b56980mr6611669d50.79.1771320300069; Tue, 17 Feb 2026
 01:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKvGLUoR7-hD3LdgkYy5Oh2zR+g+P5ZtKnkpg-A_XvfaQ@mail.gmail.com>
 <740c2e83-b7c7-49db-bdaf-067352d9aa16@canonical.com>
In-Reply-To: <740c2e83-b7c7-49db-bdaf-067352d9aa16@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Feb 2026 11:24:23 +0200
X-Gm-Features: AZwV_Qj1Dt-vZH95CuLXMjCm2IPvY1kOsQeHn9Fp_qsnaU9Qk45Z6lu1haXnYAI
Message-ID: <CAC_iWjKFnChaXoZ0VZ-e3zF7qpF4Lrw_9aF8w3hT_kNRHcL5kg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: require at least 128 KiB of stack space
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 17 Feb 2026 at 10:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 2/17/26 09:18, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Tue, 17 Feb 2026 at 09:47, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The UEFI specification requires at least 128 KiB stack space. Consider this
> >> value as a prerequisite for CONFIG_EFI_LOADER.
> >>
> >> Mention the requirement in the CONFIG_STACK_SPACE description and decribe
> >> that the UEFI sub-system uses CONFIG_STACK_SPACE when defining the memory
> >> map.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   Kconfig                | 8 +++++---
> >>   lib/efi_loader/Kconfig | 2 ++
> >>   2 files changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Kconfig b/Kconfig
> >> index ce25ea24a60..99b3cd62526 100644
> >> --- a/Kconfig
> >> +++ b/Kconfig
> >> @@ -615,9 +615,11 @@ config STACK_SIZE
> >>          default 0x4000 if ARCH_STM32
> >>          default 0x1000000
> >>          help
> >> -         Define Max stack size that can be used by U-Boot. This value is used
> >> -         by the UEFI sub-system. On some boards initrd_high is calculated as
> >> -         base stack pointer minus this stack size.
> >> +         Define Max stack size that can be used by U-Boot. The UEFI sub-system
> >> +         considers this value when setting up the memory map. The UEFI
> >> +         specification requires 128 KiB or more of available stack space. On
> >> +         some boards initrd_high is calculated as base stack pointer minus this
> >> +         stack size.
> >>
> >>   config SYS_MEM_TOP_HIDE
> >>          hex "Exclude some memory from U-Boot / OS information"
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index 13e44be1d06..450ffa61c0a 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -15,6 +15,8 @@ config EFI_LOADER
> >>          # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> >>          depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> >>          depends on !EFI_APP
> >> +       # The EFI specification requires 128 KiB or more of stack space
> >> +       depends on STACK_SIZE >= 0x20000
> >
> > Won't this disable EFI for ARCH_STM32 devices? Those define the
> > default stack size as 0x4000.
>
> The UEFI specification explicitly requires an enabled MMU.
> The ARMv7-M architecture does not offer it.

There was a discussion about this earlier and we decided to keep it
alive though. IIRC Mark explained why we can keep it enabled.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >>          default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> >>          select EFI
> >>          select CHARSET
> >> --
> >> 2.51.0
> >>
>
