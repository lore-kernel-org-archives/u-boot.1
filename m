Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144CD1BDF0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7608C88E6E;
	Mon,  4 Nov 2024 21:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DFeiEWxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226B688E7B; Mon,  4 Nov 2024 21:38:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC7088E1C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730752678; x=1731357478; i=xypron.glpk@gmx.de;
 bh=W3eha4sqF+PUKSlDQUaZtwv10wuL5fOAV9PDMI2WvCE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DFeiEWxlHbnYSjTRV0KmlkrYileQAY3iYWl45qGGbMj0RonhLVDSBcpU04dNNhnI
 g66qU1VqSDoc+7jRQekjU/ayDdvEcA/Hy7gxamsoqh3wVDxri9GblDArv3V/R4p3T
 F/XYQ6r30OoROWAbx++nlZjwgK/bAxenI5/ugNXeIqw1JuMorN2XeDLOMuovHYjoc
 wRFjrpEcn2KSneQOVBqllkoUz+DhXbej6LZ38vjTGfOu+qVt49jZqY1IjKUYgoG14
 qAoDLaIU2zaj7mNJVMOyJXncPETp4JLqSj3UQJD92znF/OFNkOQGTf/7mWU8Wg1ue
 +35C0gE9IS66dpJdMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.108.63]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1tvRUR19mv-00zmio; Mon, 04
 Nov 2024 21:37:58 +0100
Date: Mon, 04 Nov 2024 21:37:56 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/9=5D_sandbox=3A_efi=5Floader=3A?=
 =?US-ASCII?Q?_Correct_use_of_addresses_as_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104133954.840994-2-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-2-sjg@chromium.org>
Message-ID: <183A3E20-0AA1-4E07-A376-5BE270080357@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YEei7DWp7Vv7zehjs5wiv6XJU7+gkzLxlpa7C46bMMw2u0WvmWv
 PtYTmyw3Y9lGXwwtPylKha5JNvLsFQ3LIO11orSYITy+GfpVVSUUwxU61fTePu79EPJnFAu
 L70i04aoABHwAU5/uWUyQke0v5kgoFuBWHF+7uGApSacULOE7L7S5G+F5UVPXoF/SCA8wTX
 Fu49twLRaI39ZB9VjgcoQ==
UI-OutboundReport: notjunk:1;M01:P0:L2xmH2j9gfw=;fi/Le7N/jnuzgP1QPrC8D55ZpXj
 I9JATM9Uy98VhAMU/pgv/dhqPdeoRtBE0uIyfwDG41Jsa/amAvi560/kxzJc7D+7MnWSq1Ax+
 Mnod8uoKq+4gVFe0pCSZCVCaPoWowjrD+707lN6t/QrOoVvT/f5dFd0FMpTThF1Dm1bF6ftee
 94jZASwAxwY+m5uYfDI+JK2QN8EtfWSAdHR/ExNbOkWGAKMs2WLRCKb7dhJ68rJVoTztSB1tJ
 vZ6sNO3Udmayk+iaATBhWMui83VevyqsAsjIf+mOQEplqVe/jL955+NWPcPMADTfJiFt0fU36
 s0iHRtTsdHCk46GyvZHzdStz6Ma5XIRG+f73l+FUda+ZhEXGl8eux8WAzapXQdSNeoup5ag5K
 /gyj6Z/hN3I/djExoG9flu1Shl4U0LOR2S/ucngYTCGTwmEpgjAih38HXUX/AX1RScga9aB7B
 aZ3q37VJ3Wlj2gpBTANX5VvF22pC5BFj+WbZtGi5hrjsUhJhhCijizqkHSSYVnEO19gESwO88
 j5WUbOoU4So1Mu6n9VWRXRBxZoR0gGLZhL+Mcu/ZmFmFJlWqfLM1hiQVg76g1/9/fTCUQbu7v
 a4cuStvvTM32iCy/gztQIafkso1tkn6IR6H1RD5UVB0AvYdLyE3F1Rf8jKRuxTtiQKMd8rGT9
 f2HuL0RBtwJ8e/l2t9pyHsvDcbxzvTQATnwVbXdYg3o3+q7gkzhpvY3FAhTuecSEcWT2avRIW
 0bOl50vj3h0YtrrW2IiERgDCmkuYoiKdQQR3UbkGSgeb5a5jJRhf9Qcw+ugbF1t0llMBq6zzY
 NNVS5gJCFrv667/no0THQsEQ==
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



Am 4=2E November 2024 14:39:45 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>The cache-flush function is incorrect which causes a crash in the
>remoteproc tests with arm64=2E
>
>Fix both problems by using map_sysmem() to convert an address to a
>pointer and map_to_sysmem() to convert a pointer to an address=2E
>
>Also update the image-loader's cache-flushing logic=2E
>
>As discussed some time ago, it would be good to update the way
>EFI_LOADER uses addresses and pointers, particularly around memory
>allocation=2E Ideally we would use addresses internally, with pointers
>only exposed via the external API, even where pointers are in fact
>u64 values=2E

No, we should get rid of sandbox virtual addresses where possible, e=2Eg=
=2E in LMB=2E

They are are only relevant for the sandbox's command line interface and de=
vice-tree=2E

This will minimize the number of conversions, which only satisfy the needs=
 of the sandbox and have no relevance on real systems including QEMU=2E

Do not wag the dog with the tail=2E

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
>---
>
> arch/sandbox/cpu/cache=2Ec              |  8 +++++++-
> drivers/remoteproc/rproc-elf-loader=2Ec | 18 +++++++++++-------
> lib/efi_loader/efi_image_loader=2Ec     |  3 ++-
> 3 files changed, 20 insertions(+), 9 deletions(-)
>
>diff --git a/arch/sandbox/cpu/cache=2Ec b/arch/sandbox/cpu/cache=2Ec
>index c8a5e64214b=2E=2E96b3da47e8e 100644
>--- a/arch/sandbox/cpu/cache=2Ec
>+++ b/arch/sandbox/cpu/cache=2Ec
>@@ -4,12 +4,18 @@
>  */
>=20
> #include <cpu_func=2Eh>
>+#include <mapmem=2Eh>
> #include <asm/state=2Eh>
>=20
> void flush_cache(unsigned long addr, unsigned long size)
> {
>+	void *ptr;
>+
>+	ptr =3D map_sysmem(addr, size);
>+
> 	/* Clang uses (char *) parameters, GCC (void *) */
>-	__builtin___clear_cache((void *)addr, (void *)(addr + size));
>+	__builtin___clear_cache(map_sysmem(addr, size), ptr + size);
>+	unmap_sysmem(ptr);
> }
>=20
> void invalidate_icache_all(void)
>diff --git a/drivers/remoteproc/rproc-elf-loader=2Ec b/drivers/remoteproc=
/rproc-elf-loader=2Ec
>index ab1836b3f07=2E=2E0b3941b7798 100644
>--- a/drivers/remoteproc/rproc-elf-loader=2Ec
>+++ b/drivers/remoteproc/rproc-elf-loader=2Ec
>@@ -6,6 +6,7 @@
> #include <dm=2Eh>
> #include <elf=2Eh>
> #include <log=2Eh>
>+#include <mapmem=2Eh>
> #include <remoteproc=2Eh>
> #include <asm/cache=2Eh>
> #include <dm/device_compat=2Eh>
>@@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsig=
ned long addr, ulong size)
> 	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
> 		void *dst =3D (void *)(uintptr_t)phdr->p_paddr;
> 		void *src =3D (void *)addr + phdr->p_offset;
>+		ulong dst_addr;
>=20
> 		if (phdr->p_type !=3D PT_LOAD)
> 			continue;
>@@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, uns=
igned long addr, ulong size)
> 		if (phdr->p_filesz !=3D phdr->p_memsz)
> 			memset(dst + phdr->p_filesz, 0x00,
> 			       phdr->p_memsz - phdr->p_filesz);
>-		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>-			    roundup((unsigned long)dst + phdr->p_filesz,
>+		dst_addr =3D map_to_sysmem(dst);
>+		flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
>+			    roundup(dst_addr + phdr->p_filesz,
> 				    ARCH_DMA_MINALIGN) -
>-			    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>+			    rounddown(dst_addr, ARCH_DMA_MINALIGN));
> 	}
>=20
> 	return 0;
>@@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, u=
long fw_addr,
> 	const struct dm_rproc_ops *ops;
> 	Elf32_Shdr *shdr;
> 	void *src, *dst;
>+	ulong dst_addr;
>=20
> 	shdr =3D rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> 	if (!shdr)
>@@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev,=
 ulong fw_addr,
> 		(ulong)dst, *rsc_size);
>=20
> 	memcpy(dst, src, *rsc_size);
>-	flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>-		    roundup((unsigned long)dst + *rsc_size,
>-			    ARCH_DMA_MINALIGN) -
>-		    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
>+	dst_addr =3D map_to_sysmem(dst);
>+	flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
>+		    roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
>+		    rounddown(dst_addr, ARCH_DMA_MINALIGN));
>=20
> 	return 0;
> }
>diff --git a/lib/efi_loader/efi_image_loader=2Ec b/lib/efi_loader/efi_ima=
ge_loader=2Ec
>index 0ddf69a0918=2E=2Ebb58cf1badb 100644
>--- a/lib/efi_loader/efi_image_loader=2Ec
>+++ b/lib/efi_loader/efi_image_loader=2Ec
>@@ -13,6 +13,7 @@
> #include <efi_loader=2Eh>
> #include <log=2Eh>
> #include <malloc=2Eh>
>+#include <mapmem=2Eh>
> #include <pe=2Eh>
> #include <sort=2Eh>
> #include <crypto/mscode=2Eh>
>@@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj =
*handle,
> 	}
>=20
> 	/* Flush cache */
>-	flush_cache((ulong)efi_reloc,
>+	flush_cache(map_to_sysmem(efi_reloc),
> 		    ALIGN(virt_size, EFI_CACHELINE_SIZE));
>=20
> 	/*
