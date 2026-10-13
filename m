Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A019CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D016C60643;
	Tue, 13 Oct 2026 12:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfBdkLfIuCnL; Tue, 13 Oct 2026 12:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3D51605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791895648;
	b=YSilmNCW6BAxfQQuNgiHp3rhObEF3HxR++x3wzNZ3q14j2gD2zuABiFZ7E84Ctg60WJW
	 zP2wD4N82BPdtcFh4kaHZ9OeuUjQ9BhfQmmHCOmyWjq29HQwJh1g4JGScBH4f4gg5/PIn
	 dmt/P7jHBUMxgMfySpsVkqFgdRWEQ81gduNB/tzRaGM2tH0OcqXMOUUlQ/bifnFpcuu/j
	 raYm7y9zwhoy1iCZb5YPBTVAvu30a6dLR3qkVWS4JF1o6fOp+sBEIhdPk7fdWTjnUKe27
	 9qmw3fXmBtfyo441hKwCKdeEBDFN/yNGEk7z7wj33if81wFfGWLdbUcBqywoNHgV3aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791895648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KubDKtxgW/t34Q1OaVkkiHNnws9tQx7ZmqUy6LKgk1w=;
	b=J4hwzAYVkYnz+o+iT8iO2JpkytXf9r4OsGIJQelXCKXTk3rQgzyhROvfAFlF7tGwdMkb
	 v8OQH9LIGW4Q8Ywu/Edq5jNF2nN8clKTVHs75Rq0+K7xGNB3MvJAA0kxs4RQW0v9I1ErX
	 Rya7ABURLTEh88fgLQA8UgvNTG4NsmbehF7oS4Ma24tbgVrcO5GclHhS+4m7R3aE6PVmo
	 QFWhoLeN8Li3w3nCEaHs0LXD9hZ1UBWpP0gG/Do/ljgipI2Zg/ivM0Zu0bOJ82Xlu6sYb
	 dfr5z0BWzYD8nVMuG5Z3EfGWKJWTh7KQ+iULKl7Z8y+PQmvu/LDYYBE5Elxm0Tx+MdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791895648;
	bh=KubDKtxgW/t34Q1OaVkkiHNnws9tQx7ZmqUy6LKgk1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gkFWJ2bkbuaE4FnEzhuA7dPf8X8y/EZ4rFs9l/IbT31i4rCL5q8dx7KPic6WPzl+A
	 mxCkVwxyQX2lM0sN6TS5eVMls8a3Br5yqfA4aNO8ooAVDAACTGjB5H5ypWjJ9UXfc/
	 Uv5yE7F5WmwChBrdZmXqJtwQ8s4zMzQCVZmqi8tvSHRmHQPIDyvS4MI4SlOQxXbwcX
	 Bz/LeYhNCDX9oQUgFzQhQEpxeopQt9luc5odhIJx9GQmyCaeAxYVFWi0LdWzpr/ygN
	 8asSBtUyze6WmMZeFUlacEXu6fdksk5nJSzF8GusqmMB85RrCsalpddolDlBBptUeS
	 QsvbwB/xZ951Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3D51605F4;
	Tue, 13 Oct 2026 12:47:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22BD175
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 146FA4007C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2__xkngHmNU for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB6F140070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791895646;
 b=h//1jg7CEeH1w9jNWozIFGe5DicQ25U7txp0U0+F/ysCokUItcG2sXvr4bBYi5JuQmt5
 xgVgJonTr4Uph5vqlXlmXvhruP8/GpKjHZPr7Fuqnx7Sy7XObTnVhNgsoxLfXAdu8cikL
 mbTOCxUHPy6nKlgIj2+xJte+u9bPFwXoIVV7vveCPR/W6BXhQps1AKTpDm455yGObybxl
 79izyMKz0FQpenHAoXav0Qij3C98wOcTANuCdG+cdgwX4tQ7vIuKfXt+utcFlcYOfwEZn
 GnE/2bYlFT14JpwlNDHUsSAHWhyJEDUu6yf7dsdQ0sLnf/Ew0TXQIXACI6KzpC6mYaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791895646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=KubDKtxgW/t34Q1OaVkkiHNnws9tQx7ZmqUy6LKgk1w=;
 b=SEFAqjNKA6gi05MEh0tPTPOCrmO4bVcwpPZF02+7kKV/swXR0vWttxWBJsU6JffBf2GC
 4Ubjn4N34BLIrphuTOfTUBtgulNBxoq5X4Ap9KzJkXOF3IDBq75pImrYv9Y8McezpICg4
 OxiNd/Qj7txHWmTXryI6x4PF0WsWSnQWnHx6Hl4MOeI3btYXOZI010Y6IGJlcsnufKPcF
 opQBX0L2m5z86z1fUkPgwGgqh31n7Ce0s6BsoaILM0WRE0omrIOW6QkOkGlMKHfS74Nn9
 bwNskdTcE9Fj3F+t2c/raYwWJ3T1Fxs6lgcS1A4Q7W/CoABOddzrpCZzPHd0jfPjSfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="mCyf6v/7"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mCyf6v/7
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB6F140070
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:47:25 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1633971f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791895643; x=1792500443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KubDKtxgW/t34Q1OaVkkiHNnws9tQx7ZmqUy6LKgk1w=;
 b=mCyf6v/7e6nnEk0lhW3VECqyT6gxC3GOXkLrrGs4/B2uhAIH/2XDqZUDYXcb9R5r/p
 ozgHon1zt7l+LOhBq8glq8ioO+x95r/cky1Y1VU0PQM5585NeVeJ1APth9JSj414NwTg
 U97i/woLia33wwGztZ1PSBfdkxk819bbd79BFAlXdPBakK50dBY2/qgyYQE0b7+nqSab
 gR5V/nqxASBUy6lSBKSecRsQzPnvbuLkDtbIOq2fmspHPDEGgg5t5nnZZFD6bsY8Go+W
 8n9JJoltbOp2mRnqsjRVZxATxlU+XL2I5Sc3D2d1LObqdK8gzkryVuKUzGMO9xXGo1WY
 sUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895643; x=1792500443;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KubDKtxgW/t34Q1OaVkkiHNnws9tQx7ZmqUy6LKgk1w=;
 b=c6QQXmlhXIgKTqJbLJ+WRTSlU50UTtiadHAdKdxOGqSTv8VI5cdwNAbCZ7BjO/x2OY
 xKiUxKoA+rYFP/S4yoly6pYjZsh7zjBaj1ytiXfdGraCGnh/peqhMvzQJ9nnZNSBlZGd
 OkKFO5KsNA4rQDG8IHjESEKcyePr4YMAQajAAjSIX7LpSgPyuGOCrE5f6B6VnFI7U0H/
 0dEd8kW4lBm2KWGL5VeXyt+QFTjHSFytwFh2sIp0h8nh2fsSbd85J0oz9wBzQ+ZxOM7f
 O17mHtUJaAJRoNuVqex1RLLOhUbwddUrVzzedlj5TxhWsnWKa8LAPYg3noyXD4DCFzBz
 F39A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxUpmGKkM/IHEqzak+xTgiPkUNRgmzIYGwKpQY2531i2FTNnI9pq4OggF1mmvGrRhYjrChEqw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIKokHJgGGPPc60zBjcnwUqI/j0P3tRYPjq6JZLXJ0hgEtIXL07
 u5aduQgfCMUFXzqO4n5Um4B/XBC3OeNQv3LppzwuAfPYEu0F1kir6o06TdvkiVp1vSo=
X-Gm-Gg: AYBFou2x9oufp8ksokqwWazEI77/5sLCIRyKVJCykEV2hZVrYwtfDSE50qarfCCafIC
 N8mFy80ClnlMRlmGnr8vKlOUZy3XjqUTz+2kXbckoxnfnQu/Kz0GsVR8/mJXivbhNeGzztWhnYi
 Ky1tIOvkKOp1qixYpgHWaHT3WZ7qzXVSIMnpo/gjDsuqE4lvbxNIjKPpFgxoUancrfPNVX7FF7R
 9ifMR+1IblAknsRjwi4KrNqEu2PtsiNfsZilluxOrRQBqY3AQ2Nnlcg4E+L5PDMEXhM7xlDdOP7
 BcyWYjCTPoLaU5KLCuBE8AYRDWXYPgG1lCwrDXAHU9W/XGNjKMf1nHmp2TnE74yk7lz4e8mqNrz
 fZJaWmYC6SFOesXeb3Rm85MtVW61uCP99kZrqVALxHq9eCXGvDualk4JManph/PmgWSNAQAetSQ
 aJD/GM1rLw4m1aX0yMzBRFCOXUEewB26uBrIi44LORK5Wfc0pejPkVSVgY84URbnX4lrnXP8apF
 /beBOBMqeaKyAhXvzXU2DL28XWgpYHCBLVQqzNgDmkuciwE/FROhwjBKbdrb3k=
X-Received: by 2002:a05:6000:4814:b0:48d:db43:4ba7 with SMTP id
 ffacd0b85a97d-48ddb434e4amr9045464f8f.9.1791895642900; 
 Tue, 13 Oct 2026 05:47:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc91e2sm4790752f8f.55.2026.10.13.05.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 05:47:22 -0700 (PDT)
Message-ID: <d99d0593-d0b1-4537-a848-0b3dd0a174b4@baylibre.com>
Date: Tue, 13 Oct 2026 14:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] avb: Drop the mmc naming from the block IO helpers
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-2-jan.kehren@emteria.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261006092732.3577974-2-jan.kehren@emteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

thanks for your patch

Le 06/10/2026 à 11:27, Jan Kehren a écrit :
> The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
> nothing in them is mmc-specific. The names say otherwise, which makes the
> mmc assumption in AVB look wider than it is.
>
> Rename them after what they do, in the AVB namespace rather than the block
> layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
> struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
> The block descriptor field loses its mmc_ prefix for the same reason.
>
> No functional change.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
> ---
> Changes in v2:
> - New patch: split out of "avb: Take a storage interface in the AVB
>    operations" so the rename lands on its own, with no functional change
> - Keep the _and_flush suffix on avb_blk_read_and_flush(), it still flushes
>    the cache after reading
> - Re-align continuation lines that the longer helper names had broken
>
>   common/avb_verify.c  | 106 +++++++++++++++++++++----------------------
>   include/avb_verify.h |  12 ++---
>   2 files changed, 59 insertions(+), 59 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index b96cd1ebd7..fc29433c3c 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -304,13 +304,13 @@ char *avb_set_enforce_verity(const char *cmdline)
>   
>   /**
>    * ============================================================================
> - * IO(mmc) auxiliary functions
> + * Block IO auxiliary functions
>    * ============================================================================
>    */
> -static unsigned long mmc_read_and_flush(struct mmc_part *part,
> -					lbaint_t start,
> -					lbaint_t sectors,
> -					void *buffer)
> +static unsigned long avb_blk_read_and_flush(struct avb_blk_part *part,
> +					    lbaint_t start,
> +					    lbaint_t sectors,
> +					    void *buffer)
>   {
>   	unsigned long blks;
>   	void *tmp_buf;
> @@ -342,7 +342,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
>   		tmp_buf = buffer;
>   	}
>   
> -	blks = blk_dread(part->mmc_blk,
> +	blks = blk_dread(part->blk,
>   			 start, sectors, tmp_buf);
>   	/* flush cache after read */
>   	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
> @@ -353,8 +353,8 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
>   	return blks;
>   }
>   
> -static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
> -			       lbaint_t sectors, void *buffer)
> +static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
> +				   lbaint_t sectors, void *buffer)
>   {
>   	void *tmp_buf;
>   	size_t buf_size;
> @@ -382,19 +382,19 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
>   		tmp_buf = buffer;
>   	}
>   
> -	return blk_dwrite(part->mmc_blk,
> +	return blk_dwrite(part->blk,
>   			  start, sectors, tmp_buf);
>   }
>   
> -static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
> +static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
>   {
>   	int ret;
>   	u8 dev_num;
>   	int part_num = 0;
> -	struct mmc_part *part;
> -	struct blk_desc *mmc_blk;
> +	struct avb_blk_part *part;
> +	struct blk_desc *blk;
>   
> -	part = malloc(sizeof(struct mmc_part));
> +	part = malloc(sizeof(struct avb_blk_part));
>   	if (!part)
>   		return NULL;
>   
> @@ -421,20 +421,20 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
>   		}
>   	}
>   
> -	mmc_blk = mmc_get_blk_desc(part->mmc);
> -	if (!mmc_blk) {
> +	blk = mmc_get_blk_desc(part->mmc);
> +	if (!blk) {
>   		printf("%s: failed to obtain block descriptor\n", __func__);
>   		goto err;
>   	}
>   
> -	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
> +	ret = part_get_info_by_name(blk, partition, &part->info);
>   	if (ret < 0) {
>   		printf("%s: can't find partition '%s'\n", __func__, partition);
>   		goto err;
>   	}
>   
>   	part->dev_num = dev_num;
> -	part->mmc_blk = mmc_blk;
> +	part->blk = blk;
>   
>   	return part;
>   err:
> @@ -442,22 +442,22 @@ err:
>   	return NULL;
>   }
>   
> -static AvbIOResult mmc_byte_io(AvbOps *ops,
> -			       const char *partition,
> -			       s64 offset,
> -			       size_t num_bytes,
> -			       void *buffer,
> -			       size_t *out_num_read,
> -			       enum mmc_io_type io_type)
> +static AvbIOResult avb_blk_byte_io(AvbOps *ops,
> +				   const char *partition,
> +				   s64 offset,
> +				   size_t num_bytes,
> +				   void *buffer,
> +				   size_t *out_num_read,
> +				   enum avb_io_type io_type)
>   {
>   	ulong ret;
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>   	u64 start_offset, start_sector, sectors, residue;
>   	u8 *tmp_buf;
>   	size_t io_cnt = 0;
>   	AvbIOResult io_ret = AVB_IO_RESULT_OK;
>   
> -	if (!partition || !buffer || io_type > IO_WRITE)
> +	if (!partition || !buffer || io_type > AVB_IO_WRITE)
>   		return AVB_IO_RESULT_ERROR_IO;
>   
>   	part = get_partition(ops, partition);
> @@ -486,11 +486,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>   				residue = num_bytes;
>   			}
>   
> -			if (io_type == IO_READ) {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 1, tmp_buf);
> +			if (io_type == AVB_IO_READ) {
> +				ret = avb_blk_read_and_flush(part,
> +							     part->info.start +
> +							     start_sector,
> +							     1, tmp_buf);
>   
>   				if (ret != 1) {
>   					printf("%s: read error (%ld, %lld)\n",
> @@ -505,10 +505,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>   				tmp_buf += (start_offset % part->info.blksz);
>   				memcpy(buffer, (void *)tmp_buf, residue);
>   			} else {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 1, tmp_buf);
> +				ret = avb_blk_read_and_flush(part,
> +							     part->info.start +
> +							     start_sector,
> +							     1, tmp_buf);
>   
>   				if (ret != 1) {
>   					printf("%s: read error (%ld, %lld)\n",
> @@ -520,8 +520,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>   					start_offset % part->info.blksz,
>   					buffer, residue);
>   
> -				ret = mmc_write(part, part->info.start +
> -						start_sector, 1, tmp_buf);
> +				ret = avb_blk_write(part, part->info.start +
> +						    start_sector, 1, tmp_buf);
>   				if (ret != 1) {
>   					printf("%s: write error (%ld, %lld)\n",
>   					       __func__, ret, start_sector);
> @@ -538,16 +538,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>   		}
>   
>   		if (sectors) {
> -			if (io_type == IO_READ) {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 sectors, buffer);
> +			if (io_type == AVB_IO_READ) {
> +				ret = avb_blk_read_and_flush(part,
> +							     part->info.start +
> +							     start_sector,
> +							     sectors, buffer);
>   			} else {
> -				ret = mmc_write(part,
> -						part->info.start +
> -						start_sector,
> -						sectors, buffer);
> +				ret = avb_blk_write(part,
> +						    part->info.start +
> +						    start_sector,
> +						    sectors, buffer);
>   			}
>   
>   			if (!ret) {
> @@ -564,7 +564,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>   	}
>   
>   	/* Set counter for read operation */
> -	if (io_type == IO_READ && out_num_read)
> +	if (io_type == AVB_IO_READ && out_num_read)
>   		*out_num_read = io_cnt;
>   
>   out:
> @@ -603,8 +603,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
>   				       void *buffer,
>   				       size_t *out_num_read)
>   {
> -	return mmc_byte_io(ops, partition_name, offset_from_partition,
> -			   num_bytes, buffer, out_num_read, IO_READ);
> +	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
> +			       num_bytes, buffer, out_num_read, AVB_IO_READ);
>   }
>   
>   /**
> @@ -630,8 +630,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
>   				      size_t num_bytes,
>   				      const void *buffer)
>   {
> -	return mmc_byte_io(ops, partition_name, offset_from_partition,
> -			   num_bytes, (void *)buffer, NULL, IO_WRITE);
> +	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
> +			       num_bytes, (void *)buffer, NULL, AVB_IO_WRITE);
>   }
>   
>   /**
> @@ -883,7 +883,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
>   						 char *guid_buf,
>   						 size_t guid_buf_size)
>   {
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>   	size_t uuid_size;
>   
>   	part = get_partition(ops, partition);
> @@ -920,7 +920,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
>   					 const char *partition,
>   					 u64 *out_size_num_bytes)
>   {
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>   
>   	if (!out_size_num_bytes)
>   		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 66655aab87..8c97adbfbf 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -32,16 +32,16 @@ struct AvbOpsData {
>   #endif
>   };
>   
> -struct mmc_part {
> +struct avb_blk_part {
>   	int dev_num;
>   	struct mmc *mmc;
> -	struct blk_desc *mmc_blk;
> +	struct blk_desc *blk;
>   	struct disk_partition info;
>   };
>   
> -enum mmc_io_type {
> -	IO_READ,
> -	IO_WRITE
> +enum avb_io_type {
> +	AVB_IO_READ,
> +	AVB_IO_WRITE
>   };
>   
>   AvbOps *avb_ops_alloc(int boot_device);
> @@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res);
>    * I/O helper inline functions
>    * ============================================================================
>    */
> -static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset)
> +static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t offset)
>   {
>   	u64 part_size = part->info.size * part->info.blksz;
>   

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

Regards
Guillaume

