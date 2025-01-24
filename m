Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8669CC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA7FA80C6D;
	Fri, 24 Jan 2025 16:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732386;
	bh=JNiAinz9/8Ztu3CarykR7rfJb2rzAOt8j2EmEf+AORY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gr0GQ2bzcsGdm6HZi+W8JCdwGnxjC88pasHB4TIDKtdEIgUdJiG2I8393mwefwUah
	 BD5QEUw6cyd6Y7R3ZyJb3Xoiym6MouEbbKFbC6HumPaVwOyDwk9WnzZLuvtvpkJNXy
	 7COGKT869WkEgddotybyruBi9hFEmIy7rY1pRYJ7LH8ScpsOcYeVNSuKJMugNAPupI
	 Us+CTBXGyoEIg6mtxXd6N9GVE4z6ScpTkU2cJh1wUj2wDkvQaTfZQmqPapQhbE/ElX
	 OwRc+Nogda+Li3/EM+WBTLhmadu/uYCqgAsAxEBPmezii18ED5Eg0uaF3S8hJkJ8q+
	 9chcYz8cxV5Iw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC14880BAD; Fri, 24 Jan 2025 16:26:25 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA64C809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ataC1HyI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 661C1101D2388; Fri, 24 Jan 2025 16:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNiAinz9/8Ztu3CarykR7rfJb2rzAOt8j2EmEf+AORY=;
 b=ataC1HyIZnrgZ07CtVRtMGFXEIl5yfKd6DsCxIe5eXzGpF8puFBQiT3XSx+BF+4GtPazbI
 68ZNjvoVIz1dXG/3eNg/3fLXUHEUKXlaeOEl4yEbRSfT4+LAxkWhCw2t2ZOVtSz+uNXeXu
 vf2oNtTo/2BG29ApPZYz7/5j+lCrsqmRj8caurSXVG+KFiSzClSJ94mpRuSNo641xavRFo
 7jisPvjMIYX3KKIHeLdjLtgUkOmnBGD7OLLHElQNU8FqMRtqHmGgD3llHM2f/0WfP+xxb4
 9R6g7R7nG4PuUymuYr/iopKLt2Hh/11Ju/KwnesWXCryzq/RnQonKMhBIhhBnw==
Message-ID: <23affd75-93cc-4b72-8a34-6479b98e7a62@denx.de>
Date: Fri, 24 Jan 2025 15:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/20] scmi: add the macro SCMI_MSG
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-11-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-11-93b28a514dea@oss.nxp.com>
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

On 1/15/25 2:28 PM, Alice Guo wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch adds the macro SCMI_MSG for protocols that do not need
> _in_array.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>   include/scmi_agent.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/scmi_agent.h b/include/scmi_agent.h
> index 755986d6c424ccc881ac0943a88735cbcfacb001..5508a126a6dc504afa6d896c78c760b1af0d3deb 100644
> --- a/include/scmi_agent.h
> +++ b/include/scmi_agent.h
> @@ -54,6 +54,17 @@ struct scmi_msg {
>   		.out_msg_sz = sizeof(_out_array),	\
>   	}
>   
> +/* Helper macro to match a message on output array references */
> +#define SCMI_MSG(_protocol, _message, _out_array)	\
> +	(struct scmi_msg){				\
> +		.protocol_id = (_protocol),		\
> +		.message_id = (_message),		\
> +		.in_msg = (uint8_t *)NULL,		\

Is the cast needed ?

> +		.in_msg_sz = 0,				\

Is the explicit assignment of in_msg/in_msg_sz even needed at all ?

> +		.out_msg = (uint8_t *)&(_out_array),	\
> +		.out_msg_sz = sizeof(_out_array),	\
> +	}
[...]
