Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AA606A337
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tjIuv3Kh;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=kgjzGHrp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A9940966;
	Tue, 17 Nov 2026 16:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgtdohVsTV_u; Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6874140917
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794933363;
	b=oCAAVxd5wISw03ncGDkHLFs70AoN5VzfbH3hMBz5cu1zGLCxmA3SoQAeSjNHUGoHDy+a
	 ECgp6k6JQuWBVpx9WE/vwyJCX8to0mB3kw/GqYZsiJQORMeSHbFBxvH6DUy//j/OWW4mY
	 lX6Cy0g0L7zXRpgIX8YLFY3Kpd8WFb1/4cw+tbTmaS3+T2xwxJhu4jI2t6Adh5t5XqTa0
	 pGfGvc9lEL1iXmEsDf5VV7u3wbFeRvtZeyZ8D+crMC7K1xxyoXkjSPjSSw5Kc38I71l3Y
	 9PGaOiJjUAPekvw9/lby6UWy6bJInIxnTugowTMT4y2l69E1edWIe0zxbCQJlrB18aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794933363;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8G636PABG8MMlAW89kuM0haDE5BmJiIjvwbQhSz5JuM=;
	b=NAfnuKxKqJWTEzwKW4+79x3SgXaXTK/H0QbBPc8aw9EilLamqY6GKksmxJpUKXWYxI9f
	 46VoFFncoTi2//LL2Hmk9HRYxHVgYFseYn7Scpx/9e2a2b4uVmPCTgnv/Y4wZjoNPcU9s
	 SdZqRuEDhnl+7eKdfkFuRjkGLnbaVfQsdHFqi387VlkmU2UcjA/Fw8fAmtJ8E0gkzmxPx
	 AVWMrraHNz7KzVAV45z0DbKgIPpSZ5B0qPcQMpduUJtJKkKR27u3Bv4mSXqwB3m1rgqn4
	 lWn3CbBpGbqMviKLp/RKkqFw2BP/uGrRGNQblUVPtl6vUDy1HQ+JKeEvbbAmDe30svA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=kgjzGHrp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794933363;
	bh=8G636PABG8MMlAW89kuM0haDE5BmJiIjvwbQhSz5JuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjIuv3Khph2wJrCsFjrEkhtk6uu7J1wZhEhHycf+uk60CokTzHGzBQ+Tka0gZWqj/
	 mintUWdE+TjO/wcMegc7AJyrMcgbRaMs4mtFkQ+X3lk8t8/EEo7nI9DhCEbv7WJWkd
	 RoQC3lCvypD9ZIv8JOMLM7LCjHYrl90NV7S+aKCURlbgzTGjnlL4/yCgrN3jb8nUDm
	 cydCudu/xjKBm63w5OsFDu5JW3y0QAKAk8EZfZ1x7D3TwlsaRyK/bxFTwU+jC4wgrZ
	 eWu8S99TzAeSzgYNohUZP4YdED2YTkcIe93MR0moIwDbiBYnevIVfPOA/dBoLaexh0
	 maQnREYNpsoRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6874140917;
	Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 360A71A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3355940917
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABUa13fwpe8b for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C10D64084A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=kgjzGHrp
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C10D64084A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:35:58 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTVj76gbVzPbZ
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794933355;
 bh=8G636PABG8MMlAW89kuM0haDE5BmJiIjvwbQhSz5JuM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kgjzGHrpuEvxtKSh4m9tOeNg/CTKxUau5g2N9xDKK6VKYHI0PQibi57y0walnSNxB
 9ac9UNNF/pkuSTPgKbFgBzCTMVAdI88OQw/uhpXKKHA8abel+XhQX17koVgJXBuYjW
 Ufl1fbac7pyBVXjp2bpiZjjs7N39Gu0/xtcvgEMboLF8XOeYT2koMN1GdDiBB4Xqtn
 wUmNS4I7gOOb0VSJthI36omEDuPwKSzTL+rRh4xzV2iBmJsU6mQO8OtaNRhXjAKqPz
 lmUMLgROvVRTgLT3V9T0INPakfKZVPtQ8Oof9LEuDzp1IXc5QFXoXOc0PCmEUleiSs
 +vvUHJH1vfYKg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTVj66R8jzkbJ; Tue, 17 Nov 2026 17:35:54 +0100 (CET)
Message-ID: <ccb6d9bd-284f-4cb6-9348-246e4477b0c6@0leil.net>
Date: Tue, 17 Nov 2026 17:35:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ram: rockchip: add DDR3 sdram type config option
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-2-fe9fb30a3169@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261116-ddr-multi-v3-2-fe9fb30a3169@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> Add new RAM_ROCKCHIP_DDR3 sdram type configuration option and drop the
> PX30 and RV1126 sdram drivers' fallback behaviour, which consists of
> using DDR3 sdram parameters when no RAM_ROCKCHIP_XXX config option is
> selected. Instead, the drivers code now raises a compile-time error if
> none is selected. The default value of RAM_ROCKCHIP_DDR3 is true if all
> other RAM_ROCKCHIP_XXX options are false: this preserves the overall
> default behaviour avoiding impacts on defconfigs.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig        | 8 ++++++++
>   drivers/ram/rockchip/sdram_px30.c   | 4 +++-
>   drivers/ram/rockchip/sdram_rv1126.c | 4 +++-
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index 74422947452..f51ae6a4542 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,6 +24,14 @@ config RAM_ROCKCHIP_DEBUG
>   	  This is an option for developers to understand the ram drivers
>   	  initialization, configurations and etc.
>   
> +config RAM_ROCKCHIP_DDR3
> +	bool "DDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126

Same remark/question/thought as the previous patch wrt currently 
unlisted SoCs:

thought: add ROCKCHIP_RK3036 || ROCKCHIP_RK3368 || ROCKCHIP_RK3066 || 
ROCKCHIP_RK3188 || ROCKCHIP_RK322X || ROCKCHIP_RK3288 || ROCKCHIP_RK3328 
|| ROCKCHIP_RK3399?

> +	default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
> +		!RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
> +	help
> +	  Enable DDR3 sdram support on Rockchip SoCs.
> +
>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
>   	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index 37e62120504..bdb9cc9031d 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -130,8 +130,10 @@ struct px30_sdram_params sdram_configs[] = {
>   #include	"sdram-px30-lpddr2-detect-333.inc"
>   #elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
>   #include	"sdram-px30-lpddr3-detect-333.inc"
> -#else
> +#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
>   #include	"sdram-px30-ddr3-detect-333.inc"
> +#else
> +#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"

issue: misleading Kconfig symbol

We already have a CONFIG_RAM_ROCKCHIP option and it must be enabled for 
the build system to even be able to compile this file. This means that 
the user will be told "look at this option" and it's already enabled. I 
would suggest instead:

Please select a DRAM type via a CONFIG_RAM_ROCKCHIP_* option

what do you think?

>   #endif
>   };
>   
> diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
> index b371f597d23..3d7cd076a51 100644
> --- a/drivers/ram/rockchip/sdram_rv1126.c
> +++ b/drivers/ram/rockchip/sdram_rv1126.c
> @@ -83,7 +83,7 @@ struct rv1126_sdram_params sdram_configs[] = {
>   # include	"sdram-rv1126-ddr4-detect-784.inc"
>   # include	"sdram-rv1126-ddr4-detect-924.inc"
>   # include	"sdram-rv1126-ddr4-detect-1056.inc"
> -#else
> +#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
>   # include	"sdram-rv1126-ddr3-detect-328.inc"
>   # include	"sdram-rv1126-ddr3-detect-396.inc"
>   # include	"sdram-rv1126-ddr3-detect-528.inc"
> @@ -91,6 +91,8 @@ struct rv1126_sdram_params sdram_configs[] = {
>   # include	"sdram-rv1126-ddr3-detect-784.inc"
>   # include	"sdram-rv1126-ddr3-detect-924.inc"
>   # include	"sdram-rv1126-ddr3-detect-1056.inc"
> +#else
> +#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"

issue: misleading Kconfig symbol

See above for suggestion.

Cheers,
Quentin
