Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622B3D1358F
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 00:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9A988744;
	Mon, 28 Oct 2024 01:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="t/gozOPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A2688ECB; Mon, 28 Oct 2024 01:30:59 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B683E88730
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 01:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241028003044epoutp0468cb01acc2fbd0c2f2774bc81019aa66~CdnNPhAWz1725117251epoutp049
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:30:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241028003044epoutp0468cb01acc2fbd0c2f2774bc81019aa66~CdnNPhAWz1725117251epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730075444;
 bh=D5XP+P4OKmP3dvG63jy/mJqmn9NyUaL1no8+dOceqn0=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=t/gozOPD12olywJMq//A11k3x/9QAr6tkbX/tUnDx4TtKykh9bqwQQnNjlqoyV/Uu
 elmsLIJQfXpgeiYeaMI+FfQdmhO2T5aR00raatrLjMcgcJcfY5yTwVA4GA90zCFG0O
 jglBAavjG9qD0znRcIOSGk/x+NgXOTe3AhVW2GQA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241028003044epcas1p356cfcb2d1e3dd4def9f7915b24e695df~CdnM-d41f0619206192epcas1p3J;
 Mon, 28 Oct 2024 00:30:44 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.136]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4XcDnb28Kvz4x9Pq; Mon, 28 Oct
 2024 00:30:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 25.AE.19363.33BDE176; Mon, 28 Oct 2024 09:30:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241028003043epcas1p1a412d029d329dac92060d51bf19a4a8c~CdnL3jzgR2959129591epcas1p1M;
 Mon, 28 Oct 2024 00:30:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241028003043epsmtrp2726f98f11981984fd804e25816389317~CdnL21p2m2861328613epsmtrp2a;
 Mon, 28 Oct 2024 00:30:43 +0000 (GMT)
X-AuditID: b6c32a4c-02dff70000004ba3-72-671edb334c00
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E1.24.18937.23BDE176; Mon, 28 Oct 2024 09:30:42 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241028003042epsmtip18cc04b8d7f53dbee818fecc1b02a222a~CdnLrOsWN1786817868epsmtip1-;
 Mon, 28 Oct 2024 00:30:42 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <wens@csie.org>, "'Andre Przywara'" <andre.przywara@arm.com>
Cc: "'Jagan Teki'" <jagan@amarulasolutions.com>, "'Tom Rini'"
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <linux-sunxi@lists.linux.dev>
In-Reply-To: <CAGb2v671y0EkMKmYJKqPp0ek3_-kv26adUjG=g5-tdPe+5f3Hw@mail.gmail.com>
Subject: RE: [PATCH] sunxi: power: axp809: Fix DCDC4 programming
Date: Mon, 28 Oct 2024 09:30:42 +0900
Message-ID: <104601db28d0$9f4290d0$ddc7b270$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGqQcI8CYpISmIDDBim4CD6STd+mgIv+UgYAnP1doWy1/4noA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmga7xbbl0g29r+C1WzPvJaPFl0wQ2
 iyn7drFZTJ20md3i7d5Odoufh84zObB5rP14n9Vjzbw1jB4bHq1m9Xh1YBW7x9k7Oxg9Xmye
 yRjAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0
 h5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgxt7g0L10vL7XEytDAwMgU
 qDAhO2PJn07mgj7+iq3HPzE1MD7h7mLk4JAQMJG48ZC1i5GLQ0hgD6PEmod/2CCcT4wSU6/e
 RXC+7H4F5HCCdRz/+YoJIrGTUeJR+xOwhJDAS0aJU7fsQWw2AT2J/4sWMoPYIgIOEp2TprGD
 NDALdDNKtE9eANbAKRAosXbvTLAiYaCirl9TGEFsFgFViQPPellBbF4BS4mZh34xQ2xWkPj5
 dBlYnFlARGJ2ZxszyA8iAk4Sh2/VgsyXEHjELtF38y4LRL2LxNer56BsYYlXx7ewQ9hSEp/f
 7WWDaGhmlFi65CArhNPDKPGv4TrUn8YS+5dOZgLZwCygKbF+lz7EYj6Jd197WCGBxyvR0SYE
 Ua0icen1SyaY+Xef/GeFsD0kfi47zQgJrWuMEgve32WdwCg/C8kPsxA2LGBkWsUolVpQnJue
 mmxYYKibl1oOj87k/NxNjOBEqOWzg/H7+r96hxiZOBgPMUpwMCuJ8K6OlU0X4k1JrKxKLcqP
 LyrNSS0+xGgKDM2JzFKiyfnAVJxXEm9oYmlgYmZkbGJhaGaoJM575kpZqpBAemJJanZqakFq
 EUwfEwenVANT/ZMz15kXuxjzvvh8rip+p7mU3UkWz8MWDXzGqS//K7P9/BLz2cgqK12xekXh
 cvMe6S0511Pm7XnSYbxhEdvJfpOgX2mC0rIhNet/rYh+vmvCu6CZjFMVZEUzE6fuOB8oVX6p
 +n/h+dClezU/PLpc/IfR87KA8k9W0ffamsf2Rld05u29IL5Wz136e9GsZQtVVZasfHlZf1+S
 VfkGhs5DOyz23XKRPO3VFJNw9Nfl176Zfm3b78z8uGPHWRa7QBmmHXsfzj2s7WMbM6P4/pNV
 Vv/e3vuWvDqoU/mhSkZC0EuNGVz7v3T8+BYW7tor8XbD1liFTrOlp01sk4N/b7jyJUV296wp
 AjM1ay2n3i62V2Ipzkg01GIuKk4EADsOcAoNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnK7Rbbl0g5d9VhYr5v1ktPiyaQKb
 xZR9u9gspk7azG7xdm8nu8XPQ+eZHNg81n68z+qxZt4aRo8Nj1azerw6sIrd4+ydHYweLzbP
 ZAxgi+KySUnNySxLLdK3S+DKWPKnk7mgj79i6/FPTA2MT7i7GDk5JARMJI7/fMXUxcjFISSw
 nVHi5sqXzBAJKYnPT6eydTFyANnCEocPF0PUPGeU2LP7GhtIDZuAnsT/RQvB6kUEnCSWnbzN
 AmIzC/QzSnzaIQjRcIlRYvr2FUwgCU6BQIm1e2eCNQgLOEh0/ZrCCGKzCKhKHHjWywpi8wpY
 Ssw89AvqCAWJn0+XsUIMFZGY3dnGDHIQyLLDt2onMArMQpJZwMi4ilE0taA4Nz03ucBQrzgx
 t7g0L10vOT93EyM4bLWCdjAuW/9X7xAjEwfjIUYJDmYlEd7VsbLpQrwpiZVVqUX58UWlOanF
 hxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUxbz268cZHvbMKlt7r5D6w1WYXkTByK
 Bd/vFu9zKdM33PxV5WX7boHiVyKpCzUNytzzcnTWKTB/cq64pczqICV90LJAMpZjqrlt/v+5
 HBq7il8nrGm7VX9uwY34vLXOYf+2yL/UqXO81POwbH9GdsG6/eesotQSF21+2PrputQ9v/71
 keeY5NeVqu1IYmHM3iobtOHt310Fr3wmiG+9uzpqn5DImXkbdCVkNtfPj57adsThxepF3c92
 SeWL1quLvr6UHvPQrU6ltqDvodyH2Utqql5Ln1p14VOzvmna24KPmxNX/pmx+e6CwmXfdQ91
 Se0VNL6k5u2zzeqrAGv57AN+hzJk6ovSwi9OnbJsFacSS3FGoqEWc1FxIgBKznU2ygIAAA==
X-CMS-MailID: 20241028003043epcas1p1a412d029d329dac92060d51bf19a4a8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241025144320epcas1p3f4f3ad62a7b7aacb4cebc7f1ce9fc14c
References: <20241007222625.18883-1-andre.przywara@arm.com>
 <CGME20241025144320epcas1p3f4f3ad62a7b7aacb4cebc7f1ce9fc14c@epcas1p3.samsung.com>
 <CAGb2v671y0EkMKmYJKqPp0ek3_-kv26adUjG=g5-tdPe+5f3Hw@mail.gmail.com>
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



> -----Original Message-----
> From: Chen-Yu Tsai <wens@csie.org>
> Sent: Friday, October 25, 2024 11:43 PM
> To: Andre Przywara <andre.przywara@arm.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>; Jagan Teki <jagan@amarulasolutions.com>; Tom Rini
> <trini@konsulko.com>; u-boot@lists.denx.de; linux-sunxi@lists.linux.dev
> Subject: Re: [PATCH] sunxi: power: axp809: Fix DCDC4 programming
>
> On Tue, Oct 8, 2024 at 6:27?AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > When trying to set the DCDC4 regulator, the code was accidentally
> > setting the voltage register for DCDC5 (VCC-DRAM). The higher voltage
> > doesn't harm the DRAM chips, but upsets the Linux regulator driver: when
> > it tried to correct that, it tripped over a separate DT bug.
> > The DCDC5 DT limits are 1.425 and 1.575V, which cannot bet set with the
> > rail's resolution of 50mV. The kernel driver gave up, and made in turn
> > the system hang, as the PMIC powers essential devices.
> >
> > Fix the copy&paste bug by using the correct PMIC voltage register.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

>
> > ---
> >  drivers/power/axp809.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/axp809.c b/drivers/power/axp809.c
> > index 9e38e1a7450..ec3eca1ac4b 100644
> > --- a/drivers/power/axp809.c
> > +++ b/drivers/power/axp809.c
> > @@ -93,7 +93,7 @@ int axp_set_dcdc4(unsigned int mvolt)
> >                 return pmic_bus_clrbits(AXP809_OUTPUT_CTRL1,
> >                                         AXP809_OUTPUT_CTRL1_DCDC4_EN);
> >
> > -       ret = pmic_bus_write(AXP809_DCDC5_CTRL, cfg);
> > +       ret = pmic_bus_write(AXP809_DCDC4_CTRL, cfg);
> >         if (ret)
> >                 return ret;
> >
> > --
> > 2.46.2
> >


