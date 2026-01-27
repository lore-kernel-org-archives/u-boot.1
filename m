Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92533D2D8F1
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E16483FE9;
	Tue, 27 Jan 2026 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E45D983FED; Tue, 27 Jan 2026 11:38:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E96FF83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E9761595;
 Tue, 27 Jan 2026 02:37:53 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.128.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4213F73F;
 Tue, 27 Jan 2026 02:37:59 -0800 (PST)
Date: Tue, 27 Jan 2026 11:37:56 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH] efi_loader: fix use after free in efi_exit() with tcg2
Message-ID: <aXiVhGo-HfCwOyy4@debian>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
 <CAC_iWj+QPW+7-aJ7XMmzxoHwJ47kM51sZfWjp4T2cT+v7L0wDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWj+QPW+7-aJ7XMmzxoHwJ47kM51sZfWjp4T2cT+v7L0wDw@mail.gmail.com>
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

(Updated Kojima-san's e-mail address.)

On Tue, Jan 27, 2026 at 09:58:33AM +0200, Ilias Apalodimas wrote:
> Hi Vincent,

Hi Ilias,

Thank you for having a look!
My comments below.

> On Fri, 23 Jan 2026 at 14:58, Vincent Stehlé <vincent.stehle@arm.com> wrote:
> >
> > The efi_exit() function frees the loaded image memory by calling
> > efi_delete_image(). However, when CONFIG_EFI_TCG2_PROTOCOL is enabled, the
> > image_obj->image_type structure member is accessed after the memory has
> > been freed.
> >
> > Fix this by keeping a copy of image_type, as is already done for exit_jmp.
> >
> > Fixes: 8fc4e0b4273a ("efi_loader: add boot variable measurement")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >
> > Hi,
> >
> > This can be verified with sandbox_defconfig + CONFIG_VALGRIND=y and the
> > following command:
> >
> >   valgrind --suppressions=scripts/u-boot.supp \
> >     ./u-boot -T -c "setenv efi_selftest start image return; \
> >                     bootefi selftest"
> >
> > Best regards,
> > Vincent.
> >
> >  lib/efi_loader/efi_boottime.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index ddc935d2240..0b3f2fd276c 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -3453,6 +3453,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
> >         struct efi_loaded_image_obj *image_obj =
> >                 (struct efi_loaded_image_obj *)image_handle;
> >         jmp_buf *exit_jmp;
> > +       u16 image_type;
> >
> >         EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
> >                   exit_data_size, exit_data);
> > @@ -3496,13 +3497,14 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
> >         }
> >         /* efi_delete_image() frees image_obj. Copy before the call. */
> >         exit_jmp = image_obj->exit_jmp;
> > +       image_type = image_obj->image_type;
> >         *image_obj->exit_status = exit_status;
> > -       if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
> > +       if (image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
> >             exit_status != EFI_SUCCESS)
> >                 efi_delete_image(image_obj, loaded_image_protocol);
> >
> >         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> > -               if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
> > +               if (image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
> 
> This looks ok, but I don't remember the TCG spec on top of my head.
> Can't we just move the measurement before deleting the handle?

I think this can work indeed, and it is more elegant; I will send a v2, thanks!

If I read the specification[1] correctly, the measurements sequence in 8.2.4 is
the following:

  f. Execute UEFI application
     i. If additional loads
          measure
  g. Measure EV_EFI_ACTION "Returning ..."
  h. If select next
       goto a
  i. If ExitBootServices
       measure EV_EFI_ACTION "Exit Boot Services ..."

Everything efi_exit() is doing is happening in step "g", therefore moving code
around efi_delete_image() should have no effect on the measurements.

Best regards,
Vincent.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub.pdf

> 
> Thanks
> /Ilias
> >                         ret = efi_tcg2_measure_efi_app_exit();
> >                         if (ret != EFI_SUCCESS)
> >                                 log_debug("tcg2 measurement fails (0x%lx)\n",
> > --
> > 2.51.0
> >
