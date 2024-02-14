Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BA3C4829A
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 07:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD7787DDE;
	Wed, 14 Feb 2024 08:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707897023;
	bh=wn+5ZeBEXt2c+vERr6DpuE3QuVTxYuZAVJEl+tP3SF4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YmvvDfTf2JtaAqksvDqa8leU3mrESq32ZRVcT/lKGzlZquACAXibN5V4Eb5vC/D/n
	 3n/cRoKBVLN6/Q39Lx41QXVBk+GJE6u5ivpuQ01b1HHQ/tJHTbM+ei6dRX52YNAIOl
	 g1cmVrf7tUTLcWHOTOKu1kTStRTFQYiAF7G8aw91090yYRFQJV4j+EDFkOjI0kmmvS
	 mEmfk0Q7D8Buf8Urn69HVLZ4V1gYFdVaumI1uL/v/36m/VlSpbxZb6mCfakp7WtaiB
	 U/7n76S9Iuw755HMCBwRfLCYSkVWPPEb7te5bW5dfOUk/GA2dZKXClYV8pZYd28s0c
	 Mf7S53RXZjClw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394A787DDF; Wed, 14 Feb 2024 08:50:22 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C96587DDB
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 08:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TZVjP6k1jz9skq;
 Wed, 14 Feb 2024 08:50:17 +0100 (CET)
Message-ID: <45ffb9f2-8986-4d85-868e-eca618ff16ab@denx.de>
Date: Wed, 14 Feb 2024 08:50:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
From: Stefan Roese <sr@denx.de>
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, tharvey@gateworks.com,
 marex@denx.de
References: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
 <20231218170930.4afe5dbd@dellmb>
 <c620d56f-29b6-4819-a51f-dca962a2ec64@denx.de>
Content-Language: en-US
In-Reply-To: <c620d56f-29b6-4819-a51f-dca962a2ec64@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Ramon,

On 1/9/24 10:37, Stefan Roese wrote:
> On 12/18/23 17:09, Marek Behún wrote:
>> On Wed, 6 Dec 2023 15:35:56 +0100
>> Marek Mojík <marek.mojik@nic.cz> wrote:
>>
>>> The mv88e6xxx driver does not currently initialize the smi_addr 
>>> field, but
>>> instead keeps the default zero value. This leads to driver being 
>>> unusable
>>> on devices where the switch is not on address zero of the mdio bus. Fix
>>> this problem by reading the SMI address from device tree.
>>>
>>> Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
>>> ---
>>>   drivers/net/mv88e6xxx.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
>>> index c073f81e72..8fbbc1cacc 100644
>>> --- a/drivers/net/mv88e6xxx.c
>>> +++ b/drivers/net/mv88e6xxx.c
>>> @@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
>>>   {
>>>       struct dsa_pdata *dsa_pdata = dev_get_uclass_plat(dev);
>>>       struct mv88e6xxx_priv *priv = dev_get_priv(dev);
>>> +    fdt_addr_t smi_addr;
>>>       int val, ret;
>>>       if (ofnode_valid(dev_ofnode(dev)) &&
>>> @@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
>>>           return -ENODEV;
>>>       }
>>> +    smi_addr = dev_read_addr(dev);
>>> +    if (smi_addr == FDT_ADDR_T_NONE) {
>>> +        dev_err(dev, "Missing SMI address\n");
>>> +        return -EINVAL;
>>> +    }
>>> +    priv->smi_addr = smi_addr;
>>> +
>>>       /* probe internal mdio bus */
>>>       ret = mv88e6xxx_probe_mdio(dev);
>>>       if (ret)
>>
>> Reviewed-by: Marek Behún <kabel@kernel.org>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Ramon, this patch was assigned to me as an Marvell MVEBU patch
> depends on it. I've assigned it to you now. Or if it's okay that
> I pull it with the Marvell tree, just let me know.

Any updates on this?

Thanks,
Stefan
