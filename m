Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF91E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1E5801CE;
	Tue, 17 Dec 2024 09:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ga5U6fLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC0E801CF; Tue, 17 Dec 2024 09:56:12 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259BA801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7D9C3120004;
 Tue, 17 Dec 2024 11:56:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7D9C3120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734425767;
 bh=0o+2LOgRi4IOlx6scrq6pZGg5HFTGqLFDBhRpBZBlvI=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=ga5U6fLfngEzPtSKV9WngbAjAkmhs7TlYO0GtlHAMFrheEub3agH0w29fUp3FPJb1
 UBab5RhcA9dSFi1N02+rzPec2MEOQL7z0wjS52rM8H7OFxLdANfRabOkI4mQMYtv00
 edAs0VazySDypfSY9tScU3vBe1GOALI6oeBwZUrcWxkzauphzReRpWuTeNvPj9rHgS
 4tzU+1Un2j2vW0acb/3M6IJ3NU6pdlbFU6peAhm0QM2AeYuqO6KwWuMtYhtQ5KiP3W
 oTTdI7fe9Xa2D/HDXQ5XUligrFjjPL1LWr4/rGt6ANrpqGyd15gLMBh4iSxbsCUFWo
 8o2qkr2JeFf5w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Dec 2024 11:56:07 +0300 (MSK)
Date: Tue, 17 Dec 2024 11:56:06 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>, <kernel@salutedevices.com>,
 <evgen89bachinin@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/5] sandbox: repair compile and run-time for OF_EMBED case
Message-ID: <lxjnwb4nxc2fvl5cmon6qlqfaagvm6mgmgk5bccqrrjpkzi2gm@kfzzhqt42fd7>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <CAFLszTic80ddU1QRxD0dKG0fruZnMXxpoZVEAuK76ji3pM2vMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTic80ddU1QRxD0dKG0fruZnMXxpoZVEAuK76ji3pM2vMg@mail.gmail.com>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189881 [Dec 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47
 57010b355d009055a5b6c34e0385c69b21a4e07f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 github.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/17 08:10:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/17 08:11:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/17 06:22:00 #26894014
X-KSMG-AntiVirus-Status: Clean, skipped
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


Hello, Simon.


On Fri, Dec 06, 2024 at 12:19:42PM -0700, Simon Glass wrote:
> Hi Evgeny,
> 
> On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
> <EABachinin@salutedevices.com> wrote:
> >
> > This patch-set repairs ability to use sandbox with CONFIG_OF_EMBED=y.
> >
> > For now, to use OF_EMBED, the following must be done
> > 1) sandbox64_defconfig should have:
> >   ```
> >   -CONFIG_OF_LIVE=y
> >   +CONFIG_OF_EMBED=y
> >   ```
> >
> > 2) On sandbox when CONFIG_OF_EMBED=y, the u-boot process can't start
> > due to:
> >   ```
> >   Bloblist at b000 not found (err=-2)
> >   initcall failed at call 000000000011829c (err=-2: No such file or \
> >       directory)
> >   ### ERROR ### Please RESET the board ###
> >   ```
> >   So, it is natural desire to disable CONFIG_BLOBLIST just to test
> > sandbox with OF_EMBED=y (disable it one way or another):
> >   ```
> >     config SANDBOX
> >   -     select BLOBLIST
> >   +     select BLOBLIST if SOME_NON_EXISTING_OPTION
> >   ```
> >
> > 3) As a result, having such changes (CONFIG_OF_EMBED=y &&
> > CONFIG_BLOBLIST=n) leads to the link & run-time errors, being fixed
> > by this patch series.
> >
> > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > ---
> > Tested:
> > * locally with aforementioned options applied
> > * CI - https://github.com/u-boot/u-boot/pull/704
> >   * No regression
> >
> > ---
> > Evgeny Bachinin (5):
> >       sandbox: fix bloblist_finish() linker error if BLOBLIST=n
> >       test: sandbox: fix invalid_use_of_IF_ENABLED_INT if BLOBLIST=n
> >       test: sandbox: fix link error with do_ut_bloblist if BLOBLIST=n
> >       test: sandbox: fix link error with do_ut_bootm if BLOBLIST=n
> >       sandbox: set retval early in board_fdt_blob_setup()
> >
> >  arch/sandbox/cpu/cpu.c |  2 +-
> >  include/bloblist.h     |  7 +++++++
> >  test/cmd_ut.c          |  2 ++
> >  test/lib/kconfig.c     | 10 ++++++----
> >  4 files changed, 16 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
> > change-id: 20241120-sandbox_repair_of_embed-2188465eb22b
> >
> > Best regards,
> > --
> > Evgeny Bachinin <EABachinin@salutedevices.com>
> >
> 
> Thanks for looking at this.
> 
> You could add a test for ~OF_EMBED in
> test/py/tests/test_sandbox_opts.py if you want to keep this working in
> future.

I did not know about this. Thank you, will do.

-- 
Best Regards,
Evgeny Bachinin
