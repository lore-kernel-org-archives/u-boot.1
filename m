Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B35C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4245870A5;
	Sat,  4 Nov 2023 20:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n8ivLrfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B67486F7C; Sat,  4 Nov 2023 20:43:00 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EE98708A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so5212771a12.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699126978; x=1699731778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=raCBbg8k21hFmd/xilkZ7HErH8g1kg9IL4Jfch0bPlU=;
 b=n8ivLrfNla2J3yBnn9wuNHqn6rcJ91P8mm9+J+GASKfumZamengIHBR/KUK3gXDnD3
 QUVtSHd2WWma1GN1j1hzbdq2tMRHgE1Ec/TjjDd6jiquEvMjwXOWXBcl6WbL6Rd9lZzB
 qJXRNHQbB4bEGr6fKYZlpRpC0ytW0+rC0M9Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699126978; x=1699731778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raCBbg8k21hFmd/xilkZ7HErH8g1kg9IL4Jfch0bPlU=;
 b=m2i1WVw5+ok3x8NPiWDDk7YwYoJ4KUgLhluGd27K+PykujhBvVzK7crIsc0jQgd2ih
 mffpk51vfrhHPRzHKcA6brFMO0qnEM5/lH7kIZCO4RqzVSeGp0jyp9p4vlVjofGV/37I
 QmRlLz8orqaeRFHwPQUI+/dXd9xeKqNR49xMRWQ814WoFPU71q27topQNqxg7flKIlia
 fbJdZJAJ49/XvVtha5Wu+RBtpe4/H1JNSXejUW84p1c3Wq9bXQ+rbaKAYMAwtoYUfvlc
 oBmyrYsZnWYUeJwLxQXLNrrv9qy5NVODsOEuiIiZWceWz0lP35cjATKT3wDjSrivZJJm
 28TA==
X-Gm-Message-State: AOJu0Yx5CR5OQZsptZHOEcECD4kSdL4E/WrSvxFYsM9JMJG8XYraEmWQ
 Jrtj71CE19p1B9PNxzwBRmvD5xAyHdIZdeEzkest391bOEYRZaDw0So=
X-Google-Smtp-Source: AGHT+IE2aVpBAynwDF24BPWHkPkL/UNqQjlEz8w+u4IwuTkGyZzVBwy+h2fpfdfOhFr5mZMaj7cYnJXvQv1KS1pi9oE=
X-Received: by 2002:a50:baa7:0:b0:533:97c:8414 with SMTP id
 x36-20020a50baa7000000b00533097c8414mr21157876ede.7.1699126977578; Sat, 04
 Nov 2023 12:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
In-Reply-To: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:42:38 +0000
Message-ID: <CAPnjgZ0zjD+vrsyHkRpAzatZvA7Cv5-9Q+96O1mUN0Ei4H70uw@mail.gmail.com>
Subject: Re: Need advise with u-boot on SH-7785LCR
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: u-boot@lists.denx.de
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

Hi John,

On Sat, 4 Nov 2023 at 13:59, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hello!
>
> I am Debian's maintainer for the SuperH (sh4) port as well as one of the upstream
> maintainers of SuperH support in the kernel. I own various SuperH boards with one
> of them being the Renesas SH-7785LCR board which used to be supported by u-boot
> up to including v2019.01.
>
> My board is currently running v2014.01 with the following output:
>
> U-Boot 2014.01 (Jan 30 2015 - 11:01:14)
>
> CPU: SH4
> BOARD: Renesas Technology Corp. R0P7785LC0011RL
> DRAM:  384MB
> Flash: 64MB
> PCI: SH7780 PCI host bridge found.
> PCI:   Bus Dev VenId DevId Class Int
>   00:00.0     - 10ec:8169 - Network controller
>   00:01.0     - 1095:3512 - Mass storage controller
> In:    serial
> Out:   serial
> Err:   serial
> Net:   RTL8169#0
> Warning: RTL8169#0 MAC addresses don't match:
> Address in SROM is         00:00:87:6b:bd:72
> Address in environment is  74:90:50:00:02:03
>
> Hit any key to stop autoboot:  0
> => printenv
> baudrate=115200
> bootargs=console=ttySC1,115200 root=/dev/sda1 ip=dhcp
> bootcmd=usb reset; fatload usb 0:1 0x89000000 uImage-git.gz; pmb ; bootm
> bootdelay=3
> bootdevice=0:1
> ethact=RTL8169#0
> ethaddr=74:90:50:00:02:03
> stderr=serial
> stdin=serial
> stdout=serial
> usbload=usb reset; fatload usb 0:1 0x89000000 uImage-git.gz; pmb ; bootm
> ver=U-Boot 2014.01 (Jan 30 2015 - 11:01:14)
>
> Environment size: 396/262140 bytes
> =>
>
> I am currently running into the problem that u-boot hangs after verifying the image
> checksum when trying to boot a cross-built kernel. This has happened in the past before
> while often the kernel would boot just fine after performing some resets.
>
> When the boot hangs, it looks like this:
>
> => usb reset; fatload usb 0:1 0x89000000 uImage-next.gz ; pmb ; bootm
> (Re)start USB...
> USB0:   scanning bus 0 for devices... 2 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
> reading uImage-next.gz
> 4348967 bytes read in 2470 ms (1.7 MiB/s)
> ## Booting kernel from Legacy Image at 89000000 ...
>    Image Name:   Linux-6.6.0-rc1-00007-g63f1ee206
>    Image Type:   SuperH Linux Kernel Image (gzip compressed)
>    Data Size:    4348903 Bytes = 4.1 MiB
>    Load Address: 80001000
>    Entry Point:  80002000
>    Verifying Checksum ... OK
> (hangs)
>
> My first attempt at fixing this would be upgrading the board to v2019.01.
>
> Unfortunately, I have not found any documentation yet which explains how to upgrade
> the u-boot firmware on this particular board. Does anyone know whether there are
> any tools for this available? I can see an "erase" command in the u-boot command
> list, but there is no command for writing a new u-boot firmware to flash.
>
> I have already reached out to Nobuhiro Iwamatsu who is the original author of support
> for these boards in u-boot and also provided me with the particular hardware. However,
> I haven't heard back from him yet.
>
> Another question that I have is the loading address. I need to load the kernel to the
> loading address 0x89000000 as otherwise the machine won't boot. However, according to
> the output of the u-boot mkimage tool, the loading address is 0x80001000 and not
> 0x8900000. Could the different addresses be related to the unusual memory layout
> of this board which has to be switched with the "pmb" command prior boot?
>
> Also, I was wondering what it would take to convert this particular board to CONFIG_DM_USB
> and CONFIG_DM_PCI. I would be interested in getting support for SuperH boards in u-boot
> into a better shape with broader hardware support.
>
> From the kernel side, we're currently working on converting SuperH to Device Trees, so I'm
> expecting SuperH Linux to be better suited to modern versions of u-boot in the future.
>
> For now, it would be a great help if anyone could help me with the hanging boot issue.

Is it possible to check if it reaches the kernel? E.g. with
earlyprintk ? It would be good to know if U-Boot managers to jump to
Linux, or not.

Regards,
Simon
