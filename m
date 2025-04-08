Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57085C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 18:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0EB8210F;
	Tue,  8 Apr 2025 20:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744137187;
	bh=EIOw8jbJFx0/hipNJStChXH+NlSG/ulD2MARjCy8iOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tptRi+yCDxH+HOpwL/z1BSMsBSTaV5mFgBhJtTWPH8hT0efRv7EKLYCwIHQwHoMbN
	 xGOMAOQImGnZegHHbFMvZemO+2rsZu61VZ5oZsUH+GFa0Rzt+SFdEx3fvSgyJM+J+g
	 dHlCk3UOvfB+LFGl1Zvm1DtrBQNne9Rvx6QfXifGUxzeh3d1uOncGNIfGIGmh6t1T/
	 HW1jIP4Svqo+zyd5Uh0YkIPpvjxaEXv5YnXcwPsjVvAUEkMZ+OULdwrjbO3mTwO7Aq
	 Z86qtM/xQ6dKktwFpmqxjja0v/BeBw1ufhOxi/oUi5z0TQw+Zc41xSivgQv0fBe4gz
	 s5TaGKUhtVmCA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F868211F; Tue,  8 Apr 2025 20:33:06 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4808210D
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 20:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AEkf5ryh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 93797102EB9FE; 
 Tue,  8 Apr 2025 20:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744137183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=EIOw8jbJFx0/hipNJStChXH+NlSG/ulD2MARjCy8iOE=;
 b=AEkf5ryhc5SFwV0anQ+T2Sb6098TYXXXqwEDSA4h0I3R6qymqiHqQUyBCSwPS0UnVjXBva
 F5UM1aI0TvKuUno1ZyvbbPnV9yfll+aWg0Yr95ngMFnvA0fNQ0lm0zGdNQLp6FJ/Td4/DL
 xsbN6bP/CJRTjuZxWZQHKur9kTP94O7QUR+W6batoBXtoluIS9oQ4tIjK81cJS0SO3e48K
 WE4HOXEWL/DmrxBAZ8PenhrTx2aRNJX7uIJvPsWljxmwFoqWKDLOwW2vORODtkEb25lc4g
 y3eTlpB2e3TEiNzLnfV2AZyjI16r1ALMpaxFFNAzQ/WlMW6rkpKA494v6HA37w==
Message-ID: <4db49cb4-bb80-4aa8-958b-a5b14f0d22d4@denx.de>
Date: Tue, 8 Apr 2025 20:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gW1BBVENIXSBwb3dlcjogcmVndWxhdG9y?=
 =?UTF-8?Q?=3A_scmi=3A_Move_regulator_subnode_hack_to_scmi=5Fregulator?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <20250322014444.174796-1-marex@denx.de>
 <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 4/3/25 12:56 PM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年3月22日 9:45
>> 收件人: u-boot@lists.denx.de
>> 抄送: Marek Vasut <marex@denx.de>; Alice Guo <alice.guo@nxp.com>; Ilias
>> Apalodimas <ilias.apalodimas@linaro.org>; Jaehoon Chung
>> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
>> 主题: [EXT] [PATCH] power: regulator: scmi: Move regulator subnode hack to
>> scmi_regulator
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> The current code attempts to bind scmi_voltage_domain to regulator subnode
>> of the SCMI protocol node, so scmi_voltage_domain can then bind regulators
>> directly to subnodes of its node. This kind of behavior should not be in core code,
>> move it into scmi_voltage_domain driver code. Let the driver descend into
>> regulator node and bind regulators to its subnodes.
>>
>> Fixes: 1f213ee4dbf2 ("firmware: scmi: voltage regulator")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/firmware/scmi/scmi_agent-uclass.c | 8 +-------
>> drivers/power/regulator/scmi_regulator.c  | 6 ++++++
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c
>> b/drivers/firmware/scmi/scmi_agent-uclass.c
>> index 8c907c3b032..e6e43ae936a 100644
>> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
>> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
>> @@ -427,14 +427,8 @@ static int scmi_bind_protocols(struct udevice *dev)
>>                          break;
>>                  case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>>                          if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
>> &&
>> -                           scmi_protocol_is_supported(dev, protocol_id))
>> {
>> -                               node = ofnode_find_subnode(node,
>> "regulators");
>> -                               if (!ofnode_valid(node)) {
>> -                                       dev_err(dev, "no regulators
>> node\n");
>> -                                       return -ENXIO;
>> -                               }
>> +                           scmi_protocol_is_supported(dev,
>> + protocol_id))
>>                                  drv =
>> DM_DRIVER_GET(scmi_voltage_domain);
>> -                       }
>>                          break;
>>                  default:
>>                          break;
>> diff --git a/drivers/power/regulator/scmi_regulator.c
>> b/drivers/power/regulator/scmi_regulator.c
>> index 99f6506f162..2550b27246f 100644
>> --- a/drivers/power/regulator/scmi_regulator.c
>> +++ b/drivers/power/regulator/scmi_regulator.c
>> @@ -178,6 +178,12 @@ static int scmi_regulator_bind(struct udevice *dev)
>>          ofnode node;
>>          int ret;
>>
>> +       node = ofnode_find_subnode(node, "regulators");
>> +       if (!ofnode_valid(node)) {
>> +               dev_err(dev, "no regulators node\n");
>> +               return -ENXIO;
>> +       }
>> +
>>          drv = DM_DRIVER_GET(scmi_regulator);
>>
>>          ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>> --
>> 2.47.2
> 
> Hi Marek,
> 
> Is there a problem in your patch? Should it be changed like this:
What kind of problem ? Can you please elaborate ?
