Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74EFC282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7D7812BE;
	Mon,  3 Mar 2025 22:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039044;
	bh=Lb1p+BADrFsZ2IH7Ajzux1mgs/jxKiHJ1GFx3aTv0BQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lO+kimYmfYWdc5sEYg6Qr0RFpYbEG5/F9VaW3q1JFehgnb2G8R9Z7uGLTrcQ7wMJV
	 NXtUKDjAnw4unRkiYiDi4y9lJgfjKGcUFLCrmgK8tw5QpVCuL7BfEpO5o6Fs9l7RGY
	 7E15o+kAJfXx0oPs/opm+3JIhEwf0qPsm30O6HSmQnTDykgxgyeW8ZGYZfCi585IAE
	 BLEoFMxz8c3zJG6d4KKbIa3zZlAJxMNqrGpR3RmX2c3gDOxOsxYhvVJGMlL35Bm5UR
	 mpv4K7bU8RFICVOA/7PBgluPMLbB22OLg5d6Y/oc5DM/c3axIHLp1gCW8QQ8W9WSqD
	 iDdMXnhLHgF5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F714811C1; Mon,  3 Mar 2025 22:57:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFEB812BB
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="F/N5ricH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B75810381918; Mon,  3 Mar 2025 22:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Lb1p+BADrFsZ2IH7Ajzux1mgs/jxKiHJ1GFx3aTv0BQ=;
 b=F/N5ricHVwVjFQbd7PLA1563jvpctw1Pf3x7SeTKGOS7SW0GYEuxTeINqZ3hIQdiMG9jXA
 QB9r3ibcBr94uIkz3KehAfzBc6e4q4pfxCbpKUPtSoI4IoiKYOTi3OXUkZBw/RfhMrG6RI
 jxBG3xJq2QCLEEZz7Be/zSUYTdTu+c1wcft9pz3Vr5QGi5l7qf39FOHdUEuhAYCvaeTJDu
 sT4g5wZraTZBrmEcU0TM63CkW+RYrWfRtaGva2MibCehZJvP7Rajd/LkbbYSQqWWUH9ppu
 Pry2HmdN8xpOc5jHD32KJCpXE4wqevCkENsFfI9jjHywTN8VluUQ8Bf4FM9PxQ==
Message-ID: <e7dd64a4-2c85-46d7-802f-f55fff445455@denx.de>
Date: Mon, 3 Mar 2025 22:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY2IDAyLzIwXSBmaXJtd2FyZTogc2Nt?=
 =?UTF-8?Q?i=3A_smt=3A_Interrupt_communication_enable?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
 <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
 <PAXPR04MB964420C8F69517BDE8E406D6E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB964420C8F69517BDE8E406D6E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/3/25 3:51 AM, Alice Guo (OSS) wrote:

Hi,

>>> @@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct
>> scmi_smt *smt)
>>>    	if (!smt->buf)
>>>    		return -ENOMEM;
>>>
>>> +	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
>>> +		scmi_smt_enable_intr(smt, true);
>> Would it be possible to check DT /firmware/scmi node for compatible ==
>> "arm,scmi" and presence of "mboxes" property , and based on that , determine
>> that this is mailbox based SCMI ?
> 
> Hi Marek,
> 
> Do you mean that replace IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR) by checking "arm,scmi" and "mboxes" in device tree?
If that is possible, yes.
