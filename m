Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B38FC47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738B287BAD;
	Fri, 26 Jan 2024 08:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ejkXqiT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D79287BC4; Fri, 26 Jan 2024 08:57:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52E287869
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706255841; x=1706860641; i=xypron.glpk@gmx.de;
 bh=XeRO6pHH+ow+VCGcG8DA4085JGUVA7NAZRSvla/iLiM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ejkXqiT7a7GmkzVJhwDJK4um0T+Y2mf+JMp+HhL6FW3gQ9VuohqixK2yDYZzGR9k
 EXB3VUcmFFr+stQKmOhWttPJum64dFHA/3AGzaFoyB0MyUu5lg4ZxJct2aIbiBGOW
 cooozmLQe1gM42+gPzu2TNhk1gSzH8bOg2/8pfIR67ujMgvbWDQB0QVNrZH3JWmdZ
 kLlh4hAjE9K/Qe/Yg18NrxXCid1AydIYxFuIjosaCCHGRnhHuLVCG7smxeKl4dbet
 r4FuaeikF56vklbR5Z0p6Hn+2e3a5mIWVFerwkhsY0HYebJuRAYoGrckG7XN6QVUq
 V1Wka7ka88CHO/WGZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1ra4IY2tVn-00Z06I; Fri, 26
 Jan 2024 08:57:21 +0100
Message-ID: <923ce74f-c4ce-4984-9229-adeb94dd1543@gmx.de>
Date: Fri, 26 Jan 2024 08:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: migrate SMBIOS 3.0 entry point structure
 for measurement
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240126005342.1221684-1-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240126005342.1221684-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKMvxkBuQcVuHjw+ACU4QWfa+oJV1r2M55eOdsgsNsIwWGyTS40
 90z660DsZ7vqZKzoq+01qyi3uPck8cEkRQO8RJ9BfNOjpBuWnnK7MQo6UL6cwmJe2ffwk90
 fBqkvfdzc7WgC/Nsh5WFYBK9UBzzf0+luw3EaKFYsbiUV7Rps9VPZ+sZu4AkrofhXlIjK/y
 idRuguNAnuh23J2qsIUIw==
UI-OutboundReport: notjunk:1;M01:P0:RDw8MViDTJQ=;jluA9A4f8wTKzSPKMKGHhRpfTOa
 1SxecMmPUSmfmI3oHIge6XmVkBRnHj1DwUI57t0Akjf8MLZCTEz3hoshwIp5tKEu9EP/QPrUT
 Jl8ixQjugmkMWmNfyGfL4rOzF/X6nf4abrx/3qXl/y2XkFVP3oBAEnTBQ1EQYOBpRp2561cRc
 4MxV+h8x0c4X0v+m7hPSx4Pbu2j/YTdCE9vpx7l7aBVmfk0+3r8JqMXMuDR9F1Y47kpVY2zjX
 bu05IniG+hM+++CfMR+ZYsB3S4MvnE4T/e0eKowC1nVQZMQvAaD76pY1gjDFblmjNQVG9lWL3
 Y74s0uwkn2vDixHKYn71zp8Jr5NopxNNPi9Ksz6oHvylo8LGw45Qn+/roCGr8KcH6xsAAvkVn
 /xqhvt90vcxO18TGeyREfubc1KGRrDb/2/qPIRPifPTbT+49w6xNmfR8FVpqIv3dCAwMHCzhW
 TafEmEXRbAm6/jbke6Deunfs7vYr6iUTPfwAVJfdJx2+0DAGeMO+9YEK65RZ1IALW8VWOK6rs
 etS6VsvPSFW+ZAdWtjni6YHvyf+X3P1EZ6xjBX9/WHJfY2M3OotfY9pqC1y71o02VkQj/pGWY
 E3jCFhDy5QBy2yRVPZMKo6TcSy6A41LbFI8q/k70GQA4b+bZ4S6AuGBVpJZpJ1UARrSaYC4vZ
 YBtnfD5wsck0w6ezeVGJpXv3zREglfMuLIcOZFGiPnzQxFdkx5+SfH2LBPuh5/qjbQDBRFZ2Z
 FaCxsE7IpE1hCwyHwfH5FTxYiN78Vk+f4DMPskfkyCjfk8FT5YT6W9NNOkfDStQEl9dSzbJre
 Ib8wzAs2Ekv0SAZAXG6He1Uo+6vmeQct2SmJJti+bDxcGQ2GVt0HkZRpsSyzQmyaqSFki5ha1
 aEb549f/txbLz3x90Kwldt2j/GkBdJmxixkMzEAj0QGI3cEfVf+ebf1uqraGcm5lIc55iNxtn
 5G3/fPCa5krEoLdai68lIMRDdcE=
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

On 1/26/24 01:53, Masahisa Kojima wrote:
> Current U-Boot only supports the SMBIOS 3.0 entry point structure.
> TCG2 measurement code should migrate to SMBIOS 3.0 entry
> point structure.
>
> efi_selftest tcg2 test also needs to be updated, and expected
> PCR[1] result is changed since guid for SMBIOS EFI system table
> uses different guid SMBIOS3_TABLE_GUID instead of SMBIOS_TABLE_GUID.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
> Changes in v2:
> - add SMBIOS 3.0 anchor string check
>
>   include/efi_loader.h                 |  1 +
>   include/smbios.h                     |  4 +-
>   lib/efi_loader/efi_tcg2.c            | 19 ++++--
>   lib/efi_selftest/efi_selftest_tcg2.c | 97 +++++++++++++---------------
>   lib/smbios-parser.c                  |  9 ++-
>   5 files changed, 66 insertions(+), 64 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d5fca2fa5e..5c5af4f7fd 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -340,6 +340,7 @@ extern const efi_guid_t efi_guid_firmware_management=
_protocol;
>   extern const efi_guid_t efi_esrt_guid;
>   /* GUID of the SMBIOS table */
>   extern const efi_guid_t smbios_guid;
> +extern const efi_guid_t smbios3_guid;
>   /*GUID of console */
>   extern const efi_guid_t efi_guid_text_input_protocol;
>   extern const efi_guid_t efi_guid_text_output_protocol;
> diff --git a/include/smbios.h b/include/smbios.h
> index b507b9d9d7..e45303d0d3 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -326,10 +326,10 @@ int smbios_update_version_full(void *smbios_tab, c=
onst char *version);
>    * This function clear the device dependent parameters such as
>    * serial number for the measurement.
>    *
> - * @entry: pointer to a struct smbios_entry
> + * @entry: pointer to a struct smbios3_entry
>    * @header: pointer to a struct smbios_header
>    */
> -void smbios_prepare_measurement(const struct smbios_entry *entry,
> +void smbios_prepare_measurement(const struct smbios3_entry *entry,
>   				struct smbios_header *header);
>
>   #endif /* _SMBIOS_H_ */
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 8db35d0b3c..85562c50a1 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1075,12 +1075,17 @@ error:
>    */
>   static efi_status_t
>   tcg2_measure_smbios(struct udevice *dev,
> -		    const struct smbios_entry *entry)
> +		    const struct smbios3_entry *entry)
>   {
>   	efi_status_t ret;
>   	struct smbios_header *smbios_copy;
>   	struct smbios_handoff_table_pointers2 *event =3D NULL;
>   	u32 event_size;
> +	const char smbios3_anchor[] =3D "_SM3_";
> +
> +	/* We only support SMBIOS 3.0 Entry Point structure */
> +	if (memcmp(entry->anchor, smbios3_anchor, sizeof(smbios3_anchor) - 1))
> +		return EFI_UNSUPPORTED;
>
>   	/*
>   	 * TCG PC Client PFP Spec says
> @@ -1093,7 +1098,7 @@ tcg2_measure_smbios(struct udevice *dev,
>   	 */
>   	event_size =3D sizeof(struct smbios_handoff_table_pointers2) +
>   		     FIELD_SIZEOF(struct efi_configuration_table, guid) +
> -		     entry->struct_table_length;
> +		     entry->max_struct_size;
>   	event =3D calloc(1, event_size);
>   	if (!event) {
>   		ret =3D EFI_OUT_OF_RESOURCES;
> @@ -1104,11 +1109,11 @@ tcg2_measure_smbios(struct udevice *dev,
>   	memcpy(event->table_description, SMBIOS_HANDOFF_TABLE_DESC,
>   	       sizeof(SMBIOS_HANDOFF_TABLE_DESC));
>   	put_unaligned_le64(1, &event->number_of_tables);
> -	guidcpy(&event->table_entry[0].guid, &smbios_guid);
> +	guidcpy(&event->table_entry[0].guid, &smbios3_guid);
>   	smbios_copy =3D (struct smbios_header *)((uintptr_t)&event->table_ent=
ry[0].table);
>   	memcpy(&event->table_entry[0].table,
>   	       (void *)((uintptr_t)entry->struct_table_address),
> -	       entry->struct_table_length);
> +	       entry->max_struct_size);
>   lib/efi_loader/efi_helper.c
>   	smbios_prepare_measurement(entry, smbios_copy);
>
> @@ -1133,7 +1138,7 @@ static void *find_smbios_table(void)

This function contains redundant code. We should replace it in a future
patch. See
efi_loader: export efi_get_configuration_table
https://lists.denx.de/pipermail/u-boot/2024-January/544516.html

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	u32 i;
>
>   	for (i =3D 0; i < systab.nr_tables; i++) {
> -		if (!guidcmp(&smbios_guid, &systab.tables[i].guid))
> +		if (!guidcmp(&smbios3_guid, &systab.tables[i].guid))
>   			return systab.tables[i].table;
>   	}
>
> @@ -1360,7 +1365,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(s=
truct efi_loaded_image_obj *ha
>   	u32 pcr_index;
>   	struct udevice *dev;
>   	u32 event =3D 0;
> -	struct smbios_entry *entry;
> +	struct smbios3_entry *entry;
>
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
> @@ -1382,7 +1387,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(s=
truct efi_loaded_image_obj *ha
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> -	entry =3D (struct smbios_entry *)find_smbios_table();
> +	entry =3D (struct smbios3_entry *)find_smbios_table();
>   	if (entry) {
>   		ret =3D tcg2_measure_smbios(dev, entry);
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_selftest/efi_selftest_tcg2.c b/lib/efi_selftest/efi=
_selftest_tcg2.c
> index 67a886efaa..fb8b997653 100644
> --- a/lib/efi_selftest/efi_selftest_tcg2.c
> +++ b/lib/efi_selftest/efi_selftest_tcg2.c
> @@ -126,41 +126,40 @@ static u8 boot_order[] =3D {0x02, 0x10, 0x00, 0x10=
, 0x01, 0x10};
>
>   static void *orig_smbios_table;
>   static u64 dmi_addr =3D U32_MAX;
> -#define SMBIOS_ENTRY_HEADER_SIZE 0x20
> +#define SMBIOS3_ENTRY_HEADER_SIZE 0x18
>   /* smbios table for the measurement test */
> -static u8 smbios_table_test[] =3D {
> -0x5f, 0x53, 0x4d, 0x5f, 0x2c, 0x1f, 0x03, 0x00, 0x54, 0x00, 0x00, 0x00,
> -0x00, 0x00, 0x00, 0x00, 0x5f, 0x44, 0x4d, 0x49, 0x5f, 0xe4, 0x5c, 0x01,
> -0x20, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00,
> -0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08, 0x01, 0x00, 0x00, 0x00,
> -0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff, 0x55, 0x2d, 0x42, 0x6f,
> -0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e, 0x31, 0x30, 0x2d, 0x72,
> -0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35, 0x2d, 0x67, 0x37, 0x32,
> -0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39, 0x2d, 0x64, 0x69, 0x72,
> -0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31, 0x2f, 0x32, 0x30, 0x32,
> -0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01, 0x02, 0x00, 0x03, 0x31,
> -0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
> -0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> -0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
> -0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
> -0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00, 0x01, 0x02, 0x00, 0x04,
> -0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> -0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
> -0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
> -0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
> -0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00, 0x02, 0x03, 0x03, 0x03,
> -0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x6e,
> -0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
> -0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00,
> -0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00,
> -0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00,
> -0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x03, 0x04,
> -0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08, 0x00, 0x08, 0x00, 0x01,
> -0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33,
> -0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
> -0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x00,
> -0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
> +static u8 smbios3_table_test[] =3D {
> +0x5f, 0x53, 0x4d, 0x33, 0x5f, 0x00, 0x18, 0x03, 0x07, 0x00, 0x01, 0x00,
> +0x5c, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x18, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08,
> +0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff,
> +0x55, 0x2d, 0x42, 0x6f, 0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e,
> +0x31, 0x30, 0x2d, 0x72, 0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35,
> +0x2d, 0x67, 0x37, 0x32, 0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39,
> +0x2d, 0x64, 0x69, 0x72, 0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31,
> +0x2f, 0x32, 0x30, 0x32, 0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01,
> +0x02, 0x00, 0x03, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e,
> +0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> +0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32,
> +0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00,
> +0x01, 0x02, 0x00, 0x04, 0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e,
> +0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> +0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33,
> +0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35,
> +0x36, 0x37, 0x38, 0x00, 0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00,
> +0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32,
> +0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33,
> +0x33, 0x33, 0x33, 0x00, 0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02,
> +0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff,
> +0xff, 0x02, 0x03, 0x04, 0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08,
> +0x00, 0x08, 0x00, 0x01, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e,
> +0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33,
> +0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35,
> +0x35, 0x35, 0x35, 0x00, 0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00,
> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
>   };
>
>   #define IDX_ARRAY_SZ 3 /* support 24 PCRs */
> @@ -179,10 +178,10 @@ static u8 expected_pcrs[EFI_TCG2_MAX_PCR_INDEX + 1=
][TPM2_SHA256_DIGEST_SIZE] =3D {
>   	 0x7b, 0xb9, 0xfe, 0xa1, 0xcd, 0x64, 0x49, 0xdd,
>   	 0xed, 0xe2, 0x65, 0x82, 0xc5, 0x3e, 0xf4, 0xc4},
>
> -	{0xf5, 0x79, 0xf3, 0x20, 0x62, 0x6e, 0x8b, 0x58,
> -	 0x62, 0xa3, 0x4e, 0x2f, 0xb7, 0x10, 0xac, 0x34,
> -	 0x4e, 0x68, 0x94, 0x37, 0x87, 0x29, 0xc4, 0xbe,
> -	 0xa3, 0xc4, 0xd9, 0x14, 0x2b, 0x66, 0x79, 0x9b},
> +	{0x75, 0xb5, 0x91, 0x54, 0x12, 0xa8, 0xa4, 0x25,
> +	 0x73, 0x79, 0xa7, 0x47, 0xd9, 0x32, 0x54, 0x78,
> +	 0x9a, 0x80, 0x3f, 0xa8, 0x34, 0xfe, 0xd2, 0xae,
> +	 0x76, 0xd3, 0x16, 0x4a, 0xb2, 0x03, 0xac, 0xe6},
>
>   	{0x3d, 0x45, 0x8c, 0xfe, 0x55, 0xcc, 0x03, 0xea,
>   	 0x1f, 0x44, 0x3f, 0x15, 0x62, 0xbe, 0xec, 0x8d,
> @@ -543,7 +542,7 @@ static void *find_smbios_table(const struct efi_syst=
em_table *systable)
>   	u32 i;
>
>   	for (i =3D 0; i < systable->nr_tables; i++) {
> -		if (!guidcmp(&smbios_guid, &systable->tables[i].guid))
> +		if (!guidcmp(&smbios3_guid, &systable->tables[i].guid))
>   			return systable->tables[i].table;
>   	}
>
> @@ -558,14 +557,12 @@ static void *find_smbios_table(const struct efi_sy=
stem_table *systable)
>    */
>   static efi_status_t setup_smbios_table(const struct efi_system_table *=
systable)
>   {
> -	struct smbios_entry *se;
> +	struct smbios3_entry *se;
>   	efi_status_t ret;
>   	/* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
>   	void *dmi;
> -	char *istart;
> -	int isize;
>
> -	if (sizeof(smbios_table_test) > EFI_PAGE_SIZE)
> +	if (sizeof(smbios3_table_test) > EFI_PAGE_SIZE)
>   		return EFI_OUT_OF_RESOURCES;
>
>   	orig_smbios_table =3D find_smbios_table(systable);
> @@ -586,19 +583,15 @@ static efi_status_t setup_smbios_table(const struc=
t efi_system_table *systable)
>
>   	dmi =3D (void *)(uintptr_t)dmi_addr;
>   	se =3D dmi;
> -	boottime->copy_mem(se, smbios_table_test, sizeof(smbios_table_test));
> +	boottime->copy_mem(se, smbios3_table_test, sizeof(smbios3_table_test))=
;
>
>   	/* update smbios table start address */
> -	se->struct_table_address =3D (uintptr_t)((u8 *)dmi + SMBIOS_ENTRY_HEAD=
ER_SIZE);
> +	se->struct_table_address =3D (uintptr_t)((u8 *)dmi + SMBIOS3_ENTRY_HEA=
DER_SIZE);
>
> -	/* calculate checksums */
> -	istart =3D (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> -	isize =3D sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
> -	se->intermediate_checksum =3D table_compute_checksum(istart, isize);
> -	se->checksum =3D table_compute_checksum(se, sizeof(struct smbios_entry=
));
> +	se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3_entr=
y));
>
>   	/* Install SMBIOS information as configuration table */
> -	ret =3D boottime->install_configuration_table(&smbios_guid, dmi);
> +	ret =3D boottime->install_configuration_table(&smbios3_guid, dmi);
>   	if (ret !=3D EFI_SUCCESS) {
>   		efi_st_error("Cannot install SMBIOS table\n");
>   		boottime->free_pages(dmi_addr, 1);
> @@ -992,7 +985,7 @@ static int efi_st_tcg2_teardown(void)
>   	 * If orig_smbios_table is NULL, calling install_configuration_table(=
)
>   	 * removes dummy SMBIOS table form systab.
>   	 */
> -	r =3D boottime->install_configuration_table(&smbios_guid, orig_smbios_=
table);
> +	r =3D boottime->install_configuration_table(&smbios3_guid, orig_smbios=
_table);
>   	if (r !=3D EFI_SUCCESS) {
>   		efi_st_error("Failed to restore SMBOIS table\n");
>   		return EFI_ST_FAILURE;
> diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
> index ac9a367a87..f48d743657 100644
> --- a/lib/smbios-parser.c
> +++ b/lib/smbios-parser.c
> @@ -223,21 +223,24 @@ static void clear_smbios_table(struct smbios_heade=
r *header,
>   	}
>   }
>
> -void smbios_prepare_measurement(const struct smbios_entry *entry,
> +void smbios_prepare_measurement(const struct smbios3_entry *entry,
>   				struct smbios_header *smbios_copy)
>   {
>   	u32 i, j;
> +	void *table_end;
>   	struct smbios_header *header;
>
> +	table_end =3D (void *)((u8 *)smbios_copy + entry->max_struct_size);
> +
>   	for (i =3D 0; i < ARRAY_SIZE(smbios_filter_tables); i++) {
>   		header =3D smbios_copy;
> -		for (j =3D 0; j < entry->struct_count; j++) {
> +		for (j =3D 0; (void *)header < table_end; j++) {
>   			if (header->type =3D=3D smbios_filter_tables[i].type)
>   				break;
>
>   			header =3D get_next_header(header);
>   		}
> -		if (j >=3D entry->struct_count)
> +		if ((void *)header >=3D table_end)
>   			continue;
>
>   		clear_smbios_table(header,

