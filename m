Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C31C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75C988732;
	Wed, 12 Jun 2024 11:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XhblQX8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6598822D; Wed, 12 Jun 2024 11:32:02 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D6A8822D
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VzgKp0LQRz9smk;
 Wed, 12 Jun 2024 11:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718184718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgmkFVWm5JgZ7+bJjcCOwX90acq0XOJpso7/kEBQYpw=;
 b=XhblQX8R7nrY0mjmbCn1r3XQZ2l0N5nlgkNTOne91Fs2+rlc8rYwyu8rnYcc1Q4SNK/Pgo
 8rc1ok5iJIlp0JiHMizVtgKgLyluacAapypfhdzQTtUbeNjZyv8xk1DXEHjAe10Q/yEdTD
 ACrbyJ9fs33BXwjNsDMq32FCHlRM2SsVvfFNSs+H70vsWSwXsBhl+bsjsmwMmAeVJcyvIs
 pYmVnHANjvwUZTpJN6s/pEbdABjCORrLHTqkmEJTweNGINzN3z63iCr0AUgsxfOoG0CeO7
 fLp2ZWDcuNh3RDuTUDyA41oIzFZpGGhvS9e1NfP3BRi3jwvT5SRyJR92s7LShg==
Message-ID: <d66b2844-6e5e-455c-ae71-7d511c2b6e81@mailbox.org>
Date: Wed, 12 Jun 2024 11:31:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, trini@konsulko.com
Cc: sjg@chromium.org, xypron.glpk@gmx.de, sumit.garg@linaro.org, afd@ti.com,
 bb@ti.com, mr.bossman075@gmail.com, leon@georgemail.eu,
 michael@amarulasolutions.com
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 503db1df0c4efe67321
X-MBO-RS-META: ahnwnsqxi99gzqxqcjiq7nndexnewjae
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

On 6/3/24 5:07 PM, Patrick Barsanti wrote:
> Always prioritizing u-boot includes causes problems when trying to migrate
> boards to OF_UPSTREAM that have different local devicetree files with
> respect to the upstream ones, if local DT headers are not dropped.
> At the same time if local and upstream files are the same, migrations
> can be, and have been, introduced without dropping local DT headers.
> This also causes problems whenever upstream DTS and DT headers are patched.
> 
> For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> breaks it, as there are some missing defines in a local DT header file
> (`imx6ul-clock.h`); the solution would be to drop it, which has not always
> been done in previous OF_UPSTREAM migration patches for other boards
> because most of the time the two are the same. This solution is also
> vulnerable to ABI breakage, although this has not yet happened since the
> introduction of OF_UPSTREAM support and is unlikely.
> 
> Maintainers assure backwards compatibility for DT headers when syncing the
> upstream folder with the kernel.

... upstream directory ...

> The problem is that, at the current state, all boards that have not dropped
> their local headers when migrating to OF_UPSTREAM will break once the
> upstream devicetrees are patched, for example, to use any newly added
> define which is not present in the local DT header file, even if those
> changes are backwards compatible.

Why not simply remove the headers ?

Add a WARNING if there are local duplicates .

[...]
