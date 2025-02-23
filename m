Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66336C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 10:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603E280FA4;
	Sun, 23 Feb 2025 11:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SyeRekWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F4980FBC; Sun, 23 Feb 2025 11:35:36 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0263880F67
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 11:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51NAZ8nc653038
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Feb 2025 04:35:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740306908;
 bh=LnPDLCRC2tBM1eCJYXsyYtVKS43/pai5ZQjXnkMUolY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SyeRekWZwxB6va2hPK29d8hRGeKnJoQHJ1gHYz/rRcGy7BT5xSPvqazI0F85e+340
 Mb8wC0bQZEuR5eynp5J9ID0PTWho9Cexkvl99IoEFMtDEWOIA2T0CGpOqwWBwhC0mW
 fNW09Ow8y14qEC254Ai6QpYVQlU+9fWrtS5a6bCQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51NAZ8GZ015337
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 23 Feb 2025 04:35:08 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 23
 Feb 2025 04:35:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 23 Feb 2025 04:35:07 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51NAYxZl096515;
 Sun, 23 Feb 2025 04:35:00 -0600
Message-ID: <d2f9214b-6b0a-4322-8a7a-a7628fd0cec6@ti.com>
Date: Sun, 23 Feb 2025 16:04:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] net: ti: am65-cpsw-nuss: Define and switch to
 bind method for CPSW driver
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "s-k6@ti.com" <s-k6@ti.com>, "afd@ti.com" <afd@ti.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "hnagalla@ti.com" <hnagalla@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kishon@ti.com" <kishon@ti.com>, "bb@ti.com" <bb@ti.com>,
 "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-3-c-vankar@ti.com>
 <f3d550a323fae44604d1d5c76053b86d2bf44fc8.camel@siemens.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <f3d550a323fae44604d1d5c76053b86d2bf44fc8.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Alexander and Roger,

On 20/02/25 01:18, Sverdlin, Alexander wrote:
> Hi Chintan!
> 
> On Wed, 2025-02-19 at 16:18 +0530, Chintan Vankar wrote:
>> CPSW driver is defined as UCLASS_MISC driver which needs to be probed
>> explicitly. Define bind method for CPSW driver to scan and bind
>> ethernet-ports with UCLASS_ETH driver which will eventually probe CPSW
>> driver and avoids probing CPSW driver explicitly.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is new in this series.
>>
>>   drivers/net/ti/am65-cpsw-nuss.c | 129 +++++++++++++++++++-------------
>>   1 file changed, 75 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>> index c70b42f6bcc..12c66095cce 100644
>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>> @@ -132,6 +132,7 @@ struct am65_cpsw_priv {
>>   	struct am65_cpsw_common	*cpsw_common;
>>   	u32			port_id;
>>   	struct phy_device	*phydev;
>> +	bool			probe_done;
>>   };
>>   
>>   #ifdef PKTSIZE_ALIGN
> 
> [...]
> 
>> @@ -675,6 +729,13 @@ static int am65_cpsw_port_probe(struct udevice *dev)
>>   	char portname[32];
>>   	int ret;
>>   
>> +	if (!priv->probe_done) {
>> +		ret = am65_cpsw_probe_nuss(dev->parent);
>> +		if (ret < 0)
>> +			return ret;
>> +		priv->probe_done = true;
>> +	}
>> +
> 
> So this particular port will probe the parent device only once... But what about the
> next port? Will it probe the same parent once again?
> 
> Is it actually necessary if device_probe() actually ensures, that all parents are
> being probed first?
> 
> The probe_done you invent is probably much better served with
> "dev_get_flags(dev) & DM_FLAG_ACTIVATED"?

Thank you Alexander for reviewing the patch and pointing out this since
I was not aware of dev->flags.

We can observe in device_probe() method that while probing a driver for
the dev we first check whether it's parents are probed or not. That is
also true for "am65_cpsw_port_probe" and that's why I don't think we
need to probe "am65_cpsw_probe_nuss" from it's child
am65_cpsw_port_probe since every time we probe child it's parent will
eventually get probed from device_probe method.

Also I have defined bind method by replacing a probe for
"am65_cpsw_probe_nuss" but also removed probe from the U_BOOT_DRIVER
definition by mistake, I will correct it in next version.

Let me know what you think.

Regards,
Chintan.

> 
>>   	priv->dev = dev;
>>   
>>   	cpsw_common = dev_get_priv(dev->parent);
> 
