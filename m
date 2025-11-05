Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF4CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 05:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6A083968;
	Wed,  5 Nov 2025 06:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AJojRCOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25B0835B3; Wed,  5 Nov 2025 06:48:36 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F3183981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 06:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B061109CE4; Wed,  5 Nov 2025 06:48:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762321710;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=z/weDerQLe6dX3d+sIcWhkNRTMX/MCY/FZPFWy5U2FI=;
 b=AJojRCOcGfdFCXnhKBX7vgR6BH9KefNuofg1AsLJhpcBGdAhqctmqT9WuuhnepFwXi7V5J
 tX/1pS41/SNCzykzfZBp1BT6w1P4Xs+/g7j9GzhN91Pi//CyyUSKumYEM5K/EE3doyEYja
 g/Tf8bl4XIK9cp1ZCqZDSYzph5F34HIRLsHB73hulUDVK1xxppW2JpcvdaqAhcL61pltZZ
 dW31KuGQEbocUNrb5wJRqlx8cckw5dtNvB5u4In+Xvc5eBSyBzGiHof7TnUuaolUFpgs2A
 9BchPnz77gu0MPoRFKZWkOuMMmhQMdwjG2XVelbNn0oGOPIqpFOH2BC4cdKoIw==
Message-ID: <daa45f64-f7ed-333b-9dd8-e7a43eb5e8b5@nabladev.com>
Date: Wed, 5 Nov 2025 06:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/3] test: gpio: include in build, and fixup bitrot
Content-Language: en-US
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>
References: <20251104174458.3385564-1-ravi@prevas.dk>
 <20251104174458.3385564-2-ravi@prevas.dk>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251104174458.3385564-2-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Rasmus,

On 04.11.25 18:44, Rasmus Villemoes wrote:
> Commit ebaa3d053e5 ("test: fix CONFIG_ACPIGEN dependencies"), which
> got into v2022.10-rc1, accidentally left out a $
> before (CONFIG_DM_GPIO), with the effect that test/dm/gpio.c has not
> been built for three years.
> 
> Unsurprisingly, the code in there has bit-rotted.
> 
> - There's a missing ; causing plain build fail.
> 
>    That code was added in 9bf87e256c2 ("test: dm: update test for
>    open-drain/open-source emulation in gpio-uclass"), which was part of
>    v2020.07-rc3, i.e. long before the commit causing gpio.c to not be
>    built at all. It did build at that time, but also, the missing
>    semicolon wasn't found when fa847bb409d ("test: Wrap assert macros
>    in ({ ... }) and fix missing semicolons") happened in 2023.
> 
> - Commit 592b6f394ae ("led: add function naming option from linux")
>    bumped sandbox,gpio-count for bank gpio_a in test.dts to 25, but
>    didn't update the expected global gpio numbers accordingly.
> 
> - The "lookup by label" test likely worked when it was added, but then I
>    inadvertently broke it when I noticed that dm_gpio_lookup_label()
>    seemed to be broken in commit 10e66449d7e ("gpio-uclass: fix gpio
>    lookup by label") - which landed in v2023.01-rc1, so after gpio.c
>    was no longer being built.
> 
>    The "label" (which is a u-boot concept) that a "hogged gpio" gets is
>    <gpio hog node name>.gpio-hog, which is why it used to work with the
>    strncmp() but doesn't with strcmp().
> 
>    We can either revert 10e66449d7e or append the ".gpio-hog" suffix as
>    done below. I don't really have a dog in that race; when I did
>    10e66449d7e, it was because I thought the "lookup by label" was
>    actually about the standardized gpio-line-names property, but then I
>    learnt it was not, so is not at all useful to me.
> 
> - The leak check now fails.
> 
>    Test: gpio_leak: gpio.c
>    test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a95b0 (2790832), got 0x2a9650 (2790992)
>    test/dm/gpio.c:328, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
>    Test: gpio_leak: gpio.c (flat tree)
>    test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a9650 (2790992), got 0x2a9700 (2791168)
>    test/dm/gpio.c:328, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
> 
>    And it fails with the same differences (160/176) even if I
>    remove the three lines that actually exercise any of the gpio code,
>    i.e. make the whole function amount to
> 
>      ut_assertok(dm_leak_check_end(uts));
> 
>    Test: gpio_leak: gpio.c
>    test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a95b0 (2790832), got 0x2a9650 (2790992)
>    test/dm/gpio.c:325, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
>    Test: gpio_leak: gpio.c (flat tree)
>    test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a9650 (2790992), got 0x2a9700 (2791168)
>    test/dm/gpio.c:325, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
> 
>    So I suspect that the leak is somewhere in the test framework
>    setup/teardown code - dm_leack_check_end() isn't really used
>    anywhere else except in a dm/core test. Bisecting to figure out
>    where that was introduced is somewhat of a hassle because of the
>    other bitrot, and because of the SWIG failure that makes it very
>    hard to build older U-Boots.
> 
>    So since it's better to have most of the gpio tests actually
>    working instead of leaving all of gpio.c as dead code, #if 0 that
>    part out and leave it as an archeological exercise.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   test/dm/Makefile |  2 +-
>   test/dm/gpio.c   | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko



-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
