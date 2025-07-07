Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2805C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800AB83046;
	Mon,  7 Jul 2025 10:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wa014yyz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="olK98lgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 879808304D; Mon,  7 Jul 2025 10:41:08 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB20383043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbHl63D9rz9stX;
 Mon,  7 Jul 2025 10:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlEmZpFlegiCwwI0XGpx0obFr+nFZwPXAeyx+1OvxYQ=;
 b=wa014yyzYMaykE4nSxc2nMNrfvwMq/2N59BP98em4b5N5o490GkAUNifHsB+gSumk4+MSG
 uyo981ij2IfuVZHeAnNNTTns6OYHTDVUaw1qUp+3wKWlEIQLRUxuXIdliJM7RA8L8aay9O
 jG6IHXdWSZReRcfWRUErhxTQ6QBIGLg8k/TpMpQsvmDLgJUQk4KLym+8mWWruK1tTYc9GK
 LnzJQCu3baMKNKP56yoDnp76bK7ay1iPxjvcgifCr8uZHk0JPY8Gu5Mu5LJEBCD60JwN9/
 wh5AVz2kL2ds/Kf50rK+2tMMtSjHHCEZYoHdU6LDAf08kcUiwXnMVSado16dxQ==
Message-ID: <be60c8fc-5efd-462c-9731-6aa82f918008@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlEmZpFlegiCwwI0XGpx0obFr+nFZwPXAeyx+1OvxYQ=;
 b=olK98lgzIb8tgR/fTHT45/MZe7feTNYLUcT998eW5DwVtse3s+lCRYuU8kayZVulbYyYzM
 ehwGUGuVAUgOsZwfcg0L9D/h61KQX94s60hxLmH/1JsLY6ag1FELaDEfuzmDEnUztGeMlf
 PLi9P4JKsuNxYWXw3MP6WqbdZKjN+9e0iAFHXdJeDx+ueG/Xx1zYWgN25m1I+TtAvdIAHz
 +SzLPJ6vUd7uWCXUOjMWLTWtf1D8odFbgnmxWVVyLwXZNNZbVPJVLwj7EGmhgkJ+qEbRVe
 ClLktHh2skwiyTKWoWAYidMFkRc/J5ZQzs1QDxZ9Mr4WLOsMVoDk5odelC/XDQ==
Date: Mon, 7 Jul 2025 10:41:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: renesas: Split common RZ/A1 and GR-PEACH defconfigs
To: Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
References: <20250630185238.1099287-1-marek.vasut+renesas@mailbox.org>
 <CANqRtoT5cvfRHkPHmO+0x9CeoFRO9fFMrcMjBVdE5R1P4vUBQg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CANqRtoT5cvfRHkPHmO+0x9CeoFRO9fFMrcMjBVdE5R1P4vUBQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11ff043536b9ebef3b6
X-MBO-RS-META: yn8ky6i96651frx9irsppcphxqs36zfb
X-Rspamd-Queue-Id: 4bbHl63D9rz9stX
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

On 7/2/25 3:11 PM, Magnus Damm wrote:
> Hi Marek,
> 
> On Mon, Jun 30, 2025 at 8:52 PM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Split the RZ/A1 GR-PEACH defconfig into board-specific defconfig
>> and common RZ/A1 SoC defconfig. This is a preparatory patch for
>> new RZ/A1 boards, no functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
> 
> Thanks. I like the idea of your patch but it seems that "make
> grpeach_defconfig" generates the following output after applying this
> patch on top of
> cbb5672790d400e9ec6e9fceaf89ece2660c0117 (origin/next)
> 
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    YACC    scripts/kconfig/zconf.tab.c
>    LEX     scripts/kconfig/zconf.lex.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
>    HOSTLD  scripts/kconfig/conf
> generated_defconfig:66:warning: override: reassigning to symbol ENV_OFFSET
> generated_defconfig:69:warning: override: reassigning to symbol ENV_SIZE
> #
> # configuration written to .config
> #
> 
> Any ideas why?
Because ENV_OFFSET and ENV_SIZE are in both .config and defconfig which 
includes the .config , should be fixed in V2, thanks.
