Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA9606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GQBGKKWB;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Whi+c3aF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28B7B40807;
	Thu, 12 Nov 2026 06:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hQg4MyWz8AT; Thu, 12 Nov 2026 06:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6AD85405C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794464788;
	b=BqmQpoTIxFfEronrsTvrqUBzoLHaLJ7d4Quauu3WljMOnrSmJ0Ifc3swwVBpmJAq7Aa9
	 HLoLJH+YlXF0Sc6r4ceeXMFFuwdr3S2kRpD/QUqB5/E0NDDhdh2RkpV1wUkYkdrQmi5tx
	 O0Qg5rNxhNPyDz0DTdq5Tpu98SzWEFPShYefbnILeoT+3ltOYybouVf5jB76GcPK5TFIe
	 EEXEZtC7NaHl4IHy4J5fgOAEpmbfyrDCkGuyx67XX91w73aA3hYBUZASJYJq7/X2grlpA
	 +tuT1SB0AfQdyfo9/C3WdTESP+E+fcmpoUyq2C8cRtUasdw5MKZF+L6qivlQa8oF73A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794464788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8lygPlQbf8Diux6NRYHZj3EPGvCDgwGcZVOQ2CpCZ7A=;
	b=mNyffI+rZP7ygqmJsNaTG4PrO5wo/Cs3/HdGKXer6quX+9M5ku0tkuEfgAWDmaDR4cul
	 hEGuJAw1vVIaPshMnNjxUejyA67ubRgp2DtQ7pmylgbT55eGPjbZPHC8P5naCb3rmhh2m
	 ZTys056MoZIVSWCejVWkFjmWbrTtLwrOHMjIYPUuil1BYOXYZuvX2QBOo2FOeQoURCf/n
	 qlztqBRCZ0xlJWV8rlMuoP8VCjOrcfxO3S4ioeqNPTDFGHtw+bPTGiWSG/3QoUGfTFvtr
	 VktqN9zu3Xk9RdH6Yy22WIJUjooWg6DSnbZdJf2C20aueaXu6Y3Y2BYCcNZkcgB5Grg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794464788;
	bh=8lygPlQbf8Diux6NRYHZj3EPGvCDgwGcZVOQ2CpCZ7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQBGKKWBXXAKykPx6ecS2uBSDtaIBy40Vr7RTqlds++34vQSevMH2BMlqMuxhGmLb
	 wXZEnTU2Aq9GVPgzdCBcaublE32A0e/1CMUcBcrgHJoMGGAlcx1dDY6Aiu9EmPscVM
	 65K/MDZgbV8mp+gSM5YbJP1P/XVd94olJbHqdz0IZLdb963ZSfWNijKx8Dxaqxv6fa
	 RWqusZZtJhDDJ62aaxi/x2d1bqTQ1yJdQDJs/SrXHnik9jwfqSuO8/ONSfRQJVLJ/G
	 KO9+aabjKIxku7uBttmUXbfM6lsR6yKiBoChRp6ZE1AgEbvWoJj0IDBMNWLReU9CkY
	 o9Y0qb98gQcjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AD85405C5;
	Thu, 12 Nov 2026 06:26:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91754D7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83277608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRWGP4Dsw4j6 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BB0060897
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Whi+c3aF
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BB0060897
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:26:25 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jQ9Q606mNzKp2T;
 Thu, 12 Nov 2026 07:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794464782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lygPlQbf8Diux6NRYHZj3EPGvCDgwGcZVOQ2CpCZ7A=;
 b=Whi+c3aFyImcVfT4Xw3XJmZMeaMM5/6A/pVjqCvW6YTLdhwkgfz+cYEeQPt3Y4fsSwbC9K
 Geab2mWHSqH4dnShQlj556uqvLikxjSDl+5wP0wkna/1FXMwbA0CR52oVHZ2NubhSSnyHJ
 PubcONGFxDdBZnzdYYgk+GdS9JTzPSBGqj3m3X6BqA9YpOS1we+AKm9CR63jPz8slydzbV
 bTPo5mkq3PKfzU9nT3a9GzXVsnfyw5W4LgQDe/orsoywhqgrso/YyeIRiWBVT6u5NyuE2K
 kQ9ny9Wx9KudteYduAOWsSS/T4jkhSiP13CkLwknY8Y620GWHu3/8VUmpDFPAQ==
Message-ID: <b7fb9a05-6e03-4bfa-bed1-0d4319504d38@mailbox.org>
Date: Wed, 11 Nov 2026 17:18:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@nabladev.com,
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com,
 anshuld@ti.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, quentin.schulz@cherry.de,
 s-vadapalli@ti.com
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org> <avRoy3ghzzRPHWnu@monster>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <avRoy3ghzzRPHWnu@monster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pnqrskx87566tkobrxezhdkmioz5jrqa
X-MBO-RS-ID: 0d4c2379cf0bc67a9c9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 2:08 PM, Anders Roxell wrote:
> On 2026-11-10 16:18, Marek Vasut wrote:
>> On 11/7/26 8:21 AM, Anders Roxell wrote:
>>
> 
> [ ... ]
> 
>>>
>>> The rest is build tested only.
>> I would like to move this series forward, so let me get input on the status.
>> Below are the vendors which use DWC3 core that I could find in tree, can I
>> get a go/no-go on this series from each of you ? I hope the CC is complete,
>> if not, please add the missing people.
> 
> 
> Hi Marek,

Hello Anders,

> I have v12 of part 2 ready, with the review comments you had on a
> few patches in v11 of part 2. Part 1 did not change. Do you want me
> to send v12? Or do you want to merge v11, and I send follow-up patches
> with the fixes once it is merged?

I suspect this series is now v2027.04 material, since we passed -rc2 
this week. Please give others a bit of time to test and then do a v12 
sometimes next week -ish . Thank you.

> The fixes do not change what the code does, so the v11 tests still
> hold.

OK

-- 
Best regards,
Marek Vasut
