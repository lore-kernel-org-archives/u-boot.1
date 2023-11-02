Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD29DC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 02:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5FC8763B;
	Thu,  2 Nov 2023 03:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ngCQYuzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C31487650; Thu,  2 Nov 2023 03:11:37 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D424875F5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 03:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231102021124epoutp0450c3c36211926bdccc4509d4c13c8cbe~TrHCiRi871539615396epoutp04e
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 02:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231102021124epoutp0450c3c36211926bdccc4509d4c13c8cbe~TrHCiRi871539615396epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698891084;
 bh=dNsHB4kZxAm1dJyleY8DkcrIn3L74RNY8MJONVoo5jI=;
 h=Date:Subject:To:From:In-Reply-To:References:From;
 b=ngCQYuzcTSRA39WppYt9PjgW0m8oVs4gBOV47+JFY7A99qCo8HEZ4VbZ9jV2UT8FG
 A1AkXAbc7HvG+3hw0S7bCEdD9pP2+nSfXyWCFT7JohMveASGJUCxIxqut05gshxyGL
 5EWyBV5s64dOUbWKXYCalk5IUhXwKPbSLLgM+ua8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231102021123epcas1p307b30de5aaf194cc764faf8351b8e1f4~TrHCOEoVw3242532425epcas1p3F;
 Thu,  2 Nov 2023 02:11:23 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SLS6L37R3z4x9Q6; Thu,  2 Nov
 2023 02:11:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.5B.09731.A4503456; Thu,  2 Nov 2023 11:11:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231102021122epcas1p21c93e275b1c2b5bda7353dcdf09a9a2a~TrHAlbrEj2061720617epcas1p2v;
 Thu,  2 Nov 2023 02:11:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231102021122epsmtrp11a8d82c6fdf84ea45d3a2ad291e9db4a~TrHAkyesc2153521535epsmtrp1i;
 Thu,  2 Nov 2023 02:11:22 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-6a-6543054a0b81
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FD.0F.08755.94503456; Thu,  2 Nov 2023 11:11:22 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231102021121epsmtip1ab32541e4d4bfbe6ccadba2cfe6ee849~TrHASRdAa0400304003epsmtip1O;
 Thu,  2 Nov 2023 02:11:21 +0000 (GMT)
Message-ID: <3e69afd5-4204-4fbb-84cf-af6ad5865a6b@samsung.com>
Date: Thu, 2 Nov 2023 11:11:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mmc: renesas-sdhi: Drop <common.h>
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>, Peng Fan
 <peng.fan@nxp.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231101200600.119507-5-paul.barker.ct@bp.renesas.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmnq4Xq3OqwdvnYhbbVzUzW7xtLrZo
 XXmHzeLPyR+sFj9WfWG1eLu3k92BzWPli9nsHmfv7GD02Dl7H5PHgcnnWD02vtvB5PHtzESW
 ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoDOU
 FMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCF
 CdkZj48fZSu4xlrx/v975gbGiyxdjBwcEgImEl/2CncxcnEICexglDi74gcrhPOJUWLBpZlM
 EM43Rom2v1MZuxg5wTpOfDsJVbWXUeJF+xYWCOc9o8TthkmsIHN5BewkFk9yBTFZBFQkdmyI
 A+nlFRCUODnzCQuILSogL3H/1gx2EFtYwFri9MN/YPOZBcQlbj2ZD7ZYROApo8S9VW+YQBJs
 AjoS278dB7M5BVwkjq1bxwbRIC+x/e0cZpAGCYFODolbb+cwQvzmInF6UyTE0cISr45vYYew
 pSRe9rexQ9Q3M0osXXKQFcLpYZT413CdDaLKWGL/0slMIIOYBTQl1u/ShwgrSuz8PRfqUj6J
 d197WCF28Up0tAlBlKhIXHr9kglm190n/1khbA+JRWcPskHC6iKjxNWNDSwTGBVmIQXMLKQA
 mIXkt1kIVyxgZFnFKJZaUJybnlpsWGAEj+3k/NxNjOAkqmW2g3HS2w96hxiZOBgPMUpwMCuJ
 8B42dUgV4k1JrKxKLcqPLyrNSS0+xGgKjJ2JzFKiyfnANJ5XEm9oYmlgYmZkbGJhaGaoJM47
 53FvipBAemJJanZqakFqEUwfEwenVAMTC1+j2Z2SV/qKSrYdJpWaEheO/Spz4mlvNz2u9va7
 o/QZN8vi/ymiPaenbFy7ZsfyxYZKKcefnzoocVPURF8vY+u8UCX9hD0rtjXMv3VnUgpnulz6
 ZuGty5a+efDr44V7GQ08iW+5D+693jzRkdtp+VNH5fJFH2T2BKz67MM0sWPRsU2dIc+ijrJY
 TnOxulwfYFnygu0yu1HapMsmc4+57y4sL759NKWT9wzb1++3hNYHcl7Qjyi7+17FS+RwiMeq
 6pRHHzSSJCw9z7N83zavW9Ou1+7XrL6jE5sFFwvntT028Tu3/3DA0qnuneW++xsTBJcd+91t
 v1RgsiTfl6mrc0KNTFVc4jdyLZwVtfeaEktxRqKhFnNRcSIAPuSs8CsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnK4Xq3Oqwcw8i+2rmpkt3jYXW7Su
 vMNm8efkD1aLH6u+sFq83dvJ7sDmsfLFbHaPs3d2MHrsnL2PyePA5HOsHhvf7WDy+HZmIksA
 WxSXTUpqTmZZapG+XQJXxuPjR9kKrrFWvP//nrmB8SJLFyMnh4SAicSJbydZuxi5OIQEdjNK
 nF22mRUiISXx+elUti5GDiBbWOLw4WKImreMEnd3/mcHifMK2EksnuQKYrIIqEjs2BAH0skr
 IChxcuYTsPGiAvIS92/NYAexhQWsJU4//McIYjMLiEvcejKfCWSkiMBTRolZjdvA1goJ1Eoc
 aH/GBGKzCehIbP92HMzmFHCROLZuHdg5zALqEuvnCUHMkZfY/nYO8wRGwVlIVs9CsmIWQscs
 JB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4WW5g7G7as+6B1iZOJgPMQo
 wcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwen
 VAPTPm7LeCe7G7vffOU2s3e6tEDw+s3fbw/9F3n82+dO/43I/9q9Cief3hDfKzJ7h9/jhyZa
 hzbtCePhXK3+ZdUex+rfdpOVTf8WJ3qbMLxfxtx+5barqYHl4t0akqyVJwoXBewOu+7B/myZ
 fN2Kb0yyTt2pj25M9zaa47ZOledGy6ZJe6c8r4+s5S4LX1S44hj3xcnrVX79//d7rdft20VG
 22bmHz/m9ephgc3HfkN/TZ4LFoa79WU/THm18Gd6WsSa4olv3u9fn3lXoWXjzrL9wqo7Bd2r
 6i75LbCd/G7OpJSLQmlf+pu+RE6w2fu+wWLNMtVEWd09q4+yfXuYcszael4Cp6jx/PdCCS8X
 SjuubFZiKc5INNRiLipOBACAcie6+QIAAA==
X-CMS-MailID: 20231102021122epcas1p21c93e275b1c2b5bda7353dcdf09a9a2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231102021122epcas1p21c93e275b1c2b5bda7353dcdf09a9a2a
References: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
 <20231101200600.119507-5-paul.barker.ct@bp.renesas.com>
 <CGME20231102021122epcas1p21c93e275b1c2b5bda7353dcdf09a9a2a@epcas1p2.samsung.com>
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

On 11/2/23 05:05, Paul Barker wrote:
> In line with changes elsewhere, drop inclusion of the common header.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/renesas-sdhi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 865efdd32184..8cd501c5f7c7 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>  
> -#include <common.h>
>  #include <bouncebuf.h>
>  #include <clk.h>
>  #include <fdtdec.h>

