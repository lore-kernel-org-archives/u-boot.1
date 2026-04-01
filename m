Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEB6D3515E
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B5983CE3;
	Wed,  1 Apr 2026 11:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y9Uj6ZwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B259B83CE3; Wed,  1 Apr 2026 11:21:52 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A118E80212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65006c99d38so8822757d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 02:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775035308; cv=none;
 d=google.com; s=arc-20240605;
 b=K2ERMKAGYYzROayqv39G5ifJ44NVbv5WZ3lattl3yeNO0dewRwEK0p15egBLTHBBiT
 62zwxFdBulD2hTqFMRLWGeXiIDXcVq6h5DmwRhrk719hP6zQOAQpJEJ/73xjkEMBVmgk
 +r0XhhlHR/3wjjYihnKXaIizJ4UMMNYSFo+RlOx1wvvcBX48VM2VK5f2a93S/3ipzF6a
 ZR+oDuSk0ItG3lp9hzfohSMH6BYCBMVcqOnxk3LrZL4xcEmuPUjhu3wTqdMt1aubfbcz
 VnnhehEE+ee/7MeGytZBVIkDc+d5TWkTPJlh8yvXywBPBJGp/IkcY85b5BZYZmK23asX
 BOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BeAeadjaozO/WevwaLwmNgiEgeSQQXXFJoI/whZjb6Q=;
 fh=J51sd8YISvqlZNOcCSvYdKuaukOA/tENi9cg6USwZfQ=;
 b=f/xefYFHx/qRRuxIr/+OcbaOLOZRQSQ/s/+f5iKJxh3oxnGXtXcn7SV2adaaT8stcn
 LAbe2os4c6sml8n1G1zJJx+/HroEX5UlMj6KB6RN6RteMlu3m8/tHvUC21d7YPOsVpDI
 2qBSeueWU8bmQKQ1NJm8s8SsXPdt3jjgi3DGeEqSYMO9OJWuGWBqg9iGPmnFGK112y43
 bHbakPcWm24rJieOKczATi1lu05Yx0YRQGhx+sSq8aUdAt7inl4JJYUfEiXS9f7iJOyQ
 OaEBMoAYIWcuwN8486N+64tOZmJ0UVlWnOhDBOLF7jNfTdBT+ekhRTe6lNcgcTzvtcYW
 3buw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035308; x=1775640108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BeAeadjaozO/WevwaLwmNgiEgeSQQXXFJoI/whZjb6Q=;
 b=y9Uj6ZwUe5Z2gX9syIVAxuYeX0C+ApKG2YS9q/LUfyVbKchklPay3FHO/y0y6NnX+6
 c56j/bNLdMJ8TJQtxKm63iy/Pzr6wobp4n1LblO24E9gwkPh84qwrrg55e4JCq99ugUu
 l5wZMGMo6RSswY9op2fpR3c8HfM6H3rlxOjauaWarZTWnMD9AjeyWACy5QC+UEmPJEy5
 rXEGIUWscxyVwOQODv3Kl6WJaOV+mX+vYBsZyh/5uJkznUYG/5x/pzmCuu/YOVeulNNH
 wwtpLjhNDoUvvjdTg9lraxPSPaxol6SeA1XOkKvP8v0zf+hSYr7PauEd+v6umjDbZ3Ut
 /rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035308; x=1775640108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeAeadjaozO/WevwaLwmNgiEgeSQQXXFJoI/whZjb6Q=;
 b=kckI4DQdiCkHya5b0uUg6lAeWwvkrWDUpmTosNpnALDe18j7x5VdcN2K5JTYKm1A6O
 ixNJxkk+MqaFAT42v0nS2XEPt9jBsWKo7QPJSu58+9KOa1K5Npw33TYgicOPAsU6pajy
 PNo5uSEyXAiQJw8YHfsAWpmgJVgmrbncYN373GvhqyEsjQSQymoz2bGPKVb+i63sTJUK
 thbTk+RvkdF5KOqxIHSm6YeE0Its7zXI+pzwO49wIx7YmJi6p/Wh+sse+ALneEj+9YIA
 4Jd+LgBOWw0QlFNd35jwe/zDgGQf4B2FZWu6Gwim7t/6Ge5XOWTQSLV/yasAMU0YyrsF
 RcDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUELG9hg/ZRTEyX4U7HyoTns8/Wwpz9roWmTFq106oIqL4xmsq5ajwnNWhbGEemuQEOmfATF8=@lists.denx.de
X-Gm-Message-State: AOJu0YzrNU8P6h8qiQ+tw3/8UdDFpV82/on4z4Ts6Rz9/zwI8sMsv/Rx
 1by2qe9+vFvVOwQv1IgkKIrKBpM6+ApRaob7ZBtSgJOoigHxZPL+2LUiNOqnc6jYvKHUrvOB0z9
 iM9bzAkpVN/JVECXOdAIbdhzCXKJgMciRM/+nsK+Y0Q==
X-Gm-Gg: ATEYQzwoXWjjMZYuLg2TUmgf8APrC5LJ43YUZw08JrOWLPmnsWH0Izgm4cUg51BswI2
 hZjXCRMl+2D9/nCeMW7fbV44/8kXpoULckBqNzi/Gr8NpWSTERt8xKylcyfAxcI3QmKtXA71akW
 v+Pwb/bhbrV5GhdWWgDAxqzO4prLXXTByCMYln+OXolK1S3lQiZCCrD+kMTjrQqMrgxytq31jkK
 yLLOFLGBzLWkYud0e/uoUxjIjL2zcZ6kZeNR9UQasw605wyXJvICPAE+l/CcEPUPEZX1yY4y7zX
 UKZHSGOqBEdtgB0A0/JFmReBipAwOfSQSdeENz1pKoIu5CRzAesr8sAlUnS3orwMGTATiiPa6Ch
 t0VVbSt1S8MCLII20zZ2sPqeSPJY6WFgreXXRjbhu15snaWIUulx3Cj+B5+dywSbjaZDZ4kZdMi
 dMu14GJcOs3dYQLE4DRVivZ5vSdARGfLZQfbHpuvKRYRc7+F7yC+Qb0mEC5j/pRuVdcLQdwztY9
 OERdAOLQsNHs5oP5gX/Y1rA88LX4tGd60a0aRncKMGYz3zaiwVmBV3606G86Fsmvh69ReNYcT7I
 uhJBXqsNzkJgBv/Tuhxznvt3PTMl6I9ofpMueUpfgCDa
X-Received: by 2002:a53:d78f:0:b0:64e:a213:90b0 with SMTP id
 956f58d0204a3-6502fe96000mr2018110d50.72.1775035308203; Wed, 01 Apr 2026
 02:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
 <CAC_iWjKRrL8CtU5Fu-ZM=Yg8XQztfC8e6TAoCY_SGX_Ds8xHCg@mail.gmail.com>
 <3ed2db2d-bdbe-4ef2-980c-372a3e88fb31@kwiboo.se>
In-Reply-To: <3ed2db2d-bdbe-4ef2-980c-372a3e88fb31@kwiboo.se>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 12:21:11 +0300
X-Gm-Features: AQROBzA0nYePX2zydgdLhpO4hmDHVnJWI7KRJqF9qgSx3QkrB1TgE2fQszxY6gc
Message-ID: <CAC_iWjKXWx4QYAQm_vub5wHv92S_-SC2UepX4x9PP0SmG_t8RQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Jonas Karlman <jonas@kwiboo.se>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, 1 Apr 2026 at 11:54, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 4/1/2026 10:31 AM, Ilias Apalodimas wrote:
> > Hi Jonas
> >
> > [...]
> >
> >>>  #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
> >>>       /*
> >>>        * Detect whether we have so much RAM that it goes past the end of our
> >>> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >>>                */
> >>>               return 0;
> >>>  #endif
> >>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> >>> +             phys_addr_t old_top = gd->ram_top;
> >>> +
> >>> +             ret = fdtdec_setup_mem_ram_top();
> >>
> >> This seem to make assumption that memory is already fully described in
> >> FDT? Maybe this should instead be based on gd->bd->bi_dram, however that
> >> is possible initialized at a later initcall.
> >
> > It is. That was my first approach in fixing it, but the
> > gd->bd->bi_dram contained garbage at that point.
> >
> >>
> >> If I got the call chain correct board_get_usable_ram_top() is normally
> >> called from INITCALL(setup_dest_addr), and gd->bd->bi_dram banks are
> >> typically initialized in INITCALL(dram_init_banksize), a later initcall.
> >
> > Yes
> >
> >>
> >> On e.g. Rockchip there is no memory bank information in FDT at that
> >> stage and memory banks is populated to gd->bd->bi_dram based on
> >> information from dram init and only later possible added to the FDT for
> >> booting OS.
> >
> > And that happens after u-boot has relocated or before?
>
> gd->bd->bi_dram is populated during dram_init_banksize() so I think it
> should be almost just before u-boot is relocated.

Ok I'll check that on QEMU. If that's true I think this is a better
approach overall. We can skip all the DT parsing and if the iformation
is  filled up before the reloc we can use that to decide on the top
reloc address. Which will also be useful in getting rid of bespoke
board ram init functions, like the one you have in rockpi.

>
> I am not sure when or how, but the OS knows about the bank information
> populated to bi_dram, not sure if some fdt fixup is happening just
> before jumping to OS.

Depends on how you boot. In the EFI world we add all the memory in the
memmap, but marked the regions above ram_top as reserved (but
reclaimable).
The OS then boots and can use the entire defined DRAM.

>
> On Rockchip we keep gd->ram_top below 4 GiB to work around any >32-bit
> DMA issues, however we do populate ram_size and bi_dram with correct
> info gathered during the initial dram init (U-Boot TPL or external TPL).

Yea, that's the next problem to fix. We already had a discussion with
Marek on how to fix this.

Thanks
/Ilias
>
> Regards,
> Jonas
>
> >
> >>
> >> Rockchip does have a platform board_get_usable_ram_top() so this will
> >> not be an issue, but the new generic Kconfig option added here seem to
> >> have a dependency on FDT containing memory bank information, if I am not
> >> mistaken. Maybe something worth mentioning in help and commit message?
> >
> > I can amend the Kconfig option. However, people using that default
> > function are already aware of this.
> >
> > Thanks
> > /Ilias
> >>
> >> Regards,
> >> Jonas
> >>
> >>> +             if (ret)
> >>> +                     debug("failed to relocate to ram top");
> >>> +             ret = fdtdec_setup_ram_size();
> >>> +             if (ret) {
> >>> +                     debug("failed to calculate RAM size");
> >>> +                     gd->ram_top = old_top;
> >>> +             }
> >>> +     }
> >>> +
> >>>       return gd->ram_top;
> >>>  }
> >>>
> >>
>
