Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F728D40D08
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CF3891A4;
	Wed,  6 Nov 2024 00:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="h7VkJ0KG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F05891D0; Wed,  6 Nov 2024 00:35:20 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BC7891A4
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 00:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241105233513epoutp0124596974d3c4054c65cbdeca42b5e940~FNqTgeiG12365123651epoutp01U
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241105233513epoutp0124596974d3c4054c65cbdeca42b5e940~FNqTgeiG12365123651epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730849713;
 bh=F3DT1W5FXq2inCV7iXL5k/oia5r5h4tK8R2VHpZoO1g=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=h7VkJ0KGcjBzHY4UnxgrPzX2Vr4GzIyIiXI+xt024QjMg6/oEsM1c9xjlhabz0ND1
 lrRCb/Ht6nVXrWMh1E73BAutVgIeGjSclioM9t0hPXLaD3S0V/cLKDI2T14IpYMILa
 S4fKCKYWdS9cmfV1gNQr/L2m0EfqGujYtmhhkGn4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241105233513epcas1p15de8990417b37a393b535e3254b75f1a~FNqTG8g7f1440914409epcas1p1w;
 Tue,  5 Nov 2024 23:35:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.237]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Xjl7N0jvpz4x9Q2; Tue,  5 Nov
 2024 23:35:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 08.DD.09403.FABAA276; Wed,  6 Nov 2024 08:35:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241105233511epcas1p1c16d682920faf6943b3e9897e608ce56~FNqR2_j9c0312003120epcas1p15;
 Tue,  5 Nov 2024 23:35:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241105233511epsmtrp24f68c15bf88d7d98be20decc2c2e04ed~FNqR2KwjV2548325483epsmtrp2Z;
 Tue,  5 Nov 2024 23:35:11 +0000 (GMT)
X-AuditID: b6c32a37-ad8c8a80000024bb-41-672aabaf325f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B5.25.18937.FABAA276; Wed,  6 Nov 2024 08:35:11 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241105233511epsmtip17accc52d25dcfe5e6eeaaff7be35b2f3~FNqRrB3ku1926919269epsmtip1Q;
 Tue,  5 Nov 2024 23:35:11 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, <mbrugger@suse.com>, <pbrobinson@gmail.com>
In-Reply-To: <20241105223851.GO3600562@bill-the-cat>
Subject: RE: [PATCH] board: rpi: Change from CONFIG_ARM64 to CONFIG_PHYS_64BIT
Date: Wed, 6 Nov 2024 08:35:11 +0900
Message-ID: <02e901db2fdb$5b6bb410$12431c30$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJkjVLChXpY1RMDi1qJCDFhYd6H8gGI+xQIAq0GKvWxdOosMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmge6G1VrpBr+3M1osmPyE1WLdqjVs
 FlMnbWa3eLu3k92BxWPnrLvsHq8OrGL3OHtnB6PH+i1XWQJYorJtMlITU1KLFFLzkvNTMvPS
 bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4B2KimUJeaUAoUCEouLlfTtbIryS0tS
 FTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMxqOihe856lYfWEzcwPjfq4u
 Rk4OCQETiQVdv9m6GLk4hAR2MEpcbX0E5XxilJjypIsVznm7oI0dpmXJqRNQiZ2MEvP3rody
 XjJKzFzTwwxSxSagJ/F/0UIwW0RAVWLXx8lg3cwC7hJrPy4BszmBJm2a2MnUxcjBISwQIPH/
 kBpImEVAReLT0UdMIDavgKXE+47VrBCLFSR+Pl3GCjHSSeLF0o+MECNFJGZ3tjGD3CAhcIhd
 YvWnVmaIBheJE51Hoa4Wlnh1fAuULSXx+d1eNoiGZkaJpUsOskI4PYwS/xqus0FUGUvsXzoZ
 7DpmAU2J9bv0IbbxSbz72sMKEpYQ4JXoaBOCqFaRuPT6JRPM/LtP/kMd7SHx8slXdkgA7WKU
 ePasn3kCo/wsJIfPQtiwgJFpFaNYakFxbnpqsWGBMTwqk/NzNzGCE5uW+Q7GaW8/6B1iZOJg
 PMQowcGsJMI7L1U9XYg3JbGyKrUoP76oNCe1+BCjKTAoJzJLiSbnA1NrXkm8oYmlgYmZkbGJ
 haGZoZI475krZalCAumJJanZqakFqUUwfUwcnFINTGWlS0Lyl5bvVzggd+2DmNjSQ8GRX68V
 93MJha9Ne91j0LvOZ/WjPVfeNitc/XBVQqVvablh8YZ4DZPTtedPHOB5ZC0WduB/1fH8lNk8
 hs+l13K2b456F2qg03XhV0/KbOXr0/d/2LRq6edjT4s3soTqPWAqbhV8YH76nLjTMZbm3f4b
 PzzL5pCouJsq91VMNPYKUzND8m3Jm9Fzdl/ndXGbPPe37cEpWa6LTBI32zjGaFpefXdTw4RZ
 t0C83uDZkz/JUdcLxPzqgo3eWVT8TIvkzb3H9snKLO9ZTeIurphNwS1Xd964kjVZLSiuRnHn
 KYOvs6s/yT5UNW6qTnDcoN94yZ4j1IMjs5ddQ/i/EktxRqKhFnNRcSIA0RPy8PUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO761VrpBhM3aFssmPyE1WLdqjVs
 FlMnbWa3eLu3k92BxWPnrLvsHq8OrGL3OHtnB6PH+i1XWQJYorhsUlJzMstSi/TtErgyGo6K
 F7znqVh9YTNzA+N+ri5GTg4JAROJJadOsHYxcnEICWxnlLj86CkzREJK4vPTqWxdjBxAtrDE
 4cPFEDXPGSWOHfjBAlLDJqAn8X/RQrB6EQFViV0fJ7OD1DMLeEvM22oEUb8NqP7CVXaQGk6g
 ZZsmdjKB1AgL+Ems6fcCCbMIqEh8OvqICcTmFbCUeN+xmhXiBAWJn0+XsUKMd5J4sfQjI4jN
 LCAiMbuzjXkCo8AsJO4CRsZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMGhqBW0g3HZ+r96
 hxiZOBgPMUpwMCuJ8M5LVU8X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpa
 kFoEk2Xi4JRqYFpwVerh7ikML13drO1at83ayMcjqOttvuCCzXbnBhaL6FzHdS2qLN6P2aym
 VDeI27cdX6d0rzx+j8D0e/8ao7+Kz0iY8Wy9ePWrwo93eWRz5FOyDrudMDu+qvO57YelW8/P
 7Lu5+NQMzfnPAhgU7u8TeOLIIMoR/aNB4eCn+V+EIut5rSqn5xyZFB8icUvGeF0rY095s2v5
 nR3XriQks+2TCb2xrbT8uUqn4YrXy+J7JPgd7lnYs/eWL/vEpNOXKcLrx2q4g6XboPvVg5Uv
 G3k9Jban2K77Z9q69sb2ci/7DcJH1L9oTvku1HHi6/rXET1JSxQjfbcWWccb//i3SrDn2t1j
 zcL321QiT2lOU2Ipzkg01GIuKk4EANbXMna0AgAA
X-CMS-MailID: 20241105233511epcas1p1c16d682920faf6943b3e9897e608ce56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195
References: <CGME20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195@epcas1p1.samsung.com>
 <20241105221936.508328-1-jh80.chung@samsung.com>
 <20241105223851.GO3600562@bill-the-cat>
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, November 6, 2024 7:39 AM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: u-boot@lists.denx.de; mbrugger@suse.com; pbrobinson@gmail.com
> Subject: Re: [PATCH] board: rpi: Change from CONFIG_ARM64 to CONFIG_PHYS_64BIT
>
> On Wed, Nov 06, 2024 at 07:19:36AM +0900, Jaehoon Chung wrote:
> > initrd_high is dependent with CONFIG_PHYS_64BIT configuration.
> > Even though CONFIG_ARM64 is not enabled, CONFIG_PHYS_64BIT can be
> > enabled.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  board/raspberrypi/rpi/rpi.env | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> > index 30228285edde..47529b0b7a68 100644
> > --- a/board/raspberrypi/rpi/rpi.env
> > +++ b/board/raspberrypi/rpi/rpi.env
> > @@ -61,7 +61,7 @@ dfu_alt_info+=zImage fat 0 1
> >   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> >   * large initrds before they start colliding with U-Boot.
> >   */
> > -#ifdef CONFIG_ARM64
> > +#ifdef CONFIG_PHYS_64BIT
> >  fdt_high=ffffffffffffffff
> >  initrd_high=ffffffffffffffff
> >  #else
>
> We really need to drop both of those _high variables in all cases and
> set some reasonable bootm_size

To change some reasonable bootm_size, it needs to know the corresponding reasonable value for each SoC.
I can't change and drop all _high variables in all cases now.
In RPI, I will check reasonable bootm_size and update it.

Best Regards,
Jaehoon Chung

>
> --
> Tom


