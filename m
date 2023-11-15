Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94403C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD8687209;
	Wed, 15 Nov 2023 16:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="2t5VnzzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797A287206; Wed, 15 Nov 2023 16:13:08 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6EA87215
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so11125882a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700061184; x=1700665984;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrMYlleesNZjNg1OIY57ES637tv5htbHE+x2b8vmoT4=;
 b=2t5VnzzLeNvA1HObwC+dnEXDcty75O9ST1DHtIwFV1NmAdz1hd3iZnKG+1zjkyeYzC
 qna6jr650jsd1+DhrE2Ybu/hY/K8zpJDf9BNZIMutw/SZEjzJ7r0SBqo66DacrZw7cqw
 E2wPDbxCt61Txgk2yxBllED8FviNTzCCdMWXDB0XxkW3a85KGEAJSzxu2N33UhCxM85M
 oo1a/ApSv0mXdt0lhMk5KR/8r2/haBGVsZLJThmlHMBH29EKMb1P0mJvDUqxNR0yP/b1
 XQher4bEM+kcGmZ+YlYbNeSL8gUyGYwvBq30oheQmVw3QK888bOLThcw7JRD74ykIR05
 iTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700061184; x=1700665984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrMYlleesNZjNg1OIY57ES637tv5htbHE+x2b8vmoT4=;
 b=LdSYzZGxSysf7gX1f/getBYJZ105c+ztC3AuXi4+9VFUBpDazG6x4YeYdmx+hjpR1X
 jY7wMRWJmuNa/wTHxgtONx1u4U0mQ6t0+Y++VJAZaggN5Ln+cc9G58mwFYOIBFeZGtEI
 84IEEoDVeR/tuEZyGoWIFD0eEC47SLRBLgS+Zrj4RY192j9orhCLmAzMGNDKeaxe22ml
 tZgJSdI2ZbBIs5hph7GX+4XeF1E7XoWBSB8WH3fO9zEFB9SCDrKvtUwtCYHvAb/oO5FM
 NbvUgBhrFUH8h9GWQpRJI8Dqe1FMccUdTlJ51tDMyjyUQB4qKSJQoAkrLHy1bveAeTGX
 qICw==
X-Gm-Message-State: AOJu0YwkUIFYNe1d+b/+8Y7SLoycja7NOIGA2w60LQLxYUa5cyUP+kZT
 CxiYzgJJGywblSxTU3xOs004L5n7etsplJ6j4X4CEyJTImE=
X-Google-Smtp-Source: AGHT+IHkOUvXitxap1QA50Mr3MCYBeZ8glwGDHT+GLfKG+ySRhfBvHEs/LmyO8AvXA2yLi4womY+iw==
X-Received: by 2002:a17:906:2587:b0:9dd:7133:881 with SMTP id
 m7-20020a170906258700b009dd71330881mr11128520ejb.40.1700061183706; 
 Wed, 15 Nov 2023 07:13:03 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 h18-20020a1709063b5200b009adc81bb544sm7194118ejf.106.2023.11.15.07.13.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 07:13:03 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so11125812a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:13:02 -0800 (PST)
X-Received: by 2002:aa7:ca5a:0:b0:53e:7cd3:9522 with SMTP id
 j26-20020aa7ca5a000000b0053e7cd39522mr9041648edt.39.1700061182215; Wed, 15
 Nov 2023 07:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
In-Reply-To: <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 15:12:51 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3v23k_Xbws5o-g9iQfoQ7fhpKScf89XDaaAgo+bu8tbQ@mail.gmail.com>
Message-ID: <CAHc5_t3v23k_Xbws5o-g9iQfoQ7fhpKScf89XDaaAgo+bu8tbQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 12, 2023 at 8:04=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
>
> However, when booting a bootflow that relies on USB, usb_stop() is
> called, which unbinds the device. For EFI, this happens in
> efi_exit_boot_services() which means that the bootflow disappears
> before it is finished with.
>
> There is no need to unbind all the USB devices just to quiesce them.
> Add a new usb_pause() call which removes them but leaves them bound.
>
> This resolves a hang on x86 when booting a distro from USB. This was
> found using a device with 4 bootflows, the last of which was USB.
>
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
Tested-by: Shantur Rathore <i@shantur.com>
> ---
>
> Changes in v4:
> - Don't rename the legacy-USB functions
> - Add a bit more detail to the comment
>
> Changes in v2:
> - Add new patch to avoid unbinding devices in use by bootflows
>
>  boot/bootm.c                  |  2 +-
>  common/usb.c                  |  5 +++++
>  drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
>  include/usb.h                 | 21 ++++++++++++++++++++-
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index cb61485c226c..d9c3fa8dad99 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -502,7 +502,7 @@ ulong bootm_disable_interrupts(void)
>          * updated every 1 ms within the HCCA structure in SDRAM! For mor=
e
>          * details see the OpenHCI specification.
>          */
> -       usb_stop();
> +       usb_pause();
>  #endif
>         return iflag;
>  }
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9e9..a486d1c87d4d 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -144,6 +144,11 @@ int usb_stop(void)
>         return 0;
>  }
>
> +int usb_pause(void)
> +{
> +       return usb_stop();
> +}
> +
>  /***********************************************************************=
*******
>   * Detect if a USB device has been plugged or unplugged.
>   */
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.=
c
> index a1cd0ad2d669..c26c65d7986b 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -173,7 +173,7 @@ int usb_get_max_xfer_size(struct usb_device *udev, si=
ze_t *size)
>         return ops->get_max_xfer_size(bus, size);
>  }
>
> -int usb_stop(void)
> +static int usb_finish(bool unbind_all)
>  {
>         struct udevice *bus;
>         struct udevice *rh;
> @@ -195,7 +195,7 @@ int usb_stop(void)
>
>                 /* Locate root hub device */
>                 device_find_first_child(bus, &rh);
> -               if (rh) {
> +               if (rh && unbind_all) {
>                         /*
>                          * All USB devices are children of root hub.
>                          * Unbinding root hub will unbind all of its chil=
dren.
> @@ -222,6 +222,16 @@ int usb_stop(void)
>         return err;
>  }
>
> +int usb_stop(void)
> +{
> +       return usb_finish(true);
> +}
> +
> +int usb_pause(void)
> +{
> +       return usb_finish(false);
> +}
> +
>  static void usb_scan_bus(struct udevice *bus, bool recurse)
>  {
>         struct usb_bus_priv *priv;
> diff --git a/include/usb.h b/include/usb.h
> index 09e3f0cb309c..b964e2e1f6b2 100644
> --- a/include/usb.h
> +++ b/include/usb.h
> @@ -265,7 +265,26 @@ int usb_kbd_deregister(int force);
>   */
>  int usb_init(void);
>
> -int usb_stop(void); /* stop the USB Controller */
> +/**
> + * usb_stop() - stop the USB Controller and unbind all USB controllers/d=
evices
> + *
> + * This unbinds all devices on the USB buses.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_stop(void);
> +
> +/**
> + * usb_pause() - stop the USB Controller DMA, etc.
> + *
> + * Note that this does not unbind bus devices, so using usb_init() after=
 this
> + * call is not permitted. This function is only useful just before booti=
ng, to
> + * ensure that devices are dormant.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int usb_pause(void);
> +
>  int usb_detect_change(void); /* detect if a USB device has been (un)plug=
ged */
>
>
> --
> 2.42.0.869.gea05f2083d-goog
>
