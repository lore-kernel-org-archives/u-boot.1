Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7421BCD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 02:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E9A83EF9;
	Sun, 17 May 2026 04:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="faE8t5gG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5A083FEE; Sun, 17 May 2026 04:13:00 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6AF83E76
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 04:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gJ4GK3YNhz9vN7;
 Sun, 17 May 2026 04:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778983977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/XLmBgZLq2EYVqdldF+MxV5M+XXhjmsJjRTgqsWilg=;
 b=faE8t5gGtWPkDcqOlN7ZS9nLP9gYGoEybgqMQpDuh6GgYtFyWTe3aPtZsiRv3dZLGAfqC2
 MyYdhzNrjFcwTl77WW0zUqjoSNtChSbmUgFJyB7TgD9I4nIlMO5FCX1W5pxvc6OWXYXf//
 E+1SKY7F9RfjkTPbOvJ/5ZnizjwdCkfDc/S8bNwJ9hMSKkjwci2kcPX2y4PaWhXngkahoS
 Ta6ZNJqcs7QIUtsvS+Dah5Iq9k/ZX1xe0CsgTMgjuJ0dw9jpojzbaOFBfwXehJ3Xm5JK9I
 8xPieqauBpXZ9e+nvvmT2HFLSeE+VUkejY4d+XaqEkEF8ui+/rXBON/pdcYtqg==
Message-ID: <1f68f8fb-eb3a-4e3d-982c-3761e7be5caa@mailbox.org>
Date: Sun, 17 May 2026 00:02:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] net: phy: fix duplicate eth_phy binding
To: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Simek, Michal" <michal.simek@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260513133344.1288865-1-pranav.vinaytilak@amd.com>
 <5f8a52d8-765b-4a52-96b3-1258558bd500@mailbox.org>
 <MW6PR12MB708859452C870D4233A80B12FB042@MW6PR12MB7088.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <MW6PR12MB708859452C870D4233A80B12FB042@MW6PR12MB7088.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nz9yxwz46ru7tfp8xbxwf9soyckbt6cf
X-MBO-RS-ID: e4679a67096ec66e4d4
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

On 5/15/26 1:13 PM, Vinay Tilak, Pranav wrote:

[...]

>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c index
>>> d7e0c4fe02d..7d698f00c09 100644
>>> --- a/drivers/net/phy/phy.c
>>> +++ b/drivers/net/phy/phy.c
>>> @@ -24,6 +24,7 @@
>>>    #include <linux/delay.h>
>>>    #include <linux/err.h>
>>>    #include <linux/compiler.h>
>>> +#include <dm/uclass-internal.h>
>>>
>>>    /* Generic PHY support and helper functions */
>>>
>>> @@ -927,6 +928,14 @@ struct phy_device *phy_connect(struct mii_dev
>> *bus, int addr,
>>>    {
>>>      struct phy_device *phydev = NULL;
>>>      uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
>>> +   struct udevice *phy_dev;

Please pick a variable name which is not phy_dev , there is already a 
phydev variable in this function and the naming is VERY confusing.

>>> +   int ret;
>>> +
>>> +   /* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
>>> +   ret = uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
>>> +                                       "phy-handle", &phy_dev);
>>> +   if (!ret)
>>> +           goto out;

You already check if (!ret) here ...

>>>    #ifdef CONFIG_PHY_FIXED
>>>      phydev = phy_connect_fixed(bus, dev); @@ -947,9 +956,13 @@
>> struct
>>> phy_device *phy_connect(struct mii_dev *bus, int addr,
>>>              phydev = phy_connect_gmii2rgmii(bus, dev);
>>>    #endif
>>>
>>> +out:
>>>      if (!phydev)
>>>              phydev = phy_find_by_mask(bus, mask);
>>>
>>> +   if (phydev && !ret && !ofnode_valid(phydev->node))
>>> +           phydev->node = dev_ofnode(phy_dev);
>> Is the !ret test necessary in this conditional ?
> 
> Yes i checked, !ret is necessary as uclass_find_device_by_phandle() always sets phy_dev= NULL on entry, when it fails to find an already bound PHY phy_dev is NULL. Removing !ret would call dev_ofnode(NULL) which dereferences a NULL pointer and crashes.

... so I think the goto jump target needs to be adjusted ?

In fact, I do not understand why does this code call phy_find_by_mask() 
if the PHY udevice was already found by uclass_find_device_by_phandle() 
? Can you not convert that already found PHY udevice into phydev ?

> !ret also serves as a guard for the assignment of phydev->node it should only happen when the PHY is already DM bound. When binding methods run (ret != 0), they already set phydev->node correctly so no need to again set phydev->node in that case.

If uclass_find_device_by_phandle() does locate PHY udevice , it will 
return 0, and the !ret conditional will evaluate to true , so 
phydev->node = dev_ofnode(phy_dev); will run in that case ?

> The !ofnode_valid(phydev->node) check is redundant and can be dropped. In the ret == 0 path, only phy_find_by_mask() runs and it never sets phydev->node, so !ofnode_valid(phydev->node) is always true.
> Hence condition can be simplified to:
> 
> if (phydev && !ret)
>      phydev->node = dev_ofnode(phy_dev);
[...]
