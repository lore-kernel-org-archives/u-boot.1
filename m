Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41520CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B364686F3A;
	Tue, 17 Oct 2023 21:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="E6Isj3Cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F1486F15; Tue, 17 Oct 2023 21:25:53 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19DB86F42
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f6171b78-6d22-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f6171b78-6d22-11ee-90ec-00505699b430;
 Tue, 17 Oct 2023 21:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=wetHedKhmzeeCfnq+9y/UycJ4jaDfl1SZ3Hu3YzceNk=;
 b=E6Isj3CpjCwG3RVT8FCsaENSJDmRYjdkijN64iyqHFxoDXdIH+a133DERhUBoQ7EWJyvqVgB63QYF
 ItYQqSlHnxstDApePXNgOklUnRsMLmkZc21irCuLdpSEQ2LbmfWpTxXCa+KrnD6ouSn16ndM09Flqz
 fDuuNIowvL5qhaSOLxRvz+leSZydW2sEOxmxkW9XvjSoFbBBTnow8ICCEuDc+BW9XAUTzVnLb2Plvk
 ND+sY1SBZPQGd7Wgqq2p0/8LOhrrjbJ9+Wwa2e2QOAEglfCdjHFw2BxZbO+VksaIb5GRSkjhwEJTgT
 mlhFyTbknobVy+zwf2EaBvyDSbdkEhw==
X-KPN-MID: 33|v+u1sENyWPnHs6oxK9DyH2qDK9BDqzu6Pz0s9SQJJ9+fRIe+xY3gbCQp++kxSlN
 aU62AnIGufx1aftf7dyDJ+EJozKOeDBBfMovUX/PKxwE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9HPIt4z1YYs1Pf46DPwzgj0IQLBKCz6rrCiJeMxfrVLUNhuLvhubbfLlrSnHxGk
 x4AIJb2wBC5wEnz2DsBzv3Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id fa286e61-6d22-11ee-acaa-00505699d6e5;
 Tue, 17 Oct 2023 21:25:49 +0200 (CEST)
Date: Tue, 17 Oct 2023 21:25:48 +0200
Message-Id: <87v8b5qceb.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
 raymond.mao@linaro.org, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
In-Reply-To: <20231017175148.75215-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Tue, 17 Oct 2023 19:51:48 +0200)
Subject: Re: [PATCH] efi_loader: fix efi_bootmgr_enumerate_boot_option
References: <20231017175148.75215-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Tue, 17 Oct 2023 19:51:48 +0200
> 
> Only auto-generate boot options for removable media.
> 
> For testing the different handling of removable and non-removable devices
> an emulated USB device can be used:
> 
>     make qemu-riscv64_smode_defconfig; make
>     qemu-system-riscv64 -M virt -kernel u-boot.bin -nographic \
>     -device qemu-xhci -drive if=none,file=disk.img,format=raw,id=USB1 \
>     -device usb-storage,drive=USB1,removable=on

Unless I misunderstand what this patch does, this may result in
systems that don't boot after installation.

On most boards U-Boot does not provide a way to create persistent EFI
variables after ExitBootServices() is called.  This means that an OS
installer cannot create a boot entry for the OS installation it just
created.  Therefore the EFI boot manager will not boot the newly
installed system.

Now as long as the traditional distro boot mechanism or the EFI distro
boot bootmeth is enabled the system will probobly still attempt to
boot the installed system.  But do want to rely on that?

> Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
> Fixes: 339b527bd450 ("Move bootorder and bootoption apis to lib")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c..96d45157b3 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -346,7 +346,7 @@ error:
>  }
>  
>  /**
> - * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
> + * efi_bootmgr_enumerate_boot_option() - boot options for removable boot media
>   *
>   * @opt:		pointer to the media boot option structure
>   * @volume_handles:	pointer to the efi handles
> @@ -370,6 +370,9 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
>  		struct efi_device_path *device_path;
>  		struct efi_device_path *short_dp;
>  
> +		if (!efi_disk_is_removable(volume_handles[i]))
> +			continue;
> +
>  		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
>  		if (ret != EFI_SUCCESS)
>  			continue;
> @@ -674,7 +677,10 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
>  		goto out;
>  	}
>  
> -	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> +	/*
> +	 * Enumerate all removable devices supporting the
> +	 * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> +	 */
>  	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
>  	if (ret != EFI_SUCCESS)
>  		goto out;
> -- 
> 2.40.1
> 
> 
