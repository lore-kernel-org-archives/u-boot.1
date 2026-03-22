Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2287AD58CA0
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 20:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3504283FBC;
	Sun, 22 Mar 2026 21:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I0x1OnEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D9983FC6; Sun, 22 Mar 2026 21:07:01 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040A28366F
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 21:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso465854366b.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 13:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774210018; cv=none;
 d=google.com; s=arc-20240605;
 b=GMlbN6F5ctaJ0jjrm+l+q5rwj7YyQpOPe6TS6Vmu57m++ix5Mo+8jOEmyC6EDD2PEI
 Hpv5PmyUcCZLBHX6gAFFq50Kf7jvziHRIljKyltvyoF//eGaG6VUDpJ3r8VEr+QUG92b
 4hZ6VuOTv00C83dMP1kPTD79qoYpVuyW+/7S/9VUGxNqb/wurqCAy5bI9ePvt0A9xsxP
 F227Ev/eOF1nOx/sy8X4oAts5686A7qWtKHan8JiX7ztfQOi8ru+pYUWgQgIyCCUjulE
 ED/jxmZdR4Adcdzf1iUXKaTDByvqeoJNu1RphXj8WRZYDtCwj/zyVmRVa9pHj9Ko/NYF
 ymlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V+En6DMZjFegEve9MsTm13ur5VPDXSIxVDPHehv2WHk=;
 fh=s97ghWUoCYEmx5lTBn419V0zqGqvWBnKS6Gb6QZlrbI=;
 b=T1kgi3faOM8b05Nvpq7FS59L+aFBKH/XaOWZKzrX7NdZ/OspXtT7H3PM8XZCaxJaU6
 t65noeD5vyOUGb+3CtflZVOtkfQ0dgvB2TrNL5IVSRtAM1YRF36UnYQjHoqQrFXVy3dc
 kcnDm44q6pUHBz9aLxG4vx6O1pDwWlWKOZXJ5hLf2Ly+QMSe7sMjQvOgAZCncurNek5K
 x4+/HesdB3Wp8QHDZDsmCFycPgWaC8vrqJIOEpHLu53pstpzOJCf20A+1Yy6+RhP1zxf
 g7hyzf3t0L1xeR078l1RXiVxOWRn3mqHBdXVn+DUBcLqBa4dqsBFjtxF6YHcD/THBLyN
 SSMg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774210018; x=1774814818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+En6DMZjFegEve9MsTm13ur5VPDXSIxVDPHehv2WHk=;
 b=I0x1OnEIZFXR3Z/B1tvGo0zCyH52FLtEievetujrJl0En53XeP1JTcx5KSfG8RJ8wx
 kowmE0sXEGs+TQyHa737HwCpe9h6a/Zu+6HAcirEmFnE0o9HcfkKXKDbHi6YZ964ddXU
 Z4tQgYfRGDfEeOKTVyNe8grOpLA+dcbZnjUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774210018; x=1774814818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V+En6DMZjFegEve9MsTm13ur5VPDXSIxVDPHehv2WHk=;
 b=YI7HlZpImNhofGsVGCIlWEPLV1Qb0VYPWgjFXZbFMWIrDZL7/FZsH9izLgD9OkPRmB
 lT1cycPv5zZ14P6cwtcUWK/gX46l7Gvp+I52cv9y99kbRq5ktZ7LJqNiefg7pKMeZAX7
 imLKlHHYfdNvnovTO+UMTEfzidNuYAtU6IxOYvtuW/FZBQ+xTW34vOOGSNE1oWYGHuHK
 pYy6Lcv+vdRb7dFFYHWG4OnIPzyhTbkAQ/O7kG/r3Xfkb8Kwug8wXvJIGbOZ8S34ZvYe
 9u20hzbypu4ctnptkLm/fFjiZexKkbC0Akt/MUFpKzjt73KP4EtyzKoP60GOAEGZnXno
 l5WA==
X-Gm-Message-State: AOJu0Yzjnt9U+00VvgbmVy0Ba+oowZUA4zLaOeHwI+qBKEJCc+hl4u9+
 aEH+fhl0Xra5swPmfPHQuOAixpfsMav1Em+MIidJSyCWunvhebwd3BDYE0URSqWz+Qt2xy/dtal
 KLki7Y91gMpKy1Rb8P7UpeFKRatgCcBms8J+uXY93
X-Gm-Gg: ATEYQzz99EduwiJg+IlnbD7BH8GVawBB06uWN3oB3H3Lhc8cMLxzck18qQk41gzdTY8
 TCPK0ACW13U0xWQhUI/BURMh3bZIfB12dwY2JOoeJpA8qrUE49IWXxEKdreOiJ02JrDP07V73IK
 MJ4lZ1aLl3ZJtJl1/FLUrogf0OtELbxTng6Ntei4ndXPl2oQ5ggaiXXCL53vhePBa/eZoNJPW+k
 caraFEWyyd8q67reJ9AgRiD0XbiBe6jCrZZPIW9fdjCTtD6UcORLBbqjhh7BhiYdmnXO26idmX2
 B83Nzzk=
X-Received: by 2002:a17:907:76c6:b0:b93:9ac0:7913 with SMTP id
 a640c23a62f3a-b982f303a4fmr544379066b.35.1774210018214; Sun, 22 Mar 2026
 13:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANRoWwhdatirL6V=xptv-ZYW_fLqYc+QzUgktGTTc187nHRgpg@mail.gmail.com>
 <CANRoWwjZeMXpOaDw-CCw-24mPCGEo6Y45VeHrgrx_KKeJiPxXg@mail.gmail.com>
In-Reply-To: <CANRoWwjZeMXpOaDw-CCw-24mPCGEo6Y45VeHrgrx_KKeJiPxXg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 22 Mar 2026 14:06:44 -0600
X-Gm-Features: AaiRm52E_KZaY_wUdSpJRpRiVhGrDhwM1ZK7hEcjmZVOwx4spGIN9wtw306qCWY
Message-ID: <CAFLszTheWP_64DV0guR7XnTmuFdVR_aU=GKPrCxs8utvgdjLKw@mail.gmail.com>
Subject: Re: [HELP needed] bootstd EFI bootmeth over the network
To: =?UTF-8?B?UnlhbiBQZXJzw6ll?= <ryan.persee@gmail.com>
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

Hi Ryan,

On Sun, 22 Mar 2026 at 10:09, Ryan Pers=C3=A9e <ryan.persee@gmail.com> wrot=
e:
>
> Hello!
>
> I'm a bit stuck on this. Does anyone have any idea what I might be doing
> wrong? Any suggestions on how to make it work would be really appreciated=
!
>
> Thanks.

This is most likely a bug in the network path of the EFI bootmeth. The
qemu_arm64 target has CONFIG_OF_HAS_PRIOR_STAGE enabled (since QEMU
provides the device tree), and when fdtfile is not set,
efi_get_distro_fdt_name() returns -EALREADY to indicate the
prior-stage FDT should be used. The block-device EFI path handles this
correctly, but the network path treats it as a fatal error.

I suspect the -22 (-EINVAL) you saw initially is because fdt_addr_r is
checked before we even determine whether a FDT download is needed.

As a workaround, setting the fdtfile env var to any value should get
past this (the TFTP download of the FDT will fail but that is handled
gracefully). E.g.:

   env set fdtfile dummy.dtb

I'll send a patch to fix this properly.

Regards,
Simon


>
> Le lun. 9 mars 2026, 22:45, Ryan Pers=C3=A9e <ryan.persee@gmail.com> a =
=C3=A9crit :
>
> > Hello,
> >
> > As the title says, I'm trying to get u-boot to discover and boot an EFI
> > application (iPXE) over the network with DHCP+TFTP.
> > I can get the EFI application to start if I run commands (bootflow scan=
 +
> > bootefi) manually, but after reading the documentation, I expected u-bo=
ot
> > to automatically register a bootflow after the scan, and run it
> > automatically.
> >
> > ## Environment
> >
> > - U-Boot version: U-Boot 2026.01 (compiled from sources)
> > - Target: qemu_arm64
> > - EFI-related bootmeths present (from `bootmeth list`):
> >   ```text
> >   =3D> bootmeth list
> >   Order  Seq  Name                Description
> >   -----  ---  ------------------  ------------------
> >       0    0  extlinux            Extlinux boot from a block device
> >       1    1  script              Script boot from a block device
> >    glob    2  efi_mgr             EFI bootmgr flow
> >       3    3  efi                 EFI boot from an .efi file
> >       4    4  qfw                 QEMU boot using firmware interface
> >       5    5  pxe                 PXE boot from a network device
> >    glob    6  vbe_simple          VBE simple
> >   -----  ---  ------------------  ------------------
> >   (7 bootmeths)
> >   ```
> > - To narrow down the issue, I restricted bootmeths to only the EFI load=
er:
> >   ```text
> >   =3D> bootmeth order efi
> >   =3D> bootmeth list
> >   Order  Seq  Name                Description
> >   -----  ---  ------------------  ------------------
> >       0    3  efi                 EFI boot from an .efi file
> >   -----  ---  ------------------  ------------------
> >   (1 bootmeth)
> >   ```
> >
> > ## Network/TFTP setup
> >
> > - DHCP/TFTP server: `dnsmasq` on the host
> > - For ARM64 EFI clients (DHCP option 93 =3D 11), dnsmasq returns the
> > bootfile `arm64-efi/snp.efi`:
> >   ```ini
> >   dhcp-match=3Dset:arm64efi,option:client-arch,11
> >   enable-tftp
> >   tftp-root=3D/var/lib/tftpboot
> >
> >   dhcp-boot=3Dtag:arm64efi,arm64-efi/snp.efi
> >   ```
> > - File on disk:
> >   ```bash
> >   $ file /var/lib/tftpboot/arm64-efi/snp.efi
> >   /var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
> > (application), ARM64, 6 sections
> >   ```
> >
> > So the TFTP payload appears to be a valid ARM64 EFI application.
> >
> > ## Steps to reproduce
> >
> > 1. Start QEMU with `qemu_arm64` and virtio-net pointing to the
> > dnsmasq/TFTP server.
> > 2. Interrupt autoboot to get a U-Boot prompt.
> > 3. Ensure only the `efi` bootmeth is active:
> >    ```bash
> >    bootmeth order efi
> >    bootmeth list
> >    ```
> > 4. Set `fdt_addr_r`:
> >    ```bash
> >    env set fdt_addr_r 0x44000000
> >    ```
> > 5. Run a full bootflow scan with errors shown:
> >    ```bash
> >    bootflow scan -lae
> >    ```
> >
> > (Initially, before setting `fdt_addr_r`, I saw `err=3D-22` on the netwo=
rk
> > bootflow; after setting `fdt_addr_r` that changed to `err=3D-114` =E2=
=80=94 see logs
> > below.)
> >
> > ## Observed behavior
> >
> > ### Before setting `fdt_addr_r` (for context)
> >
> > When I first ran `bootflow scan -lae` with only `efi` enabled and **no*=
*
> > `fdt_addr_r` in the environment, I saw:
> >
> > ```text
> > Scanning bootdev 'virtio-net#32.bootdev':
> > BOOTP broadcast 1
> > DHCP client bound to address 172.18.0.243 (2 ms)
> > Using virtio-net#32 device
> > TFTP from server 172.18.0.2; our IP address is 172.18.0.243
> > Filename 'arm64-efi/snp.efi'.
> > Load address: 0x40400000
> > Loading: #####################
> >          11.7 MiB/s
> > done
> > Bytes transferred =3D 305664 (4aa00 hex)
> >   6  efi          base    ethernet     0  virtio-net#32.bootdev.0
> > arm64-efi/snp.efi
> >      ** No media/partition found, err=3D-22
> > ...
> > (7 bootflows, 0 valid)
> > ```
> >
> > So:
> > - DHCP and TFTP succeed.
> > - `bootfile` is `arm64-efi/snp.efi`.
> > - A bootflow entry is created but stays in `base` state and has `err=3D=
-22`.
> > - No bootflows are considered valid.
> >
> > ### After setting `fdt_addr_r`
> >
> > After:
> >
> > ```bash
> > env set fdt_addr_r 0x44000000
> > bootflow scan -lae
> > ```
> >
> > I now get:
> >
> > ```text
> > Scanning for bootflows in all bootdevs
> > Seq  Method       State   Uclass    Part  Name
> >  Filename
> > ---  -----------  ------  --------  ----  ------------------------
> >  ----------------
> > Scanning bootdev 'fw-cfg@9020000.bootdev':
> >   0  efi          base    qfw          0  <NULL>
> >      ** No media/partition found, err=3D-524
> > Scanning bootdev 'usb_mass_storage.lun0.bootdev':
> >   1  efi          media   usb_mass_    0  usb_mass_storage.lun0.boo
> >      ** No partition found, err=3D-2
> >   2  efi          media   usb_mass_    1  usb_mass_storage.lun0.boo
> >      ** No partition found, err=3D-2
> >   3  efi          media   usb_mass_    2  usb_mass_storage.lun0.boo
> >      ** No partition found, err=3D-2
> >   4  efi          media   usb_mass_    3  usb_mass_storage.lun0.boo
> >      ** No partition found, err=3D-2
> > Scanning bootdev 'virtio-blk#35.bootdev':
> >   5  efi          media   virtio       0  virtio-blk#35.bootdev.who
> >      ** No partition found, err=3D-93
> > Scanning bootdev 'virtio-net#32.bootdev':
> > BOOTP broadcast 1
> > DHCP client bound to address 172.18.0.243 (2 ms)
> > Using virtio-net#32 device
> > TFTP from server 172.18.0.2; our IP address is 172.18.0.243
> > Filename 'arm64-efi/snp.efi'.
> > Load address: 0x40400000
> > Loading: #####################
> >          4.9 MiB/s
> > done
> > Bytes transferred =3D 305664 (4aa00 hex)
> >   6  efi          base    ethernet     0  virtio-net#32.bootdev.0
> > arm64-efi/snp.efi
> >      ** No media/partition found, err=3D-114
> > No more bootdevs
> > ---  -----------  ------  --------  ----  ------------------------
> >  ----------------
> > (7 bootflows, 0 valid)
> > ```
> >
> > So with `fdt_addr_r` set:
> >
> > - DHCP and TFTP still succeed; the same EFI binary is downloaded.
> > - The bootflow for `virtio-net#32.bootdev.0` stays in `base` state, now
> > with `err=3D-114`.
> > - There are still `(0 bootflows, 0 valid)`.
> > - No attempt to actually execute the downloaded EFI application is visi=
ble
> > on the console.
> >
> > Separately, `file(1)` on the TFTP payload shows:
> >
> > ```text
> > /var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
> > (application), ARM64, 6 sections
> > ```
> >
> > ## Expected behavior
> >
> > Given that:
> >
> > - The EFI bootmeth (`efi`) is present and enabled.
> > - The network bootdev (`virtio-net#32.bootdev`) successfully completes
> > DHCP and downloads the bootfile.
> > - The bootfile is a PE32+ ARM64 EFI application on disk.
> >
> > I expected:
> >
> > - A bootflow for `virtio-net#32` to reach a =E2=80=9Cready=E2=80=9D or =
equivalent state
> > (i.e. no error), and
> > - `bootflow scan -b` to attempt to execute the downloaded EFI applicati=
on
> > via the EFI loader.
> >
> > Instead, the bootflow remains in `base` state with `err=3D-22` (before
> > setting `fdt_addr_r`) or `err=3D-114` (after setting `fdt_addr_r`), and=
 is
> > not considered valid, so it never gets booted.
> >
> > ## Notes
> >
> > - This is all on QEMU (`qemu_arm64`), but my end goal is to use the EFI
> > bootmeth to automatically boot into iPXE on real ARM64 hardware using t=
he
> > same network flow.
> > - Running `bootefi` manually after DHCP+TFTP fetched the file does work=
:
> > ```text
> > =3D> bootefi 0x40400000
> > Booting /arm64-efi\snp.efi
> > iPXE initialising devices...
> >
> >
> >
> > iPXE 1.0.0+ -- Open Source Network Boot Firmware -- https://ipxe.org
> > Features: DNS FTP HTTP HTTPS iSCSI NFS TFTP VLAN AoE EFI Menu
> >
> > net0: 52:54:00:12:34:56 using SNP on SNP-0xbe690010 (Ethernet) [open]
> >   [Link:up, TX:0 TXE:0 RX:0 RXE:0]
> > Configuring (net0 52:54:00:12:34:56)...... ok
> > net0: 172.18.0.243/255.255.0.0 gw 172.18.0.1
> > net0: fe80::5054:ff:fe12:3456/64
> > Next server: 172.18.0.2
> > ...
> > ```
> >
> > Can you please help me on this? And/or explain what I'm doing wrong?
> >
> > Kind regards.
> >
