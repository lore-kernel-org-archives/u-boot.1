Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C8C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 03:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8E988256;
	Sat,  8 Jun 2024 05:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TfZU7uyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9AA882A5; Sat,  8 Jun 2024 05:28:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0A988047
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 05:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717817326; x=1718422126; i=xypron.glpk@gmx.de;
 bh=DYZvpAxFHeIuvACWU7NqTfObjuny60eZiS/Ly1MBffI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TfZU7uyCIOhCZaJM/TsplvNCoBYQr7fOlC8Aq+TJPd7NuXKxqzDjcyI6Aa/j15iL
 reS2bBgF8Gfq+maZzfgTPE0wJMWRUVWZYQ0y1yW6G41nGutKmVKmYMV1eW0ActnsB
 1sdakz8panKKT7aPYdJuQoDmKLFQYBqVL4pQpoaTUhJ560+neIkBlRkgbGE99t0Ij
 UcTcD1/nlUljX+YPbhrQkqqeSm/jTyXblyqkMgUS6KcoEO0oWo4wZRmnNg/C9km9Q
 fqUMOj5LNDRw7y9Uytq5tfX3kyzAOi3ZdOm8SpvCQZ6ero2luvHMLfnpfjjFymoa8
 kWKPEZygzRW04Nx+4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.178.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1s8w3b1LK5-009VkT; Sat, 08
 Jun 2024 05:28:46 +0200
Date: Sat, 08 Jun 2024 05:28:44 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_31/31=5D_temp=3A_cmd=3A_efi=3A?=
 =?US-ASCII?Q?_add_a_command_to_dump_EFI_memory_map?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240607185240.1892031-32-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-32-sughosh.ganu@linaro.org>
Message-ID: <D859DD98-73B6-4E7D-BE36-5442845F3FE9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qPTSsIJERfS+TXmkErl0IGBrTDzIy4A3LHMotSfF/fk7L+bZ59E
 kUxmKQxalGevJ1Z466lecILD+MF/fdeiVDegvoyRwvCshNlux8w5pazNZCCGdYUX1S7i34V
 uD5lyzHaxfSMyMcnrv4fGx9m9IAkU5V7dmchd2Ag/PxrdFoXlW4lJg3a6EtOTPgkiwhRtNG
 aUEwBnmPuZUW5AHp8sVVQ==
UI-OutboundReport: notjunk:1;M01:P0:xPtjqFXQsrg=;LWAuDpqd3kIb5exuy0ZUVTOQNXp
 vHEZMqFKgSOvW5Op3R1kYiD4aZB5I0xJDnO5a3HykJEPkONWepiRqNSBXAYgc29bdyoZDfMRG
 JcxHtVIyw3ziFwGbgv8M/hppQFJINicMkKyc4e9gwNW4qQyVHX8xL2lKhBMqeUKgO+6Bhio+w
 R+In3ahHgoymutNC0uIFqvY6p2koIr0sT0iJbmhrKvXDDuUYM7Gn/bqkSutCtLoqo2cR/3WG8
 T8YD8Po6TjQZ1XMl98UeCnKeX/rrPMfwr1wkbL6hhR3QiGKMFT4jMRsK+shtXmPekWTvdXkpp
 oi4ODKlQscf4gAqharqppB1nPtJaSjZrQEe0zp5FKkn2GxlVjZR82iuGwboC9AMSb8RrXmGuc
 BKJsTaIG/PKkXqGggLN4hWaOznxwePabuD5f6M9WEZpPGz1vTJvPdR8ACxXhl1iFB2syL5EVl
 OiPRfMj98JUk3g592Il/feIwpprc7xMc5Zjvvc0oSXlMPcPxhDwME0KLBMtjyaDz4IW6uQGeY
 v0ciUFLFn8hUCSnPdORy7+QCeJZQQXHTeWr+yH1eJfQOb+kEu1KPgyFGFSqthGNvWY2cwLhXc
 EisS8iuPLwz5MTu4+mUdGpEXcTvH1qSgXXt5rPEVeGmC7t2HRbfUOlS6bC7LB8rX0Tmfkmq7p
 1hpfH1eNYbXG+RtE0Eea64GTSKEStb1JHfA8S33yIYTO1a7BO+FiWcL+vEmv9Y4kZB+FA4um/
 2wqfCn7pH7ptFRH5U+5RhMqi59WJB3bAZZBY1EYFH8IOjYVSs7LnD6p366TyJ5gYmcsFgrKnD
 ODtJ+AKw32/5pyXAXtRrXdvhJDAFIrXdtfHxTb23Kn8AQ=
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



Am 7=2E Juni 2024 20:52:40 MESZ schrieb Sughosh Ganu <sughosh=2Eganu@linar=
o=2Eorg>:
>Add a command to dump the EFI memory map=2E

What are you missing in 'efidebug memmap'?

Best regards

Heinrich

>
>Not for committing=2E
>
>Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>---
> cmd/Makefile                |  1 +
> cmd/efi_map_dump=2Ec          | 28 ++++++++++++++++++++++++++++
> include/efi_loader=2Eh        |  2 ++
> lib/efi_loader/efi_memory=2Ec | 32 ++++++++++++++++++++++++++++++++
> 4 files changed, 63 insertions(+)
> create mode 100644 cmd/efi_map_dump=2Ec
>
>diff --git a/cmd/Makefile b/cmd/Makefile
>index 35fcc4af5a=2E=2E315046def6 100644
>--- a/cmd/Makefile
>+++ b/cmd/Makefile
>@@ -11,6 +11,7 @@ obj-y +=3D help=2Eo
> obj-y +=3D panic=2Eo
> obj-y +=3D version=2Eo
> obj-y +=3D efi_memory=2Eo
>+obj-y +=3D efi_map_dump=2Eo
>=20
> # command
> obj-$(CONFIG_CMD_ARMFFA) +=3D armffa=2Eo
>diff --git a/cmd/efi_map_dump=2Ec b/cmd/efi_map_dump=2Ec
>new file mode 100644
>index 0000000000=2E=2Ef2a5932767
>--- /dev/null
>+++ b/cmd/efi_map_dump=2Ec
>@@ -0,0 +1,28 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ *  Allocate and Free EFI memory
>+ *
>+ *  Copyright (c) 2024 Linaro Limited
>+ */
>+
>+#include <command=2Eh>
>+#include <efi_loader=2Eh>
>+
>+static int do_efi_map_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>+			   char *const argv[])
>+{
>+//	printf("%s: argc =3D> %d\n", __func__, argc);
>+
>+	if (argc !=3D 1)
>+		return CMD_RET_USAGE;
>+
>+	dump_efi_memory_map();
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
>+U_BOOT_CMD(
>+	efi_map_dump, 1, 0, do_efi_map_dump,
>+	"Dump the EFI memory map",
>+	""
>+);
>diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>index 9600941aa3=2E=2E40f894f182 100644
>--- a/include/efi_loader=2Eh
>+++ b/include/efi_loader=2Eh
>@@ -791,6 +791,8 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_m=
ap_size,
> 				uint32_t *descriptor_version);
> /* Adds a range into the EFI memory map */
> efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>+/* Dump the contents of the EFI memory map */
>+void dump_efi_memory_map(void);
> /* Adds a conventional range into the EFI memory map */
> efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> 					     u64 ram_top);
>diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader/efi_memory=2E=
c
>index 93244161b0=2E=2E7ab1b86140 100644
>--- a/lib/efi_loader/efi_memory=2Ec
>+++ b/lib/efi_loader/efi_memory=2Ec
>@@ -47,6 +47,8 @@ static LIST_HEAD(efi_mem);
> void *efi_bounce_buffer;
> #endif
>=20
>+static uint64_t desc_get_end(struct efi_mem_desc *desc);
>+
> /**
>  * struct efi_pool_allocation - memory block allocated from pool
>  *
>@@ -118,6 +120,36 @@ static int lmb_mem_map_update_sync(void *ctx, struct=
 event *event)
> EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> #endif /* MEM_MAP_UPDATE_NOTIFY */
>=20
>+static void dump_efi_mem_desc(struct efi_mem_desc *desc)
>+{
>+	u64 end;
>+
>+	end =3D desc_get_end(desc);
>+
>+	printf("-----------------------------------\n");
>+	printf("Memory Range   [0x%llx - 0x%llx]\n",
>+	       desc->physical_start, end);
>+	printf("Num Pages      [0x%llx]\n", desc->num_pages);
>+	printf("Memory Type    [0x%x]\n", desc->type);
>+	printf("Attribute      [0x%llx]\n", desc->attribute);
>+	printf("-----------------------------------\n");
>+}
>+
>+void dump_efi_memory_map(void)
>+{
>+	struct list_head *lhandle;
>+
>+	list_for_each(lhandle, &efi_mem) {
>+		struct efi_mem_list *lmem;
>+		struct efi_mem_desc *desc;
>+
>+		lmem =3D list_entry(lhandle, struct efi_mem_list, link);
>+		desc =3D &lmem->desc;
>+
>+		dump_efi_mem_desc(desc);
>+	}
>+}
>+
> /**
>  * checksum() - calculate checksum for memory allocated from pool
>  *
