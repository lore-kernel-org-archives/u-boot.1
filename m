Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C33C5DF66
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3569B606C1;
	Sun, 16 Aug 2026 23:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ew505u4uyYML; Sun, 16 Aug 2026 23:44:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A4EC606B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786923882;
	bh=yABB0j6VU/72qtiZ65+p8027E7PNEDT99RYGHchddkI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=H+dwAq4Dsgi+Hj1dH737OMJ6Y3FH9r5eiTVxVtZ1w4LhOd295O/IWxe9dzKFA9Ukv
	 yitscfXrIWV25Vw8Lm8otTImuNPlENlSy0ETcqQAejlsGJQPtTa9q5XTkt5j5jFcey
	 qnhW0u8f80GJTvRFVxoVwrZ1At/jQveFvqqoHppY/idXQSzMWl2iKanL0l9PiQ9OTM
	 joOx/rccLRGYfVWIEjeVEjjhC/xRvaoNdNBJK38B3P4tWJiU6YH1+iY4lZIiGVqqCt
	 7xBKgwKbHZhyGrCUfu4PjaHinNhurAZJeC+2j1rJWd+Na+jJkzO9FLbUc3s9517jNv
	 V/MsAAtq3+k3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A4EC606B3;
	Sun, 16 Aug 2026 23:44:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6820E2B2
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5951340634
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J61pLsB-Corh for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 43349405AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43349405AA
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43349405AA
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hNXck19dszMlK1;
 Mon, 17 Aug 2026 01:44:38 +0200 (CEST)
Message-ID: <e1b49626-4368-4657-8830-cecc1c9b7dc9@mailbox.org>
Date: Sun, 16 Aug 2026 13:27:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] spi: cadence_qspi: enable all clocks
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
 <20260814-rzn1-2026-10-spi-v2-1-973d5fa092f2@linaro.org>
 <43fec897-24f2-40f6-b1d4-63a7a171a013@mailbox.org>
 <aoBzB2o_KUD6NwrC@maple.netwinder.org>
Content-Language: en-US
In-Reply-To: <aoBzB2o_KUD6NwrC@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: trobke318ufd8erhsqnksfigqh1k8fya
X-MBO-RS-ID: 2f4afee78b299e7df60
X-Rspamd-Queue-Id: 4hNXck19dszMlK1
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/15/26 4:09 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:03:55AM +0200, Marek Vasut wrote:
>> On 8/14/26 8:28 PM, Ralph Siemsen wrote:
>>
>> [...]
>>
>>> @@ -250,7 +250,11 @@ static int cadence_spi_probe(struct udevice *bus)
>>>              return ret;
>>>  #endif
>>>          } else {
>>> -            priv->ref_clk_hz = clk_get_rate(&clk);
>>> +            ret = clk_enable_bulk(&clks);
>>
>> Some sort of clk_disable_bulk() seems to be missing.
>>
>> Fail path which disables the clock seems to be missing too in this 
>> function.
> 
> Ack for both.
> 
>>> +            if (ret)
>>> +                dev_warn(bus, "failed clk_enable_bulk\n");
>>> +
>>> +            priv->ref_clk_hz = clk_get_rate(&clks.clks[0]);
>>
>> Can the refclock be second or later (not first) clock in the list of 
>> multiple clock in DT ? If yes, then the clk_get_rate[0] will return 
>> bogus rate for another clock.
> 
> The right solution is to get the clock by name. But once again we have a 
> pile of existing boards which may not have the correct name ("ref") in 
> their device tree. So I went with the simple option of continuing to 
> assume that the first clock is the refclock.
Try by name and fall back if that fails ?
