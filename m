Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B171C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 11:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF8D81119;
	Mon, 27 Jan 2025 12:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AR2YXasj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TVUSBkev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892AF81119; Mon, 27 Jan 2025 12:30:56 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3477680087
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YhR7K67fTz9sZZ;
 Mon, 27 Jan 2025 12:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737977453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBafmWqF85S3aWAByn4Mgg2HqQcXadR3ZA2JrtWr8Wk=;
 b=AR2YXasjtMyr9/9nFpSfCqnh7hFUGFGCPYCkdEDVKWDfWp7A/AK/KufFSdtHO7F0IU/rLG
 IA2tY6eMB28qWTDz5gCBEqGTawFCJ3EChF2TFSjbnvUtojVux21P/57P87RauIHfAFoLbJ
 YLPE9NnqSGD/mRWwieqV6ROB1Ev323YRu3oDM1oybQ3m63v8+PJyLMcLY8z4YjMrcNOV61
 iiqBSZ4Cs6bG5Z3UFyEUodPvFI4DEtLUd6hnQRDMX4kk6++h5CqC6oYC7r8XcXanIUskZO
 9FdaPqFK2DEUwVf8orV9R8JWa6BoAeCXDc3ihpOkSu/ut3V9CFi/N3uEvIfuVg==
Message-ID: <c025e008-48ee-41c0-ae47-2d348058a635@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737977451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBafmWqF85S3aWAByn4Mgg2HqQcXadR3ZA2JrtWr8Wk=;
 b=TVUSBkev1FWEqFcs5ikO9XUl3ml0Tq5MGNN8hq0zGrc8KIWOhM8OewbIGRTWbnLvo2samM
 MD1LFetBMkeYemx06l+iGi0K2Dh7wRe/9WHwW07KC7I2NiryQs3WLORgxpZCOJA5MW5BQN
 AZan/SfONsEVqJi/B0AuysMqvM0KHa0KUw3VynLUVohratAZWA3GEbcWJDRq71wq5Qcwto
 a2tA29Y2VFOh3uAOW4M7vAKS7cd6S4gMsLFoqJPK5AISD+TirSJtJfCf3b5OXhT5S9q+MH
 zwaHGZaK5YbiyPRg53crSl03ImkhMwiBja8ZDjr1gcnSNzoMIczBlz6AjIQWVg==
Date: Mon, 27 Jan 2025 12:30:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/17] miiphy: Introduce mdio_init()
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
 <78ea8dbd-56ae-49a0-b9f9-274a8cf9182a@bp.renesas.com>
 <273bc749-8378-40de-b533-6c58a4569f0e@mailbox.org>
 <dc02c0b8-55d3-49d7-8aae-012bad61b183@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <dc02c0b8-55d3-49d7-8aae-012bad61b183@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7dbkrrxf964f7efrwn46yejp6h6pu8u3
X-MBO-RS-ID: d5a43c6654b9e6e1176
X-Rspamd-Queue-Id: 4YhR7K67fTz9sZZ
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

On 1/27/25 11:32 AM, Paul Barker wrote:
> Hi Marek,
> 
> On 25/01/2025 12:56, Marek Vasut wrote:
>> On 1/21/25 3:38 PM, Paul Barker wrote:
>>> On 18/01/2025 06:53, Marek Vasut wrote:
>>>> Introduce mdio_init() split off from mdio_alloc(), which is used
>>>> to initialize already allocated struct mii_dev.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> Replying here for the whole patch series...
>>>
>>> I like where we get to at the end of this series, but I don't like the
>>> intermediate state where the bb_miiphy_buses arrays still exist but are
>>> unused. I also think we should introduce a new ops struct so we're not
>>> duplicating function pointers in each instance of struct bb_miiphy_bus.
>>>
>>> I would prefer the following order of changes, let me know if you think
>>> this would be cleaner:
>>>
>>> 1) Introduce mdio_init().
>>>
>>> 2) Add mii member to struct bb_miiphy_bus.
>>>
>>> 3) Modify each driver to use the mii member of the appropriate struct
>>>      bb_miiphy_bus instance, calling mdio_init() instead of mdio_alloc().
>>>      At this point we're still using the instances in the statically
>>>      allocated bb_miiphy_buses array.
>>
>> Those instances might be rodata , so using them as read-write storage
>> does not necessarily work , does it ?
> 
> None of the instances in the current U-Boot code are marked as const,
> and the name field is already modified at runtime by each driver. So I
> don't think we need to worry about them being rodata.
Can the compiler not decide to place the structure into rodata if it is 
never written ?
