Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B23C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB32801CF;
	Mon, 20 Jan 2025 20:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F5+uu0GP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E765B8032B; Mon, 20 Jan 2025 20:20:21 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C63800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso901524466b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400819; x=1738005619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d+UQGetXkhHP7xr0SSnIxs7dJ+4REoSCBvOhxK1JtpM=;
 b=F5+uu0GPCP6/khUY1wesobUS6crukdP6VtSu8dvgDIZ03+Y5gKzQ/PwZjzLs0bJpoW
 kFca0OZfSXXqWS8JPWawmygEWWt7eKCF3VXKP8gSh74tAKCwYVKnscn32gclkkQDJ8hu
 734VHFAV52Y2Qf0X7YGJWRgmvyoKMwV2k8/cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400819; x=1738005619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+UQGetXkhHP7xr0SSnIxs7dJ+4REoSCBvOhxK1JtpM=;
 b=rPJkRFVeHG7lUj76eHnaBfLd/BmQFE+ctxZlqW8DtQhn91PZmiFN9Qu0rRY0cEUnYN
 C0+axI24UNl0TGTX2gPDfqnNDh9k6rX2MAypwDOQ1IFE3khXd9jvz2XspAnL1tL6hQJS
 my7/JQQQIIVaPQM7D8l4PLHMkstV8YDHkLhAlMdlWu3ZxebScPnyjJPizSPNdHgbtuyS
 HWmx2LEA7RgGdxlXfKSGTwVrEhL9rZA2JNplOiGR7r6/Ca+egSIIBcD0rJ+KoiLmShuj
 z8feBSUZ2bg3VVr0DySHtzGLOPBnBNmRCioCUMCJCQNbam2vyAVESIqZ9cSyrc0VFb8b
 0VAg==
X-Gm-Message-State: AOJu0YwVGsG2HhvUAdFj+r4Exa0DT8r6TQSA/l05E5VCd31KgCj8Nlff
 IU4l/FM30MzcvRlf1ZM9weNNh0Jjy8lAOXmWHbbNCmibrIyfXRNTww4wa51kC/5aY/I+N/xftnI
 UHqqhmIsIO0MJ8vbyMgvUB8SrkdC3hWA/WAeJ
X-Gm-Gg: ASbGnctdlUXIOsbcpSc2fOuyMdlqbuyvlPTcl1/1oqfn0kBWTHmgsPxWyqx1NtmTJCL
 +t76xeFvC5mkvtedRx+ZadQqtVm2V/tSowkkfNzS+BvJCHFz6hpn1
X-Google-Smtp-Source: AGHT+IGx1WUwO4SJ1sGc/Pr6HlMT10vpPdzYRvhnDsPbZYTfQ57fGPqgOkRiVFpsfn5wUdE646GmIwmdMdmREvVL084=
X-Received: by 2002:a17:906:da82:b0:ab3:771b:2e99 with SMTP id
 a640c23a62f3a-ab38b42b4b7mr1418845166b.45.1737400818686; Mon, 20 Jan 2025
 11:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250116232840.GN3476@bill-the-cat>
In-Reply-To: <20250116232840.GN3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:20:06 -0700
X-Gm-Features: AbW1kva09MqAKzYSxoD5sCkhW0o9GipUpa5hE7AmQf2eIm8kI9lmyJEssz5PPro
Message-ID: <CAFLszTjnCA0gHQLAZQsX6k7z_qsVVrQ0Zwquw3411LAz=WdukA@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
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

Hi Tom,

On Thu, 16 Jan 2025 at 16:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
>
> > This series implements read_all() so that it is possible to read all the
> > files relating to a bootflow, make adjustments and then boot.
> >
> > Unfortunately quite a few things stand in the way, so this series
> > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > required support in pxe_utils and the differing code in the extlinux and
> > PXE bootmeths. There is very little new code, but quite a lot of
> > refactoring.
> >
> > The bootm, booti and bootz commands have all been refactored previously,
> > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > At the, time, zboot was left alone, since it is x86-specific and a bit
> > more trouble.
> >
> > However it turns out that the booti support doesn't work with compressed
> > booti images, so this series resolved that problem too.
> >
> > This series adds a programatic API for zboot and uses the forthcoming
> > bootstd 'image list' to collect information from an extlinux file. It is
> > therefore possible to parse the file, load the resulting images and then
> > examine/adjust the resulting bootflow, before booting.
> >
> > The addition of options to extlinux resulted in the PXE and extlinux
> > bootmeth having slightly different features. This is tidied up in this
> > series, with common functions for both. This allows the same features
> > (loading images as a separate step) to be provided for PXE.
>
> To sync up with what I said on IRC, this breaks
> test/py/tests/test_net_boot.py likely due to changes in the output.

I am taking a look at this, but I'm really not sure how to set up
test_net_pxe_boot_config test

I have this in my py/ellesmere/u_boot_boardenv_rpi_3_32b.py file:

env__pxe_boot_test_skip = False
env__net_pxe_bootable_file = {
    'fn': 'default.boot',
    'addr': 0x10000000,
    # 'size': 74,
    'timeout': 50000,
    'pattern': 'Linux',
    'valid_label': '1',
    'invalid_label': '2',
    'exp_str_invalid': 'Skipping install for failure retrieving',
    'local_label': '3',
    'exp_str_local': 'missing environment variable: localcmd',
    'empty_label': '4',
    'exp_str_empty': 'No kernel given, skipping boot',
    'check_type': 'boot_error',
    'check_pattern': 'ERROR',
}

This is what I see when running test_net_pxe_boot_config :

test/py/tests/test_net_boot.py +u-boot-test-reset rpi_3_32b rpi3
{lab mode}
Building U-Boot in pytest-source dir for rpi_3_32b
Bootstrapping U-Boot from dir /tmp/b/rpi_3_32b
Writing U-Boot using method rpi3
cat: /sys/class/block/sdz1/size: No such file or directory
cat: /sys/class/block/sdz1/size: No such file or directory

{lab ready in 10.4s: U-Boot 2025.01-rc6-00508-gd6da3dbaef57-dirty (Jan
20 2025 - 12:11:05 -0700)}
skip False
U-Boot> setenv autoload no
U-Boot> U-Boot> dhcp
Waiting for Ethernet connection... done.
BOOTP broadcast 1
DHCP client bound to address 192.168.4.50 (4 ms)
U-Boot> U-Boot> echo $bootfile

U-Boot> U-Boot> setenv pxefile_addr_r 10000000
U-Boot> U-Boot> pxe get
missing environment variable: pxeuuid
Retrieving file: pxelinux.cfg/01-b8-27-eb-b4-f9-f2
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/01-b8-27-eb-b4-f9-f2'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A80432
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A80432'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A8043
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A8043'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A804
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A804'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A80
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A80'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A8
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A8'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0A
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0A'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C0
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C0'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/C
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/C'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/default-arm-bcm283x-rpi
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default-arm-bcm283x-rpi'.
Load address: 0x10000000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Retrieving file: pxelinux.cfg/default-arm-bcm283x
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default-arm-bcm283x'.
Load address: 0x10000000
Loading: ##################################################  64 Bytes
4.9 KiB/s
done
Bytes transferred = 64 (40 hex)
Config file '<NULL>' found
U-Boot> U-Boot> pxe boot 10000000
Retrieving file: pxelinux.cfg/default-arm
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default-arm'.
Load address: 0x10000044
Loading: ##################################################  349 Bytes
30.3 KiB/s
done
Bytes transferred = 349 (15d hex)
Retrieving file: pxelinux.cfg/default
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default'.
Load address: 0x100001a4
Loading: ##################################################  108 Bytes
9.8 KiB/s
done
Bytes transferred = 108 (6c hex)
Linux boot selections
1: Boot kernel
2: Invalid boot
3: Local boot
4: Empty boot
Enter choice: 3
3: Local boot
missing environment variable: localcmd
U-Boot> pxe boot 10000000
Retrieving file: pxelinux.cfg/default-arm
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default-arm'.
Load address: 0x10000044
Loading: ##################################################  349 Bytes
19.5 KiB/s
done
Bytes transferred = 349 (15d hex)
Retrieving file: pxelinux.cfg/default
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'pxelinux.cfg/default'.
Load address: 0x100001a4
Loading: ##################################################  108 Bytes
9.8 KiB/s
done
Bytes transferred = 108 (6c hex)
Linux boot selections
1: Boot kernel
2: Invalid boot
3: Local boot
4: Empty boot
Enter choice: 4
4: Empty boot
No kernel given, skipping boot
1: Boot kernel
Retrieving file: Image
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'Image'.
Load address: 0x80000
Loading: ##################################################  6 Bytes
0 Bytes/s
done
Bytes transferred = 6 (6 hex)
Retrieving file: rootfs.cpio.gz.u-boot
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'rootfs.cpio.gz.u-boot'.
Load address: 0x2700000
Loading: ##################################################  30.6 MiB
995.1 KiB/s
done
Bytes transferred = 32123014 (1ea2886 hex)
Retrieving file: system.dtb
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'system.dtb'.
Load address: 0x2600000
Loading: ##################################################  11 Bytes
1000 Bytes/s
done
Bytes transferred = 11 (b hex)
zimage: Bad magic!
2: Invalid boot
Retrieving file: kernels/install.bin
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.4.1; our IP address is 192.168.4.50
Filename 'kernels/install.bin'.
Load address: 0x80000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...
Skipping install for failure retrieving kernel
3: Local boot
missing environment variable: localcmd
U-Boot> F

Do you have a passing run I could compare against, and/or a boardenv
file that works?

Thanks,
Simon
