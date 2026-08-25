Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D52C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 536A940564;
	Tue, 25 Aug 2026 18:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akSZbVem6-5y; Tue, 25 Aug 2026 18:48:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787683681;
	bh=grRKtx8zYClfjklLFNLOhC3YZLEXfWGN3l9a5Mrkels=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YhVxhIgpsTedGkeNBPN2iVan2+X/ryM5v+rf/9c6dW8dSRRdRvixjHhCl+qkF3TIH
	 /jJurmAPz6DlJ4XomKbxFZxHi8dewewEdJxnJH3/VYjuQpc1oAx6itxHg9V9j4K63P
	 0xv4ARyrpSSdklPxioQEV4/4PlVBSYeCzLGmj/asfbS6+TntagKle3e867rpvXdVLl
	 t33/jDWRGJhR1SYubzGWspaOpd9PCxsEFATlk62sPi5euaJAwRK9K6ZgdoqgR2fkY1
	 I4amcG3jxX7S37hv8MFysxQpg8PXtR5glep5TO5+Gzl+SxbU0B2AKOILW90A1wjPZ5
	 Q6PyodCsyz5qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46DB94054C;
	Tue, 25 Aug 2026 18:48:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3248B334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 211654054C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAqSrFLOsVAO for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:47:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Yz7zkknL
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8959F40505
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:47:57 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 319383FC39
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787683675;
 bh=grRKtx8zYClfjklLFNLOhC3YZLEXfWGN3l9a5Mrkels=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Yz7zkknL7RgvP1RUXsMvPJqLsJDECuYysdpy67AYOZ3MyBoW//HLaWZfZ0OYprje5
 arw9QZlwn6EzA8qAzQa9xUTsghquRABjf0oQHU/D0Ss2icbCMUQ8xVwZstryzXdKyh
 GAka7Lu3bfNZ+TFCHJ+GBhzyGU42bTP5lk4Pw+oXuzV1DA/AmFiQ/ewf7WvOdB6HN6
 ROeoHserc1tNn6nTVXhaIKGe+g95YbPt3tf8I58rbo0BZibgED0h5h0kA3c8fFiaHd
 4TaBEv/ZC0wgIkH1iL/OXcYxDs/c1ZAEPWrEvnQDamZohQiyWtUVPRHYjSkGUv9htA
 sQV//JPIoppkWgVnoBjd6xwKt1byQ5XV2uNw4YPK3e0yrb7aBoY6E56ywgrqtsHuFY
 tJnkopSk6T5Vkp28edHm9eq3vBnmfw+vxrUf1dFiYyL56dbSdD/X/Stx9Dm+RYrQbE
 sOzYHs02/N4McyPH/0vV2wOAjqMWZ2HSilzkyng4uqYM7mxtasNgv7LNQpYwf39DBT
 rCi7SprxBihcmdy/yzfVn4Y43MfNCG5bQPJlv4KU9LYsYSFWl4KmnD6UCz+/1a6RXg
 TdzBuawaT1nShCznyXDj5rD963+BMQ6r1MxbyU071lrzwahTyOLStcrL0gT/fWS3Bz
 +pCumcuO4MST9QL6RUCkKm0M=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a3899d74c5so121841a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787683675; x=1788288475;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grRKtx8zYClfjklLFNLOhC3YZLEXfWGN3l9a5Mrkels=;
 b=pGjl7uari43uU2d3GnQtKFxflQoa/c2Vxf5FbfYwCv5BGkv/fXqCgSlpMH/VWoJ8dt
 HeYts/ILR/6yNIXwuPOv7agB+0pwg7C10Frrf4SLoiM4lhe9fZQMhWwNBQj8sfdb8cO+
 nN9TFbS8/bKVJ9jzCwk9azA2tRAfTusKaEZ4usGjgOSbzrREeU4TH8WdkgoPYyw5YTU5
 AwKjlEP4iCxENchRLFJF3mMLJ4oBYwGRp+yjmvqh9xMZdUA+RS61l2q+etTAcCeWG8Tm
 39tjUmu5BxsgUT+USBgpcjdaVFfa/jY2SDnTdb0rtZBCCnD1Fg3qQMVwuyRDUk6/HdRd
 sm4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMKyp0aSrFOZ5RHisEu3kpVUzNGM5ZjmVaFpLAm2m0+pA62oAsqCFz5wOXKj0IiqVnhhXI75Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k8KasjTVUrG89Cdx3PUPHoo0ufEwYgZoq2qoB+GYx10tAeTkY4
 dipy/O8QNy8PTW4ySbDQx4iHMnrDsir0FulyVAzah6W2UVXIzhkZH2NsXroPwIVipHAKUUP98Ne
 bZajOXRp08PRtdExaHk37lS9k6I3/DNkvCJqkMDUVP40pTksTOwiO+CPXs2vGBfVt21wUwY7fjZ
 tlJWlF2qOeXg==
X-Gm-Gg: AR+sD11E1EISYdZRa56JD8RpW96Hjl6BybFBZjmydZ/rv3gEMyvMpNG3jyH+3Ti/Lag
 NgtboozKbJSC1tMm5TlZQBKK7kDE9vuGAN4rJVLsVx6UGqMCq6CBjgzDnAbnQ6lu5dGgWbahb4Q
 cLTflBI2KsRRKY4/8I90yH17TDJ7EyFoVHvGsmgMYWy5XOb8eLaI+PRP38wIbIaWzcSYcbsC+CG
 O/XNFrcVnflGxglLmTwZlj9ML2S6ZcMr4LK3wFNCWjiXJ2iGQjWWWO8+ciiR4mlJiAJQ2TVWFUj
 7IpszRvlTpim5u6gcN05jPlxpzDlOfiri8G9IE9nDEGy23l5HEDM74Y66GjpuYfHfpf6mGv5et1
 m4OOnM/zcMlEHgNpfLpOwsKX4UUcd1YpgFLBzc4BY1sZA+IRxqorP/Yv7wUyTBKoOcr+j1P70hV
 sgadP6+PaXH+BVPPqaco1O
X-Received: by 2002:a05:6402:208a:b0:6a0:eb:ae41 with SMTP id
 4fb4d7f45d1cf-6a5df61c0bdmr1213785a12.10.1787683674599; 
 Tue, 25 Aug 2026 11:47:54 -0700 (PDT)
X-Received: by 2002:a05:6402:208a:b0:6a0:eb:ae41 with SMTP id
 4fb4d7f45d1cf-6a5df61c0bdmr1213734a12.10.1787683674191; 
 Tue, 25 Aug 2026 11:47:54 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83a30sm649985a12.15.2026.08.25.11.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 11:47:53 -0700 (PDT)
Message-ID: <73745748-eeb0-4dd8-ba15-6c220037b330@canonical.com>
Date: Tue, 25 Aug 2026 20:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] disk: part_efi: Size the partition entry array from
 the block size
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass
 <sjg@chromium.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 7/31/26 14:40, Alexey Charkov wrote:
> gpt_fill_header() computes last_usable_lba and first_usable_lba from
> hardcoded block counts that silently assumes 512-byte sectors and the

Hello Alexey,

Thank you for fixing this issue.

Nits:

%s/assumes/assume/

> default number of partition entries.
 > > The partition entry array holds GPT_ENTRY_NUMBERS entries of 128 bytes
> each, so the number of blocks it needs depends on both the entry count

The size of the partition table entries is not fixed to 128 bytes. 
Instead it is 128 * 2 ** n with n >= 0. The size is stored in field 
SizeOfPartitionEntry of the partition table header.

You already consider this value in gpt_pte_blocks(). It is just the 
commit message that is misleading.

> and the block size. write_gpt_table() derives that count correctly and
> writes the backup array at last_usable_lba + 1, so whenever the two
> disagree the backup array no longer immediately precedes the backup GPT

It remains unclear which two values might "disagree".

Otherwise the patch looks good to me.

Best regards

Heinrich

> header. Furthermore, on a device with 4096-byte native sectors, such as
> UFS flash, and the default 128 entries, the array is 4 blocks rather than
> 32. Current code reserves 34 blocks at each end of the disk for any block
> size and wastes about 114 KiB at each end.
 > > Add a new helper gpt_pte_blocks() and use it in all four places which
> currently calculate the number of blocks each in its own way, so the
> layout written by gpt_fill_header() and the extent written by
> write_gpt_table() cannot drift apart again. With this, first_usable_lba
> on 4096-byte sectors is 6, last_usable_lba is lba - 6, and the backup
> array occupies lba - 5 .. lba - 2, immediately preceding the backup
> header, as the UEFI specification describes.
> 
> Note that this changes the 512-byte layout too for boards that do not use
> the default entry count. CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is
> "default 56 if ARCH_SUNXI" and is set to 64 by a number of Rockchip
> defconfigs:
> 
>    entries  array blocks  first_usable_lba  last_usable_lba
>         56            14        34 -> 16    lba - 34 -> lba - 16
>         64            16        34 -> 18    lba - 34 -> lba - 18
>        128            32        34 -> 34    lba - 34 -> lba - 34
> 
> Existing partition tables stay readable either way, since is_gpt_valid()
> locates the entry array from the on-disk partition_entry_lba. Only newly
> written tables change. Partitions given without an explicit start= will
> now be placed lower on those boards; on sunxi first_usable_lba lands on
> the 8 KiB SPL offset, so such boards should keep specifying start=
> explicitly.
> 
> While here, report both LBAs when the requested layout does not fit, since
> the existing "Partitions layout exceeds disk size" debug message gives no
> clue as to by how much, making it less helpful in debugging.
> 
> Co-developed-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   disk/part_efi.c | 47 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91a..af311867a285 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -388,10 +388,23 @@ static int set_protective_mbr(struct blk_desc *desc)
>   	return 0;
>   }
>   
> +/**
> + * gpt_pte_blocks() - number of blocks taken up by a partition entry array
> + *
> + * @desc:	block device descriptor
> + * @gpt_h:	GPT header describing the array
> + * Return: number of blocks the array occupies on @desc
> + */
> +static u32 gpt_pte_blocks(struct blk_desc *desc, const gpt_header *gpt_h)
> +{
> +	return DIV_ROUND_UP(le32_to_cpu(gpt_h->num_partition_entries) *
> +			    le32_to_cpu(gpt_h->sizeof_partition_entry),
> +			    desc->blksz);
> +}
> +
>   int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
>   {
> -	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
> -					   * sizeof(gpt_entry)), desc);
> +	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
>   	u32 calc_crc32;
>   
>   	debug("max lba: %x\n", (u32)desc->lba);
> @@ -453,9 +466,7 @@ int gpt_fill_pte(struct blk_desc *desc,
>   	size_t hdr_end = hdr_start + 1;
>   
>   	size_t pte_start = gpt_h->partition_entry_lba;
> -	size_t pte_end = pte_start +
> -		gpt_h->num_partition_entries * gpt_h->sizeof_partition_entry /
> -		desc->blksz;
> +	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
>   
>   	for (i = 0; i < parts; i++) {
>   		/* partition starting lba */
> @@ -482,7 +493,9 @@ int gpt_fill_pte(struct blk_desc *desc,
>   		gpt_e[i].starting_lba = cpu_to_le64(start);
>   
>   		if (offset > (last_usable_lba + 1)) {
> -			log_debug("Partitions layout exceeds disk size\n");
> +			log_debug("Partitions layout exceeds disk size: "
> +				  LBAFU " > " LBAFU "\n",
> +				  offset, last_usable_lba + 1);
>   			return -E2BIG;
>   		}
>   		/* partition ending lba */
> @@ -604,18 +617,29 @@ static uint32_t partition_entries_offset(struct blk_desc *desc)
>   int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
>   		    int parts_count)
>   {
> +	u32 pte_sectors;
> +
>   	gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
>   	gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
>   	gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
> +	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
> +	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
> +
> +	/*
> +	 * Number of blocks occupied by the partition entry array. For the
> +	 * default of 128 entries that is 32 blocks on 512-byte sectors, but
> +	 * only 4 blocks on 4096-byte sectors.
> +	 */
> +	pte_sectors = gpt_pte_blocks(desc, gpt_h);
> +
>   	gpt_h->my_lba = cpu_to_le64(1);
>   	gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
> -	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
> +	/* Reserve space for backup GPT header (1) + backup partition entries */
> +	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - pte_sectors - 2);
>   	gpt_h->partition_entry_lba =
>   		cpu_to_le64(partition_entries_offset(desc));
>   	gpt_h->first_usable_lba =
> -		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + 32);
> -	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
> -	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
> +		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + pte_sectors);
>   	gpt_h->header_crc32 = 0;
>   	gpt_h->partition_entry_array_crc32 = 0;
>   
> @@ -747,8 +771,7 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *desc)
>   static int write_one_gpt_table(struct blk_desc *desc, gpt_header *gpt_h,
>   			       gpt_entry *gpt_e)
>   {
> -	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
> -					   * sizeof(gpt_entry)), desc);
> +	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
>   	lbaint_t start;
>   	int ret = 0;
>   
> 

