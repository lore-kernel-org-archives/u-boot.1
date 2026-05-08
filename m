Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51CECD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C95C84BDC;
	Fri,  8 May 2026 12:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="H3y0qeFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C725784C19; Fri,  8 May 2026 12:18:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5867784A66
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 058741BCA;
 Fri,  8 May 2026 03:18:27 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805A23F763;
 Fri,  8 May 2026 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778235512; bh=2HlNUe5uiUOGmPJMhYk28AacQboyjN3j+eKMUsTM8/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H3y0qeFCNFf6d9zHwyO7MhaaeS9K5n5NE3jSJjE+5hpAFcsWBaiTwguxv8dGnRtMm
 cTncFeyzuAnUzUa4kLqLCWyyHX1w9DzdGaN49Xf0A197pLBrOX7fuMLQrgP9/PkKDL
 ysrz3ROHOeFlRlm0ERywqgqOacGWF60A1ztyDBIY=
Date: Fri, 8 May 2026 11:18:21 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Simon Glass <sjg@chromium.org>, harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com
Subject: Re: [PATCH 02/12] arm-ffa: add FF-A bus runtime support
Message-ID: <af24bWF2NjwQlUer@e130802.arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-3-harsimransingh.tungal@arm.com>
 <CAFLszTiBGiJHiw+mv3y=pr+csA3AQoQ_HOG5-R+ZrPXxbPJL4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTiBGiJHiw+mv3y=pr+csA3AQoQ_HOG5-R+ZrPXxbPJL4w@mail.gmail.com>
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

Hi Harsimran,

> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > arm-ffa: add FF-A bus runtime support
> >
> > Enable FF-A runtime transport for EFI services
> >
> > This patch introduces the FF-A runtime infrastructure that enables
> > U-Boot to use the Arm Firmware Framework for Arm A-profile (FF-A)
> > transport layer after ExitBootServices().
> > The runtime transport provides persistent, runtime-safe
> > implementations of key FF-A functions used by EFI runtime services.
> >
> > Summary of key changes:
> > -----------------------
> >   - Add drivers/firmware/arm-ffa/arm-ffa-runtime.c implementing FF-A
> >     runtime operations.
> >   - Introduce include/arm_ffa_runtime.h exporting FF-A runtime
> >     functions and data structures.
> >   - Move FF-A error mapping into runtime context.
> >   - Introduce invoke_ffa_fn_runtime() as runtime safe SMC wrapper.
> >   - Add runtime SMC wrapper for sandbox emulation.
> >   - Add ARM_FFA_RT_MODE Kconfig to enable runtime support.
> > [...]
> >
> > drivers/firmware/arm-ffa/Kconfig           |  11 ++
> >  drivers/firmware/arm-ffa/Makefile          |   4 +-
> >  drivers/firmware/arm-ffa/arm-ffa-runtime.c | 287 +++++++++++++++++++++++++++++
> >  drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 111 ++---------
> >  drivers/firmware/arm-ffa/arm-ffa.c         |  16 +-
> >  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  12 ++
> >  include/arm_ffa.h                          |  16 +-
> >  include/arm_ffa_priv.h                     |  24 ++-
> >  include/arm_ffa_runtime.h                  | 183 ++++++++++++++++++
> >  test/dm/ffa.c                              |   6 +-
> >  10 files changed, 551 insertions(+), 119 deletions(-)
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,287 @@
> > +     if (priv)
> > +             ffa_copy_runtime_priv(&priv->rt);
> > +     else
> > +             log_err("FF-A: Entering RT mode without FF-A runtime data information\n");
> > +
> > +     ffa_enable_runtime_context();
> 
> This enables the runtime context unconditionally, even after logging
> the priv data is missing. The runtime then comes up with id == 0 and
> fwk_version == 0 and any later FF-A call silently uses bogus values.
> Please return after the log_err() so ffa_get_status_runtime_context()
> keeps returning false on the failure path.
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,287 @@
> > +#include <arm_ffa_runtime.h>
> > +#include <arm_ffa_priv.h>
> > +#include <log.h>
> > +#include <asm/global_data.h>
> > +#include <linux/errno.h>
> > +#include <linux/types.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> 
> gd doesn't seem to be referenced in this file?
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,287 @@
> > + * after the FF-A bus device has successfully probed and U-Boot’s FF-A
> 
> This (and the same line in arm_ffa_runtime.h) should use a normal '
> instead of the UTF-8 right single quotation mark.
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,287 @@
> > +#if CONFIG_IS_ENABLED(ARM_FFA_RT_MODE)
> > +static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *event,
> > +                                                 void *context)
> 
> CONFIG_IS_ENABLED() is only meaningful for symbols with an SPL twin.
> ARM_FFA_RT_MODE has none, and the uclass side already uses
> IS_ENABLED(CONFIG_ARM_FFA_RT_MODE) - please use IS_ENABLED() here and
> in arm_ffa_runtime.h.
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,287 @@
> > +     if (is_smc64) {
> > +             req_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
> > +     } else {
> > +             req_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
> > +     }
> 
> Single-statement bodies should not be braced. Please run patman or
> checkpatch.pl on your patches. Also, the two efi_memset_runtime()
> calls below clear fresh stack variables. Please initialise them at
> declaration ('ffa_value_t ffa_args_rt = {}') and drop the explicit
> memset()s; the compiler's zero-init is just as runtime-safe and is
> what the boot path already does.
> 
> Also could you run checkpatch / patman over your patches for v2?
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > @@ -1047,6 +961,11 @@ static int ffa_do_probe(struct udevice *dev)
> > +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +             ret = ffa_setup_efi_exit_boot_services_event(uc_priv);
> > +             if (ret)
> > +                     return ret;
> > +     }
> 
> If event creation fails here, the RX/TX buffers mapped above and the
> partition cache are leaked, i,e. the existing failure path for
> ffa_cache_partitions_info() at least calls
> ffa_unmap_rxtx_buffers_hdlr(). Please follow the same pattern, or move
> event registration before resource allocation.
> 
> > diff --git a/drivers/firmware/arm-ffa/Kconfig b/drivers/firmware/arm-ffa/Kconfig
> > @@ -41,3 +44,11 @@ config ARM_FFA_TRANSPORT
> > +config ARM_FFA_RT_MODE
> > +     bool "Enable FF-A runtime support"
> > +     depends on ARM_FFA_TRANSPORT && EFI_LOADER
> > +     default y
> 
> Just to check, does every existing FF-A user want this on? 'default y'
> silently enables a new transport path (and the ExitBootServices
> callback) for everyone with ARM_FFA_TRANSPORT && EFI_LOADER. I'd
> suggest defaulting, or at minimum 'default y if CORSTONE1000' or
> similar, until other boards have opted in.
> 
> > diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
> > @@ -212,9 +227,8 @@ struct ffa_partitions {
> > -     u32 fwk_version;
> > +     struct ffa_priv_runtime rt;
> >       struct udevice *emul;
> > -     u16 id;
> 
> Just to clarify the model: 'struct ffa_priv' now embeds 'struct
> ffa_priv_runtime rt' at boot, and at ExitBootServices we copy the
> whole sub-struct (including 'use_ffa_runtime', always false here) into
> the resident 'ffa_priv_rt', then immediately overwrite use_ffa_runtime
> via ffa_enable_runtime_context(). Layering would be clearer if
> 'use_ffa_runtime' lived only on the resident copy and ffa_priv_runtime
> carried just the data shipped across the boundary (fwk_version, id).
> 
> Regards,
> Simon

Simon’s comments make sense to me. Please address them.

Aside from that, everything looks good in this commit.

Regards,
Abdellatif
