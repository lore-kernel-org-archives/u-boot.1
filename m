Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07DDC4725D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 01:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5442D87887;
	Thu, 18 Jan 2024 02:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YzU9lAUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C989E87A2A; Thu, 18 Jan 2024 02:21:48 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFC887AB9
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 02:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240118012140epoutp01dff932e9a69a60df7a6afa2037d38fd7~rTGmIJuUs1865818658epoutp01C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240118012140epoutp01dff932e9a69a60df7a6afa2037d38fd7~rTGmIJuUs1865818658epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1705540900;
 bh=U6ytVm1nozk5jFeau1thu/HuDE1mKtHeMJq80FDvU44=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=YzU9lAUhSJXV1oKGOvVK66bFyZfFJyglkEtWonsqjEh1pYJmEWF76OoFmUiC9PyEM
 vF19ac/eaq+TOooQ9Vc/6t46dYdOUN7DNFAyqVPvDppJM84Xt3yiYHPi6ULpcDdDLs
 rlkekqegiIZLoYfefFVjshlLp+vKRTZzJNg87wKg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240118012139epcas1p10afdf894b8d7e97fa7a0656b447c8622~rTGlzxgi72611926119epcas1p1B;
 Thu, 18 Jan 2024 01:21:39 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.234]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4TFlMQ50grz4x9Py; Thu, 18 Jan
 2024 01:21:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FF.21.09731.22D78A56; Thu, 18 Jan 2024 10:21:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240118012138epcas1p48695ba7bb3fa49a8d7877f4a3a1e82a0~rTGknwwL91667616676epcas1p4b;
 Thu, 18 Jan 2024 01:21:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240118012138epsmtrp15572004d286f60e5c773cad172bacf01~rTGkm809w1114411144epsmtrp1U;
 Thu, 18 Jan 2024 01:21:38 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-26-65a87d2255fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E3.87.08817.22D78A56; Thu, 18 Jan 2024 10:21:38 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240118012138epsmtip171cbfca3c409013035c941bddc2e4a75~rTGkajKoz1479414794epsmtip1R;
 Thu, 18 Jan 2024 01:21:38 +0000 (GMT)
Message-ID: <575015d0-c212-4471-a7d2-ad917d8264f9@samsung.com>
Date: Thu, 18 Jan 2024 10:21:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
Content-Language: en-US
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Cc: cheehong.ang@starfivetech.com, Alex Soo <yuklin.soo@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231128063859.615-1-kuanlim.lee@starfivetech.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTT1epdkWqwfSd6hZ7ezqZLbo2vWey
 eLu3k93i/Z7Z7BZblp9gdmD1OHtnB6PH7bO8AUxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
 pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QNuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
 qQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZp+/tZC/o4Kj4/v8IUwPjFbYuRk4OCQET
 iT+XfwLZXBxCAjsYJV6s6oByPjFK7OyZDuV8Y5R4emw7E0zLqlkboRJ7GSXarrxngnDeM0rs
 OjqNBaSKV8BO4ub666wgNouAqsTzs32sEHFBiZMzn4DViArIS9y/NYO9i5GDQ1jAR6JtohRI
 mFlAXOLWk/lgy0QEXCVmHGxggohXSUz+dAtsDJuAjsT2b8fB4pwCDhJbmzexQ9TIS2x/O4cZ
 4tBH7BKLttRC2C4SZzunMULYwhKvjm9hh7ClJF72t7GD3C8h0MwosXTJQVYIp4dR4l/DdWgo
 GUvsXzqZCeRQZgFNifW79CGW8Um8+9rDChKWEOCV6GgTgqhWkbj0+iUTzPy7T/6zQtgeEtPn
 zWWBhNVkRom50x6yT2BUmIUULLOQ/D8LyT+zEDYvYGRZxSiWWlCcm55abFhgBI/u5PzcTYzg
 pKhltoNx0tsPeocYmTgYDzFKcDArifD6GyxLFeJNSaysSi3Kjy8qzUktPsRoCoycicxSosn5
 wLScVxJvaGJpYGJmZGxiYWhmqCTOe+ZKWaqQQHpiSWp2ampBahFMHxMHp1QDk+bhbZbz3S3f
 xNy/P7n12SrGSlO/np7MGQtmygY/jDqeu1Ln6ivb2Vs+nPG90y6ypMx8UZz9vQkrlxcYaGXv
 vLXjus6nsqfPWjzWBqqw/JVJ2RnJ5uPXsPPfb5mD2U9OVnzPZWKyuGIYdkzga6XEM6Fff9ga
 XBk3fq5ZdNzOYt6TLSdYt+3auL+7YOL7H+8+mU+T+jrx81cvFd7yfiW30OXnJs5x7BYr5dm8
 0u+lxkW1V1xvp//ddm/q1V1xqifzZj3vvN/J/8R35u/JXJ7Bfhs+h16948+8IbPqB+cUlpRn
 S+bekNvXY2RgK3qo9fb964kH5rNzJ4m0remr2WhifGVnwtmdcu+f7YmQdL2cx2WpxFKckWio
 xVxUnAgAeEENSBMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnK5S7YpUg5m/hS329nQyW3Rtes9k
 8XZvJ7vF+z2z2S22LD/B7MDqcfbODkaP22d5A5iiuGxSUnMyy1KL9O0SuDJO39vJXtDBUfH9
 /xGmBsYrbF2MnBwSAiYSq2ZtBLK5OIQEdjNKLHq/jx0iISXx+elUoAQHkC0scfhwMUTNW0aJ
 eVNfMIHU8ArYSdxcf50VxGYRUJV4fraPFSIuKHFy5hMWEFtUQF7i/q0Z7CBzhAV8JNomSoGE
 mQXEJW49mQ82RkTAVWLGwQYmiHiVxKYvb8FsIQF7iX0PmsHGsAnoSGz/dhwszingILG1eRPY
 SGYBdYn184QgWuUltr+dwzyBUWgWkiNmIdk2C6FjFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WK
 E3OLS/PS9ZLzczcxgoNfS2sH455VH/QOMTJxMB5ilOBgVhLh9TdYlirEm5JYWZValB9fVJqT
 WnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QD06bJjqmsLrdnbmiNmxusYSvPZ7h8
 4ZsLxRv7/jv07o3bdKbN7NF/Z3t7prnuy3YeYuB/z3zCaHb4430LJuywnXP3hfKLpQXZi/9p
 Mh2ZvynVcdUqzgtxJ0+6XWhhyrrUKsBmaam5f8llN+4MH5X9RZJzdBaencjDU2Au+/X6MvPY
 U5/tRXOyT2h7/TebrHzEu+Bol+wjBZlDRrXCU3jP935+IJmutCM85inDb9P7DHcr5n60Xdnf
 12b0rP+j995Y56XBH9d2Sx847MTstmfeerGoNfkWwp/eegVy+s2fr7L4sZRQzJYXSgsjrvz6
 Y+rtr9qrFVvUMPfbwlmGdTc/RCvvWGkh2LznjqqgwEwrOyWW4oxEQy3mouJEAF1toj3tAgAA
X-CMS-MailID: 20240118012138epcas1p48695ba7bb3fa49a8d7877f4a3a1e82a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240118012138epcas1p48695ba7bb3fa49a8d7877f4a3a1e82a0
References: <20231128063859.615-1-kuanlim.lee@starfivetech.com>
 <CGME20240118012138epcas1p48695ba7bb3fa49a8d7877f4a3a1e82a0@epcas1p4.samsung.com>
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

On 11/28/23 15:38, Kuan Lim Lee wrote:
> Cadence SDMMC v6 controller has a lot of changes on initialize
> compared to v4 controller. PHY is needed by v6 controller.
> 
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Co-developed-by: Alex Soo <yuklin.soo@starfivetech.com>
> Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Changes in v2
> - Rename file sdhci-cadence6-phy.c to sdhci-cadence6.c
> - Remove CONFIG_MMC_SDHCI_CADENCE_V6
> - Rewrite code of v6 configuration part
> - Add sdhci_cdns6_phy_init() function
> ---
>  drivers/mmc/Makefile         |   1 +
>  drivers/mmc/sdhci-cadence.c  |  63 ++------
>  drivers/mmc/sdhci-cadence.h  |  69 ++++++++
>  drivers/mmc/sdhci-cadence6.c | 294 +++++++++++++++++++++++++++++++++++
>  4 files changed, 376 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/mmc/sdhci-cadence.h
>  create mode 100644 drivers/mmc/sdhci-cadence6.c

