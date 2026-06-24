Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624BCDE002
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 13:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8DD84995;
	Wed, 24 Jun 2026 15:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rz1Uu45E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61735848DC; Wed, 24 Jun 2026 13:41:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 49A9B84671
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C213D15A1;
 Wed, 24 Jun 2026 04:41:10 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.29.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C62A13F632;
 Wed, 24 Jun 2026 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782301275; bh=gjWZoW8cfR/bhNr/LUUvu6NkvlqvaCwYdhuG5pyePoM=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=rz1Uu45EI8mlotfmpGwcuk/0/JaUKjoBgtEm64lEzF3imF7QtdaMukZ4cLv6ACFBA
 CIbiDdZHKT3XrcaqeWbadSylc6eii+n35ZDhPakaZb9a+QPdcBGmnUukV8FewfLFcO
 cT05VOqCYYz36p9+wJTeDiKPUQdn/C06zKwx6B+g=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/11] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 xypron.glpk@gmx.de, hugues.kambampiana@arm.com, sjg@chromium.org
In-Reply-To: <CAC_iWjKtPCfiDEkT8H2KGuJE5dpNsS18dnyPdDgiiX0W-MoejA@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
 <CAC_iWjKtPCfiDEkT8H2KGuJE5dpNsS18dnyPdDgiiX0W-MoejA@mail.gmail.com>
Date: Wed, 24 Jun 2026 12:41:08 +0100
Message-Id: <178230126816.4073031.10941263792926021769.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 24 Jun 2026 15:15:53 +0200
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

On 2026-06-05 13:46 +0300, Ilias Apalodimas wrote:
> Hi Harsiman
> 
> [...]
> 
> > +/**
> > + * ffa_map_sp_event() - Map MM SP response to errno
> > + * @sp_event_ret: MM SP return code from MM SP notification
> > + *
> > + * Convert the MM SP return code into a standard U-Boot errno. This helper
> > + * is marked __efi_runtime so it can be shared by both the boot and runtime
> > + * FF-A notification paths.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + */
> > +static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
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
> > @@ -177,52 +225,36 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
> >   * This is a blocking call during which trusted world has exclusive access
> >   * to the MM shared buffer.
> >   *
> > - * Return:
> > - *
> > - * 0 on success
> > + * Return: 0 on success
> >   */
> > -static int ffa_notify_mm_sp(void)
> > +static int __efi_runtime ffa_notify_mm_sp(void)
> >  {
> >         struct ffa_send_direct_data msg = {0};
> >         int ret;
> >         int sp_event_ret;
> > -       struct udevice *dev;
> > +       bool at_runtime = efi_at_runtime();
> >
> > -       ret = uclass_first_device_err(UCLASS_FFA, &dev);
> > -       if (ret) {
> > -               log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
> > -               return ret;
> > -       }
> > +       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> > +
> > +       if (at_runtime) {
> > +               ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> > +       } else {
> > +               struct udevice *dev;
> >
> > -       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET; /* x3 */
> > +               ret = uclass_first_device_err(UCLASS_FFA, &dev);
> > +               if (ret) {
> > +                       log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
> 
> This will crash at runtime, we don't have access to log_XXX.
> Please go through the entire patchset and make sure you aren't calling
> core functions that haven't been marked as such for v3
> Thre functions that do make sense can be converted to __efit_runtime.
> log_XXXX is not one of them though.
> 
> > +                       return ret;
> > +               }
> >
> > -       ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
> > +               ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
> > +       }
> >         if (ret)
> >                 return ret;
> >
> > -       sp_event_ret = msg.data0; /* x3 */
> > -
> > -       switch (sp_event_ret) {
> > -       case MM_SUCCESS:
> > -               ret = 0;
> > -               break;
> > -       case MM_NOT_SUPPORTED:
> > -               ret = -EINVAL;
> > -               break;
> > -       case MM_INVALID_PARAMETER:
> > -               ret = -EPERM;
> > -               break;
> > -       case MM_DENIED:
> > -               ret = -EACCES;
> > -               break;
> > -       case MM_NO_MEMORY:
> > -               ret = -EBUSY;
> > -               break;
> > -       default:
> > -               ret = -EACCES;
> > -       }
> > +       sp_event_ret = msg.data0;
> >
> > -       return ret;
> > +       return ffa_map_sp_event(sp_event_ret);
> >  }
> >
> >  /**
> > @@ -266,36 +298,41 @@ static int ffa_discover_mm_sp_id(void)
> >  }
> >
> >  /**
> > - * ffa_mm_communicate() - Exchange EFI services data with  the MM partition using FF-A
> > + * ffa_mm_communicate() - Exchange EFI services data with the MM partition using FF-A
> >   * @comm_buf:          locally allocated communication buffer used for rx/tx
> > - * @dsize:                             communication buffer size
> > + * @comm_buf_size:     communication buffer size
> >   *
> >   * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
> >   * that there is data to read from the shared buffer.
> >   * Communication with the MM SP is performed using FF-A transport.
> >   * On the event, MM SP can read the data from the buffer and
> >   * update the MM shared buffer with response data.
> > - * The response data is copied back to the communication buffer.
> > - *
> > - * Return:
> > + * The response data is copied back to the communication buffer during the
> > + * boot phase. At runtime, the communication buffer is already the FF-A
> > + * shared buffer and is updated in place.
> >   *
> > - * EFI status code
> > + * Return: EFI status code
> >   */
> > -static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> > +static efi_status_t __efi_runtime ffa_mm_communicate(void *comm_buf,
> > +                                                    ulong comm_buf_size)
> >  {
> >         ulong tx_data_size;
> >         int ffa_ret;
> >         efi_status_t efi_ret;
> >         struct efi_mm_communicate_header *mm_hdr;
> > -       void *virt_shared_buf;
> > +       u8 *shared_buf;
> > +       bool at_runtime = efi_at_runtime();
> >
> >         if (!comm_buf)
> >                 return EFI_INVALID_PARAMETER;
> >
> > -       /* Discover MM partition ID at boot time */
> > -       if (!mm_sp_id && ffa_discover_mm_sp_id()) {
> > -               log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
> > -               return EFI_UNSUPPORTED;
> > +       if (!mm_sp_id) {
> > +               if (at_runtime)
> > +                       return EFI_UNSUPPORTED;
> > +               if (ffa_discover_mm_sp_id()) {
> > +                       log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
> > +                       return EFI_UNSUPPORTED;
> > +               }
> >         }
> >
> >         mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> > @@ -304,30 +341,61 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> >         if (comm_buf_size != tx_data_size || tx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
> >                 return EFI_INVALID_PARAMETER;
> >
> > -       /* Copy the data to the shared buffer */
> > -
> > -       virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> > -       memcpy(virt_shared_buf, comm_buf, tx_data_size);
> > +       if (at_runtime) {
> > +               shared_buf = comm_buf;
> > +       } else {
> > +               /* Copy the data to the shared buffer */
> > +               shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> > +               memcpy(shared_buf, comm_buf, tx_data_size);
> > +       }
> 
> Does the shared_buf live in the same memory space for linux ? How is
> that communicated to the OS?
>

Hi Ilias,
Yes, the FF-A shared buffer is added to the EFI
memory map as EFI_RUNTIME_SERVICES_DATA, so the OS sees it as runtime
memory. In v3, we will register an EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE callback
and convert ffa_shared_buf with efi_convert_pointer(), so if the OS calls
SetVirtualAddressMap(), runtime variable calls use the converted virtual
address instead of relying on identity mapping. This will be handles in
v3 patchset.

Regards
Harsimran Singh Tungal

> [...]
> 
> 
> Thanks
> /Ilias
> 


