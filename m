Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D2F8DFE9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568FB83EEF;
	Fri, 17 Apr 2026 10:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8Teb50C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9401584214; Fri, 17 Apr 2026 10:41:57 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE3B83B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651b4d09141so662400d50.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776415314; cv=none;
 d=google.com; s=arc-20240605;
 b=LKlHrav4gAgtJs0MbXZHtPPlwqIxOgZDNFT1CXQXF9JLj1FFPnjYsSrLdij7RVghAF
 fr4+KWdCw22Awrh/C0sudW8WTpoQkLHT87zF9d71aJ6DDNh3Mg3oGhuVf3QZjDzyRcKu
 4xwKHxua/6wQdE/VECn1ZCHhUroAZwFbjNfmixnjJcTN4xXH5Pfbo6FrWOEtkjpW273r
 T2DiGwbrBmO5LWdHYubZfV6TbBfgdsfqjxJl2rXdFhQIyOuIDHXkganJ+uBR87pgHDc9
 pgfUH0M8QKDQ9PlF9vdTrmWPo/srwac5t0G+THJz5j6QQa41p7clbLk9LrpDqtYDD/s8
 t4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gnw/n1QleqCuYQTkpqGqVsrzPlsdqjrQYbeeUscLrbE=;
 fh=VYMhwsKdAQQ2hTCPvnZFflohSyFHwDIIUqKJEcPNysk=;
 b=IbZGpkEjsnfX+b8x3YdNaUxJ9Gta/zKlKCtYFaj1R/7FO41VvyFooRQw8ki93ooH5o
 GcrTwEalXsO/1+cvfsDXbHE5G8tvURhHBO9LXMwPmxjeLK09P5AOc1wpdtSt5sRicWQd
 AwqkEcg50wn8LfqhZZCeimAJohvHBgNODndty1cpJiixT/FjB5AWRIe+C4cN4Aa59pB5
 Hh5JmBThmhpizSz0SiHOsflMIO2tw5I4PcHpmK1JxSemBbvLJy+bV80oQoP0Xswz0mq0
 GVzG93ofG+UIgKTn19VViGLdq0+5dRXJgqRNhpbxATe0RRsmkiZGEaQmTgWcmKJN7hi0
 zbBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776415314; x=1777020114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gnw/n1QleqCuYQTkpqGqVsrzPlsdqjrQYbeeUscLrbE=;
 b=w8Teb50C22tuWG3p7iar8IyQ47aI0EHNHVIFUJQcDLr5aHiyDtT57v4/3At/FHUihj
 3bQ5+lDPL76kDVcJux/LB7UBlfZy7jrxxXk9MjVUwSX4rmzigBZIv9ZH4ZDq3GnnD+2Q
 cs2nKJcWNz7KiroGn5Om++w2C7SCJivxdB6Ig1SSW3G2acp59da5RNXKTjB97rBR50pY
 6Oy29+iKwuPtZycVnDFMxGRacHqYvWnMw3cEfJyjxeowJNoSAbyVRTxRH9Jut1tBXoLu
 vHSnJ1YSY+klEnUwXvGjTfQvbbmbStoS0bpMt52Op7Rr5DrV9tN//fcN4ctQHXV6gBK6
 UCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776415314; x=1777020114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnw/n1QleqCuYQTkpqGqVsrzPlsdqjrQYbeeUscLrbE=;
 b=lK87JDCludkq7QOrKUwXj4c+jY+ThSXyZJbOBoyM3KPpAKy/MNIn1cUQ4mC4X0yfPm
 Bo1V2zyzCn18pNJu+hqzvCz6Tacx2PBzL6xfTiD7h8EnlyaCNLNqixPG+eeVapW+LJjq
 30wrgdjQUiPLxpoQ958vqDPQLSBCU9S/xDbGyFojDOWflHr4xh8MIyNa7xooFxABoh1q
 H4ScYk0A559dP8YKWNruGDmCCdNJUKiHQmBAJUNwIlOjTgk79dmi8zRwoPECtDAJLQ7M
 fqJvG8AekGcFpUTfVLqKCQCPiyTjvr4Nrpq4Hja56Ltee/1aYZnM76HqnN6M5pJUXUfP
 rWXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MjMNyD8hSwsKYzzekMaWxaerRLRJhD560c6IUj5JqceueXCjrIpgLwXN1XD5V+BRn0M+pFlE=@lists.denx.de
X-Gm-Message-State: AOJu0YxPHwgaMPGrS4w5n4YXKh+UN2wCUB7bBEe51QQPHer3CciUiK8S
 NgEZiKNC2UbrBnQ9/ka7UCi//t9r2j7e9glDI/shjXcqM1Ne1TMGP1FZ7TequzbgYp90E0c5nYx
 AsjLDhwb/4MVfqZNJFQq/gAXxW/BRyZoEoG8Wk5trNA==
X-Gm-Gg: AeBDies2MKNHWUhK533OOTArC/WQTiq+GIALZvecYdi0LGJMHcN151DZDBRJUB8JXxZ
 4ESyBATtW2WE8JMMIvlzEyg99Qetpwj/zcJUKxzNNkfq0BVIf+XgxirO3r9eXif2se2cQIpeD8g
 FxMhRn/2oAPdAeErALMNxBS2+Cl9Hcojt0LG25DP7CDmZE6lS/Q6koBrPZi6lD40ahK38cta+9K
 PLuSXC36g0CiexUGHFEpK+Jp2j12YXsREjayqsrEF+xoxpIUfF7cLZRcjdXj5G+WuM263tvopE1
 oQaDvqIQMK7L3jOPa159HCBzxlXLebpz41xzi+rwkl9IRBm81NxN7irlpcvM9J7iwBQ7sHSXeGn
 4JkgEnO+YFF20V/5FePcNey6pEs9JQWFDo6nhCKnjunh0WAxB03+u1xut6KZ9Wm/m6VSKVUFVXt
 wsW3BTmQEpFkNwoSGkneD0LNegxNJma1QQuptSEt2RoL+nBTZqRg3XnY+ojVo/rltA3rXsY/ChK
 h4yNfb8t3wJKeejUR2ERBlLBK0snKfYusbL6xtq//WO/bkj9ClE2SKbxPkxX4NE2aDTUoABNpxD
 ijqaK8J1XgG1oC5AGtTRtRdxmbTccCNL20FwuB73w2Tk2TkstEb/gwI=
X-Received: by 2002:a05:690e:480c:b0:651:b61a:4b5f with SMTP id
 956f58d0204a3-65311989a3amr711436d50.17.1776415313569; Fri, 17 Apr 2026
 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260331191853.44549-1-gary@garyguo.net>
 <76933f99-d73a-43e2-be5e-0b765e8679b2@gmx.de>
In-Reply-To: <76933f99-d73a-43e2-be5e-0b765e8679b2@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Apr 2026 11:41:17 +0300
X-Gm-Features: AQROBzBjYeONew93s6dGM3z0QXt0qjTbGy98d3pzsQDbvsgO7ip5Xn3HFVShTPQ
Message-ID: <CAC_iWjK2KtL=Gdx-sMb8EPa_VuZsGJ2pyrmdGGkVkjz7TkQinw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: Gary Guo <gary@garyguo.net>, u-boot@lists.denx.de, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Martyn Welch <martyn.welch@collabora.com>
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

Hi Heinrich

On Fri, 17 Apr 2026 at 08:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/31/26 21:18, Gary Guo wrote:
> > EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> > indicating that the OS (or next stage bootloader) requests booting into
> > firmware UI instead of continuing autoboot process.
> >
> > Support it by having autoboot.c asking EFI bootmgr if boot should continue,
> > which checks and clear the bit (so the next boot continue as normal).
> >
> > With this change, systemd-boot will show a "Reboot Into Firmware Interface"
> > option which will be able to drop back to u-boot. This can be useful if
> > bootdelay is configured to be -2.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >   common/autoboot.c            |  4 +++-
> >   include/efi_loader.h         |  2 ++
> >   lib/efi_loader/efi_bootmgr.c | 45 ++++++++++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_setup.c   |  4 ++++
> >   4 files changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/autoboot.c b/common/autoboot.c
> > index 1783ef92c94c..b889407612dc 100644
> > --- a/common/autoboot.c
> > +++ b/common/autoboot.c
> > @@ -11,6 +11,7 @@
> >   #include <cli.h>
> >   #include <command.h>
> >   #include <console.h>
> > +#include <efi_loader.h>
> >   #include <env.h>
> >   #include <errno.h>
> >   #include <fdtdec.h>
> > @@ -503,7 +504,8 @@ void autoboot_command(const char *s)
> >   {
> >       debug("### main_loop: bootcmd=\"%s\"\n", s ? s : "<UNDEFINED>");
> >
> > -     if (s && (stored_bootdelay == -2 ||
> > +     if (s && !(IS_ENABLED(CONFIG_EFI_BOOTMGR) && efi_should_abort_autoboot()) &&
>
> I do not understand why the logic should depend on CONFIG_EFI_BOOTMGR
> instead of CONFIG_EFI_LOADER. It seems applicable whenever we support UEFI.

That's a good point, but we install some protocols that are useful for
booting distros only when we boot via the bootmgr e.g the load_initrd
stuff. OTOH grub, systemd etc install their own version of the protocl
nowadays so I don't mind if we allow it in the generic case as well.


>
>
> > +         (stored_bootdelay == -2 ||
> >                (stored_bootdelay != -1 && !abortboot(stored_bootdelay)))) {
> >               bool lock;
> >               int prev;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 3e70ac070550..449697ad13b3 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -583,6 +583,8 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *buf,
> >   efi_status_t efi_bootmgr_update_media_device_boot_option(void);
> >   /* Delete selected boot option */
> >   efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> > +/* Check if autoboot should be aborted based on EFI vars */
> > +bool efi_should_abort_autoboot(void);
> >   /* Invoke EFI boot manager */
> >   efi_status_t efi_bootmgr_run(void *fdt);
> >   /* search the boot option index in BootOrder */
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a687f4d8e85c..39f255ac9de4 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -1290,6 +1290,51 @@ out:
> >       return ret;
> >   }
> >
> > +/**
> > + * efi_should_abort_autoboot() - check if autoboot should be aborted per EFI vars
>
> Please, mention the relevant flag.
>
> > + *
> > + * Return:   true if autoboot should abort
> > + */
> > +bool efi_should_abort_autoboot(void)
> > +{
> > +     efi_status_t ret;
> > +     u64 os_indications = 0x0;
> > +     efi_uintn_t size;
> > +     efi_status_t r;
> > +
> > +     /* Initialize EFI drivers */
> > +     ret = efi_init_obj_list();
>
> @Ilias:
>
> Essentially this ends up in always running  efi_init_obj_list() if we
> have UEFI enabled.
>
> Shouldn't we then replace all invocations of efi_init_obj_list() by a
> single call after preboot but before EVT_POST_PREBOOT?

I agree with you here and if we do that, your point above to depend on
EFI_LOADER instead of the bootmanager makes more sense.
Tom keeping in mind that more and more distros work out of the box
with U-Boot, can we bite the bullet and always init the subsystem
early now ?
If people don't plan to boot with EFI that can always disable the EFI_LOADER.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> > +     if (ret != EFI_SUCCESS) {
> > +             log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +                     ret & ~EFI_ERROR_MASK);
> > +             return false;
> > +     }
> > +
> > +     size = sizeof(os_indications);
> > +     r = efi_get_variable_int(u"OsIndications", &efi_global_variable_guid,
> > +                              NULL, &size, &os_indications, NULL);
> > +     if (r != EFI_SUCCESS || size != sizeof(os_indications))
> > +             return false;
> > +
> > +     if (!(os_indications & EFI_OS_INDICATIONS_BOOT_TO_FW_UI))
> > +             return false;
> > +
> > +     /* Clear the BOOT_TO_FW_UI so next boot returns to normal */
> > +     os_indications &= ~EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> > +     r = efi_set_variable_int(u"OsIndications",
> > +                              &efi_global_variable_guid,
> > +                              EFI_VARIABLE_NON_VOLATILE |
> > +                              EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                              EFI_VARIABLE_RUNTIME_ACCESS,
> > +                              sizeof(os_indications),
> > +                              &os_indications, false);
> > +
> > +     if (r != EFI_SUCCESS)
> > +             log_err("Setting %ls failed\n", L"OsIndications");
> > +
> > +     return true;
> > +}
> > +
> >   /**
> >    * efi_bootmgr_run() - execute EFI boot manager
> >    * @fdt:    Flat device tree
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index f06cf49e4435..0ad02e9fe0dd 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -156,6 +156,10 @@ static efi_status_t efi_init_os_indications(void)
> >   {
> >       u64 os_indications_supported = 0;
> >
> > +     if (IS_ENABLED(CONFIG_EFI_BOOTMGR))
> > +             os_indications_supported |=
> > +                     EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> > +
> >       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> >               os_indications_supported |=
> >                       EFI_OS_INDICATIONS_CAPSULE_RESULT_VAR_SUPPORTED;
>
