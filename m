Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13070C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 05:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E6DC80D96;
	Wed, 16 Sep 2026 05:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EadKPoZoBaLT; Wed, 16 Sep 2026 05:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0AA1880D16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789534820;
	b=o66DN01atvdPhUcTnUxiHm3Ph+qfEj/T+VwObFSMg3c4FPwy3KevCIJirfyBZ+vtXCcR
	 A61MCiQGMiMUMkD2VMJtSJ88qS/V8hTVqdmzQNFBHyGRbguNylV/JaMQIoeSf1NAhOw//
	 FsP5awSCC05rMJ/VRsRvbdx/Bkw/419P1sOYc2RHp+W/FbWjG60jr2ssU5GnrHrWTXfmy
	 qeyU7ifR46SeN9h+GbiiBJ6AU089CfSv2f3MrZa+1bpLD1qpXB2zPrtjnnuGQQVsfp1DN
	 AXZVvWlNdYS9rxg07XNU8C+aEfxtjbpXa7Xtx5hdKzh56LTSY/RY3NnUo0fTN+Rx3uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789534820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L8zdB0Zgln/G3uZ2paoiYoIbqnszSgS+ikOuZKoFsBw=;
	b=egY7S6iSE1YLVfsoW0NjxNQwr2uTojHNX6xp48OHsboV8AtxuuXCE8WjoRbD62XgsRMb
	 LAmxK1GCWWKNQ+fy5+8VU7wquPq9jlXyLMrYDLydmBd8GXVCsDY32Ou5A8efnCSYivCle
	 kqjWyfhnWrzA50ci33pjVWXBsXYfnNrJvKzdc9Gm2OdT72BsVrhHUPvWBTuURF8mMJcJ+
	 4finnZP/UCk2U24P8m/46t/zAaQM06AhkfFU1YxOahWYynAOF3tKTkMcjz/yfls45f3v/
	 i4r49w9XBkcnB1znQDYio+b+JKm0fOhoTJcqDxp3E1v+idFvFjOe2APm5RRSaPSDdFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789534820;
	bh=L8zdB0Zgln/G3uZ2paoiYoIbqnszSgS+ikOuZKoFsBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pNofuxP7nNJmc32kno/Th7XX4WsbACieWuVWggcJv4UIJOABj6/xFeFduAI+blWkp
	 xPYH1LBf+2M/QRElm1bAEgo2lOXIiri0uFvh864mP5nudE6gH6I44vhAZAYIG3s1Ue
	 XlBERiqxNY77wZ4U5vEkWbbAnjLch05EFZKi7U/WKsAQaxTyzgYsVHHw5NWEclVAUt
	 VRHa7GVhEYAnVtRAYzCgQlYoEsQLDCMh0gh23BTaFz8cgoLierw9tbmT4CI7/lce/X
	 czpI046yZpjoM2r2qKs84TqtEt/JEBMuYQxt3664CYwvEK18cgODypZanka6Lex8uL
	 is9jfCps126Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AA1880D16;
	Wed, 16 Sep 2026 05:00:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D78FC388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD9CE4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlxCJq6WW8VF for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 05:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3FA5440076
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789534817;
 b=tfAS6drBrggdQs55Q+QHaHIJUOIggN/aRgFQ8z8zYwamBNmFKObBvH0YFIUmM2K8b5Ft
 SEpb7QLXCeWGUF7+bE7V5WteZa7PHdO37WgkHGwBU5iWzZh9go29W4g3Rokl8OavLmFwx
 cneyO38kdro8bT97JLN+mTuU9X40uBBOgJYArwumHnb91oBBpHYTrQd85S3XMbhaL0l5S
 EB3yRcuNocqZobinVN0sYog27Gnzogx4DKuFtrmS4obheSyntwRbjad63KOgPBEBT+cvH
 CXIzSom88EXiM7WYT3L5/6o8Jd3/LPJXqSe0+GAZ5rgF5Yb9biAOBXKYKRcL9Y4ZlcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789534817;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=L8zdB0Zgln/G3uZ2paoiYoIbqnszSgS+ikOuZKoFsBw=;
 b=JO5KKXf+wENzNd5/QhJaxJJUIn8LV1LE+/k+KdOL3MHayF+Sc/yS3opRMD4f261CFCLs
 4J6Tpj41IkkTcIyue+sUc4aiI3VabQbkJjEKYBh4j1AA17vztwseRwAYJKi7k+8rpErwq
 L4RfE4XABbOQ4YRZDs4VHpNJNgWLNq5hiNWXKCNUsYukr2V+3clneAgRz3GNIzRAsc0J0
 5pnsSpWAY1AIO6yMOedWlJmmqfX3K9DzSIFwbjBFOvHKZmstnPqhiBK5BsMvTWoUEYk0f
 Tdupv9aZHXvtQYO78/lRZCE5Q6wvlYcncfbihoD56lqz6zu7CJJctGtVihzkD6pnm9Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="aseKtR/Y"; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Fc9qrv4E; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=aseKtR/Y; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Fc9qrv4E
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FA5440076
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hl6C20CbCz8v1q;
 Wed, 16 Sep 2026 07:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789534814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8zdB0Zgln/G3uZ2paoiYoIbqnszSgS+ikOuZKoFsBw=;
 b=aseKtR/YWFPnPhhn3xjIs0psRvjxMf93KmdlG9huGP4q10FxecuPoeBPjWk+lKOSbl3tDp
 v4d4ZBazw71jKoQT9Elr1EoJhOwc5OQvlg9eBOBjbccV15Ud8zmXis0A4cVRkjzczUvu3F
 TC0A7IZvbsdsiFK6KPmTnGNZSP7mLGjgtsB/byxvzIWnPd+oz/zynF6RL9AygZjWWj12fq
 7Aay1lUVopWDWi/Zm0s7E6Ca6tVUYeeBuOhQ/sGtdVuy6/vc+oIqXsKot60BxGeUy4ogAX
 KBE8maQviluEebJ6jytuXGbIgIjtzUzdJXmbIUFMQa91MmWXte7sS8AbW9w3vQ==
Message-ID: <34683aa6-50a5-4461-be76-12430ef235de@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789534812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8zdB0Zgln/G3uZ2paoiYoIbqnszSgS+ikOuZKoFsBw=;
 b=Fc9qrv4Ey0gCuyiHxGyCvAkOr/CUVF51ky6AMDudOp5MtMQB6/kA5bh4qsqCF2Suphd4oU
 tdsEXabMR2q5tmggdWecmIsrIjXliA2SkxfrL7gFHS7bAwuz8zHK95bBGAKGSQzgXw73Na
 QPkrezw9FCufNl3ThQpZS8wbnORc2sOyfzTR3TYhZpVAZMvSPpngjbSkViCwtgOAw0ZsCo
 m2x/onND8M66UK1JeuUZOAbN5Q+yO7/lIGSg+2ne+PI3wPqSHiwmSlbGEsVCIFEObvQWp4
 v6MIwZgySZouhTNZzxP3ijh1TsuINHGyo068qQ25ujR680+O8uDuNA57AfRt2g==
Date: Tue, 15 Sep 2026 16:22:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 u-boot@lists.u-boot-project.org
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-4-eichest@gmail.com>
 <94548efb-5bb8-4320-82ea-5e40b706d584@mailbox.org>
 <aqj3XczDvnQs0Wwp@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aqj3XczDvnQs0Wwp@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ye1j68f8qnpqzsn7fkxkuu7ehgcokkp4
X-MBO-RS-ID: 90591872c088f3609d6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/15/26 9:44 AM, Stefan Eichenberger wrote:
> On Mon, Sep 14, 2026 at 09:26:12PM +0200, Marek Vasut wrote:
>> On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
>>> port the hub itself enumerates fine but a USB stick plugged into it
>>> fails intermittently:
>>>
>>>     Verdin iMX95 # usb start
>>>     starting USB...
>>>     USB XHCI 1.10
>>>     Device not responding to set address.
>>>
>>>           USB device not accepting new address (error=80000000)
>>>     Bus usb@4c100000: 2 USB Device(s) found
>>>            scanning usb for storage devices... 0 Storage Device(s) found
>>>     Verdin iMX95 # usb reset
>>>     resetting USB...
>>>     USB XHCI 1.10
>>>     WARN endpoint is halted
>>>     WARN endpoint is halted
>>>     unable to get device descriptor (error=-22)
>>>
>>> Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
>>> both controller DT nodes") added a fallback that searches the DWC3
>>> child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
>>> the parent glue node, but always resolves the found index against
>>> glue->clks, a clk_bulk populated only from the parent glue node's own
>>> clock-names list. This is wrong since the child node's clock-names list
>>> is not guaranteed to be in the same order as the parent's, and indeed on
>>> Verdin iMX95 the child node has a different order than the parent node.
>>>
>>> Fix it by looking the reference clock up by name with clk_get_by_name(),
>>> walking the dwc3 device first and then its parent glue device, so the
>>> clock is always resolved through the device that owns the node its name
>>> was found in. Also enable the clock before use, the child node's clocks
>>> are not part of the glue node's clk_bulk and are therefore not enabled
>>> by dwc3_glue_clk_init(), and disable it again in dwc3_generic_remove()
>>> to keep the enable balanced.
>>>
>>> Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>> ---
>>>    drivers/usb/dwc3/dwc3-generic.c | 47 ++++++++++++++++++++++-----------
>>>    1 file changed, 31 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 2356b3bc0aa..704dd242553 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
>>>    	struct dwc3 dwc3;
>>>    	struct phy_bulk phys;
>>>    	struct gpio_desc *ulpi_reset;
>>> +	struct clk ref_clk;
>>>    };
>>>    struct dwc3_generic_host_priv {
>>> @@ -47,8 +48,8 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>    	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>>>    	struct dwc3 *dwc3 = &priv->dwc3;
>>>    	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
>>> -	int __maybe_unused index;
>>> -	ofnode __maybe_unused node;
>>> +	struct udevice * const __maybe_unused clk_devs[] = { dev, dev->parent };
>>> +	int __maybe_unused i;
>>>    	dwc3->dev = dev;
>>>    	dwc3->maximum_speed = plat->maximum_speed;
>>> @@ -63,22 +64,31 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>    	 * - in top level generic node, with no subnode (i.MX8MQ)
>>>    	 * - in generic subnode, with other clock in top level node (i.MX8MP)
>>>    	 * - in both top level node and generic subnode (Rockchip)
>>> -	 * Cover all the possibilities here by looking into both nodes, start
>>> -	 * with the top level node as that seems to be used in majority of DTs
>>> -	 * to reference the clock.
>>> +	 * Cover all the possibilities here by looking into both nodes, the
>>> +	 * generic node first and the top level glue node second. The clock
>>> +	 * must be looked up on the device that owns the node it is described
>>> +	 * in, the clock-names lists of the two nodes are unrelated (e.g. on
>>> +	 * i.MX95 the glue node has "hsio", "suspend" while the generic
>>> +	 * subnode has "bus_early", "ref", "suspend").
>>>    	 */
>>> -	node = dev_ofnode(dev->parent);
>>> -	index = ofnode_stringlist_search(node, "clock-names", "ref");
>>> -	if (index < 0)
>>> -		index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
>>> -	if (index < 0) {
>>> -		node = dev_ofnode(dev);
>>> -		index = ofnode_stringlist_search(node, "clock-names", "ref");
>>> -		if (index < 0)
>>> -			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
>>> +	for (i = 0; i < ARRAY_SIZE(clk_devs); i++) {
>>
>> Do we need a loop for two device pointers, where we are basically sure that
>> there won't ever be any more device pointers in the list ? (I think no, so
>> please use four clk_get_by_name() calls and be done with it)
>>
>> Also, please send this patch separately, so it can be picked as a bugfix for
>> 2026.10 .
>>
>> Thank you.
> 
> My fault, I somehow missunderstood the last comment and thought I should
> create a loop. I will change that and send it as a separate patch.
I could have been overloaded too and didn't explain it clearly.

In any case, thank you.
