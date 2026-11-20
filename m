Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D8606A531
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0wbD/jyG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMfkdRJs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9653040DBF;
	Fri, 20 Nov 2026 05:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wUgywWC2p-O4; Fri, 20 Nov 2026 05:58:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC9DD40DAD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795154329;
	b=fzkjPy3iDA9MbThCftB7pTn3QomdU/Q39WnQl+Re+59twhgy6D5M3GLH2ayxsXcEGJQq
	 cujnNF3XhFF4KhBA+YmxdO6bh2foXTshVKQny2+L8DWe3OZn9FPVi5/o+bd3Oir4uMaMJ
	 deZOxZLEPjXnXi1zutOX5sGWdguvevWEj/w0mtfrGOQFHTVyC4mAMJjIk6Hti/RMi+QAM
	 WVLFiubDp9mT/JMKbvW85iSvFKlXeJkLVLrAIHXCsLnQrHTwPoCDAT0+pNzzygwC0FM8V
	 rrMwik/qIsKfRiNSLcgC+0vT11Z+emy1qlWhF61N4p9k1pXQHJT2n5ySTd0VanaUfAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795154329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jaGYQmptKZ8ALPvdcdbe+BXxRbV1KOhVFZOyvjfOiyc=;
	b=JUb9PNlrGvAPLZbYSUEEM0/9Tl7Al540kRiaEf9TWRwFeiGCVD8j2HNkasM9eSwYRwSt
	 qP3uQXZpySvEDAus5s43QOHq4owA5CRTdJqRHjlwU7kMpUi4NGo8kdi/oXU3EYicZTBE4
	 r29PUx1lhexHyPDg+AC6WDpkfYG7x0Cea87l7gme48GHPEyo0OiDECfBQUlocaUFWllBP
	 jajwRnjM2Md4Va852eCjvFyBCZTTB3ApDD/ZO1MpDIRcNWcR/+40/VNxWVpwWnq/LLll+
	 DH10VAPSoRAQo3X5FW5oFFzn2aIuX6hiuT7gegJMpudXg0ZR/v175Cbwz3p25hySVjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795154329;
	bh=jaGYQmptKZ8ALPvdcdbe+BXxRbV1KOhVFZOyvjfOiyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0wbD/jyGYVh92QD1m0sdqi6wn1iM3dFBalX1MXL57I11usrJjLqAr/CdS5JfUIpKn
	 cz0WmtE9bCD4TBpSM5QzXrifNdo7BIyUu9/G+QA5EYpsug+J9rsXqrs+nx58oVENKW
	 4GsvVWo0/EV/w5P3qjeQ3A3lrhG7iOaHGN18nB8f+bfqPc7xyeimDAeCmjF0V5i+D4
	 MW32l8q64+7neboH7vd3mJp4zC1Y/vofvQtcg3vRhsRvd38/LTbwtiYpNEfJg4VuqG
	 loS3EKtiq4pi2gi8A59Oa0elC8GAwaFQy5E1xWc0RfMv+XTAtIyhJ/VRlcIre8izpY
	 H9GmInVP51jIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC9DD40DAD;
	Fri, 20 Nov 2026 05:58:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9416C1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A42740122
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOfsZhhI5-cN for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 05:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BDB61400D6
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NMfkdRJs
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDB61400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:58:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1281C46B95;
 Fri, 20 Nov 2026 05:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6165C1F000F2;
 Fri, 20 Nov 2026 05:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795154325;
 bh=jaGYQmptKZ8ALPvdcdbe+BXxRbV1KOhVFZOyvjfOiyc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NMfkdRJslLOr3IfKZwora8ZjukJ6TVIG3+aVaO8kw2Rl43IyUNPBGB55BmX72TYa/
 3w1W4CXO7wSkm368jBj/EajeqJtfyyZQre/Mmnu5glV2Gs2WGO9QaA1zqk9H0wZbeG
 5zXx/efbwKxbKM23lm07Ximv5BJwLWw66y3rnYhCnusaBoMOjQBj10zk8aAS9p7Bku
 Wova9z78xWzWpxclgrprltkItajI7fkLd36XYhJODblSTAbO+ZB8b0JXFSEtvZm711
 AQZAeGe824SePru2iZhPl5mO0dfpig5SYY5QrQJn8OIF1OGn24IsVw4ESFxySrmmNL
 JrJj3DoKp/wCA==
Date: Fri, 20 Nov 2026 05:58:42 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v1 4/6] gpio: spacemit: Add SPL support for K1 GPIO driver
Message-ID: <20261120055842-GKE156369@kernel.org>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-5-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029134705.3767-5-linux.amoon@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

Can you split out patch 4, 5 and send a v2? I'd like to
 take them first..

On 19:16 Thu 29 Oct     , Anand Moon wrote:
> Add SPL_SPACEMIT_GPIO to enable the SpacemiT K1 GPIO driver
> during SPL initialization.
> 
..
> Depend on SPL_DM_GPIO and TARGET_SPACEMIT_K1, and select
> SPACEMIT_GPIO to reuse the existing driver implementation.
> 
I'd rather drop above explanation, it's quite obvious from
reading the code..

> This allows SPL to access GPIOs required for early board
s/This allows/Allow/, use imperative mood
> initialization.
> 
Any specific user of the GPIO? Can you add more detail, I can
 think of reason that SdCard's Dectect pin will use gpio.. 

> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
Can you put CC list in cover letter? I'd rather not apply them..
or possibly under line "---" if you want specific CC in single
patch? and of course it works..

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/gpio/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7f12e39dad8..3be6a9e54fa 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -457,6 +457,13 @@ config SPACEMIT_GPIO
>  	  arranged into a number of banks (different for each SoC type) each
>  	  with 32 GPIOs.
>  
> +config SPL_SPACEMIT_GPIO
> +	bool "Spacemit K1 GPIO driver in SPL"
    just "SpacemiT GPIO driver in SPL", which also make it work for K3,
so let's not only mention for K1..

> +	 depends on SPL_DM_GPIO && TARGET_SPACEMIT_K1
I'd also like to see it enabled in K3 platform, so how about

	 depends on SPL_DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
or simply remove platform contraint..
	 depends on SPL_DM_GPIO

> +	 select SPACEMIT_GPIO
> +	 help
> +	   Enable the Spacemit K1 GPIO driver in SPL.
> +	   This allows SPL to configure GPIOs during early board initialization.
>  
>  config SUNXI_GPIO
>  	bool "Allwinner GPIO driver"
> -- 
> 2.56.0
> 

-- 
Yixun Lan (dlan)
