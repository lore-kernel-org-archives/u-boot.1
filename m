Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112C9C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27ED284A26;
	Wed,  1 Jul 2026 09:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yByaIPAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D013584A3C; Wed,  1 Jul 2026 09:24:13 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6346884A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gqs2d57wxz9vGl;
 Wed,  1 Jul 2026 09:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782890649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67QArFP8qnwfyYhEBG7+RYtUv5kA7Xtb/h/dMULnS/Y=;
 b=yByaIPAfUZbKkbONaa1/0Rrvoy05hWWbvupTjU9stiFWgv+m3Ukvk3Mf8qjMg9ZZgk3fBJ
 jNZLsJJ1xgXSUUVtNH8VYqOOsKMa4b69DfcqAixbgJvVL2NZmL6TddFXVHCT6e8rPqepPg
 /+sn87+ryZmfaIz3O65GjDi/HVo/Ta2Ntf19prRo3XAMKgSlcgc2EO7kE4g5etB3aIzfXC
 O6pBMdJ5iPYEXsHx14HwByY/75Jdtuh9RF8LqTCF+3Be4XffCsIDSJOjtX800XKigRx163
 tT7oaI427YRBQP8WGD3cEAKvR3guQKNFH/960M+2yMFk220P88MygEE36javow==
Message-ID: <1d7dec66-5da1-4555-8514-ef89de5491e0@mailbox.org>
Date: Wed, 1 Jul 2026 09:24:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
 <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
 <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
 <4db136c5-aa08-4506-99ac-bbfe0c7963d8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4db136c5-aa08-4506-99ac-bbfe0c7963d8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8a9c67d7d0edcd37e27
X-MBO-RS-META: kw354q3bmstax51cakp9uanmkggnfjgs
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

On 7/1/26 8:27 AM, Patrice CHOTARD wrote:

Hello Patrice,

>> What takes 700ms in sleep_thread() , surely not schedule() ?
> 
> Hi Marek
> 
> On STM32MP157C-dk2, each schedule() execution takes between 2 and 4us depending of the cyclics function to execute.

That is about 1100 instructions on 650 MHz CA7 which is way too much , I 
think that is the problem we need to solve first.

Look ta common/cyclic.c schedule() , I think it is the list iteration in 
cyclic_run() that takes forever. And I think the fix is simple, let the 
list iteration surely run through once on the first run of cyclic_run(), 
and while it is running, for each entry, figure out when the entry 
should be run NEXT, and note the NEXT run timestamp down. At the end of 
cyclic_run(), figure out when the nearest NEXT timestamp is (you can do 
that as part of the list iteration of course), and store that 
information in some global variable. Finally, add at the beginning of 
cyclic_run() a test whether this timestamp was reached. If not, do 
nothing, because you already know that nothing has to be executed yet, 
and you will avoid the expensive list traversal this way.

That should make the execution time of cyclic_run() negligible for the 
majority case.

What do you think ?
