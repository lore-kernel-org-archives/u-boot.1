Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EC606A32C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H3SZSPp0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsYKe0rT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AE028119C;
	Thu, 26 Nov 2026 13:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93oTCK4XASuS; Thu, 26 Nov 2026 13:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B704481198
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700196;
	b=Oa2XxzL59NPZhZmav82X+qYMkLT7hT4xC7/AFynLNa5RMAliFgyrQ47c0KqlB6/8h1Dk
	 KEZK4gkJn3PiW0HRY5I/dO725F1MhbwFupaKq1avEyqsZkTE4l80qTuiCnmNBG4GOwbEm
	 lwYvDhDmv27Lq+G5RLTRvh/63nBxl0JwrMJTEcjevAOS+p8GxAiKNkoNwDWKr7hxIP1DD
	 X8IlJKBgP5yWfcfQHKcdyDYF0/AwHBDJ8MRtQMhe2KKXF+DzV2DsrhbMPWWFR8D0FnJBu
	 WMklkghpiqeeBS1sIxy7uP5e/0O5sBdLaOxnJeyXVlnakzl01B5JVzbNehwDcL5VpNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eIuDgraUnVAn5bIrOmrT6dd9awgXc534R+tNk3kbVyU=;
	b=Na1CuOhAcjJN/UohWVhUyTTYXe0taadKFaxMkkviATkS1fKSOMM6gEGLp/CY1Gq4SXg7
	 qXgzLzErDIK5L8Vthk+6YXtEMDQ6MRw1ao6dAB9OoA+7lPCmry15GwYfBU9jHkChW/mlu
	 mRU8vVuVEq/loIDMXBpxj5d3oElMGUnBgXS8CH2Qv0sI0pWanx/G89cDq+cbCSFblo57B
	 KQqYuR1GKj9qtap6ElgHW3HnmNDimUQIetpD2JoaMfXMA4hvaEAK4jk1haHepGr0G8lrG
	 nD+vVpBsIeLvpcMlXNKN2t42MgbHfPV52ZGAeOkW7NVJV9uBEH71SjMMyZLVonbDLxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700196;
	bh=eIuDgraUnVAn5bIrOmrT6dd9awgXc534R+tNk3kbVyU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3SZSPp0Uz8qQJCHj3zLzHg0PdLm1rHRq6lmkNoNLxef7UjikIdAp906HcwqftA6P
	 GzG5yVKa8owlcxxtv3kFMAANC1LqUVT0kFCpAeBSXGZ9bwvKH/p3ID0jhFlVAZF8Zv
	 k92hDqPQ59IX1En1EYvZhAB86UbgDGIzrutSxkKDd+w5We0bb4/hGf5SWiKfXBgeuo
	 +8IaSEICLUD/q41+XspwFMPcUBqYDnpHUBE0yUj9DxtridUOvg7cRQuR8q0LorW3EF
	 8631qGA0qTnWusf/m8jIj4zdptQcuba4oLhaALaHqv1vqCP9BoCAlHMX2GhH+pOEDL
	 AdBByw6Jq3s2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B704481198;
	Thu, 26 Nov 2026 13:36:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A437522B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9606F409E0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgkKiaFZ1Feq for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3DBF409D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MsYKe0rT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3DBF409D3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:36:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCE964121E;
 Thu, 26 Nov 2026 13:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC0F1F000D0;
 Thu, 26 Nov 2026 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700193;
 bh=eIuDgraUnVAn5bIrOmrT6dd9awgXc534R+tNk3kbVyU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=MsYKe0rTgwlfpBenQiccn5i6COkI2wpY/J7ILra1tl3vZJmqccsUqJaqeefGzUsxW
 AvD3LBrd3FhCmvrQMJrGs19wSiuA1/Nbiq0V7SoOYjzj31sC0Nnom5u5m4U6GQLMzT
 jXouguwfHlbHRGIG6zY3GMI9FpdbTQO6LNEzorWBcljaMpF6INPkown8l/owesVEsM
 CDP1ltGKvtiHt/M+6wkCHM/yUB4m7dH8x8Z6j9UeA6b4/yp43s48Ll6Zv4E5Jc8yyf
 29dweAqjT27RFDN+6LwoCogviuYpDnuEKYw5hjDZ6CGVbEjEE4CmMii7PEOq1O6mlZ
 fUokwGCXptdjg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] misc: qcom_geni: use the minicore settings only on
 all-minicore wrappers
From: Sumit Garg <sumit.garg@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-geni-mixed-minicore-v1-1-bce20aa8f4cf@oss.qualcomm.com>
References: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
 <20261115-qcom-geni-mixed-minicore-v1-1-bce20aa8f4cf@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:06:26 +0530
Message-Id: <179570018635.130558.10239136169683925720.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-15 11:49 +0100, Igor Opaniuk wrote:
> A QUP wrapper is treated as minicore as soon as one of its serial
> engines reports GENI_USE_MINICORES, and then no engine is loaded from
> the firmware partition. On QCM2290, SE0 and SE1 have program RAM while
> SE2-SE5 are minicores; with CONFIG_QCOM_GENI_MINICORE=n no engine gets
> firmware:
> 
>   i2c_geni i2c@4a80000: Invalid proto 255
> 
> Use the built-in settings only if every engine is a minicore and the
> table is built in. Otherwise load the firmware image and skip the
> program RAM copy for minicore engines, as Linux does.
> 
> Tested on the Arduino UNO Q (QRB2210): all engines are loaded, i2c probe
> finds the devices, Linux uses the engines. Not tested: an all-minicore
> wrapper (IPQ5210).
> 
> Fixes: 91a70d8bcf5e ("misc: qcom_geni: Add minicore support")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/misc/qcom_geni.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

Thanks for the fix, looks reasonable to me:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Varda,

Can you confirm if it works fine on IPQ platforms?

-Sumit

> 
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index 90aac714988..2b44bb492de 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -280,9 +280,15 @@ static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
>  		return -EINVAL;
>  	}
>  
> -	/* Program RAM address space. */
> -	for (i = 0; i < hdr->fw_size_in_items; i++)
> -		writel_relaxed(fw_val_arr[i], rsc->base + SE_GENI_CFG_RAMN + i * sizeof(u32));
> +	/*
> +	 * Program RAM address space. A minicore engine runs the protocol on
> +	 * a hardware state machine and has no program RAM, so only the
> +	 * register configuration of the ELF image applies to it.
> +	 */
> +	if (!elf || !(readl(rsc->base + SE_HW_PARAM_2) & GENI_USE_MINICORES))
> +		for (i = 0; i < hdr->fw_size_in_items; i++)
> +			writel_relaxed(fw_val_arr[i],
> +				       rsc->base + SE_GENI_CFG_RAMN + i * sizeof(u32));
>  
>  	/* Put default values on GENI's output pads. */
>  	writel_relaxed(0x1, rsc->base + GENI_FORCE_DEFAULT_REG);
> @@ -457,9 +463,16 @@ static int geni_se_of_to_plat(struct udevice *dev)
>  	struct resource res;
>  	u32 proto;
>  	struct geni_se_plat *plat = dev_get_plat(dev);
> +	bool all_mini_cores = true, any_se = false;
>  
>  	plat->need_firmware_load = false;
>  
> +	/*
> +	 * The built-in minicore settings replace the firmware image only if
> +	 * every engine of the wrapper is a minicore. A wrapper can mix both
> +	 * kinds (QCM2290: SE0/SE1 have program RAM, SE2-SE5 are minicores),
> +	 * and then the engines are loaded from the firmware partition.
> +	 */
>  	dev_for_each_subnode(child, dev) {
>  		if (!ofnode_is_enabled(child))
>  			continue;
> @@ -474,10 +487,13 @@ static int geni_se_of_to_plat(struct udevice *dev)
>  		if (proto == GENI_SE_INVALID_PROTO)
>  			plat->need_firmware_load = true;
>  
> -		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
> -			plat->is_mini_core = true;
> +		any_se = true;
> +		if (!(readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES))
> +			all_mini_cores = false;
>  	}
>  
> +	plat->is_mini_core = any_se && all_mini_cores;
> +
>  	return 0;
>  }
>  
> @@ -580,7 +596,7 @@ static int qcom_geni_fw_initialise(void)
>  		return 0;
>  	}
>  
> -	if (plat->is_mini_core) {
> +	if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE) && plat->is_mini_core) {
>  		fw_buf = qup_mini_cores;
>  		goto mini_core;
>  	}
> 
> -- 
> 2.53.0
> 
> 


