Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65506CD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C238488A0A;
	Tue,  3 Sep 2024 20:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BfL9h4Dl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ANOgaTmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B36A88B49; Tue,  3 Sep 2024 20:04:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA7A887EB
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wytmy5CtLz9smQ;
 Tue,  3 Sep 2024 20:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725386674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7dL7MLden+e/FBcbkIdLEvcyJttb/7HLYU04RtppMk=;
 b=BfL9h4DlE3zsC7zns9PgVZV8pTDGCJPsklIIGC5n6+JDD0jHmwRh48Ue/ZyQAtp5XBPvl7
 bhwYNiXavI0GdCrU+He61DfzT0CuHASfZvJCyfhNsyfyG017z0nHunEzJDRSE8SZjwcoMS
 /JElCZRidEjzUsDUTTQbmEDI+iSeQ38MJIlhm5mEsOQXKc15WgoeA05wM+PTD/30F9e5o5
 8zqbQ16Kl1bdhFAXiNTv5EZKceL/EgTJSAn5T4HeBasOeWQJd/yUVdb85f/wp7/oGJj7np
 s3W7m1UgebrymqxQ4tiU2nclDyxolUUg42QmXtu/DUBpoMkxQZkB2Wjw2NY8Sg==
Message-ID: <62ca3ec5-f0a6-4819-88f1-25b1302926a9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725386672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7dL7MLden+e/FBcbkIdLEvcyJttb/7HLYU04RtppMk=;
 b=ANOgaTmA5pBAsBIjMe1TrHwzrv83mfBvLEvwfvMVbvyL6jOh75KmT0zcXDAaMl00cA63pt
 mRZHI+xLIwEic46TodlZtGZonFbR8Objw5uMLMAJ/gb3IRaDZXSauhKlKpuR/x/8G2Uw7W
 nAyw+MYQzy9x0gjrUqBYe/WSZvNWOgMTudI6C7PCkUG4JNtjy9sQDNH69kNlCeH3OOr22z
 HofMvXdvjZ4N7k5W6/Sw/WJohmkum/FwkjBxPwmohgyx41kTbqOcmk+2N4XW7rg6g6v5x+
 WahJ6waKvNEDfoFbuDxYnn5z8RhroKTQlqzSiu6Be8OuOFLnKacJnhGnFzulfg==
Date: Tue, 3 Sep 2024 20:04:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: Hide mmc speed command under mmc command
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
 <26339e14-1d8a-4471-acdc-902d0ef2ed54@cherry.de>
 <87v7zd6v55.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87v7zd6v55.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h7fys58cefih7equru9srnpwfnw9mgaq
X-MBO-RS-ID: 2e19f3afa56f838683a
X-Rspamd-Queue-Id: 4Wytmy5CtLz9smQ
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

On 9/3/24 9:42 AM, Mattijs Korpershoek wrote:
> On lun., sept. 02, 2024 at 15:41, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Marek,
>>
>> On 9/2/24 3:37 PM, Marek Vasut wrote:
>>> The mmc speed command configuration option keeps showing up in
>>> Kconfig directly in 'Command line interface'. Move MMC_SPEED_MODE_SET
>>> under CMD_MMC to make it show up alongside the MMC command.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
>>> Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>> V2: Rework the commit message
>>
>> Better, thanks :)
>>
>>> ---
>>>    cmd/Kconfig | 19 +++++++++----------
>>>    1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index 43f78a5aeb1..953e1f0ef2a 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -1406,6 +1406,15 @@ config CMD_MMC_SWRITE
>>>    	  Enable support for the "mmc swrite" command to write Android sparse
>>>    	  images to eMMC.
>>>    
>>> +config MMC_SPEED_MODE_SET
>>
>> I'm wondering if we should prefix this with CMD_ maybe? It's used in
>> drivers/mmc/ though.
>>
>> Anyway, not a blocker for this.
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> (You forgot Mattijs's Rb from v1 BTW)
> 
> Giving it again, thank you for noticing :)
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thank you both.
