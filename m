Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0988C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 03:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2704987666;
	Sat,  8 Jun 2024 05:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ErKlnsYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392DD88481; Sat,  8 Jun 2024 05:37:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E0A85B66
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 05:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717817856; x=1718422656; i=xypron.glpk@gmx.de;
 bh=lhlP5W/qvO7ZvH55xwb8GK7QGsDdbZ1Tr0XQKjrOU6M=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ErKlnsYX3B3ch1UX7bIgIHYeTbT/mKclboIm6pyR9OJtc6US4U7ZXLC3tOhtIKOl
 7+XymtdX7tjuyDj58cvp5Po2rqbe8X1Vb6kYAzTlI2XZQ9uNuJW+iAoJM+nn3w55i
 H8sjXb97J+GEsJfNHwj2lBd+7ALV3aPV7vYPFHTfmMsrSr6/bA75U1L5IiANMzw3S
 WbDf0AOYHH3ZxpW1XSrSY4IE2hDCah+VQrZNxLwPqd0iuVzppeJ/2u+ElI5SmtRPY
 15hPGXaDLeXnPXSqXn/x8I0O9uINe+JUcI8GjTETx7dcr/kNT7z/gpKMdoHE58zdD
 LJQXOwQB4VTXdipq5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1rywpe35kb-00Z1wQ; Sat, 08
 Jun 2024 05:37:35 +0200
Date: Sat, 08 Jun 2024 05:37:33 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_30/31=5D_temp=3A_cmd=3A_efi=5Fme?=
 =?US-ASCII?Q?m=3A_add_a_command_to_test_efi_alloc/free?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240607185240.1892031-31-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-31-sughosh.ganu@linaro.org>
Message-ID: <5BF273F8-08EB-44C9-9B59-1AAA924F4591@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ZxVE0QRzfvaQcSFcEim9ivne3c785sdFfv4JKz2znMWQ8DSx5F
 2myU7cdC63X3AoOhPCviXrNpehfvpNHmCDhIs6gWfz6KiuS7y/cT2ILygC4bZUPi4h3GV/F
 2MXYDwZSl4zFS01UF2dTYpqyyK1di7Rne2BPps2oyJF1rjRO35OjVRS0VqrMmMzirW7ChUg
 eSBdyxq+CbszKk9qSGtMg==
UI-OutboundReport: notjunk:1;M01:P0:hXb72P1uNrI=;fAdYhZ17nhBfD3gkPHlH404J06P
 ssexG23E7i3wHHaKkFupMphNflr6CWYwlmbjhIr1MzlQoxS/320K06FSOElTjZJn+GfYyOwol
 u33yWd5E/eJI0uH6H5t4OJiqKKf7uAxt0bxDC1Ru79Ndyez8jPoXbwCZ9v4P6Jd5CvhydtYQm
 0RXuMVVzjuedHfXPiLbtoP3EmQF3n3ttIznPKMX+sprbeSWj3tQ1nWasATJXPSuEz9qVMaGhy
 h4dMSjCCQeMjk8zfOxwLToEkWkALwPvE0C1Tu9i9mh4ApeEkzv8+m/iINY9TeNJveV/qqhq+F
 Np4ZeFEyK+iGwk3x+ckcFBQeUtzQVcG7iiKIAWYvNgc+rNou+LLb2veqa5C4EPHWI7Y3ADYwH
 +wYF//pFRtABW3ck+NeXHxAOJuIMMgPNq3KGCeO05bdVL9NlWeFrNsUlE8PHKj9S/r/oVQLjU
 F8F8F6PkRbLbl3HA9uTvJYO+IFkoVcXUzbtENjlYc3sTQtnhpheeoNcVlTPUMUiX25OjwK/F4
 Z6JbUO6Z46fxtHb1gnVwtg4tpVAKxAdz+7iDebou9Cc6bT1ag1oBYJHblNDPIZeswd8ontZ/m
 QF5bPdsISRWMbZxjjQToBvTJ0pVjWpThn2fsZ5VUWQnOipMNTdvl4fBCJMRtwfb/UnFy+rMAn
 YEhGMkcXBcjr8ElIwffe7aZw4F51cspZIELyA9DFNm6PAGlWUSOx+cKF9Bv5rArVGFlzzJip/
 Ud3bk9V7cN3ElzyFAC/cLAuo1qvRhkzCgvzv3Jz1KnH5XjPzA9bzon08K3Fh3IP7qn8Ignnbo
 Sys0QzY5qwgwCcTpOM+daNF2M6TFbfcFUjU6xLTOPk7qI=
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



Am 7=2E Juni 2024 20:52:39 MESZ schrieb Sughosh Ganu <sughosh=2Eganu@linar=
o=2Eorg>:
>Not for committing=2E

Best put "DON'T MERGE" into the title to avoid mishaps in future versions=
=2E

In the final series we should have unit test covering all relevant aspects=
 of the memory system=2E

Best regards

Heinrich

>
>Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>---
> cmd/Makefile     |   1 +
> cmd/efi_memory=2Ec | 155 +++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 156 insertions(+)
> create mode 100644 cmd/efi_memory=2Ec
>
>diff --git a/cmd/Makefile b/cmd/Makefile
>index 87133cc27a=2E=2E35fcc4af5a 100644
>--- a/cmd/Makefile
>+++ b/cmd/Makefile
>@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) +=3D bootm=2Eo
> obj-y +=3D help=2Eo
> obj-y +=3D panic=2Eo
> obj-y +=3D version=2Eo
>+obj-y +=3D efi_memory=2Eo
>=20
> # command
> obj-$(CONFIG_CMD_ARMFFA) +=3D armffa=2Eo
>diff --git a/cmd/efi_memory=2Ec b/cmd/efi_memory=2Ec
>new file mode 100644
>index 0000000000=2E=2E52ddcb7146
>--- /dev/null
>+++ b/cmd/efi_memory=2Ec
>@@ -0,0 +1,155 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ *  Allocate and Free EFI memory
>+ *
>+ *  Copyright (c) 2024 Linaro Limited
>+ */
>+
>+#include <command=2Eh>
>+#include <efi_loader=2Eh>
>+#include <lmb=2Eh>
>+#include <vsprintf=2Eh>
>+
>+#include <linux/types=2Eh>
>+
>+static int do_efi_mem_free(struct cmd_tbl *cmdtp, int flag, int argc,
>+			   char * const argv[])
>+{
>+	uint64_t addr =3D 0, size =3D 0;
>+	efi_uintn_t pages;
>+	efi_status_t status;
>+
>+	if (argc !=3D 3)
>+		return CMD_RET_USAGE;
>+
>+	argc--; argv++;
>+
>+	size =3D simple_strtoul(argv[0], NULL, 16);
>+	if (!size) {
>+		printf("Enter valid size for free in Hex\n");
>+		return CMD_RET_USAGE;
>+	}
>+
>+=09
>+	addr =3D simple_strtoul(argv[1], NULL, 16);
>+	if (!addr) {
>+		printf("Enter a valid address in Hex\n");
>+		return CMD_RET_USAGE;
>+	}
>+
>+	pages =3D efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
>+
>+	status =3D efi_free_pages(addr, pages);
>+	if (status !=3D EFI_SUCCESS) {
>+		printf("Unable to free memory, error (%#lx)\n", status);
>+		return CMD_RET_FAILURE;
>+	}
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
>+static int do_efi_mem_alloc(struct cmd_tbl *cmdtp, int flag, int argc,
>+			    char * const argv[])
>+{
>+	enum efi_allocate_type type;
>+	uint64_t addr =3D 0, size =3D 0;
>+	efi_uintn_t pages;
>+	efi_status_t status;
>+	bool max =3D false;
>+
>+	if (argc < 2)
>+		return CMD_RET_USAGE;
>+
>+	argc--; argv++;
>+
>+	if (!strcmp("max", argv[0])) {
>+		if (argc !=3D 3)
>+			return CMD_RET_USAGE;
>+
>+		max =3D true;
>+		argv++;
>+		argc--;
>+	}
>+
>+	size =3D simple_strtoul(argv[0], NULL, 16);
>+	if (!size) {
>+		printf("Enter valid size for allocation in Hex\n");
>+		return CMD_RET_USAGE;
>+	}
>+
>+	if (max || argc =3D=3D 2) {
>+		addr =3D simple_strtoul(argv[1], NULL, 16);
>+		if (!addr) {
>+			printf("Enter a valid address in Hex\n");
>+			return CMD_RET_USAGE;
>+		}
>+	}
>+
>+	if (max)
>+		type =3D EFI_ALLOCATE_MAX_ADDRESS;
>+	else if (addr)
>+		type =3D EFI_ALLOCATE_ADDRESS;
>+	else
>+		type =3D EFI_ALLOCATE_ANY_PAGES;
>+
>+	pages =3D efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
>+	status =3D efi_allocate_pages(type, EFI_BOOT_SERVICES_DATA, pages,
>+				    &addr);
>+	if (status !=3D EFI_SUCCESS) {
>+		printf("efi_allocate_pages failed %lx\n", status);
>+		return CMD_RET_FAILURE;
>+	} else {
>+		printf("Address returned %#llx\n", addr);
>+	}
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
>+static struct cmd_tbl cmd_efi_mem_sub[] =3D {
>+	U_BOOT_CMD_MKENT(alloc, 3, 0, do_efi_mem_alloc,
>+		"", ""),
>+	U_BOOT_CMD_MKENT(free, 2, 0, do_efi_mem_free,
>+		"", ""),
>+};
>+
>+static int do_efi_mem(struct cmd_tbl *cmdtp, int flag, int argc,
>+		      char *const argv[])
>+{
>+	struct cmd_tbl *cp;
>+	efi_status_t r;
>+
>+	if (argc < 3)
>+		return CMD_RET_USAGE;
>+
>+	argc--; argv++;
>+
>+	/* Initialize UEFI subsystem */
>+	r =3D efi_init_obj_list();
>+	if (r !=3D EFI_SUCCESS) {
>+		printf("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
>+		       r & ~EFI_ERROR_MASK);
>+		return CMD_RET_FAILURE;
>+	}
>+
>+	cp =3D find_cmd_tbl(argv[0], cmd_efi_mem_sub,
>+			  ARRAY_SIZE(cmd_efi_mem_sub));
>+	if (!cp)
>+		return CMD_RET_USAGE;
>+
>+	return cp->cmd(cmdtp, flag, argc, argv);
>+}
>+
>+U_BOOT_LONGHELP(efi_mem,
>+	"Functions to allocate and free memory\n"
>+	"\n"
>+	"efi_mem alloc <size> [addr]\n"
>+	"efi_mem alloc max <size> <max-addr>\n"
>+	"efi_mem free <size> <addr>\n"
>+	"\n"
>+);
>+
>+U_BOOT_CMD(
>+	efi_mem, CONFIG_SYS_MAXARGS, 0, do_efi_mem,
>+	"Allocate and free EFI memory",
>+	efi_mem_help_text
>+);
