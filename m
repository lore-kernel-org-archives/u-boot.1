Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A5FC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 21:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8DC80F9C;
	Sun, 30 Mar 2025 23:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743368712;
	bh=C5WRsM6rAmlqwz6O/egLzPyU09i/rDfPrJXaoyu4Nfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFpyfOkWePJv0L542yYnrbqqziYoUMmo2+e/nuc4CqVE3x+2++IS/PMR8Xcx80fEm
	 3VRhI1p9IWlvGlmiDITHhW75NBtIqPfz3b8iJmYnpbLBN1/rAUaop1WtrOKFJU0f5N
	 9qWM7X6qAM9hkN2+bKbjxfeldt3CajRiYcymjisBRQhKQJDxT3kj1xpr45376/Wl7m
	 eK9QjQcpVPfQXxkUKGptmNjnCpbu6H5csSzwaiw/k/E9TxIPCrW9WV5DQfoHlCR6L6
	 X26zY4zVHH3bDeXA92QyEeTOAob2VMqFxiesmhj0wYecoomIQc34g3ltjnu4H9iJXd
	 qrlexKxmAecyw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D23280FDA; Sun, 30 Mar 2025 23:05:10 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E799800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NFLtLT0q"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7ABC5102F66E1; 
 Sun, 30 Mar 2025 23:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743368707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=C5WRsM6rAmlqwz6O/egLzPyU09i/rDfPrJXaoyu4Nfo=;
 b=NFLtLT0qiCVcbzFvZJcqkf+RqrSduGu9/qf71LkDhciF+6Lwr1q/yS2U/fmfrvQ9QXFYk8
 r8DVNEuXFwswNeVkfEl/HeFhxFpYom/uln88ID6irjWn18gPAp4leTPMHbJTSPn3/B/VVn
 qd5YoW/v2mudJNWEuomgCTZwc+qE0mwFVk/RWP7V6Nj9EepEgfvy41mfki8yXP2jbDhRdY
 AZ0VKzoweslsSQ4R+8Q/b6ANKvz4OE5TBqqeE6EMNs/pzlWItP/7c9sRIoT4CQrvglcM8X
 KwnZeBe+f9FtEgj3DlfFJ3RoaMeYl2oF4Qv/z61vXszyifQtb5F2iJhXz9MgQg==
Message-ID: <0c95ffa8-b26f-40fb-b4f6-4beabef3fb53@denx.de>
Date: Sun, 30 Mar 2025 23:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY4IDA3LzE5XSBjbGs6IHNjbWk6IGNo?=
 =?UTF-8?Q?eck_the_clock_state/parent/rate_control_permissions?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-7-f2c8ba815f89@oss.nxp.com>
 <78f7d9f2-6226-49bb-8568-41e7ca0cdaba@denx.de>
 <PAXPR04MB9644F826CFC88160CF9CF2EBE2A02@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644F826CFC88160CF9CF2EBE2A02@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/28/25 11:26 AM, Alice Guo (OSS) wrote:

Hello Alice,

>>>    enum scmi_clock_message_id {
>>>    	SCMI_CLOCK_ATTRIBUTES = 0x3,
>>> @@ -738,6 +739,7 @@ enum scmi_clock_message_id {
>>>    	SCMI_CLOCK_RATE_GET = 0x6,
>>>    	SCMI_CLOCK_CONFIG_SET = 0x7,
>>>    	SCMI_CLOCK_PARENT_SET = 0xD,
>>> +	SCMI_CLOCK_GET_PERMISSIONS = 0xF,
>>
>> Better call it SCMI_CLOCK_PERMISSIONS_GET to be consistent with the rest of
>> these fields , unless this is some SCMI specification name ?
> 
> CLOCK_GET_PERMISSIONS is from Arm System Control and Management Interface Platform Design Document 3.2.
Understood, please note it in the commit message .

Thank you.
