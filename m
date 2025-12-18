Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E977CD68BDA
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 10:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F1983C54;
	Thu, 18 Dec 2025 11:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XS6YXkvF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p0uqpN2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5227783D00; Thu, 18 Dec 2025 11:04:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6607783BA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dX5qF6dcyz9v83;
 Thu, 18 Dec 2025 11:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766052250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQTY9YzPI/ibgx3Gt3MkoCrrmJmrwNquHBc9u1V98tQ=;
 b=XS6YXkvFRg0bIsHibSyIoE8cCsL7Z0nhrY6Hv0C7EDe9ziDj7cVD6rxm1XmmG2XRnUsjaq
 gqWiEQqXLszjNkgfGECymf3fCtni2I2nzSp89U9iO3xjyqiC5dJ6vZAJ0vF5v+9tNBFNEb
 8+27RUItYmpgiVT+ou7nRFkgO7inffopWkiCyggZMAt92UMgZt5XAiiiKhFZX2eFfjjRj9
 680FB21oTAE8UaH+3Tty1w/Yufqo4TRjfRJmW5VE4S1vEBW9v2OeR2cQ4bsHwxY6mxVtAZ
 I3rHffpT1GhdvxaICz582DVdbItj7q3zT1DjrP6Y/w+LtxbkM0kkjujtuzwWbg==
Message-ID: <2dd0c065-66a6-4122-a5c7-3bc5dbeb77c7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766052247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQTY9YzPI/ibgx3Gt3MkoCrrmJmrwNquHBc9u1V98tQ=;
 b=p0uqpN2KGf36p1ThPqrHJvWvBDR7Zv0sfZDOeTMTbNnanmmTHm1CMRsVFgQQG8t7DSZyTI
 QDr2PoP3KiQvMOjEs0FrHlqn1m8G6H3/Axnb+9ea1sHr9mAHeNFyUmgKqc1n1FhWFe/Id5
 fzFkt/1oy6xi+3Tt+bwAsmsPWpAD/7pfAK4ODVoeIR2JnSSzpGaBCK4hbBmml5Co1KticR
 HFsQjeK1/w0YOyzMZvJX0GadSXsxq/hx6pVNnzXWFYxiV8xGl0kka9sLOa9Vtm/QUvZEfF
 7D2qA+tVBG3G1LDsKJuvt3wdXuR4S6LH4Uf45jNy7EYmHf5BtgHos86qq7ucjw==
Date: Thu, 18 Dec 2025 11:04:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
 <20251218-sqqs-v4-2-ff95bf2062ab@foss.st.com>
 <93f17cf0-542c-4c0c-a97f-40dd328afd5d@mailbox.org>
 <4255b341-2a03-4ca3-bc33-45075d0fb80c@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4255b341-2a03-4ca3-bc33-45075d0fb80c@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cf23b45aa52cb93bcc7
X-MBO-RS-META: rutnejmhn4bfun6xx85tac6kugnbz64z
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

On 12/18/25 10:58 AM, Patrice CHOTARD wrote:

Hello Patrice,

>>> @@ -156,6 +156,16 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>>                             in_v2, out);
>>>        int ret;
>>>    +    /*
>>> +     * In scmi_clk_probe(), in case of CLK_CCF is set, SCMI clock
>>> +     * version is set in dev's parent priv struct. Otherwise
>>> +     * SCMI clock version is set in dev priv struct.
>>> +     */
>>> +    if (CONFIG_IS_ENABLED(CLK_CCF))
>>> +        priv = dev_get_parent_priv(clk->dev);
>>> +    else
>>> +        priv = dev_get_priv(clk->dev);
>> On your hardware, do you have CCF enabled or not ?
> 
> On stm32mp15, CCF is not set.
> 
>>
>> What does this print output if added here ?
>>
>> printf("clk->dev->name=%s clk->dev->parent->name=%s\n", clk->dev->name, clk->dev->parent->name);
>>
>> I think it should be something like this:
>>
>> clk->dev->name=scmi-325 clk->dev->parent->name=protocol@14
> 
> I got
> 
> clk->dev->name=protocol@14 clk->dev->parent->name=scmi

I see.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
