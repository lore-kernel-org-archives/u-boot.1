Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C829CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8171801A9;
	Mon, 11 May 2026 13:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWY3xVf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249BF83CF5; Mon, 11 May 2026 13:40:40 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED34800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so6602020a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 04:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778499638; cv=none;
 d=google.com; s=arc-20240605;
 b=JFMOewDaWI0fD9OmqKGjjamXDDn8IEy54WNwwSs68Mk4QHCGu8hKZj+RTGIJtGEIAw
 2HQ7O/V2PsJrDV8r8Cojxtp4E52BPGtMKJPnfiGj9e4dqvZaElc1pBSDopM1i6A/lNvW
 BHTVT5bMq12Hc2NWCgPPRFhvrWaqtiOUWUiYq1i88SwLtUYglZLNddIUQafwDlzyHqKR
 Js4YqHHw6VBGUI8QsnilbKTJbYqOSov9eQbxD02i7eXIl+U4IRrnbEbRpoVFuxT3qZXZ
 WL+fI72LRLdX0Kq5qg8MAUvWshKs97hYli8fAWsFQlW8BpiFI4STLdrZbRjrFzfw9w2A
 vxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9nuhHCnddWpYDOS2f5pMh7QcfvPou74xppXEQAK/oTA=;
 fh=GQ2cjfQn5sZJCXk7Y4miokBo6mkL3WClEi6ZZsPVrlo=;
 b=LzgHZnNXOWJ0X8cWwVj0ZVY5jD6iYqR3UsvXjs9gFPXZPS6Aw6XmzErCHhBtGw82E/
 U9gwphyrAIu+ubzQ0WsqZORAMpSN80dAO2ekPuNt68lTuyoBaHMtIwpcqaEBzwYnZAof
 VdRb5roFclhotmcCInkGhwu9x9PjlHKfeZYfr9p+JEp3MccFbNE2iBT9IHGcqhltjKUX
 sQHEvI1LcFwAgPeZyZi8c+4hLa+ZSt8k8YyTPP29VqEbq4lbdtpevOXkO1Q/+l9xn8Q9
 nu1oEYLr4yuigm+j2oCseCDCiqMrXelMwcGVYHmWj2xqV0IKo1Z/OO3u/CRxnEDPaD5j
 ZFWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778499638; x=1779104438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9nuhHCnddWpYDOS2f5pMh7QcfvPou74xppXEQAK/oTA=;
 b=jWY3xVf8DQCjhEgC/BJAd4LneOHH4q3mmteuUBInB9i/tr3sBmPz8Cwof90akirC75
 mH+qfMxIzcRoCCUsrmtR0Vb0FLRZ+iww4rf8XxGVtUkMNNhsNoXlyH3MyavUV9+9yxEa
 WuShLhUVIylOhbLtEGOUJgDa2wfrbZhxoJxaLL9Ldc1bBOz50c+kFvCFBp3YIyBEAuWL
 vVrwWnnT3Fps1Sfn4prumsl7nGHmqQ/Hj6cD67U5zSEMIFOo5b2d3eE0/X69+nTIGlLt
 fKAN8h9plK8FojBE9iDIFd0WC0k+bbCcXXHbGmZVXyq7INMRDiCXMOapMmy1+fKBdbIb
 h0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778499638; x=1779104438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nuhHCnddWpYDOS2f5pMh7QcfvPou74xppXEQAK/oTA=;
 b=j9gPe+M93RM5piFOlOaZYDBOWNlp2VxarWpzNyLS0HLa3HXyLtPw3hZHjFMFjBdmqh
 6rp0QYF+A5bYSz+DDSP8ATGxg/NhGKOH+mVvRpnoPwrNfok5rDVc+jcA/VuUb0Ae9SiR
 xABMY6eMU1XaPDtF/18ULbO/1ZUtJPJn0tH8WOQtOEO6BEo33zYT+l7Ws8GaKfSJgH9T
 vyNclpZf/dGBpusjCsf5ZIrgqhdey13FVu8L5ITBOr4UGNBeR06l6PCKFCUbLUP+5tkD
 0IPvqIMzs9SSWfmeKdKmZFcEC+RU5a8KznG3u/bgGHpTkqMxgKl1RIdqoJLfvQExYhdc
 V3+A==
X-Gm-Message-State: AOJu0Yx0IOo1pOtzTQw5O4Ylwh6p4TaFvHn5JacaVRYMl8OwjXouvMiu
 oNC8gWqU4f2qjqvqa8h/uL9iNwodDG4DC/HBw8QLnOemmzBcjPWDxASLIBaEgmrErOdsCBC0Y3U
 WEB7aQCwa2D3R0ZqiAHgDvSNTzcZYk90=
X-Gm-Gg: Acq92OERnAVrczuQS+ZRKInvDEgf8I5Z0QDdnvb62qNSQdI8Dsc7TdxRsJUxxd2ZoMm
 GH23F8Qygz/6h1mZpQ6bCzK5/WsPya5j/fAAzKp2+pdc5w0ZCNn6TQdIHG0Kowfwz6zNTLaW9l5
 /C4e7W2au2n0xiQytyUjEgHneF0VmE+R+oEnZIjCskWpUMPSLPtpUv3IXfnPPA1ky3lABkzioyp
 rC1AqsqazrUBTEdMDoBGcBw015AKXkHGsfS7QlEWReG5UKc3hYWIxVicstZCuglI0TQ85BXnKI/
 OKb0FkF3uJwDGc9Zi5LU2YZNca8trxru/YcJ8LySIzyPvq3oR8SpyEzJkMKk0964cxquh2aLFCH
 MUXwM6h82TgN2XFCx5qUj/ZQZtxnLFmMj+0dZiEGPk1wpxg2GR/YlQ6LNegSVnahwvIiKiZuC3m
 Zm
X-Received: by 2002:a05:6402:13c5:b0:672:f3e:1475 with SMTP id
 4fb4d7f45d1cf-67d642bc479mr12556078a12.12.1778499637363; Mon, 11 May 2026
 04:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260508233254.2022495-1-sjg@chromium.org>
In-Reply-To: <20260508233254.2022495-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 12:40:25 +0100
X-Gm-Features: AVHnY4IaFJIDLzGCAw0LcDTy8om0mVmTCepvxGMd9ife5G4GJibhuad0IjYWDzA
Message-ID: <CALeDE9PLAf9-VrOCfKmDDiQHWFtMvowoB_U_35QZgixFiJ_s9g@mail.gmail.com>
Subject: Re: [PATCH] rpi: bcm2712: Extend DRAM mapping to 16 GiB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

Thanks for this.

On Sat, 9 May 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
>
> The bcm2712 memory map only covers the first 1 GiB of DRAM, but Pi 5
> models ship with up to 16 GiB. Accesses above 1 GiB fault because the
> range is not present in the MMU page tables.
>
> Allocations above 1 GiB used to be blocked at the lmb layer because
> memory above ram_top was reserved as no-overwrite. Commit 0efb6bc3e36d
> ("lmb: Reinstate access to memory above ram_top") removed that
> reservation, so callers like tftp now route allocations into the
> unmapped range and trigger a fault.
>
> Extend the first DRAM entry to 16 GiB to cover the largest addressable
> range for any production Pi 5 model. Smaller models are unaffected
> because aarch64 only faults on actual access of unbacked memory, and
> no peripheral region lies between 1 GiB and 64 GiB on this SoC
> (peripherals start at 0x1000000000).

So a couple of questions:
1) Do we need to do this for the Pi4 (bcm2711) too? It's currently at ~4Gb.
2) On the bcm2711 it sits at just under 4gb, initially that was
4Gb-16Mb AFAICT (917a1e9a78fe) and then it was reduced in a followup
commit (c44b3f523c48) because of overlap with "device's IO area"
3) why doesn't the rpi5 have the overlap issues?

Peter

> Fixes: 0efb6bc3e36d ("lmb: Reinstate access to memory above ram_top")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/arm/mach-bcm283x/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7a1de22e0ae..3d11c9e5c3b 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>
>  static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         {
> -               /* First 1GB of DRAM */
> +               /* DRAM, up to the 16 GiB maximum supported by Pi 5 models */
>                 .virt = 0x00000000UL,
>                 .phys = 0x00000000UL,
> -               .size = 0x40000000UL,
> +               .size = 0x400000000UL,
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>                          PTE_BLOCK_INNER_SHARE
>         }, {
> ---
> base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
> branch: rpi-us
>
> --
> 2.43.0
>
