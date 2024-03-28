Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A98CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B287988146;
	Thu, 28 Mar 2024 16:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B1S8YbnJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tUwmtBPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7ED88176; Thu, 28 Mar 2024 16:57:23 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DEE87D9C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V57TX3srsz9t56;
 Thu, 28 Mar 2024 16:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711641440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnrQz7zJ5TYRQJ8RhAZGjvdCEJDD2LqyzTEIo7jEnN0=;
 b=B1S8YbnJCmg04SuqPtRhEoj8pBu9iXh72yxwGA4oFcesYbyxYJhVQfx+SA9XIjH897331+
 z4ANuSaXijUI3o1q1ZSrbwwy0NQXTSv6/zosailX+Eu6KuGhsAKuxzdtZ0SKAxAI07g3kO
 qzYuFT9wOxJxaNmPiwgucCFmticgJnuaG/R3nkGMM8L4OuJGwDaPMI2lppEbLKJlnd1wQJ
 O9QvJpDqb2pu2S6+q+xswH0Q8nWYmbXgXOLDyDlYlKcsWu60TUSsWC+c8H+2n/GNQjmaOD
 /Ihcsfi/PRIQTefiAEDVFKNnqvVHaBXIG3yv5oMHQqQrvF2JW6Mqa7ZC4X7Ckw==
Message-ID: <9feb66e6-1de6-42b8-9bef-041764936866@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711641438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnrQz7zJ5TYRQJ8RhAZGjvdCEJDD2LqyzTEIo7jEnN0=;
 b=tUwmtBPDL6MEM2T/fWH4QuxvERzvXwSFhmr0EBitXOcLfdUpuiap2XMPS5LzHZzWEwb53w
 XphNbmcjggAKAuxz8s3LMwPevixMG6IcjFWrpSz/43wvo/iZSQeaotM2gf5q+cz5d+eQi1
 qFRmPXcimcsunwLipoLvP/R6wP+kgqNWa9s13Szbi0M7ZuDX5LhEvwt8FxFJOVcVoeijFs
 W+HIidIDyB7f/9SA1x1uNuI0HsHagX3CBFbuasclOl3ZAO7dKT/QTX6Z/Q3SPERljkg2l4
 LJUio/TpNKpTQDQ3etbu3YUts4S/IkqQbyAtci+OQrtE/Suqoe6eIbfF4895zA==
Date: Thu, 28 Mar 2024 16:57:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: phy: ncsi: reslove the unaligned access issue
To: Tom Rini <trini@konsulko.com>, Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, BMC-SW@aspeedtech.com
References: <20240205081323.256131-1-jacky_chou@aspeedtech.com>
 <20240328150856.GU3442575@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240328150856.GU3442575@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 370b0d95425471a894d
X-MBO-RS-META: sfiew6skdj6w8c5xhqkjw3xxj16hjpp5
X-Rspamd-Queue-Id: 4V57TX3srsz9t56
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

On 3/28/24 4:08 PM, Tom Rini wrote:
> On Mon, Feb 05, 2024 at 04:13:23PM +0800, Jacky Chou wrote:
> 
>>  From the ethernet header is not on aligned, because the length
>> of the ethernet header is 14 bytes.
>> Therefore, unaligned access must be done here.
>>
>> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> 
> Applied to u-boot/next, thanks!

Typo in subject, reslove->resolve .
