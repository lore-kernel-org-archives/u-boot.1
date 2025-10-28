Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF33CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ECA82A9E;
	Tue, 28 Oct 2025 15:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ClnS61U9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sDJrC8qQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDDD832AD; Tue, 28 Oct 2025 15:39:25 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF7380422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwtLM12c7z9t9t;
 Tue, 28 Oct 2025 15:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761662363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/TcGZItNadutmzHwdqg49VN5jfzglOxpzdMp+r2evk=;
 b=ClnS61U9i9+228MC+kUgSlOigxyxklV0N3vb28zatBSl4mBTig1NX/E9rBUDM33K8PT4PQ
 b/ttAUj+xEhw5eE8CU/sk5LvBzetv9vg+uQKJjUVfdPXh64uH49x/zHeknz7K81voWdqZ/
 IRDhAJdtK7lzvIPrewNx2vnvOimvn5sMkLlruINY2fPU2ub9pCKekj6N248AwgDbvjIVW4
 wOMP34YFQTLL4J8EXTIHmKDXuxaQqvHWi4X6fznnKP07EGef9HmalR56W8C16dds+Hekj2
 wHAcKnQ8b3tYUzZdRwPIKSe7B0yI8rUVWGAEoEE+m6gwD3uHq7zhVxz07Ku3Rw==
Message-ID: <4b42a07c-5660-46e7-ab53-572a3eb11a2f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761662361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/TcGZItNadutmzHwdqg49VN5jfzglOxpzdMp+r2evk=;
 b=sDJrC8qQy0OEdHoY2Y+M3Dsv45nG4/RC3zBAJlqa0BX0kHjPe/5DH9fjkyUKFlNGie20Cc
 eCAFSy+pCtG6OWAcpUFZpOjxqmt6giHi7H+Rqi0xJbEgKfZ4Hu65a728ViPB1plL5s20d9
 IAl7AIU4mJsm5XFJnyJ855tGOhRRiEVoOv6DCf1mJmI1lRigB2DS6l+So2mO4InpvcNOGp
 LNW11T1jHHoJmENLLq94qmOmqWW/sgTbvQWEsjLcV9URrUeGK0MRj0rlNnxuylu99jYf8/
 H8p6UsTWQXxf9By47CfQdqwlivW2tGGv4NpiNJ0XE3eDbCE8rW5i5tMGjVjCDw==
Date: Tue, 28 Oct 2025 14:51:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] clk: scmi: Postpone clock name resolution
To: Peng Fan <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
 <20251028115645.GA9371@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251028115645.GA9371@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 92f8ee7ef2b42426be7
X-MBO-RS-META: h4afj3ag8pfzu6esiktzuctxen9tqur6
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

On 10/28/25 12:56 PM, Peng Fan wrote:

Hello Peng,

>> @@ -325,24 +326,20 @@ static int scmi_clk_probe(struct udevice *dev)
>> 		return -ENOMEM;
>>
>> 	for (i = 0; i < num_clocks; i++) {
>> -		char *clock_name;
>> +		clk_scmi = clk_scmi_bulk + i;
>> +		char *clock_name = clk_scmi->name;
>> 		u32 attributes;
>>
>> -		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
>> -			clk_scmi = clk_scmi_bulk + i;
>> -			if (!clock_name)
>> -				ret = -ENOMEM;
>> -			else
>> -				ret = clk_register(&clk_scmi->clk, dev->driver->name,
>> -						   clock_name, dev->name);
>> -
>> -			if (ret) {
>> -				free(clock_name);
>> -				return ret;
>> -			}
>> +		snprintf(clock_name, SCMI_CLOCK_NAME_LENGTH_MAX, "scmi-%zu", i);
>> +
>> +		ret = clk_register(&clk_scmi->clk, dev->driver->name,
>> +				   clock_name, dev->name);
>> +		if (ret)
>> +			return ret;
>>
>> -			dev_clk_dm(dev, i, &clk_scmi->clk);
>> +		dev_clk_dm(dev, i, &clk_scmi->clk);
>>
>> +		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
> 
> There is still scmi_clk_get_attibute for each clock. In commit log,
> you mentioned this takes lot time to complete. I may miss something,
> what is improved in this change?
That scmi_clk_get_attribute() is finally deferred in 4/4 , which 
improves that . I tried to keep the patchset reviewable, so I split the 
rework into multiple patches.
