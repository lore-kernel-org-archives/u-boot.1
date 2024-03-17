Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494A3C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 21:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767AB87D09;
	Sun, 17 Mar 2024 22:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyMJzMmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8A887E06; Sun, 17 Mar 2024 22:39:53 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F758876E4
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 22:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c19b7d9de7so2583304b6e.2
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710711588; x=1711316388; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUEhA3z2gTprtYU9kfes8bGGwPzEeGifG0d29VKKfjE=;
 b=NyMJzMmn6grU5gnD1wJ+D0vmZtEjxHFKuRD/LIpLXTtW8mST5Y27o3kD/BEpUYaLDh
 rspBCbvBqXfr/mNRm6CG2FDjG/o9zeRLQj9fxOePqaWlsSyhJt1GSW5uKJcrgxDnRf1L
 Arz3kVRGjqDPvz1xyvbu9SwjkGLhrca8KwVR1ZD38a/nuEny02LkHNYXKsfloSBAwbVD
 ++otr36c4sIVEq7FfdeK+uejLhcC994HrEGU2rCnfgfiiLavgSRTgA7A26lDgUKXtUgt
 CLVa/3MdbcOf1lnyeWNJxnrPnIeduDpsyHCXyZjAV/Ju6jdjtVdca0nA8FhKtJVjRhxm
 PdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710711588; x=1711316388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUEhA3z2gTprtYU9kfes8bGGwPzEeGifG0d29VKKfjE=;
 b=Y+pe2tb09g+wiDzSSaNzG0W4jm3mi7pdyI4EV1QhYiGjINVb3E44wVCu16AfWMLLwv
 YpmpidQVI1xazwRnHMrvbtceleMDRvvaAjkuqON3U7mwipNWtvm44dw6JpcqAdRA/8K1
 IPOQ1n5EAzANQtPATP0ZuqpwxmnQIFFeo98/PJjvF5Vl9ccdskweZV56IgeUV+Yc1vEn
 +j/pmKnBEp7Di004CT++uUoYqx2nFbdssO02X0iw/9140gELLZCm/ZNVgN+L1lGlY7ow
 mIh3r/x08Z6MDJqHS0LV3iixPiYBkxk//NtauazQTY1j6z1xYx6zH/dFWwAHlYfDbNVV
 LkIQ==
X-Gm-Message-State: AOJu0YwgczwcmlVmvJPjaPMUZK8bGO7OQ75neuIBzsZbie6kS3ZA5DRE
 iWoHnMXKCLO0DTkTbeF2cd8u3uxHsRH12marHs0LvJIeKX/rqPBbqUB8LvdvNgMQEjxK74L28pR
 piYnlFxVZArpkah9OHOgUo1oDffc=
X-Google-Smtp-Source: AGHT+IE7skuYMa/MQ2GXluK1XWfSS3JQAIzWRSUSBXSOTE2pcOVB4VqB5EJhj5a/VkuhLPFxkRLiyZZ8jqp3kmmIsdU=
X-Received: by 2002:a05:6808:399b:b0:3c3:7f24:4537 with SMTP id
 gq27-20020a056808399b00b003c37f244537mr8054368oib.42.1710711588093; Sun, 17
 Mar 2024 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
In-Reply-To: <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
From: E Shattow <lucent@gmail.com>
Date: Sun, 17 Mar 2024 14:39:36 -0700
Message-ID: <CANV2PTPfth7Z=BYah6xLT3BoparckKzG=dtJAEhea1PdtibMWg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
To: j@jannau.net
Cc: u-boot@lists.denx.de
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

Should be usb_denylist, since "block devices" is ambiguous meaning if
it is a list of data chunks (blocks) or if it blocks (deny). There is
no question what a denylist is.

On Sun, Mar 17, 2024 at 4:07=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> Add the environment variable "usb_blocklist" to prevent USB devices
> listed in it from being used. This allows to ignore devices which
> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
> Devices emulating keyboards are one example. U-boot currently supports
> only one USB keyboard device. Most commonly, people run into this with
> Yubikeys, so let's ignore those in the default environment.
>
> Based on previous USB keyboard specific patches for the same purpose.
>
> Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568=
@denx.de/
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  doc/usage/environment.rst | 12 ++++++++++
>  include/env_default.h     | 11 ++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9..73af5be066 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *d=
ev, int addr, bool do_read,
>         return 0;
>  }
>
> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
> +{
> +       printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
> +              blocklist);
> +       return 0;
> +}
> +
> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
> +{
> +       ulong vid, pid;
> +       char *end;
> +       const char *block_str =3D env_get("usb_blocklist");
> +       const char *cur =3D block_str;
> +
> +       /* parse "usb_blocklist" strictly */
> +       while (cur && cur[0] !=3D '\0') {
> +               vid =3D simple_strtoul(cur, &end, 0);
> +               if (cur =3D=3D end || end[0] !=3D ':')
> +                       return usb_blocklist_parse_error(block_str,
> +                                                        cur - block_str)=
;
> +
> +               cur =3D end + 1;
> +               pid =3D simple_strtoul(cur, &end, 0);
> +               if (cur =3D=3D end && end[0] !=3D '*')
> +                       return usb_blocklist_parse_error(block_str,
> +                                                        cur - block_str)=
;
> +
> +               if (end[0] =3D=3D '*') {
> +                       /* use out of range idProduct as wildcard indicat=
ion */
> +                       pid =3D U16_MAX + 1;
> +                       end++;
> +               }
> +               if (end[0] !=3D ',' && end[0] !=3D '\0')
> +                       return usb_blocklist_parse_error(block_str,
> +                                                        cur - block_str)=
;
> +
> +               if (id_vendor =3D=3D vid && (pid > U16_MAX || id_product =
=3D=3D pid)) {
> +                       printf("Ignoring USB device 0x%x:0x%x\n",id_vendo=
r,
> +                             id_product);
> +                       debug("Ignoring USB device 0x%x:0x%x\n",id_vendor=
,
> +                             id_product);
> +                       return 1;
> +               }
> +               if (end[0] =3D=3D '\0')
> +                       break;
> +               cur =3D end + 1;
> +       }
> +
> +       return 0;
> +}
> +
>  int usb_select_config(struct usb_device *dev)
>  {
>         unsigned char *tmpbuf =3D NULL;
> @@ -1099,6 +1150,11 @@ int usb_select_config(struct usb_device *dev)
>         le16_to_cpus(&dev->descriptor.idProduct);
>         le16_to_cpus(&dev->descriptor.bcdDevice);
>
> +       /* ignore devices from usb_blocklist */
> +       if (usb_device_is_blocked(dev->descriptor.idVendor,
> +                                 dev->descriptor.idProduct))
> +               return -ENODEV;
> +
>         /*
>          * Kingston DT Ultimate 32GB USB 3.0 seems to be extremely sensit=
ive
>          * about this first Get Descriptor request. If there are any othe=
r
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index ebf75fa948..e42702adb2 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -366,6 +366,18 @@ tftpwindowsize
>      This means the count of blocks we can receive before
>      sending ack to server.
>
> +usb_blocklist
> +    Block USB devices from being bound to an USB device driver. This can=
 be used
> +    to ignore devices which causes crashes in u-boot's USB stack or are
> +    undesirable for other reasons.
> +    The default environment blocks Yubico devices since they emulate USB
> +    keyboards. U-boot currently supports only a single USB keyboard devi=
ce and
> +    it is undesirable that a Yubikey is used as keyboard.
> +    Devices are matched by idVendor and idProduct. The variable contains=
 a comma
> +    separated list of idVendor:idProduct pairs as hexadecimal numbers jo=
ined
> +    by a colon. '*' functions as a wildcard for idProduct to block all d=
evices
> +    with the specified idVendor.
> +
>  vlan
>      When set to a value < 4095 the traffic over
>      Ethernet is encapsulated/received over 802.1q
> diff --git a/include/env_default.h b/include/env_default.h
> index 2ca4a087d3..ba4c7516b4 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -99,6 +99,17 @@ const char default_environment[] =3D {
>  #ifdef CONFIG_SYS_SOC
>         "soc=3D"          CONFIG_SYS_SOC                  "\0"
>  #endif
> +#ifdef CONFIG_USB_HOST
> +       "usb_blocklist=3D"
> +#ifdef CONFIG_USB_KEYBOARD
> +       /* Ignore Yubico devices. Currently only a single USB keyboard de=
vice is
> +        * supported and the emulated HID keyboard Yubikeys present is us=
eless
> +        * as keyboard.
> +        */
> +       "0x1050:*,"
> +#endif
> +       "\0"
> +#endif
>  #ifdef CONFIG_ENV_IMPORT_FDT
>         "env_fdt_path=3D" CONFIG_ENV_FDT_PATH             "\0"
>  #endif
>
> --
> 2.44.0
>
