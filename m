Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CA3C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 23:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114AD805C5;
	Tue, 21 Jan 2025 00:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMJN/h4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A52805C5; Tue, 21 Jan 2025 00:45:07 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C2B800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 00:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b7041273ddso402048285a.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737416703; x=1738021503; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fRVEnkOSZaNmPxhzd9Jp4mdOHLGZYIBeldf5WjAwNK0=;
 b=BMJN/h4NcrpPUcGXJqOL8rEn7Yw/IwGSMpFHLAzUju0EwXl0lDjopwqa3yb8Qbv+4N
 eB3NUskBsZQEi5vvnr6H+wV1KQEuMquLcFkgKUABDEPlgeXFRLyxvlsoqXEIPB1ij1gx
 9+j9PJM0686Ni1D7YCn1zMbJV4afuYslKNjfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737416703; x=1738021503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRVEnkOSZaNmPxhzd9Jp4mdOHLGZYIBeldf5WjAwNK0=;
 b=raZ5Ehhe/QY7VIkZ2SS3IfeiZrskbDXqJ5VidkRpiQWrdgKOSfB0aUCWVJUKth+9xd
 u3Y7GwR+GxrU9tSDln5psWEBc+rh6Dq8Y92fyx7nJXx/BADmNhRcJO54SNu1hmn9Emv1
 aSw57zOxiWEnP3iJQIEMI9xUunWp7i5RJBHU8TyaVmVa/Q5xkhmwEm0gM98AY2tXxAEg
 4cj7vaNVSVnX8M6L4AUMcNznFLDvl/8HAWC8Cn/wBl90/MF+Y0/oYIycTk7jBEB62ZAo
 e2Upfy4j50HaX0m6odz812kJQzt7ukKaXlqmIMK8FvFIgkizUxpw6BmzejAgjzSScUIf
 Gazw==
X-Gm-Message-State: AOJu0YyhCvmjjiCgDOyGzucf2ew5R1QHMKsdkwTQ4Y73CKVUSBBJ2e/r
 8DiAM1rL/wmsnyXXP5pm60Lq/yiu5yQ2MsDU85vIn/v976IT6zsD2bLVOeBAVdA=
X-Gm-Gg: ASbGncufPQpn31zuNIoevFJ81w4QRiiBmxiOBsuokWTpdTF2rTIom0V0UPlgZg8Obv1
 OZ2UtrM1nHkDwuF75TvpcUUi4ln1obEETgtEl9HHkUmoow6jmMTi3fb+lOOXk5Y6r8hOZVCXK7J
 tUJ2+Z3CNMZ3DtJLppoDlhh6zNUhn44OCYcWAMn1S1htxayXeMvMKQ4ghnRsQE7MmOHbfuJ6y7y
 XsQj/K8L0XreZ2jGPlCihrw2G5ksGCmMmeGf+12IJK7wXhwzPRFQ48OZsi5v7WqL/8=
X-Google-Smtp-Source: AGHT+IHpwJafh/Dlj/4bAy1mmsZQnW7JXDSopHRw5lPmkWl4Es2f44cw93ncmLGCri08UkMf3EFCTA==
X-Received: by 2002:a05:620a:404f:b0:7b6:6b52:8bb1 with SMTP id
 af79cd13be357-7be63215c8fmr2367784085a.14.1737416703073; 
 Mon, 20 Jan 2025 15:45:03 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d9adbsm496177985a.87.2025.01.20.15.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 15:45:02 -0800 (PST)
Date: Mon, 20 Jan 2025 17:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
Message-ID: <20250120234457.GG3476@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250116232840.GN3476@bill-the-cat>
 <CAFLszTjnCA0gHQLAZQsX6k7z_qsVVrQ0Zwquw3411LAz=WdukA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="26M42XUs2xtcMj3d"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnCA0gHQLAZQsX6k7z_qsVVrQ0Zwquw3411LAz=WdukA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--26M42XUs2xtcMj3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 12:20:06PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 16 Jan 2025 at 16:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> >
> > > This series implements read_all() so that it is possible to read all =
the
> > > files relating to a bootflow, make adjustments and then boot.
> > >
> > > Unfortunately quite a few things stand in the way, so this series
> > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > required support in pxe_utils and the differing code in the extlinux =
and
> > > PXE bootmeths. There is very little new code, but quite a lot of
> > > refactoring.
> > >
> > > The bootm, booti and bootz commands have all been refactored previous=
ly,
> > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > more trouble.
> > >
> > > However it turns out that the booti support doesn't work with compres=
sed
> > > booti images, so this series resolved that problem too.
> > >
> > > This series adds a programatic API for zboot and uses the forthcoming
> > > bootstd 'image list' to collect information from an extlinux file. It=
 is
> > > therefore possible to parse the file, load the resulting images and t=
hen
> > > examine/adjust the resulting bootflow, before booting.
> > >
> > > The addition of options to extlinux resulted in the PXE and extlinux
> > > bootmeth having slightly different features. This is tidied up in this
> > > series, with common functions for both. This allows the same features
> > > (loading images as a separate step) to be provided for PXE.
> >
> > To sync up with what I said on IRC, this breaks
> > test/py/tests/test_net_boot.py likely due to changes in the output.
>=20
> I am taking a look at this, but I'm really not sure how to set up
> test_net_pxe_boot_config test
>=20
> I have this in my py/ellesmere/u_boot_boardenv_rpi_3_32b.py file:
>=20
> env__pxe_boot_test_skip =3D False
> env__net_pxe_bootable_file =3D {
>     'fn': 'default.boot',
>     'addr': 0x10000000,
>     # 'size': 74,
>     'timeout': 50000,
>     'pattern': 'Linux',
>     'valid_label': '1',
>     'invalid_label': '2',
>     'exp_str_invalid': 'Skipping install for failure retrieving',
>     'local_label': '3',
>     'exp_str_local': 'missing environment variable: localcmd',
>     'empty_label': '4',
>     'exp_str_empty': 'No kernel given, skipping boot',
>     'check_type': 'boot_error',
>     'check_pattern': 'ERROR',
> }
>=20
> This is what I see when running test_net_pxe_boot_config :
>=20
> test/py/tests/test_net_boot.py +u-boot-test-reset rpi_3_32b rpi3
> {lab mode}
> Building U-Boot in pytest-source dir for rpi_3_32b
> Bootstrapping U-Boot from dir /tmp/b/rpi_3_32b
> Writing U-Boot using method rpi3
> cat: /sys/class/block/sdz1/size: No such file or directory
> cat: /sys/class/block/sdz1/size: No such file or directory
>=20
> {lab ready in 10.4s: U-Boot 2025.01-rc6-00508-gd6da3dbaef57-dirty (Jan
> 20 2025 - 12:11:05 -0700)}
> skip False
> U-Boot> setenv autoload no
> U-Boot> U-Boot> dhcp
> Waiting for Ethernet connection... done.
> BOOTP broadcast 1
> DHCP client bound to address 192.168.4.50 (4 ms)
> U-Boot> U-Boot> echo $bootfile
>=20
> U-Boot> U-Boot> setenv pxefile_addr_r 10000000
> U-Boot> U-Boot> pxe get
> missing environment variable: pxeuuid
> Retrieving file: pxelinux.cfg/01-b8-27-eb-b4-f9-f2
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/01-b8-27-eb-b4-f9-f2'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A80432
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A80432'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A8043
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A8043'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A804
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A804'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A80
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A80'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A8
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A8'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0A
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0A'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C0
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C0'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/C
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/C'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/default-arm-bcm283x-rpi
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default-arm-bcm283x-rpi'.
> Load address: 0x10000000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Retrieving file: pxelinux.cfg/default-arm-bcm283x
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default-arm-bcm283x'.
> Load address: 0x10000000
> Loading: ##################################################  64 Bytes
> 4.9 KiB/s
> done
> Bytes transferred =3D 64 (40 hex)
> Config file '<NULL>' found
> U-Boot> U-Boot> pxe boot 10000000
> Retrieving file: pxelinux.cfg/default-arm
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default-arm'.
> Load address: 0x10000044
> Loading: ##################################################  349 Bytes
> 30.3 KiB/s
> done
> Bytes transferred =3D 349 (15d hex)
> Retrieving file: pxelinux.cfg/default
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default'.
> Load address: 0x100001a4
> Loading: ##################################################  108 Bytes
> 9.8 KiB/s
> done
> Bytes transferred =3D 108 (6c hex)
> Linux boot selections
> 1: Boot kernel
> 2: Invalid boot
> 3: Local boot
> 4: Empty boot
> Enter choice: 3
> 3: Local boot
> missing environment variable: localcmd
> U-Boot> pxe boot 10000000
> Retrieving file: pxelinux.cfg/default-arm
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default-arm'.
> Load address: 0x10000044
> Loading: ##################################################  349 Bytes
> 19.5 KiB/s
> done
> Bytes transferred =3D 349 (15d hex)
> Retrieving file: pxelinux.cfg/default
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'pxelinux.cfg/default'.
> Load address: 0x100001a4
> Loading: ##################################################  108 Bytes
> 9.8 KiB/s
> done
> Bytes transferred =3D 108 (6c hex)
> Linux boot selections
> 1: Boot kernel
> 2: Invalid boot
> 3: Local boot
> 4: Empty boot
> Enter choice: 4
> 4: Empty boot
> No kernel given, skipping boot
> 1: Boot kernel
> Retrieving file: Image
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'Image'.
> Load address: 0x80000
> Loading: ##################################################  6 Bytes
> 0 Bytes/s
> done
> Bytes transferred =3D 6 (6 hex)
> Retrieving file: rootfs.cpio.gz.u-boot
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'rootfs.cpio.gz.u-boot'.
> Load address: 0x2700000
> Loading: ##################################################  30.6 MiB
> 995.1 KiB/s
> done
> Bytes transferred =3D 32123014 (1ea2886 hex)
> Retrieving file: system.dtb
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'system.dtb'.
> Load address: 0x2600000
> Loading: ##################################################  11 Bytes
> 1000 Bytes/s
> done
> Bytes transferred =3D 11 (b hex)
> zimage: Bad magic!
> 2: Invalid boot
> Retrieving file: kernels/install.bin
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.4.1; our IP address is 192.168.4.50
> Filename 'kernels/install.bin'.
> Load address: 0x80000
> Loading: *
> TFTP error: 'File not found' (1)
> Not retrying...
> Skipping install for failure retrieving kernel
> 3: Local boot
> missing environment variable: localcmd
> U-Boot> F
>=20
> Do you have a passing run I could compare against, and/or a boardenv
> file that works?

I didn't test this on 32bit ARM, only 64bit. For Pi 3:

env__net_uses_usb =3D True

env__net_dhcp_server =3D True

env__tftp_boot_test_skip =3D False

env__net_tftp_bootable_file =3D {
    'fn': 'v6.6/image.fit.nocomp',
    'addr': 0x00200000,
    'size': 85984256,
    'crc32': '754c839a',
    'pattern': 'Linux',
    'config': 'conf-852',
}

# Details regarding a file that may be read from a TFTP server. This variab=
le
# may be omitted or set to None if PXE testing is not possible or desired.
env__net_pxe_bootable_file =3D {
    'fn': 'default',
    'addr': 0x00200000,
    'size': 64,
    'timeout': 50000,
    'pattern': 'Linux',
    'valid_label': '1',
    'invalid_label': '2',
    'exp_str_invalid': 'Skipping install for failure retrieving',
    'local_label': '3',
    'exp_str_local': 'missing environment variable: localcmd',
    'empty_label': '4',
    'exp_str_empty': 'No kernel given, skipping boot',
}

# False or omitted if a PXE boot test should be tested.
# If PXE boot testing is not possible or desired, set this variable to True.
# For example: If pxe configuration file is not proper to boot
env__pxe_boot_test_skip =3D False

And:
$ cat /srv/tftp/pxelinux.cfg/default
label Linux
    menu label Boot kernel
    kernel Image
    fdt system.dtb
    initrd rootfs.cpio.gz.u-boot
$ cat /srv/tftp/pxelinux.cfg/default-arm
menu title Linux boot selections
menu include pxelinux.cfg/default

label install
    menu label Invalid boot
    kernel kernels/install.bin
    append console=3DttyAMA0,38400 debug earlyprintk
    initrd initrds/uzInitrdDebInstall

label local
    menu label Local boot
    append root=3D/dev/sdb1
    localboot 1

label boot
    menu label Empty boot
$ cat /srv/tftp/pxelinux.cfg/01-b8-27-eb-fc-64-a6
menu include pxelinux.cfg/default-arm
timeout 50

default Linux

And kernels/install.bin, etc, do not exist. Only v6.6/image.fit.nocomp
exists.=20

--=20
Tom

--26M42XUs2xtcMj3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeO3+4ACgkQFHw5/5Y0
tyw++gv/Z5k+E70gQh63acs/Okd7CkEtJf0RaZzQlSa2igqNX1JxK45377iPktzI
jrqyrqBwXYkKjRBWe1yWccNTYq4fM0vl49PIRQp2No2YbS57Tywy2uvMHkanuMx3
oEnjtkns5eXX3Z+6fh1PcAzRhHV/r+P4G6cB7pGOTES6suvaN9SZKAy0OFWlHujU
IeOS/ejyppnw5J98rcET6YmAUS3A/EhXR0BUpMMsz72A6hnWsI42NuO5qD1GUfqo
ytPKj3ooiKAZYjTvST3GyeBHUzK6RfMYvy6X05KAazk4dPbK2Zlr+s983YpTmSMG
Eaiod6kVAENZMUrKVwpxraz1R0Cls0ZlkDElBf995LxtsKP0CbnaFTOu7SCSFWXK
jyATT1df8I+nslebpU/7+KnsfvMsM1buwX0XVyN7fbIEmU3wm5S47TPUzEnjs0Sd
nlTKAJaP4yFV/kXrs845LYfHVjFtHt8XkotBrw928Dl4qvCNYJ4fhdD8gnlRQUIQ
u4K/l/tW
=bjhi
-----END PGP SIGNATURE-----

--26M42XUs2xtcMj3d--
