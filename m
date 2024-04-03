Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB1C6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE6B88141;
	Wed,  3 Apr 2024 02:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="RVaLL6Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640A2881A7; Wed,  3 Apr 2024 02:43:53 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F572879F4
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240403004349epoutp0429993d33577b1a0a5f7669e081c2b9d9~CnnPwmjx11101511015epoutp04k
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240403004349epoutp0429993d33577b1a0a5f7669e081c2b9d9~CnnPwmjx11101511015epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712105029;
 bh=8Ifq6pO4pzUDe6f5Z//HQyrzuIiEkHAN7HiEuvYma8A=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=RVaLL6BcV6Zo2joGuG6O/pK8Lnsew9QO+ijTq2u9SqbnIlsI4zHQW9oqnDGu3pzek
 NPGz3ofs3UBmLIG28LiA4R97ewk+iIHEMKYkjajxljVW2TE87pzY5rY1RILO/1b6mg
 jAPqQLiiKrR7Ctd3sjyAde1VtAerwGIAVZAdzf4o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240403004348epcas1p2135ba02a7e2278140b402340b5564e1e~CnnPdh89J1146311463epcas1p2k;
 Wed,  3 Apr 2024 00:43:48 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.145]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8Qwh2Hpwz4x9Px; Wed,  3 Apr
 2024 00:43:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 24.88.08627.146AC066; Wed,  3 Apr 2024 09:43:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5~CnnMa6v8J2794527945epcas1p3E;
 Wed,  3 Apr 2024 00:43:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403004345epsmtrp295c578b6c4a12ce3f7e955d456a4d0da~CnnMaShqK2916329163epsmtrp2E;
 Wed,  3 Apr 2024 00:43:45 +0000 (GMT)
X-AuditID: b6c32a33-d59fa700000021b3-5e-660ca6414e70
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3B.CD.07541.146AC066; Wed,  3 Apr 2024 09:43:45 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403004345epsmtip1eb8a2304bd135e41ceb9f67ae8c73f76~CnnMEpPRy0709907099epsmtip1T;
 Wed,  3 Apr 2024 00:43:45 +0000 (GMT)
Message-ID: <56685eac-34ff-4ad9-9128-1ba83a9a48c6@samsung.com>
Date: Wed, 3 Apr 2024 09:43:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: hi6220_dw_mmc: add fifoth_val to private
 data and set it in .probe
To: forbidden405@outlook.com, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240201-mmc-v2-3-9f09dc1335fd@outlook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmvq7jMp40g6OvjCz+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf0tf1nLDgmUNG5o5+1gXEZbxcjJ4eEgIlE75Vu
 pi5GLg4hgR2MEoveTmeEcD4xStz+9ZkVwvnGKNHz8yYrTMvb5d+ZIRJ7GSVW7WiDct4zSvxZ
 /pSti5GDg1fATuLLPzeQBhYBFYmb7edYQGxeAUGJkzOfgNmiAvIS92/NYAexhQVSJRa+nM8M
 YosIWErMWn6aCcRmFpCQWHLoPiuELS5x68l8sDibgI7E9m/HwWxOoPoZhxZA1ctLbH87B+we
 CYF77BLHZ7UyQ1ztInHp2j42CFtY4tXxLewQtpTE53d72SAamhklli45yArh9DBK/Gu4DtVh
 LLF/6WQmkM+YBTQl1u/Sh9jGJ/Huaw8rSFhCgFeio00IolpF4tLrl0ww8+8++Q8NOQ+Jhi+3
 WCCBtZtR4tfOD0wTGBVmIQXMLCSPzkLy0CyEzQsYWVYxiqUWFOempyYbFhjC4zs5P3cTIzgd
 ahnvYLw8/5/eIUYmDsZDjBIczEoivD+9OdOEeFMSK6tSi/Lji0pzUosPMZoCo2cis5Rocj4w
 IeeVxBuaWBqYmBkZm1gYmhkqifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cCUt/VOYGY442GW
 D0vm39j9pWXFEZ7jIgahj5ieOR42+MOhcOrahTzJZfOFy+RYJvFvPMrNo12Q9qk9elFpHuO2
 E2V9VzsKWD/JrLaZo/bjyTqzvueZxqFZWky9P2e/nNq9VP+PAuf972K8ed1q11pPPgyWmnEl
 jCNoF4fI5EYrn4cf/dIkPknmGkb1Bj84kyuycomc9ip54Qc7J5VNcA2L4VF3rrm5pEj6ZEWA
 qEJPxLw7K/fyaYumc6rtPlCjlj8jb09I6q8JL6vKHkgzSpvXJ3saJ7k5aMg/MV64qKJ02eft
 jjPKbRS/rpvasrsu1dnReMeUKuMaI0b5lztfJKbanSv05nN5/dw/e27EVyWW4oxEQy3mouJE
 AEOutf8QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnK7jMp40g107pSz+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdx2aSk5mSWpRbp2yVwZfS1/WcsOCZQ0bmjn7WB
 cRlvFyMnh4SAicTb5d+Zuxi5OIQEdjNKnHv9nwUiISXx+elUti5GDiBbWOLw4WKImreMElMa
 N7KAxHkF7CS+/HMDKWcRUJG42X4OrJVXQFDi5MwnYLaogLzE/Vsz2EFsYYFUiebjS1lBbBEB
 S4lZy08zgdjMAhISSw7dB4sLCaRLXOg6xQwRF5e49WQ+WA2bgI7E9m/HwWxOoN4ZhxYwgZzA
 LKAusX6eEES5vMT2t3OYJzAKzUJyxSwkk2YhdMxC0rGAkWUVo2RqQXFuem6yYYFhXmq5XnFi
 bnFpXrpecn7uJkZw0Gtp7GC8N/+f3iFGJg7GQ4wSHMxKIrw/vTnThHhTEiurUovy44tKc1KL
 DzFKc7AoifMazpidAvROYklqdmpqQWoRTJaJg1OqgWmh0TVDE0mnBd9aYs582lF/0a9Ci/3l
 hlcJ34KWOkiYHXuYnLHMrvh4rhFjsszNU3PmCSp67+eofNw982J9W/YjO8/3xWdnHHxS9apo
 ivayoqpfCWpx+z2nxx40udgjP10qpVgl/gGjdo2zt/oyOcEpK8tvON5stFTlz9p2Lt1Lq2Dm
 +b1esswFR44Wpe8Iedd7tkLPn/V6xGWuTubLey8ET/YorSh+y2RrYMCU+z/k5p03Vh0/TrOs
 +xi4yZLraMtUGa2K9ac5i1+kbUzs7l3z+3yYNtMfP3YHxnds+RGNEQsPtAVpTuVgqNvSIclz
 28ly07eJRa9Uu1TtJZdM/2O17wr7usKLlsqv6/bLK7EUZyQaajEXFScCAFGUMfzpAgAA
X-CMS-MailID: 20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-3-9f09dc1335fd@outlook.com>
 <CGME20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5@epcas1p3.samsung.com>
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

Hi

On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The value defaults to 0 and is ignored by dw_mmc code, so the other
> users are not affected.
> 
> Setting this explicitly fixes some weird reading error found on Hi3798MV200.
> 
> Fixes: 8a5dc8140e62 ("mmc: hi6220_dw_mmc: add compatible for HC2910 support")
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/hi6220_dw_mmc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> index a4b8072976..dc0210402b 100644
> --- a/drivers/mmc/hi6220_dw_mmc.c
> +++ b/drivers/mmc/hi6220_dw_mmc.c
> @@ -37,6 +37,7 @@ struct hi6220_dwmmc_priv_data {
>  struct hisi_mmc_data {
>  	unsigned int clock;
>  	bool use_fifo;
> +	u32 fifoth_val;
>  };
>  
>  static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
> @@ -125,6 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
>  	host->mmc = &plat->mmc;
>  
>  	host->fifo_mode = mmc_data->use_fifo;
> +	host->fifoth_val = mmc_data->fifoth_val;
>  	host->mmc->priv = &priv->host;
>  	upriv->mmc = host->mmc;
>  	host->mmc->dev = dev;
> @@ -154,13 +156,20 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
>  	.use_fifo = false,
>  };
>  
> +static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
> +	.clock = 50000000,
> +	.use_fifo = false,
> +	// FIFO depth is 256
Removed unnecessary comment.

Best Regards,
Jaehoon Chung

> +	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
> +};
> +
>  static const struct udevice_id hi6220_dwmmc_ids[] = {
>  	{ .compatible = "hisilicon,hi6220-dw-mshc",
>  	  .data = (ulong)&hi6220_mmc_data },
>  	{ .compatible = "hisilicon,hi3798cv200-dw-mshc",
>  	  .data = (ulong)&hi6220_mmc_data },
>  	{ .compatible = "hisilicon,hi3798mv200-dw-mshc",
> -	  .data = (ulong)&hi6220_mmc_data },
> +	  .data = (ulong)&hi3798mv2x_mmc_data },
>  	{ .compatible = "hisilicon,hi3660-dw-mshc",
>  	  .data = (ulong)&hi3660_mmc_data },
>  	{ }

