Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C6C61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 03:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6038140A27;
	Sat, 29 Aug 2026 03:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tqeo21UIB7Ex; Sat, 29 Aug 2026 03:02:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787972524;
	bh=X1WyPCjJCsfG/9OXcuMvHS/n769R3bs1AHWhgH61LS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k55ONzmFJ4Bxzwso6khT154DGbC5kteOdoCX321jy+gpzx5q5Dfenr1du8N1NVUVm
	 8+bZIKxL6UNmFhU7f/gu7MOP8fCRS0U7jsoRHFb2njLTO6xQ+zdD8bMdil3/3EgX62
	 p3133CpQ3bSBsH6pS5Fo/RdhHszFjcfqxZ2XWGxbW/QoYiUkqr8DK5vTdKR2jevBOP
	 0ki5ZTVx1Ng+EOkrsMqbuTRUKiARcQaL5CxXj+vjPeNB/8gqcR8cbHCjefgve1AGzs
	 X5KUKb60tQ2JhR6ZPHg86UueDQw4XlFwCnsBBIvFoFfez6c2WHfz9OSgcE9wkJe4Zb
	 x6Ycjv0x8OZTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F029340A0C;
	Sat, 29 Aug 2026 03:02:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF05A1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 956EC40087
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GNNdEWxp4W_R for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 03:01:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=tF93ahoP; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OljmvGO6
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E12DE40068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:55 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hX0Qm3Xx7zMlBT;
 Sat, 29 Aug 2026 05:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787972512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1WyPCjJCsfG/9OXcuMvHS/n769R3bs1AHWhgH61LS0=;
 b=tF93ahoPRvDbDjZDafwsqmcZ1Cujmiv8cdBFU4eJdQSUS/EQW5GTuedacu/faZpNA5whwX
 863TBYInNaRASl1PYe5ZPGwUo3fKB6Ll4ICCcdMuEjAA1t/ww7Z4EykBS8AGUI2+M211gd
 n9SDEP7Jbt0F/HJY24xY506eJsfFE33e5Sd/ufNYKaTt+nklmB+XvlgMKuNjYwWHFz/dVS
 Rcs2GQS3ol5VoxPdt1t5Rr4YnsH6UfuqJRxDgMDtf6wuGdK7GDvK+f+glJyHsEZsxodBqh
 bY/GnvSi+k0/gphbL88VvjU8HXnEdy70Nj06mzt4HJceRGqejFQgWKO8jVbitw==
Message-ID: <89aa40df-e38d-45a0-a422-4ef045153771@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787972511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1WyPCjJCsfG/9OXcuMvHS/n769R3bs1AHWhgH61LS0=;
 b=OljmvGO637x9DAVI028LeX0R+KFIfE8Y5fmTxYNSQqa+8FfpNzho2qhylGGRuXx555SXhF
 P2U6C/atN2Y+hkTJ/96p5jU1k1NAzIOuQYYCICy/tegjekNL7nV+tlntVteu2Za1ivHvil
 nOFyVq7lFqIlMEuQHwDXYsHaV2z0J7umMdxq/n2Iga4NDBMUQkLw5f/wjrkSDtqnzV1Qt6
 HJQYPmdmfwZatUN/Y+iG0vUgW1AZJK/AP+v9aTbb5z3jElPtpAKGUuc+93bO2gUINBziUY
 bEpXXX6S3vLULvMNROY1wlATgheqbh5b29Hqeiq9+AGSwCPuM1b+OHMlFkcIdg==
Date: Fri, 28 Aug 2026 23:18:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
 <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
 <apHK_Q-dogLc3Mkr@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <apHK_Q-dogLc3Mkr@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aeenikz5h4bb9s65b5mhed95znu46txo
X-MBO-RS-ID: 3d7253b7558f8e70295
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/28/26 7:53 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:25:10AM +0200, Marek Vasut wrote:
>> On 8/14/26 8:38 PM, Ralph Siemsen wrote:
>>>
>>> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/ 
>>> Kconfig
>>> index f86acc31039..4d16d541443 100644
>>> --- a/arch/arm/mach-renesas/Kconfig
>>> +++ b/arch/arm/mach-renesas/Kconfig
>>> @@ -70,9 +70,13 @@ config RZN1
>>>      select DM
>>>      select DM_ETH
>>>      select DM_SERIAL
>>> +    select DM_SPI
>>>      select PINCTRL
>>>      select PINCONF
>>>      select REGMAP
>>> +    select SPI
>>
>> Shouldn't this be in board config ? Not all RZN1 boards likely require 
>> SPI ?
> 
> Any RZ/N1 board that makes use of the QSPI will want this.

That means, move to board defconfig.

> It could be 
> done in the defconfig, but it is easy to miss, and not fun to debug 
> (took many hours of printf() for me to find it)

That is board defconfig bug then.

>>> +    select SPI_MEM
>>> +    select SPI_DIRMAP
>> Shouldn't this be selected by the SPI NOR driver instead ?
> 
> The same driver has other users, but they may not all want DIRMAP.

Why would they not want dirmap ?

> I will move these settings under TARGET_SCHNEIDER_RZN1 so they are 
> specific to this board.
OK
