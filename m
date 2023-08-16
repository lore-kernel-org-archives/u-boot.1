Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6480BC001DF
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 07:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E75868BC;
	Wed, 16 Aug 2023 09:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RDjaXXcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57E38697E; Wed, 16 Aug 2023 09:11:35 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A19867E2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 09:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe426b8583so62770855e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692169892; x=1692774692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IYjqM0hMn++wWcAGjjWyMEzLrgsrDL35Byhq/CVcySA=;
 b=RDjaXXcVQdhgPJQYzhGaADQyLtQKkY2OS5lRzFf0p3i7ooqw7lciH8B61k0dFF342i
 ZDWe0VYaiu7EyGzX5g2F4zBUl6CPqO20Kwr+QVg3r+aHLesf05ZORlvu3Cl+xPXi4Nfv
 cdjgJtCtRlM2ZjHS1pZSE1nnloPYZb8+tKR+iuEAOn68d56LFmMwOJpIYkgNuJiIFeJY
 qd9Rf3vagY5bGkCkkqci3qW9RgjANfJgn9yaCGA99ixITv8HqTS4dYd96Zycek5LvM8r
 PjXchX8qQGX/BghClvshD/RffBrIuy8N4LxGirSLreVdIV/Okp5quO8TJ3k2JUK+F/Ke
 gHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692169892; x=1692774692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYjqM0hMn++wWcAGjjWyMEzLrgsrDL35Byhq/CVcySA=;
 b=PuxBWQUrDxJEfUbdYQV4zDxoMxyssUY8hyo2MeLbqBCrlFwlBL6LvY07eTRRtJuDcw
 WvR6VKCLafk5GNw+EpqF/GEWzZdjSrpGq0H78NEujaHhg9jB/MQISpUwhCNLmnhIzjSw
 WFVgYF36fXtJ43WUky/BanJqAchy23LWRJUGT1TeUaSWgNtTWblGobxlhZNsUABmESVY
 9+h0GBv5ZvGWl5o6qA0wNapyn1EtSw4kjMu3S10meby2l8V8xwxlsJp3gxa9DRKw8K5m
 8Ncth6kNiZvgG9DVoBnW+nH5146BoyXL4BA4ifYl9s53cpNoDOjLRlgwRJum3vUZfbQr
 AnPw==
X-Gm-Message-State: AOJu0YxN0iJ09M0PmxJQQGSE5CFMncKr7WelWpzuloQBiFwFTTopaCKv
 NjGrwa3Cs1jNPTTVeEJ7ldYNUA==
X-Google-Smtp-Source: AGHT+IHIy/J5YX3QcDCY4M3yTh4NwRn1X3zn036S68BjznPaHFcOZSH0uxnAT1lUC+IkKuS+6GMZdA==
X-Received: by 2002:adf:e685:0:b0:317:6639:852d with SMTP id
 r5-20020adfe685000000b003176639852dmr825840wrm.43.1692169891989; 
 Wed, 16 Aug 2023 00:11:31 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 f6-20020adffcc6000000b0031984b370f2sm5055292wrs.47.2023.08.16.00.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 00:11:31 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:11:29 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: Booting Windows 11
Message-ID: <ZNx2oS0qK8E3NTY5@hades>
References: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
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

Hi Simon, 

On Tue, Aug 15, 2023 at 07:22:56PM -0600, Simon Glass wrote:
> Hi Heinrich,
> 
> I thought I would try booting Windows on U-Boot but it does not get
> very far. Have you tried that? I note a ew odd things below. Is there
> a validation suite for it?
> 
> https://github.com/sjg20/u-boot/tree/efi2
> 
> qemu-system-x86_64  -smp 4 -m 8G -serial mon:stdio -bios
> /tmp/b/qemu-x86_64/u-boot.rom -drive
> id=fisk,file=root.img,if=virtio,driver=raw -drive
> id=disk,if=virtio,file=/vid/software/win/Win11_22H2_English_x64v2.iso
> 
> Scanning bootdev 'virtio-blk#0.bootdev':
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> Path, 00000000becf6848, 00000000becf6840)
> efi_locate_device_path()     EFI: Call:
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_handle_buffer()       EFI: Entry
> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> 00000000becf67b8, 00000000becf67b0)
> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> efi_locate_device_path()     EFI: 0 returned by
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
> efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
> 
> 
> ^ This seems unhappy because it is a virtio device?
> 
>  efi_locate_device_path(protocol, &dp, &old_handle)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6948, Device Path, 0,
> 00000000bdcf2040)
> efi_install_protocol_interface()     EFI: handle 00000000bed1f820
>     efi_add_protocol()     EFI: installed device path
> '/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,8200000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600820000000000)'
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6948, Block IO, 0,
> 00000000bed1f850)
> efi_install_protocol_interface()     EFI: handle 00000000bed1f820
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> Scanning bootdev 'virtio-blk#1.bootdev':
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> Path, 00000000becf6848, 00000000becf6840)
> efi_locate_device_path()     EFI: Call:
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_handle_buffer()       EFI: Entry
> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> 00000000becf67b8, 00000000becf67b0)
> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> efi_locate_device_path()     EFI: 0 returned by
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
> efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6948, Device Path, 0,
> 00000000bdcf0040)
> efi_install_protocol_interface()     EFI: handle 00000000bed24ef0
>     efi_add_protocol()     EFI: installed device path
> '/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600820001000000)'
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6948, Block IO, 0,
> 00000000bed24f20)
> efi_install_protocol_interface()     EFI: handle 00000000bed24ef0
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> Path, 00000000becf6818, 00000000becf6810)
> efi_locate_device_path()     EFI: Call:
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_handle_buffer()       EFI: Entry
> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> 00000000becf6788, 00000000becf6780)
> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> efi_locate_device_path()     EFI: 0 returned by
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6918, Device Path, 0,
> 00000000bdced040)
> efi_install_protocol_interface()     EFI: handle 00000000bed1f9e0
>     efi_add_protocol()     EFI: installed device path
> '/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600820001000000)/CDROM(1,0x80c,0x8)'
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6918, Block IO, 0,
> 00000000bed1fa10)
> efi_install_protocol_interface()     EFI: handle 00000000bed1f9e0
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> Path, 00000000becf6818, 00000000becf6810)
> efi_locate_device_path()     EFI: Call:
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_handle_buffer()       EFI: Entry
> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> 00000000becf6788, 00000000becf6780)
> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> efi_locate_device_path()     EFI: 0 returned by
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6918, Device Path, 0,
> 00000000bdceb040)
> efi_install_protocol_interface()     EFI: handle 00000000bed2b050
>     efi_add_protocol()     EFI: installed device path
> '/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600820001000000)/CDROM(2,0x814,0x0)'
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
> efi_install_protocol_interface()   EFI: Entry
> efi_install_protocol_interface(00000000becf6918, Block IO, 0,
> 00000000bed2b080)
> efi_install_protocol_interface()     EFI: handle 00000000bed2b050
> efi_install_protocol_interface()   EFI: Exit: efi_install_protocol_interface: 0
> efi_install_multiple_protocol_interfaces_int() EFI: 0 returned by
> efi_install_protocol_interface(handle, protocol, EFI_NATIVE_INTERFACE,
> protocol_interface)
>   0  efi          ready   virtio       2  virtio-blk#1.bootdev.part
> efi/boot/bootx64.efi
> ** Booting bootflow 'virtio-blk#1.bootdev.part_2' with efi
> efi_set_blk_dev_to_system_partition() No EFI system partition
> efi_set_blk_dev_to_system_partition() No EFI system partition
>      efi_var_to_file() Failed to persist EFI variables
>     efi_add_protocol() EFI: installed device path
> '/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/MAC(525400123456,1)'
> EFI using ACPI tables at f0060
>      efi_install_fdt() WARNING: Can't have ACPI table and device tree
> - ignoring DT.
>        efi_run_image() Booting /efi\boot\bootx64.efi
>       efi_load_image() EFI: Entry efi_load_image(0, 00000000becfb110,
> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5400000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,8200000001000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600820001000000)/CDROM(2,0x814,0x0)/efi\boot\bootx64.efi,
> 0000000001000000, 904560, 00000000becf6820)
>       efi_load_image() EFI: Exit: efi_load_image: 0
>      efi_start_image() EFI: Entry efi_start_image(00000000bed3d820,
> 00000000becf67e0, 00000000becf67e8)
>      efi_start_image()   EFI: Call: efi_open_protocol(image_handle,
> &efi_guid_loaded_image, &info, NULL, NULL,
> EFI_OPEN_PROTOCOL_GET_PROTOCOL)
>    efi_open_protocol()     EFI: Entry
> efi_open_protocol(00000000bed3d820, Loaded Image, 00000000becf6730,
> 0000000000000000, 0000000000000000, 0x2)
>    efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
>      efi_start_image()   EFI: 0 returned by
> efi_open_protocol(image_handle, &efi_guid_loaded_image, &info, NULL,
> NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL)
>      efi_start_image()   EFI: Jumping into 0x00000000bdbaf090
>      efi_start_image()   EFI: Call: image_obj->entry(image_handle, &systab)
>    efi_open_protocol()     EFI: Entry
> efi_open_protocol(00000000bed3d820, Loaded Image, 00000000becf66c8,
> 00000000becfb110, 0000000000000000, 0x1)
>    efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
>    efi_open_protocol()     EFI: Entry
> efi_open_protocol(00000000bed2b050, Device Path, 00000000becf6670,
> 00000000becfb110, 0000000000000000, 0x1)
>    efi_open_protocol()     EFI: Exit: efi_open_protocol: 0
> efi_allocate_pages_ext()     EFI: Entry efi_allocate_pages_ext(2, 2,
> 0x1, 00000000becf66d8)
> efi_allocate_pages_ext()       EFI: - type address
> efi_allocate_pages_ext()       EFI: - address 102000
> efi_allocate_pages_ext()       EFI: - returning memory 102000
> efi_allocate_pages_ext()     EFI: Exit: efi_allocate_pages_ext: 0
> 
> Here it hangs for about 10 seconds, then reboots.


How are you launching QEMU? 
IIRC by default the VM spawns in EL1 and sets the PSCI conduit to HVC. But Windows 
issues an SMC unconditionally and blows up.  Can you try with
virtualization=on?

Regards
/Ilias
> 
> Regards,
> Simon
