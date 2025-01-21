Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E3FC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9619480326;
	Tue, 21 Jan 2025 13:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rm1zuqCX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CVmC3Uw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C931A805C5; Tue, 21 Jan 2025 13:15:38 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9499801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YcmPg2pWpz9t33;
 Tue, 21 Jan 2025 13:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737461735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbHf0sMnWZWUhlIFZAsIDiIJM7K/cQc0KQxpv2QRcAU=;
 b=Rm1zuqCXZy0q9HG4Thr1FCXJK83S6S/xVS0S2ZuiT5LlLXj2/Aqffnjwkrjvy+VqRSrgM8
 FBLKqJr75+mMwrxDKzUHy6Oh5ILe3a12ZDdmKKvu+MhfH/BABob3Y8jIb6mAqcr8RZEf53
 WV/PPT0kc3nHsK4H6NvYEXhtTb1QDm0z3z8djUjhzp5IAUpLr1FyHur6u6LT6CverSqm2/
 QJKJTf3upRtNuKuCWBJnQX7uzEueD1s54UHHwdyJf+XkJEPYklFkYoRB9m2a0nI2DDTWEk
 dC1a2SWVww5nyhq8oA04DpwBEAqNdCpqEGm1v2XjWm3QY+shXFoCfBAQUHRJOw==
Message-ID: <3f1613ff-7306-4f94-863a-a204617f3fb5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737461733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbHf0sMnWZWUhlIFZAsIDiIJM7K/cQc0KQxpv2QRcAU=;
 b=CVmC3Uw1QTO5wMd+yjkmcbM72nnR5uEQcnBN6wZUeYgm0p2M+6BoIKT280o0fDsEOoisKm
 KwrNXbXDhsmXYWOmjpiqFH4RdHprDtofJi/uAcSiJ/k1DnIEiQ6zOoV23nZM14rsjL2XcO
 lJjgQh7eDoInaOamrG/QLQb8WVF0W1t35DYmxb1Catbj0eU53eZwhIodSG6kieqWvREFQx
 a7jT+Krm9+Cgg7PBLHpeUYOmwK2kof6ZcSzMii6p6tC7LERkPYDIJ3xJupPDgj6ndDFEHP
 ddFgYKMtlzvr2sVwTTc7Cs//0X7jDBfPN7MhIgjYNZz0Hmf7HyHMJmrVFD+QZg==
Date: Tue, 21 Jan 2025 13:15:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] net: ravb: Drop empty init callback
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <44f1d2e2-7da3-4682-9402-b9b51f1b4dff@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6rerh9oshtoxwhn6o33p61ikxgkg47ht
X-MBO-RS-ID: f34dfcf5814a9002e55
X-Rspamd-Queue-Id: 4YcmPg2pWpz9t33
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

On 1/21/25 1:07 PM, Paul Barker wrote:
> On 18/01/2025 06:34, Marek Vasut wrote:
>> The init function does nothing, the bb_miiphy_init() already checks
>> whether the .init callback is assigned, and if not, skips calling it.
>> Remove the empty init function. The entire init callback will be
>> removed in follow up patches.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>> Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Mario Six <mario.six@gdsys.cc>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/net/ravb.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>> index 7286ad19598..f9c27f0f370 100644
>> --- a/drivers/net/ravb.c
>> +++ b/drivers/net/ravb.c
>> @@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
>>   	return 0;
>>   }
>>   
>> -static int ravb_bb_init(struct bb_miiphy_bus *bus)
>> -{
>> -	return 0;
>> -}
>> -
>>   static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
>>   {
>>   	struct ravb_priv *eth = bus->priv;
>> @@ -626,7 +621,7 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
>>   struct bb_miiphy_bus bb_miiphy_buses[] = {
>>   	{
>>   		.name		= "ravb",
>> -		.init		= ravb_bb_init,
>> +		.init		= NULL,
> 
> Do we need to explicitly set this to NULL? The field should be
> initialised to zero if we omit it.
I don't think it does, this is only a safety assignment until this .init 
callback gets fully removed in follow up series.
