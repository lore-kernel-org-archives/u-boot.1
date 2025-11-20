Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040CDCF8548
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 06:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E9584064;
	Thu, 20 Nov 2025 07:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ih9L/Shi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242BB84064; Thu, 20 Nov 2025 07:49:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57D983E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763621356; x=1764226156; i=xypron.glpk@gmx.de;
 bh=u6RhVfP43f02RQQAr10lkyjG5IpnQBsDcROUsz8mLC8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ih9L/ShibfgLlSiEtUO41yXH2DHoLLtILv5ywLepRVqMEUgYuDX6ty2y8cSDFx0E
 x952VPqymoroh7XV+GNbfl7PtXyiBwA+u3MLjR7m1D96cSo7mOrM7RbL613vopkuq
 DolE1qsyF5WsWdmz/02lGEZjEQ5yoV8HXPePODCpqJtYXOCxeJMoJOsVcg8G1vJtd
 /WH2s7ijL8RGYel2RptU6ZiGcUIGiRw/F+BWSg4PDFKaUqogb4pFWzTbcnb7PrSQO
 TUy8MyDc8beJX73d2Bkg3OoJCf46qoa07myxnKLe5luQt5UaagJP3iJASBFIdNEw3
 ODOg9o39c6zx0h3RLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1wAlc51IMr-012WfU; Thu, 20
 Nov 2025 07:49:16 +0100
Date: Thu, 20 Nov 2025 07:49:14 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriana Nicolae <adriana@arista.com>, u-boot@lists.denx.de
CC: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_boot/bootfdt=3A_Add_smbio?=
 =?US-ASCII?Q?s3-entrypoint_to_FDT_for_non-EFI_boots?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251119184640.543904-1-adriana@arista.com>
References: <20251119184640.543904-1-adriana@arista.com>
Message-ID: <1AE5584C-7EAE-4671-8825-DCF05B07C7DD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJSUB+cUZ3vHkuM08kAVydd0BdeqhI12BLh6OydTYFRonrKK4qi
 TNomhswd0fRtaWoutTPP42ZY9sRdf9q+PHxMw9UpEI1yDHFOThYBT9jt9S4ojFYmUE2ZOL0
 uKt6oXJ31Xcl0gnbp+Q3Xj7BgGgElrrZ1QwlnEFmZLIewGJQVRglk4Z+ULbeyaj0dlKRcE3
 aVYTRWUIqCOLGuut6etfw==
UI-OutboundReport: notjunk:1;M01:P0:nEKAudE1GrQ=;ZBXlVkWvIRlSZd2lqX8UpxHKQLR
 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
 zbqfgKQg=
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

Am 19=2E November 2025 19:46:40 MEZ schrieb Adriana Nicolae <adriana@arista=
=2Ecom>:
>From: adriana <adriana@arista=2Ecom>
>
>The Linux kernel can discover SMBIOS tables through two primary methods:
>1=2E Via EFI tables, when using EFI boot;
>2=2E Via the 'smbios3-entrypoint' property in the /chosen node of the
>device tree=2E
>
>When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
>"bootz", or "booti"), the kernel relies on the device tree to detect
>the hardware=2E If SMBIOS tables are available in U-Boot, they should
>be passed to the kernel via this device tree property=2E
>
>This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
>address into the device tree if there is a table generated by U-boot=2E
>The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
>for specific boards to select custom SMBIOS addresses=2E
>
>The changes in this patch are added in the context of supporting this
>device tree property in linux kernel:
>https://lkml=2Eorg/lkml/2025/10/24/1393
>
>Device tree schema was updated to include the "smbios3-entrypoint" node
>in pull request: https://github=2Ecom/devicetree-org/dt-schema/pull/177
>
>Signed-off-by: Adriana Nicolae <adriana@arista=2Ecom>
>---
>Changes in v4:
>  - Remove weak function board_fdt_chosen_smbios(), replace with
>    gd_smbios_start();
>  - Return -EAGAIN in test if GENERATE_SMBIOS_TABLE is not enabled;
>  - Remove unnecessary fdt cleanup at the end of the test;
>  - Added missing newlines at the end of the modified files=2E
>
>Changes in v3:
>  - Moved "board_fdt_chosen_smbios" function to lib/smbios=2Ec
>  - Return physical address of smbios entry and use map_sysmem to
>    access the entry point;
>  - Removed check for config enabled and added check for
>    GENERATE_SMBIOS_TABLE;
>  - Add test to check that smbios entry address is added into fdt;
>
>Changes in v2:
>  - Renamed device tree property to "smbios3-entrypoint"=2E
>  - Removed redundant check for CONFIG_SMBIOS=2E
>---
> boot/fdt_support=2Ec | 19 ++++++++++++++++++
> test/dm/fdtdec=2Ec   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 67 insertions(+)
>
>diff --git a/boot/fdt_support=2Ec b/boot/fdt_support=2Ec
>index 92f2f534ee0=2E=2E1c215e548db 100644
>--- a/boot/fdt_support=2Ec
>+++ b/boot/fdt_support=2Ec
>@@ -27,6 +27,7 @@
> #include <fdtdec=2Eh>
> #include <version=2Eh>
> #include <video=2Eh>
>+#include <smbios=2Eh>
>=20
> DECLARE_GLOBAL_DATA_PTR;
>=20
>@@ -333,6 +334,7 @@ int fdt_chosen(void *fdt)
> 	int   nodeoffset;
> 	int   err;
> 	const char *str;		/* used to set string properties */
>+	ulong smbiosaddr;		/* SMBIOS table address */
>=20
> 	err =3D fdt_check_header(fdt);
> 	if (err < 0) {
>@@ -387,6 +389,23 @@ int fdt_chosen(void *fdt)
> 		return err;
> 	}
>=20
>+	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
>+		/* Inject SMBIOS address when we have a valid address=2E
>+		* This is useful for systems using booti/bootm instead of bootefi=2E
>+		* Failure to set this property is non-fatal, we only generate a
>+		* warning=2E
>+		*/
>+		smbiosaddr =3D gd_smbios_start();
>+		if (smbiosaddr) {
>+			err =3D fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
>+					smbiosaddr);
>+			if (err < 0) {
>+				printf("WARNING: could not set smbios3-entrypoint %s=2E\n",
>+				fdt_strerror(err));
>+			}
>+		}
>+	}
>+
> 	return fdt_fixup_stdout(fdt, nodeoffset);
> }
>=20
>diff --git a/test/dm/fdtdec=2Ec b/test/dm/fdtdec=2Ec
>index 1f24f1d5dff=2E=2E1744211d4d1 100644
>--- a/test/dm/fdtdec=2Ec
>+++ b/test/dm/fdtdec=2Ec
>@@ -7,6 +7,9 @@
> #include <asm/global_data=2Eh>
> #include <dm/of_extra=2Eh>
> #include <dm/test=2Eh>
>+#include <fdt_support=2Eh>
>+#include <mapmem=2Eh>
>+#include <smbios=2Eh>
> #include <test/ut=2Eh>
>=20
> DECLARE_GLOBAL_DATA_PTR;
>@@ -129,3 +132,48 @@ static int dm_test_fdtdec_add_reserved_memory(struct=
 unit_test_state *uts)
> }
> DM_TEST(dm_test_fdtdec_add_reserved_memory,
> 	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
>+
>+static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
>+{
>+	void *blob;
>+	ulong val;
>+	struct smbios3_entry *entry;
>+	int chosen, blob_sz;
>+	const fdt64_t *prop;
>+
>+	if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
>+		return -EAGAIN;
>+	}
>+
>+	blob_sz =3D fdt_totalsize(gd->fdt_blob) + 128;

This is very tight=2E Depending on the architecture more properties may be=
 injected=2E 4 KiB is a safe value=2E

>+	blob =3D malloc(blob_sz);

Device-trees must be 8 byte aligned=2E

Please, consider using memalign(blob_sz, 8)=2E

Best regards

Heinrich


>+	ut_assertnonnull(blob);
>+
>+	/* Make a writable copy of the fdt blob */
>+	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
>+
>+	/* Mock SMBIOS table */
>+	entry =3D map_sysmem(gd->arch=2Esmbios_start, sizeof(struct smbios3_ent=
ry));
>+	memcpy(entry->anchor, "_SM3_", 5);
>+	entry->length =3D sizeof(struct smbios3_entry);
>+	unmap_sysmem(entry);
>+
>+	/* Force fdt_chosen to run */
>+	ut_assertok(fdt_chosen(blob));
>+
>+	chosen =3D fdt_path_offset(blob, "/chosen");
>+	ut_assert(chosen >=3D 0);
>+
>+	/* Verify the property exists */
>+	prop =3D fdt_getprop(blob, chosen, "smbios3-entrypoint", NULL);
>+	ut_assertnonnull(prop);
>+
>+	/* Verify the property matches smbios_start */
>+	val =3D fdt64_to_cpu(*prop);
>+	ut_asserteq_64(gd->arch=2Esmbios_start, val);
>+
>+	free(blob);
>+
>+	return 0;
>+}
>+DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);

