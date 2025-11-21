Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5485CFA749
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CBB8051F;
	Fri, 21 Nov 2025 09:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oxRD7w6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F148F807B1; Fri, 21 Nov 2025 09:27:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC9980433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763713636; x=1764318436; i=xypron.glpk@gmx.de;
 bh=xoBv1K/LAxb/9WSBIzrpRjy+JnD29osoJKS3Pag4yic=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oxRD7w6OwPmZ+Ly68DB53l1vJ5Kr3cs4FPlWoRjPJoZ4pQUs6zpXl+orUO/+yQgc
 XjDkjwqHJMojGEOCEb05Lij4P+86tn09nrhyUHpKdIfRx7o1TlLl1acI8X/qhCT0v
 mAVdx5tQG+mfVli9utbxnzhvza6eQJvkE2hoD8BTjbFG0M41ARCmimKtDvqKbFf7w
 msb3IYf1DVKUGGwUUmoEXQmWVJw3X3M8yhCHrq3ZvugJfuk7U/47T2LxL9gyaUzSq
 dh5M7TJhSD9xriHQEIpa8XLwn8yKXn/GW7wWO3He797BM3DCAflTuy9yaaVTlRfOz
 O+xfVe8w0JfYO+udIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.119] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1vW1El2UKZ-00TDco; Fri, 21
 Nov 2025 09:27:16 +0100
Message-ID: <a975f396-ca65-4b9a-8f8c-d79dfcd80136@gmx.de>
Date: Fri, 21 Nov 2025 09:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
To: Adriana Nicolae <adriana@arista.com>
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, u-boot@lists.denx.de
References: <20251120085057.549221-1-adriana@arista.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251120085057.549221-1-adriana@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PA7qMRqi0IMNi3Vmd12akKmZ5tsWlcJfcyEJL6Vhgf5Sbqbx+sG
 1OAJpPewxdqTjKwLpniuWm4voaHFXn5Y3xTuvn9jTDaXv/NhX+L7v6Q4E/ydTVCxTTNOpTO
 /ZfAQA+q148tJAsQBBEpZ6TnHctWZagPKAT+u85SAwNUgy8rT3xH2qZiw63MaDt+3tyluaB
 /cL37Ap+TCQCSmavPjxNw==
UI-OutboundReport: notjunk:1;M01:P0:H+z9UKGIHjs=;kmY0fuCFPM+JVYoLZTFuAinyUVg
 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
 prspZs7E=
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

On 11/20/25 09:50, Adriana Nicolae wrote:
> From: adriana <adriana@arista.com>
>=20
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>=20
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>=20
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>=20
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>=20
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>=20
> Signed-off-by: Adriana Nicolae <adriana@arista.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes in v5:
>    - Allocate 4KiB extra space for fdt blob and align it to 8 bytes.
>=20
> Changes in v4:
>    - Remove weak function board_fdt_chosen_smbios(), replace with
>      gd_smbios_start();
>    - Return -EAGAIN in test if GENERATE_SMBIOS_TABLE is not enabled;
>    - Remove unnecessary fdt cleanup at the end of the test;
>    - Added missing newlines at the end of the modified files.
>=20
> Changes in v3:
>    - Moved "board_fdt_chosen_smbios" function to lib/smbios.c
>    - Return physical address of smbios entry and use map_sysmem to
>      access the entry point;
>    - Removed check for config enabled and added check for
>      GENERATE_SMBIOS_TABLE;
>    - Add test to check that smbios entry address is added into fdt;
>=20
> Changes in v2:
>    - Renamed device tree property to "smbios3-entrypoint".
>    - Removed redundant check for CONFIG_SMBIOS.
> ---
>   boot/fdt_support.c | 19 ++++++++++++++++++
>   test/dm/fdtdec.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+)
>=20
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 92f2f534ee0..1c215e548db 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -27,6 +27,7 @@
>   #include <fdtdec.h>
>   #include <version.h>
>   #include <video.h>
> +#include <smbios.h>
>  =20
>   DECLARE_GLOBAL_DATA_PTR;
>  =20
> @@ -333,6 +334,7 @@ int fdt_chosen(void *fdt)
>   	int   nodeoffset;
>   	int   err;
>   	const char *str;		/* used to set string properties */
> +	ulong smbiosaddr;		/* SMBIOS table address */
>  =20
>   	err =3D fdt_check_header(fdt);
>   	if (err < 0) {
> @@ -387,6 +389,23 @@ int fdt_chosen(void *fdt)
>   		return err;
>   	}
>  =20
> +	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
> +		/* Inject SMBIOS address when we have a valid address.
> +		* This is useful for systems using booti/bootm instead of bootefi.
> +		* Failure to set this property is non-fatal, we only generate a
> +		* warning.
> +		*/
> +		smbiosaddr =3D gd_smbios_start();
> +		if (smbiosaddr) {
> +			err =3D fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
> +					smbiosaddr);
> +			if (err < 0) {
> +				printf("WARNING: could not set smbios3-entrypoint %s.\n",
> +				fdt_strerror(err));
> +			}
> +		}
> +	}
> +
>   	return fdt_fixup_stdout(fdt, nodeoffset);
>   }
>  =20
> diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
> index 1f24f1d5dff..ea5a494612c 100644
> --- a/test/dm/fdtdec.c
> +++ b/test/dm/fdtdec.c
> @@ -7,6 +7,9 @@
>   #include <asm/global_data.h>
>   #include <dm/of_extra.h>
>   #include <dm/test.h>
> +#include <fdt_support.h>
> +#include <mapmem.h>
> +#include <smbios.h>
>   #include <test/ut.h>
>  =20
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -129,3 +132,48 @@ static int dm_test_fdtdec_add_reserved_memory(struc=
t unit_test_state *uts)
>   }
>   DM_TEST(dm_test_fdtdec_add_reserved_memory,
>   	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
> +
> +static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
> +{
> +	void *blob;
> +	ulong val;
> +	struct smbios3_entry *entry;
> +	int chosen, blob_sz;
> +	const fdt64_t *prop;
> +
> +	if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
> +		return -EAGAIN;
> +	}
> +
> +	blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
> +	blob =3D memalign(8, blob_sz);
> +	ut_assertnonnull(blob);
> +
> +	/* Make a writable copy of the fdt blob */
> +	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
> +
> +	/* Mock SMBIOS table */
> +	entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct smbios3_entr=
y));
> +	memcpy(entry->anchor, "_SM3_", 5);
> +	entry->length =3D sizeof(struct smbios3_entry);
> +	unmap_sysmem(entry);
> +
> +	/* Force fdt_chosen to run */
> +	ut_assertok(fdt_chosen(blob));
> +
> +	chosen =3D fdt_path_offset(blob, "/chosen");
> +	ut_assert(chosen >=3D 0);
> +
> +	/* Verify the property exists */
> +	prop =3D fdt_getprop(blob, chosen, "smbios3-entrypoint", NULL);
> +	ut_assertnonnull(prop);
> +
> +	/* Verify the property matches smbios_start */
> +	val =3D fdt64_to_cpu(*prop);
> +	ut_asserteq_64(gd->arch.smbios_start, val);
> +
> +	free(blob);
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);

