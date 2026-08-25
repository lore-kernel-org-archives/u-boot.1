Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2675CC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A2C8403FB;
	Tue, 25 Aug 2026 19:37:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SOwWJWU6SLQ; Tue, 25 Aug 2026 19:37:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787686676;
	bh=zcIG7IpfNIuY/AFfafKmuFsDvF73O6k3Fow4q+ZaflU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z6YrkM6wjk8NninO0TNbqG2ZHw5aPL9LQaTvN/PmnSV/PXdydximG0iVLT1dTHGEO
	 DFHMp8LYeI+uMxMHdEZ5OHLxutiLuZJcwGNmpdMvM1Xg9hGJhssq6b+5EVl3h9q8z+
	 2eIVoJdWROZf7YQfXhZ7xKFBK/FxWa/gUZam1qIoneW99Y0zQUETMod0l6hbZD5m1V
	 xLMEXBht+X39wvvo3wvMtM+QymcByw3v9HgwDqkVv2jSe/GJHd3EGKJFc8AIC/wFtT
	 oANijxVCEQ+f04lZSIuTgV/Wew99UHnEI2GVoQa4ZkHmbMhiiIlTCw2NcOdNVRMPHF
	 4amoQ6DaKTQwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77F85403DE;
	Tue, 25 Aug 2026 19:37:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D742FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 747C040199
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAxF-SxEL-kZ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:37:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=c8HvGKEj
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEA5B400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:37:48 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 295053FC3B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787686667;
 bh=zcIG7IpfNIuY/AFfafKmuFsDvF73O6k3Fow4q+ZaflU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=c8HvGKEj6vuCgNp46Mq7Iih8v9BkgU837D/m/AvoR2RaJ3ClpZKQP3nJzMs6caCCj
 ugufJQBpi9O2vbc5eWjfGsjEiI/GT2Sep5AfzCIUNLnLKmborVBcbHwY/kjHuUHtMf
 g8gvi6Lb5grcvtsW7wmyM1uCxVTMrfuZB/OqnmQREBcHnYtcO+eTZRWzfwuZHmHyED
 U8bMkqMhBCwoKk38Lhau481StmgBW464G7MWVNEBtJnfMZ0Irh76iNENySENXj1TRp
 4y7s+rnZ7jNtUeYh1E+hcNROYSfZ6jWu4tOOQW+Fnuc9Zf/u//CcX5V1m+gGOby+B0
 zGsyvrEtCbGb7V+CcKXdYJ/7/XXPKrbTs+N9XoWRPAvWRPzYgAAcmXpG7xKD4znoUW
 7cfP8/NFS2XNLbIrWEM7kyYLyGGvKc7+jWsjhQUQOmkiRDfdWUi8Y1n2LxOHxoR3I7
 crm9bxvmdcN5w9HWyQ39nw8tEO2+FEAp9FgM2NFGqKKEozLv2zrIA75cd/MXd7mjNz
 YCsRkM1yoJUCYlQ1I+wnR5LKFcE359Hhz4NqxwWoH/wp4eaPhEQOJTsXuqYD0lw9tU
 oaYQ7H9l4gd+ZiJO7mwKl64NwVDsw1Jl2azk7NBgAnZN+CehcZAO6P76O2T4W6k2wg
 Yok5HPEqytyJV1i5CNHYjCB8=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so152071a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787686666; x=1788291466;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcIG7IpfNIuY/AFfafKmuFsDvF73O6k3Fow4q+ZaflU=;
 b=cwKOegU1auDVhH8QurTDfd0593mTCLfNXpBBvJNJ63ZFKhsk8bWwlhjCuTMimiiP/J
 QdLTt4exoxVKVYXLy7Ob3ZpCJXdX9GZ8InOYnDFiLGXHg+mzngpS6egr2QjNJgAUWr/y
 3vM7mX7smFQC1QjcDQFjdjcV83+QWtpnrcLWW8mKFYiFCYYtjtU3L+fxtRD3KZciHPr9
 iGIxCYLau70CUMGy9/UwjBBA7qAIBH6vzPp4ZXgm5K/bwufbyOPXoiY2Fp8peMxwr/mz
 Vw92spRkVJPOdYxMvzbQldpjFLMCPfaxmjDfzn7FxKRJv+4Cpzclizox466u6VO14gbJ
 QQBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoVXUnDQRQ0sJhj6looajkTBkixOEi/PVp62hKEWarOztmzG3jLvSsXqcqr29bJnnxpZS5IYM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m7eDfGzMcarFoj9CTwhPbsRjg7haTuyepYx1N5IakhAVh9zQu0
 /y5Qm//THAGptA2c6R0eQtWfO5lvbqwQGC3BnYw8kZciSKtDQAflDF/fuzvE9r0QuXghBSShGuO
 gzGbQF3cPPR17nUb9LFQ9AxMa766CB97Mzv8JdeFWpZupY/5csLQInxd0sV2PUDLcN5fG3PMMH+
 fl+k9tFz506A==
X-Gm-Gg: AR+sD13bb9L+NQcek3IdcyosuFbz/HErbFqGnnD2sHKmuThZDLhqxbPejXA+b4d158j
 wrlB5ziZ1wpkGBa04O6KvayFYB8ieflk5z33he5kRSErgPSwlDv06bQnPA48b9plR/BZcXy5iW3
 yVUOTAVaVl3YeMPItvETPvDi7fvTEds4vai+4YCVSGyp/4zHrbcZwb6DuMkhXjYGauuqYNK/hFN
 V2I9kSC6XvgDvFb8UJ0e5WGLO9V2U4C158E5HghWhNMdXhIdK51Q6Nc6JWVry+V9MH3sYJy+lWp
 cGn8Fw7OTFE3w6w2Azbr0ooFxiZLcIm/GMgY+xQBnuaGH3H3QO96vhI2tzdxVsS7AnzRxKT9TDw
 IkVlSYdM408mibuji01Gq/Gm6yHgGnuDxNUbLQj8W2+HWIuDdfM7821WPAeB3O+PPIeI3b9mejY
 Avh8906kdjxoYr7hvHorid
X-Received: by 2002:a05:6402:3908:b0:6a3:849b:aa48 with SMTP id
 4fb4d7f45d1cf-6a5df6344e1mr1871783a12.7.1787686666659; 
 Tue, 25 Aug 2026 12:37:46 -0700 (PDT)
X-Received: by 2002:a05:6402:3908:b0:6a3:849b:aa48 with SMTP id
 4fb4d7f45d1cf-6a5df6344e1mr1871693a12.7.1787686666317; 
 Tue, 25 Aug 2026 12:37:46 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83a30sm775799a12.15.2026.08.25.12.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 12:37:45 -0700 (PDT)
Message-ID: <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
Date: Tue, 25 Aug 2026 21:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
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
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
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
> part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
> single-block buffer sized after the descriptor struct:
> 
> 	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> 	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> 
> Both structs are 512 bytes, but every blk_dread() below them asks for one
> block, which transfers desc->blksz bytes. On a device with 4096-byte
> logical blocks that writes 4096 bytes into a 512-byte on-stack buffer and
> corrupts the stack.
> 
> part_test_mac() runs on every block device during partition probing, so on
> sandbox with CONFIG_MAC_PARTITION=y this crashes on any access at all to a
> device with large blocks, for instance:
> 
> 	host bind 0 disk.img 4096
> 	part list host 0
> 
> Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD(),
> which is what part_efi.c already does for its own block buffers.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Modern Apple Computers use GPT partition tables.

Gemini claims:

Because APM was functionally obsolete by the time Advanced Format (4Kn) 
drives emerged in the 2010s, Apple never updated the specification to 
establish official compatibility guidelines for native 4 KiB sectors.

If Apple has not defined how to treat 4 KiB sectors, we should not try 
to invent a scheme.

Apple has already deleted the documentation of this outdated partition 
table format 
(http://developer.apple.com/techpubs/mac/Devices/Devices-126.html)

My preference would be to remove this driver completely.

Best regards

Heinrich

> ---
>   disk/part_mac.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/disk/part_mac.c b/disk/part_mac.c
> index dd3ce0be832b..f0afab65d755 100644
> --- a/disk/part_mac.c
> +++ b/disk/part_mac.c
> @@ -37,8 +37,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
>    */
>   static int part_test_mac(struct blk_desc *desc)
>   {
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>   	ulong i, n;
>   
>   	if (part_mac_read_ddb(desc, ddesc)) {
> @@ -64,8 +64,8 @@ static int part_test_mac(struct blk_desc *desc)
>   static void part_print_mac(struct blk_desc *desc)
>   {
>   	ulong i, n;
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>   	ldiv_t mb, gb;
>   
>   	if (part_mac_read_ddb(desc, ddesc)) {
> @@ -208,8 +208,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
>   static int part_get_info_mac(struct blk_desc *desc, int part,
>   			     struct disk_partition *info)
>   {
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>   
>   	if (part_mac_read_ddb(desc, ddesc))
>   		return -1;
> 

