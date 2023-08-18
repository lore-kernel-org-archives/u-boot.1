Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F7C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 01:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB17086BFF;
	Fri, 18 Aug 2023 03:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XoD3C436";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9E586C20; Fri, 18 Aug 2023 03:14:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B4286BF8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 03:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692321270; x=1692926070; i=xypron.glpk@gmx.de;
 bh=1oEYBIrcl/f6GJ09rR/pZxhZ9kISjo6vDyu92lyC2iQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=XoD3C436p46IhSPCuzGo864S0cHP1EQVznWCVZs7Yx6NoURosU2EGbQ8EjKvcdS8ZQ23eaL
 pzBHbdOKIQZ2cQwe1abdlbRp9FbmPljyjFG4HEjDJyNVB0YhHMeTy8IlV20kTkv8sqnrbB4Zt
 0zYN+vmuHHZkMM6H+GMnCBkUyqZtvYjh/wd+mc4dv/pYNJFwg+aJsgR8gpzHztHuBfX7gE3E0
 Kb53BslJTpFxuqZoCr7HcsakjqFPHe2LisPrw+o2j3nG01xxO9zASmuJKhYmAs4Kd2NInwnni
 QP2Ua4zER5Dpak78qTOL64MEiL8/HWh3lcJ6yHan1RNDrEsyrvaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1qDUES0yYQ-00JKJT; Fri, 18
 Aug 2023 03:14:30 +0200
Date: Fri, 18 Aug 2023 03:14:33 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 14/20] efi: x86: Use the installed SMBIOS tables
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818002706.853550-15-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-15-sjg@chromium.org>
Message-ID: <DC7E1FFE-0327-425D-A9E9-D8C22188F93A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sr+8xoSxzMLe4zBKs+084nR8gUP+d12Pnwi1uX2z3hP04uYl5o2
 0zMPWe9VCEjJsnpvrd8Jx2IAxQcQFANQ1hM43+Vk1LYKj4HCYbbDwAB4PKCKfbCWpV2iZ3e
 fELyEecMhu5HX98Wlpqof/Lp/OVLZu4o5a7imi7QpbDRjNB67MIS440Wjck3O4hhFOVm6IT
 Nlq9jCexXOKfqFlotFrfg==
UI-OutboundReport: notjunk:1;M01:P0:ydxRkPvFvoA=;tQSebHaPRxkRZvxKEnbUxgF6KED
 pZv15Rh2zGT/8slwG5tBbpWH/dZd+zdZSzoQ8o0pJvbz8QOu+ak4tgfdYCI8j+Lag5Rm8uSVm
 6qKuXJXU3biJLg9YVr6tfpA4oV9ObyGG/RNCW67DI0JuX65gBWEVgItU0HiZPKbxBVPAY4WlM
 RtKJAXsQKi13jZLgPiTaTcv7ynlVQ9HeCGXNOEFJQwKQWUnOmNz94qrD4b6GOPp4dojDnplVL
 PzmMJHOWpw00GHbvNveyATp9MHvNL0RUh1WPsi0SQFJotl0ger/Pb/Z1im0o8pGbOZ+UKpA3X
 /HDPZmdh31ifg/tiAlo87K+bWS//FxqaHVwm6VQBZDaUIXIgGtvA51zxewxxa1gWJJK6jiNKz
 2vHAiijKGNlFb7lNpdFBXe5bsqy6MsiIN0Ht41PVL53dhHp91V8k2aNzLVgh5HcxCKOVygbWm
 IxDrP5KyRSjfbPJ2QVtC8weLCT8qJOHZrK+Sf4gzs6g9bPrtFjnD6g17Ahj78RDiYTenKLHoU
 uTDrQGaB5WrzP1W1c85B3nCI1cI2aB6lXRCMOUpIZOrHOY8d1M/M2CtOqQ5oGZ17PY7wy3j/r
 MjiQc4K6Jm217GNJbr462vVnowPbX0A4XWXpg6xFnZa4dg7snHlAg322Uf50IPk+brzhP6cm3
 0R0kfj1t/PVcHyDc6+4lxyBsYcTB6BCZzPqFr8Gkhsic4xttmVw1Y91Hp4gdsd9XAAGYikmw2
 ZTkAidYiHC4rxizNS977v6ma/iJR16Q+zQNxphtxDUCfRxF8EImqq0ZNaBZ4ua0mRI6jMsJ3s
 mXy3WDR70kSaTPTbaNnX4lhodiNMMp0Fu/3Qcx27ahfmjoidKO4547sef3+aYWEixEyL1/Wt1
 TtlLMohIJu9n+ztnl50oW1GA96dVSW0sWVINS51Tl/hmtbM57zeU9ElAsp4AVuVYtZSqxAT5p
 RLSk9THPgoWRJddzqJoUWvd8UJ4=
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



Am 18=2E August 2023 02:26:53 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>U-Boot sets up the SMBIOS tables during startup=2E Rather than creating a
>new set, install the existing ones=2E Rely on the ACPI table's memory-map
>record to cover the tables=2E
>
>Tidy up the installation-condition code while we are here=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Add new patch
>
> lib/efi_loader/efi_setup=2Ec  | 10 +++++-----
> lib/efi_loader/efi_smbios=2Ec | 37 +++++++------------------------------
> 2 files changed, 12 insertions(+), 35 deletions(-)
>
>diff --git a/lib/efi_loader/efi_setup=2Ec b/lib/efi_loader/efi_setup=2Ec
>index ad719afd6328=2E=2Ee6de685e8795 100644
>--- a/lib/efi_loader/efi_setup=2Ec
>+++ b/lib/efi_loader/efi_setup=2Ec
>@@ -326,11 +326,11 @@ efi_status_t efi_init_obj_list(void)
> 		if (ret !=3D EFI_SUCCESS)
> 			goto out;
> 	}
>-#ifdef CONFIG_GENERATE_SMBIOS_TABLE
>-	ret =3D efi_smbios_register();
>-	if (ret !=3D EFI_SUCCESS)
>-		goto out;
>-#endif
>+	if (IS_ENABLED(CONFIG_SMBIOS)) {
>+		ret =3D efi_smbios_register();
>+		if (ret !=3D EFI_SUCCESS)
>+			goto out;
>+	}
> 	ret =3D efi_watchdog_register();
> 	if (ret !=3D EFI_SUCCESS)
> 		goto out;
>diff --git a/lib/efi_loader/efi_smbios=2Ec b/lib/efi_loader/efi_smbios=2E=
c
>index 306c0bc54f90=2E=2E0e6454a8fe0b 100644
>--- a/lib/efi_loader/efi_smbios=2Ec
>+++ b/lib/efi_loader/efi_smbios=2Ec
>@@ -20,36 +20,13 @@
>  */
> efi_status_t efi_smbios_register(void)
> {
>-	/* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
>-	u64 dmi_addr =3D U32_MAX;
>-	efi_status_t ret;
>-	void *dmi;
>+	ulong addr;
>=20
>-	/* Reserve 4kiB page for SMBIOS */
>-	ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
>-				 EFI_RUNTIME_SERVICES_DATA, 1, &dmi_addr);
>+	/* space for all tables is marked in efi_acpi_register() */
>+	addr =3D gd->arch=2Esmbios_start;
>+	printf("EFI using SMBIOS tables at %lx\n", addr);

This is should be log_debug() as typically only developers will ever need =
this address=2E

Best regards

Heinrich=20


>=20
>-	if (ret !=3D EFI_SUCCESS) {
>-		/* Could not find space in lowmem, use highmem instead */
>-		ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>-					 EFI_RUNTIME_SERVICES_DATA, 1,
>-					 &dmi_addr);
>-
>-		if (ret !=3D EFI_SUCCESS)
>-			return ret;
>-	}
>-
>-	/*
>-	 * Generate SMBIOS tables - we know that efi_allocate_pages() returns
>-	 * a 4k-aligned address, so it is safe to assume that
>-	 * write_smbios_table() will write the table at that address=2E
>-	 */
>-	assert(!(dmi_addr & 0xf));
>-	dmi =3D (void *)(uintptr_t)dmi_addr;
>-	if (write_smbios_table(map_to_sysmem(dmi)))
>-		/* Install SMBIOS information as configuration table */
>-		return efi_install_configuration_table(&smbios_guid, dmi);
>-	efi_free_pages(dmi_addr, 1);
>-	log_err("Cannot create SMBIOS table\n");
>-	return EFI_SUCCESS;
>+	/* Install SMBIOS information as configuration table */
>+	return efi_install_configuration_table(&smbios_guid,
>+					       map_sysmem(addr, 0));
> }
