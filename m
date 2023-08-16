Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E693C0015E
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 01:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE2286995;
	Wed, 16 Aug 2023 03:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="calI2sWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142B0867C7; Wed, 16 Aug 2023 03:23:12 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C545886994
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 03:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so841052666b.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692148988; x=1692753788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wfplmyj9Fc/hj8BtnAPD03dsC95Ro1XWbXVIHabFw3Q=;
 b=calI2sWzVGzpVezZzblS88h5NliQrFOIx363sVzf32BmDGR82VCcPVL0tifnmD/B1Q
 qRt9r9FG1vjlkq0KOZHuOyNWI8himaoNgY76LPy/OBOLiggU9qi6faxL1msISyOJElhR
 gV70exYpTSXdxBicNqVA41N9p7fG9h/plj+kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692148988; x=1692753788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wfplmyj9Fc/hj8BtnAPD03dsC95Ro1XWbXVIHabFw3Q=;
 b=Dx9dqasQoVAnv2GF2Vd4ZF6GMe4JcW2Znn3qSTn38l5OEJIEsAE2aH2X1slf+EMkbn
 iDu34M7L1ebIxsJEUF/pXpCGFAWOd9xphY3z4+aRDCoWyrgZXLUuX+5DGQP4bXr6yZbd
 S0Ohm8TcuYKqpA/UYawDszYI/ms9qCK63TXVv1K4BR0WJFyp7WXDUijLVVjDn8VbH/vt
 AGkW0lifVDPqCfYH8P270Fse1RxzfVGwLC3hZ3Ac5gyP0YHeIeVHpEtYNXawCeo1b5QY
 plB0XkaV7PjTgqYpAuv4fKk/oq5+7OR1nkaP/5G78n6PFSJxz9LCV1E615kaxa+FDsAM
 CgQw==
X-Gm-Message-State: AOJu0YwLa5cof6UA809J0CYXkJD0hbXUOQuWCDjjG1Zj/jd+QQlmxoDN
 GtI+nx/23p2UJIAhYwdO14gBJ5i4tdA/zm2p4/Hi+/8bLymyf92Z8K+3lA==
X-Google-Smtp-Source: AGHT+IEVz7vzIjCpbjPQIvaEuTsA2RM+m6P7JQVVRIW9mbyiHxN/E+3BPaIzymAGiB8AKukEdAbEFNHj6WMTMUQzKcE=
X-Received: by 2002:a17:906:1da1:b0:99b:f392:10b0 with SMTP id
 u1-20020a1709061da100b0099bf39210b0mr224344ejh.37.1692148987716; Tue, 15 Aug
 2023 18:23:07 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 19:22:56 -0600
Message-ID: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
Subject: Booting Windows 11
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

I thought I would try booting Windows on U-Boot but it does not get
very far. Have you tried that? I note a ew odd things below. Is there
a validation suite for it?

https://github.com/sjg20/u-boot/tree/efi2

qemu-system-x86_64  -smp 4 -m 8G -serial mon:stdio -bios
/tmp/b/qemu-x86_64/u-boot.rom -drive
id=3Dfisk,file=3Droot.img,if=3Dvirtio,driver=3Draw -drive
id=3Ddisk,if=3Dvirtio,file=3D/vid/software/win/Win11_22H2_English_x64v2.iso

Scanning bootdev 'virtio-blk#0.bootdev':
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_locate_device_path(protocol, &dp, &old_handle)
efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
Path, 00000000becf6848, 00000000becf6840)
efi_locate_device_path()     EFI: Call:
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_handle_buffer()       EFI: Entry
efi_locate_handle_buffer(2, Device Path, 0000000000000000,
00000000becf67b8, 00000000becf67b0)
efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
efi_locate_device_path()     EFI: 0 returned by
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by


^ This seems unhappy because it is a virtio device?

 efi_locate_device_path(protocol, &dp, &old_handle)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6948, Device Path, 0,
00000000bdcf2040)
efi_install_protocol_interface()     EFI: handle 00000000bed1f820
    efi_add_protocol()     EFI: installed device path
'/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-a=
eab-82e828f3628b,8200000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f362=
8b,1600820000000000)'
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6948, Block IO, 0,
00000000bed1f850)
efi_install_protocol_interface()     EFI: handle 00000000bed1f820
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
Scanning bootdev 'virtio-blk#1.bootdev':
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_locate_device_path(protocol, &dp, &old_handle)
efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
Path, 00000000becf6848, 00000000becf6840)
efi_locate_device_path()     EFI: Call:
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_handle_buffer()       EFI: Entry
efi_locate_handle_buffer(2, Device Path, 0000000000000000,
00000000becf67b8, 00000000becf67b0)
efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
efi_locate_device_path()     EFI: 0 returned by
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
efi_locate_device_path(protocol, &dp, &old_handle)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6948, Device Path, 0,
00000000bdcf0040)
efi_install_protocol_interface()     EFI: handle 00000000bed24ef0
    efi_add_protocol()     EFI: installed device path
'/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-a=
eab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f362=
8b,1600820001000000)'
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6948, Block IO, 0,
00000000bed24f20)
efi_install_protocol_interface()     EFI: handle 00000000bed24ef0
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_locate_device_path(protocol, &dp, &old_handle)
efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
Path, 00000000becf6818, 00000000becf6810)
efi_locate_device_path()     EFI: Call:
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_handle_buffer()       EFI: Entry
efi_locate_handle_buffer(2, Device Path, 0000000000000000,
00000000becf6788, 00000000becf6780)
efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
efi_locate_device_path()     EFI: 0 returned by
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_locate_device_path(protocol, &dp, &old_handle)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6918, Device Path, 0,
00000000bdced040)
efi_install_protocol_interface()     EFI: handle 00000000bed1f9e0
    efi_add_protocol()     EFI: installed device path
'/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-a=
eab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f362=
8b,1600820001000000)/CDROM(1,0x80c,0x8)'
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6918, Block IO, 0,
00000000bed1fa10)
efi_install_protocol_interface()     EFI: handle 00000000bed1f9e0
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_locate_device_path(protocol, &dp, &old_handle)
efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
Path, 00000000becf6818, 00000000becf6810)
efi_locate_device_path()     EFI: Call:
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_handle_buffer()       EFI: Entry
efi_locate_handle_buffer(2, Device Path, 0000000000000000,
00000000becf6788, 00000000becf6780)
efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
efi_locate_device_path()     EFI: 0 returned by
efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
&handles)
efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_locate_device_path(protocol, &dp, &old_handle)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6918, Device Path, 0,
00000000bdceb040)
efi_install_protocol_interface()     EFI: handle 00000000bed2b050
    efi_add_protocol()     EFI: installed device path
'/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-a=
eab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f362=
8b,1600820001000000)/CDROM(2,0x814,0x0)'
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_multiple_protocol_interfaces_int() EFI: Call:
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
efi_install_protocol_interface()   EFI: Entry
efi_install_protocol_interface(00000000becf6918, Block IO, 0,
00000000bed2b080)
efi_install_protocol_interface()     EFI: handle 00000000bed2b050
efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interfac=
e: 0
efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
protocol_interface)
  0  efi          ready   virtio       2  virtio-blk#1.bootdev.part
efi/boot/bootx64.efi
** Booting bootflow 'virtio-blk#1.bootdev.part_2' with efi
efi_set_blk_dev_to_system_partition() No EFI system partition
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
    efi_add_protocol() EFI: installed device path
'/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73=
b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/MAC(525400123456,1)'
EFI using ACPI tables at f0060
     efi_install_fdt() WARNING: Can't have ACPI table and device tree
- ignoring DT.
       efi_run_image() Booting /efi\boot\bootx64.efi
      efi_load_image() EFI: Entry efi_load_image(0, 00000000becfb110,
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b=
9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-ae=
ab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628=
b,1600820001000000)/CDROM(2,0x814,0x0)/efi\boot\bootx64.efi,
0000000001000000, 904560, 00000000becf6820)
      efi_load_image() EFI: Exit: efi_load_image: 0
     efi_start_image() EFI: Entry efi_start_image(00000000bed3d820,
00000000becf67e0, 00000000becf67e8)
     efi_start_image()   EFI: Call: efi_open_protocol(image_handle,
&efi_guid_loaded_image, &info, NULL, NULL,
EFI_OPEN_PROTOCOL_GET_PROTOCOL)
   efi_open_protocol()     EFI: Entry
efi_open_protocol(00000000bed3d820, Loaded Image, 00000000becf6730,
0000000000000000, 0000000000000000, 0x2)
   efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
     efi_start_image()   EFI: 0 returned by
efi_open_protocol(image_handle, &efi_guid_loaded_image, &info, NULL,
NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL)
     efi_start_image()   EFI: Jumping into 0x00000000bdbaf090
     efi_start_image()   EFI: Call: image_obj->entry(image_handle, &systab)
   efi_open_protocol()     EFI: Entry
efi_open_protocol(00000000bed3d820, Loaded Image, 00000000becf66c8,
00000000becfb110, 0000000000000000, 0x1)
   efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
   efi_open_protocol()     EFI: Entry
efi_open_protocol(00000000bed2b050, Device Path, 00000000becf6670,
00000000becfb110, 0000000000000000, 0x1)
   efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
efi_allocate_pages_ext()     EFI: Entry efi_allocate_pages_ext(2, 2,
0x1, 00000000becf66d8)
efi_allocate_pages_ext()       EFI: - type address
efi_allocate_pages_ext()       EFI: - address 102000
efi_allocate_pages_ext()       EFI: - returning memory 102000
efi_allocate_pages_ext()     EFI: Exit: efi_allocate_pages_ext: 0

Here it hangs for about 10 seconds, then reboots.

Regards,
Simon
