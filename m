Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1354C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F168144A;
	Mon,  3 Mar 2025 22:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039048;
	bh=4Qh6ZqLBabKMXMeospUcOmwo02erx5dArIQQG584f3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hjm9LYDfI1xH+hq11AtVoaNo9ZpnA1zshpruQcHJp4GukLIMIlphL/gy8Fn0tcjOs
	 HCEFxzpEPAB30Y4tCVooM5qBGVPSgA6JV1UHw/PLfO3ebGVzdF6JTDCYMHPXR9KBWc
	 a/0gleT1gFEUb3EaG6MZc75ytifBSxTsqbrHy5vVMQp3ueP8Dcmnpjor25jXFKrGyE
	 /kkb69c7tNaB/xZ6xhOqerHfIVUS3ZvkCoono9ulTBlTK1DPBREioqrt7MgF5AE5Kj
	 xUsPm37nmnj5rlkUhKWY5Z+r8BdmqHq1/5wdzyFo+eJykKEcVLYjFPc+/UkOoVZoCl
	 2R4LeJFT4FBkw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE52D8142D; Mon,  3 Mar 2025 22:57:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA53E812D8
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aP9Zc0qd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 91D6C10381918; Mon,  3 Mar 2025 22:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4Qh6ZqLBabKMXMeospUcOmwo02erx5dArIQQG584f3k=;
 b=aP9Zc0qd4FMKIOGr2weNIE6DLbL6Qdcbqt7j7zV6KaxYAs85EZ1GpRn2HmmqIY97esttKl
 rR5HFxfdmssfjGZjFwM4TdvcypN/SKkDPCL93DU68Q9daaCRUcXTtjsBgUEGDBlP+pI5tL
 zK9T/sLA0FSzgapeXLZAIBoi2IllvGX4SDworIEyTqN2vsVPKYkUtcDZI74NYNc6hzE30H
 hgtmBrJh54qgd+FIvUN6ZEezFElCVMd0Pyn7XNCl0gRDBA+HDUqU9/9/fYdVBER6JwaZ9T
 gJdSyf+BYKGyjvppbVas4spT/7D1gX59MFMECFruNihWN57GJ9Q8vyjjxBIOKg==
Message-ID: <bbb36873-7351-4b00-ae2b-be24d9cab960@denx.de>
Date: Mon, 3 Mar 2025 22:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY2IDAzLzIwXSBwaW5jdHJsOiBueHA6?=
 =?UTF-8?Q?_add_a_pin_controller_driver_based_on_SCMI_pin_control_protocol?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-3-09594e93cc9b@oss.nxp.com>
 <5d0f1b3c-02ec-416d-b566-2cc8f44576df@denx.de>
 <PAXPR04MB9644735B4D9568DEB0218133E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644735B4D9568DEB0218133E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/3/25 7:28 AM, Alice Guo (OSS) wrote:

[...]

>>> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h index
>>> 7abb2a6f36..279ebbad44 100644
>>> --- a/include/scmi_protocols.h
>>> +++ b/include/scmi_protocols.h
>>> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>>>    	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>>>    	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>>>    	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
>>> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
>> This is the custom iMX specific pinctrl protocol, isn't it ?
> 
> Hi Marek,
> 
> Protocol id 0x19 is not i.MX specific, and it is defined in Arm® System Control and Management Interface Platform Design Document Non-Confidential Version 3.2.
> 
> For pin control protocol, drivers/pinctrl/nxp/pinctrl-scmi.c are used on i.MX95.
I replied to previous version of this and outlined how this can be 
implemented using some U_BOOT_SCMI_DRIVER() and linker lists, that 
should help.
