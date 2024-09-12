Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A267EEE6454
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B50B88E0D;
	Thu, 12 Sep 2024 09:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NMZKzNpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E31C88E78; Thu, 12 Sep 2024 09:11:17 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF4E88E04
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C6638120012;
 Thu, 12 Sep 2024 10:10:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C6638120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726125054;
 bh=dHY3HMM7ZEdU1d+ZUD+VCQZ2HCWXkJgc/eMn7VVO53E=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=NMZKzNpDVPsbwvIzEdpuSxI/cwFSVeCaI9HlXy7B4ssVJQfurn9zPRBBKKdLbqyWL
 5NRQN4blpyJYt0U1MWql7g4LZNRSDEZKmdoGPmrzWzo28zZCE130Qgx3Vx6UBIZYRb
 WDTZyX+4skYFsgStpO/AUUkvuy5MD+NX0qcwoGUlO4UNlHKA71YIBrTflP/pN3SrDZ
 n1g1J3iD9XVpXwa5B9uswqtxr2X6n2gd4H+gBJBUPVaropG1hsNJtp6NDGYswFVF+H
 3ZtGhYQhbhPrC3z1gOxaCb0ncrip9NFaIQcZHVKK6SIk+aCVlfpS8NslyuC6bnv6VB
 JIO0HBiPEkWwA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 10:10:54 +0300 (MSK)
Date: Thu, 12 Sep 2024 10:10:53 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-ID: <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [176.99.198.29]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187699 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, github.com:7.1.1;
 lore.kernel.org:7.1.1; salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/12 05:48:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/12 05:48:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/12 04:05:00 #26557625
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

There are Pipeline results. One test was failed. I suppose it's not
related to my patch series:

https://github.com/u-boot/u-boot/pull/625/checks?check_run_id=30029925059

=================================== FAILURES ===================================
_______________________ test_ut[ut_dm_dm_test_rtc_dual] ________________________
test/py/tests/test_ut.py:590: in test_ut
    assert output.endswith('Failures: 0')
E   AssertionError: assert False
E    +  where False = <built-in method endswith of str object at 0x7fb0835c50d0>('Failures: 0')
E    +    where <built-in method endswith of str object at 0x7fb0835c50d0> = 'Test: dm_test_rtc_dual: rtc.c\r\r\nTest: dm_test_rtc_dual: rtc.c (flat tree)\r\r\ntest/dm/rtc.c:307, dm_test_rtc_dual...&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)\r\r\nTest dm_test_rtc_dual failed 1 times\r\r\nFailures: 1'.endswith
----------------------------- Captured stdout call -----------------------------
=> ut dm dm_test_rtc_dual

Test: dm_test_rtc_dual: rtc.c

Test: dm_test_rtc_dual: rtc.c (flat tree)

test/dm/rtc.c:307, dm_test_rtc_dual(): -EINVAL == cmp_times(&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)

Test dm_test_rtc_dual failed 1 times

Failures: 1

=> 
=================================== FAILURES ===================================

On Thu, Sep 12, 2024 at 12:49:08AM +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
> 
> Changes v2 since v1 at [1]:
>     - move ab_select_slot() documentation to @ notation
>     - move ab_select command to bcb subcommands per Simon and Mattijs
>       suggestions
>     - redesign ab_dump as bcb subcommand
>     - use spaces instead of tabs in the ab_dump command output
>     - print hex values in the lowercase
>     - add RvB tags
> 
> Links:
>     [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> Dmitry Rokosov (6):
>   include/android_ab: move ab_select_slot() documentation to @ notation
>   treewide: bcb: move ab_select command to bcb subcommands
>   cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>   cmd: bcb: introduce 'ab_dump' command to print BCB block content
>   common: android_ab: fix slot suffix for abc block
>   test/py: introduce test for ab_dump command
> 
>  MAINTAINERS                               |   1 -
>  boot/android_ab.c                         | 116 ++++++++++++++++++----
>  cmd/Kconfig                               |  15 +--
>  cmd/Makefile                              |   1 -
>  cmd/ab_select.c                           |  66 ------------
>  cmd/bcb.c                                 | 108 ++++++++++++++++++--
>  configs/am57xx_hs_evm_usb_defconfig       |   1 -
>  configs/khadas-vim3_android_ab_defconfig  |   1 -
>  configs/khadas-vim3l_android_ab_defconfig |   1 -
>  configs/sandbox64_defconfig               |   4 +-
>  configs/sandbox_defconfig                 |   4 +-
>  doc/android/ab.rst                        |  12 +--
>  include/android_ab.h                      |  17 +++-
>  include/configs/khadas-vim3_android.h     |   2 +-
>  include/configs/khadas-vim3l_android.h    |   2 +-
>  include/configs/meson64_android.h         |   4 +-
>  include/configs/ti_omap5_common.h         |   4 +-
>  test/py/tests/test_android/test_ab.py     |  31 +++++-
>  18 files changed, 251 insertions(+), 139 deletions(-)
>  delete mode 100644 cmd/ab_select.c
> 
> -- 
> 2.43.0
> 

-- 
Thank you,
Dmitry
