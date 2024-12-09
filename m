Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE3E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D258979E;
	Mon,  9 Dec 2024 20:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GqD5NbAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1FD89792; Mon,  9 Dec 2024 20:27:47 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015F489792
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so297122366b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733772464; x=1734377264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5X6y2tAq5CGAWNF24tzc3U0MqaJPHhOxbj3zBPndnU=;
 b=GqD5NbALp8gzOrVWFwHZsQzXiDJmPcT/Z09F/EODrsTPVt/IGaexfrGB726wOazOUD
 /1bB6132xhMbY7lFx1asQ0Oqd+TRAw2ORl81b8FnMM+8aE8onhcsboiKAWm+tTRSTLtv
 SdqXkdvuqQbUpBM0q2DNhP97ul4m/Y3Y1kyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733772464; x=1734377264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5X6y2tAq5CGAWNF24tzc3U0MqaJPHhOxbj3zBPndnU=;
 b=XMq7w2DERzhbreNTA6aAdKw6hu8fZsO3H25pICEwOoWrVYjkWFV1ALnN6smSAYGWXr
 9X9tEQ1KHkCleipII3jzQZNvTeK9jy9coal/quegO6jjLOAaFBft1gmZTVIW3wt0hdOt
 DWE54GyFcIHzUx1p1Kf2xT3e6ZIDCAVDiQVKFSRrbB2mn/Fgh0f3T1Ah6pECCyBAHQyl
 uowSW5vRyJXeTur3ZaOgI8AeqtebT1z/j1tn7LybnfT1iKO8KgC/6Z5ZhyCMRhlLvrFV
 IctZ4vwA5CuHtt/HWEfX6tb++8n4l/2B/0eOK7pwL29slwf5UQdF8+Sgqbv9zXgMUwfA
 36xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9COIb8GdED6pjwCkIm8IXkKxQ0pyB8QgP+qCpVDI86UlO2ANDOy2wXNgII1FiVERs/hFespk=@lists.denx.de
X-Gm-Message-State: AOJu0YzKXwUZ7/D/iJMEOTYPQk0BEuv4yIcxABkIL0Hw5R8TxDkWfTnN
 5WNIw5zcMcuJW5ZkITOWZHZP4T5r0YVUY6MJlFas38EPo7NSzpPqBryS/+QpuYQ4l+sxlJPjds5
 8eu9SONs8i8JeZPacwwccoPlJmhMovVOpion4
X-Gm-Gg: ASbGncufl8u06jCn4wq+nNFVOUSMrCvSp/6DeoH8m8v00cXGXyJLhX/mxVn8nT3ADk9
 JC7KkAa4F+6b9Ylhcaixepwb7E7XlnArLzG3w
X-Google-Smtp-Source: AGHT+IGZjUvb5f6JwIGJa8t+3iXPcQZFxHzfpM0cCIwRcEa9ev72GTzhVkmua0vovfWVGkPWPJVWJuP+rS/RYvXQR0k=
X-Received: by 2002:a17:907:1c85:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-aa6a006e645mr50854866b.8.1733772464410; Mon, 09 Dec 2024
 11:27:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
 <20241209192340.GV2457179@bill-the-cat>
In-Reply-To: <20241209192340.GV2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 12:27:31 -0700
Message-ID: <CAFLszTi-NsvU=UP2Ze7NH4iGRKtG1Ja9Z5pFig+52LNJRxqd-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com, 
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Mon, 9 Dec 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 09, 2024 at 07:34:34PM +0100, Michal Simek wrote:
> >
> >
> > On 12/9/24 16:47, Simon Glass wrote:
> > > Hi,
> > >
> > > On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> > > > >
> > > > >
> > > > > On 12/6/24 20:20, Simon Glass wrote:
> > > > > > On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
> > > > > > >
> > > > > > > Calling empty function when BINMAN_FDT is adding +64B for nothing which is
> > > > > > > not helping on size sensitive configurations as Xilinx mini configurations.
> > > > > > >
> > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - new patch
> > > > > > >
> > > > > > >   From my perspective there is no reason to call empty function. It is just
> > > > > > > increase footprint for nothing and we are not far from that limit now.
> > > > > > >
> > > > > > > ---
> > > > > > >    common/board_r.c | 7 +++----
> > > > > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > This is a bit odd, though. Do you have LTO enabled?
> > > > > >
> > > > >
> > > > > yes LTO is enabled. And there are other candidates like this.
> > > > > Is LTO able to fix function arrays which is calling empty function?
> > > > >
> > > > > (without this patch)
> > > > >
> > > > > 00000000fffc0eb4 <initr_of_live>:
> > > > >      fffc0eb4:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0eb8:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ebc <initr_dm_devices>:
> > > > >      fffc0ebc:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ec0:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ec4 <initr_bootstage>:
> > > > >      fffc0ec4:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ec8:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ecc <power_init_board>:
> > > > >      fffc0ecc:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ed0:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ed4 <initr_announce>:
> > > > >      fffc0ed4:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ed8:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0edc <initr_binman>:
> > > > >      fffc0edc:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ee0:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ee4 <initr_status_led>:
> > > > >      fffc0ee4:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ee8:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0eec <initr_boot_led_blink>:
> > > > >      fffc0eec:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ef0:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0ef4 <initr_boot_led_on>:
> > > > >      fffc0ef4:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0ef8:   d65f03c0        ret
> > > > >
> > > > > 00000000fffc0efc <initr_lmb>:
> > > > >      fffc0efc:   52800000        mov     w0, #0x0                        // #0
> > > > >      fffc0f00:   d65f03c0        ret
> > > >
> > > > No, but maybe Simon would prefer if we marked all of the could-be-empty
> > > > functions as __maybe_unused and did:
> > > >          CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> > > > etc in the list instead?
> > >
> > > Yes that looks better.
> >
> > But we are talking about using macro inside array at best with using #ifdefs.
> > Or maybe I am not seeing what you are saying.
>
> No, nevermind, sorry. I was hoping that:
> diff --git a/common/board_r.c b/common/board_r.c
> index ff9bce88dc93..c18997446dfa 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -610,9 +610,7 @@ static init_fnc_t init_sequence_r[] = {
>         noncached_init,
>  #endif
>         initr_of_live,
> -#ifdef CONFIG_DM
> -       initr_dm,
> -#endif
> +       CONFIG_IS_ENABLED(CONFIG_DM, initr_dm),
>  #ifdef CONFIG_ADDR_MAP
>         init_addr_map,
>  #endif
> @@ -632,9 +630,7 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_EFI_LOADER
>         efi_memory_init,
>  #endif
> -#ifdef CONFIG_BINMAN_FDT
> -       initr_binman,
> -#endif
> +       CONFIG_IS_ENABLED(CONFIG_BINMAN_FDT, initr_binman),
>  #ifdef CONFIG_FSP_VERSION2
>         arch_fsp_init_r,
>  #endif
>
> would work, but the macro doesn't evaluate how I'd hope it did and that
> just blows up.

You should drop the CONFIG_ inside the brackets. Also, you need
something like this, since the comma must not be present unless the
option is enabled:

CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))

If we want to do this more generally, we could:
- convert more things to use an event (then the cost is just 4-8 bytes per item)
- add a helper to initcall.h to make it easier, e.g.
INITCALL(BINMAN_FDT, initr_binman)

Regards,
SImon
