Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4F6C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 14:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DF488261;
	Mon, 29 Jul 2024 16:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="eK6+qK8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD38A885BC; Mon, 29 Jul 2024 16:39:32 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B79E88247
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 16:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 448C0100010;
 Mon, 29 Jul 2024 17:39:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 448C0100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1722263967;
 bh=3curqCuBbFYg2Lq6ZXhnWY3TTJF40wehTNa0njCIKug=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=eK6+qK8Rv4WgVj9bDs1OhtnnmjbU9JG69gdE98fGa+YjnEs1/lyNdxcTSxSJI/BYm
 Q3xmUl2dn9662DntbzBawMO6Ds26W2BGLgG/1boNJLBJGg/J488dIvEc40poI9XrdY
 rk79n/zCxzGEgZPRxxhxAdy/8MH7VuyJZUyN1uSJQyqd8AckeTOIeES1RnbmeVLObA
 kilOIxdAFb+VVPrp0P0oqcQiLbbkFnDtPT1X1xl8mTXxzmzU9Eqq0EhTOyjCGwvAF7
 o+89EwES9IfMLdk/ab3QTVa7UnoA7pNuRGzDY1yDdm6TxpdTZU/vqB6ly5fgeslQQU
 sOd+Vyr3zT1IQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 29 Jul 2024 17:39:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jul
 2024 17:39:26 +0300
Date: Mon, 29 Jul 2024 17:39:26 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>,
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v1 3/4] test/py: introduce test for ab_dump command
Message-ID: <20240729143926.tc6su3jp5jmvc3xl@CAB-WSD-L081021>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-4-ddrokosov@salutedevices.com>
 <CAFLszTgU_NtS9bM1WXw0RLiZNJHvrBUEr7ujkUsELw0PxHPZkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTgU_NtS9bM1WXw0RLiZNJHvrBUEr7ujkUsELw0PxHPZkg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186774 [Jul 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/29 12:26:00 #26174422
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

Hello Simon,

On Sun, Jul 28, 2024 at 01:36:05PM -0600, Simon Glass wrote:
> Hi Dmitry,
> 
> On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > The ab_dump command allows you to display ABC data directly on the
> > U-Boot console. During an A/B test execution, this test verifies the
> > accuracy of each field within the ABC data.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> 
> This looks good but please use lower-case hex.

Thank you for the quick review!

I will change it to lower-case hex in the next version.

-- 
Thank you,
Dmitry
