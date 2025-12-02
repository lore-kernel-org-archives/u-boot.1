Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EBFCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 07:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F77883E0E;
	Tue,  2 Dec 2025 08:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Cf8MjpZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D118483E0F; Tue,  2 Dec 2025 08:53:37 +0100 (CET)
Received: from mx-relay61-hz1.antispameurope.com
 (mx-relay61-hz1.antispameurope.com [94.100.132.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8CA83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 08:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=042460c183=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate61-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=wtbKpxWiGiaww6mgoYyhxtPgB2YELq+sfox4Lenebtg=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764662014;
 b=BvEoYDlD3TBJHlGHF8z13tLD38WdjIx5wxD0staipk6pP2W57xVJNItE4cdW8EG/nCqOwYrW
 zl+wtfZ5VQMaIlUpAjQMsoul3YpSbljdBLy/wQagyc6YZOyH96MXQCz3Yxsa2lbviXcGvF+9n9x
 8HMZ6BcGfMYcR+zhGCVo2flU/1i/FcrqPcs/XOS1GMgwzINS5AKBayIwhnCvAz4hUSCh1/ghP7u
 MLn9y1fKowozeubXRBXD9uhQu+V0vD0NdrZBH37IRnpmQu9GDyv4v3R+HOHmlwuILYRsMEem5eY
 HsgC/L2pUAyCiSt0QwJVl+vhfeYucTJt0RvfwlVyLJDlA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764662014;
 b=hfqQ2DaHtxDYzb5YQEExi2af4CXPd8JtYsNv1+HaluwVxbvdU3uSRDckcP76JBJT+lbBQ/8r
 dxri07kJGzKbHCCwx7A/tQr+KBGnjIJUMyHHEwyf0CcQDcD+Wc/WbpwnuOovaAWU19oc6GH9h5V
 hu+6jXBNAWM9TM94ey7tZN7uS1HzDZ1ML5NzQLP/mIKS+pEp2Bp+gDe/rXLDHABSSGLMU92M3vL
 xsTbhsinKb75oFAGgb82NJOC2ZeRkQeIEFiA1GrbxZte4ogzqADiFjui8UnltrQSU3vOzXyVtG5
 1EQoM9FJay05rzCDagH70RqaRIs1XdPcj3ZXkT8hRfLRw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay61-hz1.antispameurope.com; Tue, 02 Dec 2025 08:53:34 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 27DA95A07F0;
 Tue,  2 Dec 2025 08:53:20 +0100 (CET)
Message-ID: <20a53453-29fb-4e22-84e3-358297d2ce1b@ew.tq-group.com>
Date: Tue, 2 Dec 2025 08:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: phy: micrel_ksz90x1: disable asymmetric pause
 for KSZ9031
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
References: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
 <20251121081810.73852-2-Max.Merchel@ew.tq-group.com>
 <5bfefc10-b58f-4235-83ee-209237c4a2e2@cherry.de>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <5bfefc10-b58f-4235-83ee-209237c4a2e2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay61-hz1.antispameurope.com with 4dLCgh5G6qz2gW2Z
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 1a5381ad0cb83e26800bd54ed2da9703
X-cloud-security: scantime:2.192
DKIM-Signature: a=rsa-sha256;
 bh=wtbKpxWiGiaww6mgoYyhxtPgB2YELq+sfox4Lenebtg=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764662014; v=1;
 b=Cf8MjpZkf5NHXvI9B70o1cryBoV2F/4+Z5SmNPVPy3co8aju0IBCB2e3Cp2SSeZzpeQOMIq+
 W/2WRI/9Xvfrf2lK013VGob+U/kceIuEhvxB1TbKg4oBxLWPn+LsLfCkcjFhM/JG1/RZnJHIVF2
 3F5pdBhF0EienzS2h84TwLlGCE/V+QS1s8Np+FGxsw8miiXrBGI65fQwmBp9eew3UEPqE0RiP0y
 hiU6hHGHyT7B2fCsSQpuFobKiaGIEl7LhwPphZadp5ZgC0ahM4jK9TIorJeBKw7WTxU69w9t8b4
 48aGIwg9UwQJB17WYmdZzFXFlb13GV/NUwsdH6O3QOXfw==
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



Am 24.11.25 um 17:31 schrieb Quentin Schulz:
> Hi Max, Markus,
> 
> On 11/21/25 9:18 AM, Max Merchel wrote:
>> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>>
>> Disable the support due to chip errata and call genphy_config_aneg
>> instead of genphy_config. For a complete describtion look at the
>> errata sheets: DS80000691D or DS80000692D.
>>
> 
> Linux counterpart seems to be 3aed3e2a143c ("net: phy: micrel: add Asym 
> Pause workaround"). It does seem to set an additional bit 
> (ADVERTISE_PAUSE_CAP in U-Boot) but the explanation doesn't seem to 
> apply to U-Boot.

I checked ADVERTISE_PAUSE_CAP in the code and ran tests on TQMa6-MBa6. 
Setting ADVERTISE_PAUSE_CAP isn't necessary for the workaround.

> 
> Though another interesting commit is in the Linux tree as well, 
> 407d8098cb1a ("net: phy: micrel: add Asym Pause workaround for 
> KSZ9021"). I assume we need a similar fix in ksz9021_config()?

I will integrate the workaround for KSZ9021 into the commit in V2 and 
add references to both Linux commits.

>> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
>> ---
>>   drivers/net/phy/micrel_ksz90x1.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/ 
>> micrel_ksz90x1.c
>> index a02dbe900b8..bc42506c65e 100644
>> --- a/drivers/net/phy/micrel_ksz90x1.c
>> +++ b/drivers/net/phy/micrel_ksz90x1.c
>> @@ -336,6 +336,7 @@ static int ksz9031_phy_extwrite(struct phy_device 
>> *phydev, int addr,
>>   static int ksz9031_config(struct phy_device *phydev)
>>   {
>> +    unsigned int features = phydev->drv->features;
> 
> It's a u32 member, so we can simply use a u32 for the local variable.

I've changed it in V2.

> 
> This will be overshadowed by unsigned features in the if block, just 
> remove the overshadowing variable and features = phydev->drv->features; 
> in the if block since you'll already have set it.
> 
>>       int ret;
>>       ret = ksz9031_of_config(phydev);
>> @@ -371,7 +372,22 @@ static int ksz9031_config(struct phy_device *phydev)
>>           return 0;
>>       }
>> -    return genphy_config(phydev);
>> +    /* Silicon Errata Sheet (DS80000691D or DS80000692D):
>> +     * Whenever the device's Asymmetric Pause capability is set to 1,
>> +     * link-up may fail after a link-up to link-down transition.
>> +     *
>> +     * Workaround:
>> +     * Do not enable the Asymmetric Pause capability bit.
>> +     */
>> +    features &= ~ADVERTISE_PAUSE_ASYM;
>> +    /* update feature support and forward to advertised features */
>> +    phydev->supported = features;
>> +    phydev->advertising = phydev->supported;
>> +
>> +    /* genphy_restart_aneg called from genphy_config_aneg */
>> +    return genphy_config_aneg(phydev);
>> +
>> +    return 0;
> 
> Don't need the return 0 here as it won't be reached.

I remove it.>
> Is this errata only applicable if 1000BASE-T is supported? I couldn't 
> find that in the doc but maybe I misread. In which case, we need the 
> exact same logic in the if (env_get("disable_giga")) section I think?

I checked. It doesn't only apply to 1000BASE-T.
To use the workaround for KSZ9021 as well, it's implemented as a 
function and called before `if (env_get("disable_giga"))` for KSZ9031.

> 
> Cheers,
> Quentin


I send V2

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

