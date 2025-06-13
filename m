Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8790AC61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BCB82CA0;
	Fri, 13 Jun 2025 14:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pjvzhiH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C883A82CA6; Fri, 13 Jun 2025 14:56:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1A2807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749819387; x=1750424187; i=xypron.glpk@gmx.de;
 bh=IXAR4N6RKc0UQ076+SlqXMaMQ1X4W89JL+wpPQIKKYU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pjvzhiH29zHjiT4cRMyw4nYnSzlbyRSNvuXtQj0xvz+BuQ4dZNufOw7AdXwF0g/M
 qmAESGVhGJDFq8PwccA+W4gLcn1K7tdJx9zsbdKq+m4qNU6loGvopC6avWvYkRytH
 GcypIrz6D+gwoJZk/kJnX0H3uM94XCpxWDHWIuTVjuqa2XkrEHSGRPU6GcAALHRyE
 cOOSfx4o6hxjrhKlQGT2t2gZqgNngnVvShn8iu0qbPmAMK/YcB3J//j2V9J2fVtSN
 ktioEq0AP32ZRbOkNnamDwbQprNGOvwan0fMB4gJTTMuZtAWs5LyGs3wqXlNvzpk0
 Xpg/X31i2P0aqCLrww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([61.8.138.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1uWPCf29Cp-001TJV; Fri, 13
 Jun 2025 14:56:26 +0200
Date: Fri, 13 Jun 2025 14:56:24 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
CC: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_efi=5Floader=3A_disk=3A_ad?=
 =?US-ASCII?Q?d_EFI=5FPARTITION=5FINFO=5FPROTOCOL_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250613085742.796015-4-javierm@redhat.com>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
Message-ID: <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EFoaJPVE0fm0tin9Pc89ThDI/TCOeOguYhIsUfDpFLUdUSvYQ8A
 k6gAQA64VA2fvd2pou5o6zih+ZxEhU39hnuJvwmrsKwD0qUdvcPcA0D2f5dd7yqTmBB/iSo
 /gVHsjyNFEL0vKAJcmD5eWfNYW0mmwvz04pGiZ97zEWjAJE+M7o+/y+MKEn1FmNM4j3QFZX
 bbloRzmlLWpuCnm1nBwxw==
UI-OutboundReport: notjunk:1;M01:P0:DFJY7BmVlxM=;iwEEKjDWuDwz4QpJnwW9xMXosqR
 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
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

Am 13=2E Juni 2025 10:57:38 MESZ schrieb Javier Martinez Canillas <javierm@=
redhat=2Ecom>:
>The UEFI 2=2E10 specification mentions that this protocol shall be instal=
led
>along with EFI_BLOCK_IO_PROTOCOL=2E It provides cached partition informat=
ion
>for MBR and GPT partition types=2E

U-Boot is targeting the EBBR specifcation which defines a subset of UEFI=
=2E

Which application needs this protocol?
Are you planning to add it to the EBBR specification?

Best regards=20

Heinrich=20



>
>This patch just implements support for GPT partition types=2E The legacy =
MBR
>partition types is only needed for backward compatibility and can be adde=
d
>as a follow-up if needed, to make it fully compliant with the EFI spec=2E
>
>Signed-off-by: Javier Martinez Canillas <javierm@redhat=2Ecom>
>---
>
> include/part_efi=2Eh        | 20 ++++++++++++++++++++
> lib/efi_loader/efi_disk=2Ec | 38 ++++++++++++++++++++++++++++++++++++--
> 2 files changed, 56 insertions(+), 2 deletions(-)
>
>diff --git a/include/part_efi=2Eh b/include/part_efi=2Eh
>index 59b7895b8a23=2E=2Efb402df6f13e 100644
>--- a/include/part_efi=2Eh
>+++ b/include/part_efi=2Eh
>@@ -138,4 +138,24 @@ typedef struct _legacy_mbr {
> 	__le16 signature;
> } __packed legacy_mbr;
>=20
>+#define EFI_PARTITION_INFO_PROTOCOL_GUID \
>+	EFI_GUID(0x8cf2f62c, 0xbc9b, 0x4821, 0x80, \
>+		 0x8d, 0xec, 0x9e, 0xc4, 0x21, 0xa1, 0xa0)
>+
>+#define EFI_PARTITION_INFO_PROTOCOL_REVISION 0x0001000
>+#define PARTITION_TYPE_OTHER 0x00
>+#define PARTITION_TYPE_MBR 0x01
>+#define PARTITION_TYPE_GPT 0x02
>+
>+struct efi_partition_info {
>+	u32 revision;
>+	u32 type;
>+	u8 system;
>+	u8 reserved[7];
>+	union {
>+		struct partition mbr;
>+		gpt_entry gpt;
>+	} info;
>+} __packed;
>+
> #endif	/* _DISK_PART_EFI_H */
>diff --git a/lib/efi_loader/efi_disk=2Ec b/lib/efi_loader/efi_disk=2Ec
>index 47b583cc5e12=2E=2Eba41b77b9d1c 100644
>--- a/lib/efi_loader/efi_disk=2Ec
>+++ b/lib/efi_loader/efi_disk=2Ec
>@@ -26,6 +26,7 @@ struct efi_system_partition efi_system_partition =3D {
>=20
> const efi_guid_t efi_block_io_guid =3D EFI_BLOCK_IO_PROTOCOL_GUID;
> const efi_guid_t efi_system_partition_guid =3D PARTITION_SYSTEM_GUID;
>+const efi_guid_t efi_partition_info_guid =3D EFI_PARTITION_INFO_PROTOCOL=
_GUID;
>=20
> /**
>  * struct efi_disk_obj - EFI disk object
>@@ -35,6 +36,7 @@ const efi_guid_t efi_system_partition_guid =3D PARTITIO=
N_SYSTEM_GUID;
>  * @media:	block I/O media information
>  * @dp:		device path to the block device
>  * @volume:	simple file system protocol of the partition
>+ * @info:	EFI partition info protocol interface
>  */
> struct efi_disk_obj {
> 	struct efi_object header;
>@@ -42,6 +44,7 @@ struct efi_disk_obj {
> 	struct efi_block_io_media media;
> 	struct efi_device_path *dp;
> 	struct efi_simple_file_system_protocol *volume;
>+	struct efi_partition_info info;
> };
>=20
> /**
>@@ -426,6 +429,7 @@ static efi_status_t efi_disk_add_dev(
> 	/* Fill in object data */
> 	if (part_info) {
> 		struct efi_device_path *node =3D efi_dp_part_node(desc, part);
>+		struct efi_partition_info *info =3D &diskobj->info;
> 		struct efi_handler *handler;
> 		void *protocol_interface;
>=20
>@@ -454,18 +458,47 @@ static efi_status_t efi_disk_add_dev(
> 			goto error;
> 		}
>=20
>+		info->revision =3D EFI_PARTITION_INFO_PROTOCOL_REVISION;
>+
>+		switch (desc->part_type) {
>+		case PART_TYPE_EFI:
>+			info->type =3D PARTITION_TYPE_GPT;
>+			ret =3D part_get_gpt_pte(desc, part, &info->info=2Egpt);
>+			if (ret) {
>+				log_debug("get PTE for part %d failed %ld\n",
>+					  part, ret);
>+				goto error;
>+			}
>+
>+			break;
>+		case PART_TYPE_DOS:
>+			info->type =3D PARTITION_TYPE_MBR;
>+
>+			/* TODO: implement support for MBR partition types */
>+			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
>+
>+			break;
>+		default:
>+			info->type =3D PARTITION_TYPE_OTHER;
>+
>+			break;
>+		}
>+
> 		diskobj->dp =3D efi_dp_append_node(dp_parent, node);
> 		efi_free_pool(node);
> 		diskobj->media=2Elast_block =3D part_info->size - 1;
>-		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
>+		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
> 			esp_guid =3D &efi_system_partition_guid;
>+			info->system =3D 1;
>+		}
>+
> 	} else {
> 		diskobj->dp =3D efi_dp_from_part(desc, part);
> 		diskobj->media=2Elast_block =3D desc->lba - 1;
> 	}
>=20
> 	/*
>-	 * Install the device path and the block IO protocol=2E
>+	 * Install the device path, the block IO and partition info protocols=
=2E
> 	 *
> 	 * InstallMultipleProtocolInterfaces() checks if the device path is
> 	 * already installed on an other handle and returns EFI_ALREADY_STARTED
>@@ -476,6 +509,7 @@ static efi_status_t efi_disk_add_dev(
> 					&handle,
> 					&efi_guid_device_path, diskobj->dp,
> 					&efi_block_io_guid, &diskobj->ops,
>+					&efi_partition_info_guid, &diskobj->info,
> 					/*
> 					 * esp_guid must be last entry as it
> 					 * can be NULL=2E Its interface is NULL=2E

