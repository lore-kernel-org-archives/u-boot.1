Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDCEC27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F72B8804F;
	Sun, 16 Jun 2024 12:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718533112;
	bh=8UUWhh5whrOyiw9pv8tNIik3Q7OOX0KpVDyFl6XhqEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbNm2+S7+Weo4LQdLg2fYhiYjMoosK/7DrHoEY46CvaxQV5vjIWOyD4UAGEm8r/za
	 CNIx/OfvH36xgfLFmrPSW5tBCuvEHKN8NU71UmAlqv1hbLKH282P67JxvYPfqWLiOo
	 meXf6AjSv+svcraG8xGI9voA6BPjBZpRN3mGp10ZQNR4BEuPF1nOOjJfm52/VHo2dg
	 1p7NRaxe9nx6qeCsmCHuW4bg2GGTmkdANCrSL1hmbjmmaT2m+nz0l8eEkaA8eMFz65
	 bPF5zY7k7tvvf0Uw30JrqG9f6anwFonX4K3Mij1dtQ6f82dGyNVg/0SmtTT+OrJgue
	 yoGueM1ixBAjw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D61C880E5; Sun, 16 Jun 2024 12:18:30 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C01A87FC2
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4W289c1LwKz9ss5;
 Sun, 16 Jun 2024 12:18:28 +0200 (CEST)
Message-ID: <b9b4e2a8-b624-461e-81ea-f9951ea5e898@denx.de>
Date: Sun, 16 Jun 2024 12:18:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/21/24 10:46, Rasmus Villemoes wrote:
> A bit of a mixed bag. I've been wanting to submit something like 3/3
> for a while. So when I stumbled on Marek's patch
> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
> , I got reminded of that plan, and I think that patch could be more
> readable if we adopt this model.
> 
> While actually doing those mostly mechanical changes, I stumbled on
> two separate issues that probably want fixing regardless of the fate
> of 3/3.
> 
> Mostly just compile-tested, and now also checked that at least the
> sandbox test runs succesfully, and that it builds both with and
> without CONFIG_CYCLIC.
> 
> v4: Make sure there's only one definition of struct cyclic_info, previous
> versions failed to move the full definition under #ifdef CONFIG_CYCLIC,
> breaking builds with !CONFIG_CYCLIC.
> 
> v3: Also update the unit test according to the new API.
> 
> v2: Add R-bs from Stefan. Fixup whitespace in the doc/ part. Rebase
> to current master (676903c1b97), fixing trivial conflict with
> 301bac6047c8.
> 
> Rasmus Villemoes (3):
>    cyclic: stop strdup'ing name in cyclic_register()
>    wdt-uclass: prevent multiple cyclic_register calls
>    cyclic: make clients embed a struct cyclic_info in their own data
>      structure

Applied to u-boot-watchdog/next

Thanks,
Stefan

>   board/Marvell/octeon_nic23/board.c |  9 ++++---
>   cmd/cyclic.c                       | 12 ++++------
>   common/cyclic.c                    | 24 +++++--------------
>   doc/develop/cyclic.rst             | 26 ++++++++++++--------
>   drivers/watchdog/wdt-uclass.c      | 38 ++++++++++++++++--------------
>   include/cyclic.h                   | 37 +++++++++++++++--------------
>   test/common/cyclic.c               | 19 +++++++++------
>   7 files changed, 84 insertions(+), 81 deletions(-)
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
