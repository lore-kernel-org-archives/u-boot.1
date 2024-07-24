Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D0FC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD448896B;
	Wed, 24 Jul 2024 16:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iQvQyaRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CD78897A; Wed, 24 Jul 2024 16:37:27 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714F888920
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7a0ef0e75so40356646d6.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831844; x=1722436644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5fdRErxGSUe2YcBjty9uU+IoPYtODwUThkLaFN11WmM=;
 b=iQvQyaRfvJZWXY6+jcc02QFphREhjbZ5ZlljS/2Vg7kPG2fuJAXzzIrRruIrTcm+DY
 zjgBCDtQ4B8CE2JHgaj5fEJh3/dDexAC1x5PrJqiF4+Yi379ZI5iSvKEdNXR9uzUZ5AS
 VwTx9S0vRBDKpWno4SRrLjuDJWesYC2M6Bv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831844; x=1722436644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fdRErxGSUe2YcBjty9uU+IoPYtODwUThkLaFN11WmM=;
 b=sV1xx6m71FhZOB8jo6P4oF/+aE+dnp8aMNBpkEWaqGhsW76bppcVDtKA+fB7uoBy8N
 9QxiWkUN/AKUKzGs8HD0yW3DvIN6ZYWf7gyr5XydHmEFNEMB2AoX6//3q0OKRGTFS21r
 VG1JnUf49hlHUVniHI4df1cNTIJT6JhQi8WA70rw/nR+07+cVIt6pwx24xzQl/8MV8le
 AuIYt+S+16bTkEECrOEUB8IZIPlDCKxGiA5G6tOLG1j6NLzO96hQ2hBzPvHuirhDfhEG
 iN+AIWnlOBZfwNgyzF0V2Jn2wgCNnogsthev4hzKS9JcpXq5dPnuqNw3rFO2HrEVWnbz
 uOqg==
X-Gm-Message-State: AOJu0YyQIxAke0NQZ6z6xaNKo5lbIl82tWoTF6ifQFPjJNa+fNlK6Q4L
 1KOa3z+Sd3nVr9vo7zIKFgti2TxBs/QtAHjsU+hRnlocttnTnnyQJmOIX6d+ejM5Qf91RLIfmcp
 FStofmHi3JlybVA+f+j2r565peuWxH+mIuG5FAc681hqph48=
X-Google-Smtp-Source: AGHT+IH31UP52RIJ3K6UoOw10/TvflmptdK3o13a/lw/iSaMyn1W6IcZedCur1YBtv1QBssoqYcOsP7E3Aw/19Auebg=
X-Received: by 2002:ad4:5be4:0:b0:6b5:413a:3f96 with SMTP id
 6a1803df08f44-6b98ed243c1mr33876376d6.10.1721831844303; Wed, 24 Jul 2024
 07:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240723150400.16650-2-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:13 -0600
Message-ID: <CAFLszTiXhnZ+=e1d3k0izMAYtPOHKb2bbdubrkB-kPL+KdXfjw@mail.gmail.com>
Subject: Re: [PATCHv1 1/5] cpu: add release_core callback
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com
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

Hi Zhiqiang,

On Tue, 23 Jul 2024 at 08:43, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new callback release_core to the cpu_ops, which is used to
> release a CPU core to run baremetal or RTOS application on a SoC
> with multiple CPU cores.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/cpu/cpu-uclass.c | 10 ++++++++++
>  include/cpu.h            | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
> index 16f8f2e521..2c8e46c05e 100644
> --- a/drivers/cpu/cpu-uclass.c
> +++ b/drivers/cpu/cpu-uclass.c
> @@ -104,6 +104,16 @@ int cpu_get_vendor(const struct udevice *dev, char *buf, int size)
>         return ops->get_vendor(dev, buf, size);
>  }
>
> +int cpu_release_core(const struct udevice *dev, phys_addr_t addr)
> +{
> +       struct cpu_ops *ops = cpu_get_ops(dev);
> +
> +       if (!ops->release_core)
> +               return -ENOSYS;
> +
> +       return ops->release_core(dev, addr);
> +}
> +
>  U_BOOT_DRIVER(cpu_bus) = {
>         .name   = "cpu_bus",
>         .id     = UCLASS_SIMPLE_BUS,
> diff --git a/include/cpu.h b/include/cpu.h
> index 2077ff3063..0018910d61 100644
> --- a/include/cpu.h
> +++ b/include/cpu.h
> @@ -102,6 +102,15 @@ struct cpu_ops {
>          *         if not.
>          */
>         int (*is_current)(struct udevice *dev);
> +
> +       /**
> +        * release_core() - Relase a CPU core to the given address to run application
> +        *
> +        * @dev:        Device to check (UCLASS_CPU)
> +        * @addr:       Address to relese the CPU core
> +        * @return 0 if OK, -ve on error
> +        */
> +       int (*release_core)(const struct udevice *dev, phys_addr_t addr);
>  };
>
>  #define cpu_get_ops(dev)        ((struct cpu_ops *)(dev)->driver->ops)
> @@ -164,4 +173,10 @@ int cpu_is_current(struct udevice *cpu);
>   */
>  struct udevice *cpu_get_current_dev(void);
>
> +/**
> + * cpu_release_core() - Relase a CPU core to the given address to run application
> + *
> + * @return 0 if OK, -ve on error
> + */
> +int cpu_release_core(const struct udevice *dev, phys_addr_t addr);
>  #endif
> --
> 2.17.1
>

Please also add a test for this callback to test/dm/cpu.c

Regards,
Simon
