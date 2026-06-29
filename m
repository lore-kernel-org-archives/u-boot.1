Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915CBC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE97A84AB5;
	Mon, 29 Jun 2026 23:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EAHxsu1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2076D84AAE; Mon, 29 Jun 2026 23:49:44 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E720849C5
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gq0LD3SYTz9v1R;
 Mon, 29 Jun 2026 23:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782769780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJO6M3WrnasNg4rUQwEIxPIMrtozhKXGtga/LoXhkyA=;
 b=EAHxsu1+B0a9JbuoUZAFAtei0lSqgTcG9Is36YBrqlbUgOzgLYAPGyolK5xpsuiKvH1Z4T
 BtM6/YLRGg4kKTF1ShO5U5JE9bhwH4ygTM+/dYNpLF5HFks+WTdC+bqkK0WjbSjEE5RrVN
 gyd2qzYgQQwSlJtPpScb3rurdci3haFf+WS+ZWFZfuY4z4bFm+mChceMpHBlYLwG6ZElR8
 x9xHDzJNrybSW/Di5XdzlzrBsXVKEUcFDXN0kfoYz0GdUPpmyg3p21gx+K0tZGjMHk9D4o
 clQ/1FjBsupl33Jh5wL4xriKoece4n1V5OwefyAwFpYUqBTM+Gy36Cut/qEJEg==
Message-ID: <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
Date: Mon, 29 Jun 2026 23:08:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
 <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cmtf6i3dgpy8m7g8e8dnrc6ndyfa1az6
X-MBO-RS-ID: e233b1ee04c6238bbac
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

On 6/29/26 8:24 AM, Patrice CHOTARD wrote:
> 
> 
> On 6/25/26 14:36, Marek Vasut wrote:
>> On 6/25/26 10:38 AM, Patrice Chotard wrote:
>>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>>> it may take a while to get the control back on the console,
>>> sometimes around 1 second.
>>
>> Why does that happen ?
>>
>> [...]
> 
> On STM32MP157C-DK2 board, there are 3 cyclics registered which are called by schedule():
>    _ mmc_cyclic_cd_poll (1 to 2us) every 100 ms
>    _ watchdog@5a002000
>    _ video_idle
> 
> schedule is called on every loop, whereas ctrlc() (CTRL+C detection) is called every 10 * 20000 loops.
> That means ctrlc() is called every ~700ms on STM32MP157C-DK2 board,

What takes 700ms in sleep_thread() , surely not schedule() ?

> Moving schedule() from main loop to same level that ctrlc(), it allows to call ctrlc() every ~70ms
> which increase reactivity when user hit CTRL+C.
Maybe I am too tired, but that does not sound right to me. Why is 
ctrlc() called every 700ms, where does that massive delay come from?
