Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A624C0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 13:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C22B80EBD;
	Sat, 25 Jan 2025 14:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j1v6Ta/L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mRNk0pHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1F780C77; Sat, 25 Jan 2025 14:24:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2222280EE5
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YgFl65j2qz9sdn;
 Sat, 25 Jan 2025 14:24:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4p5QFJC1PrWsc2/jrsRq7t0x/XiiGxX3sPa+E2raxtU=;
 b=j1v6Ta/Lkl7pISeQIPa/avZ9NT96BTdlkUfMAdwGjE18q3gdokKkbU5X648UEw8IIsyQJx
 ENgvLTKTDa9Srx3kk1SuDBGS3m61otrWp35Abks4Bo4tfNO1dXfycrtLk52lNKlL4bZ6J1
 9559fCVlc3oLsFg0lDR5M0i90sDZ7xtOUaaOVv1aFYMshD7LkRUHnGT6jS5FapIltgHou7
 cwWHyRBARN873xxfcZnvfc4xXuskXcsFtMI1XRwztW66uOgccRzcDcaqNBkbyB9ZT5BlYw
 fPVlHJMkHQ3qoORd6tm2ULTnB7HxdvoHwijYFN49wa9DAcaVxjiJCAJry8r1QA==
Message-ID: <982868e8-0106-4e1d-812d-a5cd3e5534a2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4p5QFJC1PrWsc2/jrsRq7t0x/XiiGxX3sPa+E2raxtU=;
 b=mRNk0pHIvCZCgMOP0FAsOxRCNGkP/ehl4bUVKAN6KJyzTFN1WCwYyJn4HSPsNhDMM49cx4
 W6y6h+uXqdg6Cm4B1l8IoPk4YRx9NkqnRec+RJ6L8GnXEhmTxKwarE4UfNYIveyB3rUXly
 fpIvs71/Os21Z4WmR9PB+J4Uoc2COgiQ4mwDxUHgM8CiVjeUZmXHTZy0uc20Bgbqyu3BTl
 JC0R/SP4FSWa29R3KWEg4+9TkgJNo/QXDw3Q4YUKbqiHQuhVSOmW4X00j0Mg060bbAyuYv
 HoV2QLASGPqboAeoSSZS98PnFQmIS9QkZW12w4dNB+9BdA7mo6csSxiX2+FXTw==
Date: Sat, 25 Jan 2025 13:34:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] net: ravb: Drop empty init callback
From: Marek Vasut <marek.vasut@mailbox.org>
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118063458.137258-1-marek.vasut+renesas@mailbox.org>
 <44f1d2e2-7da3-4682-9402-b9b51f1b4dff@bp.renesas.com>
 <3f1613ff-7306-4f94-863a-a204617f3fb5@mailbox.org>
Content-Language: en-US
In-Reply-To: <3f1613ff-7306-4f94-863a-a204617f3fb5@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xkpjsi6gekpgz4ngoqpe5ubn1oxrqsad
X-MBO-RS-ID: 9b9a92f9f761fca6dba
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

On 1/21/25 1:15 PM, Marek Vasut wrote:
> On 1/21/25 1:07 PM, Paul Barker wrote:
>> On 18/01/2025 06:34, Marek Vasut wrote:
>>> The init function does nothing, the bb_miiphy_init() already checks
>>> whether the .init callback is assigned, and if not, skips calling it.
>>> Remove the empty init function. The entire init callback will be
>>> removed in follow up patches.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>>> Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>> Cc: Mario Six <mario.six@gdsys.cc>
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Cc: Ramon Fried <rfried.dev@gmail.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>   drivers/net/ravb.c | 7 +------
>>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>> index 7286ad19598..f9c27f0f370 100644
>>> --- a/drivers/net/ravb.c
>>> +++ b/drivers/net/ravb.c
>>> @@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
>>>       return 0;
>>>   }
>>> -static int ravb_bb_init(struct bb_miiphy_bus *bus)
>>> -{
>>> -    return 0;
>>> -}
>>> -
>>>   static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
>>>   {
>>>       struct ravb_priv *eth = bus->priv;
>>> @@ -626,7 +621,7 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
>>>   struct bb_miiphy_bus bb_miiphy_buses[] = {
>>>       {
>>>           .name        = "ravb",
>>> -        .init        = ravb_bb_init,
>>> +        .init        = NULL,
>>
>> Do we need to explicitly set this to NULL? The field should be
>> initialised to zero if we omit it.
> I don't think it does, this is only a safety assignment until this .init 
> callback gets fully removed in follow up series.

I would like to pick these two patches for the upcoming release, is that 
OK with you ?
