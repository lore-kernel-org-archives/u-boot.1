Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CEEC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 23:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5874C81B42;
	Wed, 26 Mar 2025 00:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E4rQNxsd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EyJJCFEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F024F81D3B; Wed, 26 Mar 2025 00:02:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFAA81C84
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZMlmh1JJjz9sk9;
 Wed, 26 Mar 2025 00:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742943732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTU8fh/yoMq4srYeNdKuJiw4o1QV7TBLQzGwQPtupVc=;
 b=E4rQNxsdFNfZm+7JZ6x6aNx1VROXQzjxOgBovEm8LNeH9HJQ2CayoHiQjxVjFHmrRIsQp6
 VbWAEEgMsd8B/l7oSRF0v8YVcgLxIh03N6Wx2QFhqmTFoUqXgPTUExgp+iKi3iIWdlfnXm
 mfeaLbdAZY8K1HHCKNsje5/pDhRUeXqHPo1MPW/+VkA0xdKqPpIEHQYL4h7kbxM6Uw1pav
 xyGV1JuwxOH+AbZIWVRoWPY8RE3zTZ9HWrLrQMIkxljUVSwRJigsDP2UtVm9Nxq4ZOyTY4
 QFQ3MHtX0rEx3gY37Xs92aGPKLJkk70UFBexkWD8gA+5wEI/Xn26daZgUNj8YQ==
Message-ID: <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742943730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTU8fh/yoMq4srYeNdKuJiw4o1QV7TBLQzGwQPtupVc=;
 b=EyJJCFEWFCLcitECD1hXnr5a5TtRnuKojrDerK/DIBAQqUcwwGyGmxDzQk63h8RLO7SiE6
 ZAhjb2RKcy9Y0H0wnoHvO4w9OvYqF7a0uf1MgNaek+wr+hzzrcCHOI/ON+iJ6M0Lzanya3
 aTyrKMN2LcPZ4l5ScNWD/Wt3V4gui77FuRFFZ+KgSx9uCfYjjAbXqDwQVSr/tzJdPnFBow
 y5H1cGiZQkcJFY8kyEw62fTs9HwmTUQla5tsU4ohCyY94EhQs89cyhbfe2y/4fTnAZuBux
 nfH1aNBOw7i+uP4GUcHs6v6ByBB77RnyK+a1oUK7MBXLd5HermwxYuMOZcZxJQ==
Date: Wed, 26 Mar 2025 00:02:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
 <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8uzab8b8eky74d1ptu7ajp846n6d93ki
X-MBO-RS-ID: a631d61da01676b7933
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

On 3/24/25 1:39 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 3/22/25 10:55 PM, Marek Vasut wrote:
>> Rename the variable and add ENV_ prefix, so that all configuration
>> options which are related to environment would have an CONFIG_ENV_
>> prefix. No functional change.
>>
>> Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
>> index, a number, as enumerated by U-Boot. Update the help text
>> accordingly.
>>
> 
> I disagree with this part of the rename (MMC->SDMMC), our drivers all 
> are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for both SD and 
> MMC. We also have ENV_IS_IN_MMC which is for both. I don't think it's 
> worth the confusion.

My main problem is, that it is confusing to call everything _mmc_ even 
if most of it also applies to SD . There is no way to discern parts 
which are MMC specific from parts which are common to SD and MMC now.

> SYS_ prefix to ENV_ is fine though!
> 
> DEVICE_INDEX could be DEV_IDX too if we want to shorten the symbol name.

No abbreviations please, it only adds to confusion.

-- 
Best regards,
Marek Vasut
