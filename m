Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB92CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 14:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D5B88B9E;
	Fri,  9 Aug 2024 16:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZgFd1jJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B73288BA5; Fri,  9 Aug 2024 16:44:13 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0B38641A
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 16:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so12176166d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723214649; x=1723819449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=298hmhrjEqDY2oHT3eO92asmCaHZiI9eCW9wAz5SZos=;
 b=ZgFd1jJk/tDKSzLZqHMVTKzHJQt+cjgjyIWNhTliJKe46B6gocaDXHHSBz9G8i6Njx
 RvKVXyOrYcuJOxHVua4XYk9TeGN3xALdq/gu3EDky71yDLwDqvUHHtqe+igLB/rPKIyF
 I9PK1gt1wG4cHLP3lAFhYlbrBd316Q1CxfbLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723214649; x=1723819449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=298hmhrjEqDY2oHT3eO92asmCaHZiI9eCW9wAz5SZos=;
 b=b7zMP3d65dj/gqDE/ITMxD8jbHMdF/ft80SYUwKhGREVh3h02OKcnEMLT7DwO31HH5
 zSx97LQrkZga20gImiv2iodrH3I+peKmn8iAaMc9dgaMFtV78ldgALywrCyKpPZVq3Rz
 /1Q03Egl0F1hOU6IthB41tECJhb0Kczim88qhboJuNW6vPVUwPvwDQf5GDYIOFk8srSm
 +Z9HXrObN0TJaaX3ljVY5YEs3Kdkw+A9Y0sMZ9r/IKOKzF4VZzMsQXXt1Mkya88eVGLS
 jwRFWc9BSuU/Q/0o44IReMQoYcgdUDrM/VI40q9/MHhlhnzU5BGpUubzi8eAPoso2xlZ
 oPgA==
X-Gm-Message-State: AOJu0Yy2MzyxG/EdT3ZrUs+LX9o/BfzzBCiGG6Fov0VA2f+1o2xoOmuZ
 j/w4YZYQz+iJX/pL28l/Y5eez9/zv7asHKDdcVpuu0SdA4ssnseWGrIHWIWxxd+ZYgJbbv6gOTG
 C1kS7yKZHY+nyitnFk1y7nDVWZuKTbzDUpLJd
X-Google-Smtp-Source: AGHT+IHInbL1iXrxyzqNkHQO7LB+T9pqT01Gp8mnOfh1+7OgAJH9IL42dtf6yZBGSMh2bFz3zT4ivp7w6CphJYqfSbg=
X-Received: by 2002:a05:6214:5d87:b0:6b4:fdfd:fece with SMTP id
 6a1803df08f44-6bd78ea443bmr21400266d6.44.1723214649550; Fri, 09 Aug 2024
 07:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj5oQwuMDbd_AXbYFsuQ=Yt+MzWeEOvcbqTuws2D2CPOQ@mail.gmail.com>
 <d2d39b09-6070-002c-0e74-54f5311009f5@gmail.com>
In-Reply-To: <d2d39b09-6070-002c-0e74-54f5311009f5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 08:43:58 -0600
Message-ID: <CAFLszTgrvBOcrK2CLpTjJxzL_Tc4ZhC=0TJ35YNT=2SwqDF3Yw@mail.gmail.com>
Subject: Re: pinctrl warning on sandbox
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Sean,

On Fri, 9 Aug 2024 at 07:31, Sean Anderson <seanga2@gmail.com> wrote:
>
> Hi Simon,
>
> On 8/7/24 19:17, Simon Glass wrote:
> > Hi Sean,
> >
> > I was looking at [1] and bisected the message to this commit:
> >
> > 7f0f1806e3a (refs/bisect/bad) test: pinmux: Add test for pin muxing
> >
> > I'm not quite sure what is going on, but could you please take a look?
> >
> > Regards,
> > Simon
> >
> > [1] https://source.denx.de/u-boot/u-boot/-/issues/2
>
> That test run is pretty old. Does the error always occur during EFI tests?
> You said in IRC it occurs on current master; can you send a link?

Yes, it happens whenever sandbox is run with the device tree. This is
sandbox build from -next:

$ /tmp/b/sandbox/u-boot -D
Bloblist at b000 not found (err=-2)
sandbox_serial serial: pinctrl_select_state_full:
uclass_get_device_by_phandle_id: err=-19


U-Boot 2024.10-rc2-00021-gb63f30d4ae6a-dirty (Aug 08 2024 - 12:46:24 -0600)

Reset Status: COLD
Model: sandbox
DRAM:  256 MiB

Warning: host_lo MAC addresses don't match:
Address in ROM is b2:e9:3c:a1:b3:05
Address in environment is 02:00:11:22:33:44
sandbox_serial serial: pinctrl_select_state_full: pinctrl_config_one: err=-38
Core:  117 devices, 61 uclasses, devicetree: board
WDT:   Started alarm-wdt with servicing every 1000ms (5s timeout)
NAND:  0 MiB
MMC:
Loading Environment from nowhere... OK
Warning: device tree node '/config/environment' not found
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: host_lo, eth1: host_enp14s0, eth2: host_eth6, eth3:
host_wlp15s0, eth4: host_docker0
Error: eth@10002000 No valid MAC address found.


Hit any key to stop autoboot:  0
=>

Regards,
Simon
