Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5930ECD37AC
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF7F84BDC;
	Fri,  8 May 2026 12:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YRfnqE+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C49C84C45; Fri,  8 May 2026 12:24:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0D16B84A66
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8AE1BCA;
 Fri,  8 May 2026 03:23:57 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D153F763;
 Fri,  8 May 2026 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778235842; bh=DuCyh2LHQHuYFabsZ1Ud/ilQw+BZS+VsS7TNH+9GJCw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YRfnqE+gbOttjuGveDiX3kEeLCy5oZ9rHG0G5WRaU4F0/TKaL7nCcA9Lb5ZkNeDp5
 TnTk5Ubb6Ufe01n4otuSsVfKsSkkexr3dUBd4v1KM6S3ZDPocNsjXhIqAw9VZkk4JA
 K2v5M/XHDNCMv0r4Gc/tkDxSNmtysMqoJHl+c/4Y=
Date: Fri, 8 May 2026 11:23:52 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org
Subject: Re: [PATCH 03/12] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
Message-ID: <af25uGoE7BBQpGhj@e130802.arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-4-harsimransingh.tungal@arm.com>
 <CAC_iWj+TMCCMkRmAV3x2gh0LoxBt3pvkJgnojq48fCkJBFro+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+TMCCMkRmAV3x2gh0LoxBt3pvkJgnojq48fCkJBFro+w@mail.gmail.com>
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

> On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Enable MM variable services over FF-A after ExitBootServices
> >
> > This patch extends lib/efi_loader/efi_variable_tee.c to support FF-A
> > communication with the secure world during EFI runtime. It enables EFI
> > runtime variable access and MM communication using FF-A transport when
> > ExitBootServices() has already been called.
> >
> > Key changes:
> >  ------------
> >   - Introduce runtime-safe implementations for MM communication,
> >     notification, and variable access using FF-A driver.
> >   - Introduce communication-buffer helper (get_comm_buf()) that switches
> >     between dynamic allocation (boot phase) and the fixed FF-A shared
> >     buffer (runtime phase).
> >   - Mark persistent data and code with __efi_runtime and
> >     __efi_runtime_data attributes.
> >   - Use direct physical address mapping for shared buffers since
> >     U-Boot operates with 1:1 physical-to-virtual mapping.
> >   - Only per-buffer cache maintenance is performed at runtime,
> >     as whole D-cache invalidation would violate the OS coherency model
> >     after ExitBootServices().
> >   - Add runtime-phase tracking (efi_runtime_enabled).
> 
> Why is this needed? For the memory allocations?
> 
> [...]
> 
> >   *
> >   *  Authors:
> >   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > @@ -14,6 +14,7 @@
> >
> >  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> >  #include <arm_ffa.h>
> > +#include <arm_ffa_runtime.h>
> >  #endif
> >  #include <cpu_func.h>
> >  #include <dm.h>
> > @@ -34,20 +35,47 @@
> >  #define MM_DENIED (-3)
> >  #define MM_NO_MEMORY (-5)
> >
> > +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> > +       [-MM_NOT_SUPPORTED]      = -EINVAL,
> > +       [-MM_INVALID_PARAMETER]  = -EPERM,
> > +       [-MM_DENIED]             = -EACCES,
> > +       [-MM_NO_MEMORY]          = -EBUSY,
> > +};
> > +
> 
> These are already defined above and used in ffa_notify_mm_sp(). If you
> plan to convert them, do it for the entire file.
> 
> [...]
> 
> > +/**
> > + * efi_is_runtime_enabled() - Indicate whether the system is in the UEFI runtime phase
> > + *
> > + * This helper returns whether the firmware has transitioned into the
> > + * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
> > + *
> > + * Return:
> > + *   true  - The system is operating in UEFI runtime mode.
> > + *   false - The system is still in the boot services phase.
> > + */
> > +static bool __efi_runtime efi_is_runtime_enabled(void)
> > +{
> > +       return efi_runtime_enabled;
> > +}
> 
> Enabled is a bit confusing. efi_at_runtime() should be enough. The
> efi_tcg.c code calls this 'ebs_called'
> 
> > +
> >  /**
> >   * get_connection() - Retrieve OP-TEE session for a specific UUID.
> >   *
> > @@ -169,6 +197,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
> >  }
> >
> >  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> > +/**
> > + * ffa_map_sp_event_runtime() - Map MM SP response to errno (runtime-safe)
> > + * @sp_event_ret: MM SP return code from ffa_notify_mm_sp_runtime()
> > + *
> > + * Convert the MM SP return code into a standard U-Boot errno. This helper
> > + * is marked __efi_runtime to ensure it is safe to call after
> > + * ExitBootServices().
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + */
> > +static __efi_runtime int ffa_map_sp_event_runtime(int sp_event_ret)
> > +{
> > +       int idx = -sp_event_ret;
> > +
> > +       if (sp_event_ret == MM_SUCCESS)
> > +               return 0;
> > +       if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
> > +           mm_sp_errmap[idx])
> > +               return mm_sp_errmap[idx];
> > +       return -EACCES;
> > +}
> > +
> >  /**
> >   * ffa_notify_mm_sp() - Announce there is data in the shared buffer
> >   *
> > @@ -225,6 +275,35 @@ static int ffa_notify_mm_sp(void)
> >         return ret;
> >  }
> >
> > +/**
> > + * ffa_notify_mm_sp_runtime() - Runtime implementation of
> > + *                              ffa_notify_mm_sp()
> > + *
> > + * Notify the MM partition in the trusted world that
> > + * data is available in the shared buffer.
> > + * This is a blocking call during which trusted world has exclusive access
> > + * to the MM shared buffer.
> > + *
> > + * Return:
> > + *
> > + * 0 on success
> > + */
> > +static int __efi_runtime ffa_notify_mm_sp_runtime(void)
> > +{
> > +       struct ffa_send_direct_data msg = {0};
> > +       int ret;
> > +       int sp_event_ret;
> > +
> > +       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> > +
> > +       ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = ffa_map_sp_event_runtime(sp_event_ret);
> > +       return ret;
> > +}
> > +
> >  /**
> >   * ffa_discover_mm_sp_id() - Query the MM partition ID
> >   *
> > @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> >         return efi_ret;
> >  }
> >
> > +/**
> > + * ffa_mm_communicate_runtime() - Runtime implementation of ffa_mm_communicate()
> > + * @comm_buf:          locally allocated communication buffer used for rx/tx
> > + * @comm_buf_size:     communication buffer size
> > + *
> > + * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
> > + * that there is data to read from the shared buffer.
> > + * Communication with the MM SP is performed using FF-A transport.
> > + * On the event, MM SP can read the data from the buffer and
> > + * update the MM shared buffer with response data.
> > + * The response data is copied back to the communication buffer.
> > + *
> > + * Return:
> > + *
> > + * EFI status code
> > + */
> > +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> > +                                                            ulong comm_buf_size)
> > +{
> 
> There's a lot of code duplication between the boottime and runtime
> variants, but I don;t see why we need it. Can't we have a single
> function that works both boottime and runtime?

Ilias suggestion makes sense to me. Please address that.

Regards,
Abdellatif
