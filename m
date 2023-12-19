Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC6C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B2687732;
	Tue, 19 Dec 2023 12:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="feFZ4hST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D4887732; Tue, 19 Dec 2023 12:41:23 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40FB8767C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231219114118epoutp02f5c39ac76635a3adabe1832da5a56a79~iONC2eQ2q1559515595epoutp02U
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:41:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231219114118epoutp02f5c39ac76635a3adabe1832da5a56a79~iONC2eQ2q1559515595epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702986078;
 bh=Hyjm/rKfkdeNFIZ3n6RexQoy1dB4oYiai3JRdQqMs7s=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=feFZ4hSTMYI3eCAWeYxtGjbyxjaFI/ZCB0g4qK3h7kQzhFZbDvZARevG2BjfAQ152
 OKcLYReaGY/yMLy1bGOTNfY+n37FEYY/l2aSDCnmTpxb9CuV2pqWlXQ75tK7/BCsdc
 vM8caVDCOjsPdUpOnoOfKbeg0yvTxMU93WyNI7EA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231219114117epcas2p4a820f51120268ca3e324253c29ad3de4~iONCSYay22032820328epcas2p4g;
 Tue, 19 Dec 2023 11:41:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SvZXF1jFyz4x9Q6; Tue, 19 Dec
 2023 11:41:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 E7.C3.09607.D5181856; Tue, 19 Dec 2023 20:41:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231219114116epcas2p3f926fcb4ea7f21bde5b0133077ad1f72~iONBkB1x_0594405944epcas2p3h;
 Tue, 19 Dec 2023 11:41:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231219114116epsmtrp2d50d4f68a0b5d04122190f9c6fa99b53~iONBjZEsa2382223822epsmtrp2P;
 Tue, 19 Dec 2023 11:41:16 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-d2-6581815d2f13
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 52.4C.18939.C5181856; Tue, 19 Dec 2023 20:41:16 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219114116epsmtip10eed2d7bd913061e7a66ac1cd8360f2b~iONBUaGGd2504325043epsmtip1x;
 Tue, 19 Dec 2023 11:41:16 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-7-semen.protsenko@linaro.org>
Subject: RE: [PATCH 06/13] clk: exynos: Move pll code into clk-exynos7420
Date: Tue, 19 Dec 2023 20:41:16 +0900
Message-ID: <007101da3270$46cb1050$d46130f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wEkcd+MApBdQrCvZQtXcA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmhW5sY2Oqwa4VrBbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
 LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
 F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRntLbsYixYx1Zx7PxO1gbGTaxdjJwcEgImEifffmUH
 sYUEdjBK9N7j7mLkArI/MUp0zDrJCOcsOt3ADNPxeNpWJojETkaJVee+s0A4Lxglmlt/s4FU
 sQnoS7zs2MYKkhAROMsocebWKbAlzAJ5EjP2zwCzOQUcJPpmXgKzhQU8Jfom7AFrZhFQlVjU
 84cFxOYVsJQ4/2cqM4QtKHFy5hMWiDnyEtvfzoE6SUHi59NlrBBxcYmXR4+wQ8RFJB6u/ghn
 t947C1TPAXSQk8Ttt8IQYSmJ2a9fsoPcKSHwhENixb8OaMC4SGxc8BmqV1ji1fEt7DANn9/t
 ZYOwiyW62i6xQDQ3MEqcbr8CVWQv8ePmFFaQZcwCmhLrd+lD3MYn0XH4LztIWEKAV6KjTWgC
 o8osJJ/NQvLZLCTfzEIYtICRZRWjWGpBcW56arFRgQk8tpPzczcxgpOtlscOxtlvP+gdYmTi
 YDzEKMHBrCTC67KoPlWINyWxsiq1KD++qDQntfgQoykwrCcyS4km5wPTfV5JvKGJpYGJmZmh
 uZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUyHX8cJ1b2ZO7lAQMYrrX2t/6EpmYyR
 hhMTc5/O9q5a/u/Yx+Tzhblzlgmtn3Ih5dAKpl33YjjuJ4s92mW/0D30oNjy7ksTzNdtXcR4
 qDjhoeCubYrrxDnL/Eu4jWeKfO/g9dmfvXXO7RNVF1YcyJ0eofN61sszE2o1n+2ZkL/twuIZ
 O0w89rcGMa+LcuN4uaL1spBoyLcn+fPbBQx07966fWBeoIim1xtrpsMyu+6u6ttSt/CRv0eT
 /Om26Fs9ijOKZ8x2PbTQpPf8rZMxSyPqKwqW6X4OX1Sm7XbdbOPCn0eseU5M1tB9z3bpsZW/
 zvSWy/bnlb/maLjYvheoOTZ5xSZnV9mFXuwTckzWmrftV2Ipzkg01GIuKk4EANU1EUk/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSnG5MY2Oqwan36hbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziiuGxSUnMyy1KL9O0SuDJaW3YxFqxjqzh2fidrA+Mm
 1i5GTg4JAROJx9O2MnUxcnEICWxnlDj1+zcTREJW4tm7HewQtrDE/ZYjrBBFzxglbp5dzgiS
 YBPQl3jZsQ0sISJwkVFiTcNOsASzQIHExfnX2CA6jjJKvNuzmRkkwSngINE38xLYWGEBT4m+
 CXvYQGwWAVWJRT1/WEBsXgFLifN/pjJD2IISJ2c+AYpzAA3Vk2jbCDVfXmL72znMENcpSPx8
 uowV5uo/R+eyQdSIS7w8egTqAxGJh6s/wn3z6vgWuHjrvbPMIONFBJwkbr8VhgiLScycdhlq
 vJTE7Ncv2ScwSs5CctAshINmITloFpLFCxhZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIE
 R79W0A7GZev/6h1iZOJgPMQowcGsJMLrsqg+VYg3JbGyKrUoP76oNCe1+BCjNAeLkjivck5n
 ipBAemJJanZqakFqEUyWiYNTqoGplG3Kz78bjPTKmKcwTvzp6z3B1Twgt51968spjPVtq+4o
 zfbYm9rfsf3KibPbudL/uTsvvhV35P5dKaNFC7IdTmpN/pfjf1VftPDTbpPYosUaHrVHTl7I
 yztmzWO6ksP+ybQKmZMxrfeAcblx/TvtJzu92UsCH7rJ5Kcw/BCvzH10h8X+rZbhrT77DQ0n
 bj52yvmzJej6wwkVXUFW3o57POaL2pv5LpnaMGOdRuauC8VZnY2BjP/DW8VFe7otXudv3m0x
 u6UsbOamOeltx9ZGtZud+P46W1L/hbA3/x05cw4jw598lbYOM9RUslrUjOT9om9In/mUwR+X
 mRbsyZl61aXxz5RrZoYqq9/UK7EUZyQaajEXFScCAB4ldNdtAwAA
X-CMS-MailID: 20231219114116epcas2p3f926fcb4ea7f21bde5b0133077ad1f72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031821epcas2p1f857736dec4f11bd6c576f223519dffd
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031821epcas2p1f857736dec4f11bd6c576f223519dffd@epcas2p1.samsung.com>
 <20231213031646.28828-7-semen.protsenko@linaro.org>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Sam Protsenko
> Sent: Wednesday, December 13, 2023 12:17 PM
> To: Minkyu Kang <mk7.kang@samsung.com>; Tom Rini <trini@konsulko.com>;
> Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> Subject: [PATCH 06/13] clk: exynos: Move pll code into clk-exynos7420
> 
> PLL utilities code is only used by clk-exynos7420 driver at the moment.
> Move it into clk-exynos7420 to make clk-pll.c file available for CCF PLL
> clocks implementation, which is coming in the next patches.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

