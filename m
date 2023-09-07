Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B47EE14D4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 06:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08423860C9;
	Thu,  7 Sep 2023 08:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WOUnBXH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8640786290; Thu,  7 Sep 2023 08:40:09 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B94833F5
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 08:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230907063959epoutp0449582c2494719decb7bce1f38e4df107~CipkR1lud0947509475epoutp04j
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 06:39:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230907063959epoutp0449582c2494719decb7bce1f38e4df107~CipkR1lud0947509475epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1694068799;
 bh=Lq71M3CleC+Cutu7YYeeqbAkGzpV+5xC521HP7PSd9Q=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WOUnBXH2robDv9Nu9l7TynQSUIR56MQQ3pcC8yrrrtrgxggIHZbDtTfXfZsG+8Vf2
 gKvXsaZ8ZIaRyuscBiYdawhQmrBSuKq9S30YAVt5Hq15eHzBytA0Vy6R+cpeGqiAyU
 +OxhXmNrgJvQsWRJHyi8tDt6ZX449gAIOj4/fEp4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230907063959epcas2p1690eb338e73ed6de3c81bd8f6403c928~CipkF8v8i2878828788epcas2p1Z;
 Thu,  7 Sep 2023 06:39:59 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Rh8k70dBjz4x9Pt; Thu,  7 Sep
 2023 06:39:59 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.E4.09660.E3079F46; Thu,  7 Sep 2023 15:39:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230907063958epcas2p315c94b15db47a29fe62803f91482ae40~CipipcR-K3204732047epcas2p3h;
 Thu,  7 Sep 2023 06:39:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230907063958epsmtrp1c3aa9429007bedd2b8ad7d0d4593e5d2~CipioyjQ32311223112epsmtrp1H;
 Thu,  7 Sep 2023 06:39:58 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-c2-64f9703eb514
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DB.7A.08742.D3079F46; Thu,  7 Sep 2023 15:39:58 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230907063957epsmtip17bd7795b8bb5dbf93c0318ee18e917d9~Cipib7cGR1244412444epsmtip1G;
 Thu,  7 Sep 2023 06:39:57 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Simon
 Glass'" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>, "'Rick Chen'" <rick@andestech.com>, "'Leo'"
 <ycliang@andestech.com>
In-Reply-To: <641ab172-256a-4d38-84d8-bdf871adddd1@canonical.com>
Subject: RE: [PATCH v3 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Date: Thu, 7 Sep 2023 15:39:57 +0900
Message-ID: <000001d9e156$1e85e9f0$5b91bdd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGg499DM90sTBxeCyBe1PnwO8LscANkgWAfAjfnQlcB06WNwLBFXssQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTVNeu4GeKQdckcYsLjTfZLd6+OMto
 8W3LNkaLt3s72S0eH3rN5MDqsef0LGaPWQ29bB6zGy6yeJy9s4MxgCUq2yYjNTEltUghNS85
 PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLGSQlliTilQKCCxuFhJ386m
 KL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj2vwlLAUT5StuLN7I
 3MD4QqKLkZNDQsBEYsni3axdjFwcQgI7GCUaP/WzQTifGCUWr+ljAakSEvjGKNHXmgDTsebg
 DiaIor2MEl2bFkA5Lxgl1v1/xQhSxSagL/GyYxvQXA4OEYFUibXt6SBhZoFEiSnvJrKC2JwC
 jhIrfs9iArGFBWIkJi3qAFvGIqAi8WVnAzOIzStgKXHxZQ8bhC0ocXLmExaIOdoSyxa+ZoY4
 SEHi59NlYDNFBNwknl9czApRIy7x8ugRdpDbJAR6OSQ677yAanCR+L64nQXCFpZ4dXwLO4Qt
 JfGyv40d5GYJgXKJHcuSIHpbGCWa2/ZA9dpL/Lg5BewvZgFNifW79CHKlSWO3II6jU+i4/Bf
 qCm8Eh1tQhCN6hIHtk+HWior0T3nM+sERqVZSB6bheSxWUgemIWwawEjyypGsdSC4tz01GKj
 AmN4VCfn525iBKdILfcdjDPeftA7xMjEwXiIUYKDWUmE9538txQh3pTEyqrUovz4otKc1OJD
 jKbAoJ7ILCWanA9M0nkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBK
 NTCtmzhb7VXTXL6J7pOPyc119T/z7P8zT9OkyfuCul+svLGVvzTv38T1XPtX5qhMSVJmWuih
 b7e+WP9Spg27Q67i+yYN7ooPXB9WHPNs+qD5ZHnKqzr2sr7zGn+jnqRzcx2ub7/BKfdippiB
 g2vZFYkatzn5Ns5uBa+u1Kgsdljx8PcLi5cysy4v85zStGdSfJFBxs2CTzIiR1XdLC9ufMxY
 KbZtxYJTdq47TQL/RB2Yfu73xP0JE9cfXsHR+2xL1CGLos7G1XdmOO1qZ+I4qfS+b/Xnllcv
 r5228fv3XaBj3l+jWpvIH26lhbtD7587avDjuq3uJNaArGyHJbMEfq2cIvqI4+BZ5tOLu0Rq
 VpSfVGIpzkg01GIuKk4EAMWOgRQaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTteu4GeKwd2ZjBYXGm+yW7x9cZbR
 4tuWbYwWb/d2sls8PvSayYHVY8/pWcwesxp62TxmN1xk8Th7ZwdjAEsUl01Kak5mWWqRvl0C
 V8bho1tZCp7IVZy/dpO1gXGtRBcjJ4eEgInEmoM7mLoYuTiEBHYzSpy81sEIkZCVePZuBzuE
 LSxxv+UIK0TRM0aJ/uZtrCAJNgF9iZcdELaIQKrE/+edzF2MHBzMAskSrf8lIOr/MEr8nrCW
 GaSGU8BRYsXvWUwgtrBAlMSM9kawXhYBFYkvOxvAangFLCUuvuxhg7AFJU7OfMICYjMLaEs8
 vfkUzl628DUzxHEKEj+fLoO6wU3i+cXFrBA14hIvjx5hh3mmeyfETJBn7j54yT6BUXQWkhWz
 kKyYhWTFLCSjFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4xLc0djNtXfdA7
 xMjEwXiIUYKDWUmE9538txQh3pTEyqrUovz4otKc1OJDjNIcLErivOIvelOEBNITS1KzU1ML
 UotgskwcnFINTNVbGawzb171Zf35y+Znaei7Gyz/g9fq+uh2P86cuM191fK+SVFFLXnaawTW
 9x3J8F+W9GRV8NmZ24on/fLvXHjn4OfC7yV6furWfakVJTvjHxg05loJZhmznxEMurxBWZ6h
 58SaS/zubx/8uyxboqSTnuJ/ZlLAtz3KkSoah6YxB5vWeshYOBYEJ3pNPZ6UM3/FttO9Fosf
 p6h6/wq/yhO5b6/1+ZZn1fUredmYFatXZ83d2ur+SGZ3y7oG3ROC07N+/Rbw3aoYLKPVtUBP
 XMOXbdXp9OmfLq3P99ghMu2GmPqFHweKQk6y2WlKfzRl7kkuXFgT0foufxaDql35l5pm+WcO
 5f9y5l0+oftFiaU4I9FQi7moOBEAmnzLCiADAAA=
X-CMS-MailID: 20230907063958epcas2p315c94b15db47a29fe62803f91482ae40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18@epcas2p2.samsung.com>
 <20230906051814.1393464-4-chanho61.park@samsung.com>
 <641ab172-256a-4d38-84d8-bdf871adddd1@canonical.com>
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
> From: Heinrich Schuchardt <heinrich.schuchardt=40canonical.com>
> Sent: Thursday, September 7, 2023 2:27 AM
> To: Chanho Park <chanho61.park=40samsung.com>; Simon Glass
> <sjg=40chromium.org>
> Cc: u-boot=40lists.denx.de; Rick Chen <rick=40andestech.com>; Leo
> <ycliang=40andestech.com>
> Subject: Re: =5BPATCH v3 3/3=5D timer: riscv_aclint_timer: add
> timer_get_boot_us for BOOTSTAGE
>=20
> On 06.09.23 07:18, Chanho Park wrote:
> > timer_get_boot_us function is required to record the boot stages as
> > us-based timestamp.
> > To get a micro-second time from a timer tick, this converts the
> > formula like below to avoid zero result of (tick / rate) part.
> >
> > From: time(us) =3D (tick / rate) * 10000000
Still typo 10000000 -> 1000000
>=20
> Where is the old implementation that you refer to?

I referred it from timer_get_boot_us function of lib/time.c

lib/time.c
55         else if (timer_rate > 1000000)
56                 return lldiv(count, timer_rate / 1000000);
57         else
58                 return (unsigned long long)count * 1000000 / timer_rate;

>=20
> > To  : time(us) =3D (tick * 1000) / (rate / 1000)
> >
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
> > ---
> >   drivers/timer/riscv_aclint_timer.c =7C 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/timer/riscv_aclint_timer.c
> b/drivers/timer/riscv_aclint_timer.c
> > index e29d527c8d77..73fb87912851 100644
> > --- a/drivers/timer/riscv_aclint_timer.c
> > +++ b/drivers/timer/riscv_aclint_timer.c
> > =40=40 -6,6 +6,7 =40=40
> >
> >   =23include <common.h>
> >   =23include <clk.h>
> > +=23include <div64.h>
> >   =23include <dm.h>
> >   =23include <timer.h>
> >   =23include <asm/io.h>
> > =40=40 -44,6 +45,28 =40=40 u64 notrace timer_early_get_count(void)
> >   =7D
> >   =23endif
> >
> > +=23if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
> > +ulong timer_get_boot_us(void)
> > +=7B
> > +	int ret;
> > +	u64 ticks =3D 0;
> > +	u32 rate;
> > +
> > +	ret =3D dm_timer_init();
> > +	if (=21ret) =7B
> > +		rate =3D timer_get_rate(gd->timer);
> > +		timer_get_count(gd->timer, &ticks);
> > +	=7D else =7B
> > +		rate =3D RISCV_MMODE_TIMER_FREQ;
> > +		ticks =3D readq((void __iomem
> *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> > +							RISCV_MMODE_TIMEROFF));
> > +	=7D
> > +
> > +	/* Below is converted from time(us) =3D (tick / rate) * 10000000 */
> > +	return lldiv(ticks * 1000, (rate / 1000));
>=20
> I found similar code in drivers/timer/cadence-ttc.c and
> drivers/timer/omap-timer.c with
>=20
>      us =3D (ticks * 1000) / rate;
>      return us.
>=20
> Either their code or yours must be wrong.
>=20
> What I am missing in include/timer.h is a documentation that defines if
> timer_dev_priv.clock_rate and timer_get_rate() yield the frequency in Hz
> or kHz.

'rate' seems to be Hz not kHz. So, I think they need to be corrected.

>=20
> Once we have added the missing information in the include we can start
> reviewing this patch.
>=20
> I really dislike that we have code per architecture and don't update and
> use a implementation in lib/time.c (where we also have an
> implementation) or drivers/timer/timer-uclass.c. Can't we have a single
> implementation which is driver model based and eliminate all others?

Actually, I tried to use lib/time.c's implementation or make a generic func=
tion in timer-uclass.c as you mentioned.
However, there are different implementations in cadence-ttc.c, rockchip_tim=
er.c, tegra-timer.c, omap-timer.c and tsc_timer.c.
The basic codes seems to be almost identical if we can get a DM timer succe=
ssfully but fallback codes look different.
If timer_get_boot_us can be implement in the timer-uclass.c, we still need =
per-driver callback function for supporting these different fallback codes.

Best Regards,
Chanho Park

