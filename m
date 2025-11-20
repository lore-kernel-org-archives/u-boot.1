Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF9CFA441
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 20:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF9C8405F;
	Thu, 20 Nov 2025 21:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ghTPNkBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162898409E; Thu, 20 Nov 2025 21:14:17 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A4E83F14
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 21:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dC8h40LWHz9tdq;
 Thu, 20 Nov 2025 21:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763669652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JMfVdtGIdE5lPYNI515bIqXLh7M5EsiqJ5jJ8TO/HQ=;
 b=ghTPNkBVrYDMlVgIO/JE8Uqy6VYXKFPu+M9+QQzRploUpLzx1FReotTR98CGl52mOxt03/
 ILEL36hmYlp9hatz8BcCcQEew62yBF+I+1NrIDI+w24eab532b0LGielQGrAXVTAa7jqkx
 ndMHtTdVVze8lSH7yLHRvb6lONpRh0Kcz5zSYBSCju9W7mam9WG6zfODFnjW/tQXiAMhJg
 4T7rKbUAqafFgHLh9nNslh3mrRbMJz9hCEbRzq5wtslHbDXZI3kOfKsqMCxljYLI/xatfJ
 KWx8nwVVxGcVgT+59uQ3IVwb6VhEPSV0QW1b6kAuSqeScFgDkxR5kVt+IKLr8A==
Message-ID: <49969be7-b05f-4763-bf75-10b8d4cfc7c7@mailbox.org>
Date: Thu, 20 Nov 2025 21:14:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
 <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
 <20251116141151.GC2125796@bill-the-cat>
 <11a631a3-644a-4c4f-8b09-7202687a4a90@mailbox.org>
 <20251117184027.GN2125796@bill-the-cat>
 <5dd7d2e7-7e1d-432a-b737-ae4dfa2689b2@mailbox.org>
 <20251120155401.GI2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251120155401.GI2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ed436d99060564216aa
X-MBO-RS-META: bpc86nuziuu4f56aguz7pwtkfd7ucxk3
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

On 11/20/25 4:54 PM, Tom Rini wrote:

Hello Tom,

>>>>> , and then
>>>>> every follow-up location doesn't need to perform that (or possibly many
>>>>> other as well) validation checks. My impression from when I looked at
>>>>> the code last, a few year ago, was that it was designed with "validate
>>>>> with most? every? function" and we would be happy enough with "validate
>>>>> once".
>>>>
>>>> If you can make that assumption -- that whatever we feed into libfdt is
>>>> valid -- then we can simply patch out can_assume() .
>>>
>>> Maybe the question I have then is, why isn't can_assume being optimized
>>> out at compile time, if we set the mask right. Makes me wonder if
>>> there's not something to fix upstream too. Or maybe we need to change
>>> the default to higher than 0?
>>
>> Maybe because the mask is set differently for U-Boot and SPL , see:
>>
>> CONFIG_SPL_OF_LIBFDT_ASSUME_MASK=0xff
>> CONFIG_OF_LIBFDT_ASSUME_MASK=0x0
> 
> Right. We might want a different default for full U-Boot at this point
> (not assume perfect, but also not assume nothing).

For SPL, we assume perfect. For U-Boot, we assume not valid at all.

I think this configuration is actually what we want, keep SPL size 
small, perform validation of DT in U-Boot because it might come from a 
command line.

> But still, I would
> have hoped SPL growth was smaller, but perhaps I just need to
> re-evaluate things. Let me know when you have a next iteration of
> everything branch somewhere and I'll run the size growth build before
> you post if you like and we can iterate on it.
The latest is always in u-boot-sh / test-dtc branch.
