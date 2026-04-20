Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5627BF5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEAA84347;
	Tue, 21 Apr 2026 02:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WcMfwHSO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wuD+cJiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F79584310; Tue, 21 Apr 2026 02:48:16 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6781C84198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g03cW6l3Yz9tWv;
 Tue, 21 Apr 2026 02:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrnHA3JtPBV42z3GOBTt0WhWfkYLr5uCoVz/zbYBbns=;
 b=WcMfwHSOvzVlvvwkCqx2TQA4XTfb1m9KdlZTR8ksGPlFjzSrUbTcr1vU+rEtic8UKAD4Zw
 gdHffTclosQ8NPgD30HGdiF13+CqlXPGEVLnEHNRV+2F+vGXok74IvgXKSYzptXKz/2gBc
 6MS9FF5FlgNa5Fa7w4Ubm0l6lHhWpyLVSBrDanttz1kRb6RalQ1z0PW32Z2RFLtx4LzX1U
 4yRa0y9qoexcWfPxSLTx+bLnXWDK46+LUVEa97UoZAjN9JrNKo/JDardwdsm0jIabCGNpK
 bQl4SsafsDDoikYHmkhPmRlK/iDcrDNKMBue7wLUi8P1A3vXo08xGmFdbGV8Tg==
Message-ID: <0f83beeb-4d96-45bf-ba2e-0531bbe1ae62@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrnHA3JtPBV42z3GOBTt0WhWfkYLr5uCoVz/zbYBbns=;
 b=wuD+cJizflgAZCt0GekkWZgS3f1eiCz7jfOp3G1XWV72qpYZbOp87Cu68O283gDz7xsMAT
 HAGg9PkH457XiqJguB3G0pJPzmOlnqlwSveua44AvBEx7qKitIKkWBJ2rVAbBKshVv0ZID
 1bxFnDROv5pJjTWd19375fRo/S3XenGdDIbGtbYAo72JtadvoKT3vlvozcmQqf6XuFywiO
 DtTNGOZXu4oC/+L1s75P225MWmkMhRMujiI12HL7rti0N8CfWWtK/+BCKeARQEScx8m7cp
 R6X2wB+sD28hrD0Jn+re+R7O53Bim8BPK5r0+NH1UAw5p1y0yArra1yOC/LS2A==
Date: Tue, 21 Apr 2026 00:59:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: phy: fix duplicate eth_phy binding
To: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Simek, Michal" <michal.simek@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Yao Zi <me@ziyao.cc>, "SkyLake.Huang" <skylake.huang@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260408085844.2942463-1-pranav.vinaytilak@amd.com>
 <ffade924-420d-48e6-a49c-b2cb2673c94e@mailbox.org>
 <MW6PR12MB708846C3A34019C7D34DC435FB232@MW6PR12MB7088.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <MW6PR12MB708846C3A34019C7D34DC435FB232@MW6PR12MB7088.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 058af22c19b2966e4f2
X-MBO-RS-META: tmru6h6upmcp4e4m4tqwkm59yayx8kso
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

On 4/16/26 9:12 AM, Vinay Tilak, Pranav wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Wednesday, April 8, 2026 10:02 PM
>> To: Vinay Tilak, Pranav <Pranav.VinayTilak@amd.com>; u-boot@lists.denx.de;
>> Simek, Michal <michal.simek@amd.com>
>> Cc: git (AMD-Xilinx) <git@amd.com>; Begari, Padmarao
>> <Padmarao.Begari@amd.com>; Jerome Forissier
>> <jerome.forissier@arm.com>; Tom Rini <trini@konsulko.com>; Peng Fan
>> <peng.fan@nxp.com>; Lucien.Jheng <lucienzx159@gmail.com>; Yao Zi
>> <me@ziyao.cc>; SkyLake.Huang <skylake.huang@mediatek.com>; Siddharth
>> Vadapalli <s-vadapalli@ti.com>; Marek Vasut
>> <marek.vasut+renesas@mailbox.org>; Ramon Fried <rfried.dev@gmail.com>
>> Subject: Re: [PATCH v2] net: phy: fix duplicate eth_phy binding
>>
>> On 4/8/26 10:58 AM, Pranav Tilak wrote:
>>> When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are
>> enabled,
>>> eth_phy_binds_nodes() called from eth_post_bind() already binds the
>>> ethernet PHY node to eth_phy_generic_drv. However,
>>> phy_connect_phy_id() called via zynq_phy_init() -> phy_connect()
>>> cannot attach to the already bound PHY device and creates a second
>>> instance, resulting in duplicate entries in the dm tree:
>>>
>>> Fix this by guarding the phy_connect_phy_id() call in phy_connect()
>>> with uclass_get_device_by_phandle() to skip re-binding if the PHY node
>>> is already registered in UCLASS_ETH_PHY.
>>>
>>> Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new
>>> PHY")
>>> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
>>> ---
>>> Changes in v2:
>>> - Move duplicate binding check to caller phy_connect()
>>> - Update commit description
>>>
>>>    drivers/net/phy/phy.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c index
>>> d7e0c4fe02d..cfca8328f1c 100644
>>> --- a/drivers/net/phy/phy.c
>>> +++ b/drivers/net/phy/phy.c
>>> @@ -938,8 +938,13 @@ struct phy_device *phy_connect(struct mii_dev
>> *bus, int addr,
>>>    #endif
>>>
>>>    #ifdef CONFIG_PHY_ETHERNET_ID
>>> -   if (!phydev)
>>> -           phydev = phy_connect_phy_id(bus, dev, addr);
>>> +   if (!phydev) {
>>> +           struct udevice *phy_dev;
>>> +
>>> +           if (uclass_get_device_by_phandle(UCLASS_ETH_PHY, dev,
>>> +                                            "phy-handle", &phy_dev))
>>> +                   phydev = phy_connect_phy_id(bus, dev, addr);
>> Shouldn't this binding check be closer to the beginning of phy_connect() ?
>> Basically check whether the PHY driver is already bound at the beginning, and
>> if so, you are done. I don't think that test is specific to
>> CONFIG_PHY_ETHERNET_ID, is it ?
> 
> The check is placed inside phy_connect_phy_id() because that is the only code path that calls device_bind_driver_to_node() on the PHY node, which creates the duplicate.

The device_bind_driver_to_node() in phy_connect_phy_id() is called only 
under very specific conditions -- if IS_ENABLED(CONFIG_DM_ETH_PHY) and 
phy-handle property exists and points to a valid node. The DM_ETH_PHY 
test is not covered here.

But that is besides the point. I think phy_connect() should figure out 
whether any PHY is already connected, and if it is, simply exit early. 
This sounds to me like a more generic solution.

> The other paths (phy_connect_fixed, NCSI, phy_connect_gmii2rgmii) do not bind the PHY node and are not affected.
I worry this is only a matter of time, hence it would be good to have a 
generic solution which covers all the PHY options.
