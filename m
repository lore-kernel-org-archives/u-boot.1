Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4AEC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7202863F8;
	Tue, 21 Nov 2023 18:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lsmm3IxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9990987251; Tue, 21 Nov 2023 18:20:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1BA87572
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700587235; x=1701192035; i=xypron.glpk@gmx.de;
 bh=OkbSPOUpxBDvnJl6MGtO6RsgDVudDMdxjSKGBzbZ/90=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=lsmm3IxFgjgjczthO0fmROxiIXL/R5vRzO2ofXw4L+ibXtr9T0CKzxIlB7Mbks2B
 NXgvhAD27g8gAW+AwNPSEC7c0/V02Zjo3YgfHb/Gt8ejLHaPSTOmZz+dVdUv3H6V5
 pjYb5ADs69gBE9jxbQDlcNgmrdnwRIEAnHVTeMnFm3ywwWirErY2jj8Za1NtcQoG7
 a0aUf4v0NhD7Z33NT/9iNivMnUwIbHm+2IHf0dZLGkRZD2Kov9MyKwi4T+D98SNce
 cbPY1y40F8KkdBseyUd4B3LS9p2cNytuRdU//D8eydzTCLB/U6p3w/TJhEiGXyYt0
 3VHyp9h2cbHIuKOaVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1rGr7326Be-00y7h1; Tue, 21
 Nov 2023 18:20:35 +0100
Message-ID: <555a04a5-170e-409e-bae5-b2b0ba03e09e@gmx.de>
Date: Tue, 21 Nov 2023 18:20:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] WIP: efi: debugging
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-8-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9swyE3eT1B9/tYkslxpPXI1SC2uUno1tj76A458MCeBay1sk13C
 TetHgy0Ji0UTKXCfDPCfgpAg6rSpDRR+1cO6zrLpnhhsQRgFsg62EVrUUSM245iRKsmzLXG
 oY7AxRQ/CaZkMPEbjw6kqw46+4f42uDd9JEk0pC8EANgpEJXTVh3dFYqydxrETuM6zkjwGi
 2cfz84qGvHGqm2I0w7VOQ==
UI-OutboundReport: notjunk:1;M01:P0:SYbXyD7sg2Q=;3lap2H7dikStCTUFFTgK/cKFyom
 vcjIWcoa71ibDd4OtSPKOU8C4Oi513gG+UTjxYspaB7ea2RQWBXyvsnb+o+w/iEIk0PonX2Lp
 Ozpfj0iOvr4ii99/81tdD5wK524h7cMt14sZCsGfRCK4Sqf60LgWlwOI2vwwV7oJ0UW5IunoB
 PLK+z6mBYw+lHLHfCUNJW69Fy5xy3qOKNDsE4nr0xfzExBwRmLKQ1lJJH057YDSux5nvmIYE1
 FHnTzlvCMKrZgfFgAJohWLkgU7CiB4KHqyFQQzKmKxprMUriA+vQMbiUsnTKjV17HIIdyJlxb
 GVrwoaaqChG6WFqBM+CESHtYmMwBsmMB1nHUfko4LRPs60wL77dbTsd72lB1TffbHShyosUPa
 MnhpHe/DKB2Ahe072MJtZ9DQej21CNt21MNpvSpQmgVPR9Os7vdPKJmB4svUN849mkkAvNK2w
 74zPWl6qrKNt4NxT1c+5l/503Ki78z7cMujFosSJBeaKFBPzdXdg0vbBncLtmXcQofhq1LS9I
 ix4K7FFyY9yiLA7U9Tzv3PU4rFaNuI3KBaxCXR9kJUTMMaPm5KpguxzJM4BWR+shYfClPR3U5
 Qgl84H8oKIYx8tY10IW/0OVM31+F4GEupOz+iFwLpKE7H2Kppw5LhVQNL+ErtbnhVeTd9YSa7
 LR/LrjgHSK3OSMrRfzSl5cCvZfW80RZUGKW7G7qmCVIYqLf52MPQRNtyhqwbSF5Honb9Xmuj5
 MXlrCnTYPTrC4m6p57G0ShGHkNBzErgGc5hnMD9fr9wr0IR/Vqq6RIk4e8OD0z45RLue6HuGs
 mDKi0RERh2KkWPzzzxouGhx2SV4qRZhrlL33vq+16zWE14MsSTDD07M7gUWrcMZVMAFWc5fFN
 d/Wik5hlcMUl/KxcbkKFnpk44hHBFdnRn32dFYaOwmJtigP3nO2RBwrvalPlYiaDVr4Pb0s2u
 fC7GCUwlcEVUScvZasB68GrFr6k=
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

On 11/21/23 12:35, Simon Glass wrote:
> This works when run outside a test:
>
> good:
>
> /tmp/b/sandbox/u-boot -T
>      -c "bootfl scan mmc; bootfl sel 1; bootfl list; bootfl b"
>
> ** Booting bootflow 'mmc7.bootdev.part_1' with efi
> desc =3D 0000000018c86ee0
> dev=3Dmmc, devnr=3D7:1, path=3Defi/boot/bootsbox.efi, buffer=3D000000001=
1001000, size=3D1600
> - boot device /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,00000000000000=
00)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
> - image /efi\boot\bootsbox.efi
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> EFI using ACPI tables at 8ef8000
> WARNING: Can't have ACPI table and device tree - ignoring DT.
> Loaded from disk
> Booting /efi\boot\bootsbox.efi
> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, sou=
rce_size, &handle)
> info->device_handle =3D 0000000018f180e0
> loaded_image info for 0000000018f184e0: 0000000018f18470
>
> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buf=
fer, source_size, &handle)
> EFI: Call: efi_start_image(handle, &exit_data_size, &exit_data)
> Hello, world!
> Running on UEFI 2.10
> Have ACPI 2.0 table
> Have SMBIOS table
> 18f18470
> Load options: <none>
> finding
> - search 0000000018c931a0 ret=3D0
> File path: /efi\boot\bootsbox.efi
> Vendor: Das U-Boot
> Boot device: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,000000000000000=
0)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
> Exiting boot sevices
> EFI: 5 returned by efi_start_image(handle, &exit_data_size, &exit_data)
> Boot failed (err=3D-22)
>
> bad:
>
> rtv bootflow_efi
>
> ** Booting bootflow 'mmc7.bootdev.part_1' with efi

Should we have an ESP on the MMC image to persist UEFI variables?

Best regards

Heinrich

> desc =3D 0000000018c86ee0
> dev=3Dmmc, devnr=3D8:1, path=3Defi/boot/bootsbox.efi, buffer=3D000000001=
1001000, size=3D1600
> - boot device /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,00000000000000=
00)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
> - image /efi\boot\bootsbox.efi
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> EFI using ACPI tables at 8ef8000
> WARNING: Can't have ACPI table and device tree - ignoring DT.
> Loaded from disk
> Booting /efi\boot\bootsbox.efi
> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, sou=
rce_size, &handle)
> info->device_handle =3D 0000000000000000
> loaded_image info for 0000000018c924e0: 0000000018f15080
>
> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buf=
fer, source_size, &handle)
> EFI: Call: efi_start_image(handle, &exit_data_size, &exit_data)
> Hello, world!
> Running on UEFI 2.10
> Have ACPI 2.0 table
> Have SMBIOS table
> 18f15080
> Load options: <none>
> finding
> - search 0000000018c931a0 ret=3D0
> File path: /efi\boot\bootsbox.efi
> Missing device handle
> Exiting boot sevices
> EFI: 5 returned by efi_start_image(handle, &exit_data_size, &exit_data)
> Boot failed (err=3D-22)
> test/boot/bootflow.c:1091, bootflow_efi(): console:
> Expected 'No EFI system partition',
>       got 'desc =3D 0000000018c86ee0'
> Test bootflow_efi failed 1 times
> Failures: 1
>
> (see 'Missing device handle')
>
> It seems that the device number is inconsistent between generation and
> decoding.
>
> function rt_get_suite_and_name() {
> 	local arg
> 	#echo arg $arg
> 	suite=3D
> 	name=3D
>
> 	if [ "$1" =3D "-f" ]; then
> 		force=3D"-f"
> 		shift
> 	fi
> 	arg=3D"$1"
> 	rest=3D"$2"
>
> 	# The symbol is something like this:
> 	#	_u_boot_list_2_ut_bootstd_test_2_vbe_simple_test_base
> 	# Split it into the suite name (bootstd) and test name
> 	# (vbe_simple_test_base)
> 	read suite name < \
> 		<(nm /tmp/b/$exec/u-boot |grep "list_2_ut.*$arg.*" \
> 			| cut -d' ' -f3 \
> 			| head -1 \
> 			| sed -n 's/_u_boot_list_2_ut_\(.*\)_test_2_/\1 /p')
> 	#echo suite $suite
> 	#echo name $name
> 	#name=3D${1#dm_test_}
> 	#name=3D${name#ut_dm_}
> }
>
> function rtv() {
> 	local exec=3Dsandbox
> 	local suite name force rest
> 	rt_get_suite_and_name $*
>
> 	U_BOOT_PERSISTENT_DATA_DIR=3D/tmp/b/sandbox/persistent-data \
> 	/tmp/b/$exec/u-boot -v -T $rest -c "ut $suite $force $name"
> }
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   boot/bootflow.c               | 2 ++
>   boot/bootmeth_efi.c           | 1 +
>   cmd/bootefi.c                 | 1 +
>   lib/efi_loader/efi_boottime.c | 5 +++++
>   test/boot/bootflow.c          | 2 +-
>   5 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 6922e7e0c4e7..0513522a7ec4 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -464,6 +464,8 @@ void bootflow_init(struct bootflow *bflow, struct ud=
evice *bootdev,
>
>   void bootflow_free(struct bootflow *bflow)
>   {
> +	/* this is where we want to get to (will only happen with USB) */
> +	printf("bootflow free\n");
>   	free(bflow->name);
>   	free(bflow->subdir);
>   	free(bflow->fname);
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index ae936c8daa18..edee9e62a458 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -127,6 +127,7 @@ static void set_efi_bootdev(struct blk_desc *desc, s=
truct bootflow *bflow)
>   	 * this can go away.
>   	 */
>   	media_dev =3D dev_get_parent(bflow->dev);
> +	printf("desc =3D %p\n", desc);
>   	snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
>   		 desc ? desc->devnum : dev_seq(media_dev),
>   		 bflow->part);
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 20e5c94a33a4..3c014e5684aa 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -5,6 +5,7 @@
>    *  Copyright (c) 2016 Alexander Graf
>    */
>
> +#define LOG_DEBUG
>   #define LOG_CATEGORY LOGC_EFI
>
>   #include <common.h>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 0b7579cb5af1..149da5798740 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1820,6 +1820,7 @@ efi_status_t efi_setup_loaded_image(struct efi_dev=
ice_path *device_path,
>
>   	if (device_path) {
>   		info->device_handle =3D efi_dp_find_obj(device_path, NULL, NULL);
> +		printf("info->device_handle =3D %p\n", info->device_handle);
>
>   		dp =3D efi_dp_append(device_path, file_path);
>   		if (!dp) {
> @@ -1828,6 +1829,7 @@ efi_status_t efi_setup_loaded_image(struct efi_dev=
ice_path *device_path,
>   		}
>   	} else {
>   		dp =3D NULL;
> +		printf("\nno device handle\n");
>   	}
>   	ret =3D efi_add_protocol(&obj->header,
>   			       &efi_guid_loaded_image_device_path, dp);
> @@ -1842,6 +1844,7 @@ efi_status_t efi_setup_loaded_image(struct efi_dev=
ice_path *device_path,
>   			       &efi_guid_loaded_image, info);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto failure;
> +	printf("loaded_image info for %p: %p\n\n", &obj->header, info);
>
>   	*info_ptr =3D info;
>   	*handle_ptr =3D obj;
> @@ -2665,8 +2668,10 @@ static efi_status_t EFIAPI efi_locate_protocol(co=
nst efi_guid_t *protocol,
>   		if (ret =3D=3D EFI_SUCCESS)
>   			goto found;
>   	} else {
> +		printf("finding\n");
>   		list_for_each_entry(efiobj, &efi_obj_list, link) {
>   			ret =3D efi_search_protocol(efiobj, protocol, &handler);
> +			printf("- search %p ret=3D%lx\n", efiobj, ret);
>   			if (ret =3D=3D EFI_SUCCESS)
>   				goto found;
>   		}
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index ad54ef6eaabc..76c65c46cc01 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -536,7 +536,7 @@ static int prep_mmc_bootdev(struct unit_test_state *=
uts, const char *mmc_dev,
>
>   	order[2] =3D mmc_dev;
>
> -	/* Enable the mmc4 node since we need a second bootflow */
> +	/* Enable the requested mmc node since we need a second bootflow */
>   	root =3D oftree_root(oftree_default());
>   	node =3D ofnode_find_subnode(root, mmc_dev);
>   	ut_assert(ofnode_valid(node));

