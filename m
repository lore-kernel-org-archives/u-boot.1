Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73F8E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FA0805EA;
	Sun,  5 Jan 2025 23:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115134;
	bh=uUrZ+oETGW55yzjOz/lFo91FnFcWSjuUQeYSLmqXKaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zk3DS+HiO+h2J7EoDBSdD26XRVv5ooYCMzKVduo7/mgKwKDodP/5ce+zTFK+h8uXd
	 RLaWr5Eqya0GVQKYmslC7t1O8uGtUWeIiePOsMgHwqGeEmmHAZ+8CWUJdiEdz300xf
	 yaixTpt01AQhBSm3zNlJXwspyVWJZnxL84ApnLeZFrd7fPq/NO2VLvbGxqPS+FYzm2
	 FR24iLnqo42zUyDcY0+Qf/aj1VKqFrdr8XnYzxZduhJSXqgqLrKqpSkqXFJ9KxBpjQ
	 Qs13tKvjQn0cKaOJ6AeuhFqVI4jPY2xauqV4ZCRM46Jk44KXj+gSX2CABzN26RuCyz
	 /QP0DWzhrezwA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316ED8036D; Sun,  5 Jan 2025 23:12:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7146805FC
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iDUCKO+2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C6826101ECBAD; Sun,  5 Jan 2025 23:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUrZ+oETGW55yzjOz/lFo91FnFcWSjuUQeYSLmqXKaM=;
 b=iDUCKO+2W4FR1bG2oI8CSR+R5s1ur6pDYb5UU1yMPu/GEvHpwBZqX/psANTnX3BW1JnQ2+
 VgEc9cROZRq7FuQvcl28m6xuQTNgNt64MgqAQuvzBtttlupglsuGrROTTVFjfPSyD4hEAS
 6hLaW85oSV+RHRxNtSpGsC+RZTOAXf8KpCZDHXp970KMKWYhSF79LkZNQ+Scieu2hebNXT
 V9uqoRHt9xTEWXXyAYpmcHsyXIxEPA3dLo6GIxWhZ0BMvd3eKo4iuYnRfM70ogdlvaSHsM
 acws9ifW7pZfLvNXajvZaHXE4AWNkVvl+Zv6QkGc0ydgYKnm5bTBu8BUdLO8jw==
Message-ID: <a563cb62-7922-4a68-a24c-534e583b7dcb@denx.de>
Date: Sun, 5 Jan 2025 22:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-8-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-8-6744df5dc020@oss.nxp.com>
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> @protocols is an array of protocol identifiers that are implemented,
> excluding the Base protocol. The number of elements of @protocols is
> specified by callee-side. Currently, set it to 4 is enough for i.MX95.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   include/scmi_protocols.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 9607433c3276f9aa18044c414a5bde3143726cf4..3c55d228cb641bc6c0e5ca7ac885efe84b41c66d 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
>    * @status:		SCMI command status
>    * @num_protocols:	Number of SCMI protocols in @protocol
>    * @protocols:		Array of packed SCMI protocol ID's
> + *
> + * The number of elements of @protocols is specified by callee-side. Currently,
> + * set it to 4 is enough for i.MX95.
>    */
>   struct scmi_base_discover_list_protocols_out {
>   	s32 status;
>   	u32 num_protocols;
> -	u32 protocols[3];
> +	u32 protocols[4];
Can this be made somehow future-proof? For example, figure out how many 
protocols are supported, and then malloc this structure with the right 
size and query again ?
