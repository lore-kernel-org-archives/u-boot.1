Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E70C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 15:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F0B88001;
	Sat, 22 Jun 2024 17:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZipH2rfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AE687EED; Sat, 22 Jun 2024 17:55:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F362A88001
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 17:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719071719; x=1719676519; i=xypron.glpk@gmx.de;
 bh=A43p4iA9mZ6DFXji6D5GJwKuvKnGYxT9fgkCbT8hP0Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZipH2rfgPgOODhfsbY3pWNWU8SQb7j48L/Ba9mEG6fweEAuOTRHAvmp7q4RDDPvy
 vG36mipZxFoUl3LWz54gCfLMJCf5iAKETYTTN3VkvDuW1Hana8PUaRz3AjubaDVvW
 uCUGPF4/Any/izwmQc2YN0MZgo9NciLybTTXYdTEFPqgawKyG+HAqNJlt3OMvUoey
 j3llPiRPE1ZD69NUWtu88QL/BQW4GvetyPi8fGT9xJD+5baJQmGq9ToXm9ULvM0+l
 955hkULW0Nf0aaezkLVkbrrElew1rGyClRjWl4luuSx9PcGMx61Dt6kpq1aX28puJ
 cjFeXkl4J74z0yUL/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1rx1sV3iO1-00OC23; Sat, 22
 Jun 2024 17:55:18 +0200
Message-ID: <7abc8f32-8186-4e2b-a9f8-3b032738dbcf@gmx.de>
Date: Sat, 22 Jun 2024 17:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] efi_loader: fix the return values on efi_tcg
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240622143601.187723-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:POF1HLAvSD44Wup91bojNx2kG+04a6XEu1hWXpnYflKx9D2NZZv
 hVD8QCBxg/RkiSlqXTvW+DLGqxoOXHoQ2ZfTC+Dz9Xpa8iqrw/WCRGyDeVH8y+L4JSiCial
 piRFPCTgw97lihOewOfkVfOX2bhhjmaYY6P2sk8K58Spmi7r1lzKLS5tFidovOEgxKsMFeF
 StPyp5T0vBHzyZr1jOGkQ==
UI-OutboundReport: notjunk:1;M01:P0:JdCyaZF0VW0=;GG8V2zdBr+1SalK3AdZEqcAQr+q
 f5nOTxsuVL0+dYrVthj9DhCOPasoYBAmii2Edd1LNHMLHSKTQVozxj0wZj8HrlqFVdIDH23zZ
 zLq/HRuGx4crR08+RMyRb6TzXJWKw70Q5T0J0rRSC1KtZ/imNKcRT4S+czLfGZSYfzhNFXzZ0
 70bzp39Aj/6GpIVp3T7emePmM0jcuESu0vwsxBg46kkhlbL5LvMsYh8o0Dxf9qUTK3D3IgTp8
 MoTvzcIqJuqhjP+rGOabn3NN50StIdKcfeW/PTNTTUi4o4pXRe39tDZblnt0cIaObNm47Ph4Q
 HBwMDB8yW+ytpZsqkK062C+ynON0t5pY2/ba0axhBtzQRuJdbeXBgaaEIXeILlkHUoRPKYdu9
 3K7zjvCiOLdxNcO/Uw/IuHcuHC8vlW5p4Vbz019VHOy8Ft5OjhY0PFfiD26byUHKrjgV0Dc9S
 ptKPUithMXGSamlOzzkna3hLXUqEIYL1FQlxCRtXKS2KNtoF5MspBu7zOrvbRzWeOC1iNdolP
 EqdNS16Z3d8j9eaqoHWl5JVRmAPCFtLP8WDdpsL28w1l/+XJz5G9KXFCNEvD8P6+7U/JCbmBI
 Q9LAZlRjGuOfHdIABubUqmaILWYuEH9KWJ09kTyUSRWN/GGfsYvBrB1bt6OIIqEE4fHHSxuQW
 R5FwBuWGWREfHr+bl3zVHb1q15rvEuB13Uz0i6OpQYjNbaQvEgjDQbUH4Jzh1aP6t1irUoeAs
 NhM4zEqhGSKooUqy5FMaVESSa2LxcQHxfPme5QEXEGx+MoPRpgM/aHRN0NzP6uV8Tr72D5j7x
 RzY6v9Lsg0zNz0VsNtQyMK8pRdP4eMRWnc5fHoOzsfwf0=
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

On 22.06.24 16:35, Ilias Apalodimas wrote:
> A while back we moved the core functions of the EFI TCG protocol to the
> TPM APIs in order for them to be used with bootm, booti etc.
> Some prototypes changed from returning efi_status_t to int, which is mor=
e
> appropriate for the non-EFI APIs. However, some of the EFI callsites nev=
er
> changed and we ended up assigning the int value to efi_status_t.
>
> This is unlikely to cause any problems, apart from returning invalid
> values on failures and violating the EFI spec. Let's fix them
> by looking at the new return code and map it to the proper EFI return
> code on failures.
>
> Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
> Fixes: commit d6b55a420cfc ("efi_loader: startup the tpm device when ins=
talling the protocol")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_tcg2.c | 121 ++++++++++++++++++++------------------
>   1 file changed, 64 insertions(+), 57 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index d56bd5657c8a..10c09caac35a 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -257,8 +257,8 @@ efi_tcg2_get_capability(struct efi_tcg2_protocol *th=
is,
>   	capability->protocol_version.major =3D 1;
>   	capability->protocol_version.minor =3D 1;
>
> -	efi_ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (efi_ret !=3D EFI_SUCCESS) {
> +	ret =3D tcg2_platform_get_tpm2(&dev);
> +	if (ret) {
>   		capability->supported_event_logs =3D 0;
>   		capability->hash_algorithm_bitmap =3D 0;
>   		capability->tpm_present_flag =3D false;
> @@ -353,8 +353,7 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this=
,
>   		goto out;
>   	}
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS) {
> +	if (tcg2_platform_get_tpm2(&dev)) {
>   		event_log_location =3D NULL;
>   		event_log_last_entry =3D NULL;
>   		*event_log_truncated =3D false;
> @@ -389,7 +388,7 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u6=
4 efi_size,
>   	void *new_efi =3D NULL;
>   	u8 hash[TPM2_SHA512_DIGEST_SIZE];
>   	struct udevice *dev;
> -	efi_status_t ret;
> +	efi_status_t ret =3D EFI_SUCCESS;
>   	u32 active;
>   	int i;
>
> @@ -404,12 +403,13 @@ static efi_status_t tcg2_hash_pe_image(void *efi, =
u64 efi_size,
>   		goto out;
>   	}
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev)) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		goto out;
> +	}
>
> -	ret =3D tcg2_get_active_pcr_banks(dev, &active);
> -	if (ret !=3D EFI_SUCCESS) {
> +	if (tcg2_get_active_pcr_banks(dev, &active)) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		goto out;
>   	}
>
> @@ -473,12 +473,12 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 =
efi_size,
>   	IMAGE_DOS_HEADER *dos;
>   	IMAGE_NT_HEADERS32 *nt;
>   	struct efi_handler *handler;
> +	int rc;
>
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev))
>   		return EFI_SECURITY_VIOLATION;
>
>   	switch (handle->image_type) {
> @@ -502,9 +502,9 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 ef=
i_size,
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
> -	ret =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	rc =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> +	if (rc)
> +		return EFI_DEVICE_ERROR;
>
>   	ret =3D efi_search_protocol(&handle->header,
>   				  &efi_guid_loaded_image_device_path, &handler);
> @@ -574,9 +574,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_prot=
ocol *this, u64 flags,
>   			       struct efi_tcg2_event *efi_tcg_event)
>   {
>   	struct udevice *dev;
> -	efi_status_t ret;
> +	efi_status_t ret =3D EFI_SUCCESS;
>   	u32 event_type, pcr_index, event_size;
>   	struct tpml_digest_values digest_list;
> +	int rc =3D 0;
>
>   	EFI_ENTRY("%p, %llu, %llu, %llu, %p", this, flags, data_to_hash,
>   		  data_to_hash_len, efi_tcg_event);
> @@ -586,9 +587,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_prot=
ocol *this, u64 flags,
>   		goto out;
>   	}
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev)) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		goto out;
> +	}
>
>   	if (efi_tcg_event->size < efi_tcg_event->header.header_size +
>   	    sizeof(u32)) {
> @@ -621,8 +623,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_prot=
ocol *this, u64 flags,
>   		ret =3D tcg2_hash_pe_image((void *)(uintptr_t)data_to_hash,
>   					 data_to_hash_len, &digest_list);
>   	} else {
> -		ret =3D tcg2_create_digest(dev, (u8 *)(uintptr_t)data_to_hash,
> -					 data_to_hash_len, &digest_list);
> +		rc =3D tcg2_create_digest(dev, (u8 *)(uintptr_t)data_to_hash,
> +					data_to_hash_len, &digest_list);
> +		if (rc)
> +			ret =3D EFI_DEVICE_ERROR;
>   	}
>
>   	if (ret !=3D EFI_SUCCESS)
> @@ -631,9 +635,11 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_prot=
ocol *this, u64 flags,
>   	pcr_index =3D efi_tcg_event->header.pcr_index;
>   	event_type =3D efi_tcg_event->header.event_type;
>
> -	ret =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> -	if (ret !=3D EFI_SUCCESS)
> +	rc =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> +	if (rc) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		goto out;
> +	}
>
>   	if (flags & EFI_TCG2_EXTEND_ONLY) {
>   		if (event_log.truncated)
> @@ -672,7 +678,7 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *th=
is,
>   			u8 *output_param_block)
>   {
>   	struct udevice *dev;
> -	efi_status_t ret;
> +	efi_status_t ret =3D EFI_SUCCESS;
>   	u32 rc;
>   	size_t resp_buf_size =3D output_param_block_size;
>
> @@ -684,9 +690,10 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *t=
his,
>   		goto out;
>   	}
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev)) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		goto out;
> +	}
>
>   	rc =3D tpm2_submit_command(dev, input_param_block,
>   				 output_param_block, &resp_buf_size);
> @@ -714,19 +721,20 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_prot=
ocol *this,
>   			      u32 *active_pcr_banks)
>   {
>   	struct udevice *dev;
> -	efi_status_t ret;
> +	efi_status_t ret =3D EFI_INVALID_PARAMETER;
>
>   	EFI_ENTRY("%p, %p", this, active_pcr_banks);
>
> -	if (!this || !active_pcr_banks) {
> -		ret =3D EFI_INVALID_PARAMETER;
> +	if (!this || !active_pcr_banks)
>   		goto out;
> -	}
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +
> +	if (tcg2_platform_get_tpm2(&dev))

EFI_INVALID_PARAMETER does not convey the problem type.
Should we return EFI_DEVICE_ERROR here?

The authors of the specification only foresaw one or more of the
parameters being incorrect (EFI_INVALID_PARAMETER).

> +		goto out;
> +
> +	if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))

EFI_DEVICE_ERROR?

Best regards

Heinrich

>   		goto out;
>
> -	ret =3D tcg2_get_active_pcr_banks(dev, active_pcr_banks);
> +	ret =3D EFI_SUCCESS;
>
>   out:
>   	return EFI_EXIT(ret);
> @@ -852,14 +860,15 @@ static efi_status_t measure_event(struct udevice *=
dev, u32 pcr_index,
>   				  u32 event_type, u32 size, u8 event[])
>   {
>   	struct tpml_digest_values digest_list;
> -	efi_status_t ret;
> +	efi_status_t ret =3D EFI_DEVICE_ERROR;
> +	int rc;
>
> -	ret =3D tcg2_create_digest(dev, event, size, &digest_list);
> -	if (ret !=3D EFI_SUCCESS)
> +	rc =3D tcg2_create_digest(dev, event, size, &digest_list);
> +	if (rc)
>   		goto out;
>
> -	ret =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> -	if (ret !=3D EFI_SUCCESS)
> +	rc =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
> +	if (rc)
>   		goto out;
>
>   	ret =3D tcg2_agile_log_append(pcr_index, event_type, &digest_list,
> @@ -901,10 +910,10 @@ static efi_status_t efi_init_event_log(void)
>   	struct tcg2_event_log elog;
>   	struct udevice *dev;
>   	efi_status_t ret;
> +	int rc;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	if (tcg2_platform_get_tpm2(&dev))
> +		return EFI_DEVICE_ERROR;
>
>   	ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE=
,
>   				(void **)&event_log.buffer);
> @@ -933,9 +942,11 @@ static efi_status_t efi_init_event_log(void)
>   	 */
>   	elog.log =3D event_log.buffer;
>   	elog.log_size =3D TPM2_EVENT_LOG_SIZE;
> -	ret =3D tcg2_log_prepare_buffer(dev, &elog, false);
> -	if (ret !=3D EFI_SUCCESS)
> +	rc =3D tcg2_log_prepare_buffer(dev, &elog, false);
> +	if (rc) {
> +		ret =3D (rc =3D=3D -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERRO=
R;
>   		goto free_pool;
> +	}
>
>   	event_log.pos =3D elog.log_position;
>
> @@ -1306,8 +1317,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev))
>   		return EFI_SECURITY_VIOLATION;
>
>   	rsvmap_size =3D size_of_rsvmap(dtb);
> @@ -1356,8 +1366,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(s=
truct efi_loaded_image_obj *ha
>   	if (tcg2_efi_app_invoked)
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev))
>   		return EFI_SECURITY_VIOLATION;
>
>   	ret =3D tcg2_measure_boot_variable(dev);
> @@ -1406,9 +1415,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	if (tcg2_platform_get_tpm2(&dev))
> +		return EFI_SECURITY_VIOLATION;
>
>   	ret =3D measure_event(dev, 4, EV_EFI_ACTION,
>   			    strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
> @@ -1437,9 +1445,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_eve=
nt *event, void *context)
>   		goto out;
>   	}
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev)) {
> +		ret =3D EFI_SECURITY_VIOLATION;
>   		goto out;
> +	}
>
>   	ret =3D measure_event(dev, 5, EV_EFI_ACTION,
>   			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> @@ -1469,9 +1478,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services_fa=
iled(void)
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> -		goto out;
> +	if (tcg2_platform_get_tpm2(&dev))
> +		return EFI_SECURITY_VIOLATION;
>
>   	ret =3D measure_event(dev, 5, EV_EFI_ACTION,
>   			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> @@ -1551,8 +1559,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
>   	if (!is_tcg2_protocol_installed())
>   		return EFI_SUCCESS;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS)
> +	if (tcg2_platform_get_tpm2(&dev))
>   		return EFI_SECURITY_VIOLATION;
>
>   	ret =3D tcg2_measure_secure_boot_variable(dev);
> @@ -1577,8 +1584,7 @@ efi_status_t efi_tcg2_register(void)
>   	struct efi_event *event;
>   	u32 err;
>
> -	ret =3D tcg2_platform_get_tpm2(&dev);
> -	if (ret !=3D EFI_SUCCESS) {
> +	if (tcg2_platform_get_tpm2(&dev)) {
>   		log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
>   		return EFI_SUCCESS;
>   	}
> @@ -1586,6 +1592,7 @@ efi_status_t efi_tcg2_register(void)
>   	/* initialize the TPM as early as possible. */
>   	err =3D tpm_auto_start(dev);
>   	if (err) {
> +		ret =3D EFI_DEVICE_ERROR;
>   		log_err("TPM startup failed\n");
>   		goto fail;
>   	}

