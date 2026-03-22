Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031E7FC72CB
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 16:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16287840AA;
	Sun, 22 Mar 2026 17:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EW6sNKpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EB9840AE; Sun, 22 Mar 2026 17:09:37 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3055284082
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 17:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan.persee@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59dea72099eso2673025e87.0
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 09:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774195774; cv=none;
 d=google.com; s=arc-20240605;
 b=SW3/OPr/0xtzGK1vHMx6ynVwp+Fd0+n3WN1wxoP30VAbGe/WIKkJUJSOnx2s+bW2vw
 0s77p4nU+WbbEHn3LowUD2sXNUTstU4cTJIWTW8I5rKOJZ4MOO5V1Gt7dtUtt0D8CQXh
 dulMyl/8iB837//3o+Xmb6J6oJ8LOFkb4xhauIbzlSYZssrqmHIIdAJaNkShQp5mTXL0
 Tr4M3JfC60fBP4dg4lW6JyNNHsC1Hno5cM+TZMcn813OFNpbCwd52+S9YHs4VuQ6hYR6
 dFzRgXOeAcRXlBJyJxUHn5Abm26K+V1b2MSc8iIGsnx/XgR65UMuA2kendERbBk1bcDk
 ETtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=2KadKMfZXy+81n+QVuCpb7yLN6/7QefY8fZdTL/f2Zw=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=RmNWcmERO4AqWmmRsiu5ONT8n3kJHx5rPMTq0yTNGVe5/kSjWe3zUpK7K1mCOIU51u
 l1IpE/vo43VOZBcFh2bDBNFD6rZuOR6xLvRiF/+aTwsWoOq2O90+0GGRnkqlbM1Vx8yY
 CLyoCZAg1XbvH3ihJInWfOTRgz9NMk5umd5oWLUtMELHM3lQ/wu/Gcb2DMz7Q1eitdYi
 O5RCxamcORxDQsvUOJfrvDBH2cJokd7X3txlUv+JxO741MoQI0z/LKXJajrEkMYfaz5L
 PgxVv8RxRSNKgdJKZMATmu9tJLXn4SusG0c8boAbEeJ6l9yaaU+PX6RtGG4pWELdRPRr
 OFKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774195774; x=1774800574; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KadKMfZXy+81n+QVuCpb7yLN6/7QefY8fZdTL/f2Zw=;
 b=EW6sNKpCcVwFpK/gEY5fuD/CC0Jd+jIOeLWNZ5aX/fKnFEoTPGeMjhJVRRikSyPbmN
 AWtQz0Br6BU4cFmAgOoUaYHoL5GuoyziS7JuKeAAXAcM3KRQ5PW9O1BBvrGFphUtnvXu
 kDDpau4tbuFAAdvuRtF3SBOxYRHHQEwd5t9pX8R3J/JsVawOddcR4Qbo/5POmej+wI54
 4tg5s/D5RmE+1GMrJl+64gU85r4a6KQ7B6EPDN0CCXR0R7oQZmTKYBiVoUzbt3GBjpQS
 Iqx5EYGTyFqIGKA1SGPKnW22IYZQV4w2fHXnbnpH0c9Xt3YL7Ueffl9VORu6lbqY6cbY
 hagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774195774; x=1774800574;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KadKMfZXy+81n+QVuCpb7yLN6/7QefY8fZdTL/f2Zw=;
 b=VXQre/W4cKQNNjHYsKtB0kk4A1+X99eJWRcvr+s9or9ljRgkV1KD4ADZ2Pd0vYAPeD
 RUfRx/2q0O8yXTasjeDTHFzgo1h177te4pHnz4ghL+y3bGTjrNoaO85vO0+5h8PAyk5v
 iyXftPJsEmkO99R+Bc65C50O20V88HSfVS3gDvoIGeecQvDClVx427Yi4C03ktKR8kb5
 6yv1vuOvBFkGapazrScoaQSq0ihE+9bRYkL20v13ADUoDdZBRqnlG/eFthHRlCyZtYOq
 0gILpQCm7Hpq1fOEL1ca+TwM3xswT6zN2oHqxrPmrhAmqHJSLPmwMUlN1qhzfE0aws5B
 Gsow==
X-Gm-Message-State: AOJu0YzLWZiiA9wO8cdYeM93W+GhkqoG/Eqzhzaw1jC2P3gxZ8RxnDrK
 G8QdfW0RCBkBKdbNO48322lKbTddfpw2SXyEwwvM2Q8+kX+2wfn9XxtOwUbamkIRVkWQyPDOI9Z
 TjgwUQggnOFxZ4vhRLdUkN1qNZ0iUV7tw6Q==
X-Gm-Gg: ATEYQzyPIAukN+uuQYZGnmzxiS5nASM+h+Qkd10MJPiFem3wqLBoMKhLjVCyU0OnIjf
 enxaZVWn6cubX9hs8CeDvKMPR/oCrMa9WgXPMhX21ppuM34HjmXaB/BHmjdN3bswO0fX/9DTSs4
 CHIOs1WoIdDe3zD5Va9tFImpP5J2rOIGjh5fvJKwG9HR5epZA2wSX3O6hYHU+mUQk4dNLqB9g0s
 fnFGLjaIk4snFVMje+E1m7Gsi26peo8zmGFX/ydRz0g5G1Ngeg7XYKG2GMq3if+5I8xE7YY/oCi
 Ia5/6P4z5oW/y11cyZEjJZMaAdRR77V84Iw=
X-Received: by 2002:a05:6512:3e18:b0:5a1:572f:c45 with SMTP id
 2adb3069b0e04-5a285b046a2mr3155322e87.12.1774195773478; Sun, 22 Mar 2026
 09:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <CANRoWwhdatirL6V=xptv-ZYW_fLqYc+QzUgktGTTc187nHRgpg@mail.gmail.com>
In-Reply-To: <CANRoWwhdatirL6V=xptv-ZYW_fLqYc+QzUgktGTTc187nHRgpg@mail.gmail.com>
From: =?UTF-8?B?UnlhbiBQZXJzw6ll?= <ryan.persee@gmail.com>
Date: Sun, 22 Mar 2026 17:09:24 +0100
X-Gm-Features: AaiRm53CNwj0PF29zZxHFA5uRsHI0mHNZyfvMX2jTk3ZLC-P4VnJIOUmgPlQHf8
Message-ID: <CANRoWwjZeMXpOaDw-CCw-24mPCGEo6Y45VeHrgrx_KKeJiPxXg@mail.gmail.com>
Subject: [HELP needed] bootstd EFI bootmeth over the network
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello!

I'm a bit stuck on this. Does anyone have any idea what I might be doing
wrong? Any suggestions on how to make it work would be really appreciated!

Thanks.

Le lun. 9 mars 2026, 22:45, Ryan Pers=C3=A9e <ryan.persee@gmail.com> a =C3=
=A9crit :

> Hello,
>
> As the title says, I'm trying to get u-boot to discover and boot an EFI
> application (iPXE) over the network with DHCP+TFTP.
> I can get the EFI application to start if I run commands (bootflow scan +
> bootefi) manually, but after reading the documentation, I expected u-boot
> to automatically register a bootflow after the scan, and run it
> automatically.
>
> ## Environment
>
> - U-Boot version: U-Boot 2026.01 (compiled from sources)
> - Target: qemu_arm64
> - EFI-related bootmeths present (from `bootmeth list`):
>   ```text
>   =3D> bootmeth list
>   Order  Seq  Name                Description
>   -----  ---  ------------------  ------------------
>       0    0  extlinux            Extlinux boot from a block device
>       1    1  script              Script boot from a block device
>    glob    2  efi_mgr             EFI bootmgr flow
>       3    3  efi                 EFI boot from an .efi file
>       4    4  qfw                 QEMU boot using firmware interface
>       5    5  pxe                 PXE boot from a network device
>    glob    6  vbe_simple          VBE simple
>   -----  ---  ------------------  ------------------
>   (7 bootmeths)
>   ```
> - To narrow down the issue, I restricted bootmeths to only the EFI loader=
:
>   ```text
>   =3D> bootmeth order efi
>   =3D> bootmeth list
>   Order  Seq  Name                Description
>   -----  ---  ------------------  ------------------
>       0    3  efi                 EFI boot from an .efi file
>   -----  ---  ------------------  ------------------
>   (1 bootmeth)
>   ```
>
> ## Network/TFTP setup
>
> - DHCP/TFTP server: `dnsmasq` on the host
> - For ARM64 EFI clients (DHCP option 93 =3D 11), dnsmasq returns the
> bootfile `arm64-efi/snp.efi`:
>   ```ini
>   dhcp-match=3Dset:arm64efi,option:client-arch,11
>   enable-tftp
>   tftp-root=3D/var/lib/tftpboot
>
>   dhcp-boot=3Dtag:arm64efi,arm64-efi/snp.efi
>   ```
> - File on disk:
>   ```bash
>   $ file /var/lib/tftpboot/arm64-efi/snp.efi
>   /var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
> (application), ARM64, 6 sections
>   ```
>
> So the TFTP payload appears to be a valid ARM64 EFI application.
>
> ## Steps to reproduce
>
> 1. Start QEMU with `qemu_arm64` and virtio-net pointing to the
> dnsmasq/TFTP server.
> 2. Interrupt autoboot to get a U-Boot prompt.
> 3. Ensure only the `efi` bootmeth is active:
>    ```bash
>    bootmeth order efi
>    bootmeth list
>    ```
> 4. Set `fdt_addr_r`:
>    ```bash
>    env set fdt_addr_r 0x44000000
>    ```
> 5. Run a full bootflow scan with errors shown:
>    ```bash
>    bootflow scan -lae
>    ```
>
> (Initially, before setting `fdt_addr_r`, I saw `err=3D-22` on the network
> bootflow; after setting `fdt_addr_r` that changed to `err=3D-114` =E2=80=
=94 see logs
> below.)
>
> ## Observed behavior
>
> ### Before setting `fdt_addr_r` (for context)
>
> When I first ran `bootflow scan -lae` with only `efi` enabled and **no**
> `fdt_addr_r` in the environment, I saw:
>
> ```text
> Scanning bootdev 'virtio-net#32.bootdev':
> BOOTP broadcast 1
> DHCP client bound to address 172.18.0.243 (2 ms)
> Using virtio-net#32 device
> TFTP from server 172.18.0.2; our IP address is 172.18.0.243
> Filename 'arm64-efi/snp.efi'.
> Load address: 0x40400000
> Loading: #####################
>          11.7 MiB/s
> done
> Bytes transferred =3D 305664 (4aa00 hex)
>   6  efi          base    ethernet     0  virtio-net#32.bootdev.0
> arm64-efi/snp.efi
>      ** No media/partition found, err=3D-22
> ...
> (7 bootflows, 0 valid)
> ```
>
> So:
> - DHCP and TFTP succeed.
> - `bootfile` is `arm64-efi/snp.efi`.
> - A bootflow entry is created but stays in `base` state and has `err=3D-2=
2`.
> - No bootflows are considered valid.
>
> ### After setting `fdt_addr_r`
>
> After:
>
> ```bash
> env set fdt_addr_r 0x44000000
> bootflow scan -lae
> ```
>
> I now get:
>
> ```text
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name
>  Filename
> ---  -----------  ------  --------  ----  ------------------------
>  ----------------
> Scanning bootdev 'fw-cfg@9020000.bootdev':
>   0  efi          base    qfw          0  <NULL>
>      ** No media/partition found, err=3D-524
> Scanning bootdev 'usb_mass_storage.lun0.bootdev':
>   1  efi          media   usb_mass_    0  usb_mass_storage.lun0.boo
>      ** No partition found, err=3D-2
>   2  efi          media   usb_mass_    1  usb_mass_storage.lun0.boo
>      ** No partition found, err=3D-2
>   3  efi          media   usb_mass_    2  usb_mass_storage.lun0.boo
>      ** No partition found, err=3D-2
>   4  efi          media   usb_mass_    3  usb_mass_storage.lun0.boo
>      ** No partition found, err=3D-2
> Scanning bootdev 'virtio-blk#35.bootdev':
>   5  efi          media   virtio       0  virtio-blk#35.bootdev.who
>      ** No partition found, err=3D-93
> Scanning bootdev 'virtio-net#32.bootdev':
> BOOTP broadcast 1
> DHCP client bound to address 172.18.0.243 (2 ms)
> Using virtio-net#32 device
> TFTP from server 172.18.0.2; our IP address is 172.18.0.243
> Filename 'arm64-efi/snp.efi'.
> Load address: 0x40400000
> Loading: #####################
>          4.9 MiB/s
> done
> Bytes transferred =3D 305664 (4aa00 hex)
>   6  efi          base    ethernet     0  virtio-net#32.bootdev.0
> arm64-efi/snp.efi
>      ** No media/partition found, err=3D-114
> No more bootdevs
> ---  -----------  ------  --------  ----  ------------------------
>  ----------------
> (7 bootflows, 0 valid)
> ```
>
> So with `fdt_addr_r` set:
>
> - DHCP and TFTP still succeed; the same EFI binary is downloaded.
> - The bootflow for `virtio-net#32.bootdev.0` stays in `base` state, now
> with `err=3D-114`.
> - There are still `(0 bootflows, 0 valid)`.
> - No attempt to actually execute the downloaded EFI application is visibl=
e
> on the console.
>
> Separately, `file(1)` on the TFTP payload shows:
>
> ```text
> /var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
> (application), ARM64, 6 sections
> ```
>
> ## Expected behavior
>
> Given that:
>
> - The EFI bootmeth (`efi`) is present and enabled.
> - The network bootdev (`virtio-net#32.bootdev`) successfully completes
> DHCP and downloads the bootfile.
> - The bootfile is a PE32+ ARM64 EFI application on disk.
>
> I expected:
>
> - A bootflow for `virtio-net#32` to reach a =E2=80=9Cready=E2=80=9D or eq=
uivalent state
> (i.e. no error), and
> - `bootflow scan -b` to attempt to execute the downloaded EFI application
> via the EFI loader.
>
> Instead, the bootflow remains in `base` state with `err=3D-22` (before
> setting `fdt_addr_r`) or `err=3D-114` (after setting `fdt_addr_r`), and i=
s
> not considered valid, so it never gets booted.
>
> ## Notes
>
> - This is all on QEMU (`qemu_arm64`), but my end goal is to use the EFI
> bootmeth to automatically boot into iPXE on real ARM64 hardware using the
> same network flow.
> - Running `bootefi` manually after DHCP+TFTP fetched the file does work:
> ```text
> =3D> bootefi 0x40400000
> Booting /arm64-efi\snp.efi
> iPXE initialising devices...
>
>
>
> iPXE 1.0.0+ -- Open Source Network Boot Firmware -- https://ipxe.org
> Features: DNS FTP HTTP HTTPS iSCSI NFS TFTP VLAN AoE EFI Menu
>
> net0: 52:54:00:12:34:56 using SNP on SNP-0xbe690010 (Ethernet) [open]
>   [Link:up, TX:0 TXE:0 RX:0 RXE:0]
> Configuring (net0 52:54:00:12:34:56)...... ok
> net0: 172.18.0.243/255.255.0.0 gw 172.18.0.1
> net0: fe80::5054:ff:fe12:3456/64
> Next server: 172.18.0.2
> ...
> ```
>
> Can you please help me on this? And/or explain what I'm doing wrong?
>
> Kind regards.
>
