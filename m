Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F859CF45D2
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 21:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0F1836AC;
	Mon, 12 Jan 2026 22:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HBmgGXyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A568382A; Mon, 12 Jan 2026 22:57:53 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A24836A3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dqmT95dH0z9tHd;
 Mon, 12 Jan 2026 22:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768255069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09oOv1Xn5ovBy5BxYbNuRoQxEPMosbPXhYLgSE8o+BE=;
 b=HBmgGXyh/LE9PzBJ4L2oEX6ReYV4aC8VtwS7NVc+JWLLBs1y4ZU0UFRkaZlxLYbHpMdlld
 jVo5QB4UuqfBHCaU0AsNjJ7eooMXUq8PjM4Pmlrcs3DQCWUzKUhQF6q47AQ1bwPS6SvEk2
 9W84BAG6mtjv79+hatu4EtoDGyAHiT0wHSFa8u+WHHTdICxNkY8uGaYKiVek7atjg1u+wQ
 V1ZenpuiprwLb8SZPymijm4C5/d963u280esc8LyFfScWguW/UEUWJzvFmUeHKBg7Y9qIj
 ThBL/VlblpNU4E+Sa48qWraf2stDfn2d/wsRDoOkVfr1Exzn1h1vi67grhHjFg==
Message-ID: <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
Date: Mon, 12 Jan 2026 22:57:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: "Padhi, Beleswar" <b-padhi@ti.com>, trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 708bcb9bf05bcd86353
X-MBO-RS-META: 3wzrfym8habuz77wwkttdd87o3cyh47t
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

On 1/12/26 6:25 PM, Padhi, Beleswar wrote:
> 
> On 1/12/2026 8:09 PM, Marek Vasut wrote:
>> On 1/12/26 11:11 AM, Beleswar Padhi wrote:
>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>
>> Because DT properties are 4-byte aligned, and fitImage is a DT with 
>> long binary strings encoded in them. But that is not the case here, 
>> because the invocation does use mkimage -E .
>>
>> Therefore I see two issues:
>> - Should the code which handles LEGACY fitImages with 4-byte alignment 
>> be fixed to relocate the blobs ? I think yes.
> 
> 
> This we can fix in the Makefile via the dd command as suggested by Tom.

My concern is about LEGACY fitImages (means already generated ones), not 
newly generated ones.

>> - Should mkimage -E align blobs to 8 bytes by default ? I think yes, 
>> and frankly, I thought it does so already, but apparently not.
> 
> 
> This can be done, but should it be? Not all FITs demand an 8-byte
> alignment right? It is only the FDT which requires this.
Maybe if image type is flat_dt, it should be implicitly 8-byte aligned 
then ?
