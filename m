Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D09CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6001284671;
	Sat, 30 May 2026 16:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wxI+amqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CD784693; Sat, 30 May 2026 16:34:47 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B1F8405A;
 Sat, 30 May 2026 16:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gSN6C07Zkz9tyw;
 Sat, 30 May 2026 16:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780151683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivNyC1U5MAKDQ7pQFB7zDRiZ18NtQ+wyC6HlmORpjdk=;
 b=wxI+amqdt8bpCmBOh9YHkVKqrvzgQmz+XfJrGwOG6og0Sydiqyxa/iNTaRf1K83QH9SWSo
 lgy01IdZzFniF0ABCJMhtqoGqenPSmP3wrQFoFIq0tWruKH29LiY6pcN7Hf20ViJtglR6x
 VeqnAqcq3GawLQ1xOGRUe3RQ0VQevnpgyK/LkYBjFBGWWSgHOrWEcWF1Qd4pWAt6RwN8ML
 iYPf7wKY30B5m8qENZur0FDeUU+LHRSboy6KssnqFtbh6HDGuP5tIZKqu98MfnShMeDbj0
 ZRu0aAOgJRvvZRKI73l0W9UBpO+ppFBiPHRejwPxyYXOhN8d57/sU8oO3Lg1Ew==
Message-ID: <9ee24398-2970-416c-a5d7-ba0c91ab37ae@mailbox.org>
Date: Sat, 30 May 2026 16:34:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <20260530140644.GG627328@bill-the-cat>
 <e7d1a88c-6542-40eb-b21b-b9382bdf5306@mailbox.org>
 <20260530142249.GH627328@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260530142249.GH627328@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ugt7j18i5whfh5a3u99tej3au9fqah9a
X-MBO-RS-ID: 16fcc71a59bd19ccbc4
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

On 5/30/26 4:22 PM, Tom Rini wrote:
> On Sat, May 30, 2026 at 04:16:34PM +0200, Marek Vasut wrote:
>> On 5/30/26 4:06 PM, Tom Rini wrote:
>>
>>>> The revert is wrong as that breaks other things , like use of DRAM above 4
>>>> GiB boundary, which is exactly why this change was implemented. If RPi has
>>>> limitations, then those limitations should be imposed on RPi, not globally,
>>>> so add the LMB reservations on RPi.
>>>
>>> Isn't the case you describe still a theoretical and not used in tree
>>> case?
>>
>> No, this is used by the Sparrow Hawk board, which depends on it.
> 
> Since when, and can we just also revert that to it's old behavior?

Since the inception of this patch, i.e. beginning of this thread.

And no, we cannot revert to any old behavior, because then we wouldn't 
be able to load large images on Sparrow Hawk, which is necessary.

>>> And note that Ilias' patches to relocate to the top of memory also
>>> fail on Pi. So there's something to be debugged here and worked out
>>> before we add this seemingly enhanced behavior. Hence, the need to
>>> revert it for now until it can be fixed.
>> We still have two RCs to go, so I don't see the need for a hasty revert that
>> breaks other systems, esp. if Ilias is looking into the RPi situation now,
>> and I already offered a way to fix the RPi in the short term without
>> breaking the other systems.
> 
> Ilias is not (yet) looking in to the problem with his series. I'm just
> noting that Pi is showing examples of the complicated memory map with
> things above and below 4G. And yes, we have a month between now and the
> release so a revert (or several, to return Sparrow Hawk to working) is
> currently on the table, if no one can work out how to fix things.

I sent a way to fix the RPi in this thread a few minutes ago, so that is 
the "work out" part there.

We could probably even make that generic enough and gate it behind some 
Kconfig option to let users select whether their memory above 4 GiB is 
broken or not. For SH it is not broken, for RPi it is, so we would have 
to work out some default value of that Kconfig option.

What do you think ?
