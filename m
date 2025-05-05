Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F1AC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 19:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59ECA82161;
	Mon,  5 May 2025 21:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dV2cUBpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD7F82163; Mon,  5 May 2025 21:52:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7748215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 21:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D0BDD3F2C2
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746474725;
 bh=tzkbCWX0zjZNy4aDsMKvxnP26jZIyqHGxfA8f2dEnTA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=dV2cUBpre2FbktjxHNIV6fh0B6ZBUScmNoGxVD+K46/9ezPOTU0P33vtVBeSCrK2h
 WrYXhq1ToOWz6zWgI2dBxdfURts2brkKPBTk5qcr5WDX0NsHbVpgJaC8w86FlaYRX4
 7fElH1ERlN08ytP4xXfRoB5XBJu2Au9zmnJ+Wn7YvH1FIxz/5mReLzwHdkiaXcD7oI
 MkggDWdqPJiJq4f5RXV4K8tuTACOffGRYHp5qUpvRv7nIrcxqaSvYkbPw97aDZ+OPI
 2iMvEweH9zlXCcAIzuquUZgtXkkceNHbnkJQ7kBKgu/b1aSeNkgUA/E7MvLaafZzX7
 HQJbKXcurT4TQ==
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30870e7e4fcso3196688a91.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 12:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746474724; x=1747079524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzkbCWX0zjZNy4aDsMKvxnP26jZIyqHGxfA8f2dEnTA=;
 b=nsuxVx9PVsI/3FM08VE1jX8cHl6YP5QE15bGxgZuifgtiofnB75jwbixes0R83EgDx
 GbfGA1JVk7oyKet1XlIElGqdqDtKJJesSJkggbY262AzQ+ucmxYOMywNc570jH1gt/oc
 +7VfUKDpaTqMOM7L6FnPffE9u12h42lCzEAmqX8xQ8CEkGgEZCdoOVEc9Z1vRS+R0NVc
 fuJcejcVUB2W8Nt7ZWkeHTIz4IfTZp8l/vQVqBwWvivjlpWllSst0ReYHIKEz3PaKT/O
 Sabv9ZkUrD5lzNzFl49Jn0zoQnvJO6YAVow4c1AbPXSb+sfryCiH6zIuJ08tJ4oYWfBO
 V7QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrZps1r4VFFW4MnCvkHq1IjBeZ4liy5ous70ENe6qCYFL53ikIm0gTFGW6tNo+NL9NGzCs4KQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyBDu52wuTDZlP7ToAwGSONP+LnNcmAMtJqrHz9iKeDGYEUeZjH
 tn4yrRNOJuhTxu5widD7Gt5iTPSNOneC6IiCEf+qwnYRdli9Rtn2vM1YXl5+DiR2eRD53pVaJNp
 8Pvxxc5ak0AXP1K6nVZM1LAntXICIoMgn7WW1Jfohx8t99I1tLiKnLBYgpBOsDOMbrJgzrSzmDX
 9oLMsdZcsmwbB1AV255WOfBTEnkyNkMgVvNbBAi4Af5g==
X-Gm-Gg: ASbGncuW68TfJ+aZOPtxkZEMx+mijXurtT548ZqeAn5niMzR6eEPbEanJU938DtHcp/
 fhrQ/jUj2bJb6pSzHTNYrUSMgxLzl441aBwvvJSNwQtyKcsD2nz6Iu9yHVKWV+by2Qq68zw==
X-Received: by 2002:a17:90b:280b:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-30a7bb487ddmr1046666a91.15.1746474724433; 
 Mon, 05 May 2025 12:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvJLDjo5nNEWOco2sQY48xjEfOQSjFwzjYDsvmcU56IIjepOqJskTUSwR7P4+XNujUaGoI9sa9C560dvXeW9A=
X-Received: by 2002:a17:90b:280b:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-30a7bb487ddmr1046634a91.15.1746474723984; Mon, 05 May 2025
 12:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 5 May 2025 21:51:52 +0200
X-Gm-Features: ATxdqUF0rsZCaF00_b41-ZNmw6hETFJPwROovtfanmh-rXgWNYo0iagAo6Af0cQ
Message-ID: <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025, 21:03:

> > Date: Fri, 2 May 2025 18:08:56 +0200
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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
> >
> > The check for the BootOrder variable introduced in commit f2bfa0cb1794
> > is a bug.
>
> Well, at the time the boot manager did not attempt to boot the default
> path.  So there was no point in running the boot manager code unless
> BootOrder (or BootNext) was set.  And of course before that commit the
> boot manager didn't run at all on non-sandbox builds that had the
> standard boot stuff enebaled.
>
> Anyway, I believe the thinking behind that commit is still sound.  As
> I explained earlier, I think that...
>
> > The boot manager handles in sequence:
> >
> > * Try to boot as indicated by BootNext.
> > * Try to boot as indicated by BootOrder.
> > * Try to boot default path for available media.
> >    This will add Boot#### entries and update BootOrder.
>
> ...doing this all in a monolithic sequence isn't the best way to
> handle EFI boot in the u-boot ecosystem.
>
> Your series moves the boot manager further down the list because the
> third step in the sequence has to happen late.  But as a result
> BootNext and BootOrder processing will also happen late.  So what
> happens if you have a board with two OS installations:
>
> 1. A generic Linux distro that boots via EFI.
>
> 2. Something like Armbian that provides an extlinux.conf file.
>
> Currently such a system will probably boot OS #1.  But after your
>

This did not happen with distoboot. So migration from distroboot to
standard boot results in a change that you want to avoid.

changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
> BootNext that will not change anything.
>
> So I think we need a solution where BootNext and BootOrder processing
> happens early, like we do now.
>

As of today BootNext does not invoke the boot manager.

If BootOrder is set the boot manager may fail because not all devices are
detected as "hunters" have not been running. E.g. nvme scan and usb start
are only invoked after the EFI boot manager.

I originally suggested to probe all boot devices before the boot manager
runs, but users complained that this slows down their non-EFI boot flows.
This is why I now move it after all boot methods but PXE.

Best regards

Heinrich
