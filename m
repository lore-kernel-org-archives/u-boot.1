Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B732C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907DE811C1;
	Tue,  4 Mar 2025 05:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tYDvmOqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FEAE81253; Tue,  4 Mar 2025 05:45:24 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7309B810ED
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5244jBxv3539672
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Mar 2025 22:45:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741063511;
 bh=SX3Br3/JlxV3zaLH3OsyP0anewdZ+rm6ESjk7B7KsYk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tYDvmOqX1tg7zOavq9kLZEvPTL9hz2zacMWN1b/WLviSeGQpB6fogsn9zUvkEMxD3
 wXges4CAo8mbwP6hpPxW4n9hak7IA93E4WMwB9Q31YTGyKtl0PIwicsbeXq9Dbw6Xf
 GqwPe68x4CmhqwL4vi7WytLlTd9CS3EyQsr/Mb38=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5244jBGI064541
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Mar 2025 22:45:11 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 22:45:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 22:45:10 -0600
Received: from [172.24.20.101] (lt5cd3168g9h.dhcp.ti.com [172.24.20.101])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5244j3x9050595;
 Mon, 3 Mar 2025 22:45:04 -0600
Message-ID: <a6ba6e19-3928-44c4-b69e-99dd994110ca@ti.com>
Date: Tue, 4 Mar 2025 10:15:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] net: ti: am65-cpsw-nuss: Define bind method for
 CPSW driver
To: Roger Quadros <rogerq@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar
 <danishanwar@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 "Santhosh Kumar K" <s-k6@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Neha
 Malcom Francis" <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Andrew Davis" <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, "Joao Paulo Goncalves"
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, "Jayesh Choudhary"
 <j-choudhary@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof"
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
References: <20250225114903.2080616-1-c-vankar@ti.com>
 <20250225114903.2080616-2-c-vankar@ti.com>
 <f9dd9299-0286-419f-a93a-794cf65a07f2@kernel.org>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <f9dd9299-0286-419f-a93a-794cf65a07f2@kernel.org>
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

Hello Roger,

On 2/27/2025 3:56 PM, Roger Quadros wrote:
> Hi,
> 
> On 25/02/2025 13:48, Chintan Vankar wrote:
>> CPSW driver is defined as UCLASS_MISC driver which needs to be probed
>> explicitly. Define bind method for CPSW driver to scan and bind
>> ethernet-ports with UCLASS_ETH driver which will eventually probe CPSW
>> driver and avoids probing CPSW driver explicitly.
> 
> Thank you for doing this. Overall it looks good. Just some cosmetic changes
> suggested below.
> 

Thank you for reviewing the series, I will make the changes mentioned by
you and post next version.

Regards,
Chintan.

>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v2:
>> https://lore.kernel.org/r/20250219104831.2315464-3-c-vankar@ti.com/
>>
>> Changes from v2 to v3:
>> - Removed if condition not required in CPSW driver as suggested by
>>    Alexander Sverdlin.
>>
>>   drivers/net/ti/am65-cpsw-nuss.c | 120 ++++++++++++++++++--------------
>>   1 file changed, 67 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>> index c70b42f6bcc..10513cf92f2 100644
>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>> @@ -667,6 +667,59 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
>>   	return 0;
>>   }
>>   
>> +static int am65_cpsw_probe_nuss(struct udevice *dev)
>> +{
>> +	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
>> +	int ret, i;
>> +
>> +	cpsw_common->dev = dev;
>> +	cpsw_common->ss_base = dev_read_addr(dev);
>> +	if (cpsw_common->ss_base == FDT_ADDR_T_NONE)
>> +		return -EINVAL;
>> +
>> +	ret = power_domain_get_by_index(dev, &cpsw_common->pwrdmn, 0);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get pwrdmn: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_get_by_name(dev, "fck", &cpsw_common->fclk);
>> +	if (ret) {
>> +		power_domain_free(&cpsw_common->pwrdmn);
>> +		dev_err(dev, "failed to get clock %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	cpsw_common->cpsw_base = cpsw_common->ss_base + AM65_CPSW_CPSW_NU_BASE;
>> +	cpsw_common->ale_base = cpsw_common->cpsw_base +
>> +				AM65_CPSW_CPSW_NU_ALE_BASE;
>> +
>> +	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
>> +		struct am65_cpsw_port *port = &cpsw_common->ports[i];
>> +
>> +		port->port_base = cpsw_common->cpsw_base +
>> +				  AM65_CPSW_CPSW_NU_PORTS_OFFSET +
>> +				  (i * AM65_CPSW_CPSW_NU_PORTS_OFFSET);
>> +		port->port_sgmii_base = cpsw_common->ss_base +
>> +					(i * AM65_CPSW_SGMII_BASE);
>> +		port->macsl_base = port->port_base +
>> +				   AM65_CPSW_CPSW_NU_PORT_MACSL_OFFSET;
>> +	}
>> +
>> +	cpsw_common->bus_freq =
>> +			dev_read_u32_default(dev, "bus_freq",
>> +					     AM65_CPSW_MDIO_BUS_FREQ_DEF);
>> +
>> +	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u\n",
>> +		 readl(cpsw_common->ss_base),
>> +		 readl(cpsw_common->cpsw_base),
>> +		 readl(cpsw_common->ale_base),
>> +		 cpsw_common->port_num);
>> +
>> +	power_domain_free(&cpsw_common->pwrdmn);
>> +	return ret;
>> +}
>> +
> 
> Instead of moving the am65_cpsw_probe_nuss() please leave it where it was
> and add the new am65_cpsw_nuss_bind() after it.
> This way it will show only what really changed in diff and is easier to review.
> 
>>   static int am65_cpsw_port_probe(struct udevice *dev)
>>   {
>>   	struct am65_cpsw_priv *priv = dev_get_priv(dev);
>> @@ -697,45 +750,30 @@ out:
>>   	return ret;
>>   }
>>   
>> -static int am65_cpsw_probe_nuss(struct udevice *dev)
>> +static int am65_cpsw_nuss_bind(struct udevice *dev)
>>   {
>>   	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
>> -	ofnode ports_np, node;
>> -	int ret, i;
>> +	struct uclass_driver *drv;
>>   	struct udevice *port_dev;
>> +	ofnode ports_np, node;
>> +	int ret;
>>   
>> -	cpsw_common->dev = dev;
>> -	cpsw_common->ss_base = dev_read_addr(dev);
>> -	if (cpsw_common->ss_base == FDT_ADDR_T_NONE)
>> -		return -EINVAL;
>> -
>> -	ret = power_domain_get_by_index(dev, &cpsw_common->pwrdmn, 0);
>> -	if (ret) {
>> -		dev_err(dev, "failed to get pwrdmn: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = clk_get_by_name(dev, "fck", &cpsw_common->fclk);
>> -	if (ret) {
>> -		power_domain_free(&cpsw_common->pwrdmn);
>> -		dev_err(dev, "failed to get clock %d\n", ret);
>> -		return ret;
>> +	drv = lists_uclass_lookup(UCLASS_ETH);
>> +	if (!drv) {
>> +		puts("Cannot find eth driver");
>> +		return -ENOENT;
> 
> I'm not sure why this check is required.
> drv is not used anywhere.
>  >>   	}
>>   
>> -	cpsw_common->cpsw_base = cpsw_common->ss_base + AM65_CPSW_CPSW_NU_BASE;
>> -	cpsw_common->ale_base = cpsw_common->cpsw_base +
>> -				AM65_CPSW_CPSW_NU_ALE_BASE;
>> -
>> +	cpsw_common->dev = dev;
>>   	ports_np = dev_read_subnode(dev, "ethernet-ports");
>>   	if (!ofnode_valid(ports_np)) {
>> -		ret = -ENOENT;
>> -		goto out;
>> +		return -ENOENT;
>>   	}
>>   
>>   	ofnode_for_each_subnode(node, ports_np) {
>>   		const char *node_name;
>> -		u32 port_id;
>>   		bool disabled;
>> +		u32 port_id;
>>   
>>   		node_name = ofnode_get_name(node);
>>   
>> @@ -745,14 +783,13 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
>>   		if (ret) {
>>   			dev_err(dev, "%s: failed to get port_id (%d)\n",
>>   				node_name, ret);
>> -			goto out;
>> +			return ret;
>>   		}
>>   
>>   		if (port_id >= AM65_CPSW_CPSWNU_MAX_PORTS) {
>>   			dev_err(dev, "%s: invalid port_id (%d)\n",
>>   				node_name, port_id);
>> -			ret = -EINVAL;
>> -			goto out;
>> +			return -EINVAL;
>>   		}
>>   		cpsw_common->port_num++;
>>   
>> @@ -768,30 +805,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
>>   			dev_err(dev, "Failed to bind to %s node\n", ofnode_get_name(node));
>>   	}
>>   
>> -	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
>> -		struct am65_cpsw_port *port = &cpsw_common->ports[i];
>> -
>> -		port->port_base = cpsw_common->cpsw_base +
>> -				  AM65_CPSW_CPSW_NU_PORTS_OFFSET +
>> -				  (i * AM65_CPSW_CPSW_NU_PORTS_OFFSET);
>> -		port->port_sgmii_base = cpsw_common->ss_base +
>> -					(i * AM65_CPSW_SGMII_BASE);
>> -		port->macsl_base = port->port_base +
>> -				   AM65_CPSW_CPSW_NU_PORT_MACSL_OFFSET;
>> -	}
>> -
>> -	cpsw_common->bus_freq =
>> -			dev_read_u32_default(dev, "bus_freq",
>> -					     AM65_CPSW_MDIO_BUS_FREQ_DEF);
>> -
>> -	dev_info(dev, "K3 CPSW: nuss_ver: 0x%08X cpsw_ver: 0x%08X ale_ver: 0x%08X Ports:%u\n",
>> -		 readl(cpsw_common->ss_base),
>> -		 readl(cpsw_common->cpsw_base),
>> -		 readl(cpsw_common->ale_base),
>> -		 cpsw_common->port_num);
>> -
>> -out:
>> -	power_domain_free(&cpsw_common->pwrdmn);
>>   	return ret;
>>   }
>>   
>> @@ -806,6 +819,7 @@ U_BOOT_DRIVER(am65_cpsw_nuss) = {
>>   	.name	= "am65_cpsw_nuss",
>>   	.id	= UCLASS_MISC,
>>   	.of_match = am65_cpsw_nuss_ids,
>> +	.bind	= am65_cpsw_nuss_bind,
>>   	.probe	= am65_cpsw_probe_nuss,
>>   	.priv_auto = sizeof(struct am65_cpsw_common),
>>   };
> 
