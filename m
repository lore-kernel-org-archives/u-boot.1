Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA1C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E3C8785F;
	Sun, 31 Dec 2023 17:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xm7dLluw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABC587874; Sun, 31 Dec 2023 17:11:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104258785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704039096; x=1704643896; i=xypron.glpk@gmx.de;
 bh=f5PDAHRSTcA68W+TmFr86L2CmgGd0dFAG8NIo2/SHAA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Xm7dLluwWUrb4SbHzJpt3uIheAhH39DTRrekruOFcR05xJX+p9LexRRQ5+vFxxxW
 qGpUFjzM0hOTt2s8JEKKnWIxHvYgAA3oUUf+ESIBNvEbsZVKEf6A2V0JAGRMfRrVQ
 S/aOSBicGdsr9g6U4GkNqr1KYELLgaBhEVeeTqD4gRkQNM9JONtGlUDuf1ER/wCSC
 1GgV5ZZpUh7hXdgXzkIW7XdcTy3h9ffn8WcrLYMg6T2/kgYmeFgyk7+t7PyxW/Veh
 ww7fkJEC0xsc6g67iqfW9+MYx3dQrudDsuBHopefQhNW7jSOM3jhTIIukskOdDvbq
 OaKyc7mKIunyT7Ba/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1qmZX735Mv-00bszs; Sun, 31
 Dec 2023 17:11:36 +0100
Message-ID: <b11c19c1-7ca6-468c-9355-7b9461a628df@gmx.de>
Date: Sun, 31 Dec 2023 17:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-5-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231231152555.464874-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+cfZB6e4rsceJ/9zWPYkJi3VboNvlfynqW1/QQaKfhXs70NVrno
 agrJhzjznQ/P5LEnzBQqrEpIeT8rdK5IsYYHtf31LZN1OzmcreDReCLsmYQEhEOOiNZPDjb
 HQK1bFdgPjXmtZEgh+V1MGboI6l+Gaxdibu1T1myOdhGpAeD6HsChWJ+cq+PmrGIw0LumoC
 uD6SiuE30R6UYBKM3bnRw==
UI-OutboundReport: notjunk:1;M01:P0:2QaeEi27BSo=;lHDQJuUwV/waNO5/Lj09BVNRXg/
 eAzMDluW4fqv6Cc+LzT8hLegR/xAYMGKXuTKbmlFjEvNoAPuFxf6CeThSc+twEzsFrxgHLCDE
 1C/F4aZn1OPpGvHD7jayp7oMirM94ht0ttkcGenBeBH4yuHOLohR9EH9dHmO2IeteGMFRpbUY
 TM2N1DTVry7KlZRR52KN8zMQuC0nvLiUzkIyZiPg8lnMFQ3NkR2NlyTQPOhjKMG11bs+Kajq9
 krXY9coo8exF8J8MRNmEaBrNyiV+jdNXL+rjIfQp68PNoJBJmfMhQqBhntwIEy9hmsgvld0x0
 5BfFUtkDPVmS3WUr+HLnhAT4jOuTldx9/4mYvrS9PIH/lsyqVLgbLagE3F8/gf+SnXU0qFAQp
 Br4I5Yt+G5x11QIbN0Yq7By8SnCevEEmpvDlkR7aD3bxCfwoXrr4Ze+sBLo9FAgn/d/Of7aRO
 s36kK+h2v613fRD7PYqbNPYBePEunqpmIdZ829qwm9YsoC5d7SSU0Vl3otaftw04Fyfo+SL/S
 SN4zrQc0DSagxxXeyuhuLdKoOo69hO10OyD9yI93KgIqDHWzbKI64omcBK/1fgqJbu+NIW5qg
 vCzdH/yAErcC35yIt7FudR0ZNnGGaBPGYRxSkIcecaFiM7hzsT331U6kQ9Ww/Wu8lG2xm8uKA
 f6MZFdq6MhtTHOfMBT5xOEi25gqfyvFZUggx6VsVTlOuDrO5dbbBluLMEDZgq1dH1QFHPWyEG
 zBZBaSVpCeWqrf3n1qNaMLvitIPPx6SlE8MAu1ssifvc07AH9bPOi/tiPAtFyJEDdczSzvqix
 qnQstBEEhuIFWyBvUzGNMl+SiQI7dtQ4dCy4+LV/GayU7HJ9X4nF5oU9ryO3O75pDvuyY7ebp
 NrURDxv2LoHoQJ1QZbtJR+X+k+VNKZlU1XNvIxq+mJ2bJeB4S9sVb9sVgAKwMBN2PDZ9gMori
 UhrVBQ==
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

On 12/31/23 16:25, Simon Glass wrote:
> When the SMBIOS table is written to an address above 4GB a 32-bit table
> address is not large enough.
>
> Use an SMBIOS3 table in that case.
>
> Note that we cannot use efi_allocate_pages() since this function has
> nothing to do with EFI. There is no equivalent function to allocate
> memory below 4GB in U-Boot. One solution would be to create a separate
> malloc() pool, or just always put the malloc() pool below 4GB.
>
> - Use log_debug() for warning
> - Rebase on Heinrich's smbios.h patch
> - Set the checksum for SMBIOS3
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Check the start of the table rather than the end
>
> Changes in v2:
> - Check the end of the table rather than the start.
>
>   include/smbios.h |  6 +++++-
>   lib/smbios.c     | 30 +++++++++++++++++++++++++-----
>   2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index e601283d293..77be58887a2 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -12,7 +12,7 @@
>
>   /* SMBIOS spec version implemented */
>   #define SMBIOS_MAJOR_VER	3
> -#define SMBIOS_MINOR_VER	0
> +#define SMBIOS_MINOR_VER	7
>
>   enum {
>   	SMBIOS_STR_MAX	=3D 64,	/* Maximum length allowed for a string */
> @@ -80,6 +80,10 @@ struct __packed smbios3_entry {
>   	u64 struct_table_address;
>   };
>
> +/* These two structures should use the same amount of 16-byte-aligned s=
pace */
> +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
> +	      ALIGN(16, sizeof(struct smbios3_entry)));
> +
>   /* BIOS characteristics */
>   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
>   #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
> diff --git a/lib/smbios.c b/lib/smbios.c
> index eea72670bd9..7f79d969c92 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -567,7 +567,11 @@ ulong write_smbios_table(ulong addr)
>   	addr =3D ALIGN(addr, 16);
>   	start_addr =3D addr;
>
> -	addr +=3D sizeof(struct smbios_entry);
> +	/*
> +	 * So far we don't know which struct will be used, but they both end
> +	 * up using the same amount of 16-bit-aligned space
> +	 */
> +	addr +=3D max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry=
));
>   	addr =3D ALIGN(addr, 16);
>   	tables =3D addr;
>
> @@ -590,16 +594,32 @@ ulong write_smbios_table(ulong addr)
>   	 * We must use a pointer here so things work correctly on sandbox. Th=
e
>   	 * user of this table is not aware of the mapping of addresses to
>   	 * sandbox's DRAM buffer.
> +	 *
> +	 * Check the address of the end of the tables. If it is above 4GB then
> +	 * it is sensible to use SMBIOS3 even if the start of the table is bel=
ow
> +	 * 4GB (this case is very unlikely to happen in practice)
>   	 */
>   	table_addr =3D (ulong)map_sysmem(tables, 0);
> -	if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) =
{
> +	if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)UINT_MAX) {


All SMBIOS specifications since version 3.0.0, published 2015, allow
using a SMBIOS3 anchor in all cases. SMBIOS_MAJOR_VER =3D=3D 3.

Our target is to keep the code size small. Why do you increase the code
size here?

Best regards

Heinrich

> +		struct smbios3_entry *se;
>   		/*
>   		 * We need to put this >32-bit pointer into the table but the
>   		 * field is only 32 bits wide.
>   		 */
> -		printf("WARNING: SMBIOS table_address overflow %llx\n",
> -		       (unsigned long long)table_addr);
> -		addr =3D 0;
> +		log_debug("WARNING: Using SMBIOS3.0 due to table-address overflow %lx=
\n",
> +			  table_addr);
> +		se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> +		memset(se, '\0', sizeof(struct smbios_entry));
> +		memcpy(se->anchor, "_SM3_", 5);
> +		se->length =3D sizeof(struct smbios3_entry);
> +		se->major_ver =3D SMBIOS_MAJOR_VER;
> +		se->minor_ver =3D SMBIOS_MINOR_VER;
> +		se->doc_rev =3D 0;
> +		se->entry_point_rev =3D 1;
> +		se->max_struct_size =3D len;
> +		se->struct_table_address =3D table_addr;
> +		se->checksum =3D table_compute_checksum(se,
> +						sizeof(struct smbios3_entry));
>   	} else {
>   		struct smbios_entry *se;
>

