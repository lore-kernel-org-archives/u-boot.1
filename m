Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61445CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2466846D3;
	Tue, 26 May 2026 14:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lii6qGa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F292846FA; Tue, 26 May 2026 11:16:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7DF2F846AC
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A719A169C;
 Tue, 26 May 2026 02:16:21 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.31.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3A83F7B4;
 Tue, 26 May 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779786986; bh=8Gnds1tOMzo1yDgTxwa4iDxoi74z5wwsUphp8DXEZ0Y=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=lii6qGa8BGuGBBPDWwpp6R1mU2IZKIscicDQeji0CRqoBaoxygSeNOW+FkjzKa1zk
 RRh3O4x+7qhJ5+Suewco1O2qdrUkFMmIfKPIUZjksdlx+JWwfBZOsujavSC29AADDh
 h4YN67dZ2tWZDbTgntrUSulbBM4hh4qf6+2yWkko=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 02/11] arm-ffa: add FF-A bus runtime support
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com
In-Reply-To: <CAFLszTiHPguTVCYGMqWWAj_efuzLTh7gGObi82Lky9dXvrbD3Q@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-3-harsimransingh.tungal@arm.com>
 <CAFLszTiHPguTVCYGMqWWAj_efuzLTh7gGObi82Lky9dXvrbD3Q@mail.gmail.com>
Date: Tue, 26 May 2026 10:16:19 +0100
Message-Id: <177978697985.2292270.14164539361652694046.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

On 2026-05-15 12:25 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-05-14T12:49:13, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > arm-ffa: add FF-A bus runtime support
> >
> > Enable FF-A runtime transport for EFI services
> >
> > Add the FF-A runtime infrastructure needed after ExitBootServices() so
> > EFI runtime services can continue to use the FF-A transport layer.
> > Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> > include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> > direct messaging, SMC invocation, and error translation. Add the
> > sandbox runtime SMC wrapper, the ARM_FFA_RT_MODE Kconfig option, and
> > the ExitBootServices hook that copies the required FF-A runtime data
> > into resident storage before enabling the runtime context.
> >
> > Tag the runtime code and data with __efi_runtime and
> > __efi_runtime_data so they remain available after
> > ExitBootServices().
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > ----
> > [...]
> >
> > drivers/firmware/arm-ffa/Kconfig           |  11 ++
> >  drivers/firmware/arm-ffa/Makefile          |   4 +-
> >  drivers/firmware/arm-ffa/arm-ffa-runtime.c | 295 +++++++++++++++++++++++++++++
> >  drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 113 ++---------
> >  drivers/firmware/arm-ffa/arm-ffa.c         |  16 +-
> >  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  12 ++
> >  include/arm_ffa.h                          |  16 +-
> >  include/arm_ffa_priv.h                     |  22 ++-
> >  include/arm_ffa_runtime.h                  | 191 +++++++++++++++++++
> >  test/dm/ffa.c                              |   6 +-
> >  10 files changed, 566 insertions(+), 120 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > @@ -1024,6 +937,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
> >  static int ffa_do_probe(struct udevice *dev)
> >  {
> >       int ret;
> > +     struct ffa_priv *uc_priv = dev_get_uclass_priv(dev);
> >
> >       ret = ffa_get_version_hdlr(dev);
> >       if (ret)
> > @@ -1033,6 +947,12 @@ static int ffa_do_probe(struct udevice *dev)
> >       if (ret)
> >               return ret;
> >
> > +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +             ret = ffa_setup_efi_exit_boot_services_event(uc_priv);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       ret = ffa_get_rxtx_map_features_hdlr(dev);
> 
> The event is installed before the rxtx-map and partition-cache steps.
> If any of those later steps fail, probe returns nonzero but the EBS
> event stays registered against this uc_priv. When ExitBootServices()
> fires the notifier still copies priv->rt and calls
> ffa_enable_runtime_context(), so runtime FF-A appears ready even
> though the bus never finished probing. Either install the event at the
> end of probe, or tear it down on the error paths.
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,295 @@
> > +#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
> > +static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *event,
> > +                                                 void *context)
> > +{
> > +     struct ffa_priv *priv = context;
> > +
> > +     if (priv) {
> > +             ffa_copy_runtime_priv(&priv->rt);
> > +     } else {
> > +             log_err("FF-A: runtime data missing, keeping RT mode disabled\n");
> > +             return;
> > +     }
> > +
> > +     ffa_enable_runtime_context();
> > +}
> 
> Please flip this around - the usual U-Boot thing is an early-return guard:
> 
>    if (!priv) {
>            log_err("FF-A: runtime data missing, keeping RT mode disabled\n");
>            return;
>    }
>    ffa_copy_runtime_priv(&priv->rt);
>    ffa_enable_runtime_context();
> 
> Also, since the context is set when we create the event, this is
> essentially can't happen - drop to log_warn() or an assert.
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,295 @@
> > +/* Error mapping declarations */
> > +
> > +int __ffa_runtime_data ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
> > +     [NOT_SUPPORTED] = -EOPNOTSUPP,
> 
> Only referenced inside ffa_to_std_errno() in this file — please make
> it static. Also this is a definition, not a declaration.
>

Hi Simon,

ffa_to_std_errmap is currently also used by ffa-emul-uclass.c, so this
cannot be made it static in arm-ffa-runtime.c without changing those users first.

Regards,
Harsimran Singh Tungal

> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > @@ -1046,7 +966,6 @@ static int ffa_do_probe(struct udevice *dev)
> >               ffa_unmap_rxtx_buffers_hdlr(dev);
> >               return ret;
> >       }
> > -
> >       return 0;
> >  }
> 
> Unrelated whitespace change - please drop (we normally have a blank
> line before the final return in a function).
> 
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > @@ -0,0 +1,295 @@
> > +bool __ffa_runtime ffa_get_status_runtime_context(void)
> > +{
> > +     return ffa_runtime_enabled;
> > +}
> 
> The name reads awkwardly - how about ffa_runtime_is_ready() or
> ffa_runtime_context_ready() ?. Same for ffa_enable_runtime_context() /
> ffa_reset_runtime_context() if you want to keep them parallel.
> 
> >     arm-ffa: add FF-A bus runtime support
> >
> >     Enable FF-A runtime transport for EFI services
> >
> >     Add the FF-A runtime infrastructure needed after ExitBootServices() so
> >     EFI runtime services can continue to use the FF-A transport layer.
> >     Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> >     include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> 
> Please use single quotes rather than backticks throughout the commit
> message if you need them at all, also for CONFIG_ARM_FFA_RT_MODE /
> efi_memset_runtime() later on. Filenames such as
> drivers/firmware/arm-ffa/arm-ffa-runtime.c don't need quoting at all.
> 
> Also, the single-line lede ('Enable FF-A runtime transport for EFI
> services') is redundant with the paragraph that follows - drop it and
> let the first paragraph carry the motivation.
> 
> Regards,
> Simon
> 


