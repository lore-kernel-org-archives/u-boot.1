Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFACCD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E79984671;
	Sat, 30 May 2026 16:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u2sqbl2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BD6846A5; Sat, 30 May 2026 16:35:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87AF8405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 16:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gSN6j43BVz9sb8;
 Sat, 30 May 2026 16:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780151709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYhDHZ5ye/lz84c5UJkekxcQt991KqSSBIfQC9jcF6g=;
 b=u2sqbl2i5DSLmkY2r5VdUWfNuvEesQJmOxFyIahQZm6YXSTuQbxAahqJca9ECunmFqGL0X
 qu8HYmImzGhkFvNMBsaWeg8AN9H4DmjI5lNS1PM5RleR9lRnjlxAFiG58tuaVCZNMS9h8U
 RV7tc8JRG4XTw0OI+vXz5dqoXv2NRilxT/1IgZp26E4X8LZXy2ePHmqAmP2LzYUwOwNTVn
 uCpRwNBzEmCxDjrSC18mZNNY95nnAS1ropWXS9B6szzBCA6E2nI6YrZh/2vrwLDl0x5ugd
 wnuYMLmmfm823Ehu52dZEb7jwRKzeguIGhAhWGIIv8Zxk4xddzAgkuooPcxuEw==
Message-ID: <a7fab43c-fbd5-4b37-8a84-c4f5330d5529@mailbox.org>
Date: Sat, 30 May 2026 16:29:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "lmb: Reinstate access to memory above ram_top"
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20260529162942.281897-1-pbrobinson@gmail.com>
 <d0cb15bb-d4d0-43b2-bf14-b36a62da1dad@mailbox.org>
 <CALeDE9NzKS15mMqLEmpBfwXHajN5hr5kapjuguf1fnCXC-1+GQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CALeDE9NzKS15mMqLEmpBfwXHajN5hr5kapjuguf1fnCXC-1+GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d3u6ikokgacx14jcqbewato3e46j41bd
X-MBO-RS-ID: 7e68d4a96d2c72085c2
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

On 5/30/26 3:43 PM, Peter Robinson wrote:
> On Sat, 30 May 2026 at 14:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 5/29/26 6:29 PM, Peter Robinson wrote:
>>> This reverts commit a3075db94d49f415658bf7e961e1eae90d9abc33.
>>>
>>> This causes boot issues on Raspberry Pi 4/5 in a number of ways,
>>> the mmc needs memory < 4Gb, the mailbox needs it < 1Gb at the
>>> very least so there's some work to be done here for that platform.
>>>
>>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>> NAK
>>
>> The revert is wrong as that breaks other things, like use of DRAM above
>> 4 GiB boundary, which is exactly why the original change was implemented.
> 
> Read the thread, Tom asked me to send a revert.

The revert is wrong, I already sent you a way to fix your RPi problem 
too. It would be nice if you didn't use "Tom said so" as an argument in 
technical discussion, that is not helpful.

>> If RPi has limitations, then those limitations should be imposed on RPi,
>> not globally. Please add the LMB reservations on RPi only. Use
>> lmb_arch_add_memory() to add those restrictions per-board/soc/arch instead.

