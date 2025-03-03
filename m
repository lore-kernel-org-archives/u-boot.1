Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6157BC282D0
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00D081298;
	Mon,  3 Mar 2025 22:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039040;
	bh=dgonOEtdYTcywVKYs9y+qo8BdpNEA9+mGlyfZ0FhwEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnoqn4k0gUsaQx5x9/MKWMvUDZsHY7r/Q0HJWOngD6Ad0vhrN4E93lKUa142aTxFU
	 M8pjw3P0uJpDjGRLIunVs8xeViksc7EGyWpsxgq2uk0O6BOjYsKmapWELcq0JunZFL
	 1te5869dFTCBvkRHL/DlgTrT5r6+wd7NRvhmooQZ9e3nbMbtIVtRyruW2WKeBhMzaL
	 9Fd7W7H3GA56nGcM5AJFeAOyb8v5CrAnm0wNdjahqxuzU+fLjaLYGgc4Uqubw7uhEl
	 gKeY4ZKXDsGuuJlu/sWsu/cs+/iQKoFCTPoPsr2RwBWQqPe+u+xNYfxnQyLelI/YJ7
	 5H+mZ7iuZXiqg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9706E811B3; Mon,  3 Mar 2025 22:57:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 980A7811B3
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aW+YA49r"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5599C10381918; Mon,  3 Mar 2025 22:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039037; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=dgonOEtdYTcywVKYs9y+qo8BdpNEA9+mGlyfZ0FhwEM=;
 b=aW+YA49r8TMUcH9c3NJ/CSaOVr7otwnif9QtziUugYdoUafX5JMnOe3deQVFz4pBfQQIpg
 1dTiN78R8leGuuv6zTpKY/9W6BVq6PcTll2CivjZQoacVYjovp7JueAEDoEgkarznWw2S4
 yAdVtJAbi2sZtvJkNuwpIQW1ZhaCoVstwXrKpeguqXOYisZsbTB6jVMhTHknBmwDHnbFLn
 qoI0qMTJRTNq/6HPmy6RnlumUUOwqXxTj8jJh/wrRsbOGspTagf2gdmBfVGyxTdKG6U4d4
 RZx6ruBft/VlSn/TmNrkFwXbfJTCv9RP4j59Urb2jfXKNUyE6/6yG0b1UvTnEg==
Message-ID: <d140bd3b-d0d5-4e1b-b4db-f029f102a5d7@denx.de>
Date: Mon, 3 Mar 2025 21:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2NCAxMC8yMF0gc2Nt?=
 =?UTF-8?Q?i=5Fprotocols=3A_update_struct_scmi=5Fbase=5Fdiscover=5Flist=5Fpr?=
 =?UTF-8?Q?otocols=5Fout?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
 <05ef8aa9-fc2c-44c4-905d-13cf81b35d9b@denx.de>
 <PAXPR04MB9644E421817CBBA159C9907BE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644E421817CBBA159C9907BE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/3/25 11:37 AM, Alice Guo (OSS) wrote:

Hi,

>>> @protocols is an array of protocol identifiers that are implemented,
>>> excluding the Base protocol. The number of elements of @protocols is
>>> specified by callee-side. Currently, set it to 4 is enough for i.MX95.
>> Can you please try something like this instead ? That should be
>> future-proof:
>>
>> diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c index
>> f4e3974ff5b..92d278edfaf 100644
>> --- a/drivers/firmware/scmi/base.c
>> +++ b/drivers/firmware/scmi/base.c
>> @@ -258,17 +258,16 @@ static int
>> scmi_base_discover_impl_version_int(struct udevice *dev,
>>    static int scmi_base_discover_list_protocols_int(struct udevice *dev,
>>                                                   u8 **protocols)
>>    {
>> -       struct scmi_base_discover_list_protocols_out out;
>> +       struct scmi_base_discover_list_protocols_out *out;
>>          int cur;
>>          struct scmi_msg msg = {
>>                  .protocol_id = SCMI_PROTOCOL_ID_BASE,
>>                  .message_id = SCMI_BASE_DISCOVER_LIST_PROTOCOLS,
>>                  .in_msg = (u8 *)&cur,
>>                  .in_msg_sz = sizeof(cur),
>> -               .out_msg = (u8 *)&out,
>> -               .out_msg_sz = sizeof(out),
> 
> The pointer and byte size of the buffer where the response message is stored should be provided before sending a BASE_DISCOVER_LIST PROTOCOLS message.
> 
> There is a more reasonable way. Number of protocols that are implemented, excluding the Base protocol, can be obtained by sending a PROTOCOL_ATTRIBUTES message. But now this command is not supported in U-Boot. In this patch, ec8727b7e1 ("firmware: scmi: implement SCMI base protocol"), "u32 protocols[3];" is used. So, I think setting the array of packed SCMI protocol ID's to a fixed size is acceptable.
NAK, let's not perpetuate this suboptimal implementation, please 
implement PROTOCOL_ATTRIBUTES if that's the way to find out the amount 
of supported protocols dynamically.
