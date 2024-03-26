Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD7CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A3187E1D;
	Tue, 26 Mar 2024 23:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KqYVSrjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F210987E3F; Tue, 26 Mar 2024 23:20:04 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22EA87DB1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V44405r5yz9sbr;
 Tue, 26 Mar 2024 23:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSN7Pfh0rFGwSk+cR6hbp6hZT7YRBGPtnv2LkWCJHVc=;
 b=KqYVSrjDd7gdfAVJ7wD4V37oPHQjQ9WRNy22tcWsGeH5hHcJZPG33L9UCB1cK1T6yXpp10
 ikvgaKnDoSxo/Ge2dfRaXAYLnFHgbEEPj/wOhRMrE5SznsbNlt6qJ+HIaOD7Ozek2fsm+6
 wICoPSzAwP25BxSdTlWcMERWpBIr8pVys3L/PQA4BZ/1CWI2ieXK6Uqp+VI4tkM6UsRgkR
 UyHGO194960PRUVF1x/K3mYz64BAnYqseotd7fDA2yZWJhhmmDb3jTsZ5D6BnM6paPlNbS
 tIYm/5ixhJA1GcvqVsdLgBKKhC30w8kr0porLywgbt+RNQX8mxFWcNoQZJhMzw==
Message-ID: <3a83f813-0780-404f-bda5-ae20e5b78148@mailbox.org>
Date: Tue, 26 Mar 2024 23:19:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] boot: fdt: Clean up env_get_bootm_size()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
 <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
 <20240318161813.GF13682@pendragon.ideasonboard.com>
 <b13328fd-03ed-49e0-90b2-0f0697e8c415@mailbox.org>
 <20240320210015.GA2539@pendragon.ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240320210015.GA2539@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 79dnb7ipqro5rgphgdsu5t58u9sxf94c
X-MBO-RS-ID: 45d07d8aeb6f91aa567
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

On 3/20/24 10:00 PM, Laurent Pinchart wrote:
> On Wed, Mar 20, 2024 at 09:52:34PM +0100, Marek Vasut wrote:
>> On 3/18/24 5:18 PM, Laurent Pinchart wrote:
>>
>>>> @@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
>>>>    
>>>>    	s = env_get("bootm_low");
>>>>    	if (s)
>>>> -		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
>>>> +		tmp = simple_strtoull(s, NULL, 16);
>>>>    	else
>>>>    		tmp = start;
>>>>    
>>>
>>> Maybe you could even drop the tmp variable completely by writing this
>>>
>>> 	if (s)
>>> 		size -= simple_strtoull(s, NULL, 16) - start;
>>>
>>> 	return size;
>>>
>>> I've never liked variables named tmp :-)
>>
>> No, let's not do this. With this FDT part, the code should be verbose
>> and as easy to understand at first glance as possible, no subtraction
>> assignments and other shenanigans please.
> 
> How about this ?
> 
> 	s = env_get("bootm_low");
> 	if (s) {
> 		phys_addr_t low_addr = simple_strtoull(s, NULL, 16);
>                  size -= low_addr - start;
> 	}
> 
> 	return size;
> 
> If you're going for readability, that's clearer than
> 
> 	return size - (tmp - start);

I do not share this opinion, the subtraction assignment makes this 
harder to read. If that makes for a more verbose code, so be it.

> and it also interestingly points out that tmp/low_addr should be a
> phys_addr_t, not a phys_size_t.

The original code already contains trivial 'tmp = start' assignment, so 
these two types should match, and they don't. Fixed in V4, thanks.
