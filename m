Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED300C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3A08845D;
	Wed, 17 Apr 2024 13:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jRRUFjpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860F988478; Wed, 17 Apr 2024 13:41:03 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E942388447
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240417114054epoutp01baf82ea33e85884975d23cadcf674e1f~HDm9NQR1F0525605256epoutp01m
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:40:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240417114054epoutp01baf82ea33e85884975d23cadcf674e1f~HDm9NQR1F0525605256epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713354054;
 bh=PZEq0pqd4rU2Ho1yfk4JBRbX9QWXmAKi0gwWaW0CjgY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=jRRUFjpOzmwXDnhPYi+Gl66DGRmaZ2bAR52ToBWI34YzmXqoWZZOrc+dMF3UzXVYf
 iqIvDbvlkS1Rk9RkGS4MNAm/51a9/i8+RrFheOwJMgGl1QR4J4r1P0qMxjCo0CVFkw
 ntKG2QwsVt1G/+61IsqnY1YasVUg0bqNyM3dBC5g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240417114053epcas1p3d586a3bdedfef722ef6e23bda9c8c4b6~HDm8nsuSm0701807018epcas1p3G;
 Wed, 17 Apr 2024 11:40:53 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.231]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VKJrN5tKtz4x9Q1; Wed, 17 Apr
 2024 11:40:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.9C.19431.445BF166; Wed, 17 Apr 2024 20:40:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240417114052epcas1p4c09549fcfdbd59d57ac411e151a518de~HDm7UUYEX2878828788epcas1p4l;
 Wed, 17 Apr 2024 11:40:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417114052epsmtrp23079a9279a957de1d09046bf1ccc4cbc~HDm7TFLS32278022780epsmtrp2O;
 Wed, 17 Apr 2024 11:40:52 +0000 (GMT)
X-AuditID: b6c32a4c-485ff70000004be7-65-661fb5446d4f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E6.77.19234.445BF166; Wed, 17 Apr 2024 20:40:52 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417114052epsmtip29dc98cd6e28e186a47b4722e9cd202ac~HDm7Iv2UR2735627356epsmtip2D;
 Wed, 17 Apr 2024 11:40:52 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Kongyang Liu'" <seashell11234455@gmail.com>, <u-boot@lists.denx.de>
Cc: "'Leo Yu-Chi Liang'" <ycliang@andestech.com>, "'Peng Fan'"
 <peng.fan@nxp.com>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20240416073131.8527-1-seashell11234455@gmail.com>
Subject: RE: [PATCH] mmc: cv1800b: Add transmit tap delay config to fix
 write error
Date: Wed, 17 Apr 2024 20:40:52 +0900
Message-ID: <01ff01da90bc$19cd7e80$4d687b80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJctH8J5r3lGfoF8xnQ9yoVG6ixbQKHQD9TsFPVEaA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmga7LVvk0g+9ntC1+rPrCanFs3Ud2
 i6mTNrNbvN3byW7x+NBrJgdWjz2nZzF77Jx1l93j1YFV7B5n7+xg9Nj4bgdTAGtUtk1GamJK
 apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0HYlhbLEnFKgUEBi
 cbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGibX7WQt+
 8FRc/DuVsYHxJFcXIyeHhICJxPdTi1m7GLk4hAT2MEqcv7CHCcL5xCix5vNXVjjn6r0z7F2M
 HGAt1/bYQ8R3Mkrsef4Oquglo8Tv6TNZQeayCehJ/F+0kBnEFhHwlGj4+4MdxGYWKJNo67sN
 ZnMK2EtM2rOAEcQWFgiVeHJqDVicRUBV4lBrM5jNK2ApsWjnDxYIW1Di5MwnLBBz5CW2v53D
 DPGDgsTPp8tYIXZZSTQsa4CqEZGY3dnGDHKchEArh8STpS8ZIRpcJF51TGKHsIUlXh3fAmVL
 SXx+t5cNoqGZUWLpkoOsEE4Po8S/hutsEFXGEvuXTmYChQWzgKbE+l36ENv4JN597WGFBBGv
 REebEES1isSl1y+ZYObfffKfFcL2kDh2bAbzBEbFWUh+m4Xkt1lIfpiFsGwBI8sqRqnUguLc
 9NRkwwJD3bzUcniUJ+fnbmIEJ08tnx2M39f/1TvEyMTBeIhRgoNZSYS3RVg2TYg3JbGyKrUo
 P76oNCe1+BCjKTDEJzJLiSbnA9N3Xkm8oYmlgYmZkbGJhaGZoZI475krZalCAumJJanZqakF
 qUUwfUwcnFINTMWqvzY/f/rI9kMMb8X89gszpG4fMwnpufUoz3aKblDatoLl7YUOXTXTzxRd
 UimPUo+f1XphltPzH7EipUrny1dfUVly8TdvaueJ6ptM4Rtak/oWrH328VvtX9msEwv9Tvxb
 ONfQ4cL6fXf9d+mLL5sWo7Pj79JCV/Xfh/9c71WJdjmycOZnm9UVR/Vu6jMVR+tW328puXvK
 aE/balX9i/NTpaRXff4ZnHLUdu6dWO4pC1b/+HAtc/O01FNH/TnPKzwW2WO4Pj7p4+Yv294v
 eLujWd9SZ7/pwcD+55f6Y55X3HwT8umGQffL6c5qjzf28c1izd/xwuxxXOofuf6A4uT5fcpa
 KxvfiZXxbL/y5qKAEktxRqKhFnNRcSIAsgUJmicEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK7LVvk0g1vnhS1+rPrCanFs3Ud2
 i6mTNrNbvN3byW7x+NBrJgdWjz2nZzF77Jx1l93j1YFV7B5n7+xg9Nj4bgdTAGsUl01Kak5m
 WWqRvl0CV8aJtftZC37wVFz8O5WxgfEkVxcjB4eEgInEtT32XYxcHEIC2xklei83sXUxcgLF
 pSQ+P53KBlEjLHH4cDFEzXNGiacdO1lAatgE9CT+L1rIDGKLCHhLXFzcCNbLLFAhsfDIATBb
 SGACo8S6JeYgNqeAvcSkPQsYQWYKCwRLLD8tBBJmEVCVONTazA5i8wpYSiza+YMFwhaUODnz
 CQvESG2JpzefQtnyEtvfzmGGOFNB4ufTZawQJ1hJNCxrgKoRkZjd2cY8gVF4FpJRs5CMmoVk
 1CwkLQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBMeLVtAOxmXr/+odYmTiYDzEKMHB
 rCTC2yIsmybEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXA
 JLVihpOA5YHzBnaZGVcfuS145P3x5Sw/MVVeYaeKvYYPnkVnOb+pzmC4ou0m+N/654MjsQdk
 /PLu6zZe2/txdaX2hP6PZb+fPD62UDmb+f75vVlh35bOm/KiImPtzMtnv87w5hLafdGjtKTu
 UO92/b9/JkRaBJbM/ty+7MWh7adeWDxZu3rXobLFO6/XT7gWnPjtxpJvrzvWe88/tyl8bsGm
 nXcfHd5e5M+0xaD6q5VDciP7OkH14nfvZaYtsb74Zga/8Kf/2YXrN12WV7h7677stzkVhj1O
 r9eWXNJ0+XygZdl+lstlLtPsZMW1fwn3dNz7wGxix+exJcltcen1B60FJz75Pdxavb7rZW9W
 1nUDJZbijERDLeai4kQAWZat6gYDAAA=
X-CMS-MailID: 20240417114052epcas1p4c09549fcfdbd59d57ac411e151a518de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240416073148epcas1p23ad0d7f46660f71578f353a35179790b
References: <CGME20240416073148epcas1p23ad0d7f46660f71578f353a35179790b@epcas1p2.samsung.com>
 <20240416073131.8527-1-seashell11234455@gmail.com>
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
> From: Kongyang Liu <seashell11234455@gmail.com>
> Sent: Tuesday, April 16, 2024 4:31 PM
> To: u-boot@lists.denx.de
> Cc: Jaehoon Chung <jh80.chung@samsung.com>; Leo Yu-Chi Liang <ycliang@andestech.com>; Peng Fan
> <peng.fan@nxp.com>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] mmc: cv1800b: Add transmit tap delay config to fix write error
> 
> Currently, only the receive delay is configured while the transmit delay
> is not set, which may result in errors when writing to the file. This issue
> can be resolved by setting PHY_TX_SRC_INVERT to SDHCI_PHY_TX_RX_DLY.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/cv1800b_sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> index 2275c53777..a50f4cff0d 100644
> --- a/drivers/mmc/cv1800b_sdhci.c
> +++ b/drivers/mmc/cv1800b_sdhci.c
> @@ -12,6 +12,8 @@
>  #define MMC_MAX_CLOCK        375000000
>  #define TUNE_MAX_PHCODE      128
> 
> +#define PHY_TX_SRC_INVERT  BIT(8)
> +
>  struct cv1800b_sdhci_plat {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
> @@ -19,7 +21,7 @@ struct cv1800b_sdhci_plat {
> 
>  static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
>  {
> -	sdhci_writel(host, tap << 16, SDHCI_PHY_TX_RX_DLY);
> +	sdhci_writel(host, PHY_TX_SRC_INVERT | tap << 16, SDHCI_PHY_TX_RX_DLY);
>  }
> 
>  static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
> --
> 2.41.0


