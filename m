Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1130CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B44E833C0;
	Thu, 11 Sep 2025 14:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="Za+57eoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4387E8331F; Thu, 11 Sep 2025 11:50:45 +0200 (CEST)
Received: from send150.i.mail.ru (send150.i.mail.ru [89.221.237.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD6A83314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=k9IV2aSRgiQqd1MQtWxw0Lgo5IPwCzOqAQ7Srl4gDYw=; t=1757584243; x=1757674243; 
 b=Za+57eoDlQtpurZuCJCpQFmvCgq4kYqQZ7NelJHhcU0Vw0Szo30/zefwdAHkkNS1c5VL1YpaKFa
 Dfg3hMxD3IRs8slylYxWmCmZ2NgeOOlNoZLAMGBmpQYcM2+/7aRD955bMO3dXYY/GGHcxge5RqYnv
 eLg7yf8W1jhKXSYjD73+hpUifRdqukvMLU/Tbf9yzYkj3w19X5mMUdm//GeONMaXa/IAoiqRnhQLC
 lNoYP/UqdZ4WAUMm0KqnwBdYiClpe0E1emqlnPVlb33h5mFO0hHN4RdwsbDGULfccLLsiAeOfMH1I
 LguLXKQJ405rfFo75cBOZCs8hC7slEtGMY9g==;
Received: by exim-smtp-6658775494-d57j7 with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1uwdwv-0000000056R-3X9X; Thu, 11 Sep 2025 12:50:42 +0300
Message-ID: <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
Date: Thu, 11 Sep 2025 12:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
To: Dhruva Gole <d-gole@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
 <20250909101806.bymqunywxu6pe33o@lcpd911>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20250909101806.bymqunywxu6pe33o@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-6658775494-d57j7;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD99F281FB5F96F126D008904DA4BD8908277003BBE922654C100894C459B0CD1B9087C847916E27C36D27678DDAA806314974094F66C44092C6F787B7047A127BCE2602FFE9E909B31
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79961E86438F5BDAEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A5F354E88FC47EC0160D405D5D9A1AEE950D29DF6EEA7C077A8F7A1A50D27BD18EEF46B7454FC60B9742502CCDD46D0DD23BF7408B3F9022F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249197FFA0EFC27E0ACA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FE5D25F19253116ADD2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A45692FFBBD75A6A089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A529C8C473668342865002B1117B3ED69667C41D9F6D5B1E83886DC9BC01168B20823CB91A9FED034534781492E4B8EEAD8D8BB953E4894305BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF296067EE738F6C5187EFE35B08B7D312F3AA8B5D72B26FD7047A58B9583F7F0D17059C39C4D6624203AE5C37BC66C62903F69E1AD639AD74DB9F1FFAECD24605F730B7BD328DEB74034D55ECCE8C67C6913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVdVMtzNxwZu5hRKmhlU8zVE=
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB63FE083C6957295E4C8554DCF9C70F3C6C9BD47F8CC6B439A90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

09.09.2025 13:18, Dhruva Gole wrote:
> On Aug 25, 2025 at 16:49:30 +0300, Maxim Kochetkov wrote:
>> 19.08.2025 10:33, Kamlesh Gurudasani wrote:
>>> Clock version 3.0 specified in ARM SCMI Platform design document
>>> v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
>>>
>>> The SCMI server with clock version 3.0 rejects the message if
>>> they don't have this field.
>>>
>>> Add support so that both SCMI server with clock version 2.0 and 3.0
>>> can be handled.
>>>
>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>> ---
>>>    drivers/clk/clk_scmi.c   | 43 ++++++++++++++++++++++++++++++-------------
>>>    include/scmi_protocols.h |  6 ++++++
>>>    2 files changed, 36 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>>> index 83ea7bb4286..b33cc05685d 100644
>>> --- a/drivers/clk/clk_scmi.c
>>> +++ b/drivers/clk/clk_scmi.c
>>> @@ -131,19 +131,36 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>>>    static int scmi_clk_gate(struct clk *clk, int enable)
>>>    {
>>> -	struct scmi_clk_state_in in = {
>>> -		.clock_id = clk_get_id(clk),
>>> -		.attributes = enable,
>>> -	};
>>> +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
>>
>> struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
>>
> 
> Could you elaborate?
> I think clk->dev should be fine, similar to other instances in the same
> file. Maybe I am missing something?
> 

clk->dev points to hw clock device. It has no struct scmi_clock_priv
stored in priv data. So we have to step up to parent device to get SCMI
protocol device to get struct scmi_clock_priv to get protocol version
priv->version.

