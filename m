Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83121C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 12:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E2988323;
	Mon, 10 Jun 2024 14:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dCF7YiVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BD1884F4; Mon, 10 Jun 2024 14:22:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7AD888096
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718022138; x=1718626938; i=xypron.glpk@gmx.de;
 bh=Yss/RU1IjxKUyNDXdC24PxHBryyOKuBxJnIs6iwi4RM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dCF7YiVMql1oBgtlvuqfIlGHkH3JGMsgqPW89AUM8WHL53TtdvV6fzP7ytgz5LTD
 hTPXQYVvKz8WiYdiLBZcnWyuRVk/SoKK0TlAyiy7foxV5kBAlEV3v/FOgcR5tw1e3
 372M/CHCfzBxB/HJEVdemXWJn6IEkZXf4FzmvfB16N5GUPmDVeAi7VcaqGKxxbJRO
 BWx16fIpGkhuAYis4865+DXiwUMSLqyaN9pE1K1myGVZpmZ/URmsDsSfTyDo2KVCt
 vs+Mwgu+xFq0OGjBx6/vQywGEge8zHKPwizh4gdMk7SsUia9Ao5jvun3d2XXH3IXg
 hrdYM9/AUZnz0fSyEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1sUQcP1PF1-00sOvk; Mon, 10
 Jun 2024 14:22:18 +0200
Message-ID: <b4549859-022e-4992-8a44-9dc9a21d943b@gmx.de>
Date: Mon, 10 Jun 2024 14:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] part: efi: Rely on a definition to specify the primary
 GPT position
To: Roman Stratiienko <r.stratiienko@gmail.com>
References: <20240519153542.2572014-1-r.stratiienko@gmail.com>
Content-Language: en-US
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240519153542.2572014-1-r.stratiienko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BnqeEfnMey+PH254ZjMm6b7LdXolBQSXI37p2heBCFJz9CPjRet
 VILOkmiskcacWdSDmb9HuQooKvSIo/k7zVvF9Gw+MAPWwkmJCTYI31ZM68ZCBDI+Ikql533
 7TV+JKUF0Okc4Wa0uSqk4Zj+dN/h2zzhY3VwrjWGoogs5C2JDSDZf/82m2LrRHTn2j3EkF1
 PGqTpk10gkViEcB+hLSTA==
UI-OutboundReport: notjunk:1;M01:P0:bHYWOE+RP5E=;XPzcHqvI2hctcDbUcDmGTL5K6RN
 VT9mnD7feTfa0TUV/GreLWwZPnNMlee9qWrkI3KZ/VL0W1roQKEQWusuJPyKKjjyiNJOygxrY
 SrAnhcvH3Qw2A49rgKDf+gyRW/u0Vpqm0F2lSvYbHPGTCMi4A5yiurj5zMosR1TNqiFuosCna
 tpbY0trW9SxvZIiclN19BGXm9/1pr5NT5u7+elor5lpw6jZWAOCWzWg+Yt+kLoT24hwrL5iaF
 4aDr8/304aEkgb8zYAncbwvAD1A+Shznb9oZnR7r6/llf70liF+Qfb3v9YomGnyuLUTYNCEB+
 LneGYwI0+6OPqMQam6Z/Lr+F7JFDytInCBbqtFx+HLevx5t/2kt08qbR/Uq1eSu8JhN3QiJ9F
 Ecmc/V8FGvqYjRpwM8zMTfrHQ9T0Li22dsNlhWxx71vivFTaj5qn0FqFbZWmp4Vf3MAUCcL5r
 IB803fI76wB42cF6Wb+WL/eZLkgu8rtMNcTImKRJu6Ogy2mt1U6B+QaJX+OmwkOqpruzQplaR
 b8Bpv590xpU3MyE8RFAaoFxRklJi8rBixVGksK91CT4PA13X2xVXLm7GahEXVl4Ts7DMBoGh7
 A5DYy+xup8us3tH9pHfQXB7FBjC/OKX1GytuUCJV0eOIRSVHiDD6Un0/+edPFK0dbE1/JKTMY
 8wCeg7J4UFWFksVVFzVPRk1WgS9ABQc7hDCupADomou6a1dHeabBbz/2HLYlw7KDWFTlpNK/q
 UlvPky2fKhfVV2EyVnFv/76arjETRYCopLVS83XSDdKL0/1yQgS0694dTgw+eRs4mztDO4/l+
 gLRg2x6Hm3mANDDoxUFpaf4bKtEEaawgu7HY8B4ZKFDvc=
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

On 19.05.24 17:35, Roman Stratiienko wrote:
> Use GPT_PRIMARY_PARTITION_TABLE_LBA as the only source for a primary GPT
> location instead of hardcoding it every time.
>
> Sometimes, we need to shift the primary GPT location.
> Having the location in the single place simplifies such shifting.

In gdisk there is an expert command "j - move the main partition table".
This corresponds to CONFIG_EFI_PARTITION_ENTRIES_OFF. It does not move
the GPT primary header but only the partition entries. So sector 1 is
still occupied.

If I read you correctly, CONFIG_EFI_PARTITION_ENTRIES_OFF is not doing
what you need. Instead of only moving the partition entries of the
primary partition table, you want to move the complete primary GPT table.

Somehow the operating system must find the primary GPT table.

When writing the partition table shouldn't the offset be reflected in
the protective MBR fields StartingCHS and StartingLBA? See Table 5.4
"Protective MBR Partition Record protecting the entire disk*" of the
UEFI 2.10 specification.

Does Linux support this? For testing remove the backup partition table!

GPT_PRIMARY_PARTITION_TABLE_LBA should be made configurable in this case.

Best regards

Heinrich

>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>   disk/part_efi.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 4ce9243ef2..b55e251ea1 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -387,7 +387,7 @@ int write_gpt_table(struct blk_desc *desc, gpt_heade=
r *gpt_h, gpt_entry *gpt_e)
>   	gpt_h->header_crc32 =3D cpu_to_le32(calc_crc32);
>
>   	/* Write the First GPT to the block right after the Legacy MBR */
> -	if (blk_dwrite(desc, 1, 1, gpt_h) !=3D 1)
> +	if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1, gpt_h) !=
=3D 1)
>   		goto err;
>
>   	if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
> @@ -534,7 +534,7 @@ int gpt_fill_pte(struct blk_desc *desc,
>
>   static uint32_t partition_entries_offset(struct blk_desc *desc)
>   {
> -	uint32_t offset_blks =3D 2;
> +	uint32_t offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
>   	uint32_t __maybe_unused offset_bytes;
>   	int __maybe_unused config_offset;
>
> @@ -572,8 +572,8 @@ static uint32_t partition_entries_offset(struct blk_=
desc *desc)
>   	 * The earliest LBA this can be at is LBA#2 (i.e. right behind
>   	 * the (protective) MBR and the GPT header.
>   	 */
> -	if (offset_blks < 2)
> -		offset_blks =3D 2;
> +	if (offset_blks < (GPT_PRIMARY_PARTITION_TABLE_LBA + 1))
> +		offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
>
>   	return offset_blks;
>   }
> @@ -584,7 +584,7 @@ int gpt_fill_header(struct blk_desc *desc, gpt_heade=
r *gpt_h, char *str_guid,
>   	gpt_h->signature =3D cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
>   	gpt_h->revision =3D cpu_to_le32(GPT_HEADER_REVISION_V1);
>   	gpt_h->header_size =3D cpu_to_le32(sizeof(gpt_header));
> -	gpt_h->my_lba =3D cpu_to_le64(1);
> +	gpt_h->my_lba =3D cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
>   	gpt_h->alternate_lba =3D cpu_to_le64(desc->lba - 1);
>   	gpt_h->last_usable_lba =3D cpu_to_le64(desc->lba - 34);
>   	gpt_h->partition_entry_lba =3D

