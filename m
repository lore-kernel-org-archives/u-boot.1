Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0D6C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 13:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796FB80EB5;
	Sat, 25 Jan 2025 14:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OPo2sYBa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MKFkMsDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A489780EB7; Sat, 25 Jan 2025 14:24:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CEA80C77
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YgFl15nTQz9skc;
 Sat, 25 Jan 2025 14:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiKnm83EVJQGOOBY2WJa0WH3hOfAAPzSnRV9i6y1KQQ=;
 b=OPo2sYBaVE5/A06Ie6SZe/YmJJfXJCT99enrWCrqGj4gjqGuBij1vwFtm3GiJH2MFImjkk
 hP9BbaCMbnUCooUz3jkqWZ5MKxeLLY/tpjVHdj0OC/8bqVCjZi/tVhixuoGeyq2uy4M43F
 q1PZckgJc3JqOQfMZYHKrNxEIPcH4lOpJk0OsC1DexmuqB39X4vkuFpptfdIcb6SwOJnJk
 L4iZuTMeiR0cx0o17DDzzuQVULU7T7b6WVY2vcL+BgLFUd8xKtORi7TyQSznvL8cLEIwu1
 KPTgu8VRylfJIREIy4YBq4CCZG02D/C67ID8kb+S2+Cx8rRfhMfLR1OncdtzCg==
Message-ID: <af682948-a522-478b-a8b1-1223ac4b7137@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiKnm83EVJQGOOBY2WJa0WH3hOfAAPzSnRV9i6y1KQQ=;
 b=MKFkMsDCRrRORVaZonq3NeFf5rxs4G5L2OA+Bzmwvzg9vo6OZPKV1YaK5QERkLX38dHVEb
 ELN+AAwkO8gTgDMa4cOahhar/7P43n6+WID182SRnhnNnvE4/0+O18eNyNjDyzbSXZg8iE
 eRHB/IvqrB5SP2KiRocpzlvVGbUnW0W1YOZ4C3flVapVFWq5WZ0z55hOovxgFw/enTkrip
 lPuhMjd+W92/o3AS5e/QLiZ7djq9swrRFKDmeOHJomeKS6BgR/BRfoTC6uh+ZSir6a+QQT
 QVCGBfKRrU6ho5vwiCikoBEqqMqrOs5UUzllcGn5POgJN0xVn2t4XKbkHR7pLw==
Date: Sat, 25 Jan 2025 13:29:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: miiphybb: Fix short name length
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250118061558.124963-1-marek.vasut+renesas@mailbox.org>
 <04253048-71ca-43a4-8917-798d8ce027af@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <04253048-71ca-43a4-8917-798d8ce027af@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 199e02d31b65b088680
X-MBO-RS-META: 7gj8n3h1bqr4wcbtbboipishsu4zgjyp
X-Rspamd-Queue-Id: 4YgFl15nTQz9skc
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

On 1/21/25 12:56 PM, Paul Barker wrote:
> On 18/01/2025 06:15, Marek Vasut wrote:
>> Multiple drivers copy MDIO name into struct bb_miiphy_bus name, but
>> these two name fields have different length, the bb_miiphy_bus one
>> is 16 bytes, the source one is 32 bytes. Make sure these two lengths
>> are always synchronized, use MDIO_NAME_LEN for both.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I would prefer something like the following so that it's clear which
> source struct we're referring to:
> 
>      Multiple drivers copy the MDIO instance name from struct mii_phy to
>      struct bb_miiphy_bus, but the name field in these two structs have
>      different lengths...
> 
> With that changed,
> 
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Fixed in V2 , thanks.
