Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23702C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6660D82D1A;
	Wed, 16 Apr 2025 11:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uMROLdgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36BE82D1B; Wed, 16 Apr 2025 11:50:40 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1468882D05
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G9oIG3280615
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 04:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744797018;
 bh=CUPl3cN+uRgp0BBKMclR9BjyR8YPgQJi0Yw4bDVZHL0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uMROLdgfiifHoaX8FGPKoAYmpNZVadKVLscAywCY8lua9ahwROt1Tku64wxtrdKd9
 Od/xhq7aFXSD5tjQwGQgmIvehHVjwAX620usTBv8+c0N61jH19C77hyxJdz+Zxt/c0
 q6X4xwiPQjUgYHTu//shs4QnTPP1ZaqjWrc085ck=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G9oIpD089609
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 04:50:18 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 04:50:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 04:50:17 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G9oCfd104575;
 Wed, 16 Apr 2025 04:50:13 -0500
Message-ID: <7f87c129-b949-493a-9df7-26e9caf9d58e@ti.com>
Date: Wed, 16 Apr 2025 15:20:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>
CC: Samuel Holland <samuel.holland@sifive.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
 <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com> <87o6wwv5ke.fsf@bootlin.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <87o6wwv5ke.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Miquel

On 16/04/25 14:36, Miquel Raynal wrote:
> Hello,
> 
>>>> -int power_domain_on(struct power_domain *power_domain)
>>>> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>>>>  {
>>>> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>>>>  	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
>>>> +	int ret;
>>>>  
>>>>  	debug("%s(power_domain=%p)\n", __func__, power_domain);
>>>>  
>>>> -	return ops->on ? ops->on(power_domain) : 0;
>>>> +	if (priv->on_count++ > 0)
>>>> +		return -EALREADY;
>>>
>>> This change is broken for power domain providers with #power-domain-cells = <1>,
>>> which can have multiple domains per provider device. There would need to be a
>>> separate reference count per domain, and currently the uclass doesn't know the
>>> range of valid domain IDs.
>>
>> I didn't see this reply earlier, would've saved some time debugging to
>> come to the same conclusion :) but yes this is the reason for
>> breaking.
> 
> That's indeed the reason, thanks a lot for figuring this out. I am
> looking for a solution. I can reproduce on imx8mp by enabling the two
> LCD interfaces, as they have a similar pattern as on k3 platform: a
> single power domain node and one cell for figuring out which PD to
> enable.
> 
> The uclass does not save any data, so I don't have an immediate fix to
> propose. Let me dig a bit more into that and find a solution.
> 

Thanks!

Meanwhile, could we revert this patch to keep the platforms from breaking?


> Thanks,
> Miquèl

-- 
Thanking You
Neha Malcom Francis
