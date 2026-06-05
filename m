Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2487ECD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EE684879;
	Fri,  5 Jun 2026 12:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BTyqkoAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8BC848D8; Fri,  5 Jun 2026 12:47:36 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC218486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 12:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66058b880e9so1945450d50.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780656452; cv=none;
 d=google.com; s=arc-20240605;
 b=fC4YvXbscJ2peHzQcEzyal/67A5A410I+0NnK41FU+cTQAlG5TBDAhInpvoVsDToVK
 yWFNRR3TGwRWlyp9bvQzuQYmtBaRJBelDgzoUBTYCrfUc9rg97MisOrmF5Qn3g1UbOXQ
 lX6TjcdaLFqoOrpiTgF5ekGIlXOikPWYKs0cVSjQwQ+D5asDTkyrzjlwgv9dPsnLfXWp
 Tha+LJfb0V5vNj7EqK7jyWg3khZKMM6RRQBoDN3BkSHc6VUys+s8dpXY3B3qq9ij61s8
 x9PE+uD9WG2jbtilK3YMELb+AbqfhEf7TS+Xcu8BhA5j1VkYW8QBMzJecnCTHwLcAv5I
 9F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=82ajTREMPK1RhKxr8z0U2Gi2i+AUjDDYK0X2FfzPOVg=;
 fh=4q5C7hKOtTOGKSQ7kUBmqlGmZOdIMJKEMMNq7T/PWfc=;
 b=CBEYBrLceNO5N00CZjq5MwPeFQ/LV9vwibkYBmDDu4Lei7cSqCALLq9rOVQ6qLITA/
 4dC/qNHzneqp2IJgAJC/XPD9Y9mXcbvD6TRTCHjiLQV8z0QgaDitzBtzInYBTZT8yfGX
 qVMiaELOWOqLe8KSpJIHHQYGKUnfoMuqQyvxDvk+S92qcIL+PbHNY45dmV1w08WAIP05
 lllyWQrNvkxFbQyIwjcWMNyeWLJzC9kyT7F0IdYyguaNlKLnI+vBaxuA2HnOcAX9oTep
 PW/RAZu0kD83pRhryapSzQA2DTR6z+pSXjZ5eNGWzCcXlEtYipp6CLxW/gp/F0NccGKi
 sgqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780656452; x=1781261252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=82ajTREMPK1RhKxr8z0U2Gi2i+AUjDDYK0X2FfzPOVg=;
 b=BTyqkoAX8kx3I7q5QlxKuyFV4ffNOfiVzfzGm6iPa6NXqMrniXukVGZECbMLNC3TFS
 /JvPkdkhK2RMqTn7fQXubQZ9ncQK/VfP5AKY77qgu+/CRlkN8tPauXdFC+i+oUUyy6C+
 omNsvrnBnFuy4C51rJTq8PABm6U5RSFtrdC9XN9sn+vOAy96MJ4u0Rgtwqp7O//wdM/9
 CSUw9rQiwJ4lgMXG8QbLU+vYwI+GWJTAIuMvCQwJBlRgyRmccXHuCmhyWcx9LfuSEfgw
 h9S/ymFAC7TMkWMii2GD9TVBdZI68iDnKXmcVt9g2GIMycUC7lDFJ60p/8Mvrp2BNVDy
 GeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780656452; x=1781261252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82ajTREMPK1RhKxr8z0U2Gi2i+AUjDDYK0X2FfzPOVg=;
 b=pAMtsmaTkEJMol3YPGlnzf6alr0CiNLPYtY7a86W5H7/82yNdbGt1iIDps39CLIGxp
 6y22dvJ981Ip4cIhhsfeyh7qbnNPJHKRFuwosZ/V4Uqlx2BdIttcq3g82pSdvRldLSxc
 DeO4dfAHqwIHyBipcRZ4felUdhrsnj6xxC5srKQfAeMYSI0ggdpZnuDgLTW360AglgGl
 DgaMjPeWuBtbkYWt83clOeZAG6AsaRMpFeIL4844NXICfnlmyQvEoIVpcOtQXwf60/1t
 HqEzqWjEYfCB9yae6Exr+dfDFaodQH/WH07b1FtjqgCw5X/paQ2WzsmbnKm6dbIYmEqZ
 8wtA==
X-Gm-Message-State: AOJu0YzaOM0gnSf8C62MoTZfMdDypHbwYWhSbTBhvHCrvL8yvXKKDPbJ
 /hu1FjzOY2CfxzyV4asBvab4mW3tmVMjqeOQ7aCNpPd455BNn05OpkF/D7xJhkKGuTwADbRjMz7
 5wh0qvcMnbco0sf8fmO+YpR0yTt6tuXAnWZ1MDyO14AXFW3ZEAScsE1rVdg==
X-Gm-Gg: Acq92OHWiSR5sXnAy3ClRBMkrwmWU865zMHBmWM6lHTaS0b5nDNbfor1AkLUDbwQcn4
 8r8m0+Gn3GoMcPwL0MdenCpMuc14Ey+AKhhjzpAHNZd2B33vsOBiJcLmNfbWHMWZx2QDWlUohGy
 6T/ln7/FpkNUltblcaoEcckL42QHjB1AbQ1eB3lgUlMVEweNYxhgBjACXLefR8kQEqy12rsXwg/
 mVQxwHaznt/oUWMhJ+6kEKIUYNQI7VYTrQ3S02dUsjahRKTnIRSize9Sg4gy3Epg/D0xQ1lcgG4
 6nylt++L6b9xipST9l4QWIdj7i23L2A2VRL93QNdcLwhUINjbHEvSlGsjAaj9m3dvpOpqpMzmHW
 ZedUGY6IpSTLNFoqKvUK66SwIdSG16Nn2/y/T2m1ESmNxttTY5OLeaDU6qAmMU+GkUxNVbQjqtI
 5SgDRSR2Qr3PXD8VgX6HSYPGdABnuWYZ4kc4rdHpcp3rwnU0McxSYenZo8MGhi6/+NZZY1M0a8n
 6KtB4Tuz1YM2zycpZ9XnnCxFzd6mc1bdqGBMb+s7KnRtq4VXvcGQk8jm6QwVSa6kc96Z3wT9RGA
 jxv6FzkUQ0mO8xiLfrUZdOpTL2KaHE3m28D9U1ZvQgoF0jqz5DPwcuzgCpjo7C8TJmqMHzKQV6n
 UYL8l+DI3iYiIk9mc
X-Received: by 2002:a53:ad88:0:b0:660:5c10:df05 with SMTP id
 956f58d0204a3-66107025a07mr1919691d50.42.1780656452326; Fri, 05 Jun 2026
 03:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Jun 2026 13:46:56 +0300
X-Gm-Features: AVHnY4JOubhLxWS_LYHc7f3TJZWCovfKVCksUo7u7PWZDiBo4TKB3w7MN1s3v5A
Message-ID: <CAC_iWjKtPCfiDEkT8H2KGuJE5dpNsS18dnyPdDgiiX0W-MoejA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 xypron.glpk@gmx.de, hugues.kambampiana@arm.com, sjg@chromium.org
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

Hi Harsiman

[...]

> +/**
> + * ffa_map_sp_event() - Map MM SP response to errno
> + * @sp_event_ret: MM SP return code from MM SP notification
> + *
> + * Convert the MM SP return code into a standard U-Boot errno. This helper
> + * is marked __efi_runtime so it can be shared by both the boot and runtime
> + * FF-A notification paths.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
> +{
> +       int idx = -sp_event_ret;
> +
> +       if (sp_event_ret == MM_SUCCESS)
> +               return 0;
> +       if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
> +           mm_sp_errmap[idx])
> +               return mm_sp_errmap[idx];
> +       return -EACCES;
> +}
> +
>  /**
>   * ffa_notify_mm_sp() - Announce there is data in the shared buffer
>   *
> @@ -177,52 +225,36 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
>   * This is a blocking call during which trusted world has exclusive access
>   * to the MM shared buffer.
>   *
> - * Return:
> - *
> - * 0 on success
> + * Return: 0 on success
>   */
> -static int ffa_notify_mm_sp(void)
> +static int __efi_runtime ffa_notify_mm_sp(void)
>  {
>         struct ffa_send_direct_data msg = {0};
>         int ret;
>         int sp_event_ret;
> -       struct udevice *dev;
> +       bool at_runtime = efi_at_runtime();
>
> -       ret = uclass_first_device_err(UCLASS_FFA, &dev);
> -       if (ret) {
> -               log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
> -               return ret;
> -       }
> +       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> +
> +       if (at_runtime) {
> +               ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> +       } else {
> +               struct udevice *dev;
>
> -       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET; /* x3 */
> +               ret = uclass_first_device_err(UCLASS_FFA, &dev);
> +               if (ret) {
> +                       log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");

This will crash at runtime, we don't have access to log_XXX.
Please go through the entire patchset and make sure you aren't calling
core functions that haven't been marked as such for v3
Thre functions that do make sense can be converted to __efit_runtime.
log_XXXX is not one of them though.

> +                       return ret;
> +               }
>
> -       ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
> +               ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
> +       }
>         if (ret)
>                 return ret;
>
> -       sp_event_ret = msg.data0; /* x3 */
> -
> -       switch (sp_event_ret) {
> -       case MM_SUCCESS:
> -               ret = 0;
> -               break;
> -       case MM_NOT_SUPPORTED:
> -               ret = -EINVAL;
> -               break;
> -       case MM_INVALID_PARAMETER:
> -               ret = -EPERM;
> -               break;
> -       case MM_DENIED:
> -               ret = -EACCES;
> -               break;
> -       case MM_NO_MEMORY:
> -               ret = -EBUSY;
> -               break;
> -       default:
> -               ret = -EACCES;
> -       }
> +       sp_event_ret = msg.data0;
>
> -       return ret;
> +       return ffa_map_sp_event(sp_event_ret);
>  }
>
>  /**
> @@ -266,36 +298,41 @@ static int ffa_discover_mm_sp_id(void)
>  }
>
>  /**
> - * ffa_mm_communicate() - Exchange EFI services data with  the MM partition using FF-A
> + * ffa_mm_communicate() - Exchange EFI services data with the MM partition using FF-A
>   * @comm_buf:          locally allocated communication buffer used for rx/tx
> - * @dsize:                             communication buffer size
> + * @comm_buf_size:     communication buffer size
>   *
>   * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
>   * that there is data to read from the shared buffer.
>   * Communication with the MM SP is performed using FF-A transport.
>   * On the event, MM SP can read the data from the buffer and
>   * update the MM shared buffer with response data.
> - * The response data is copied back to the communication buffer.
> - *
> - * Return:
> + * The response data is copied back to the communication buffer during the
> + * boot phase. At runtime, the communication buffer is already the FF-A
> + * shared buffer and is updated in place.
>   *
> - * EFI status code
> + * Return: EFI status code
>   */
> -static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> +static efi_status_t __efi_runtime ffa_mm_communicate(void *comm_buf,
> +                                                    ulong comm_buf_size)
>  {
>         ulong tx_data_size;
>         int ffa_ret;
>         efi_status_t efi_ret;
>         struct efi_mm_communicate_header *mm_hdr;
> -       void *virt_shared_buf;
> +       u8 *shared_buf;
> +       bool at_runtime = efi_at_runtime();
>
>         if (!comm_buf)
>                 return EFI_INVALID_PARAMETER;
>
> -       /* Discover MM partition ID at boot time */
> -       if (!mm_sp_id && ffa_discover_mm_sp_id()) {
> -               log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
> -               return EFI_UNSUPPORTED;
> +       if (!mm_sp_id) {
> +               if (at_runtime)
> +                       return EFI_UNSUPPORTED;
> +               if (ffa_discover_mm_sp_id()) {
> +                       log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
> +                       return EFI_UNSUPPORTED;
> +               }
>         }
>
>         mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> @@ -304,30 +341,61 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
>         if (comm_buf_size != tx_data_size || tx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
>                 return EFI_INVALID_PARAMETER;
>
> -       /* Copy the data to the shared buffer */
> -
> -       virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> -       memcpy(virt_shared_buf, comm_buf, tx_data_size);
> +       if (at_runtime) {
> +               shared_buf = comm_buf;
> +       } else {
> +               /* Copy the data to the shared buffer */
> +               shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> +               memcpy(shared_buf, comm_buf, tx_data_size);
> +       }

Does the shared_buf live in the same memory space for linux ? How is
that communicated to the OS?

[...]


Thanks
/Ilias
