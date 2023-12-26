Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47DC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A34F87855;
	Tue, 26 Dec 2023 11:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hr47/wbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82448789B; Tue, 26 Dec 2023 11:56:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6312C87846
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703588201; x=1704193001; i=xypron.glpk@gmx.de;
 bh=JPf1U6fSrF6iETwHy9y665o/ImT1PNf4MBbX0ah7KwA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=hr47/wbCI2CAn3DBcqUO85QVdcw6ZPwK0TgQa1HlB6kpoN71wHo8izjfNPOU8EAH
 tAHDpv1+JpmfWN7cY3WwsibTrUXCQzIU0l//lkNu7yyiPSQSfAQjeNfvEKU25gbI1
 TwNa7uF3h9RcbBhq1Zgs5OnV1cogW9m9m+0k6tcEXctqXD9cnDiX2yzUd+6oz+Hcc
 ZLGzpLDQwVREdGN6Py2wwAsWQ1oKjqVRBE2rzM6XE5sGrc24UTH9mW6n3BeUF7ehW
 fPi9gXiLxzSc4hiZc4XLO2Ny/h81JWCbaho+l3l5xRm3ZFa+RAchBcV1toKr4RJ1A
 incObkdzqtaBOAYPMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1qzrlz1qKY-00rWwN; Tue, 26
 Dec 2023 11:56:41 +0100
Message-ID: <0979cfd8-edf6-4934-9dfe-46e0fb6a67f6@gmx.de>
Date: Tue, 26 Dec 2023 11:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cqUeij7860mPv69VSsgmrMEVn92/HzeIA3hwxtYm9bMbB1jNITl
 j+zjYI/aFXsiFJcGuzJvdOgJbQTmB4jJ+hVK9pzXA/uxbiYlHWe5pN6hLtbAGJK7v1HYH4k
 0a+ddGvs9UFCOkpw06FkITmtEkS+/+I7o3i6ZgFJRk5KpgkH3Z+Ie5ujbnUh4MbF3aUOLeL
 5R/kTihIobgCDLcGEQihQ==
UI-OutboundReport: notjunk:1;M01:P0:pr0JGZQyOao=;yRcT471jGhhcYeeUeAq3kFB+nHE
 fd63fFzpQ5J8If5804TI2nS1LMdBW4ZtZfRI4URjOfPNT+6ftieCg0hLTpoTfNPjVjoI0P0t6
 VfEZ6eq/xN75ky4xqhL/G1diPU1+I/6JrdhQPughos2NqoSZrjijARGFTnWIdl33k0LKyRpsV
 R7vKQX6AesPX1Kd5NHuuJ2DIISbtq3aigYH8l3a2RoBHzjXoGg+XKhpJ6BEbYLQ0yp1hbclqw
 byTbeb6vkpIfISFI8q8lob4VyxKu9qIkWkx8i4r+RElW3C/VSaYUGHkBWj0v0WN0P3QaGJ1sE
 M1ZVKL4PqQuI+QON4v8L1uLQ8mBdOLTGZXg6+m6Uij6sRiwBsrCFxXEZh/Vt5DlHN7IQ6ldHn
 If/i6YOvQ0PbmjyJlVgbR6fRUZY0Qw4zFA5SyMRcM019VmDy3+fXlplK3owv9oAZ99vFhGZjD
 wAqN1cqjV+QM+kUDM63RgtpcKXQRukhpwlV7WuNBz2WXapieY7mCJO9hSIacjeo9TUKq3TUcc
 wP9FIpQD1NoVPpzupdE3jEbQRZR64ghve3P7WKw3OpImNGTAJ/Ds/7jcakONS8TlpNBr/uo1k
 V3pnoeJPRaG5zoYi8Q6w4llXkX/zWF64vZCVqrwrmjzlJg2iYdh9A+bWhiwcMwVAA1C/4aAnT
 iK2xzVuaej8FJwVkkbmAW8QotynljaOTKeUHCoEj9GovOxqvV6HJD0hwrlkLTxav7/4RakZQr
 wDyg54McVrwSOfLkuYknZUUVaUZmlhuFD5t8JW5nq2l846Wj3fGjEyMt4KUCeeJO5YprokXNf
 u69SJ9tH0YKXXRFs1SzEf9IVGn5p0BaVxh1hdl9Fb+O/3t76OSHApjNIlyRD2T0fqswEbiKfV
 4F1MHjET1eBSKQSaCcOeGGDj/ZgxmboJ9h9jculke32D7ghVmn4cB+1+nVklaVGuihzvoz587
 eaNhmn/+vno/Jjgiw0fDSCWc8Ig=
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

This empty line is superfluous.

> +	u8 minor_ver;
> +	u8 docrev;

'doc_rev' would be more consistent with the other fields.

> +	u8 entry_point_rev;
> +	u8 reserved;
> +	u32 max_struct_size;
> +

This empty line is superfluous.

Please, consider copying the comments from my patch

[PATCH v2,1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
https://patchwork.ozlabs.org/project/uboot/patch/20231223010334.248291-2-x=
ypron.glpk@gmx.de/

Otherwise looks good to me.

Heinrich

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
>   	} else {
>   		struct smbios_entry *se;
>

