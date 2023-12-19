Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A5EC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEDE877C8;
	Tue, 19 Dec 2023 12:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WoUHEG/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DBA487879; Tue, 19 Dec 2023 12:33:58 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A6487834
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231219113352epoutp026cf7bc05af159e236baea3cbbf8d5c1c~iOGjvRvEw0999709997epoutp02Y
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:33:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231219113352epoutp026cf7bc05af159e236baea3cbbf8d5c1c~iOGjvRvEw0999709997epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702985632;
 bh=AU/wQCvvj3MOZA2mlLRRyvdOd27+xX4wpwr6QxF5q00=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WoUHEG/2DajnfKqowNqvlWF3XN1zR1p/GYOwQqZ5txo0Kgu8+7U6MR2N2sVNQIQ+q
 T5Me8wQA/wKU2vZLw+Ugq27aLMJ6c6WZu0GARm4ml7SAZ6hn8m23GZd4BFebAmpo2y
 X0ZpWs0Nzlf0fnz1liIRatz9xIeuST9xyU8fRE94=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231219113351epcas2p34b5d607dba8ed3f8bf3d8ee785279980~iOGjTT04l1545715457epcas2p3t;
 Tue, 19 Dec 2023 11:33:51 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SvZMg38nlz4x9Pw; Tue, 19 Dec
 2023 11:33:51 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 66.27.10022.F9F71856; Tue, 19 Dec 2023 20:33:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231219113351epcas2p217dab3d7ee26e61b9f83bb825d517ca9~iOGicatvJ2535325353epcas2p2r;
 Tue, 19 Dec 2023 11:33:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231219113351epsmtrp1737a8ab53505ee6a776757c27659e81b~iOGibk9WR2021420214epsmtrp18;
 Tue, 19 Dec 2023 11:33:51 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-23-65817f9f9b79
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1D.80.08755.E9F71856; Tue, 19 Dec 2023 20:33:50 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219113350epsmtip1dca3b5763922f7dad2620e0d44e9c3e4~iOGiRCBMz2787727877epsmtip1R;
 Tue, 19 Dec 2023 11:33:50 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-9-semen.protsenko@linaro.org>
Subject: RE: [PATCH 08/13] clk: exynos: Add Exynos850 clock driver
Date: Tue, 19 Dec 2023 20:33:50 +0900
Message-ID: <006d01da326f$3d29d000$b77d7000$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wI6sLFMAnYhAe6vXSkJIA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmqe78+sZUg0ndohbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
 LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
 F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNh6mq1gO3vFoofdbA2MC9m6GDk5JARMJFben8zY
 xcjFISSwg1HiUtsJNgjnE6PEjitrWCGcb4wS/773MsK0rNiyGSqxl1Hi9qrLLBDOC0aJR/e+
 MINUsQnoS7zs2AZWJSJwllHizK1T7CAJZoE8iRn7ZwDZHBycAg4SSxpYQMLCAk4Sn3ccASth
 EVCVePpxFRNICa+ApcSFzUkgYV4BQYmTM5+wQEyRl9j+dg4zxEEKEj+fLmOFiItLvDwKMUZC
 QETi4eqPcHbrvbNg9SJAq97++g8Vl5KY/follP2GQ+LCb3cI20Wi8c9XFghbWOLV8S1w9S/7
 26DsYomutktgv0sINDBKnG6/ApWwl/hxcworyP3MApoS63fpQ9zGJ9Fx+C/Y5xICvBIdbUIT
 GFVmIflsFpLPZiH5ZhbCoAWMLKsYxVILinPTU4uNCozhkZ2cn7uJEZxqtdx3MM54+0HvECMT
 B+MhRgkOZiURXpdF9alCvCmJlVWpRfnxRaU5qcWHGE2BQT2RWUo0OR+Y7PNK4g1NLA1MzMwM
 zY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamBieVqkrs4w33nhIdnU2btzYv+1Pf+V
 czfHjOtnL9/iq+2HNnE846wrY9UPX8PzrrNXtLlRL/DnMuYD5z5uq3jfabFz3dugzgfhZof+
 tK8W//NR/WSx7/J+xesSWt8iFYVnVTya3xOwek7d03/WPI5Hd7nxyS27klxaLrdD+Er79Pdn
 Pz5LmhKW/YA9RPXr5O+Z928Ih37NifF5PP3/yQfiHxUTNmwT2bJD3eWXRh6XX/9zy2W8Mzav
 TMv/Ei2xcalboae1yfSbz31uLq55Fxci3z1xP0PXlJAzC1Rcz3krJ2eufjPv//JbdSuaivQ+
 X2BZxFnhv3Al/7GH7/wYPesn+L5vNNNet+KlZ0GHKM9iJZbijERDLeai4kQAS9RSDT4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSnO68+sZUg9csFs/fXWay6DjSwmix
 9d4EJovnffuYLL5t2cZoMXXSZnaLt3s72S0OT/3A6MDhMbvhIovHvFknWDx2zrrL7vHhY5zH
 qwOr2D3uXNvD5nH2zg5Gj74tqxgDOKK4bFJSczLLUov07RK4Mk5sPc1WsJ29YtHDbrYGxoVs
 XYycHBICJhIrtmxmBbGFBHYzSkw7bQURl5V49m4HO4QtLHG/5QhQDRdQzTNGiR/HPoM1swno
 S7zs2AaWEBG4yCixpmEnI0iCWaBA4uL8a2wQHUcZJbbum87UxcjBwSngILGkgQWkRljASeLz
 jiNgG1gEVCWeflwFVsIrYClxYXMSSJhXQFDi5MwnLCBhZgE9ibaNUNPlJba/ncMMcZuCxM+n
 y1hhbv5zdC4bRI24xMujR6DuF5F4uPoj3C+vjm+Bi7feOws2RwTomre//kPFxSRmTrsMNV9K
 Yvbrl+wTGCVnIbloFsJFs5BcNAvJ5gWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3
 MYLjX0tzB+P2VR/0DjEycTAeYpTgYFYS4XVZVJ8qxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8
 RW+KkEB6YklqdmpqQWoRTJaJg1OqgUnZeq3sP8czy428/2w9eDzFnWl9wO2of6mTAoL3cbRO
 +Tsz3OHtpull/7mFci7JMCUoNFcvWabsfWOlxwGVY+fF2A7Gr/yTvXyGg4Tzi2hjz7VzHK3u
 35JUFNmV2qQck7PX6uiWCb1OVcvP3H+0/n5ZWtH9mc9jGI/wHLGyKPldebrNXmnSz6PczYYf
 Z9XHcdvu/5D/5yJDfbppcFIYi9YGoc13vCPqGi4xf43xfy87rd9zRofY31nrFq9OZVtz9eMZ
 B7G3NQqHTRXmXXwlXNR2onwG89olU3uFsgQ3Vy8XPdfzfYrqPw2xNmN5Z79HH002s92TcfQq
 NZq1jPnAS8VL4r8KGlxF/q6aJKlSm6HEUpyRaKjFXFScCAAiWv/jbgMAAA==
X-CMS-MailID: 20231219113351epcas2p217dab3d7ee26e61b9f83bb825d517ca9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031843epcas2p33e1d770b197b3053635facb5212f26dc
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031843epcas2p33e1d770b197b3053635facb5212f26dc@epcas2p3.samsung.com>
 <20231213031646.28828-9-semen.protsenko@linaro.org>
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
> Subject: [PATCH 08/13] clk: exynos: Add Exynos850 clock driver
> 
> Heavily influenced by its Linux kernel counterpart. It's implemented on
> top of recently added Samsung CCF clock framework API. For now only UART
> leaf clocks are implemented, along with all preceding clocks in CMU_TOP
> and CMU_PERI. The UART baud clock is required in the serial driver, to
> get its rate for the consequent baud rate calculation.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

