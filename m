Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9D6CD1284
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 01:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26BFF8821D;
	Fri, 29 Mar 2024 02:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EasrIDlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C8D88203; Fri, 29 Mar 2024 02:02:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7089E88150
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 02:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711674115; x=1712278915; i=xypron.glpk@gmx.de;
 bh=uSIJC0MDT6XwQ0HhbxqEGgjztQ1K0rm27ygXO+3RYIg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=EasrIDlA49rfdmzMHuVkbC0o7+1gBOWLkVjz+qLyvQ7KpjIKjbO7n6/5UJ0GJc5s
 0ccGSNr7eyZKy3fR5jU3EvAe8yLk+MbK7Rkf20E2YeJQ67AnliQENSDOSTtziehfK
 QvNuvJIIb0DBWicYJJntOL2D5MW4/pWma2SMZoZ+tQW4D3wePN2XHUmT5T3lRdlOS
 O82LJjwoop1sbuBet2ly0qe24lvGx7xR/JZcMZDxtLMZCBnFlr7bkk00O+ZUmgWvu
 wN7xkWnp7+/ZmCGTtrfPx3/LJnTz3ZOtRPe9qHrhBEOsKYfGq8USKcKTW6kQPJIT1
 M0cJJ/h/zUgOv2R9DA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1sP4CG03d5-00aGMh; Fri, 29
 Mar 2024 02:01:55 +0100
Message-ID: <c9320079-458a-44f5-85a6-3a7c8bd3585e@gmx.de>
Date: Fri, 29 Mar 2024 02:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] part: efi: Treat unused partition type GUID as a
 valid case
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Steve Rae <steve.rae@raedomain.com>, Petr Kulhavy <brain@jikos.cz>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240328222951.11431-1-semen.protsenko@linaro.org>
 <20240328222951.11431-2-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240328222951.11431-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3wdqj9xPsy9c0uvkSE6w7rI5NJgELxIOrmnS66Rty5dH2RFeHxj
 TmOy7Xb3LBgehfw3mwBiI/JdNS4+kAgqvrwmlMKExLEf5GJ4b+KSlJ86FbQUW9e4Cp+MRET
 xF4e2M4MNy57DgtNtFEhPx8QfBozNuQCTqvrBAb0lan73eHSudoE47ppYXLfsRA5zaVnAiV
 2zVPBHvrigdy8aFtibVBw==
UI-OutboundReport: notjunk:1;M01:P0:hzODbAp7E2w=;u01Z/gUJqMNzogLxodYHoZKAoId
 W57HgmCzSRJZrjtlt2H9kDxQgjlN4q55xHxaWwBHSdoZtqzq6pXeuWQbXMZ2IDChrkt9JKlkz
 nU+srjC7hVUo5tZijPspvmeOUFnso+NfGWHuKoqSdMzFsw4e7NwT7dsudB8XOIhT7RDYHywNB
 INON7votAl5oSsQ3W2nCgck1Jz9cMEqEZCbXc1u8Qsb8dnF/BnIT4fC1X5hULYDX0vOziDDOF
 ELO8dPdpv+9UQ7TigVY7W2WByJ3iWx6qti9kKP+YtSehDOsVSChQy6poMFE3/C3TChhnw54SJ
 UcOvda0Qwyo4qrm6KnJpIPby9JPvcnf4DgjlTb+UkrlCvZHb40Q/zLTOsI53PtLF9CA2ExKWZ
 pt3J2O+Zjpj0yO4C3y8WMZEBZmTyoVLcSBq77v3XKLAeASrIy7GuCOBhhcqFuQiu71ZdGRhno
 tM8/ix8BR40sJl/2Ucs+7gko/69rY/LeBl5oJGNMTGi6+3EpEimASsjr/VbEapK+TAzn7wraw
 4uBtLBfDdQ3l/iCx+mPB6EgFDhEfAmYGqc3GZ0eGC7c1QO2FR76Da0j7oB+u71WPbpr0S1J0l
 mRklH3OYOtZagLulKu+pBB6g/TaxJ+zcPffHuTaUa0CqgpI60w5aW5kPfEqeN3FIqXiWi5urv
 lwwGjXZT+9LgMLZqsuRkyCiGaMdcHw+Rt5Kbf0ceQ0rKrs/Imw/W7FT6PSBqg0RGRqA7xTDhR
 ByKuV4ENbXVjt7VFTzCsJkuBqm3AumvkyIo993giySSPPOk4FGFD8FhmbZuNGzyjmIg/Q42yW
 Y6HChY1UDyCCxdnYIfSjACurjMOkkTWbHUZ5bjrygrC/M=
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

On 3/28/24 23:29, Sam Protsenko wrote:
> Some platforms use the "unused" (all-zero) GUID as a partition type GUID
> to make some partitions hidden from the OS. For example, Samsung phones
> and other devices often have GPT partition tables like that, created by
> their "gpt_builder" tool [1]. All partitions with FILESYS=3D0 value
> (second column in [2] file) will be created in a way that:
>    1. Partition type GUID will be all-zero ("unused")
>    2. Attributes[48:49] bits will be set to 0 (whereas non-zero values
>       mean the partition is visible to the OS: 1=3Draw, 2=3Dext4, 3=3Df2=
fs)

The UEFI specification is defining what a GPT partition table has to
look like.

According the specification partition type GUID
00000000-0000-0000-0000-000000000000 marks an "unused entry" in the
partition table.

An unused partition table entry cannot define a partition. It is one of
the entries, that you skip over when enumerating via your patch 1/2.

With this patch 128 partition table entries are printed for an image
having a single partition.

=3D> part list host 0

Partition Map for HOST device 0  --   Partition Type: EFI

Part    Start LBA       End LBA         Name
         Attributes
         Type GUID
         Partition GUID
   1     0x00000800      0x0001f7ff      "EFI system partition"
         attrs:  0x0000000000000005
         type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
                 (system)
         guid:   ee474198-4601-4d5c-81f0-54acf904dd40
   2     0x00000000      0x00000000      ""
         attrs:  0x0000000000000000
         type:   00000000-0000-0000-0000-000000000000
                 (00000000-0000-0000-0000-000000000000)
         guid:   00000000-0000-0000-0000-000000000000
...

128     0x00000000      0x00000000      ""
         attrs:  0x0000000000000000
         type:   00000000-0000-0000-0000-000000000000
                 (00000000-0000-0000-0000-000000000000)
         guid:   00000000-0000-0000-0000-000000000000

This is definitively wrong.

>
> Although it's true that Linux kernel verifies the partition type GUID to
> be non-zero (in block/partitions/efi.c, is_pte_valid() function), where
> its U-Boot counterpart code was borrowed from originally, in case of
> U-Boot we want to handle partitions with "unused" GUIDs the same way as
> any other valid partitions, to allow the user to interact with those
> (e.g. list partitions using "part list", be able to flash those via
> fastboot, etc).

You cannot interact with a non-existing partition.

You may create a new partition in any empty slot that Samsung's tool has
left in the partition table and then write to it. No patch is needed for
this.

Best regards

Heinrich

>
> [1] https://gitlab.com/Linaro/96boards/e850-96/tools/gpt/
> [2] https://gitlab.com/Linaro/96boards/e850-96/tools/gpt/-/blob/master/g=
pt_layout
>
> Fixes: 07f3d789b9be ("Add support for CONFIG_EFI_PARTITION (GUID Partiti=
on Table)")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   disk/part_efi.c | 21 +++++----------------
>   1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 4ce9243ef25c..6b138abae0a6 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -1166,28 +1166,17 @@ static gpt_entry *alloc_read_gpt_entries(struct =
blk_desc *desc,
>    */
>   static int is_pte_valid(gpt_entry * pte)
>   {
> -	efi_guid_t unused_guid;
> +	/*
> +	 * NOTE: Do not check unused (zero) GUIDs here, it's considered a vali=
d
> +	 * case in U-Boot.
> +	 */
>
>   	if (!pte) {
>   		log_debug("Invalid Argument(s)\n");
>   		return 0;
>   	}
>
> -	/* Only one validation for now:
> -	 * The GUID Partition Type !=3D Unused Entry (ALL-ZERO)
> -	 */
> -	memset(unused_guid.b, 0, sizeof(unused_guid.b));
> -
> -	if (memcmp(pte->partition_type_guid.b, unused_guid.b,
> -		sizeof(unused_guid.b)) =3D=3D 0) {
> -
> -		log_debug("Found an unused PTE GUID at 0x%08X\n",
> -			  (unsigned int)(uintptr_t)pte);
> -
> -		return 0;
> -	} else {
> -		return 1;
> -	}
> +	return 1;
>   }
>
>   /*

