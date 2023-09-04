Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D0C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D972864A7;
	Mon,  4 Sep 2023 09:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="pPGFqJh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F41864A7; Mon,  4 Sep 2023 09:42:37 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBCD86497
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230904074229epoutp045b4cc032be58ec682e1f5f019a0c2a14~BokRVHYav2978529785epoutp04Z
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 07:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230904074229epoutp045b4cc032be58ec682e1f5f019a0c2a14~BokRVHYav2978529785epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693813349;
 bh=2mfyyfeOoZYYn/x854G72DEl+8YQLEElIQLkYQw65qA=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=pPGFqJh/4m3DfsVMpSL4gpQsfd5rB5jCNV1XZHu4ESzoYtD2bH9utyPVctMpSPa9x
 WRRf712FnXSIPn14jxJ6RilcqOxFBeJZ09diMgX9Yt8SLh8O2cxKQjahCJ7Dzdgrxb
 LqdJtqLv3FdW7YvEWOYvVxbyItyW5xmVMQzLADEE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230904074228epcas2p1130ebbc6d27577b7303a995e3dddd87e~BokRD8wDH2143621436epcas2p1y;
 Mon,  4 Sep 2023 07:42:28 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RfLFc2b09z4x9Px; Mon,  4 Sep
 2023 07:42:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 FD.04.09660.46A85F46; Mon,  4 Sep 2023 16:42:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230904074227epcas2p3fa1fdcecbeb64c26f47e191666e83d7d~BokQLRvTt1596615966epcas2p3l;
 Mon,  4 Sep 2023 07:42:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230904074227epsmtrp1f63d85a82ab57f883cf12d3f61fa1918~BokQKr4en1511715117epsmtrp1v;
 Mon,  4 Sep 2023 07:42:27 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-bc-64f58a64a108
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9B.5B.08788.36A85F46; Mon,  4 Sep 2023 16:42:27 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230904074227epsmtip15f98deef09be3a175ad3b4f894f06c9d~BokQB24E70423004230epsmtip1M;
 Mon,  4 Sep 2023 07:42:27 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Leo Liang'" <ycliang@andestech.com>
Cc: "'Rick Chen'" <rick@andestech.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <ZPWBAKPO5HBAzFRK@swlinux02>
Subject: RE: [PATCH v2 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Date: Mon, 4 Sep 2023 16:42:27 +0900
Message-ID: <003c01d9df03$5a67fa80$0f37ef80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJDo85+4KW0dBmGLBsoxGjOXDx6aAKO/hFpAXmVEGsDGNxoKa79s1Vg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqW5K19cUg6tvBC3evjjLaPFtyzZG
 i7d7O9ktHh96zeTA4rHn9Cxmj9kNF1k8zt7ZwRjAHJVtk5GamJJapJCal5yfkpmXbqvkHRzv
 HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0TkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
 q5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnfFp7wqmglN8FX9mzWVrYLzG3cXIySEh
 YCLxb+dt1i5GLg4hgR2MEkeubWSGcD4xSuw+d50dwvnGKNEzZR8bTMuVKe+gEnsZJc5t7YZq
 ecEo8WDuX0aQKjYBfYmXHdtYQWwRAU2JRU9PAsU5OJgFUiT2vLcECXMChXdeOMcCYgsLxEh8
 mPUVbAGLgIrEhosbwWxeAUuJPYe/sELYghInZz4Bq2cWkJfY/nYOM8RBChI/ny5jhYiLS7w8
 eoQdYq2bxPbPB8B+kxBo5JBoaP0J9YGLxL5tv6GahSVeHd/CDmFLSbzsb2MHuVNCoFxix7Ik
 iN4WRonmtj1Q9fYSP25OYYX4RVNi/S59iHJliSO3oE7jk+g4/BdqCq9ER5sQRKO6xIHt01kg
 bFmJ7jmfWScwKs1C8tgsJI/NQvLMLIRdCxhZVjGKpRYU56anFhsVGMPjOjk/dxMjOCFque9g
 nPH2g94hRiYOxkOMEhzMSiK8ctqfUoR4UxIrq1KL8uOLSnNSiw8xmgKDeiKzlGhyPjAl55XE
 G5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwOTcJfLI5GLJD5dnLvJr
 znJ37MvlCfBcEVBcqL/lReMFpfXn4jKl5rooce01PeFbeyM2rkvkyNHwX/u2X1p2eM8KhcRX
 l3TdGFzW9U4otvtu/17b8nLlF+UId+MNG94L77Z8GGSd9VNNTCG9nEsqUCQ8pDbjAfuO/V98
 925oL6056hOm/DVgVsay42a6f8M26ZaH/XmdmtX4aNvho7cj9feXFtZlvOw/HODbrBleHLIq
 kt/osoDc+VUzNjXuP68s+Gptofn8+iR9pXruJcJ5107eeC3w8GHIiVrbtR9Z+dYs9lz6pojL
 jNdeq0HfWNfANXCSCessafZr213+T2OOLLSSrRapWiN3bMYrmdbtSizFGYmGWsxFxYkAgDR3
 KREEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTje562uKQe88S4u3L84yWnzbso3R
 4u3eTnaLx4deMzmweOw5PYvZY3bDRRaPs3d2MAYwR3HZpKTmZJalFunbJXBlfNq7gqngFF/F
 n1lz2RoYr3F3MXJySAiYSFyZ8o69i5GLQ0hgN6NE/4rJjBAJWYln73awQ9jCEvdbjrBCFD1j
 lHj2cR8bSIJNQF/iZcc2VhBbREBTYtHTk2DNzAJpEgduXmCEaHjCKHFv5iFmkAQnUNHOC+dY
 QGxhgSiJ7WuOgsVZBFQkNlzcCDaUV8BSYs/hL6wQtqDEyZlPgOo5gIbqSbRthJovL7H97Rxm
 iOMUJH4+XcYKEReXeHn0CDvMA3+OzmWDuM1NYvvnA6wwz7w6voV9AqPoLCQbZiFsmIVkwywk
 UxcwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOJi2tHYx7Vn3QO8TIxMF4iFGC
 g1lJhFdO+1OKEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxS
 DUyz5vZP/r20OrkooyxKu3eOr/3HfRJSKwXeOD5eK+Se8FHMhW19x07e9h3TbZ3MtyYzzHKZ
 LM0xgWVpUFOe9YeL+1awFiTwMDpntR6b0ryqLeVnrmVgef+z551Mtj1bT/m1m2j97UwtrDaR
 CX65ZcYao4WlnVmmxcEem3wybm6K1/JINpy/4rML++zTOwV/mHktfj+N4XbsyxtKpyRjOQ7W
 zruzUd5VX6B+5foLfKYMxvX6x9evbVQ8NOth+L4jex/W9dw/9YzLuzRo9vv/Ht8VrAQ9Tpjq
 f457wlCxsNQ06oi28rVctQWXPuq1PzdrcOFasG+SmMaOTYmrzB4HH43s+pG3NljKmsu6Q0Xr
 qxJLcUaioRZzUXEiAOSWm2QVAwAA
X-CMS-MailID: 20230904074227epcas2p3fa1fdcecbeb64c26f47e191666e83d7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5@epcas2p3.samsung.com>
 <20230828094938.2061606-4-chanho61.park@samsung.com>
 <ZPWBAKPO5HBAzFRK@swlinux02>
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
> Sent: Monday, September 4, 2023 4:02 PM
> To: Chanho Park <chanho61.park@samsung.com>
> Cc: Rick Chen <rick@andestech.com>; Simon Glass <sjg@chromium.org>; u-
> boot@lists.denx.de
> Subject: Re: [PATCH v2 3/3] timer: riscv_aclint_timer: add
> timer_get_boot_us for BOOTSTAGE
> 
> Hi Chanho,
> 
> On Mon, Aug 28, 2023 at 06:49:38PM +0900, Chanho Park wrote:
> > timer_get_boot_us function is required to record the boot stages as
> > us-based timestamp.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >  drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/timer/riscv_aclint_timer.c
> > b/drivers/timer/riscv_aclint_timer.c
> > index e29d527c8d77..8b67745bb4a2 100644
> > --- a/drivers/timer/riscv_aclint_timer.c
> > +++ b/drivers/timer/riscv_aclint_timer.c
> > @@ -6,6 +6,7 @@
> >
> >  #include <common.h>
> >  #include <clk.h>
> > +#include <div64.h>
> >  #include <dm.h>
> >  #include <timer.h>
> >  #include <asm/io.h>
> > @@ -44,6 +45,27 @@ u64 notrace timer_early_get_count(void)  }  #endif
> >
> > +#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
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
> > +		rate = RISCV_MMODE_TIMER_FREQ;
> > +		ticks = readq((void __iomem
> *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> > +
RISCV_MMODE_TIMEROFF));
> > +	}
> > +
> > +	return lldiv(ticks * 1001, (rate / 1000));
> 
> Why is this dividend 1001 ?

It's a typo. I'll correct when I send v2.

Best Regards,
Chanho Park

