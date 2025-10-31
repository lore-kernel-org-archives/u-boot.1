Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B048CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 21:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CB383B0D;
	Fri, 31 Oct 2025 22:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nTZp5pXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FCB83B0E; Fri, 31 Oct 2025 22:27:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294E083AC6
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f3a5=5J=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761946053;
 bh=5wJ5rKq5ZJJHp8B9gl3VbXWEnnswdbU5+79eq72SdGI=;
 b=nTZp5pXn5O8HDuFz+4MMz51ytwm7hJZURa5JOJxu2v+QLkUvTxj9yOd3+KBfjlJP043ntpRqD
 p70aQNdmPRSkqbTSzZ8gJAHArEKrOO29gFoXKqZmJJiGkpb3bMyKH8/Str+fvZrbzXFrN/NdKAc
 df7p5aQDves+eBOt8z6dhga0jOUhz9YQrsbmVRpm6zY10qhwFMekcaCUjGdwRq0uzA1bq+1pbjK
 EJ+AFMBQRhs/BaXManqpY9MR6eycuJBRDkp+cr1Av/yL0mVJqTKNHax5NoPw9xEGqDrp6e9yf74
 Ef8NoNOu5E3Sp3QVyde+WZ6f7LKndK4e/VLjjjWbPlzg==
X-Forward-Email-ID: 690529be0a03120dafdbb96c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3e1590fc-19c9-4e89-a280-cfc975bda8a8@kwiboo.se>
Date: Fri, 31 Oct 2025 22:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Sune Brian <briansune@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
 <CAN7C2SDpWi4-+adCT+KbW7mhBHvxe95YGin2qv+AHRAkc1=ASA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAN7C2SDpWi4-+adCT+KbW7mhBHvxe95YGin2qv+AHRAkc1=ASA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Brian,

On 10/31/2025 10:02 PM, Sune Brian wrote:
>> Your original mail mentions "sometimes fails" and that you tested U-Boot
>> v2026.01-rc1+, the most recent change for the nanpi4 family was related
>> to sd-card regulator handling to improve reboot when card was using uhs
>> speed in os and boot fails in spl due to this.
> 
> I cant 100% conclude all boards and situations so I used "sometimes".
> 
>> Please try my suggestion above, the datasheet for the LDO mention 50us
>> start-time and card may need one ms to fully init. Defining this timing
>> requirement in the device tree that U-Boot SPL uses should match the
>> workaround/fix you mention in your original mail.
> 
> w/o modification do your board experience any sd card error or stall during
> boot phase?

My M4B could boot using sd-card without any issue last time I tested.

I do not understand the purpose of your original mail when you do not
seem to be willing to test suggestions from board maintainers. I will
most likely just ignore any more replies from you, sorry.

Regards,
Jonas

> 
> brian

