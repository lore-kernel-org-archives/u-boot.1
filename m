Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED575E82CC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 21:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC7F86D8F;
	Wed, 27 Sep 2023 23:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="ViZwNQxy";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5evfzzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532B586D94; Wed, 27 Sep 2023 23:32:38 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D1086BE2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 23:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 106EB5C2808;
 Wed, 27 Sep 2023 17:32:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 27 Sep 2023 17:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
 1695850353; x=1695936753; bh=4JrHx8aYO4+57H9tjVhmfHPx6wKflMQ9AEQ
 SFDY5WYk=; b=ViZwNQxySOiCxcL9IoFYPhgcokxFAFAKh9FmnkNuZbUYZAwp5YP
 71nir4I8NWfi9PvNWiedkGZF9gpChmGgXLJc7TnTLrn/hC0lMg2sqFKaxK6vBCpB
 C4hLmhZbtoEVxQEOTXiat0BqFGWHS2uiyEa25Dar/lqnkJ9EMezQdJxTetyD+6Ix
 YsJjoXDFfZIHi6YiJO7ULrhtksEJwnX/igLtW3+1HwnjuGtm0fbCqlMNO5xFCD25
 ZQBHRq6KJxsgEhTkRRmHdSbWeX5k1iylJjRQo4KlVHcAMRqMaVUti4JkZi4iQCQT
 tNX8knJHHc6znj351EnuW3vnTxW/R/e6n/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1695850353; x=1695936753; bh=4JrHx8aYO4+57H9tjVhmfHPx6wKflMQ9AEQ
 SFDY5WYk=; b=b5evfzzqYQPzibaC7qs3BiCSTr0kd4RFh7qGeD1ITWGrhqNI98C
 D5EYgchf7yZwZZRxr6e6orIxATCUq73Xc4oYL9zN/8b5yfbYndUFo8bvZd5ELyTG
 rKHpPxpt8OdY9OFran64DLAIezCa6Xr29ZUUmthdZP0nMrq1ZEsY5++ib8RABjuW
 OX3Xd4wz1fVOwTjq3IsTrynDIocb2gIGQHaIxXKdzK068xnAUxm/gZnMEjEwNq61
 jXmuIRoYPhXPcnqDvJ9a3zFsfenzkHtvbLyFfVZ0OT4nrVYtyT6+Krpk8sgPr8Ez
 th1nZZlnA9GLlFmjI/QltRlT57bp/B8D1Pg==
X-ME-Sender: <xms:b58UZVN51au-HUSzH65lN6f26pBXHbHrk5xj-cYkLC3xQMcuQZIFbg>
 <xme:b58UZX9WXw-BVzJxOKHUKeAND6aE-KDFtihkHbOD8u6KDs0WN5KD-kHmAGJxBjPIU
 8rT8HfPdDK_fT7aVg>
X-ME-Received: <xmr:b58UZURGwgmBW21CgXbNBK6EjrGd8ufME-Odt9FXP6ZKeSqEkzwZk6qy8B46Szs5swL7dHqkdUMQP2bWHDyMe4YG5XEE7u0CpKP2-Ft1lsQMNrHvmA6CybCUHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:b58UZRtvbLb5AiQwvmvCMPxOwq8LIt9SaG3pDaLpH6M6l-WyjuA5Kg>
 <xmx:b58UZddUJSvDKJ9seRMEd52-TTdGljWoA5C4xeUIdAD-FF3-0PFEDg>
 <xmx:b58UZd3lOBJ9feHCPzWUHVRNuA9h3b5iyr5QT2J3AoVYc1KVQV7yAw>
 <xmx:cZ8UZb3kzP0wBW_WEZr0pfEdupAdf7n_G8AnrbEg80M6TctGXJTodA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 17:32:30 -0400 (EDT)
Message-ID: <17e57370-754e-3954-db16-58ab013c92d4@sholland.org>
Date: Wed, 27 Sep 2023 16:32:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] riscv: andesv5: Prefer using the generic RISC-V timer
 driver in S-mode
Content-Language: en-US
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: twarren@nvidia.com, sjg@chromium.org, saproj@gmail.com,
 william.zhang@broadcom.com, andre.przywara@arm.com, clamor95@gmail.com,
 patrice.chotard@foss.st.com, jonasschwoebel@yahoo.de, bmeng@tinylab.org,
 u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com,
 randolph@andestech.com
References: <20230927072500.1018499-1-peterlin@andestech.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230927072500.1018499-1-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/27/23 02:25, Yu Chien Peter Lin wrote:
> The Andes PLMT driver directly accesses the mtime MMIO region,
> indicating its intended use in the M-mode boot stage. However,
> since U-Boot proper (S-mode) also uses the PLMT driver, we need
> to specifically mark the region as readable through PMPCFGx (or
> S/U-mode read-only shared data region for Smepmp) in OpenSBI.
> 
> Granting permission for this case doesn't make sense. Instead,
> we should use the generic RISC-V timer driver to read the mtime
> through the TIME CSR.  Therefore, we add SPL_ANDES_PLMT_TIMER
> config, the PLMT driver will be compiled only against M-mode
> U-Boot or U-Boot SPL.
> 
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>  arch/riscv/cpu/andesv5/Kconfig | 3 ++-
>  drivers/timer/Kconfig          | 9 ++++++++-
>  drivers/timer/Makefile         | 2 +-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/cpu/andesv5/Kconfig b/arch/riscv/cpu/andesv5/Kconfig
> index 82bb5a2a53..eba576af2f 100644
> --- a/arch/riscv/cpu/andesv5/Kconfig
> +++ b/arch/riscv/cpu/andesv5/Kconfig
> @@ -4,8 +4,9 @@ config RISCV_NDS
>  	imply CPU
>  	imply CPU_RISCV
>  	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> +	imply ANDES_PLMT_TIMER if RISCV_MMODE
> +	imply SPL_ANDES_PLMT_TIMER if SPL_RISCV_MMODE

You don't need the "if RISCV_MMODE" condition since the imply statement
will be ignored if the dependency is not met. Either way:

Reviewed-by: Samuel Holland <samuel@sholland.org>

>  	imply ANDES_PLICSW if (RISCV_MMODE || SPL_RISCV_MMODE)
> -	imply ANDES_PLMT_TIMER if (RISCV_MMODE || SPL_RISCV_MMODE)
>  	imply V5L2_CACHE
>  	imply SPL_CPU
>  	imply SPL_OPENSBI
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index 915b2af160..157298a941 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -59,7 +59,14 @@ config ALTERA_TIMER
>  
>  config ANDES_PLMT_TIMER
>  	bool
> -	depends on RISCV_MMODE || SPL_RISCV_MMODE
> +	depends on RISCV_MMODE
> +	help
> +	  The Andes PLMT block holds memory-mapped mtime register
> +	  associated with timer tick.
> +
> +config SPL_ANDES_PLMT_TIMER
> +	bool
> +	depends on SPL_RISCV_MMODE
>  	help
>  	  The Andes PLMT block holds memory-mapped mtime register
>  	  associated with timer tick.
> diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
> index 1ca74805fd..1f5c16fdf3 100644
> --- a/drivers/timer/Makefile
> +++ b/drivers/timer/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-y += timer-uclass.o
>  obj-$(CONFIG_ALTERA_TIMER)	+= altera_timer.o
> -obj-$(CONFIG_ANDES_PLMT_TIMER) += andes_plmt_timer.o
> +obj-$(CONFIG_$(SPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
>  obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
>  obj-$(CONFIG_ARM_TWD_TIMER)	+= arm_twd_timer.o
>  obj-$(CONFIG_AST_TIMER)	+= ast_timer.o

