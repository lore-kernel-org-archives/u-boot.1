Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC807C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C7188498;
	Sat, 17 Aug 2024 17:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WfeYPRq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9569D884AC; Sat, 17 Aug 2024 17:57:39 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A76788403
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf7f4a133aso9250306d6.2
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910256; x=1724515056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z2lZQOKWSO+XcHtqXIPzNwpCMrW9YOeiJiTkUEKMuQ=;
 b=WfeYPRq4nZ5+ubSL64kOnQQT0n4ZoIZxdQlzj57MXO2m6B9eFz4sj0TYjd5GFviQjX
 xfkaNuT6ilJk4+agJgCfLV3E8MXYPBKEEYhAIQJ+lmojNqwkNKD786bQoYDqRgU8eLUy
 5j8g06Kp4M1JHbAbS8R19/Agh+oOumT2tm3Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910256; x=1724515056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9z2lZQOKWSO+XcHtqXIPzNwpCMrW9YOeiJiTkUEKMuQ=;
 b=VgLbFV1qXME5v21X7xB+z1otoIv9pQB2ddbJTAYUmUXsk9itUva6VnJs/zrO5Rl57/
 0zC56YdjtF2cR415uGYQn8ZEvFvQiHfKfB94OygBwIhWU7hkTA37/PaAmEqQez9By7zb
 XPnyfHqJr6CzrrwlfIhIP0zWH8xNahtMdFWgj+Dv9CPrIpSgdo0Ukej57AVk4xG1EtMv
 KNaQx3Q6S2qGVMtvTT9MdJp9puGwpKVjF1szKStw940S/vosepeCdJanE185kh5D7ZLB
 0hwXFyRTKRnacfBmeSkyaE3sHvHYsNzdM7FJxTt6vULOykl/mBUquC9ookqkD2RvRNuc
 ZQUQ==
X-Gm-Message-State: AOJu0Yx+ko3I+58js+CqFUm9ad0bXIpa2SQCdXohVFeIGrnob4IVTT+n
 hFXbFRXUUYxtKicU6hhJv+PrjIITgdPSxN/c227v8H6ZaqJV1HMnM6lTlXL1lBNGwN3J7qlOOV9
 +ORWrCJfFTHvsRjm2H+k0oWjTydSvN/dENDUL
X-Google-Smtp-Source: AGHT+IHdH+QTrWCEG+SeHbftyVJDtm+YgeUI0tUjMWeL+OgXYWdSvlMpIUQUmsAENt5SaElhl6XSTmcmEvXGRzqNDc0=
X-Received: by 2002:a05:6214:57cf:b0:6bf:8087:d66c with SMTP id
 6a1803df08f44-6bf8087d680mr53107256d6.20.1723910256243; Sat, 17 Aug 2024
 08:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
In-Reply-To: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:57:25 -0600
Message-ID: <CAFLszTjHCbekGwJBvfw70iejhM6XeQ9kYc8+sHsdAfTyCq7DXw@mail.gmail.com>
Subject: Re: RPI CM4 - I2C BUS and Device Tree
To: Romain Crausaz <crausaz.romain@gmail.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>
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

+Peter Robinson
+Matthias Brugger

Hi Romain,

On Sat, 17 Aug 2024 at 07:01, Romain Crausaz <crausaz.romain@gmail.com> wro=
te:
>
> Hi all,
>
>
>
> I am currently facing an issue with U-Boot and a raspberry pi CM4. Here i=
s
> the setup:
>
>
>
> 1. Yocto Scarthgap
>
> 2. U-Boot 2024.01
>
> 3. rpi_arm64_defconfig
>
>
>
> I am trying to access the i2c bus from U-Boot. I have been trying to modi=
fy
> the device tree which is referenced as
> =E2=80=9CCONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b=E2=80=9D=E2=80=9D =
in the defconfig without
> success. I can remove everything, set all nodes to disabled and I see no
> change in U-Boot (I am using dm commands to check the status of the
> peripherals).
>
>
>
> It seems that with the rpi, U-Boot will only configure itself against the
> device tree passed by the bootloader of RPI. Could someone confirm this ?

Yes. It isn't quite obvious, but this is a clue:

Core:  211 devices, 16 uclasses, devicetree: board

'board' means that the board can do whatever it wants.

>
>
>
> Is there a way to configure / modify U-Boot to use its own devicetree and
> simply pass the device tree generated by the rpi bootloader to the kernel=
 ?
>
>
>
> Because the second issue is that the i2c driver defined in the device tre=
e
> passed to u-boot is not available in u-boot.
>
>
>
> Thanks for your help

Since OF_HAS_PRIOR_STAGE is a hidden option, you cannot disable it in
the defconfig. The only way I know of is to comment out the 'imply
OF_HAS_PRIOR_STAGE' in ARCH_BCM283X in arch/arm/Kconfig

For me, that stops the rpi_4 booting, so perhaps the devicetree is
out-of-date or ft_board_setup() is doing something strange, or
something else. The in-tree devicetree may have got out-of-date, so
perhaps use the Linux one.

Regards,
Simon
