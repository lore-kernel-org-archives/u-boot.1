Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE3FC6161
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 16:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED648876E;
	Fri, 13 Sep 2024 18:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="loKxYHJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B896188A5F; Fri, 13 Sep 2024 18:27:42 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3D688365
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 665EE100005;
 Fri, 13 Sep 2024 19:27:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 665EE100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726244859;
 bh=RGr/sCAZ60OqGpX2sLYQ0y24xEuH39v7kAd3OYAToCo=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=loKxYHJ6/1GDg2oHdgxqLuUNvihmfVZ/45dYKXfocGOrbBp2m22cqXuTr6wkiqbDr
 8aYZwLbH7fD10MN0DozJqmmpVOf7NxAEe9fNDgBduDQft0/bLTRvG7IhSJBxcTIurf
 5AS0bpP7eBpC7n590LLwNktgc0bkTsxZbjFydTMYFpYYFMDwtTDLBlQnofvfekK/K4
 CX1v64EhR5TJQY6hwrvCiXGb//NjnSWh5Jr1SKBfCmRmeFF1//K61EI2dBlqitjAJ1
 dNsQJoEvMBln5cThWTNJQqlsc3R3GSwSW+NwbYljRdt55aqDnbMvwlj8MJ3d6tKB5l
 fR/Cv/2Q2KBlQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 13 Sep 2024 19:27:39 +0300 (MSK)
Date: Fri, 13 Sep 2024 19:27:38 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-ID: <20240913162738.brhoavecnvaudw66@CAB-WSD-L081021>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912071053.4cquqz5fcbhg6yzc@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.161.140]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187741 [Sep 13 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1;
 github.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/13 14:30:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/13 14:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/13 14:58:00 #26579399
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

On Thu, Sep 12, 2024 at 10:10:53AM +0300, Dmitry Rokosov wrote:
> There are Pipeline results. One test was failed. I suppose it's not
> related to my patch series:
> 
> https://github.com/u-boot/u-boot/pull/625/checks?check_run_id=30029925059
> 
> =================================== FAILURES ===================================
> _______________________ test_ut[ut_dm_dm_test_rtc_dual] ________________________
> test/py/tests/test_ut.py:590: in test_ut
>     assert output.endswith('Failures: 0')
> E   AssertionError: assert False
> E    +  where False = <built-in method endswith of str object at 0x7fb0835c50d0>('Failures: 0')
> E    +    where <built-in method endswith of str object at 0x7fb0835c50d0> = 'Test: dm_test_rtc_dual: rtc.c\r\r\nTest: dm_test_rtc_dual: rtc.c (flat tree)\r\r\ntest/dm/rtc.c:307, dm_test_rtc_dual...&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)\r\r\nTest dm_test_rtc_dual failed 1 times\r\r\nFailures: 1'.endswith
> ----------------------------- Captured stdout call -----------------------------
> => ut dm dm_test_rtc_dual
> 
> Test: dm_test_rtc_dual: rtc.c
> 
> Test: dm_test_rtc_dual: rtc.c (flat tree)
> 
> test/dm/rtc.c:307, dm_test_rtc_dual(): -EINVAL == cmp_times(&now1, &cmp, false): Expected 0xffffffea (-22), got 0x0 (0)
> 
> Test dm_test_rtc_dual failed 1 times
> 
> Failures: 1
> 
> => 
> =================================== FAILURES ===================================
> 

I've re-run the pipeline. This time it was finished successfully.

https://github.com/u-boot/u-boot/pull/625/checks

-- 
Thank you,
Dmitry
