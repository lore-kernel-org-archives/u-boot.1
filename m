Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08055C83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B24B88C21;
	Thu, 29 Aug 2024 16:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YXb1bBx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E7088C15; Thu, 29 Aug 2024 16:05:27 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A6488C24
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc47abc040so5539545ad.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940322; x=1725545122; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsCmwDppBJ8hb6ahvseBbjcb9jGhbX7s9VoWjJaedjI=;
 b=YXb1bBx+Gwz+6qLyOAQLmp1wtOy25p3dh3XnLhPrj6DhgqXIoCaNt5zsWgTkkGOOg6
 CsMTou6u9flV+9vkdYX/0Nvwlo6lylsZxGSeYX1peOIzMd/D2zJNS3sIBvzefc9zb8Eg
 OKwFMLlJB11NbPzPw+6sX0nuXk3D4HSFF1YJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940322; x=1725545122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsCmwDppBJ8hb6ahvseBbjcb9jGhbX7s9VoWjJaedjI=;
 b=qkQE1df4s1XCjiovrXmR2zKYBqNkFKCfx04Jv9dXLJkTCe02qUKEODGeY2J6W3LXQ3
 RZpkRxCyLe0CmIJnYkFt6Dev7uUwiEfK8rLyEc6rFcXS1dLyT7a2r4VaivdCwqUXjJLQ
 /KxFVeSikUjE6B0htRXnL3qe5RHwp1VE7YlnUNd4yeXl5OMWvQICjn7CbfxBvTe0641A
 hMD8B8tud8Q3tJJ34jkPwXLcHfGIt7qiAL8kjV6qFXagGRdMd+xplHc90jpyxIePMAGo
 dOW7jat92Qehh2D/OJieZYDAwSifBK9blzkvvJ+zR/YnbCkYio8iAVbDkYZrgERyNHKH
 NlTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmYPLNyBbRIGVDs5MV5Nlr/nQ7pepRnH8LrDbucd549a2cUN4LLBg5WFYXlucgi/THRzV9MY=@lists.denx.de
X-Gm-Message-State: AOJu0YzH0lfJRiROYv/nh9iK2jkJa/GGgBnJlR9fPGa7veQDA6QClVIm
 jyd6vpkI7lhiTH/PQ4aev20qelBfLoBNjT4yaiMl3/tKrhM+YetOJKHuOKNEjO7Wa1BroJ3SgDT
 zmAmIeS5GhIEifZyYcrOQwqp2jn6GVzUYXXlcKMA8cH4XINs=
X-Google-Smtp-Source: AGHT+IGfEhaoTXWc4r7tphBD8AizmKhF2qQ4BUKvevi83tdEVTnYv3oTYFK3vpyRIEWkvETaqjF8wKIZ0EAApqcpFx0=
X-Received: by 2002:a17:902:ce88:b0:1fd:8c25:415c with SMTP id
 d9443c01a7336-2050c3321f9mr33657855ad.24.1724940322202; Thu, 29 Aug 2024
 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
 <CAFLszTjHCbekGwJBvfw70iejhM6XeQ9kYc8+sHsdAfTyCq7DXw@mail.gmail.com>
 <CAB=OP5KesR5creSZ4C20v0dn3kmH_ZRRtj=L8uiK7K0dzV6hbw@mail.gmail.com>
In-Reply-To: <CAB=OP5KesR5creSZ4C20v0dn3kmH_ZRRtj=L8uiK7K0dzV6hbw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:07 -0600
Message-ID: <CAFLszTiLNGaW25v_nKqq2tiMSND_HfkcRYMu+Et-Mjy2BiAV8w@mail.gmail.com>
Subject: Re: RPI CM4 - I2C BUS and Device Tree
To: Romain Crausaz <crausaz.romain@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 u-boot@lists.denx.de
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

Hi Romain,

On Mon, 19 Aug 2024 at 01:15, Romain Crausaz <crausaz.romain@gmail.com> wro=
te:
>
> Hi Simon, Hi Peter,
>
> First of all, thanks a lot for your answers.
>
> 1. When I enable the i2c bus in the config.txt (which is parsed by the rp=
i first stage bootloader), the overlay put this as compatible:"brcm,bcm2835=
". I checked in the source of U-Boot and the driver is not available.
> 2. One solution could be to use the i2c-gpio driver instead of the defaul=
t i2c controller. U-Boot has this driver.
> 3. Since the device tree passed by the rpi bootloader is stored in the va=
riable fw_dtb_pointer (see the lowlevel_init.S) would I be able to do the f=
ollowing:
>     3.1 remove the automatic selection for the device tree passed by the =
rpi bootload
>     3.2 system starts and use the default device tree where the i2c bus i=
s defined with i2c-gpio, access the device I need and store the information=
 needed
>     3.3 get the device tree address from fw_dtb_pointer, set fdt address =
fdt addr with the new device tree and then start the kernel
>
> I have another question, what triggers the DM to check for the device (wi=
th dm tree command there is a X under the column probed). Because here we c=
ould have a really simple device tree with the minimum configuration for ju=
st the i2c and load it from U-Boot, perform the action needed and then boot=
 the kernel by passing the device tree provided by the first stage bootlode=
r.

Just a little niggle, please avoid top-posting as it messes up the
history for later readers.

U-Boot devices are probed when used. So you could use the 'i2c'
command to make it be probed.

Regards,
Simon



>
> Regards
> Romain
>
>
>
> Le sam. 17 ao=C3=BBt 2024 =C3=A0 17:57, Simon Glass <sjg@chromium.org> a =
=C3=A9crit :
>>
>> +Peter Robinson
>> +Matthias Brugger
>>
>> Hi Romain,
>>
>> On Sat, 17 Aug 2024 at 07:01, Romain Crausaz <crausaz.romain@gmail.com> =
wrote:
>> >
>> > Hi all,
>> >
>> >
>> >
>> > I am currently facing an issue with U-Boot and a raspberry pi CM4. Her=
e is
>> > the setup:
>> >
>> >
>> >
>> > 1. Yocto Scarthgap
>> >
>> > 2. U-Boot 2024.01
>> >
>> > 3. rpi_arm64_defconfig
>> >
>> >
>> >
>> > I am trying to access the i2c bus from U-Boot. I have been trying to m=
odify
>> > the device tree which is referenced as
>> > =E2=80=9CCONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b=E2=80=9D=E2=80=
=9D in the defconfig without
>> > success. I can remove everything, set all nodes to disabled and I see =
no
>> > change in U-Boot (I am using dm commands to check the status of the
>> > peripherals).
>> >
>> >
>> >
>> > It seems that with the rpi, U-Boot will only configure itself against =
the
>> > device tree passed by the bootloader of RPI. Could someone confirm thi=
s ?
>>
>> Yes. It isn't quite obvious, but this is a clue:
>>
>> Core:  211 devices, 16 uclasses, devicetree: board
>>
>> 'board' means that the board can do whatever it wants.
>>
>> >
>> >
>> >
>> > Is there a way to configure / modify U-Boot to use its own devicetree =
and
>> > simply pass the device tree generated by the rpi bootloader to the ker=
nel ?
>> >
>> >
>> >
>> > Because the second issue is that the i2c driver defined in the device =
tree
>> > passed to u-boot is not available in u-boot.
>> >
>> >
>> >
>> > Thanks for your help
>>
>> Since OF_HAS_PRIOR_STAGE is a hidden option, you cannot disable it in
>> the defconfig. The only way I know of is to comment out the 'imply
>> OF_HAS_PRIOR_STAGE' in ARCH_BCM283X in arch/arm/Kconfig
>>
>> For me, that stops the rpi_4 booting, so perhaps the devicetree is
>> out-of-date or ft_board_setup() is doing something strange, or
>> something else. The in-tree devicetree may have got out-of-date, so
>> perhaps use the Linux one.
>>
>> Regards,
>> Simon
