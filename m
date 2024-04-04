Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8ECD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 15:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83CE28826D;
	Thu,  4 Apr 2024 17:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="d6DykFEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65ACA88277; Thu,  4 Apr 2024 17:18:21 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C4D8821B
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 17:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 95aca3c8-f296-11ee-b64f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 95aca3c8-f296-11ee-b64f-005056994fde;
 Thu, 04 Apr 2024 17:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=uPjO6gstgNCBjEUfiomahrR7awAeLUNzR1IxDR19kGQ=;
 b=d6DykFEwZy3r7DUhWpiUDKIy6SmFlW742P+MInueGh6NY7uhe4H+0ZSHdhQ2+7j1/VeOQwYzu3Zw0
 h7mW3iK7tGzV88nBEJi2r7VyfpNRJJ2EkTNxv+EolWDDG+kjQ56kXBX7qMxLfvz6hdMQkCkcL0pezu
 lkexw7XInNXrdvqWrh/XuTxpcyYCmbotmtRYuYVKOcpTuX8qPquc8GGEigKdZKKg4wdZifX9Cp3wvU
 XpsRDpaxTAePaFoDR/BkqZ0oy9RnaiGgDguMJlvcFTVoymynbkAfoJAKEzbu5xzzIOCHweg03D02XN
 LgZ7Kp7ojbBuM3kNApvNVaQQvEftWAw==
X-KPN-MID: 33|6uouDFcOmfmMPygIdpEO8ZOYboqyjibnGyFrcyz4p3iJrwYtgWXgv6jnLH+IT5X
 Q+jlK++BlTkid0+2xhSfvynZxmTwzpKDBEZzPwX8Yupg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+WVcqDv/wVMQ6/vmb2vLpEjR4bPDYUyJm81XR7voWMoNGeZHN9V4CjSPHx6d2/C
 qGkwHbt1vd4X44xktlqud+A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9013c681-f296-11ee-9b3a-005056998788;
 Thu, 04 Apr 2024 17:18:18 +0200 (CEST)
Date: Thu, 04 Apr 2024 17:18:17 +0200
Message-Id: <87r0fli2bq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 sumit.garg@linaro.org, bb@ti.com, mr.bossman075@gmail.com,
 leon@georgemail.eu, eajames@linux.ibm.com, bmeng@tinylab.org,
 i@shantur.com, kettenis@openbsd.org, rfried.dev@gmail.com,
 seanedmond@microsoft.com, abdellatif.elkhlifi@arm.com,
 kojima.masahisa@socionext.com, sughosh.ganu@linaro.org,
 lucent@gmail.com, u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Thu, 4 Apr 2024 13:47:39 +0200)
Subject: Re: [PATCH v2 1/4] boot: correct the default sequence of boot methods
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
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
> Date: Thu,  4 Apr 2024 13:47:39 +0200
> 
> The default sequence of boot methods is determined by alphabetical sorting
> during linkage.
> 
> * efi_mgr must run before efi to be UEFI compliant
> * pxe should run as last resort
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This sound very much like you're working around a standard boot design
flaw.

Who does the alphabetical sorting here?  Is that just a result of how
the toolchain behaves?  If so, that sounds fragile to me and I think
it would be better to make the order explicit in the code.

Cheers,

Mark

> ---
> v2:
> 	no change
> ---
>  boot/bootmeth_efi.c     | 2 +-
>  boot/bootmeth_efi_mgr.c | 2 +-
>  boot/bootmeth_pxe.c     | 2 +-
>  test/boot/bootflow.c    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index c4eb331d69e..a46b6c9c805 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -489,7 +489,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
>  	{ }
>  };
>  
> -U_BOOT_DRIVER(bootmeth_efi) = {
> +U_BOOT_DRIVER(bootmeth_4efi) = {
>  	.name		= "bootmeth_efi",
>  	.id		= UCLASS_BOOTMETH,
>  	.of_match	= distro_efi_bootmeth_ids,
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index ed29d7ef021..b7d429f2c3d 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -114,7 +114,7 @@ static const struct udevice_id efi_mgr_bootmeth_ids[] = {
>  	{ }
>  };
>  
> -U_BOOT_DRIVER(bootmeth_efi_mgr) = {
> +U_BOOT_DRIVER(bootmeth_3efi_mgr) = {
>  	.name		= "bootmeth_efi_mgr",
>  	.id		= UCLASS_BOOTMETH,
>  	.of_match	= efi_mgr_bootmeth_ids,
> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> index 8d489a11aa4..70f693aa239 100644
> --- a/boot/bootmeth_pxe.c
> +++ b/boot/bootmeth_pxe.c
> @@ -184,7 +184,7 @@ static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
>  	{ }
>  };
>  
> -U_BOOT_DRIVER(bootmeth_pxe) = {
> +U_BOOT_DRIVER(bootmeth_zpxe) = {
>  	.name		= "bootmeth_pxe",
>  	.id		= UCLASS_BOOTMETH,
>  	.of_match	= extlinux_bootmeth_pxe_ids,
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 4845b7121c8..e60e9309fa9 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -377,7 +377,7 @@ static int bootflow_system(struct unit_test_state *uts)
>  	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
>  		return -EAGAIN;
>  	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> -	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
> +	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
>  				"efi_mgr", 0, ofnode_null(), &dev));
>  	ut_assertok(device_probe(dev));
>  	sandbox_set_fake_efi_mgr_dev(dev, true);
> -- 
> 2.43.0
> 
> 
