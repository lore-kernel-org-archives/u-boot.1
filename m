Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C26D6B076
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E7183F32;
	Thu, 29 Jan 2026 16:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ERGxrLTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6D583FC8; Thu, 29 Jan 2026 16:28:58 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 413C883A64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f232Z1vVhz9tgB;
 Thu, 29 Jan 2026 16:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769700534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c9y9WsApYKMoKKKTkg8XUEtvuud6OkYGLJ1e2hD9aA=;
 b=ERGxrLTX/D18eu+5HepZ7VGRcwIbQbWgGna+VQj/xRondcGdOf2lnOjmditgZQPBZFmobb
 TyT4ZVCRbZDUPcUBBaOnZQtbPjvXzvQWtyEK5VoHoCfYCK3WVATnx4T8OmVOA6GBUKOCwN
 yORhcGZSPrfNrHMY3Cm18II70F2lAF9oi8FgTfsf+OI3wSTlIbIQ07yyevJ8L69RczyvK2
 NQKWa44lYEw7EarMKxQ/15CfK+X44mcSxuqSxajI9H0Bwuv2CX3EenpIF6wSTaZbXOzCU4
 5OpKlBpCvoh/hLTl/m3NV7v98wnByLKJR/7wRiUTdvCYnAsWAjHwuGO4zo7b0Q==
Message-ID: <99488165-7777-427d-8144-191279b52583@mailbox.org>
Date: Thu, 29 Jan 2026 16:28:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: lwip: wget: rework the '#' printing
To: Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
 <fb3183eb-c389-4508-9316-33c88824bbf1@arm.com>
 <f5ec9ab2-5f20-4121-a3bb-f97d7d108c1b@mailbox.org>
 <ddf9d7db-017f-4f19-8163-c28caf320e89@arm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ddf9d7db-017f-4f19-8163-c28caf320e89@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 91476f7927129602ecb
X-MBO-RS-META: 7uw4kjpjcjy9p9y9kjwe6t6rqwixxw64
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

On 1/29/26 4:22 PM, Jerome Forissier wrote:

Hello Jerome,

>>> 0%....10%....20%... etc.
>>
>> I would like to retain as much compatibility with the old network stack as possible, to make the switch over easy for existing users.
> 
> It is a valid argument but I doubt changing the display can break important
> things, aside from test frameworks maybe, but that should be manageable.
> Tom what do you think?
> 
>>
>> Is there already such a "pretty printing" function available somewhere ?
> 
> Not that I know of :-/

Hmmm, in that case, maybe there are two items which could be done:
- Deduplicate the progress bar printing in general
- Add various progress bar styles

But I think that is out of scope here.

>>> In any case:
>>>
>>> Acked-by: Jerome Forissier <jerome.forissier@rm.com>
>> Thank you
>>
>> (it seems someone rm'd a character from the AB string above, so I reinstated it according to the source email address)
> 
> That someone might be me. Muscle memory not yet trained.
In any case, good to have you back.
