Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDB6C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2CD801B0;
	Thu, 23 Jan 2025 15:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N5eZzfWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED28D80214; Thu, 23 Jan 2025 15:37:23 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8900080137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dbfab8a2b0so1912645a12.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643041; x=1738247841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0c1b8dsdjacO6F3Z9RHi4IOu9OoBiOcPyYK5AAg4M2Y=;
 b=N5eZzfWG5q04a9ucT7b6o+GuAdlkBrjdfzdLBrH3+DlFGUf3696ecEyDqvZ6Yb7xKY
 C3N67UTyciL0OnS03jyLA25Vmao3NAQFb5+vU3cPucL7VPHY9VRnOb5F3zRwb2qJXIZB
 M1EcQbhKTY3Xks1O06+dOigj5lt5SsQOcMKzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643041; x=1738247841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0c1b8dsdjacO6F3Z9RHi4IOu9OoBiOcPyYK5AAg4M2Y=;
 b=tggPEO57+cmAQrQ3QTbrm5RcLnQqsYLWWiecvL6kkkhzBQsc5BqsHiDlZ5lsTZ3jzh
 /bRSwjmQ4ln04ndZp62OEejFkL+M+SiARRwrtZVtj9cmMgJMlHKE39yYKAx9hD8+vrz6
 hFfcaMQ6UEtHJskEFgLB7n9UWMKXcKwxzAAi6FP+Gf7nD7cKmYRiBsrgvtQgyLxr9oK6
 E7Yt27nDzDJ32iobRXjpfe2u6U1oTxTfR1sDgCKlfHoE6Tc0ex2NF+USoRUPN5SsfohI
 nzozjiefzSzEtoCsJ77G5+93c4/a0DjS59UE8RP20x3jviQwrIrdWdD1c82rKQf/8yq5
 BR1g==
X-Gm-Message-State: AOJu0YzmK38pSqlP1JDttb/kskz7O+tU7OjF8vP3zXvw4GqSFV34xBhg
 pXYPJHvIyyM9itRaATX0sgJ9udyP55gglvwDf3wxPnsCsnQaDLUDOTxCjpX1uXFMbjyp5WmIQLZ
 CsrcTbUTY4ltd+3vpNTe5KpqIPajPeDu54H7d
X-Gm-Gg: ASbGncuiLVAn7seoLq7M+3EjyuEbvc7a7H9Dlk5eK/av12mXnvQmj5PaaZ5xGR8LItw
 OCONdJVadVurrJ9GPKFpUpdgpQmy9CNnirmpdmWu6vWQThnVV6sIuNcFhc6po3Pk=
X-Google-Smtp-Source: AGHT+IE9MkisTxxxeU2Z3gUvwry3Y8xuis11oVDub24DwnGERKgOc9FrQKYU5ha6KiJXrvHVZVjBqDkAcw+5wb0AG6E=
X-Received: by 2002:a17:907:72ce:b0:aa6:7df0:b17a with SMTP id
 a640c23a62f3a-ab38b29b08dmr2876549066b.34.1737643036524; Thu, 23 Jan 2025
 06:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250116232840.GN3476@bill-the-cat>
 <CAFLszTjnCA0gHQLAZQsX6k7z_qsVVrQ0Zwquw3411LAz=WdukA@mail.gmail.com>
 <20250120234457.GG3476@bill-the-cat>
In-Reply-To: <20250120234457.GG3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:04 -0700
X-Gm-Features: AbW1kvaai6TSgCqlJ-yuhIut8AQla3dK_hx9h78HYAimFmnrlgk_PfNUnsO-alg
Message-ID: <CAFLszTjrKft07HEQ08zpn3388iY232u44Drvv-GiL7=R3M1OdA@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

-Bin

Hi Tom,

On Mon, 20 Jan 2025 at 16:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 20, 2025 at 12:20:06PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 16 Jan 2025 at 16:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > >
> > > > This series implements read_all() so that it is possible to read all the
> > > > files relating to a bootflow, make adjustments and then boot.
> > > >
> > > > Unfortunately quite a few things stand in the way, so this series
> > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > required support in pxe_utils and the differing code in the extlinux and
> > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > refactoring.
> > > >
> > > > The bootm, booti and bootz commands have all been refactored previously,
> > > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > > more trouble.
> > > >
> > > > However it turns out that the booti support doesn't work with compressed
> > > > booti images, so this series resolved that problem too.
> > > >
> > > > This series adds a programatic API for zboot and uses the forthcoming
> > > > bootstd 'image list' to collect information from an extlinux file. It is
> > > > therefore possible to parse the file, load the resulting images and then
> > > > examine/adjust the resulting bootflow, before booting.
> > > >
> > > > The addition of options to extlinux resulted in the PXE and extlinux
> > > > bootmeth having slightly different features. This is tidied up in this
> > > > series, with common functions for both. This allows the same features
> > > > (loading images as a separate step) to be provided for PXE.
> > >
> > > To sync up with what I said on IRC, this breaks
> > > test/py/tests/test_net_boot.py likely due to changes in the output.
> >
> > I am taking a look at this, but I'm really not sure how to set up
> > test_net_pxe_boot_config test
> >
> > I have this in my py/ellesmere/u_boot_boardenv_rpi_3_32b.py file:
> >
> > env__pxe_boot_test_skip = False
> > env__net_pxe_bootable_file = {
> >     'fn': 'default.boot',
> >     'addr': 0x10000000,
> >     # 'size': 74,
> >     'timeout': 50000,
> >     'pattern': 'Linux',
> >     'valid_label': '1',
> >     'invalid_label': '2',
> >     'exp_str_invalid': 'Skipping install for failure retrieving',
> >     'local_label': '3',
> >     'exp_str_local': 'missing environment variable: localcmd',
> >     'empty_label': '4',
> >     'exp_str_empty': 'No kernel given, skipping boot',
> >     'check_type': 'boot_error',
> >     'check_pattern': 'ERROR',
> > }
> >
> > This is what I see when running test_net_pxe_boot_config :
> >
> > test/py/tests/test_net_boot.py +u-boot-test-reset rpi_3_32b rpi3
> > {lab mode}
> > Building U-Boot in pytest-source dir for rpi_3_32b
> > Bootstrapping U-Boot from dir /tmp/b/rpi_3_32b
> > Writing U-Boot using method rpi3
> > cat: /sys/class/block/sdz1/size: No such file or directory
> > cat: /sys/class/block/sdz1/size: No such file or directory
> >
> > {lab ready in 10.4s: U-Boot 2025.01-rc6-00508-gd6da3dbaef57-dirty (Jan
> > 20 2025 - 12:11:05 -0700)}
> > skip False
> > U-Boot> setenv autoload no
> > U-Boot> U-Boot> dhcp
> > Waiting for Ethernet connection... done.
> > BOOTP broadcast 1
> > DHCP client bound to address 192.168.4.50 (4 ms)
> > U-Boot> U-Boot> echo $bootfile
> >
> > U-Boot> U-Boot> setenv pxefile_addr_r 10000000
> > U-Boot> U-Boot> pxe get
> > missing environment variable: pxeuuid
> > Retrieving file: pxelinux.cfg/01-b8-27-eb-b4-f9-f2
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/01-b8-27-eb-b4-f9-f2'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A80432
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A80432'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A8043
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A8043'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A804
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A804'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A80
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A80'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A8
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A8'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0A
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0A'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C0
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C0'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/C
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/C'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/default-arm-bcm283x-rpi
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default-arm-bcm283x-rpi'.
> > Load address: 0x10000000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Retrieving file: pxelinux.cfg/default-arm-bcm283x
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default-arm-bcm283x'.
> > Load address: 0x10000000
> > Loading: ##################################################  64 Bytes
> > 4.9 KiB/s
> > done
> > Bytes transferred = 64 (40 hex)
> > Config file '<NULL>' found
> > U-Boot> U-Boot> pxe boot 10000000
> > Retrieving file: pxelinux.cfg/default-arm
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default-arm'.
> > Load address: 0x10000044
> > Loading: ##################################################  349 Bytes
> > 30.3 KiB/s
> > done
> > Bytes transferred = 349 (15d hex)
> > Retrieving file: pxelinux.cfg/default
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default'.
> > Load address: 0x100001a4
> > Loading: ##################################################  108 Bytes
> > 9.8 KiB/s
> > done
> > Bytes transferred = 108 (6c hex)
> > Linux boot selections
> > 1: Boot kernel
> > 2: Invalid boot
> > 3: Local boot
> > 4: Empty boot
> > Enter choice: 3
> > 3: Local boot
> > missing environment variable: localcmd
> > U-Boot> pxe boot 10000000
> > Retrieving file: pxelinux.cfg/default-arm
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default-arm'.
> > Load address: 0x10000044
> > Loading: ##################################################  349 Bytes
> > 19.5 KiB/s
> > done
> > Bytes transferred = 349 (15d hex)
> > Retrieving file: pxelinux.cfg/default
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'pxelinux.cfg/default'.
> > Load address: 0x100001a4
> > Loading: ##################################################  108 Bytes
> > 9.8 KiB/s
> > done
> > Bytes transferred = 108 (6c hex)
> > Linux boot selections
> > 1: Boot kernel
> > 2: Invalid boot
> > 3: Local boot
> > 4: Empty boot
> > Enter choice: 4
> > 4: Empty boot
> > No kernel given, skipping boot
> > 1: Boot kernel
> > Retrieving file: Image
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'Image'.
> > Load address: 0x80000
> > Loading: ##################################################  6 Bytes
> > 0 Bytes/s
> > done
> > Bytes transferred = 6 (6 hex)
> > Retrieving file: rootfs.cpio.gz.u-boot
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'rootfs.cpio.gz.u-boot'.
> > Load address: 0x2700000
> > Loading: ##################################################  30.6 MiB
> > 995.1 KiB/s
> > done
> > Bytes transferred = 32123014 (1ea2886 hex)
> > Retrieving file: system.dtb
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'system.dtb'.
> > Load address: 0x2600000
> > Loading: ##################################################  11 Bytes
> > 1000 Bytes/s
> > done
> > Bytes transferred = 11 (b hex)
> > zimage: Bad magic!
> > 2: Invalid boot
> > Retrieving file: kernels/install.bin
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> > Filename 'kernels/install.bin'.
> > Load address: 0x80000
> > Loading: *
> > TFTP error: 'File not found' (1)
> > Not retrying...
> > Skipping install for failure retrieving kernel
> > 3: Local boot
> > missing environment variable: localcmd
> > U-Boot> F
> >
> > Do you have a passing run I could compare against, and/or a boardenv
> > file that works?
>
> I didn't test this on 32bit ARM, only 64bit. For Pi 3:
>
> env__net_uses_usb = True
>
> env__net_dhcp_server = True
>
> env__tftp_boot_test_skip = False
>
> env__net_tftp_bootable_file = {
>     'fn': 'v6.6/image.fit.nocomp',
>     'addr': 0x00200000,
>     'size': 85984256,
>     'crc32': '754c839a',
>     'pattern': 'Linux',
>     'config': 'conf-852',
> }
>
> # Details regarding a file that may be read from a TFTP server. This variable
> # may be omitted or set to None if PXE testing is not possible or desired.
> env__net_pxe_bootable_file = {
>     'fn': 'default',
>     'addr': 0x00200000,
>     'size': 64,
>     'timeout': 50000,
>     'pattern': 'Linux',
>     'valid_label': '1',
>     'invalid_label': '2',
>     'exp_str_invalid': 'Skipping install for failure retrieving',
>     'local_label': '3',
>     'exp_str_local': 'missing environment variable: localcmd',
>     'empty_label': '4',
>     'exp_str_empty': 'No kernel given, skipping boot',
> }
>
> # False or omitted if a PXE boot test should be tested.
> # If PXE boot testing is not possible or desired, set this variable to True.
> # For example: If pxe configuration file is not proper to boot
> env__pxe_boot_test_skip = False
>
> And:
> $ cat /srv/tftp/pxelinux.cfg/default
> label Linux
>     menu label Boot kernel
>     kernel Image
>     fdt system.dtb
>     initrd rootfs.cpio.gz.u-boot
> $ cat /srv/tftp/pxelinux.cfg/default-arm
> menu title Linux boot selections
> menu include pxelinux.cfg/default
>
> label install
>     menu label Invalid boot
>     kernel kernels/install.bin
>     append console=ttyAMA0,38400 debug earlyprintk
>     initrd initrds/uzInitrdDebInstall
>
> label local
>     menu label Local boot
>     append root=/dev/sdb1
>     localboot 1
>
> label boot
>     menu label Empty boot
> $ cat /srv/tftp/pxelinux.cfg/01-b8-27-eb-fc-64-a6
> menu include pxelinux.cfg/default-arm
> timeout 50
>
> default Linux
>
> And kernels/install.bin, etc, do not exist. Only v6.6/image.fit.nocomp
> exists.

Thanks very much for that. I have got it running and bisected the
problem to the penultimate patch, so will figure it out and send v4.

Regards,
Simon
