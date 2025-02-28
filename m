Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B2DC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF4B81113;
	Fri, 28 Feb 2025 20:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770852;
	bh=uMQtmQCUd/lNu2JITvVNXUDEWTBPQzbD4Fuggqwz4bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TzDPG347atPv66cl9Yny87XhHpxDjggTvVCNoPAc/nKut/ZNJ6fYRmjBVYZh0zZQA
	 VcSgeKx7Ox+xaaXikMrO6+PIHgF9OYH5XpRZ6m627OrOBo3jj87UknpQXOLDHxsWkA
	 t1AfcVp8W7cuyNiU9rEtS6W8Tm4O9A8gSQNLeJbievuqgWRR4Yx5QDJ5U2ayFhEEin
	 udVzQqYTF/WDmQZ9bv3VvYfgPUC90BuLLSlr3OEysrhWVJhAd4tOuQ/UKYemKyachK
	 KY1zhh5TlgnfRBjmD2yXz6nKIoQhXOW49XYXcGGiPw22Baeo4RHWZo3wY7KwQin+7e
	 bIrB9nMzp2l2w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4306F811AC; Fri, 28 Feb 2025 20:27:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1545781120
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AiWmyyAt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E6B331034EACF; Fri, 28 Feb 2025 20:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMQtmQCUd/lNu2JITvVNXUDEWTBPQzbD4Fuggqwz4bM=;
 b=AiWmyyAtWa2a+VEXatIB1MKHj0enO+wTW2VEu7aMXhKsuLW4DMLBQL0poCZWaQClwZvEEi
 JJwp73MIFXMnZqZVn+AlHMQpnED0jr3dYttwMSogkSOIMzy72Na7VksddgB7CD53kGZhJK
 zL2P4TnsBnT9B7Bi606NXfx8ATbVQwoteAhDAhHuMpNjWPrPk+8UrQEDMXdhjmaLianq3F
 Uf/rTxmuYKND0c27JRxLwtJyPjhZ2eNA8hUlcNB6wUP7FUJ1g7KkVVfrYcqhF0nBV4NsIW
 heegjqcNeqFV70ZWE7Fg8bTelKQPgrzyOMb3Yil3e69GFd8n95SxhAwFxpcVjg==
Message-ID: <8114501f-9a0f-4e47-a093-ae5b8468d7f2@denx.de>
Date: Fri, 28 Feb 2025 20:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/20] clk: scmi: check the clock state/parent/rate
 control permissions
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-8-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250228-imx95-v1-8-09594e93cc9b@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/28/25 11:53 AM, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Clock driver based on SCMI clock management protocol in Linux checks
> clock state, parent and rate control permissions. To be consistent with
> the kernel driver, add this check here.
> 
> When using common clock framework (CCF), use the clock signal ID to get
> the clock registered by clk_register() in scmi_clk_probe(), and then
> obatin the struct clk_scmi variable with container_of().
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/clk/clk_scmi.c   | 172 ++++++++++++++++++++++++++++++++++++++++++++---
>   include/scmi_protocols.h |  26 ++++++-
>   2 files changed, 187 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 84333cdd0c..4fce92d064 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -12,6 +12,56 @@
>   #include <asm/types.h>
>   #include <linux/clk-provider.h>
>   
> +struct clk_scmi {
> +	struct clk clk;
> +	u32 ctrl_flags;
> +};
> +
> +static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
> +{
> +	u32 version;
> +	int ret;
> +
> +	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
> +	if (ret) {
> +		debug("get SCMI clock management protocol version failed\n");
> +		return ret;
> +	}
> +
> +	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
> +		debug("SCMI clock management protocol version is less than 3.0.\n");
> +		return -EINVAL;
> +	}
> +
> +	struct scmi_clk_get_permissions_in in = {
> +		.clock_id = clkid,
> +	};
> +	struct scmi_clk_get_permissions_out out;

Variable declarations should be at the start of this function.

> +	struct scmi_msg msg = {
> +		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
> +		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
> +		.in_msg = (u8 *)&in,
> +		.in_msg_sz = sizeof(in),
> +		.out_msg = (u8 *)&out,
> +		.out_msg_sz = sizeof(out),
> +	};
> +
> +	ret = devm_scmi_process_msg(dev, &msg);
> +	if (ret) {
> +		debug("get SCMI clock management protocol permissions failed\n");

Either use log_debug() or dev_dbg() or something which includes __func__ 
and __LINE__ too.

> +		return ret;
> +	}
> +
> +	ret = scmi_to_linux_errno(out.status);
> +	if (ret < 0) {
> +		debug("the status code of getting permissions: %d\n", ret);
> +		return ret;
> +	}
> +
> +	*perm = out.permissions;
> +	return 0;
> +}
> +
>   static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
>   {
>   	struct scmi_clk_protocol_attr_out out;
> @@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
>   	return 0;
>   }
>   
> -static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
> +static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
> +				 u32 *attr)
>   {
>   	struct scmi_clk_attribute_in in = {
>   		.clock_id = clkid,
> @@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
>   		return ret;
>   
>   	*name = strdup(out.clock_name);
> +	*attr = out.attributes;
>   
>   	return 0;
>   }
> @@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>   
>   static int scmi_clk_enable(struct clk *clk)
>   {
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(CLK_CCF)) {

if (!CONFIG_IS_ENABLED(CLK_CCF))
	return scmi_clk_gate(clk, 1);

Reduce indent.

> +		ret = clk_get_by_id(clk->id, &c);
> +		if (ret)
> +			return ret;
> +
> +		clkscmi = container_of(c, struct clk_scmi, clk);
> +
> +		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
> +			return scmi_clk_gate(clk, 1);
> +
> +		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
> +		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
> +		return 0;
> +	}
> +
>   	return scmi_clk_gate(clk, 1);
>   }
>   
>   static int scmi_clk_disable(struct clk *clk)
>   {
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(CLK_CCF)) {

DTTO

> +		ret = clk_get_by_id(clk->id, &c);
> +		if (ret)
> +			return ret;
> +
> +		clkscmi = container_of(c, struct clk_scmi, clk);
> +
> +		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
> +			return scmi_clk_gate(clk, 0);
> +
> +		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
> +		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
> +		return 0;
> +	}
> +
>   	return scmi_clk_gate(clk, 0);
>   }
[...]
