Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80AC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 12:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9D680C77;
	Sat, 25 Jan 2025 13:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dxB3/Dum";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DtyOit2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11FB80C7E; Sat, 25 Jan 2025 13:56:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91CE780836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YgF721Rb0z9sYX;
 Sat, 25 Jan 2025 13:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737809790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTgldTSZfSYe9s5XlG4pDa5MvJftS9mqNDvBxOsA7Iw=;
 b=dxB3/DumO+R78jxs7qVqQFKEgg3BOPga0glZH+C/pJgXU8EDMiZ4BA082i3bE/8/Lti3YG
 SCnmvX3tL4UxhCvdM7nJe7TMnriw1q8uRR8OjqVzeAUNHJQ19a6qXO5JVULTQQ6ePi3YsF
 myYfdxrKce36Hy9kJ/9YnBbUqAD2X5wsDxuCR1/9rAtnsi9MfwDnH08koaIzyBfnPRF2SD
 /OFLQekUFSK3MNKKYf9TiPgtUjMGhSc3b5iJ2cK0xWVDYX8VSPANCw8LzoCcNZ+kg3xKf1
 oidVWttRyQbHvnbbbEX40hoE8YvPw/EnpGsiRKFNEn2F3fVRvfdYSYVPdaosNg==
Message-ID: <273bc749-8378-40de-b533-6c58a4569f0e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737809788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTgldTSZfSYe9s5XlG4pDa5MvJftS9mqNDvBxOsA7Iw=;
 b=DtyOit2jcH5XnoxYllnCDRjDT1LY7yfW/DPpzgWrGaZp+VcLNHWI2qlzFvweGEh5oEtwvC
 KNFLC6MEnYXQZKkEvotR9XrpUxBdhQFRDKt7irrqzQYo/5MdC9lCz4p+FR1rEKiNHPyCMl
 xmVQWjOPUxynI/MijTYcmq4rO1vkhErbMXG52jTo4N67HRBzyi8NwGJeYGzRgS5IwZSc1X
 +B6HR9LyrO3SpbvIfUwbGoVD7/huH5SH/ozBbVN0RMIq64/xN0o1pWKBi7pIBuVGdgxWE6
 HgEkFsDwxTbyRgqZoaDhvsxsy2BDqUlJFAZm+UBjX+lP/EODngqA4D9ESfqn/g==
Date: Sat, 25 Jan 2025 13:56:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/17] miiphy: Introduce mdio_init()
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
 <78ea8dbd-56ae-49a0-b9f9-274a8cf9182a@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <78ea8dbd-56ae-49a0-b9f9-274a8cf9182a@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5bquibud8qtkckaoeocmchjjn69eyfss
X-MBO-RS-ID: 96544d31bb00c641e68
X-Rspamd-Queue-Id: 4YgF721Rb0z9sYX
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

On 1/21/25 3:38 PM, Paul Barker wrote:
> On 18/01/2025 06:53, Marek Vasut wrote:
>> Introduce mdio_init() split off from mdio_alloc(), which is used
>> to initialize already allocated struct mii_dev.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Replying here for the whole patch series...
> 
> I like where we get to at the end of this series, but I don't like the
> intermediate state where the bb_miiphy_buses arrays still exist but are
> unused. I also think we should introduce a new ops struct so we're not
> duplicating function pointers in each instance of struct bb_miiphy_bus.
> 
> I would prefer the following order of changes, let me know if you think
> this would be cleaner:
> 
> 1) Introduce mdio_init().
> 
> 2) Add mii member to struct bb_miiphy_bus.
> 
> 3) Modify each driver to use the mii member of the appropriate struct
>     bb_miiphy_bus instance, calling mdio_init() instead of mdio_alloc().
>     At this point we're still using the instances in the statically
>     allocated bb_miiphy_buses array.

Those instances might be rodata , so using them as read-write storage 
does not necessarily work , does it ?

-- 
Best regards,
Marek Vasut
