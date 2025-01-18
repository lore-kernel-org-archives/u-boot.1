Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD2AC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539F380786;
	Sat, 18 Jan 2025 09:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nosEwhMS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nosEwhMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39F58073D; Sat, 18 Jan 2025 09:00:28 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2308063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZptc4yhbz9sqH;
 Sat, 18 Jan 2025 09:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHwF0zkQsOY2q4fDVXApLr0w7QI/qZErxdffF/XpXz0=;
 b=nosEwhMSWfzuSrFc7bDILY7IWJpNoevcZZAoofb/e1P86u0dEWtLXO1gjnM94khSWmwxBB
 use9TqGwXASJQ0/vs/w5tYSWIBAzTwMHMQ/P4P2gqs2HSn1QXWRRiNnEJGSqJVEJN4FwSX
 rfWn1NP56cDlORLM/myROsf9M3FeyJUJTw68E9DBGEX/YBU/M/xNOVC7ONIcLNcuFr2Idj
 9UAWZQmkD8NaV2xCJPKYzkwrntwkLc8FLzReiXCn07r1Km+zya10MndZwcGxe4dLUrm6IL
 O46AlzT/bj5ZKj7Qoh5X+V+EVE0/iSifdNZpGurp6OT/+z93ISfcTyT3ll64ng==
Message-ID: <69d26454-10d5-4c3e-89f3-a4a0843700d3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHwF0zkQsOY2q4fDVXApLr0w7QI/qZErxdffF/XpXz0=;
 b=nosEwhMSWfzuSrFc7bDILY7IWJpNoevcZZAoofb/e1P86u0dEWtLXO1gjnM94khSWmwxBB
 use9TqGwXASJQ0/vs/w5tYSWIBAzTwMHMQ/P4P2gqs2HSn1QXWRRiNnEJGSqJVEJN4FwSX
 rfWn1NP56cDlORLM/myROsf9M3FeyJUJTw68E9DBGEX/YBU/M/xNOVC7ONIcLNcuFr2Idj
 9UAWZQmkD8NaV2xCJPKYzkwrntwkLc8FLzReiXCn07r1Km+zya10MndZwcGxe4dLUrm6IL
 O46AlzT/bj5ZKj7Qoh5X+V+EVE0/iSifdNZpGurp6OT/+z93ISfcTyT3ll64ng==
Date: Sat, 18 Jan 2025 08:59:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] arm64: renesas: Deduplicate board_early_init_f()
To: Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-7-marek.vasut+renesas@mailbox.org>
 <CAHCN7xJ+T_m_MR0PuHNMyuMegFGykPp-CpS8sCX6EYb3ksvfRg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xJ+T_m_MR0PuHNMyuMegFGykPp-CpS8sCX6EYb3ksvfRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3ugcby984eergmk5mhrih5xyd1o7tjoi
X-MBO-RS-ID: ee8c5773999f7eb64a0
X-Rspamd-Queue-Id: 4YZptc4yhbz9sqH
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

On 1/13/25 4:40 PM, Adam Ford wrote:
> On Sun, Jan 12, 2025 at 4:36 PM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Introduce common weak board_early_init_f() in rcar64-common.c
>> which is the default implementation in case there is no other
>> board specific board_early_init_f(). Remove board_early_init_f()
>> from Salvator-X, ULCB and Draak boards where this function is
>> empty.
> 
> Isn't there a config option to enable/disable board_early_init_f?  If
> they are do-nothing functions, can the config option be disabled?
There is , but I am still on the fence whether it wouldn't be better to 
remove it in favor of weak symbol, which would get optimized out. I 
think it is more user friendly as user does not have to fiddle with any 
config options, only fill in the non-weak symbol with content in their 
board file and it automatically takes effect.
