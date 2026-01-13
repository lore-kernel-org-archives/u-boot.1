Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDC7D30CDB
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 01:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC8080B98;
	Wed, 14 Jan 2026 02:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hX2js98p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3938003E; Wed, 14 Jan 2026 02:37:09 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA4C80433
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 02:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4drTHj72hhz9t31;
 Wed, 14 Jan 2026 02:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768354626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dq39FF1sUQdd12XS3zB5jo4NS/4Tu+7WoR6E/BKYcCQ=;
 b=hX2js98pdXKt+PCY+bnUe2S5C2Gbu41YgbSkut8XC0DV9F5R8tVPC2mYJo2EJU96ujqrSH
 gegLlKpv1fWj5ouVN0gf0KQBZuptJhy+RcrkvdaTxd49GSA6J0QJX3nehAaqAISzPFkOac
 lWp+mM21B/l9QE/v4YtsXS3I17l4ihrlQkxXec0g7WDuoLVCa18tCQWqZoHEwlgJAvg/8B
 DBJdMDeSLHnObSCbxYs0SpsheVTBWGUazvNYwG2m+ibbYUHbSZVXO1jzVeIWVtaLmQQnAQ
 IALY7idzyAQOdpi/v+FpRyTWNgd7Ud+2PHdwwPFksOZ/WaNV6tzPoxVIv0PuKw==
Message-ID: <5601b1a6-86e3-4865-b6f4-351be5a9820c@mailbox.org>
Date: Tue, 13 Jan 2026 17:38:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Tom Rini <trini@konsulko.com>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
 <20260112220323.GT3416603@bill-the-cat>
 <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
 <20260113150015.GW3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260113150015.GW3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ae00ca2e7aca63cdba9
X-MBO-RS-META: f1drdnaarexk86odk6cz94c4ui8ijq6k
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

On 1/13/26 4:00 PM, Tom Rini wrote:
> On Tue, Jan 13, 2026 at 12:53:39AM +0100, Marek Vasut wrote:
>> On 1/12/26 11:03 PM, Tom Rini wrote:
>>
>>>>> This we can fix in the Makefile via the dd command as suggested by Tom.
>>>>
>>>> My concern is about LEGACY fitImages (means already generated ones), not
>>>> newly generated ones.
>>>
>>> Why is that a concern? If it's a legacy fitImage for the OS, we relocate
>>> the device tree already normally to be aligned. If it's a legacy
>>> fitImage of U-Boot, it's an old U-Boot?
>>
>> Not necessarily, it could be new U-Boot using old fitImage, for whatever
>> reason (falcon boot maybe ?). We should not break that.
> 
> If it's falcon boot then it's the OS case and we relocate it before
> passing on, that's not changed.

Not always, cf the whole fdt_high=-1 bag of issues.

What I would like to see is something like

8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")

then we are safe against all obscure 4-byte-alignment cases.

> That's why I'm saying I'm not sure
> there's a legacy case to worry about, since the big change now is that
> U-Boot also demands correctly aligned device trees. The Linux Kernel
> essentially always has, and other OSes probably as well. We were just
> bad and let 4-byte work for so long.
> 
>>>>>> - Should mkimage -E align blobs to 8 bytes by default ? I think yes,
>>>>>> and frankly, I thought it does so already, but apparently not.
>>>>>
>>>>>
>>>>> This can be done, but should it be? Not all FITs demand an 8-byte
>>>>> alignment right? It is only the FDT which requires this.
>>>> Maybe if image type is flat_dt, it should be implicitly 8-byte aligned then
>>>> ?
>>>
>>> Well, the device tree spec says 8-byte alignment.
>>
>> 8 byte alignment of what, start of DT, right ?
>>
>>> It's not "FDT for OS"
>>> that's 8-byte, it's any device tree should start out 8 byte aligned, and
>>> everything else should then be naturally aligned. If we're looking in a
>>> device tree for another device tree to use in place and not relocate
>>> then that second tree must be aligned.
>>>
>>> Or am I missing something?
>> The discussion is about mkimage -E which generates DTs for U-Boot SPL use.
>> The DTs in those external data should likely be aligned to 8 bytes by
>> default, i.e. implicitly set -B 8 (they don't seem to be right now).
> 
> Right. So the only legacy case I can see would be using an old mkimage
> to generate a current U-Boot image. And I'm not super sure that can
> happen, outside of some sort of external to us tooling being wrapped
> around things, and at that point we have little control.
For that case, see above.
