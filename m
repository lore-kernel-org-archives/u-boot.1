Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63650D12D53
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 20:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFC3891A8;
	Sun, 10 Nov 2024 21:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UxfHKBNe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NlI6deaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF7D88E1C; Sun, 10 Nov 2024 21:56:45 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C683389198
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 21:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XmlNC4Ktkz9scM;
 Sun, 10 Nov 2024 21:56:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H801oqgiPcZW6LNi0q/QwQyEIje3gVvp5Gj+pqfPifU=;
 b=UxfHKBNeKt40MfedT0fdFFvJnFqR3BWtjVPfk5XxEp6gjxiWsWekb63bfF1gDZgG9FGmfC
 loXSweHO37bbli78q5dIk3jJJfXlNtFLLDg4jrD7u+QjEtkGIEGkCJicp8/Irh0MFkyiba
 LiV9RzknP9wczAY7+LzylofsK0KpVZy1aqc3LpCefrFjKrRli4HoxbGTFZRqBdwAuYhPf7
 8C9/eo0dWYqs4lXNYkyRTihfsTISM8zTBGYnHSC15N8fNeKNLFU47GQBzj5MHBqTXj9XrJ
 jWA3q33UU7aMY5D8nSAXd1j8ONDJzKM9nvCH3b3vSnsbj8dzuSAOGmVKuV43MQ==
Message-ID: <f974c911-e906-4ef4-b902-df971abeb6f6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H801oqgiPcZW6LNi0q/QwQyEIje3gVvp5Gj+pqfPifU=;
 b=NlI6deaLZUxXEjeig5Rzz4L/TsnLavo9QCF6cgcTZ21vKcj7f92GLYPM9VZqETsP+24rit
 Ix7ljl34wpLWZArXP9mzOiyqBI5Z77+peDXG8mPexTeunxoNaFJhd+42jfwdC3KIIDBKUk
 tl5GKK3IMizBDozP22z1oA4DjEGB5fbbgc2hqRg1rEdZ0VQveLgRsnTfzCc0M9VQQAltzw
 rvd00vd7CuMsOhSP7WXLkWD3w6Sy55/Za0cT34eiiLuyVTDzoZ56remffr4+nsDgzIhbK1
 XZEQaypDp0obHDWhe2f4QTF5e23H6zUt7rGrmeF/PCURqqJC9CstIAanoMnYfA==
Date: Sun, 10 Nov 2024 19:34:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 08/14] net: phy: ksz90x1: Simplify
 ksz9131_config_rgmii_delay
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-9-paul.barker.ct@bp.renesas.com>
 <73609bce-143a-4da2-9e8c-87ac7646a72d@mailbox.org>
 <1dac61de-f6fd-40ee-bfca-64464249623f@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1dac61de-f6fd-40ee-bfca-64464249623f@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c661cb51797812dcf29
X-MBO-RS-META: mfgto1eke7gozt3xfzgg54ujrwfhzeok
X-Rspamd-Queue-Id: 4XmlNC4Ktkz9scM
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

On 10/28/24 9:50 AM, Paul Barker wrote:
> On 27/10/2024 16:20, Marek Vasut wrote:
>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>> We can call phy_modify_mmd() instead of manually calling drv->readext()
>>> and drv->writeext().
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    drivers/net/phy/micrel_ksz90x1.c | 26 ++++++++------------------
>>>    1 file changed, 8 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
>>> index b64046e0bc72..6515d8feb9be 100644
>>> --- a/drivers/net/phy/micrel_ksz90x1.c
>>> +++ b/drivers/net/phy/micrel_ksz90x1.c
>>> @@ -502,8 +502,7 @@ static int ksz9131_of_load_all_skew_values(struct phy_device *phydev)
>>>    
>>>    static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>>>    {
>>> -	struct phy_driver *drv = phydev->drv;
>>> -	u16 rxcdll_val, txcdll_val, val;
>>> +	u16 rxcdll_val, txcdll_val;
>>>    	int ret;
>>>    
>>>    	switch (phydev->interface) {
>>> @@ -527,24 +526,15 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>>>    		return 0;
>>>    	}
>>>    
>>> -	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> -			   KSZ9131RN_RXC_DLL_CTRL);
>>> -	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
>>> -	val |= rxcdll_val;
>>> -	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> -			    KSZ9131RN_RXC_DLL_CTRL, val);
>>> -	if (ret)
>>> +	ret = phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> +			     KSZ9131RN_RXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
>>> +			     rxcdll_val);
>>> +	if (ret < 0)
>>>    		return ret;
>>>    
>>> -	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> -			   KSZ9131RN_TXC_DLL_CTRL);
>>> -
>>> -	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
>>> -	val |= txcdll_val;
>>> -	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> -			    KSZ9131RN_TXC_DLL_CTRL, val);
>>> -
>>> -	return ret;
>>> +	return phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
>>> +			      KSZ9131RN_TXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
>>> +			      txcdll_val);
>>>    }
>> Can't you set both bitfields at the same time ? They seem to be in the
>> same register.
> 
> These writes are to two different registers (KSZ9131RN_RXC_DLL_CTRL and
> KSZ9131RN_TXC_DLL_CTRL), using the same bitmask in both cases
> (KSZ9131RN_DLL_CTRL_BYPASS).
Uh, right, thanks for clarifying.
