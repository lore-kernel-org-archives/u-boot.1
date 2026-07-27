Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCBDC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 685E980E0C;
	Mon, 27 Jul 2026 13:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1rEi74aj20g; Mon, 27 Jul 2026 13:15:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E92980E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785158158;
	bh=3HzcI+TabEXre+K5k5+zcKRbz8AJ8V0dTiEpcM3EmUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5dyBzwMjLBxFWcP4tI7s2i0UVFQmpisXYRmBKRR+i8TVKdaDVl2Ib3EAeWBVzemb
	 gZvvpiBWKaeyJTJoiHomy8p5YL+2GNqMpVGBlzm4tz0cJofH3JcJ+n9EfM9D/fxVm2
	 DSNOsJvUQIuN+mSNiC97ehYgzDog7laienqdz6l/On4gR53bJXrmWvxkylHf1tG4Bl
	 RXw7gKos+BzgTYMQfVSr1diVk2TO1yU/FqliUx06Mvc9Kx5c6fU5RzScswfXnIp7h4
	 XhcCj3hdlWTl2PySp7pkd0xTAA31pibdg9IR4Nl/qZg7wIGmbc4Aj9hpBFMFzjIfSn
	 HMP1qoz2uRjuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E92980E1C;
	Mon, 27 Jul 2026 13:15:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E340C350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D53DE40063
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ4j9VesEBVO for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:15:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B3BF540015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3BF540015
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3BF540015
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:15:55 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so493642f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785158154; x=1785762954;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3HzcI+TabEXre+K5k5+zcKRbz8AJ8V0dTiEpcM3EmUo=;
 b=UKqzFj3q9WVv9xzrohsierCfvkIKjK4GILXhvUlSUuWzrp3cGC1C6CKpqDVP+ksYwd
 9uQmWEBablqW/rjFcFo82G563M8v4pA2ubWgbskbAVDqtYUgyFGmNj1VJgXFy7E1581Q
 AzGGD4dSh7/b4qGs6V0MQXSa05pN01Kyl8jEdgKMApxqA8aoYcgcOjel2y5onYJeaycb
 CQaa8nu+FcJ47ShzBVQLWfzqeiVHhPunC4QrrAkt6kI6f2yw9FUIroinzdIg/QLChkjy
 ZPOmOWNNLHUqjBzc6bwv8CBQ/YSaBOrmr8tjkkCugQ6lbHwDNCeh+oqbXXbjIQGu52Ar
 PnOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+lirrKEoH9yZNzSyWk36Zp0BTaBT0HaPjQo99tx7uSnxOH0sEzW52258MZM8mAIQhSSDN+Pw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywh7ZSzkZUNyvdteTC7DU8hHT1601S4Rsqi3XJ0DO9gdXqe79vP
 8N15LYVDcYjgUJliQEV8QzYTN316TBskJ7OTTL4SEgdzwXxygtnaW3xqOm04pmZElLU=
X-Gm-Gg: AR+sD11L+LxD7aSBsNOBk2caUW2Q8bTe52cOj6fKNuxJF82Ow0gE30IrVCNOShmAAzk
 MJdeWJ/9gzNKYk7YQL0KOc00/ugGVInKb/x2cwgCoOWbmqzoHwvIpuz0FVEg2SbwHAFa+qsnXI7
 r7320+qEQeKaQjoIyCCfSODlG1gTfzlpqQhvXYjbAFa1k4FmaTcHTyIwg5hENvr/hpo+4mbXba/
 6IODdo6O4ngyliCetXGMdUQli2+g18P35vWS9WnpeNBA3W7csbG6V34yj7v4diQUg47THMS9Kw5
 DQ2qxxzagOhu4BFiQHoz9jXXGNXBCixYsqyz00UI1KVMjFbRNfBo51+JGovPWPFjDFER2mDLChT
 FaSDOLhpvFQS07/LvE4j4tCjXObrATaUBuguNuj6UVfUaHN7xRVJfPthrV0ulysswI9L0ND3NLd
 UIQ2T91cEMAQNyI7KcPSOQSkj/gQwSmaFpf6SpD03DqQ==
X-Received: by 2002:a5d:5e88:0:b0:47f:8fc9:6eaa with SMTP id
 ffacd0b85a97d-47fae777b98mr800572f8f.8.1785158153579; 
 Mon, 27 Jul 2026 06:15:53 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a64dsm53266192f8f.1.2026.07.27.06.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 06:15:52 -0700 (PDT)
Message-ID: <6e706370-632e-4ba5-8ed1-efa548b037e6@linaro.org>
Date: Mon, 27 Jul 2026 15:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] mach-snapdragon: Kconfig: Add rules to create
 SPL images
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>, Anshul Dalal <anshuld@ti.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>, Jens Reidel
 <adrian@mainlining.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-7-cbfa79e85a9d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260722-spl-v8-v8-7-cbfa79e85a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785158154; x=1785762954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3HzcI+TabEXre+K5k5+zcKRbz8AJ8V0dTiEpcM3EmUo=;
 b=I5SOo03W85CG/vzY08H/A5AMA+txLYrupPHSn4EJ/v9GbMsZRLYJQaw6V/LHRxF34d
 /dPem/OlRieVpG/isVfYgvPdzOu1FtcNpFV2sCNMPbdEZnEX9xGCPXNNl2TOLZoPtf5W
 NaVeWfKX8T9DVoWd3s4d3jeZmH5QDDMzGydQLn0V70UxPBIMIExaeamRbHwGWlCWb3tz
 O+bLXOab+oy3KOcYHkRC2iR89whBCgnBMcKr9w3ICrt6VlD3F4cR7QnpdwMvbd2QBc9C
 XLhk5OMu/GA+dvTZRXETAnM6q70XGVvED1tWQ6s0omt5oeoVaf/n7W09HQc5ziyKD/w7
 ugvw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=I5SOo03W
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 22/07/2026 09:41, Varadarajan Narayanan wrote:
> The boot rom expects the secondary boot loader in MBN format followed by
> the TME executable. Add rules to board/qualcomm/config.mk to create
> u-boot-spl.mbn and u-boot-spl.melf.

For which SoC families/generations?

> 
> u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
> followed by the TME executable.

It's intentional that mkmbn is invoked twice and things are nested?
> 
> Additionally, this patch adds a config option to specify the path
> of the TME executable to be used to create u-boot-spl.melf.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig |  7 +++++++
>  board/qualcomm/config.mk         | 23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index ddded0029ef..f1a6e828c3c 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
>  	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
>  	  supported.
>  
> +config QCOM_TMEL_ELF
> +	string "TME Elf to concatenate with U-Boot SPL MBN image"
> +	depends on SPL

depends on QCOM_GENERATE_MBN

> +	help
> +	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
> +	  boot rom expected multi-elf image
> +
>  choice
>  	prompt "Qualcomm boot0.h workaround"
>  	optional
> diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
> index 769e4a51ca0..2abecbf8ea5 100644
> --- a/board/qualcomm/config.mk
> +++ b/board/qualcomm/config.mk
> @@ -12,3 +12,26 @@ quiet_cmd_mkmbn = MBN     $@
>  
>  u-boot.mbn: u-boot.bin FORCE
>  	$(call if_changed,mkmbn)
> +
> +ifeq ($(CONFIG_QCOM_GENERATE_MBN),y)
> +
> +quiet_cmd_mksplmbn = SPLMBN     $@
> +      cmd_mksplmbn = $(CMD_MKMBN) -o spl/u-boot-spl.mbn -l $(CONFIG_SPL_TEXT_BASE) -s 4 $<
> +
> +INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.mbn
> +
> +spl/u-boot-spl.mbn: spl/u-boot-spl.bin FORCE
> +	$(call if_changed,mksplmbn)
> +
> +ifneq ($(wildcard $(CONFIG_QCOM_TMEL_ELF)),)
> +
> +quiet_cmd_mksplmelf = SPLMELF     $@
> +      cmd_mksplmelf = $(CMD_MKMBN) -o spl/u-boot-spl.melf -m spl/u-boot-spl.mbn,$(CONFIG_QCOM_TMEL_ELF) -s 4 $<

you're including u-boot-spl.mbn twice here no??

> +
> +INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.melf
> +
> +spl/u-boot-spl.melf: spl/u-boot-spl.mbn FORCE
> +	$(call if_changed,mksplmelf)
> +endif	# CONFIG_QCOM_TMEL_ELF
> +
> +endif	# CONFIG_QCOM_GENERATE_MBN
> 

I'll try and get around to revieiwng the rest of this series later in
the week, no need to respin yet.

-- 
// Casey (she/her)

