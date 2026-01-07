Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC1D0D16A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAA083A91;
	Wed,  7 Jan 2026 20:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j/KCwxIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA6084051; Wed,  7 Jan 2026 20:02:04 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD24183A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so462263666b.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812520; x=1768417320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YeDRcxhIe7Osj97/4/Lrf7/WE+ZZyrnJVemNQwAIjrg=;
 b=j/KCwxIA1Gcybl+8udTw38EWLBQP2Olrt1uY9A/YciwhGYS14McFbArygAyq/ikAHu
 O2ItUQRj9hGg+0KbkgG1ko1jnP0a1ECSmncp95a90ua9IWD3IrD0P1D5j4taGfqVzhi+
 wA81M3y/qouIhcBua9nUTBNXE4uYZ4U4rilMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812520; x=1768417320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeDRcxhIe7Osj97/4/Lrf7/WE+ZZyrnJVemNQwAIjrg=;
 b=q2F+bnzHdMhbivr5ySaQXsthVLwa3T7VUOdeanWvVTNBNQmpGrCWDC/TQofdP5Vk0G
 b1Ip9tGYe9gxl0fKbiUoqbCBzBwhx+IOJg/VAO1EnYiNaROCcdTw9O0diU/gYDv2QuCe
 tO2aBhpfRUojH8CpyTi9GW32XgAerf1OZKrCg3vvSKMz+qU7pYOH4erXCq8V4GYdZ9MV
 auolPZaAtgXwm28sFJQoR37rK0bbyg/pnusIoQ0H4UqrshMWsLbZ6BlWHEZHUeHqywUy
 kTdXoAIvAF+ZBGHkpzZWULurvK5U8tfqMoepVriTcEufNBVDfA4bS+37wDwIzNi6sHH/
 sECw==
X-Gm-Message-State: AOJu0YxSbGI2yW9COg8p6NbrqayglTUsc/w0xt5bgaDzAjvSUzBW6O26
 hG25TrxTpEXlsvG08R8BzRuoAKzxesn6xijb0FId9UQR6QMBOBZzSDFNaA4dPRtNbDKhY6fG/kk
 MoOMx4VU6FuqOCG9BXG2SBFiJXLZ1eDseYjZI6peb
X-Gm-Gg: AY/fxX43fD8Ne+hYECAQMdOyFddbWJREdzV2a9+l/IKNYF9DLBAFpEYphpaqUWsqags
 fOEXDNYptjGU81PdskP1U3/Qbahoq04x3Fd4GFPYda+uRf6Ud7ipWzvJvxiRBfDNvHx4KZ0WBny
 rAMHwgyi1v43DT3CrXPlL9rLmaT7aQUn4VOc2RaGjKqhx4fQLXaFdSXH3Gra6Ev8OiroApuooGQ
 dylIGG0GlelUnZUUitKnB34+Tu/ky8KytDj3cAYsCGgbRUmaKGxJp/ovIhfgnSwFX4rnQ==
X-Google-Smtp-Source: AGHT+IEt6pbi4uqtJu8XlmzHY+krh3gJS2lZD5cdkKoz+fkAo/F+nQ9OAXZoto7RyxBni/iUnVn7QLjEFo+HVO2DWSI=
X-Received: by 2002:a17:906:c144:b0:b80:4031:bb56 with SMTP id
 a640c23a62f3a-b844516a82emr312669066b.4.1767812519822; Wed, 07 Jan 2026
 11:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-9-simon.glass@canonical.com>
 <CALeDE9OuqwihBTNHaVa7yOMUT7y2i0iqLMg4Zc=OKDpDE_foBw@mail.gmail.com>
In-Reply-To: <CALeDE9OuqwihBTNHaVa7yOMUT7y2i0iqLMg4Zc=OKDpDE_foBw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:01:48 -0700
X-Gm-Features: AQt7F2oxVlJQQGsfpRIXPFO19iFcYbqIPlhUiqdFWRMvy8bQSGbsUMSG3Jhzicw
Message-ID: <CAFLszTj5jvRT5y0fWze0dGM3wUM3ej=iS9iUqGcJDycotLeXLw@mail.gmail.com>
Subject: Re: [PATCH 08/10] riscv: Call bootm_final()
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Tue, 6 Jan 2026 at 19:33, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 7 Jan 2026 at 00:40, Simon Glass <sjg@chromium.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Make use of this function, adding some pieces needed by RISC-V
> >
> > Drop the udc_disconnect() from EFI_LOADER since it is now done in
> > bootm_final()
>
> This is two different changes, please split the patch.

OK

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
>
> Do you have a clone? Choose one email for a signoff please.

Yes it seems I do, and will do.


>
> > ---
> >
> >  arch/riscv/lib/bootm.c        | 22 +---------------------
> >  boot/bootm_final.c            |  9 ++++++++-
> >  lib/efi_loader/efi_boottime.c |  2 --
> >  3 files changed, 9 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> > index 35403e03ab0..bd47275b52e 100644
> > --- a/arch/riscv/lib/bootm.c
> > +++ b/arch/riscv/lib/bootm.c
> > @@ -32,27 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
> >   */
> >  static void announce_and_cleanup(int fake)
> >  {
> > -       printf("\nStarting kernel ...%s\n\n", fake ?
> > -               "(fake run for tracing)" : "");
> > -       bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> > -#ifdef CONFIG_BOOTSTAGE_FDT
> > -       bootstage_fdt_add_report();
> > -#endif
> > -#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
> > -       bootstage_report();
> > -#endif
> > -
> > -#ifdef CONFIG_USB_DEVICE
> > -       udc_disconnect();
> > -#endif
> > -
> > -       /*
> > -        * Call remove function of all devices with a removal flag set.
> > -        * This may be useful for last-stage operations, like cancelling
> > -        * of DMA operation or releasing device internal buffers.
> > -        */
> > -       dm_remove_devices_active();
> > -
> > +       bootm_final(fake);
> >         cleanup_before_linux();
> >  }
> >
> > diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> > index 7077702d8c7..7f069877d06 100644
> > --- a/boot/bootm_final.c
> > +++ b/boot/bootm_final.c
> > @@ -7,17 +7,24 @@
> >
> >  #include <bootm.h>
> >  #include <bootstage.h>
> > +#include <usb.h>
> >  #include <dm/root.h>
> >
> >  void bootm_final(enum bootm_final_t flags)
> >  {
> > -       printf("\nStarting kernel ...\n\n");
> > +       printf("\nStarting kernel ...%s\n\n", flags & BOOTM_FINAL_FAKE ?
> > +               "(fake run for tracing)" : "");
> >
> >         bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> >
> > +       if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
> > +               bootstage_fdt_add_report();
> >         if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
> >                 bootstage_report();
> >
> > +       if (IS_ENABLED(CONFIG_USB_DEVICE))
> > +               udc_disconnect();
> > +
> >         /*
> >          * Call remove function of all devices with a removal flag set.
> >          * This may be useful for last-stage operations, like cancelling
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 13d0d4dbe88..0bc66ee61a8 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -2238,8 +2238,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> >
> >         if (!efi_st_keep_devices) {
> >                 bootm_disable_interrupts();
> > -               if (IS_ENABLED(CONFIG_DM_ETH))
> > -                       eth_halt();
> >                 board_quiesce_devices();
> >                 bootm_final(0);
> >         }
> > --
> > 2.43.0
> >
