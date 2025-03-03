Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E512AC282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C01811C1;
	Mon,  3 Mar 2025 22:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039050;
	bh=flCnla+svfnAaCjk8MwBHPtL+Ogyjv8514NDtK1B2PM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKj7ugNvagwBWSADuuPCBtBBJjtIH8XycqXydh8QabMw/HsOaKC1PNvLMOqeUF1Vv
	 JoKYqFi4GBX7Sn8SaYHjw0FnfcdEDjp3ZEFLelGxBEL+1N4F2zgqrAF7Gap0lMzJrT
	 T8VGEnEnAVjBxjiA54UraDh6zY1DaRVE+GEFxZpLIWuFtCYPqVefvUR486SMboYkN9
	 zTG0t6NgRXailXCBf4eXpY0/1bgpS17jRhlQzXcufPaSHQ2yUJWvNgq765mPaGqd/Z
	 CzSryOdH2xYFPjI07MmOlljYmHqqUZxefBfbo/FCJQrgjeLPVeH/QbyydEZ/1VFu3v
	 GO9NhsWVSlKtA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58BF811B3; Mon,  3 Mar 2025 22:57:29 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4971681423
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MAfm1mW5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9006110382C18; Mon,  3 Mar 2025 22:57:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=flCnla+svfnAaCjk8MwBHPtL+Ogyjv8514NDtK1B2PM=;
 b=MAfm1mW5ul9pLuhxhZMEnBq9OHpLP8L6vBtX8WPuP76kPJeXkRguy5gGwj5XvXNbhTymec
 QJQeJnjr6uFI63YG3i+tXWBr5dj4zAZMEToZa/p1SYd7fNmNC8aMHxJtpxbrCzCNZ75byo
 ED2U2OjxJqaxWuS9tcJGkJNKm/Qwqz7CgI1KThJmISnb30YwM2UU7v2pTaZbYUBsgP9YXj
 lOiRCFDnPkaw9poQzgk5pJ2n0PMcT/1vjYcAPdGIMkBZkXOjjQKrOokHmFNbwuTPk8L4eg
 pYD57+8iUtiK3QYu3yaTBKGUnvjZOKd5iXs1jZfLZehYukYeWsNqrJL1znNwuQ==
Message-ID: <8e30e732-5220-4e2a-b4c7-9ccf26ec4bd4@denx.de>
Date: Mon, 3 Mar 2025 22:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY2IDEwLzIwXSBzY21pX3Byb3RvY29s?=
 =?UTF-8?Q?s=3A_update_struct_scmi=5Fbase=5Fdiscover=5Flist=5Fprotocols=5Fou?=
 =?UTF-8?Q?t?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-10-09594e93cc9b@oss.nxp.com>
 <d3722347-031e-4a2f-8898-4f270cf1be05@denx.de>
 <PAXPR04MB96444B1F034449DFF881933AE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96444B1F034449DFF881933AE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/3/25 11:43 AM, Alice Guo (OSS) wrote:

Hi,

>>> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h index
>>> 2684f4177d..7ce73ddfae 100644
>>> --- a/include/scmi_protocols.h
>>> +++ b/include/scmi_protocols.h
>>> @@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
>>>     * @status:		SCMI command status
>>>     * @num_protocols:	Number of SCMI protocols in @protocol
>>>     * @protocols:		Array of packed SCMI protocol ID's
>>> + *
>>> + * The number of elements of @protocols is specified by callee-side.
>>> + Currently,
>>> + * set it to 4 is enough for i.MX95.
>>>     */
>>>    struct scmi_base_discover_list_protocols_out {
>>>    	s32 status;
>>>    	u32 num_protocols;
>>> -	u32 protocols[3];
>>> +	u32 protocols[4];
>>
>> Can this be made dynamic ? I think I already asked about this last time, but v4
>> feedback was not addressed, can you please double-check that v4 feedback ? I
>> will review next version once it is addressed .
> 
> Sorry for not replying to your comments for v4. I have just replied in v4 and want to discuss this change with you.
No worries, thanks.
