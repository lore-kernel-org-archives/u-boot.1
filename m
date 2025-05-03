Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E34C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 07:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9123481E72;
	Sat,  3 May 2025 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hYdFyWMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BA881F66; Sat,  3 May 2025 09:04:30 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AEC812BC
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 09:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A79D93F1ED
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746255865;
 bh=usmwebb9DiWDMNklD4bZhjnwyWt+J032NEcJhNy2JjQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=hYdFyWMQs2l2lrXvuQlqjEXkmzb+xdzvvN86HcphAu5J6R8jaaBMagJmLlNk02iUf
 3rl8sfu1Zme/SNAsiUZCjCvEzcd/NE8GFQ5i5i3+nrpri6qWRcAZpzieQfu3b2q3ke
 gXfUHk79czZLJKnHztTNFRM3UuxXhSsDM8UpBjYPKuJyia1TTQvBzlKZLajUfRjtHJ
 9VEvR8kPqgevLZRyWQmeR/8yNAldumBtm4vC3NtH+OQYxlIucu3V9raDUvSzN3C5iW
 WNMynzndEgk4UsS985CbqBpM5iXeghpoG1AwYZ77tR0b1p7XqGzSRw+qQuUSDtuIiw
 EtRQpCAwATybQ==
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-225ab228a37so22130435ad.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 00:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746255864; x=1746860664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=usmwebb9DiWDMNklD4bZhjnwyWt+J032NEcJhNy2JjQ=;
 b=XaVSBVPea1Xs3CRSw33+evZsu+O3ZHUVh30MA34rXAADO5t2As9CCrDMnVMH+6sNWc
 GhGi39nFv0YB3WkhXpVeFSJkeZJ7Zk70JvBNjlTpSk/oUuBEnysUe9HHRNZbxtomek3B
 pZPztFRGibV3G8t/ZYNO48CmO8+dWzt6jTjyQtH+GlB7o7llxk48F0lnnfQUrnC9KxO4
 swVtwRrp1w89uBis0bW3ab8cDqROd7nRcU6AVVdIxf9iw1DdCOP4mAfXEfBZwdmAc6ie
 nl9A8/SnCWMcZ2Olkd5iMZG9QX2+Tmwq5AhZ3LQDvISLe9IEg0Amp6UjHAt9VwDc06kS
 b22Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhNzsKpJAGwmffp9nByH9USy3uZQ3F8viyOML5I0HYXYvxgQTAmHb18Flo5XzkPxSgjIJ+Yhs=@lists.denx.de
X-Gm-Message-State: AOJu0YylWmxrzn5nfdMvBr0/nBrmyxlrX5NkOBggLcbaG3spxzkfIw2O
 HiOXFsrxY42W81o8fjIQNr7Kvvv7HI5FXuoFc5hHnFAMcS9mBKYqD5bAzr4jcNbCQGDv4dKiR7R
 XaRP3ExjchTt1I0bPRIMAoI8i46SMRC1SinBWM1dKgAaqkebFlic7/cRxxOrcLdANWodk4HhDn8
 o6d4kM0WESGv7Gmcjxg0gBBIgyc03bpnyPZUkgonSbeA==
X-Gm-Gg: ASbGnctBUtqiD+qsuiEmD/ZIqm4Acuta7PUiJVJbWwjsGouvLc25DtD7JHWmpRQk0Gp
 JABmRTkqdphjYKpb/y104nNZurwXJdsFklNN+nfR4eT8iaDTEbwvtufWdLS7TidcZB6hh
X-Received: by 2002:a17:903:234c:b0:22e:17ac:9dd8 with SMTP id
 d9443c01a7336-22e18bfa9eemr28625075ad.29.1746255863767; 
 Sat, 03 May 2025 00:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMhQrBviiJtk9UbSbHmxFgWYiQTSOSMoSapbHu0zTaoIz0ycxCDwCjm0kMz/HFINJoQhnyaaCwrBiFXtMu5m4=
X-Received: by 2002:a17:903:234c:b0:22e:17ac:9dd8 with SMTP id
 d9443c01a7336-22e18bfa9eemr28624795ad.29.1746255863247; Sat, 03 May 2025
 00:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <CAFLszTg1Z7PArfxUUiyoNDsBj1N7Q23dn_xwhAJQ3pGikR0hzw@mail.gmail.com>
In-Reply-To: <CAFLszTg1Z7PArfxUUiyoNDsBj1N7Q23dn_xwhAJQ3pGikR0hzw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sat, 3 May 2025 09:04:11 +0200
X-Gm-Features: ATxdqUGChJApT6sN9fDJpIA6DMYcBh-KQzRcx38YJVf_ZiR4pkp8jN6V0BhFsLQ
Message-ID: <CAM=mAOmqSN7XOQonsOA6Q79T0MZRKpv3eObDCFMa_v4_3QzE6g@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 04:10:

> Hi Heinrich,
>
> On Fri, 2 May 2025 at 10:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 5/2/25 16:49, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> The EFI boot manager bootmeth does not require variable BootOrder to
> be
> > >> preexisting. It creates this variable.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
> >
> > >> ---
> > >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> > >>   1 file changed, 3 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > >> index 42b8863815e..1669cbed5bd 100644
> > >> --- a/boot/bootmeth_efi_mgr.c
> > >> +++ b/boot/bootmeth_efi_mgr.c
> > >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
> struct bootflow_iter *iter)
> > >>
> > >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct
> bootflow *bflow)
> > >>   {
> > >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > >> -       efi_status_t ret;
> > >> -       efi_uintn_t size;
> > >> -       u16 *bootorder;
> > >> -
> > >> -       if (priv->fake_dev) {
> > >> -               bflow->state = BOOTFLOWST_READY;
> > >> -               return 0;
> > >> -       }
> > >> +       int ret
> > >>
> > >>          ret = efi_init_obj_list();
> > >>          if (ret)
> > >>                  return log_msg_ret("init", ret);
> > >>
> > >> -       /* Enable this method if the "BootOrder" UEFI exists. */
> > >> -       bootorder = efi_get_var(u"BootOrder",
> &efi_global_variable_guid,
> > >> -                               &size);
> > >> -       if (bootorder) {
> > >> -               free(bootorder);
> > >> -               bflow->state = BOOTFLOWST_READY;
> > >> -               return 0;
> > >> -       }
> > >> +       bflow->state = BOOTFLOWST_READY;
> > >>
> > >> -       return -EINVAL;
> > >> +       return 0;
> > >>   }
> > >>
> > >>   static int efi_mgr_read_file(struct udevice *dev, struct bootflow
> *bflow,
> > >> --
> > >> 2.48.1
> > >>
> > >
> > > How do we know if the board is using EFI bootmgr? My understanding was
> > > that this was a way to find out?
> >
> > The boot manager must always run.
>
> Are you sure that is true? It seems false to me, e.g.
>
> - if we are booting FEL on suxi, it must not run.
> - none of the boards in my lab use it
> - the Ubuntu 24.04 test in my lab doesn't use it
>
> So how can we say that it must always run?
>

If a boot method that is earlier in the sequence boots the boot manager
will not be reached. But the existence of BootOrder or any other EFI
variable shall not decide if the boot manager runs or not.


> >
> > The check for the BootOrder variable introduced in commit f2bfa0cb1794
> > is a bug.
> >
> > The boot manager handles in sequence:
> >
> > * Try to boot as indicated by BootNext.
> > * Try to boot as indicated by BootOrder.
> > * Try to boot default path for available media.
> >    This will add Boot#### entries and update BootOrder.
>
> Regards,
> Simon
>
