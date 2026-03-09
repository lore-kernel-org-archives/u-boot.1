Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79FDFCA19A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D27183F82;
	Mon,  9 Mar 2026 23:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGRmweiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F32E83CF3; Mon,  9 Mar 2026 22:46:06 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A112C839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan.persee@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso4627131e87.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773092762; cv=none;
 d=google.com; s=arc-20240605;
 b=ayPZXZwnOfPAUjWvTmkPCjpfvjPs9WWvGYj1wMCAs5hGSj9MbXYQLFneAnp2xGW0Ln
 HG57Ce0WYIWm02OUmQ1gO+NlRO5orzX32RqRoTspEiY9zHybUFErbrPGUtwgtXXZHr5y
 g87cRpc+brsbhEgkOAS5Exousg030OYWXzXN2XeVXzQJ6011AKFnvRC5dwi3TY6aeVBQ
 HZnkVYz+8v3LJf/1E0lleJJJWsyJ7T1TPr4tfxNmrxzfQUScvDxAhREcDwLO273qH/r7
 Ry6ITSBp/nyCNhO75gpAyj78ofFhlGThZOfZQIA4mx70ihOWK0UfeDIo4Gzb2eWCof8o
 aPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yR0ZwrUWduG8wz6+LO2G5tFiToBWwg8egX7xtFo5fUs=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=EJ36Mo9o6zgtDH0e1pdH8rJwmOmYJneFioRIYQn81vcgO3Pma282fo4IBPLZk0oCpf
 XK3b6RipsQmZMu64ZRnh3DUM/NIm6h7YegsP7dl3xGfLRjgaccNs4ItlQi8fb0e+Hqfw
 ANIpSZCS28euvsc/LgeLOfH2IEg4Z+ipOz8SopQREYzjFcSmu1i5ph8vACn4XVyQlRJZ
 R5qmXlobZwysR9razY7TOeCl5tWx9AjYOcZa0wobJUyaH4msvssvgp2Jv2YeTXqDhcfg
 hNe5QmyOurtpcj70WKvZub3b+HHSIIQXX4szvn7/EFWv2RedICBPdUojI9CuM3ayA267
 Mk5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092762; x=1773697562; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yR0ZwrUWduG8wz6+LO2G5tFiToBWwg8egX7xtFo5fUs=;
 b=UGRmweiHImY4/Db3xh5awa/MtIlu3jseqHBuKjBtAZ6aJ6aLHOijABQK80YbAESgZm
 eVhsxBnJkNSynjHWDfJf50HYkvIIVlvMoyzh0Bo9TJI0I4c1/oghM+tzzfFE5C45X8jW
 G7772Lvj/FcF8zZFAybQ3yX0KW4E2Ue+JN8hwq01IuffRZuJQRfkKfmx37QaK2hojpEI
 juFrugyxk02MVa/x5yrOCZNlrYQFlrb0MM7Iz78f90YFJWMqVHaAtat+5um0a06t7AaF
 AuxWyE5iNu3klTrlWXve5BumznwBjz67wNxKxPr2cMDsnHEnhI2iEKB7j1xD+A7ek6Wy
 ex/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092762; x=1773697562;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yR0ZwrUWduG8wz6+LO2G5tFiToBWwg8egX7xtFo5fUs=;
 b=nJ+hJvrNX1X9Xc5sr7pJzy28rS/Ap12EGILZkQHuUqPnuRKXkz+SfAj3QG1Pzeunmz
 PQgaFtl6YwAL/H6StY1ol5OwWBbepaOk4XhTu4skDDEgSA69WGdi/V78ZrOrwyp1PB4y
 dmvxaHIfY19Ba9StVOncAlnuuavVVAXhOna3yd9Mxdj/QqeQKwY4j9fK4TAWIz35kozO
 bIJcc6gisijDx7h24G6ZsMvNTk+RUtGLpvVoqoGqK9CWqKtrWLIS173Mqe3Znt/ls8o6
 PEee6vz2OHGUlkoohxYpbmFD/pnfx3EfGkURTAt8hxc1hIglYgeDttTuMINh4SIUEywG
 Wu1w==
X-Gm-Message-State: AOJu0YwOYrZzS8YWZX3oGbHY5DH5z1PfVhxpxv5W7BW5Tauo5fKsRbOV
 61YYGkSUDKbtlUvCKLAS8W7p6JnGBlRpS+Rk7VewclVKPU9GIxEpER9ZGYWhIkRaHSbXctn/Tnz
 lvsDj9yRHR/HuQABqWRSXpL6yxRCLQMw/kGwacU0=
X-Gm-Gg: ATEYQzxdN935k6nHeKIzvDELFVNdamYkjzdkNSU2jwIOWfcAuq0idqoPxGfcnCB7a4q
 C+a93zKcKj/wwS5uZXcq8Kty/5ba3QxsPliUiN5biXnUxtcDyAQChpxPTKwlmrc8FKP6jeBqFWk
 ymgvzEFrtXNStts3imhcsjFsmzCO6VDTQWfd5DhnXlUm562NpwgJA9Cc9H1f8pWTKhkEgbW9sxP
 2bQhk9kgPdl8+N9t2BfT5FnHKjEXn4IbQDxKwYgscDeN3KuZID1JbLCFhg1gDUYsx1YFr5i4vZo
 bvjR73czy2umSdslooQCMfDcWpHEfS2xGEi1GRM9q1fNqjIZsHdE
X-Received: by 2002:a05:6512:24dc:b0:5a0:f95a:1602 with SMTP id
 2adb3069b0e04-5a13cabe8eamr2845902e87.17.1773092761954; Mon, 09 Mar 2026
 14:46:01 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?UnlhbiBQZXJzw6ll?= <ryan.persee@gmail.com>
Date: Mon, 9 Mar 2026 22:45:50 +0100
X-Gm-Features: AaiRm521ULFVxV1CC7HF9_SgWi9XB1ewg2cgdAKaUrQru0klsoCPxkL6z08Fhn8
Message-ID: <CANRoWwhdatirL6V=xptv-ZYW_fLqYc+QzUgktGTTc187nHRgpg@mail.gmail.com>
Subject: =?UTF-8?Q?bootstd_EFI_bootmeth=3A_network_bootflow_downloads_EFI?=
 =?UTF-8?Q?_app_but_never_becomes_valid_=28err_=E2=80=9122=2F=E2=80=91114=29_on_qemu=5Farm6?=
 =?UTF-8?Q?4?=
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 09 Mar 2026 23:14:36 +0100
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

Hello,

As the title says, I'm trying to get u-boot to discover and boot an EFI
application (iPXE) over the network with DHCP+TFTP.
I can get the EFI application to start if I run commands (bootflow scan +
bootefi) manually, but after reading the documentation, I expected u-boot
to automatically register a bootflow after the scan, and run it
automatically.

## Environment

- U-Boot version: U-Boot 2026.01 (compiled from sources)
- Target: qemu_arm64
- EFI-related bootmeths present (from `bootmeth list`):
  ```text
  =3D> bootmeth list
  Order  Seq  Name                Description
  -----  ---  ------------------  ------------------
      0    0  extlinux            Extlinux boot from a block device
      1    1  script              Script boot from a block device
   glob    2  efi_mgr             EFI bootmgr flow
      3    3  efi                 EFI boot from an .efi file
      4    4  qfw                 QEMU boot using firmware interface
      5    5  pxe                 PXE boot from a network device
   glob    6  vbe_simple          VBE simple
  -----  ---  ------------------  ------------------
  (7 bootmeths)
  ```
- To narrow down the issue, I restricted bootmeths to only the EFI loader:
  ```text
  =3D> bootmeth order efi
  =3D> bootmeth list
  Order  Seq  Name                Description
  -----  ---  ------------------  ------------------
      0    3  efi                 EFI boot from an .efi file
  -----  ---  ------------------  ------------------
  (1 bootmeth)
  ```

## Network/TFTP setup

- DHCP/TFTP server: `dnsmasq` on the host
- For ARM64 EFI clients (DHCP option 93 =3D 11), dnsmasq returns the bootfi=
le
`arm64-efi/snp.efi`:
  ```ini
  dhcp-match=3Dset:arm64efi,option:client-arch,11
  enable-tftp
  tftp-root=3D/var/lib/tftpboot

  dhcp-boot=3Dtag:arm64efi,arm64-efi/snp.efi
  ```
- File on disk:
  ```bash
  $ file /var/lib/tftpboot/arm64-efi/snp.efi
  /var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
(application), ARM64, 6 sections
  ```

So the TFTP payload appears to be a valid ARM64 EFI application.

## Steps to reproduce

1. Start QEMU with `qemu_arm64` and virtio-net pointing to the dnsmasq/TFTP
server.
2. Interrupt autoboot to get a U-Boot prompt.
3. Ensure only the `efi` bootmeth is active:
   ```bash
   bootmeth order efi
   bootmeth list
   ```
4. Set `fdt_addr_r`:
   ```bash
   env set fdt_addr_r 0x44000000
   ```
5. Run a full bootflow scan with errors shown:
   ```bash
   bootflow scan -lae
   ```

(Initially, before setting `fdt_addr_r`, I saw `err=3D-22` on the network
bootflow; after setting `fdt_addr_r` that changed to `err=3D-114` =E2=80=94=
 see logs
below.)

## Observed behavior

### Before setting `fdt_addr_r` (for context)

When I first ran `bootflow scan -lae` with only `efi` enabled and **no**
`fdt_addr_r` in the environment, I saw:

```text
Scanning bootdev 'virtio-net#32.bootdev':
BOOTP broadcast 1
DHCP client bound to address 172.18.0.243 (2 ms)
Using virtio-net#32 device
TFTP from server 172.18.0.2; our IP address is 172.18.0.243
Filename 'arm64-efi/snp.efi'.
Load address: 0x40400000
Loading: #####################
         11.7 MiB/s
done
Bytes transferred =3D 305664 (4aa00 hex)
  6  efi          base    ethernet     0  virtio-net#32.bootdev.0
arm64-efi/snp.efi
     ** No media/partition found, err=3D-22
...
(7 bootflows, 0 valid)
```

So:
- DHCP and TFTP succeed.
- `bootfile` is `arm64-efi/snp.efi`.
- A bootflow entry is created but stays in `base` state and has `err=3D-22`=
.
- No bootflows are considered valid.

### After setting `fdt_addr_r`

After:

```bash
env set fdt_addr_r 0x44000000
bootflow scan -lae
```

I now get:

```text
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
 ----------------
Scanning bootdev 'fw-cfg@9020000.bootdev':
  0  efi          base    qfw          0  <NULL>
     ** No media/partition found, err=3D-524
Scanning bootdev 'usb_mass_storage.lun0.bootdev':
  1  efi          media   usb_mass_    0  usb_mass_storage.lun0.boo
     ** No partition found, err=3D-2
  2  efi          media   usb_mass_    1  usb_mass_storage.lun0.boo
     ** No partition found, err=3D-2
  3  efi          media   usb_mass_    2  usb_mass_storage.lun0.boo
     ** No partition found, err=3D-2
  4  efi          media   usb_mass_    3  usb_mass_storage.lun0.boo
     ** No partition found, err=3D-2
Scanning bootdev 'virtio-blk#35.bootdev':
  5  efi          media   virtio       0  virtio-blk#35.bootdev.who
     ** No partition found, err=3D-93
Scanning bootdev 'virtio-net#32.bootdev':
BOOTP broadcast 1
DHCP client bound to address 172.18.0.243 (2 ms)
Using virtio-net#32 device
TFTP from server 172.18.0.2; our IP address is 172.18.0.243
Filename 'arm64-efi/snp.efi'.
Load address: 0x40400000
Loading: #####################
         4.9 MiB/s
done
Bytes transferred =3D 305664 (4aa00 hex)
  6  efi          base    ethernet     0  virtio-net#32.bootdev.0
arm64-efi/snp.efi
     ** No media/partition found, err=3D-114
No more bootdevs
---  -----------  ------  --------  ----  ------------------------
 ----------------
(7 bootflows, 0 valid)
```

So with `fdt_addr_r` set:

- DHCP and TFTP still succeed; the same EFI binary is downloaded.
- The bootflow for `virtio-net#32.bootdev.0` stays in `base` state, now
with `err=3D-114`.
- There are still `(0 bootflows, 0 valid)`.
- No attempt to actually execute the downloaded EFI application is visible
on the console.

Separately, `file(1)` on the TFTP payload shows:

```text
/var/lib/tftpboot/arm64-efi/snp.efi: PE32+ executable for EFI
(application), ARM64, 6 sections
```

## Expected behavior

Given that:

- The EFI bootmeth (`efi`) is present and enabled.
- The network bootdev (`virtio-net#32.bootdev`) successfully completes DHCP
and downloads the bootfile.
- The bootfile is a PE32+ ARM64 EFI application on disk.

I expected:

- A bootflow for `virtio-net#32` to reach a =E2=80=9Cready=E2=80=9D or equi=
valent state
(i.e. no error), and
- `bootflow scan -b` to attempt to execute the downloaded EFI application
via the EFI loader.

Instead, the bootflow remains in `base` state with `err=3D-22` (before
setting `fdt_addr_r`) or `err=3D-114` (after setting `fdt_addr_r`), and is
not considered valid, so it never gets booted.

## Notes

- This is all on QEMU (`qemu_arm64`), but my end goal is to use the EFI
bootmeth to automatically boot into iPXE on real ARM64 hardware using the
same network flow.
- Running `bootefi` manually after DHCP+TFTP fetched the file does work:
```text
=3D> bootefi 0x40400000
Booting /arm64-efi\snp.efi
iPXE initialising devices...



iPXE 1.0.0+ -- Open Source Network Boot Firmware -- https://ipxe.org
Features: DNS FTP HTTP HTTPS iSCSI NFS TFTP VLAN AoE EFI Menu

net0: 52:54:00:12:34:56 using SNP on SNP-0xbe690010 (Ethernet) [open]
  [Link:up, TX:0 TXE:0 RX:0 RXE:0]
Configuring (net0 52:54:00:12:34:56)...... ok
net0: 172.18.0.243/255.255.0.0 gw 172.18.0.1
net0: fe80::5054:ff:fe12:3456/64
Next server: 172.18.0.2
...
```

Can you please help me on this? And/or explain what I'm doing wrong?

Kind regards.
