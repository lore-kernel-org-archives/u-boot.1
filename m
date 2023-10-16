Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC86CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 07:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AAC86BD5;
	Mon, 16 Oct 2023 09:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CB0ii1ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2307886C1D; Mon, 16 Oct 2023 09:06:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FB586B4E
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 09:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697439965; x=1698044765; i=xypron.glpk@gmx.de;
 bh=10sKkqBjWsLjQKTKfnkfmp76vHwj/jW0e+4yME3ZU3E=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=CB0ii1ijtdTgNF7e4gKrcSo9bOxuKOYwZsMgNreuvB00hpFZ8c5DO5LSvG/oIhbnq1yfWVbgQte
 GxXFCNqPb9OQHY7CztBTh8Qjm+30IY+djWWySywc4FXKKTH8Qx6GBCZIihgeLqsgnOWo4/xATvALG
 g1eArGTZZ8a0vhsOl2ueVJXhytx+pAvqAc2JJxzwHXD4CNHS35xxTCZ1T2J61gC65gRHUBkKmqnCo
 DgtgwAy+dkQAK017RVZ2ew8+052UPSztvBEyv6Ja+aqdcgpEQZ7I+js4fuK+gaTDXy9ocopQ3z5aN
 KpNsP1DdOHGnIwNhyIiRcsVlzBPSKirzIrog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1rkHOi1IJ3-00z0I3; Mon, 16
 Oct 2023 09:06:05 +0200
Date: Mon, 16 Oct 2023 09:06:03 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
User-Agent: K-9 Mail for Android
In-Reply-To: <20231016064526.2410856-5-masahisa.kojima@linaro.org>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
Message-ID: <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OjIWWEhACjHD38c1D7JNTZ9kHG5JOlYx+k7hjk85U0ThG5gDPUt
 /DOlHNOJEa6Ll+UcKapPvyPsMoh5KL5fgByifEhRg5B5spjGV0FFusziSeictB/IOWrYBfv
 YpLosom+s+4lmhVge0ZtLseyWjligyBcqfNnC8yAcClTlICvJ0LOH5fgd1LcowN7Ct/L320
 zlo8tzOvThMBeHJpajUkg==
UI-OutboundReport: notjunk:1;M01:P0:tlfm3kYml1I=;YSOOoBSt9B2FjO9LZGYVNG4oe3Y
 9C70egVev/YyvanS2J0zUfIRQB932mhrKsgCLhlOa8d8ieZuOCFiRpX+NlXjhMZ0+UP1nijdR
 2sVswsyUnwZSV9Vf7nUorz8wyb8jgP8rJH73MJtGLP8Zt/krAdmPRfrI9Yyvbhi5yfa1AzaI0
 XjnaL+lbUlpydRjaWmpOllh8Zw1vmLH82zK0MlFPnrok5evhdFEZiiwgK3wGdC2Jq8EQRpcqo
 a956iknU+7uMvO/9symDtr4Kt3DRNQ5oEb5hI5YPK/73MiFL9dgpWDMC14qdb53/Pw9d9+eG0
 00KLQQUEGSaaJZA3SVAQ4vIwyp85tGa3TqIpGN3mrI+4TvaPAuo1oVlmhdp5Jz4e+SY0w506n
 fN5A2fR/vVZgLgJ6Z7Sg10ezXtlwAoKAhUVL4s+U4rfJFvsx2cgn/w7qzub9T7AEuP7DumvKQ
 JfzmdP4CqBl8deVC4pn3+Hlw1kVQTcUnUjN4F4GWOCaZtre5V5wNQoNcODn8pVZWIlqq4bdDb
 x8+3s3m6E6nCYZgw9XL/g677JPsEaARbjhrzX7SZeY/eQF8W+TtGiVRwFp8rgdYPbdYJTUXcS
 LqHZ6/3hdHDKH6MSwygmJJL9+cRAK/2Yl8C3HjIqKx30JZyErJNncK6cWVbTTK5J3cdL7V7dT
 Gqvp93ESXZ18+gsUfxJyWeay95Vh3U9Fec9svz+wW9kwssmKDEpwRitzaSM7GjTQR9dxZ22md
 3BXchor0Rmto9aBXkHGsqkTvMHfNYwJFXgI+jLB0pJAahIjaOq9r+5snkDznFLssvLbOYxR0Z
 v2c78zdPUj14cTcOLb608nYJSq+ZsPM0I2n3sbqNGq+DKCrGhGBbIuJI/Mojogp9UCCoFi5Nx
 8VPvpWrqP4ARVUt+7jCIFXYBzV46T34+3JLYmRAiub3LSd4oRqBEjk6fMeaONClcfqnHoYcAb
 8PBK14q1vtLBshjY2NwwpDuzx7I=
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



Am 16=2E Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa=2Eko=
jima@linaro=2Eorg>:
>Current efibootmgr automatically creates the
>boot options of all disks and partitions installing
>EFI_SIMPLE_FILE_SYSTEM_PROTOCOL=2E
>Some of the automatically created boot options are
>useless if the disk and partition does not have
>the default file(e=2Eg=2E EFI/BOOT/BOOTAA64=2EEFI)=2E
>
>This commit only creates the boot option if the disk and
>partition have the default file so that system can directly
>boot from it=2E

I don't directly see the user benefit=2E

Reading all file systems will increase the boot time=2E Shouldn't we avoid=
 this?

What does EDK II do?

Does the UEFI specification warrant this change?

Best regards

Heinrich

>
>Signed-off-by: Masahisa Kojima <masahisa=2Ekojima@linaro=2Eorg>
>---
> lib/efi_loader/efi_bootmgr=2Ec | 86 ++++++++++++++++++++++++++----------
> 1 file changed, 63 insertions(+), 23 deletions(-)
>
>diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_bootmgr=
=2Ec
>index a40762c74c=2E=2Ec8cf1c5506 100644
>--- a/lib/efi_loader/efi_bootmgr=2Ec
>+++ b/lib/efi_loader/efi_bootmgr=2Ec
>@@ -355,40 +355,70 @@ error:
>  */
> static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_m=
edia_boot_option *opt,
> 						      efi_handle_t *volume_handles,
>-						      efi_status_t count)
>+						      efi_uintn_t *count)
> {
>-	u32 i;
>+	u32 i, num =3D 0;
> 	struct efi_handler *handler;
> 	efi_status_t ret =3D EFI_SUCCESS;
>=20
>-	for (i =3D 0; i < count; i++) {
>+	for (i =3D 0; i < *count; i++) {
> 		u16 *p;
> 		u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
> 		char *optional_data;
> 		struct efi_load_option lo;
> 		char buf[BOOTMENU_DEVICE_NAME_MAX];
>-		struct efi_device_path *device_path;
>+		struct efi_device_path *device_path, *full_path, *dp, *fp;
> 		struct efi_device_path *short_dp;
>+		struct efi_file_handle *root, *f;
>+		struct efi_simple_file_system_protocol *file_system;
>+		u16 *default_file_path =3D NULL;
>=20
>-		ret =3D efi_search_protocol(volume_handles[i], &efi_guid_device_path, =
&handler);
>+		ret =3D efi_search_protocol(volume_handles[i],
>+					  &efi_guid_device_path, &handler);
> 		if (ret !=3D EFI_SUCCESS)
> 			continue;
>-		ret =3D efi_protocol_open(handler, (void **)&device_path,
>-					efi_root, NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>+
>+		device_path =3D handler->protocol_interface;
>+		full_path =3D efi_dp_from_file(device_path,
>+					     "/EFI/BOOT/" BOOTEFI_NAME);
>+
>+		/* check whether the partition or disk have the default file */
>+		ret =3D efi_dp_split_file_path(full_path, &dp, &fp);
>+		if (ret !=3D EFI_SUCCESS || !fp)
>+			goto next_entry;
>+
>+		default_file_path =3D efi_dp_str(fp);
>+		if (!default_file_path)
>+			goto next_entry;
>+
>+		ret =3D efi_search_protocol(volume_handles[i],
>+					  &efi_simple_file_system_protocol_guid,
>+					  &handler);
> 		if (ret !=3D EFI_SUCCESS)
>-			continue;
>+			goto next_entry;
>+
>+		file_system =3D handler->protocol_interface;
>+		ret =3D EFI_CALL(file_system->open_volume(file_system, &root));
>+		if (ret !=3D EFI_SUCCESS)
>+			goto next_entry;
>+
>+		ret =3D EFI_CALL(root->open(root, &f, default_file_path,
>+					  EFI_FILE_MODE_READ, 0));
>+		if (ret !=3D EFI_SUCCESS)
>+			goto next_entry;
>+
>+		EFI_CALL(f->close(f));
>=20
> 		ret =3D efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVI=
CE_NAME_MAX);
> 		if (ret !=3D EFI_SUCCESS)
>-			continue;
>+			goto next_entry;
>=20
> 		p =3D dev_name;
> 		utf8_utf16_strncpy(&p, buf, strlen(buf));
>=20
> 		/* prefer to short form device path */
>-		short_dp =3D efi_dp_shorten(device_path);
>-		if (short_dp)
>-			device_path =3D short_dp;
>+		short_dp =3D efi_dp_shorten(full_path);
>+		device_path =3D short_dp ? short_dp : full_path;
>=20
> 		lo=2Elabel =3D dev_name;
> 		lo=2Eattributes =3D LOAD_OPTION_ACTIVE;
>@@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_boot_opti=
on(struct eficonfig_media_boo
> 		lo=2Efile_path_length =3D efi_dp_size(device_path) + sizeof(END);
> 		/*
> 		 * Set the dedicated guid to optional_data, it is used to identify
>-		 * the boot option that automatically generated by the bootmenu=2E
>+		 * the boot option that automatically generated by the efibootmgr=2E
> 		 * efi_serialize_load_option() expects optional_data is null-terminate=
d
> 		 * utf8 string, so set the "1234567" string to allocate enough space
> 		 * to store guid, instead of realloc the load_option=2E
> 		 */
> 		lo=2Eoptional_data =3D "1234567";
>-		opt[i]=2Esize =3D efi_serialize_load_option(&lo, (u8 **)&opt[i]=2Elo);
>-		if (!opt[i]=2Esize) {
>-			ret =3D EFI_OUT_OF_RESOURCES;
>-			goto out;
>+		opt[num]=2Esize =3D efi_serialize_load_option(&lo, (u8 **)&opt[num]=2E=
lo);
>+		if (!opt[num]=2Esize) {
>+			efi_free_pool(full_path);
>+			efi_free_pool(dp);
>+			efi_free_pool(fp);
>+			efi_free_pool(default_file_path);
>+			return EFI_OUT_OF_RESOURCES;
> 		}
> 		/* set the guid */
>-		optional_data =3D (char *)opt[i]=2Elo + (opt[i]=2Esize - u16_strsize(u=
"1234567"));
>+		optional_data =3D (char *)opt[num]=2Elo + (opt[num]=2Esize - u16_strsi=
ze(u"1234567"));
> 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_gu=
id_t));
>+		num++;
>+
>+next_entry:
>+		efi_free_pool(full_path);
>+		efi_free_pool(dp);
>+		efi_free_pool(fp);
>+		efi_free_pool(default_file_path);
> 	}
>=20
>-out:
>-	return ret;
>+	*count =3D num;
>+
>+	return EFI_SUCCESS;
> }
>=20
> /**
>@@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_=
index)
>  * efi_bootmgr_update_media_device_boot_option() - generate the media de=
vice boot option
>  *
>  * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTE=
M_PROTOCOL
>- * and generate the bootmenu entries=2E
>+ * and create the boot option with default file if the file exists=2E
>  * This function also provide the BOOT#### variable maintenance for
>  * the media device entries=2E
>  * - Automatically create the BOOT#### variable for the newly detected d=
evice,
>@@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_opt=
ion(void)
> 		goto out;
> 	}
>=20
>-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
>-	ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
>+	ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
> 	if (ret !=3D EFI_SUCCESS)
> 		goto out;
>=20
