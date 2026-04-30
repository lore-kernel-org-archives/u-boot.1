Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8478EFF887E
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 00:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9784884924;
	Thu, 30 Apr 2026 02:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fc2b7/Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8567C848FD; Thu, 30 Apr 2026 02:00:38 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3E3848FD
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 02:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so33627366b.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507236; cv=none;
 d=google.com; s=arc-20240605;
 b=Rf8zj7qQ6iQs8hVh+GAAzH2E+Loowx47op6hKlP0JJQWl2+T8gI7Z53hSpwHqKjq5a
 OzFRvXFOKzjiwZxE9gHy07D3qUwVEiUW3ju1k1RH9HM/h5Z6A/mp66Id2jK3DgEH7+Ko
 y8syCEuNLF2zbQfkGbnawuNtMQCbhILuULlL2OwmNyURz5qsTE2MNCaue/aMNlbyqapp
 2xIvhCxpG4mnBO5lPmj8dozy/Crcu7aYw4SCb7DQRds12fyqmU1Mbn6nG//HwL6MVkGB
 3bjDVzlbehXZ34vkcOudWvm3fWlOB+LueqI/qvIckk/GG4I8+SUXw9KeNPZ7bLZk8ODD
 nGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zCKTXZxFXj+nJqOhH6o1i3WbRcZ2Pb+BJ+JGSQcfuJY=;
 fh=pa6Kd4uSmLweEFdENia2bCYf6/LV+ehPOHxWvcn8Sms=;
 b=LaYjbljN2Zk9cuMeRly4FhRyERayu2dyQ1xN2h/OwLvLNJzLX8BOZDoSSzA+ZQIA84
 kIAj/NjY7Lx9MClXmwzTX8GFzRA9UBetIlzGds+Gcf0ZIQ2LS/03YQJW9xPmxputcPiP
 9hlJaAiE+8eFdQZ2zYDmnW4LnpiL6TxpdIY0BtmTtSF6xrKHnIG8FnjiVukmkD73Kqvi
 Sxjr11Z1yui0tZ/riaZN8I1fGCErZ4Q+hxpCJQxJzvuMZ4lZqQpIeV0T+ytPoY6ur8pD
 bpb/GCaREmMDohohLLP69EwrU4xL3QRWeixdYLg2/OuPzJOZ5wbG+oHCassPYremvk81
 iy9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777507236; x=1778112036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zCKTXZxFXj+nJqOhH6o1i3WbRcZ2Pb+BJ+JGSQcfuJY=;
 b=Fc2b7/BsQ8WXb1w6VIFItv8JL2L4Q4wJPO+XV5hAComyu3mNQ4jmkF87NiZDDcM57E
 UkUMMLZF0G3DxBW1eAipZe7/n647Z0E2Un7QTMPPLYYncnniHwJkzDlM3n0ij76bCOi4
 8iL7K697FAcMxJAAQOd/9YYFaRK8kq41y4T3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507236; x=1778112036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCKTXZxFXj+nJqOhH6o1i3WbRcZ2Pb+BJ+JGSQcfuJY=;
 b=pK4Q3PamNTmW/KTOjMeyYlaT0qyorT4kHLzoSyjYa60Tunr9k16R3QYByXZ2Qdf3oW
 lIsTyUymSMq3Du25CpUuVtPeSUj35R9kdNfheJSjaSy8T23tHFDAgq6SNbUHeYrY76EP
 kE2O5OX5o2XAKxnj6EyW9tMsVhyvvZGDLro/bzcXpQbQ0V2wuJcjrtz9kJuaaE4J9mQO
 6sxb0zqODpHZqJ7yWYM/r4Vr8cy9+TvbDocqfuWikknXqrdpXJLjSlyZHfKA9i/Z1wY5
 VdVCI5gK7M7Vcqi8yDTaC5dQvRhjpkYhjg5FDzSwUxAZ7dBJ+fGO1NJyZbPEYdlvB3zk
 KdHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O6u/7KzPrbilklVRnEX6Q3JtX+gJ+wt3MM3waCjbCc/6sZplMJo25Zp21kcqBAzLY6gISAq8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjE4NHBLv75QpPAOJFWBluxDqv9EzFsbv0wOZ17nko4M47ezxH
 yM3VRfL4EcEC/BeP63ql+45gvzpLLYxoWqS4X8qbIX0u18uRK9Znxc7QlQXO2tuGuvLImMkvrWa
 2GbFaQIgYWWoX6cKdMPw83KgDgs96nEraVEb5SmQnaRd7pny9Kpxgow==
X-Gm-Gg: AeBDiesTx6uhvDII64Q1Q9iV8OMcHP9n8gL//kyMl7bYukWTOCreo1U7LUm/ot7IgLU
 4tBZC4Njv2hsZQNrbouYiMn8/Kf0Iq04o+VMcHdvtxX6l4G4JkFo40iLzMF6SgbPA4VXb2Lg4vx
 MIi/KGVX3wzHqqWiOXYr2HuDTXl9bQmB1OwL5ctsfdVcSkHfR3zSbbSxPYoVZzfHURzPeNBfjH0
 H2grE9StOG4McT8DFLfxGF+PnksCWyoFKU5/gr0BhAVmMI77teuHBhetz2kAEaU28AFXQ3eaAdv
 0zEPyKmAvbfjBF4m
X-Received: by 2002:a17:907:1c19:b0:bb8:c3d9:3a33 with SMTP id
 a640c23a62f3a-bbac52dcf9cmr40524866b.12.1777507235820; Wed, 29 Apr 2026
 17:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-11-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-11-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 18:00:24 -0600
X-Gm-Features: AVHnY4KwzCpnTJzP4ACEFqCEmdgYVwuH6jf-BK8Lz9ghoKL4qZtSRdFkJVypPaM
Message-ID: <CAFLszTiT=GA2GP1NhxTFFZtky7vPWQ+OJnwOJw3ycS2jCg8y3A@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] remoteproc: k3-hsm: Introduce a remoteproc
 driver for K3 HSM core
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
>
> Some K3 SoCs like J721S2, J784S4, J722S, AM62X and AM62PX have a HSM
> (High Security Module) M4F core in the Wakeup Voltage Domain which could
> be used to run secure services like Authentication. Boot flow for HSM M4
> core is different than the general purpose M4F cores, and is as below:
>
> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. For HS devices, Request Secure Entity to Authenticate and Load HSM
>    firmware into core's internal SRAM memory region. For GP devices,
>    load the unsigned firmware manually.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
>
> Add a new remoteproc driver to support this boot flow for HSM M4F core.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> MAINTAINERS                          |   1 +
>  drivers/remoteproc/Kconfig           |  10 ++
>  drivers/remoteproc/Makefile          |   1 +
>  drivers/remoteproc/ti_k3_hsm_rproc.c | 252 +++++++++++++++++++++++++++++++++++
>  4 files changed, 264 insertions(+)

> diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
> @@ -0,0 +1,252 @@
> +static int k3_hsm_load(struct udevice *dev, ulong addr, ulong size)
> +{
> +     struct k3_hsm_privdata *hsm = dev_get_priv(dev);
> +     size_t image_size = size;
> +     int ret;
> +
> +     ret = ti_sci_proc_request(&hsm->tsp);
> +     if (ret)
> +             return ret;
> +
> +     ret = ti_sci_proc_set_control(&hsm->tsp,
> +                                   PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
> +     if (ret)
> +             goto proc_release;
> +
> +     ti_secure_image_post_process((void *)&addr, &image_size);

Better to pass a proper 'void *image_addr = (void *)addr' here.
Casting &addr (a ulong *) to void ** happens to work on a 32-bit R5
SPL but it relies on sizeof(ulong) == sizeof(void *) and on the
compiler being willing to alias-write a void * back through that ulong
storage.

> diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
> @@ -0,0 +1,252 @@
> +     if (image_size == size) {
> +             debug("Loading HSM GP binary into SRAM0_0\n");
> +             memcpy((void *)hsm->mem[0].cpu_addr, (void *)(u32)addr, size);
> +             flush_dcache_range((unsigned long)hsm->mem[0].cpu_addr,
> +                                (unsigned long)(hsm->mem[0].cpu_addr + size));
> +     }

A few things on this block:

1. Detecting "this is a GP device, do the manual load" by comparing
image_size against the original size is brittle - e.g. on HS-FS
without a certificate, ti_secure_image_post_process() also returns
with the size unchanged (after printing a warning), so we would
silently fall into the GP path. Can you add a check for test
get_device_type() == K3_DEVICE_TYPE_GP explicitly - that would match
the commit message and the debug() line.

2. The (u32)addr cast truncates addr on any 64-bit build. R5 SPL is
32-bit today, but please drop the (u32) and just do (void *)addr so
the code is correct independent of target width.

3. There is no check that size fits in hsm->mem[0].size before the
memcpy(). If a malformed FIT delivers an oversized image, this
scribbles past SRAM0_0. A simple bounds test with an error return
would help.

> diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
> @@ -0,0 +1,252 @@
> +static int k3_hsm_stop(struct udevice *dev)
> +{
> +     struct k3_hsm_privdata *hsm = dev_get_priv(dev);
> +     int ret;
> +
> +     ti_sci_proc_request(&hsm->tsp);
> +
> +     ret = ti_sci_proc_set_control(&hsm->tsp,
> +                                   PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
> +
> +     ti_sci_proc_release(&hsm->tsp);
> +
> +     return ret;
> +}

The return value of ti_sci_proc_request() is silently dropped. If the
request fails, the set_control() call below will also fail and the
user gets a misleading error. Please check it and bail early like the
rest of the driver does.

> diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
> @@ -0,0 +1,252 @@
> +     tsp->dev_id = dev_read_u32_default(dev, 'ti,sci-dev-id',
> +                                        TI_SCI_RESOURCE_NULL);
> +     if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
> +             dev_err(dev, "Device ID not populated %d\n", ret);
> +             return -ENODEV;
> +     }

ret is 0 here (last set by the successful dev_read_u32_array() call),
so the %d is meaningless. I realise this was copied from
ti_k3_m4_rproc.c, but please drop the %d and the argument while
introducing a new copy.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
