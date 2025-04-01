Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3A2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11ECC820EA;
	Tue,  1 Apr 2025 14:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743511996;
	bh=FW5N7rnhCi1eH1r45WFvrkuEuZBq6PKgHxDooopJBDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hn2ozvjlV95N+jFREgNuo5zstliSBcfgPknBWjeT4CvZPiB/+ImclXtFlM1vv7PbX
	 mrUPC0rzL6AueFaYcchRT4PWK59WmzaOzEhe+Ws0N2/2r4GJydrxZ83RMjpH4/GoW5
	 tym/4p0jQm5FyarPrRly/9qlrSgD2jS0LZMvONm/92QJYae5PYHHkGduPHRBXOb4GO
	 66iOBJ0dGIefV/taucrCkC6CfCldM8SoLSmfYwtgSVCST6Rt1YFUGpG3zcwuqz7CWn
	 VTG7h1xwGqpujIanQmCQRUo5zkO0NEfxLOfPbqu4QyKYuTn4jlbpLbS9+Yn9PWZyWb
	 F6NREMNx4rARQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2509B820F0; Tue,  1 Apr 2025 14:53:15 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21639820E1
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="a+VeQ7kI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59FEB1026C1DB; 
 Tue,  1 Apr 2025 14:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743511992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FW5N7rnhCi1eH1r45WFvrkuEuZBq6PKgHxDooopJBDE=;
 b=a+VeQ7kIzegBQE6znACuDpE6949K2EI3hAAKkem1tkqKxxN8oEh4JWVntAPuLlSwkup2vM
 s4N4DaoDTPHxWjtc5A9U3tpg7qnXyMagWNCC9DOiQrB0iMUeaE9XMw9bkQ9b3Su6EntFlj
 V5MN29JMcAT6JlOcc9RkyQ5pZRxlH8mzanRpdXxE+IynvtdqPDWmGkcG7TBpZuyujyX5pM
 Lik5c+/PYlPz/3yk/xLHj0/DnxfO+LiRx/n6+V06nP21qW25cUk/m4seckkpUjAMPmcYDR
 RYvBhodsY0Oebkr7aEtHOvxQT/hXVG/nJESvF0r1AJnEaQVgDnohwh6ncaKkkA==
Message-ID: <a3007174-30a8-4dc2-ab7f-da1c1de52440@denx.de>
Date: Tue, 1 Apr 2025 14:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6?=
 =?UTF-8?Q?_add_a_pin_controller_driver_based_on_SCMI_pin_control_protocol?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
 <PAXPR04MB8459F46041C7EFF7191F8EFD88A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bbb8ecca-789d-40cc-93a8-e7284e1af840@denx.de>
 <PAXPR04MB96445CAACB6E8413A03CA386E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96445CAACB6E8413A03CA386E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 4/1/25 12:57 PM, Alice Guo (OSS) wrote:

Hello Alice,

>>>>> Both use same ID 0x19.
>>>>>
>>>>> It is fine to use below, if it is fine to you.
>>>>> SCMI_PROTOCOL_ID_PINCTRL_IMX = 0x19.
>>>> How does the kernel discern which driver it should use to communicate
>>>> with the SCMI provider if both drivers are compiled into the kernel ?
>>>
>>> There is a check in drivers probe. Only one will succeed.
>>
>> I have to admit, this is just ... uhhh :(
>>
>> But I think now, we should also have a driver-side check and two separate
>> drivers, similar to this patch:
>>
>> [PATCH] power: regulator: scmi: Move regulator subnode hack to
>> scmi_regulator
> 
> Hi Marek,
> 
> When will this patch "[PATCH] power: regulator: scmi: Move regulator subnode hack to scmi_regulator" be applied to the uboot next branch? I have already made the next version patch set based on this patch.
Fabio/Tom ?
