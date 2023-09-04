Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0325C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07054868D0;
	Mon,  4 Sep 2023 09:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Vz2o1J3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA96868D9; Mon,  4 Sep 2023 09:41:15 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEC886497
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230904074109epoutp02400e37cde30b53e7c154c506d87c0079~BojGzIKzi1167211672epoutp02M
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 07:41:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230904074109epoutp02400e37cde30b53e7c154c506d87c0079~BojGzIKzi1167211672epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693813269;
 bh=T6psqt7K7N26xyePzgOwEqYth4ZPqBf+O+4UWzUI80s=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Vz2o1J3NNCtaKl1KoDSrf09HdAYCnJeD1dAG87YphVnv/g5lchzi4bnhalTuufWMy
 EWw6Jb1dlvWD0tt+7X+/CBv/GERgrhz1S8uOnc8wTCWKIL4xNxvDDbfaoDJkL+dC8g
 doBQvWuK7T7sukMlj/g7nxFAd0Ghje1v68ZYgYng=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230904074108epcas2p1db4058cf0fe13109e1806641d0a3e09d~BojGeBBbC1711417114epcas2p1f;
 Mon,  4 Sep 2023 07:41:08 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RfLD41sKNz4x9Py; Mon,  4 Sep
 2023 07:41:08 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 E2.83.09660.31A85F46; Mon,  4 Sep 2023 16:41:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230904074106epcas2p4a130e7d89e79c9593a41ec168065f0b7~BojEks4RK2878828788epcas2p4P;
 Mon,  4 Sep 2023 07:41:06 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230904074106epsmtrp11dc369b984e5615db1c15ee0ff4c6787~BojEkFPKr1483114831epsmtrp1z;
 Mon,  4 Sep 2023 07:41:06 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-91-64f58a1316c0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DF.2B.18916.21A85F46; Mon,  4 Sep 2023 16:41:06 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230904074106epsmtip10ad09a5890bbdecb99a56eb954ad2fbe~BojEVfPB70261502615epsmtip1C;
 Mon,  4 Sep 2023 07:41:06 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Leo Liang'" <ycliang@andestech.com>
Cc: "'Rick Chen'" <rick@andestech.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <ZPWAx5JcsZRizFxb@swlinux02>
Subject: RE: [PATCH v2 2/3] riscv: timer: add timer_get_boot_us for BOOTSTAGE
Date: Mon, 4 Sep 2023 16:41:06 +0900
Message-ID: <003b01d9df03$2a01d780$7e058680$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJDo85+4KW0dBmGLBsoxGjOXDx6aAImVWeyAu9hIN0BURnKwa8DhTUA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmua5w19cUg03/OSzevjjLaPFtyzZG
 i7d7O9ktHh96zeTA4rHn9Cxmj9kNF1k8zt7ZwRjAHJVtk5GamJJapJCal5yfkpmXbqvkHRzv
 HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0TkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
 q5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnXF8NW/BRv6KmdsWsDQw9vF0MXJySAiY
 SBw4vZ6pi5GLQ0hgB6PEsvkX2SGcT4wSU+9sYoFzup69ZodpOXj0LTNEYiejxJUDS1ghnBeM
 Eu8ObGIFqWIT0Jd42bENzBYR0JRY9PQkYxcjBwezQIrEnveWIGFOoPDHlTOYQWxhAX+J0/N6
 mUBsFgEViS/TljCC2LwClhJ7G/dB2YISJ2c+YQGxmQXkJba/ncMMcZCCxM+ny1gh4uISL48e
 YYdY6yax9fQjsNskBH6yS/z5/JAVosFFYsb/E4wQtrDEq+NboD6TknjZ38YOcqeEQLnEjmVJ
 EL0tjBLNbXugltlL/Lg5hRXiF02J9bv0IcqVJY7cgjqNT6Lj8F+oKbwSHW1CEI3qEge2T2eB
 sGUluud8Zp3AqDQLyWOzkDw2C8kzsxB2LWBkWcUollpQnJueWmxUYAyP6uT83E2M4HSo5b6D
 ccbbD3qHGJk4GA8xSnAwK4nwyml/ShHiTUmsrEotyo8vKs1JLT7EaAoM6onMUqLJ+cCEnFcS
 b2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA1PE2xWHtt9XvjwhX+BX
 xaK98dvXqj/4WrvN8vDs1MXsJ5/xZK6Z8j+26+0L4Uv1nBsZK1SbJ/+ZkzEpY9m7oPdLCi8v
 m7XBasoyu9O3BL4JTL9ydE+ZWpvl6YXLnk30YO+5+Nrt3cWlmt61rBrMFxvf92t8Tdp6bY/4
 tAIu7jUKzvM/Lzp38Ej9sel51Wd71a7cvmdcOPuq3D1xYdZ+tqkc6ppKjxfuSyzO0/acsfjI
 TeU+GQeGCP6PleUV989Fz+fbceicoO523eK7gT+1lI/u0BDVWZG49paUkPJ2o5Y/CXWTj7Y8
 j18ZXVE+Nea0mj+ny4/nIj+vC9zJvmKjLTDn7Ylk7V2TQ+acvbS91zCWRYmlOCPRUIu5qDgR
 AAEE0ykQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnK5Q19cUg5s7dS3evjjLaPFtyzZG
 i7d7O9ktHh96zeTA4rHn9Cxmj9kNF1k8zt7ZwRjAHMVlk5Kak1mWWqRvl8CVcXw1b8FG/oqZ
 2xawNDD28XQxcnJICJhIHDz6lrmLkYtDSGA7o8TBd6dZIRKyEs/e7WCHsIUl7rccYYUoesYo
 Mb3jH1gRm4C+xMuObWC2iICmxKKnJxlBbGaBNIkDNy8wQjQ8YZRYdf87M0iCE6jo48oZYLaw
 gK/Eha3bWEBsFgEViS/TloA18wpYSuxt3AdlC0qcnPkEqIYDaKieRNtGqPnyEtvfzmGGOE5B
 4ufTZawQcXGJl0ePsMM88OfoXDaI29wktp5+xArzzKvjW9gnMIrOQrJhFsKGWUg2zEIydQEj
 yypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4BjSCtrBuGz9X71DjEwcjIcYJTiYlUR45bQ/
 pQjxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUw+a2+NZnz
 76w1ZpMz5MNtZprnPbt//e6ZxJlisT2JjzP+ez5KlAvJX3+kya3gTOTJBVssFFZclzPmboiV
 jyt2WlZ0/W9WyIM1bsuvV/Tb6HRqyVV+DLL7yKHBFvvi518Wzr0Jrgtb/mU+iDjz6Y/NmuBd
 p6aL67N2x7JoKh1+ue7Uaq4Yxy2XIn3WKpbLSmwUePr5yhXReEXRl3nXfHVv3Dqd3fzn9e+N
 RzZIHbyYlyx4vHyOgHra4eib+5d1XOP8dzOlk6FTndeyuv9mkfqnj1mnV4mf+S1TurdkgaXJ
 lPyFvy+djnu7b7rxFf/Qi++5ll9/1y6e/PryLrn60PIZPXwWq9Wfxfav364e7vomV4mlOCPR
 UIu5qDgRAPSC4ssQAwAA
X-CMS-MailID: 20230904074106epcas2p4a130e7d89e79c9593a41ec168065f0b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787@epcas2p1.samsung.com>
 <20230828094938.2061606-3-chanho61.park@samsung.com>
 <ZPWAx5JcsZRizFxb@swlinux02>
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

Hi,

> -----Original Message-----
> From: Leo Liang <ycliang@andestech.com>
> Sent: Monday, September 4, 2023 4:01 PM
> To: Chanho Park <chanho61.park@samsung.com>
> Cc: Rick Chen <rick@andestech.com>; Simon Glass <sjg@chromium.org>; u-
> boot@lists.denx.de
> Subject: Re: [PATCH v2 2/3] riscv: timer: add timer_get_boot_us for
> BOOTSTAGE
> 
> Hi Chanho,
> 
> On Mon, Aug 28, 2023 at 06:49:37PM +0900, Chanho Park wrote:
> > timer_get_boot_us function is required to record the boot stages as
> > us-based timestamp.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >  drivers/timer/riscv_timer.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
> > index 3627ed79b819..6cb589fcdc45 100644
> > --- a/drivers/timer/riscv_timer.c
> > +++ b/drivers/timer/riscv_timer.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <common.h>
> > +#include <div64.h>
> >  #include <dm.h>
> >  #include <errno.h>
> >  #include <timer.h>
> > @@ -50,6 +51,26 @@ u64 notrace timer_early_get_count(void)  }  #endif
> >
> > +#if CONFIG_IS_ENABLED(RISCV_SMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
> > +ulong timer_get_boot_us(void) {
> > +	int ret;
> > +	u64 ticks = 0;
> > +	u32 rate;
> > +
> > +	ret = dm_timer_init();
> > +	if (!ret) {
> > +		rate = timer_get_rate(gd->timer);
> > +		timer_get_count(gd->timer, &ticks);
> > +	} else {
> > +		rate = RISCV_SMODE_TIMER_FREQ;
> > +		ticks = riscv_timer_get_count(NULL);
> > +	}
> > +
> > +	return lldiv(ticks * 1000, (rate / 1000));
> 
> Could you elaborate a little how this formula is derived?

Sure. Below is the original formula. To avoid zero of (tick/rate), I split
the calculation to ticks and rate, respectively.

Time(us) = (ticks / rate) * 1000000
          Or (ticks * 1000000) / rate
          Or tick / (rate / 10000000)

Best Regards,
Chanho Park

