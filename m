Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5C606D802
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J6xhw5im;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=kU4hXww5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EA7340887;
	Thu,  5 Nov 2026 14:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaYBn0XkpjJM; Thu,  5 Nov 2026 14:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 566E840840
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887641;
	b=OR560c29VW9m99ro1GakMmyN6j1rb61Fua2klNM6RcJ7ls7XhtUW0Pxw8Lzc8zrRgyro
	 Lf5/nbnwKtKHzKdmUMFyaUYQuLn2ruII0KAgArZNKUCch8MvVDkr8YbzznplpZ9AnosFo
	 A2QxS7tk1TmKqkvWkb854cOck8AzuinFvK4ByUA/bYFg9X+24B4LgS/ryoQv3Lfq1mAH1
	 /Jev36o64laRx+VrhMr6S3feqRjKVShv7nVXOxYNEJ+XzLXEOjYgWk+UkKMEoGQmqGOeD
	 1IKLcXU2frKsgYL8p96i/9xS7iRVjOyfkBy5jubX/SJCT9nsetK38ys6rjF4VQmNkjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g+x5jkSKNISLl30niuXv7hQ2h22ayVTo4sr74yoD5+I=;
	b=ruWHvS10f+HcBYwGuzjww4jpBiHeOQRiEsJb2+5E+PqfRQZLCrj0kNXVmgC9+NpsN/fD
	 ILm7+acGhq/ypYCXlbD2iBJjBOnCvlYQ04qgsGY2/4BvwAT+0ZNY2zf5YOyd1suvYxJHC
	 /gGIdWnNJjIYYfNIe6thL26m7H3bUAefGr8R8gQ/9UMdMw5jjClqj6tcPAQ0JS9Qv46mN
	 /vXLdI/qNcTGSKXq6+41OLLN6H5JKr6XjRBeXlWkt/ziaszc84kNIEFxCY1RHGXucx/eI
	 a7ScyR4DNRLuZVvup/pGXncMHFMXP+OZ8pd0DK/5O5X+CQJGsWACR2jMMKO0znvrRIw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=kU4hXww5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887641;
	bh=g+x5jkSKNISLl30niuXv7hQ2h22ayVTo4sr74yoD5+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6xhw5imdeO5GmbbhgBfAuzvJLE7lJwBseKWDP+jjwDoGPTgZQNDdJgVIkJlH+wlz
	 HxICz/srbShBUkUkTTsjI9FAajqUzraH+lHC7G7tzfiZBqAQw55RSi6mGr4qOD9so6
	 2qT0XPjn2k3WnGPFgrs8I9qv/zXns6M0UhZfGpYBDONkQVwSfWY40rxN+WBPT459m0
	 dghZZnzFUDZwz8TgKJSp+xEGOcV2GzIwhjl1sxwl/ZAMrK6bGhqb4p71pTg7pcjImg
	 mYT4DpoHsKY557xWqksA57KHdf9vfET2Tz6r/7kMDG/DtwUjt9yTFzjb/NWqukPuHa
	 Hc9X9gCfozaQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 566E840840;
	Thu,  5 Nov 2026 14:07:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D1A3235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6378A40840
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EK_DysVBlI-r for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D42B4076B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kU4hXww5
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D42B4076B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:17 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jL3z54kt7z8sYm;
 Thu, 05 Nov 2026 15:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793887633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+x5jkSKNISLl30niuXv7hQ2h22ayVTo4sr74yoD5+I=;
 b=kU4hXww5p+SorKaDXzXlH7TM8EeV3zWJLwiOBNsz12iTYkeCccj9NoejUgKpuviSrif9gE
 DrdaYDTeeVsGs/vOxFLeYrLHqGb0XmniEHaK94x7fATl1BznGD4dMlvSIa7CMGfSmqjQ+8
 EL47b0YKP/aIdMgepOlm3+vC4m8m2El3hCJbOgj+eq3PLcozQowFp2wTE8VNPbqU1z0mQ4
 gecsljy3H2f0EDqn/ZgIWOnRI7PmHs2iuxjaQOYNeXfAavTLCnOn+r3BR+O7XwBH4Nl1Dm
 6GrYnjKncyh6OTvGrEXpu/QxqvtIc633uDPf1hoqmZ7AXHEP0ljHgqlglS25KA==
Message-ID: <a32da872-c8a5-48f6-b94f-db226ccbd335@mailbox.org>
Date: Thu, 5 Nov 2026 15:07:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
To: Takahiro.Kuwano@infineon.com, u-boot@lists.u-boot-project.org
Cc: kenichi.nagai.ry@renesas.com, trini@konsulko.com, vigneshr@ti.com,
 vjardin@free.fr, yuya.hamamachi.sx@renesas.com
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
 <896390bd13f4439297a31492e1a3dda5@infineon.com>
 <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
 <2d7719916f1a40288f80e0bfb63492ad@infineon.com>
 <636803e2-ea4f-47c9-9883-6cd070b1c772@mailbox.org>
 <fed118db71fb4578a13ca9eefa8fea9c@infineon.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <fed118db71fb4578a13ca9eefa8fea9c@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b0b9b0d17d9eb078067
X-MBO-RS-META: om5rr3w614qcbb6485iud5kdr5cj3bfx
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 6:55 AM, Takahiro.Kuwano@infineon.com wrote:
>> On 11/4/26 6:40 AM, Takahiro.Kuwano@infineon.com wrote:
>>
>> Hello Kuwano-san,
>>
>>>>>> From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>>>>>>
>>>>>> Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
>>>>>> with Post-Quantum Cryptography, SPI, Quad, Octal and DTR . For
>>>>>> details please see vendor page:
>>>>>>
>>>>>> https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t-nw/
>>>>>>
>>>>> Please use Link: tag.
>>>>
>>>> Does Link tag apply to arbitrary links in the commit message ?
>>>>
>>>> I believe Link tag only applies to lore links, hence I did not use it.
>>>>
>>> I have been using Link: tag with datasheet link since [3].
>>> I prefer to use the tag with datasheet link if it is publicly available in
>>> vendor's site, but I won't push for it.
>>
>> The datasheet is not available, it is only this product page that I
>> could find. Would you still prefer me to use the Link: tag for this page
>> and send a V2 ?
>>
> So, could you please drop the product page link then send v2?
> Description like your previous one for W77Q would be fine.
> https://lore.kernel.org/u-boot/20250720195901.414083-1-marek.vasut+renesas@mailbox.org/

Will do. Thank you.

-- 
Best regards,
Marek Vasut
