Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24565C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5F2060703;
	Tue, 25 Aug 2026 19:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTEU8RE_CsdE; Tue, 25 Aug 2026 19:03:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684609;
	bh=iO4Adgl+cZbj+eYwDsqN2Tc3DdAEpMZzcycpk3qOKDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ks/pcUnL8ODRQx1XBegX1Xolm+kEpdmGSmS6mf/SH2HvCASvWTxOKmcLAFzqAqt8T
	 B6dMqaCCyNMBH6plTkulr9XSpTe0R+nttHvRe8Xt8xgbTpVoQfwHkmAagKQXQBiHFl
	 1hqN7BV0Ps807U90IXqoq6K/697q1JjUCdDLou2LZIViGW2O/b0iJpgsf0hZ00mYtG
	 oH+gzJhN2f8crizCmFAuVVQYN1BoyNGUc0dWEPYvLVm3V2pHA6AYihe8HstJZD3+mb
	 zmaTi1BxJEmNWfEXx9Hs/3hjHdCEYMdbb3ypwPWVy/s2sI09MkMZbcYpot5QYLbHan
	 /nWkJWIfKiGDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24AE3606E1;
	Tue, 25 Aug 2026 19:03:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3CC839E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5BA840085
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ky60OE69NGsJ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:03:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=k2ljrF/p
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 260DB40068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:03:26 +0000 (UTC)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 77A153F8B8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787684603;
 bh=iO4Adgl+cZbj+eYwDsqN2Tc3DdAEpMZzcycpk3qOKDw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=k2ljrF/piX5sOsf8xgxl8TjFITfjHK1vEdRiVjeHuqmh60UH3XluRFe/dGJE/BOD/
 b1+lVfimm+HXf9Mgy54ffjIMzDC85A8V/5Ac91BTgL6zI+xX9QUcT/J1A6MziZ6sCp
 Glz6f/zUrzMGLQSaU0jbYXr5ht5zO5FYBxjpkw6L12rzEvPyLtXglrvb3/VWog/O7M
 R/S1WRzbpx+J05motyh9b+t+SDF4MEUU99sMtsF9sp9iXxmLlUdJH855AgQdHy0K5x
 LvhIj/mEDzBGd6L0/a6PwUd6aK17lydfBrWiXHMRSawz5i2IcjxQxYz2wjKWL871T9
 8wfUEOC59H4JCen8r7UxpZg59hIN2tUt8hXyrJ9VdAwcxpZbMohhjK6piUlumCCAOB
 aII7CPrsxPVqpId3kc9ljhKEDA2WgsT+E1IvtgxADV3MSQr3vaSkowto78Jf2M2Fr4
 W3xksujrQnzC5g7YqR3l8ZXgoTmbQE5pxTwmuYfcEQsKOrQ7xhf1hzOD6J/J8LynoZ
 2zaQcC8JXs4G3Gd/hkdskGNZgfjxx1Qa2Rr+Em+XZSOriPZPVzX4/xTS4BOMAxLmyx
 cVqOu71DgNTuA+QZUUScOxctU9tcJ04k+FLBG7x1IArmbj3wDVkVhOur/PyuQE+Az+
 MBvFn0JMMzDrvoTSqL6FgVPU=
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15cec1ccb6so1367766b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787684603; x=1788289403;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iO4Adgl+cZbj+eYwDsqN2Tc3DdAEpMZzcycpk3qOKDw=;
 b=UNnKnKjqeTMKQHxt3K/uYHW3hSuvo7MbUussnydCeK21kGJF0Cq5AmfBc9F6TS1LdS
 EaJbf1nJwZ2sE8/BVygt0rziu+9RW3ac/4WzODTNSr0wxhxEIOICca2YRHRXK+0f7g6m
 aZxG2Rt5bcQ7dllLYY57o+InKcf0NYEy82vH13hIuaLXhmHSsb9vIMFUnjKB+aY/Jp/j
 w84tXk7M9IsFxMaiKxAQfQmA7gkmCr/Hs3avE03EQQVEpIw/npLUjgabW0VnhDqufSVJ
 4FOMZ5KflCSdoaF7lGuV/2dZdnPxdDNDBQyCNwBcmMwHXpzMsSLPriCbRjP75Pc9OEGv
 7ucg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGDLP5BMHNORFZNTEuXbOnrGQIBxC89KR5K2hT2hOCcpsf68bfm/oVpqJzS9UarVvnDgDDCBU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nP4CaFaL2g8PLceOGIw+geba4bGO49eX1wi9lcB9R/DegsdDZ1
 2YVszMPAw5fKRfid6n8XkfToDNcrTn2cEmVaebG+yvCOu50bdDyVm2dXpEed7bN+a3jXmqWqkTW
 H1LZMpcoy9SvtgEqT3bfB8iRAQ8VS8Yq2Z81S1hdXsldOHBYrdGcBY4P+HsKFWbBhjDQ1lU52Sv
 BVdyHJgbevtA==
X-Gm-Gg: AR+sD13IPkiSyffeM/U+JWIxxrWtLi1ua+xxZ58Xvo/aHrP7EUENx/q3F8U7xVdZHMU
 InBUZ3x/2K+OZlbU4QKVzZQ8G4bD7vwbF7tb6Od86B7JRQBPFqgGVoaB6paEFJ8A1hlM1GBKgGN
 xk/cbZsPGX0o4Z0OIUvLGOq/4FETxQHzBtveTPhuLfrxCVmXZJHUSalENZ72PoYmuF7349DjVlH
 7Lb2O0OvTp7l4NjiV3fNcLjiIMjsZuaey6e9COdgYy0BrIL7uarvaSDjzlxx13K/le8gmkIkVoS
 095VRQspP8xk6xKaAwlvEgw8aMPRRHp8F09lP7OicNVvpTGIhdWB4escmvzA5TyfT2vBsSwGO5/
 naQr0zO/w5V1DYwhMFwKgjPkpDa7B4NBbOuoo6N+uZqkAKHO+AEZBAIARn3NS+b6KFyrtlWgmd9
 7Qt8+q8EDBPRn4lcbe+owb
X-Received: by 2002:a17:907:e915:b0:c21:6f8c:2335 with SMTP id
 a640c23a62f3a-c250c391e16mr83719466b.16.1787684602335; 
 Tue, 25 Aug 2026 12:03:22 -0700 (PDT)
X-Received: by 2002:a17:907:e915:b0:c21:6f8c:2335 with SMTP id
 a640c23a62f3a-c250c391e16mr83711666b.16.1787684601886; 
 Tue, 25 Aug 2026 12:03:21 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b10cesm89250866b.48.2026.08.25.12.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 12:03:21 -0700 (PDT)
Message-ID: <e71a191a-1388-461d-bc87-9131e1a4879f@canonical.com>
Date: Tue, 25 Aug 2026 21:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
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
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
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
> Several GPT header fields are read without converting from
> little-endian, which is wrong on big-endian hosts.
> 
> gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> the region a partition must not overlap, so on a big-endian host both
> bounds are byte-swapped garbage and the overlap check does not do
> anything useful.
> 
> gpt_verify_partitions() compares the loop counter against
> num_partition_entries raw, so its "More partitions than allowed!" guard
> never triggers.
> 
> It also swaps gpt_part_size, which is already in host order, having been
> computed from two le64_to_cpu() results a few lines above. Drop the
> conversion rather than adding one.
> 
> All of this is a no-op on little-endian targets.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

This change is not covered by the test in patch 6/6 as it runs only on 
the sandbox.

Please, ensure that the GPT tests are also executed on a big-endian 
systems, e.g malta64_defconfig which run in the CI via QEMU.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   disk/part_efi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index af311867a285..062389c3af0c 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -462,10 +462,10 @@ int gpt_fill_pte(struct blk_desc *desc,
>   	char *str_type_guid;
>   	unsigned char *bin_type_guid;
>   #endif
> -	size_t hdr_start = gpt_h->my_lba;
> +	size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
>   	size_t hdr_end = hdr_start + 1;
>   
> -	size_t pte_start = gpt_h->partition_entry_lba;
> +	size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
>   	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
>   
>   	for (i = 0; i < parts; i++) {
> @@ -851,7 +851,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
>   	gpt_e = *gpt_pte;
>   
>   	for (i = 0; i < parts; i++) {
> -		if (i == gpt_head->num_partition_entries) {
> +		if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
>   			pr_err("More partitions than allowed!\n");
>   			return -1;
>   		}
> @@ -877,7 +877,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
>   		      (unsigned long long)gpt_part_size,
>   		      (unsigned long long)partitions[i].size);
>   
> -		if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
> +		if (gpt_part_size != partitions[i].size) {
>   			/* We do not check the extend partition size */
>   			if ((i == parts - 1) && (partitions[i].size == 0))
>   				continue;
> 

