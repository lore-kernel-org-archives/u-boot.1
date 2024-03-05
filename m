Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BB1C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE7687FC2;
	Tue,  5 Mar 2024 11:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634461;
	bh=nRu6pgBYkooE4Gxym4IwWnnW2S0Dpk/gBzwllgwxy3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3QAuA+5Fau08xtikJce/Qdc11Ifeg8k8kswvu46/5PlzSPjxL0RxzBTtvstajqPd
	 /ZUCIyafSq9Tb8gvfY/UTkC/vHYnSNDgstme6DjFqkYtW1/t4mOpGTMRflAVVDfpAv
	 xO4v/gLm+RWZ8PyJu2HqoF64g1/4YJy99G3GBcG2shEf7OklU/Sx/scrCDSLckEx8D
	 tZotM41D5MvHAbJIDlM121+L+MO6WDda0ojhqEOV9KHCc3a7pqZJ9KBYjvh/4wUEku
	 f2alCsMNWWZw5rhY2GvoRvGnyI7IfvX+4eyTUV/vUoao4TpEvLKl+YQmNjeyVuobVL
	 2K6cHbuX9bPVw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D2388016; Tue,  5 Mar 2024 11:27:40 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4E488008
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsFh0M01z9sld;
 Tue,  5 Mar 2024 11:27:36 +0100 (CET)
Message-ID: <0772b972-d4c3-4ad6-b8d7-efe0c049e349@denx.de>
Date: Tue, 5 Mar 2024 11:27:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, rfried.dev@gmail.com,
 u-boot@lists.denx.de, joe.hershberger@ni.com, tharvey@gateworks.com,
 marex@denx.de
References: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
 <20231218170930.4afe5dbd@dellmb>
 <c620d56f-29b6-4819-a51f-dca962a2ec64@denx.de>
 <45ffb9f2-8986-4d85-868e-eca618ff16ab@denx.de>
 <20240304154812.48850405@dellmb>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240304154812.48850405@dellmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TpsFh0M01z9sld
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

Hi Marek,

On 3/4/24 15:48, Marek Behún wrote:
> Hi Stefan,
> 
> On Wed, 14 Feb 2024 08:50:16 +0100
> Stefan Roese <sr@denx.de> wrote:
> 
>> Hi Ramon,
>>
>> On 1/9/24 10:37, Stefan Roese wrote:
>>> On 12/18/23 17:09, Marek Behún wrote:
>>>> On Wed, 6 Dec 2023 15:35:56 +0100
>>>> Marek Mojík <marek.mojik@nic.cz> wrote:
>>>>   
>>>>> The mv88e6xxx driver does not currently initialize the smi_addr
>>>>> field, but
>>>>> instead keeps the default zero value. This leads to driver being
>>>>> unusable
>>>>> on devices where the switch is not on address zero of the mdio bus. Fix
>>>>> this problem by reading the SMI address from device tree.
>>>>>
>>>>> Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
>>>>> ---
>>>>>    drivers/net/mv88e6xxx.c | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
>>>>> index c073f81e72..8fbbc1cacc 100644
>>>>> --- a/drivers/net/mv88e6xxx.c
>>>>> +++ b/drivers/net/mv88e6xxx.c
>>>>> @@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
>>>>>    {
>>>>>        struct dsa_pdata *dsa_pdata = dev_get_uclass_plat(dev);
>>>>>        struct mv88e6xxx_priv *priv = dev_get_priv(dev);
>>>>> +    fdt_addr_t smi_addr;
>>>>>        int val, ret;
>>>>>        if (ofnode_valid(dev_ofnode(dev)) &&
>>>>> @@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
>>>>>            return -ENODEV;
>>>>>        }
>>>>> +    smi_addr = dev_read_addr(dev);
>>>>> +    if (smi_addr == FDT_ADDR_T_NONE) {
>>>>> +        dev_err(dev, "Missing SMI address\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +    priv->smi_addr = smi_addr;
>>>>> +
>>>>>        /* probe internal mdio bus */
>>>>>        ret = mv88e6xxx_probe_mdio(dev);
>>>>>        if (ret)
>>>>
>>>> Reviewed-by: Marek Behún <kabel@kernel.org>
>>>
>>> Reviewed-by: Stefan Roese <sr@denx.de>
>>>
>>> Ramon, this patch was assigned to me as an Marvell MVEBU patch
>>> depends on it. I've assigned it to you now. Or if it's okay that
>>> I pull it with the Marvell tree, just let me know.
>>
>> Any updates on this?
>>
>> Thanks,
>> Stefan
> 
> Stefan, it seems that Ramon is unavailable for this.
> Can we take this? We've been using it on Omnia and it works correctly.

Yes, I also thought about pulling this one in. As a matter of fact,
I'm currently busy with creating a pull request for Tom.

Thanks,
Stefan
