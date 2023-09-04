Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E563C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 23:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D7B8643D;
	Tue,  5 Sep 2023 01:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GrkyIYOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACCC8469B; Tue,  5 Sep 2023 01:42:15 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E398469B
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 01:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230904234206epoutp0358f41485451394c4bf6af25675e2e87e~B1qIqmhsL2650326503epoutp03i
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 23:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230904234206epoutp0358f41485451394c4bf6af25675e2e87e~B1qIqmhsL2650326503epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693870926;
 bh=jHlOlIjBvk8PsnuZvA6AOVLsRYMA1k/XghxnY0chVSg=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=GrkyIYOw3VuE+Bf/ABfwv6ITVQpF7WcXFecVyUFeIspL6v4jCAVc9bZV01F6/8LgM
 O8Kp3kj+kIBKdIMcZFKntkfCb+SZF9L234S86shM47QmbtKy8hsM4UoOMWsfFB9AUI
 1yPsswfkY81/OHvjhLn1LQ9hZw1BxsnsyfjeIpMs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230904234206epcas2p1e9fdfe696dbaf41dedaa4d46637cded7~B1qIRQ_nh2078220782epcas2p1l;
 Mon,  4 Sep 2023 23:42:06 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RflXt0TGsz4x9Px; Mon,  4 Sep
 2023 23:42:06 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5C.37.09649.D4B66F46; Tue,  5 Sep 2023 08:42:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230904234205epcas2p3e598895b6e2e6ab67b73d3a8126738f4~B1qHksW353259532595epcas2p3z;
 Mon,  4 Sep 2023 23:42:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230904234205epsmtrp1d683acd4a1ef4f263497e88f4fd64b41~B1qHjrtN90578005780epsmtrp1J;
 Mon,  4 Sep 2023 23:42:05 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-10-64f66b4dd1e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.4B.18916.D4B66F46; Tue,  5 Sep 2023 08:42:05 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230904234205epsmtip167799dfcae3c86e95ff210296a7fcbde~B1qHT652m0870808708epsmtip1I;
 Mon,  4 Sep 2023 23:42:05 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>
Cc: "'Bin Meng'" <bmeng.cn@gmail.com>, "'Anup Patel'"
 <apatel@ventanamicro.com>, <u-boot@lists.denx.de>
In-Reply-To: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
Subject: RE: [PATCH v2 0/2] risc-v: implement DBCN based debug console
Date: Tue, 5 Sep 2023 08:42:04 +0900
Message-ID: <000001d9df89$6951c360$3bf54a20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUGxKyOnWydQaE+ctjXyRYVvq1BwEML1Q+sI562GA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmua5f9rcUg6OuFrMuHWe0mNoTb3Gh
 8Sa7xdsXZxkt3u7tZLd4fOg1kwObx57Ts5g9ZjX0snnsnHWX3ePsnR2MHn9/bmUJYI3KtslI
 TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
 FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ2xZ2oX
 a8El9or333uYGxjXs3UxcnJICJhIvD7XzNLFyMUhJLCDUWJl4wZWCOcTo8TJCfPZ4ZymC5tZ
 YFrW3bkNVbWTUWL71G9MEM4LRolpUw6wg1SxCehLvOzYBlYlItDGKHF28nawBLNApsTGzhag
 7RwcnALuEv2PwKYKC7hJrHj3hhnEZhFQkZi45RyYzStgKXF9wmVGCFtQ4uTMJywQY+Qltr+d
 wwxxkYLEz6fLWEFsEQEriXnz7kHViEu8PHoE7AUJgZkcEmv2r2WFaHCRODL3KVSzsMSr41vY
 IWwpiZf9bewgt0kIlEvsWJYE0dvCKNHctgeq3l7ix80prCA1zAKaEut36UOUK0scuQW1lk+i
 4/BfqCm8Eh1tQhCN6hIHtk+HhqGsRPecz6wTGJVmIXlsFpLHZiF5YBbCrgWMLKsYxVILinPT
 U4uNCozgkZ2cn7uJEZw2tdx2ME55+0HvECMTB+MhRgkOZiUR3nfy31KEeFMSK6tSi/Lji0pz
 UosPMZoCg3ois5Rocj4wceeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPH
 xMEp1cCkfesI58rLPxklC5U9Yrw6TGLWaKjcvVz00mdq2JMpPtMbry0sdQ77u7hfVrfjkhnD
 7Xu/7vY2bv0fJrVuad6NJNblxQGyD0Vt6ssjtpgFXxTODYnZVuE1/3PtDJUFp7buOSF1cD/H
 6zXbHny7Ubw4TiVLsJTt9LFjwfNf2GZPr5Yx5276s2Un04LTDkc2TTg9a1aiEGu18obXay5m
 NFjOlDHRv+/+RMst3/zuQ7epb3eLPrFd+77MeEtwZueWSIeY4DU1FSuMzu75OI1v4vUWbdkW
 vuX7s02WLmC1mBBvsTGSuffPbrl3wjGLu+f6ZysbLtwqNTFh3YT+66Z8wedlmDzeneywvhSg
 n6t/Mq9SiaU4I9FQi7moOBEAFLGYTyQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnK5v9rcUg50tChazLh1ntJjaE29x
 ofEmu8XbF2cZLd7u7WS3eHzoNZMDm8ee07OYPWY19LJ57Jx1l93j7J0djB5/f25lCWCN4rJJ
 Sc3JLEst0rdL4MrYM7WLteASe8X77z3MDYzr2boYOTkkBEwk1t25zdrFyMUhJLCdUeL+7n5m
 iISsxLN3O9ghbGGJ+y1HoIqeMUrs27oIrJtNQF/iZcc2sISIQAejxN7OZ4wgCWaBbIkXTUsZ
 ITpmMEq0L78N1MHBwSngLtH/iAWkRljATWLFuzdg21gEVCQmbjkHZvMKWEpcn3CZEcIWlDg5
 8wkLSCuzgJ5E20ao8fIS29/OgTpUQeLn02WsILaIgJXEvHn3WCBqxCVeHj3CDvNM984eNphn
 7j54yT6BUXQWkg2zEDbMQrJhFpJJCxhZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIEx5pW
 0A7GZev/6h1iZOJgPMQowcGsJML7Tv5bihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB
 9MSS1OzU1ILUIpgsEwenVANT7KVbabYLRKIz8i69iququaKX/tT+S4P3qphQA0n/SbF/d2ze
 5b1OeYO3gsq0m9Okl9+XUI4M8LwQkbugdpcj/6EDNUe9uHsOHJjV/O5S74rXal+9ehdKLN93
 sKIuzyLix4mQ3w/5uV4xCJscubYntPranO6fvreENBmeNPx/LtZUfERhVTFreYTM3Q2LQl7l
 ik0+MHfpkZJJfRKqUeUHtnhKxM4RENHLXp93X2dBncvk3982m/bc4ipJWSXbsnrJ1OnGd2bK
 y9jOltw32ZSxbL509jGZ7N154V0zpt89m/dQrDGm2Mjhy9kTvXsfptb8C/s8+0vHBpU85/kL
 OKWjS35yifn8cNpdwmW+pJJBiaU4I9FQi7moOBEA+XF2oyQDAAA=
X-CMS-MailID: 20230904234205epcas2p3e598895b6e2e6ab67b73d3a8126738f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904112326epcas2p266eee0d2264cf6cf1dd53e5c756cb1d0
References: <CGME20230904112326epcas2p266eee0d2264cf6cf1dd53e5c756cb1d0@epcas2p2.samsung.com>
 <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
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
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Sent: Monday, September 4, 2023 8:24 PM
> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>; Anup Patel <apatel@ventanamicro.com>;
> Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de; Heinrich
> Schuchardt <heinrich.schuchardt@canonical.com>
> Subject: [PATCH v2 0/2] risc-v: implement DBCN based debug console
> 
> Currently we only offer an SBI based debug UART for SBI v0.1.
> With OpenSBI 1.3 the Debug Console Extension (DBCN) has become available.
> This allows us to implement a debug UART in a device independent manor.
> 
> v2:
> 	In the driver check that we are in S-mode.

Thanks for the update. I've tested both patches on my VisionFive2 board.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

