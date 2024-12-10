Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF490E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 11:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32C8891E8;
	Tue, 10 Dec 2024 12:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="lLy+wUqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29EA89220; Tue, 10 Dec 2024 12:16:41 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABD8891C4
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 12:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241210111634epoutp01d4c6438a90284d8c65b703f353d25c83~PzKYAnl-i3259332593epoutp01C
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 11:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241210111634epoutp01d4c6438a90284d8c65b703f353d25c83~PzKYAnl-i3259332593epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733829394;
 bh=0kfzU7hbJPEippuVy3lSbdvdB26aAGE1LB/p4uE1pYU=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=lLy+wUqLai9NJhnLpZPvYXG4Drglo7naucZ9hA251VpQwq8e4KYQsE8OGiBktvwAp
 sE0FhiD70xUp9+/LdEsp/kvqImm80/dRPnOfyaWUh7teIjXqeMgBtT0CUKsMFE9tTN
 kwR8fsKdYmgwU6fB2xKiOjj/kODhtgwV2cTgD8Wo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241210111634epcas1p40e8140d83068738fc8e0ba91a8f0dcf8~PzKX2w2lU2304823048epcas1p4f;
 Tue, 10 Dec 2024 11:16:34 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6x4x4M3Pz4x9Pv; Tue, 10 Dec
 2024 11:16:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E6.F2.23253.11328576; Tue, 10 Dec 2024 20:16:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241210111633epcas1p3c6494f2b82cc658465e816f06ba8cec2~PzKWie8dZ3095230952epcas1p3a;
 Tue, 10 Dec 2024 11:16:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210111633epsmtrp2f0d91558349fc7dfb3a9973c789df122~PzKWhz2aC2621126211epsmtrp2o;
 Tue, 10 Dec 2024 11:16:33 +0000 (GMT)
X-AuditID: b6c32a33-5a18170000005ad5-58-675823111fa3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 53.FA.33707.11328576; Tue, 10 Dec 2024 20:16:33 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210111633epsmtip19a4103ab53ca0aad1548da9922b691ef~PzKWSA7tq1343813438epsmtip1Q;
 Tue, 10 Dec 2024 11:16:33 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Stephen Warren'"
 <swarren@wwwdotorg.org>, "'Stephen Warren'" <swarren@nvidia.com>, "'Matthias
 Brugger'" <mbrugger@suse.com>, "'Peter Robinson'" <pbrobinson@gmail.com>
In-Reply-To: <20241209195528.730260-3-sjg@chromium.org>
Subject: RE: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
Date: Tue, 10 Dec 2024 20:16:32 +0900
Message-ID: <0b9101db4af4$f7f4e8e0$e7debaa0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWHE+rJGlG6nTqz0NZt5G0ftzdLQJbrX6/AiSRicKyxa8U0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmga6gckS6wY8GBYsFk5+wWqxbtYbN
 4tuWbYwWN6a3sFq8OtjGYjF10mZ2i7d7O9kd2D1mN1xk8dg56y67x6sDq9g9zt7ZwejR2/yO
 zWP9lqssHhvnhgawR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
 ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fL
 Sy2xMjQwMDIFKkzIzmg+1stYsIyv4vTDCSwNjHe5uxg5OCQETCRW7LLoYuTiEBLYwSjxadUv
 VgjnE6PE6x+zmeGcCf0L2LsYOcE6Tq/sY4FI7GSUON37CqrqJaPE1L9NLCBVbAJ6Ev8XLWQG
 2SEiECFx9oYfSJhZ4DKjxLsniSBhTgFziV/fA0FMYQELiXcf+UFMFgFViQPLLUFMXgFLiS0d
 0hBLFSR+Pl3GCmKLCDhJNOw8yAgxT0Ridmcb2H4JgY/sEpMnHWeFaHCR+N82HcoWlnh1fAvU
 9VISn9/tZYNoaGaUWLrkICuE08Mo8a/hOhtElbHE/qWTmUCuYBbQlFi/Sx9iG5/Eu689rJCA
 45XoaBOCqFaRuPT6JRPM/LtP/kPt9ZBoPzUVbK+QwHZg4LSHTmCUn4Xk7lkICxYwMq1iFEst
 KM5NT002LDCEx2Jyfu4mRnAi1DLewXh5/j+9Q4xMHIyHGCU4mJVEeDm8Q9OFeFMSK6tSi/Lj
 i0pzUosPMZoCw3Eis5Rocj4wFeeVxBuaWBqYmBkZm1gYmhkqifOeuVKWKiSQnliSmp2aWpBa
 BNPHxMEp1cAU4O92PGfTnX+X3qaesSutmLqdc/obsQzehbGPpp66836CuP15raMK/QlpUyZV
 LfZ+Hmv5t2R7TVDGBZ8ppzI2Tc8/vnfp4XgNnylL5q0sENX9VPHj5FQegR9GV9Y94eN1Oc6j
 oBjisXnxD8tfix1lMwqny52UyMh4rnRwV5S2c5BNS3t5KMf1chGhck81x7erJJ5HPJDvm5Z5
 +Ma7BSun3W/dN8tp1s03t1g2KunNLp2b08l/4wfnkyuNFToBJTqut37N4Z485+uTA8faHP5t
 kG7atPufrmfUvuAlr4L+ugeuabog8apbRDn0hBOfVkzJ+T1fUh8pMbhb87KohBj++D2pPvnP
 i3x9e5ETZ/MllFiKMxINtZiLihMB/eVyFw0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnK6gckS6wfHjXBYLJj9htVi3ag2b
 xbct2xgtbkxvYbV4dbCNxWLqpM3sFm/3drI7sHvMbrjI4rFz1l12j1cHVrF7nL2zg9Gjt/kd
 m8f6LVdZPDbODQ1gj+KySUnNySxLLdK3S+DKaD7Wy1iwjK/i9MMJLA2Md7m7GDk5JARMJE6v
 7GPpYuTiEBLYzihxbtkmJoiElMTnp1PZuhg5gGxhicOHi0HCQgLPGSU+dnuA2GwCehL/Fy1k
 BrFFBCIk5v5axAQyh1ngOqPEhvNN7BBDNzNKrG9bCDaIU8Bc4tf3QBBTWMBC4t1HfhCTRUBV
 4sBySxCTV8BSYkuHNMQBChI/ny5jhZjuJNGw8yAjiM0sICIxu7ONeQKjwCwk7gJGxlWMoqkF
 xbnpuckFhnrFibnFpXnpesn5uZsYwSGsFbSDcdn6v3qHGJk4GA8xSnAwK4nwcniHpgvxpiRW
 VqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUw+RwMMvHgeJDj19vY
 Ieh3MTTtQGhRrZk618tVJlMv3jBMY/5sdkb5+m+/5QX6P/OXeHKdvRKUnrVLkN//QFBq56s3
 0163Zhnn7yyXvKXRobi+yjyO+UPkgY2vjnfcaf3476O1LNu7noXejM/E0s04dzxL3nGhJL1W
 9saVc3N+qPLklk8oYHP1nlZyLa+jVeKpAMeH6RJMoeyiAkt7TGYrKyVdvnZh04VDy2Xu8hev
 Oaza+98jhe+pcnTTr+A+hVghP7k7M7X3PYzyT73au+/VEwvz5WWLpn60272BYzazTdtLldvy
 c9tDrp++z2fEmlR0sPRCA8f6D3wJT1lq7V9ZpqduCBPIDzaJz7xy5LYSS3FGoqEWc1FxIgDQ
 j3cy0AIAAA==
X-CMS-MailID: 20241210111633epcas1p3c6494f2b82cc658465e816f06ba8cec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209195605epcas1p233930ab12fd267c75549496e19540e9a
References: <20241209195528.730260-1-sjg@chromium.org>
 <CGME20241209195605epcas1p233930ab12fd267c75549496e19540e9a@epcas1p2.samsung.com>
 <20241209195528.730260-3-sjg@chromium.org>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Simon Glass
> Sent: Tuesday, December 10, 2024 4:55 AM
> To: U-Boot Mailing List <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Stephen Warren <swarren@wwwdotorg.org>; Stephen Warren
> <swarren@nvidia.com>; Matthias Brugger <mbrugger@suse.com>; Simon Glass <sjg@chromium.org>; Peter
> Robinson <pbrobinson@gmail.com>
> Subject: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
>
> Set this option so that all boot images stay within the bottom 512MB of
> memory. This should allow us to drop the fdt_high and initrd_high
> options.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>


> ---
>
> Changes in v3:
> - Add to the existing comment block
>
> Changes in v2:
> - Add new patch to set bootm_size
>
>  board/raspberrypi/rpi/rpi.env | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285edd..a327fccc77f 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
>   * Even with the smallest possible CPU-GPU memory split of the CPU getting
>   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>   * large initrds before they start colliding with U-Boot.
> + *
> + * Limit bootm_size to 512MB so that all boot images stay within the bottom
> + * 512MB of memory
>   */
> +bootm_size=0x20000000
> +
>  #ifdef CONFIG_ARM64
>  fdt_high=ffffffffffffffff
>  initrd_high=ffffffffffffffff
> --
> 2.34.1



