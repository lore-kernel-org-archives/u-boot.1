Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A2BE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F62894F7;
	Mon,  9 Dec 2024 00:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="SwxDwC78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C004889500; Mon,  9 Dec 2024 00:56:34 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE35893AE
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241208235625epoutp03e8609ac352ebde8c43c09aa0e1871497~PWPPdzOny2968529685epoutp03B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:56:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241208235625epoutp03e8609ac352ebde8c43c09aa0e1871497~PWPPdzOny2968529685epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733702186;
 bh=XY0PZaN7cA8MDO+1pRyUZ0qz8FYfyeDv2PXMNOhO2ps=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=SwxDwC78Vy6gj9JdhECDDT4TZS6Ae4R1EDJ3JGLqZ8Xoxae94cmsjcFxtxiMvWw/U
 RtAdf20rRq2kwaF8afJN0k2i/ihbLKHlXHVEwI+dXQNW90Pkj3w3jbE6eNIDPjozG9
 7Sxl5OE/1pBvC+yKRV0UjCqmi0VnGoCJLg1nKSbM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241208235625epcas1p2ff356c95116f985941b77133780575f1~PWPO-6j3j0891708917epcas1p2D;
 Sun,  8 Dec 2024 23:56:25 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Y622c15Rxz4x9Q3; Sun,  8 Dec
 2024 23:56:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 09.23.24218.72236576; Mon,  9 Dec 2024 08:56:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241208235623epcas1p1a89881d132a2b6a02daf19a112013589~PWPNc37oB0167001670epcas1p1P;
 Sun,  8 Dec 2024 23:56:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241208235623epsmtrp2a7feefd416446e7b39f0d580c4c1cb80~PWPNcKjAN1244212442epsmtrp2a;
 Sun,  8 Dec 2024 23:56:23 +0000 (GMT)
X-AuditID: b6c32a38-17b8524000005e9a-99-67563227c364
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 81.B7.18729.72236576; Mon,  9 Dec 2024 08:56:23 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241208235623epsmtip2408eac9ce90400258aeae74938bbd089~PWPNN6OMG3012430124epsmtip2I;
 Sun,  8 Dec 2024 23:56:23 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Michael Trimarchi'" <michael@amarulasolutions.com>, "'Peng Fan'"
 <peng.fan@nxp.com>, "'Quentin Schulz'" <quentin.schulz@cherry.de>, "'Sean
 Anderson'" <seanga2@gmail.com>, "'Tim Harvey'" <tharvey@gateworks.com>,
 "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20241207172412.1124558-2-sjg@chromium.org>
Subject: RE: [PATCH v3 01/19] spl: mmc: Avoid size growth in
 spl_mmc_find_device() debug
Date: Mon, 9 Dec 2024 08:56:23 +0900
Message-ID: <081f01db49cc$c934ac30$5b9e0490$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIvgUKR8EiTaeGdNdHyU6nlmXm9IwGBLAN5AYhxszWyHEn3cA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQFfDKCzdoO8rk8WpxlYWix+rvrBa
 rL+8jd1i670JTBbftmxjtLh44hOzxdRJm9kt3u7tZHfg8Fj78T6rx9unUxg9ZjdcZPE413OX
 zWPnrLvsHq8OrGL3OHtnB6PHxnc7mAI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
 DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
 mBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2xcfYCx4Cxnxe79J1gaGB+zdzFyckgImEhs71/G
 1sXIxSEksINRYnvXB1YI5xOjxKmPbcwQzjdGiQMru9hgWhbPew9VtZdR4m3HESjnJaPE742d
 TCBVbAJ6Ev8XLQRq5+AQEYiQOHvDD6SGWaCBSWLCmXuMIDWcAhYSqye1gB0iLBAlcfr9cyaQ
 ehYBFYltm/1BwrwClhJ731xlhVisIPHz6TIwW0TASeLz/40sIDazgIjE7E6ISyUEOjkk7nfe
 ZoZocJFY13GQEcIWlnh1fAvU01ISn9/tZYNoaGaUWLrkICuE08Mo8a/hOtSfxhL7l04Gu4hZ
 QFNi/S59iG18Eu++9rCChCUEeCU62oQgqlUkLr1+yQQz/+6T/1BHe0i8f9MNdo+QwE5GiUuX
 ZSYwys9CcvcshAULGJlWMYqlFhTnpqcWGxaYwKMyOT93EyM4UWpZ7GCc+/aD3iFGJg7GQ4wS
 HMxKIrwc3qHpQrwpiZVVqUX58UWlOanFhxhNgQE5kVlKNDkfmKrzSuINTSwNTMyMjE0sDM0M
 lcR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpg0rINuqC6YUKA9P/iliCbqozVaw6E1goETz2/
 3ytI5azskbnmhcdF3MuZv+clzsn49uyFq65veEbQtEf+jZf/zNvExdZWMjG5zDX5934x27BL
 xS8rdu52lQ80m/r2u9HlrarLPwa+azV+P9PoY5i4YeQ+rYtXkk5o3K1+GvMyaJqYe1Hc8r1P
 Gvwn1CldqPv7TVpC9sbN6VVTZ5nd19zekhAXtfnVwV1eZ5yecLzTMPQR3rq4MSN97oWb3Cd+
 G/D9vcUlZBITEdJhxFtxsGDvxxvupQVNnP1ubqeZ1l+9fefmTKkOftuHU1QWch18pXnI9OX1
 wun6hd5vJmdc+Fs5LT9gk7Pa0q1mLpncWkavlViKMxINtZiLihMBDNO90x0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK66UVi6QcsyHYtTja0sFj9WfWG1
 WH95G7vF1nsTmCy+bdnGaHHxxCdmi6mTNrNbvN3bye7A4bH2431Wj7dPpzB6zG64yOJxrucu
 m8fOWXfZPV4dWMXucfbODkaPje92MAVwRHHZpKTmZJalFunbJXBlbFx9gLHgLGfF7v0nWBoY
 H7N3MXJySAiYSCye9561i5GLQ0hgN6PEpXuTWSESUhKfn05l62LkALKFJQ4fLoaoec4o0Xb/
 FVgzm4CexP9FC5lBbBGBCIm5vxYxgRQxC7QwSby9+oEdomMro8TnT9vYQKo4BSwkVk9qAesW
 BurYuPkv2AYWARWJbZv9QcK8ApYSe99chTpCQeLn02WsEAucJD7/38gCYjMLiEjM7mxjnsAo
 MAuJu4CRcRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCga2nuYNy+6oPeIUYmDsZD
 jBIczEoivBzeoelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4
 OKUamA5Wqp+bPaPi+scdIsc7hBquGGaHTtt8vHxhncvZ4i+3jbPrLzDbnf1wpezwGqN3VYt6
 rXN9t+SuU9lzzmff/Zdp9qXqb2Rlt87zfylUbqZy8eSM9LW7fSpi6x5oTbp10jLm08OmW88e
 hk3Ii72w9EmX1MUH9bx1bdIqwge1lp7UfK+5ojn7a4LAiroF9Veu2Jaz8L1cqMY5Z4Hz2Ym1
 L3LvbTFRSZxi57LxmNPskwEzJ2tGdmf9W1nzlWOixcvIpQ5iYdbGi1eHfz1bqvc4eMpVBn+F
 HdGRLy8tv3u3MkjIjnf30V3M7KLPThWLzXK7yZCn9ti68/a+6//m/7T4VvlP2MQt1F4pd/b0
 HR03XjYrsRRnJBpqMRcVJwIA/tPRLuMCAAA=
X-CMS-MailID: 20241208235623epcas1p1a89881d132a2b6a02daf19a112013589
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241207172603epcas1p3fac688f374ee3750de1d056a5a92cc91
References: <20241207172412.1124558-1-sjg@chromium.org>
 <CGME20241207172603epcas1p3fac688f374ee3750de1d056a5a92cc91@epcas1p3.samsung.com>
 <20241207172412.1124558-2-sjg@chromium.org>
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
> From: Simon Glass <sjg@chromium.org>
> Sent: Sunday, December 8, 2024 2:24 AM
> The for() loop ends up being in the code even if the log_debug() does
> nothing. Add a condition to fix this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>
> Changes in v3:
> - Add new patch to avoid size growth in spl_mmc_find_device() debug
>
>  common/spl/spl_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 1f696593216..fe4230170a0 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -81,8 +81,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>  	struct uclass *uc;
>
>  	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> -	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> -		log_debug("%d: %s\n", dev_seq(dev), dev->name);
> +	if (_LOG_DEBUG) {
> +		uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> +			log_debug("%d: %s\n", dev_seq(dev), dev->name);
> +	}
>  	ret = mmc_init_device(mmc_dev);
>  #else
>  	ret = mmc_initialize(NULL);
> --
> 2.34.1



