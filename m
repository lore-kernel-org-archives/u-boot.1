Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401C8CEBF9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E44B89108;
	Fri, 27 Sep 2024 14:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eSSbye76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BEB89109; Fri, 27 Sep 2024 14:34:06 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5ED89105
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c54a5fbceeso13836516d6.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727440443; x=1728045243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RwkPzksTt8aQGhHHGqoYdGm1/NO77UwyKz93lgvBwUw=;
 b=eSSbye76Y1qpbe/nI/hoIPyERmT1nNqOvKsLbi0Tz0jLtbP15d5CXkV/aBA0ZVABYA
 HOhTKzlsNyXpiY+x6gvslAbVnkp6AChUCFCv3imlEuh7IxbnLtkewGvg8GdKPCkzrDCX
 ThoTExD0gxbYfzWNf5gjAuAEhDeeepVhnfgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727440443; x=1728045243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RwkPzksTt8aQGhHHGqoYdGm1/NO77UwyKz93lgvBwUw=;
 b=fJ4s5KD1GaW0hrZB8bhXV1UftVmlwWRr7m7kG5aCLK3dVmuXKF1PzHWrXrdy8BXz3Q
 dnutVuHpHPcIrGaIkCLZ1CRVkPRLr+nM9N3LPWd70GQr9skaQVxKWYj6syu5A+LG01Fr
 WxyRGbHKlJu24+85alet1RliqC2a4iVGJbtzID2kir3+VXOqrFTZzm6ABHclAIRs8Hb1
 6CwsT4g2qlqyEe4siWBJBArSnFinqBkQ7F6dOE49KQ4Y96fk9hh67OrT/UoybK9Z6W0c
 s0tXtBt8JVQ8WrJKIsc5OTNV8JXZFJxD/NCNqfvVht/NIrp2WMokF/U9EcF/LuZX9MT7
 1B0w==
X-Gm-Message-State: AOJu0Yz5/adPCxoxotlgssFXLi7LeCBfb7RTEqr9jToLESf9dGYnfJ9N
 Fe0sdtJsI4LmbFcVggMz/e6HL+P8gRHpPBSZ3NX7Jff/mb7qY4h8JhjONrdm/8g0sNPZNXqVegg
 D/KHekFOW0/5ecPbr158SAAvbYyTHaqFp/PuIaXGynjCQ1FEikHn5
X-Google-Smtp-Source: AGHT+IH6wJJfxXfFpwYBv6ySR/w4cG4QrURazNPzxGC+sFpffCVwpSwz38uE5tiS8bywJyNve9zq1Re0GdjzCEqoKuo=
X-Received: by 2002:a0c:ed4f:0:b0:6cb:3cc8:5d7a with SMTP id
 6a1803df08f44-6cb3cc85de1mr31654146d6.35.1727440442715; Fri, 27 Sep 2024
 05:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-6-sjg@chromium.org>
 <CAC_iWj+Rq4rt6otGAHWd48CG_tf=LBCfs3740rPUNYhLTaAVVQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+Rq4rt6otGAHWd48CG_tf=LBCfs3740rPUNYhLTaAVVQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 06:33:52 -0600
Message-ID: <CAFLszTj=BeSpwrK5jU4X0+fWEpBtay1vK=AmcyQdQbvPeWjxqg@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] efi_loader: Show the vendor in helloworld
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Fri, 27 Sept 2024 at 06:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
>
> On Fri, 27 Sept 2024 at 01:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Show the vendor name so it is clear which firmware is being used, e.g.
> > whether U-Boot is providing the boot services.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I already sent my r-b for this. [0]. I am not sure Heinrich remarks were covered

Heinrich basically didn't see the point of this patch, but then
suggested printing out FirmwareRevision too. I did reply but didn't
hear back.

So I suggest we just go with this and we can expand it later. Or just
drop the patch.

>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Reword commit message
> > - Use 'Firmware vendor' instead of just 'Vendor'
> >
> >  lib/efi_loader/helloworld.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> > index 586177de0c8..c4d2afcb40a 100644
> > --- a/lib/efi_loader/helloworld.c
> > +++ b/lib/efi_loader/helloworld.c
> > @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >                         (con_out, u"Missing device path for device handle\r\n");
> >                 goto out;
> >         }
> > +       con_out->output_string(con_out, u"Firmware vendor: ");
> > +       con_out->output_string(con_out, systab->fw_vendor);
> > +       con_out->output_string(con_out, u"\n");
> >         con_out->output_string(con_out, u"Boot device: ");
> >         ret = print_device_path(device_path, device_path_to_text);
> >         if (ret != EFI_SUCCESS)
> > --
> > 2.43.0
> >
>
> [0] https://lore.kernel.org/u-boot/CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com/

Regards,
Simon
