Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73663CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102968341A;
	Mon, 11 May 2026 15:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGJ5kxtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 910D983DBF; Mon, 11 May 2026 15:18:09 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD7581E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so4937978a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505486; cv=none;
 d=google.com; s=arc-20240605;
 b=aZU80FO7B8yhSUP+A/RNZLcHBD3w8Ivbabk5Zhu0s06ia3Z1eCnZhoCDrxvMDFYmeX
 qkspaM7Ehm6mKX+hrxLVGj/1H7lmeWfLtBz9Jm9dF2tb2dsYF7peay9tyPf6aeDHHtSA
 Okie0+Pg7e/dIsnOWR1P0Go63vlj7n3Rwl01NmNo7OLtx4xnIDHKwsO933a/q/994Eg3
 GGvZm1AiiGv6pIZGHNJuDDBNPW4SRfaxYO8vXSPXaTRF12yONzrbq6NQidA0KuT/ps67
 6oiWKb4mM0zCbPI5J0ygcWPqZ4peclT2VcIxzThaWSVxolS8Mr6wDaETTML0ylHSrMNT
 2kfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cTjvOPvmQihVbHEkuvb4rbXCFdE6hee++FecvmtQwkI=;
 fh=XMGPZOvrWPTh4jxpYqp7bf2uJCORZqdYFHSCmuIYfc4=;
 b=aYy++rbHfDAQHaUn3i/WBQBu1nJzaOXfBtvArT6s4uxYhxdveZwrcGqYJ9/u9PgXqJ
 kkTGKI8/wUhwINBL0cPcIOtZYRT7ZSCTPKF8YPm7+SbHKD8hK/s9mnZRdqFnlFdEZ+7s
 zkUAHvIbdZkVvlH5LOK3sDFDW3sW6Hl7kpiI7P0XUTLbSbx9SHuJ9KZ8Zg1sjC64mflg
 u4XAPaMtfVneBSJtbuTxv08jYElGNLqUEdExj06Tdfq85zFI3ZpHxl+zXNuUFO1eEvYy
 qPwORc/Ei+nOg6F2wGMMl0BjQgrOEbWQbe8CI42ASt5Yqngem4SNSYxMYKd/tDiWLn2q
 yRPQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505486; x=1779110286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cTjvOPvmQihVbHEkuvb4rbXCFdE6hee++FecvmtQwkI=;
 b=AGJ5kxtCk/km8nj692aGKnRuhZ/UGWGU4f4Pa/XjsH/faEDz1/f2XaF4T6kWDYVfkd
 E2HO2gFX9HTt13rEhXaGWKZQK3l92387hcdD7apsCyi7upgQSZHmpj1M7wRy0ueoi2Il
 IfDpKQZFjY5UuinRBJa/kdyWKj6/T1UkpzUVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505486; x=1779110286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTjvOPvmQihVbHEkuvb4rbXCFdE6hee++FecvmtQwkI=;
 b=GK1AfEgm2TgLDFu36dehpYnSHJ84Hf03E0GhCzsNjPBrr8loKuI7wWmOvFvu7MbQmZ
 eaO+AhtDfkz3ywzH5UjVci0vsMExxD71fA7pOn6yo2hbFPYhAPVGM7UhbkeHsa8cK7Xy
 STeGxwmBWa21IFA7MlGgZZzV9IyMkTPjd8mpDavrBfU6NffkbsZZbwfFGfOwmGGntIwG
 KIdrDMRWhjKE2p4PtveUCHn7FOf1I4jnOyD1ypyEXEIdPrwRkNEu2WwrUPAr1U8dYe9e
 pIIcmi2CBQzI1J3p6LQDNYMxaBz8o6t3MRmsXY6DM8Miq1dgE8wW2H+3SjYn9xh0qt75
 88Gw==
X-Gm-Message-State: AOJu0Yx6/LaPkvbxC4gAohnY2s8BDtX0vVS0bDaSrBrHP9F6TWrxWYHM
 c1YYsb2fIt2daLCCz9cknjmT5H+5LPd9sSdqQ6iT6G/al7/cAg2XlrTwkaAWSzzJitAw6RfVua9
 xVgGim5w25amXzggvlmcxu69lfxjhMAceU1i8JK2X
X-Gm-Gg: Acq92OGAbhJBmFumPh2BaYDqVrUd9hGpqOrON7D5VaAr49tWwJE7+SjhgS2ATwtX3wP
 upN9AbQEmVP6Li2jo/6vb2CApq5RUmIkh35Mukf1RAXDEh1edTl0MfcEhLAO1Be/50NFEcpJy1z
 IZhQ3VANiYYDnHZp/HjsT6Ywzgoo4YsDtNwML2IHw9gm2Y1IrzZQ0LrcpgIT+w7aJ3WX+Z2hgN7
 pot2nVqovAD4wjfhH+0ivBxPoZzfydpGflv0eLIh+rwvjw4+0rOmLGSeJFwvEaIdmZvroHsasNU
 a0AMvg==
X-Received: by 2002:a17:907:1685:b0:bc6:222d:8c95 with SMTP id
 a640c23a62f3a-bc6222d940amr1276020866b.11.1778505486502; Mon, 11 May 2026
 06:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
 <79f3438d-a6d9-48a8-8cdf-01dde7b5e2b1@siemens.com>
 <CAFLszTg_EFGf6CTJsNdnFiJrxYKm8799ZDA+wEgLYXEqQ-3_xA@mail.gmail.com>
 <dad3e201-d209-4ea8-9d19-422c635e1e06@siemens.com>
In-Reply-To: <dad3e201-d209-4ea8-9d19-422c635e1e06@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:17:54 -0600
X-Gm-Features: AVHnY4IqXllkTZcQneMRCeAxCf_uioqckUFxK2UWRFbLJu2qq8vCetS_IKLr9qM
Message-ID: <CAFLszTg2rGDEqcgrabMLVec8d0SzbXQ2D4_yATCG9v1EoYfeaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Ludwig,

On Mon, 11 May 2026 at 05:18, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/7/26 17:33, Simon Glass wrote:
> > On Wed, 6 May 2026 at 09:29, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>
> >> On 5/4/26 14:26, Simon Glass wrote:
> >>> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>>> qemu: overlay signature nodes
> >>>> [...]
> >>>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> >>>> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
> >>>>    int board_fdt_blob_setup(void **fdtp)
> >>>>    {
> >>>>         /* QEMU loads a generated DTB for us at the start of RAM. */
> >>>> -     *fdtp = (void *)CFG_SYS_SDRAM_BASE;
> >>>> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
> >>>> +     int ret;
> >>>> +
> >>>> +     if (!*fdtp)
> >>>> +             goto out;
> >>>
> >>> This runs the opposite direction to qemu-sbsa, which uses the U-Boot
> >>> DT as the base and overlays the QEMU DT onto it (see
> >>> fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
> >>> this way, any node in U-Boot's built-in DT that shares a name with a
> >>> QEMU node (/cpus, /memory, /chosen, ...) will have its properties
> >>> merged into QEMU's, potentially clobbering the hardware description.
> >>> If this is correct, please explain in the commit message why the merge
> >>> runs in this direction.
> >>
> >> IIUC the FDT patching happens before relocation. QEMU starts u-boot from
> >> a ROM at address 0 so writing to the embedded DT does not work. QEMU's
> >> provided DT is at a writable RAM location so patching that one works.
> >>
> >> I don't know which direction makes more sense really. If you say merging
> >> QEMU's DT into U-Boot's is better then board_fix_fdt() could be used for
> >> the merging I guess. Looks like that could work with
> >> CONFIG_OF_INITIAL_DTB_READONLY and CONFIG_OF_BOARD_FIXUP set.
> >
> > Hmmm now I am wondering how this actually works with sbsa. As you
> > point out it's hard to see how the fdtdec_board_setup() works before
> > relocation...I don't have the energy to dig into it, though.
>
> AFAICS SBSA relocates u-boot into RAM via
> arch/arm/include/asm/arch-qemu-sbsa/boot0.h on startup.

Ah OK, well anyway what you have seems OK to me. Let's see how it goes
down the track.

Regards,
SImon
