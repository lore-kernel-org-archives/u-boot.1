Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B667C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 05:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07818310F;
	Fri, 23 May 2025 07:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C7vUxw8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1F483164; Fri, 23 May 2025 07:24:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D9C83108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1747977883; x=1748582683; i=xypron.glpk@gmx.de;
 bh=2RzFicp2wnMxsJNGgvwQakt+7DVurRrNIxu+uAeqY2U=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=C7vUxw8/2GKFEBDP/yyh8bCgWpnpqxmdvwD3v1IvGjsR+fQFg5dNMbjZz1oHlnHc
 VjchcBi9dYaZgtOmC0nAJxa7RGsajBLd9lv7xY22aXVgRVQLZmEfRtE5g/xzpdaKg
 1fJHJVXyf/yeUUck2HOlbwQZbViDPkfcUtZoMwbV8N+ARRWEiu43y6EoFehtDcaYs
 JrLALF0vbQs060KuT3IHiinrct6CjCCuRTkbGO5Nqglz+GiCoqSCTc+k7bAfABtzF
 XDoxlr16T0ATVotK9IosyDkp/ZJPOYwEqF9o+lVUWOUBpSB6dV521W1YGyVw5cxON
 0uL5e39Ip1rUXEl/XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1v9L3b1SxE-00ttOL; Fri, 23
 May 2025 07:24:43 +0200
Date: Fri, 23 May 2025 07:24:41 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de
CC: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
User-Agent: Thunderbird for Android
In-Reply-To: <20250522011749.3498970-2-paulliu@debian.org>
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-2-paulliu@debian.org>
Message-ID: <0EE19039-64E3-44BA-AC06-CEDD1242FE90@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EiuWLG/+Y0bfwON/hrqbEcuO1bFZQT8Msn6aQcjc5MWV9nP6kuF
 YaFAbhjdHhnZVqaXSGHp1wTBxI12sNPjMWspbB/l2AGCnW0Gqz3k09nnv0uuzbJ3EwL9x1l
 wC+qlwOmsE0QyikvP1pmuBWroNEN4Z4dYnixNRqSP4zz9OnYH48NozCBHlrBjm2VTHvbiCS
 os/evBQreGKpezvKU6R+g==
UI-OutboundReport: notjunk:1;M01:P0:Xkt9vVXk6DQ=;Y2Z6jgKIFRi2cqJckjhRbCUMErI
 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
 0VeU=
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

Am 22=2E Mai 2025 03:17:45 MESZ schrieb "Ying-Chun Liu (PaulLiu)" <paulliu@=
debian=2Eorg>:
>From: "Ying-Chun Liu (PaulLiu)" <paul=2Eliu@linaro=2Eorg>
>
>Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
>the address of EFI_SYSTEM_TABLE=2E
>
>This feature is described in UEFI SPEC version 2=2E10=2E Section 18=2E4=
=2E2=2E
>The implementation ensures support for hardware-assisted debugging and
>provides a standardized mechanism for debuggers to discover the EFI
>system table=2E
>
>Signed-off-by: Ying-Chun Liu (PaulLiu) <paul=2Eliu@linaro=2Eorg>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Peter Robinson <pbrobinson@gmail=2Ecom>
>---
>V2: add Kconfig options to turn on/off this feature=2E
>V3: make efi_initialize_system_table_pointer() do the job as described=2E
>---
> include/efi_api=2Eh             | 16 ++++++++++++
> include/efi_loader=2Eh          |  2 ++
> lib/efi_loader/Kconfig        |  7 ++++++
> lib/efi_loader/efi_boottime=2Ec | 46 +++++++++++++++++++++++++++++++++++
> lib/efi_loader/efi_setup=2Ec    |  8 ++++++
> 5 files changed, 79 insertions(+)
>
>diff --git a/include/efi_api=2Eh b/include/efi_api=2Eh
>index eb61eafa028=2E=2E6c4c1a0cc7b 100644
>--- a/include/efi_api=2Eh
>+++ b/include/efi_api=2Eh
>@@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
> 	efi_status_t capsule_status;
> } __packed;
>=20
>+/**
>+ * struct efi_system_table_pointer - struct to store the pointer of syst=
em
>+ * table=2E
>+ * @signature: The signature of this struct=2E
>+ * @efi_system_table_base: The physical address of System Table=2E
>+ * @crc32: CRC32 checksum
>+ *
>+ * This struct is design for hardware debugger to search through memory =
to
>+ * get the address of EFI System Table=2E
>+ */
>+struct efi_system_table_pointer {
>+	u64 signature;
>+	efi_physical_addr_t efi_system_table_base;
>+	u32 crc32;
>+};
>+
> struct efi_memory_range {
> 	efi_physical_addr_t	address;
> 	u64			length;
>diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>index 8f9f2bcf1cb=2E=2E8f065244d8e 100644
>--- a/include/efi_loader=2Eh
>+++ b/include/efi_loader=2Eh
>@@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
> efi_status_t efi_root_node_register(void);
> /* Called by bootefi to initialize runtime */
> efi_status_t efi_initialize_system_table(void);
>+/* Called by bootefi to initialize debug */
>+efi_status_t efi_initialize_system_table_pointer(void);
> /* efi_runtime_detach() - detach unimplemented runtime functions */
> void efi_runtime_detach(void);
> /* efi_convert_pointer() - convert pointer to virtual address */
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 7f02a83e2a2=2E=2Ed878fc9021d 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
> config EFI_SIGNATURE_SUPPORT
> 	bool
>=20
>+config EFI_DEBUG_SUPPORT_TABLE
>+	bool "EFI Debug Support Table"
>+	help
>+	  Select this option if you want to setup the EFI Debug Support
>+	  Table which is used by the debug agent or an external debugger to
>+	  determine loaded image information in a quiescent manner=2E
>+
> menu "UEFI services"
>=20
> config EFI_GET_TIME
>diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_boottim=
e=2Ec
>index dbebb37dc04=2E=2E5a4349f8679 100644
>--- a/lib/efi_loader/efi_boottime=2Ec
>+++ b/lib/efi_loader/efi_boottime=2Ec
>@@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab =
=3D {
> 	=2Etables =3D NULL,
> };
>=20
>+struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D =
NULL;
>+
> /**
>  * efi_initialize_system_table() - Initialize system table
>  *
>@@ -4035,3 +4037,47 @@ efi_status_t efi_initialize_system_table(void)
>=20
> 	return ret;
> }
>+
>+/**
>+ * efi_initialize_system_table() - Initialize system table pointer
>+ *
>+ * Return:	status code
>+ */
>+efi_status_t efi_initialize_system_table_pointer(void)
>+{
>+	efi_status_t ret;
>+	const int size_4MB =3D 0x00400000;
>+	int pages =3D efi_size_in_pages(sizeof(struct efi_system_table_pointer)=
);
>+	int alignment_mask =3D size_4MB - 1;
>+	int real_pages =3D pages + efi_size_in_pages(size_4MB);
>+	u64 addr;
>+	u64 aligned_addr;
>+	u32 crc32_value;
>+
>+	/* Allocate configuration table array */
>+	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>+				 EFI_RUNTIME_SERVICES_DATA,
>+				 real_pages,
>+				 &addr);

You are allocating 8 MiB for a table that isn't even 1 KiB in size=2E

Can't we use an LMB allocation function instead and add the page to the EF=
I memory table afterwards?

Only for the EFI app and the sandbox physical and virtual addresses differ=
=2E

Best regards=20

Heinrich



>+
>+	if (ret !=3D EFI_SUCCESS) {
>+		log_err("Installing EFI system table pointer failed\n");
>+		return ret;
>+	}
>+
>+	/* alignment to 4MB boundary */
>+	aligned_addr =3D (addr + alignment_mask) & ~alignment_mask;
>+
>+	systab_pointer =3D (struct efi_system_table_pointer *)aligned_addr;
>+	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
>+
>+	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
>+	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab;
>+	systab_pointer->crc32 =3D 0;
>+	crc32_value =3D crc32(0,
>+			    (const unsigned char *)systab_pointer,
>+			    sizeof(struct efi_system_table_pointer));
>+	systab_pointer->crc32 =3D crc32_value;
>+
>+	return ret;
>+}
>diff --git a/lib/efi_loader/efi_setup=2Ec b/lib/efi_loader/efi_setup=2Ec
>index 48f91da5df7=2E=2Ea6b37d994f6 100644
>--- a/lib/efi_loader/efi_setup=2Ec
>+++ b/lib/efi_loader/efi_setup=2Ec
>@@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
> 	if (ret !=3D EFI_SUCCESS)
> 		goto out;
>=20
>+	/* Initialize system table pointer */
>+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
>+		ret =3D efi_initialize_system_table_pointer();
>+		if (ret !=3D EFI_SUCCESS) {
>+			goto out;
>+		}
>+	}
>+
> 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> 		ret =3D efi_ecpt_register();
> 		if (ret !=3D EFI_SUCCESS)

