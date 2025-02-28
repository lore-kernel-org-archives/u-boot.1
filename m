Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BD9C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D81811DF;
	Fri, 28 Feb 2025 20:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770852;
	bh=qtcSnc7KOxWfd1+si9OQvI8RttJ15K+65GQPYjsy1Z8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqwK/lqosj+cuEOpZN0i9omxpmKsewesEgObo/C//ZuNAumfSMiAv1T3kYO3gHUkg
	 sDSrttGSIKWEaX8LXeeEFwzkw4b83GbbYN4Osl4f7w/uAny4hBoGDeMpYK8un0ygln
	 2lGc/C97/A9wZYYjxfg55yChPawoJFYqwK73YXjyqquYraRa3NWcsO4nPoXqEmjZ+D
	 TtAcXbo5PCWJ0hhMLOM5rN1L8LTcBgSY/1OyFf8Uk+7OwSOp5ATbnq+z3Xyakt7xwS
	 XUJFTGvQ/nRYvkYjVYwBlOHmxnTFYEbK+M3Ny2azjoKSSyKlF09DqsknQh7I3GZVCA
	 bNeKZI9prIdqg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076F4811CE; Fri, 28 Feb 2025 20:27:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3CD81113
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EV9qeZBJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEA9B102FD52C; Fri, 28 Feb 2025 20:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtcSnc7KOxWfd1+si9OQvI8RttJ15K+65GQPYjsy1Z8=;
 b=EV9qeZBJkHuuznYlbfvXv33StcS/qmDhah6WVIHoyo0wqzgYKLNT9Fb1jxH+P3svvylx0k
 5H2OCoD5YM4LyGdqyzvc/MmkMENcAFP7sWrVdD0VsMstIervFg5Xvea2lprUO6IWBSvw98
 ucM9KpbZcZJY2enXrqShO9MhT1xWFcFShRSwELDS3kl9EGGOfv6FdoBWDRXPjwfgGv/0Zu
 nbxlKSo2nooImraTsobcIUb/8w+TQ1NBTuIAxJ/yOwp39fucJ2YrJv3FUc3cdgaZt/iKQg
 06T5zRGgTo5Y4ECpUQ2OhGCq4GRBK/yoBMem20/6Pc0Z80jv0JVf6h5u7YdqkQ==
Message-ID: <d3722347-031e-4a2f-8898-4f270cf1be05@denx.de>
Date: Fri, 28 Feb 2025 20:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-10-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20250228-imx95-v1-10-09594e93cc9b@oss.nxp.com>
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

On 2/28/25 11:54 AM, Alice Guo (OSS) wrote:
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
> index 2684f4177d..7ce73ddfae 100644
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

Can this be made dynamic ? I think I already asked about this last time, 
but v4 feedback was not addressed, can you please double-check that v4 
feedback ? I will review next version once it is addressed .
