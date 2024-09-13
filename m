Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6913FA372B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 08:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEEB8863E;
	Fri, 13 Sep 2024 10:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="UP+g/CWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 200778863E; Fri, 13 Sep 2024 10:37:18 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D991886F9
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 10:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 151BD10001F;
 Fri, 13 Sep 2024 11:37:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 151BD10001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726216631;
 bh=7ZPZryqtfBgUtBWTh8jan7RWBs3V1aMngXEbjZcBBW4=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=UP+g/CWZB1pGfIOATeZWUOo5gwzSyHkGOYbFE/9Xn+va9veF+83w0YhDy28JmLPtK
 Cm9S8K48pz7trquzCwCiYHeWpvKQoSYeYfC5mVlLs2pIrV04VnNB74ryjoK3VvQYQ6
 djYJ4zPagCuizVybNd2dJmGcaJ8YWXmNLTZ+ckHTfSBoRGqQMqIZjDu30edAvfrx/2
 ZRnO5tDzRUvbxapDz4gkuyaz0JpVsHVo5rnbW8kXergxrjC1Ghciau2LMx4VCxtZVN
 tVBvuk+TTC3vCiA1p/iU5dUYFWosuoW2nBToZzklgNumRhh/wV04fQu1McNnCL4QN5
 xOH8dCT0IMGXA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 13 Sep 2024 11:37:10 +0300 (MSK)
Date: Fri, 13 Sep 2024 11:37:10 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>
CC: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <colin.mcallister@garmin.com>,
 <4.shket@gmail.com>, <avromanov@salutedevices.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-ID: <20240913083710.rk3hj3tniaigrkgz@CAB-WSD-L081021>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
 <20240912174501.GU4252@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912174501.GU4252@bill-the-cat>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.161.140]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187724 [Sep 13 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, github.com:7.1.1;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/13 07:36:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/13 07:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/13 07:34:00 #26573401
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

Hello Tom,

On Thu, Sep 12, 2024 at 11:45:01AM -0600, Tom Rini wrote:
> On Thu, Sep 12, 2024 at 10:10:53AM +0300, Dmitry Rokosov wrote:
> > There are Pipeline results. One test was failed. I suppose it's not
> > related to my patch series:
> > 
> > https://github.com/u-boot/u-boot/pull/625/checks?check_run_id=30029925059
> > 
> > =================================== FAILURES ===================================
> > _______________________ test_ut[ut_dm_dm_test_rtc_dual] ________________________
> > test/py/tests/test_ut.py:590: in test_ut
> >     assert output.endswith('Failures: 0')
> > E   AssertionError: assert False
> > E    +  where False = <built-in method endswith of str object at 0x7fb0835c50d0>('Failures: 0')
> > E    +    where <built-in method endswith of str object at 0x7fb0835c50d0> = 'Test: dm_test_rtc_dual: rtc.c\r\r\nTest: dm_test_rtc_dual: rtc.c (flat tree)\r\r\ntest/dm/rtc.c:307, dm_test_rtc_dual...&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)\r\r\nTest dm_test_rtc_dual failed 1 times\r\r\nFailures: 1'.endswith
> > ----------------------------- Captured stdout call -----------------------------
> > => ut dm dm_test_rtc_dual
> > 
> > Test: dm_test_rtc_dual: rtc.c
> > 
> > Test: dm_test_rtc_dual: rtc.c (flat tree)
> > 
> > test/dm/rtc.c:307, dm_test_rtc_dual(): -EINVAL == cmp_times(&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)
> > 
> > Test dm_test_rtc_dual failed 1 times
> > 
> > Failures: 1
> > 
> > => 
> > =================================== FAILURES ===================================
> 
> Yes, sometimes that just fails due to the underlying hardware (even with
> retries). Please tell it to try again so that the world build tests run.
> Sorry for the noise here.

Thank you for the comments. I have re-run the pipeline. Once it is
finished, I will provide the results here.

-- 
Thank you,
Dmitry
