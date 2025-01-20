Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC6C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 00:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9AB805C5;
	Tue, 21 Jan 2025 01:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737418003;
	bh=HIz/q7Y0c4Hp+4qHOqIADS15TfrWWxIjMhr3fs4VySs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HnXk1hs/CKktPu6uo43DRiTR9t5dnlWiM+XmkgaUYWplmEEmGkW+EqqREzZugQerd
	 KcD7Jz2rtJ3u3gVDczntgKvFk8xbdnUPZhHdhDJ/B34asF8KuIIXMPlmliAT/4buNv
	 3rRwM7NfVmW4SDhNUgYY5sRgE/kwllC4GniW8h0SyQ3kmzrvgBYahzTSXgw7yOxABt
	 hQjjyslxnz4t7KkPGf2UsFhaP90pqZ8K9sh95prxTPyhlhEKb/jMwhc9GL4Xl5oLGs
	 yRMNMvkqZyMk5lYciuSd6Gkn9CDhtDGlZNfMPwLxrYCAiKDKU77KJLrwA1jb2/q5cB
	 WLbnRdi167BQw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E4780763; Tue, 21 Jan 2025 01:06:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EF7805C5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 01:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Bl12i/SU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDE13108A6AFB; Tue, 21 Jan 2025 01:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737417999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIz/q7Y0c4Hp+4qHOqIADS15TfrWWxIjMhr3fs4VySs=;
 b=Bl12i/SUl07BjOShOTEaQYSXIIMaxvjNdGjiCHfgi2odHs/LXff2k9U16n2P6Q1otaY4Bu
 uM0X5/hofBZAdl4KqFFOvgMBvYl/FZVOZKSqzfVFmAuyJ4lAPS2lVl7G5N9DXky7YCNpe9
 A6q7t/leXdewITjP8MJAe1Dp/Rzk5wg06g/RzVnNKzst5QJlMhry3VczoA4htUK9j+lnSY
 MSFh+ltXEnIKvFYc+A0Jocj5INjSRfXNFhf1OyX80FiFE6GaHM8MF9xNfVfm2OUjfHMvJs
 +xCGB+ATrdoQR2BbWVPR8AINKR28jLbp2/ZHva4Z4O+QDL1SskBQHA1w6mDrsQ==
Message-ID: <709f0a6b-32d1-4e18-915a-dfb3f87fb9a6@denx.de>
Date: Tue, 21 Jan 2025 00:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] image: apply FDTOs on FDT image node without a
 load property
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/16/25 12:46 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> A FIT image which is NOT using -E when created by mkimage - that is with
> image data within the FIT - will fail to apply FDTO if the base FDT
> image node does not specify a load property (which points to an address
> in DRAM). This is because we check that the FDT address we want to apply
> overlay to (i.e. modify and likely increase in size) is not inside the
> FIT and give up otherwise. This is assumed necessary because we may then
> overwrite other data when applying in-place.
> 
> However, we can do better than giving up: relocating the FDT in another
> place in DRAM where it's safe to increase its size and apply FDTOs.
> 
> While at it, do not discriminate anymore on whether the data is within
> the FIT data address space - that is FIT images created with mkimage -E
> - as that still may be susceptible to unintended data overwrites as
> mkimage -E simply concatenates all blobs after the FIT. If the FDT blob
> isn't the last, it'll result in overwriting later blobs when resizing.
> 
> The side effect is that the load property in the FIT is only
> temporarily used to load the FDT but then relocated right before we
> start applying overlays.
> 
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This actually forces the base FDT to always be relocated whenever FDTO
> are expected to be applied, regardless of the presence of the load
> property in the base FDT image node.
> 
> Tested with extlinux with:
> - conf node with multiple fdt entries (scenario A)
> - conf node with base fdt + conf node with fdto (stored in fdt property)
>    (scenario B)
> - conf node with multiple fdt entries with base fdt with load property
>    (scenario C)
> - conf node with base fdt + conf node with fdto (stored in fdt property)
>    with base fdt with load property (scenario D)
> 
> """fit.its
> /dts-v1/;
> 
> / {
> 	description = "Kernel fitImage for Jaguar";
> 	#address-cells = <1>;
> 
> 	images {
> 		kernel-1 {
> 			description = "Linux kernel";
> 			data = /incbin/("arch/arm64/boot/Image.gz");
> 			type = "kernel";
> 			arch = "arm64";
> 			os = "linux";
> 			compression = "gzip";
> 			load = <0x06000000>;
> 			entry = <0x06000000>;
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar.dtb {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar.dtb-load {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 			load = <0x12000000>;
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 		fdt-rk3588-jaguar-pre-ict-tester.dtbo {
> 			description = "Flattened Device Tree blob";
> 			data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtbo");
> 			type = "flat_dt";
> 			arch = "arm64";
> 			compression = "none";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 	};
> 
> 	configurations {
> 		default = "conf-rk3588-jaguar.dtb";
> 		conf-rk3588-jaguar.dtb {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-and-dtbo {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-load {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb-load";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar.dtb-load-and-dtbo {
> 			description = "1 Linux kernel, FDT blob";
> 			kernel = "kernel-1";
> 			fdt = "fdt-rk3588-jaguar.dtb-load", "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 
> 		conf-rk3588-jaguar-pre-ict-tester.dtbo {
> 			description = "0 FDT blob";
> 
> 			fdt = "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
> 
> 			hash-1 {
> 				algo = "sha256";
> 			};
> 		};
> 	};
> };
> """
> 
> """extlinux.conf (scenario A)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-and-dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b50370
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario B)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load-and-dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b79784
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Load Address: 0x12000000
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading fdt from 0x02b79784 to 0x12000000
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario C)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb#conf-rk3588-jaguar-pre-ict-tester.dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b50370
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> """extlinux.conf (scenario D)
> LABEL rk3588-jaguar
> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load#conf-rk3588-jaguar-pre-ict-tester.dtbo
> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
> """
> 
> Log:
> """
> 
>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'kernel-1' kernel subimage
>       Description:  Linux kernel
>       Type:         Kernel Image
>       Compression:  gzip compressed
>       Data Start:   0x020000cc
>       Data Size:    11862415 Bytes = 11.3 MiB
>       Architecture: AArch64
>       OS:           Linux
>       Load Address: 0x06000000
>       Entry Point:  0x06000000
>       Hash algo:    sha256
>       Hash value:   51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>     Verifying Hash Integrity ... sha256+ OK
> 
>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02b79784
>       Data Size:    168750 Bytes = 164.8 KiB
>       Architecture: AArch64
>       Load Address: 0x12000000
>       Hash algo:    sha256
>       Hash value:   96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>     Verifying Hash Integrity ... sha256+ OK
>     Loading fdt from 0x02b79784 to 0x12000000
>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
> Working FDT set to ece9d000
> 
>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>     Verifying Hash Integrity ... OK
>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>       Description:  Flattened Device Tree blob
>       Type:         Flat Device Tree
>       Compression:  uncompressed
>       Data Start:   0x02ba2bb4
>       Data Size:    2753 Bytes = 2.7 KiB
>       Architecture: AArch64
>       Hash algo:    sha256
>       Hash value:   e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>     Verifying Hash Integrity ... sha256+ OK
>     Booting using the fdt blob at 0xece9d000
> Working FDT set to ece9d000
>     Uncompressing Kernel Image to 6000000
>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
> Working FDT set to ece70000
> """
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v2:
> - Indiscriminately relocate, regardless of location of FDT to be on the
>    safe side wrt data overlap/overwrite,
> - print return value of boot_relocate_fdt when it fails,
> - Link to v1: https://lore.kernel.org/r/20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de
> ---
>   boot/image-fit.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index db7fb61bca948e42a4136b9ceb263a53362ad3f8..f3df8e2393559596f5100ea54a7ede77407713ac 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2348,10 +2348,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	char *next_config = NULL;
>   	ulong load, len;
>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	ulong image_start, image_end;
>   	ulong ovload, ovlen, ovcopylen;
>   	const char *uconfig;
>   	const char *uname;
> +	char *of_flat_tree;

Can this be void * instead ?

Aside from that:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
