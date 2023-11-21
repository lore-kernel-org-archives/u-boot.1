Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5640C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3D3870F8;
	Tue, 21 Nov 2023 03:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HVC+4voi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E137875A1; Tue, 21 Nov 2023 03:11:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98EB869F6
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700532694; x=1701137494; i=xypron.glpk@gmx.de;
 bh=jbmDPkuA+0UeYSXieuGpHZ7I6bhQMm6EyIE4qdE0s1w=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=HVC+4voikzwxNFZk2x2pR3KswzuFejpxQRnAvz63gPA8OZr/RqhFuf3+eDJD4+C4
 /aigyFLZ0zcQWXHFH+GRhe9aMTk+Ut8JgMve5xTTcCs7la9osQ5h1l9flCLQVPIq7
 YpA5wromNvbsm8bmuwYJ44OxfsOcafvO5tOjwHBMT6jj1atw6HAo+0NBPKFBbtCwy
 YHnSKJcaoNVRPm/6fHEf1fk8UR5ykUMVNNstgFq3USbG47oxEdvymxX0P8Q3itKyO
 f5BkUnx+R2zWwUg9LPyenkAFZQfMkOw3Bzaj7YuS7ZwC2FvldZwniUdWByNGq9+Sz
 YfwgSZfoB+3Xaila1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1rYGGF1Sbx-00gEee; Tue, 21
 Nov 2023 03:11:34 +0100
Message-ID: <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
Date: Tue, 21 Nov 2023 03:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyChwuljvL5YZvCC8ljT34sdOyxdL9kSFw8rXadlbkpkpqLIrOe
 iTNu+muHW8BnCBqNkTNvLcCPM3jDv6a04zggxsUkW0Qw8OzcJ6ATEEBAaXNvQwBmRwrEftw
 23D0JIKERWDDZOfeO01HcFZkCVI1jrIUcVLMHazqSE2P+PyA9EYZW5/BBVXVod07OAljaQs
 6fWfjTULkZFx3k7X+diHA==
UI-OutboundReport: notjunk:1;M01:P0:epDIck+J6ow=;Qmg03aqDrUt4qbp82MidRSrHbt9
 JkC0+oU0s8TdGD+liZhf3EhJsW5X4tXgSJMpwCAzaEI9OMVBFldd6ToQbB/YC7m+kMd2ilL5+
 hYyqLnJYvoPuMe8Xq9fo6kSln1uSWgXteQ9NwHK3ORVWiKe6Zo/ht0X4NfzNScGDaIldMaFbw
 9eXWaesmReP18kmqGgV/+zv6y6BUw35tTVY+P/EliJ82bFGqsrvJEQ/QFU19u4ezwOT0WhUNx
 gktuqzSNj89L58X+TNweKaqRU5e/2GcvV3QdcQXan28EERkMfzMsIbpdZzNcx86R9x/0V13Q1
 rBXI121lVjm1ejj9cDbxYZlprCaxD4lx8cwdYfC8tyQiSO5EBgWgOCQTMfxfQGaUW6xMFj+kW
 QfLO1bYIJMYQliPP3YbSUiS/o1IadqaoQhCxwBDmsS1t1493NH9ogyw8uFmJQcbwRVEnzdmBf
 KSmNHZ4MjgsGf0qS0VZ6YKLY70cBM3+fNAUgRAjfDjNABT2Odw5rq41kFMIZldFQq2Y92a/tl
 B5ah0Kky8f4/YiiCDp15but/KJvx9m23oBn4etQl5ADtLE0Xd4Uq1+Wh1j5WoLLnBupoisw/m
 +g7wqcefAI0hJsjS8RC0DB3sV2I0Gxvp0YnXCDzDkPcQLgPB4VgKq5tD0MMk4+NXSiYHr+NVL
 5z2J6f3KkCIUqb7F8E6RO3AUyt8rTCZ0U9FHmZS1/1HKlUOkxoycl8H9nueCk3TFpTyI1eQAg
 Uinmo1suzbohmuyV2XiYpgvauaE8K8jdOTXcGDsHx1KhWRVZ0q5yBmWOQl/Nj/7j75n9TvFSG
 E4loLGRsbriXs/jDh3lbVQrf04tuI7dqI9cnNaZsHmD+9BgyFrtlWsjv2+/sd7kEbsqWr+oZz
 13ssxBhLpGbYxvHRIqm/eJ7kwC5okWrNrC5WOSmdiEiVNPn8hBJDhQGCylxE3Dm5JauhZ4rGX
 dj+WzQ==
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

On 10/15/23 04:45, Simon Glass wrote:
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
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Check the end of the table rather than the start.
>
>   include/smbios.h | 22 +++++++++++++++++++++-
>   lib/smbios.c     | 24 +++++++++++++++++++-----
>   2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index c9df2706f5a6..ddabb558299e 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -12,7 +12,8 @@
>
>   /* SMBIOS spec version implemented */
>   #define SMBIOS_MAJOR_VER	3
> -#define SMBIOS_MINOR_VER	0
> +#define SMBIOS_MINOR_VER	7
> +
>
>   enum {
>   	SMBIOS_STR_MAX	=3D 64,	/* Maximum length allowed for a string */
> @@ -54,6 +55,25 @@ struct __packed smbios_entry {
>   	u8 bcd_rev;
>   };
>
> +struct __packed smbios3_entry {
> +	u8 anchor[5];
> +	u8 checksum;
> +	u8 length;
> +	u8 major_ver;
> +
> +	u8 minor_ver;
> +	u8 docrev;
> +	u8 entry_point_rev;
> +	u8 reserved;
> +	u32 max_struct_size;
> +
> +	u64 struct_table_address;
> +};
> +
> +/* These two structures should use the same amount of 16-byte-aligned s=
pace */
> +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
> +	      ALIGN(16, sizeof(struct smbios3_entry)));
> +
>   /* BIOS characteristics */
>   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
>   #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
> diff --git a/lib/smbios.c b/lib/smbios.c
> index c7a557bc9b7b..92e98388084f 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
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
> @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
>   	 * sandbox's DRAM buffer.
>   	 */
>   	table_addr =3D (ulong)map_sysmem(tables, 0);
> -	if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) =
{
> +	if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)UINT_MAX) {

You have to check the end of the the last SMBIOS structure not the start
of the first SMBIOS structure against UINT_MAX.

> +		struct smbios3_entry *se;
>   		/*
>   		 * We need to put this >32-bit pointer into the table but the
>   		 * field is only 32 bits wide.
>   		 */
> -		printf("WARNING: SMBIOS table_address overflow %llx\n",
> -		       (unsigned long long)table_addr);
> -		addr =3D 0;
> +		printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n"=
,
> +		       table_addr);

This should be log_debug().

> +		se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> +		memset(se, '\0', sizeof(struct smbios_entry));
> +		memcpy(se->anchor, "_SM3_", 5);
> +		se->length =3D sizeof(struct smbios3_entry);
> +		se->major_ver =3D SMBIOS_MAJOR_VER;
> +		se->minor_ver =3D SMBIOS_MINOR_VER;
> +		se->docrev =3D 0;
> +		se->entry_point_rev =3D 1;
> +		se->max_struct_size =3D len;
> +		se->struct_table_address =3D table_addr;

You must fill the checksum:

se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3_entry));

With the checksum filled I can use dmidecode in Linux based on the
SMBIOS3 table:

ubuntu@ubuntu:~$ sudo dmidecode
# dmidecode 3.5
# SMBIOS3 entry point at 0x27ef53000
Found SMBIOS entry point in EFI, reading table from /dev/mem.
SMBIOS 3.7.0 present.
# SMBIOS implementations newer than version 3.5.0 are not
# fully supported by this version of dmidecode.
Table at 0x27EF53020.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
         Vendor: U-Boot
...

Best regards

Heinrich


>   	} else {
>   		struct smbios_entry *se;
>

