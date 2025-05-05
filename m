Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B680C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 19:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEA982161;
	Mon,  5 May 2025 21:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="PqbpO9u+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E883E82163; Mon,  5 May 2025 21:03:52 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923598215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 21:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e33a7c3c-29e3-11f0-b8e9-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e33a7c3c-29e3-11f0-b8e9-005056999439;
 Mon, 05 May 2025 21:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=gv95gN4DuJBdse6Net9WvEF1AdxRAEqxVPfDT4qHibg=;
 b=PqbpO9u+ezGwCQB2tysdIGnnWdUy+38SheuHTaaF/2uNi6v13aXQHxEfLod4vWpvb4ymk1iS7w1LM
 zGC+8AbGydYKzgUTLXDFOmPOypKjGngXuG28mUgSKItE0A7k/tQkI8Qq8ANZEnWoNwqKB9nlvgTh6C
 EXuZJyAPt7ng53ANDlsiPYJQl+e/oJsRHPb6Ss8+bBi5O+7RUaudqs9Cs36tdhxD3sMPDBSj+D6V9j
 k6tADiQcaRuZYpO4mH3SbqjTKXjeLq6NDHZguEd/sS7/XVWhQGhuRsQFXHQqZQHStM4xBIv24f8RID
 DSTF6mtagHDKciLnMurnvo2+hye8L5A==
X-KPN-MID: 33|kAjwguAGC9WMhCdcXmaKrSn7TIn8rkGD3z/ByyZQzRXFq0oBFn2+vG74evJk1dQ
 GsSbi57vpPKbBdS3DmlsIC1A+Ayj/V0B9JWpAqB1dwMc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vEkoseRVDIT2J2HfLWXLCnjBLRhnMIkOsfc0MVfEchkUAyf0SOxtoG35/iuyXug
 RWxJQXYCRX9HmKeyvbD1Y+g==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ad6e4581-29e3-11f0-97ee-00505699d6e5;
 Mon, 05 May 2025 21:03:49 +0200 (CEST)
Date: Mon, 05 May 2025 21:03:49 +0200
Message-Id: <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 tuomas.tynkkynen@iki.fi, patrick.rudolph@9elements.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de
In-Reply-To: <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com> (message
 from Heinrich Schuchardt on Fri, 2 May 2025 18:08:56 +0200)
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
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

> Date: Fri, 2 May 2025 18:08:56 +0200
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> On 5/2/25 16:49, Simon Glass wrote:
> > Hi Heinrich,
> > 
> > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The EFI boot manager bootmeth does not require variable BootOrder to be
> >> preexisting. It creates this variable.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> >>   1 file changed, 3 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> >> index 42b8863815e..1669cbed5bd 100644
> >> --- a/boot/bootmeth_efi_mgr.c
> >> +++ b/boot/bootmeth_efi_mgr.c
> >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> >>
> >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> >>   {
> >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> >> -       efi_status_t ret;
> >> -       efi_uintn_t size;
> >> -       u16 *bootorder;
> >> -
> >> -       if (priv->fake_dev) {
> >> -               bflow->state = BOOTFLOWST_READY;
> >> -               return 0;
> >> -       }
> >> +       int ret
> >>
> >>          ret = efi_init_obj_list();
> >>          if (ret)
> >>                  return log_msg_ret("init", ret);
> >>
> >> -       /* Enable this method if the "BootOrder" UEFI exists. */
> >> -       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> >> -                               &size);
> >> -       if (bootorder) {
> >> -               free(bootorder);
> >> -               bflow->state = BOOTFLOWST_READY;
> >> -               return 0;
> >> -       }
> >> +       bflow->state = BOOTFLOWST_READY;
> >>
> >> -       return -EINVAL;
> >> +       return 0;
> >>   }
> >>
> >>   static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
> >> --
> >> 2.48.1
> >>
> > 
> > How do we know if the board is using EFI bootmgr? My understanding was
> > that this was a way to find out?
> 
> The boot manager must always run.
> 
> The check for the BootOrder variable introduced in commit f2bfa0cb1794 
> is a bug.

Well, at the time the boot manager did not attempt to boot the default
path.  So there was no point in running the boot manager code unless
BootOrder (or BootNext) was set.  And of course before that commit the
boot manager didn't run at all on non-sandbox builds that had the
standard boot stuff enebaled.

Anyway, I believe the thinking behind that commit is still sound.  As
I explained earlier, I think that...

> The boot manager handles in sequence:
> 
> * Try to boot as indicated by BootNext.
> * Try to boot as indicated by BootOrder.
> * Try to boot default path for available media.
>    This will add Boot#### entries and update BootOrder.

...doing this all in a monolithic sequence isn't the best way to
handle EFI boot in the u-boot ecosystem.

Your series moves the boot manager further down the list because the
third step in the sequence has to happen late.  But as a result
BootNext and BootOrder processing will also happen late.  So what
happens if you have a board with two OS installations:

1. A generic Linux distro that boots via EFI.

2. Something like Armbian that provides an extlinux.conf file.

Currently such a system will probably boot OS #1.  But after your
changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
BootNext that will not change anything.

So I think we need a solution where BootNext and BootOrder processing
happens early, like we do now.


> 
> Best regards
> 
> Heinrich
> 
