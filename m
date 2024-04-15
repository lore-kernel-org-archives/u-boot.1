Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A0CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7528488168;
	Mon, 15 Apr 2024 09:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="SRphIjtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7862C88179; Mon, 15 Apr 2024 09:07:29 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002298813C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240415070722epoutp01d57bdfe25f316da43c53fb010542d285~GYlj6KiTd2907329073epoutp01Q
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:07:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240415070722epoutp01d57bdfe25f316da43c53fb010542d285~GYlj6KiTd2907329073epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713164842;
 bh=FSK172RotMMXRuIDhHInc8kStHSTdYtYeugQcCRNyAk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=SRphIjtFmxb1/5vLdX8uzhv0zYl0c3GjLDO3oFfuAbdvAr4wMq5gfmUFDiwW4xoSW
 PHnGsYjNwI2WJiUPUI7GEl/inhaA4pH46IMkYEadGXfCJxo8UMYJIo530erz4EYaUz
 sLlIRItYIJITLVrAsKJW2n5kdelzSQkJXVFS9Ky4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240415070722epcas1p1ddbf40f96895ae49f6e7aed7b3fad706~GYljoei2_2598925989epcas1p1J;
 Mon, 15 Apr 2024 07:07:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VHysh6J8kz4x9Pv; Mon, 15 Apr
 2024 07:07:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 DA.4F.09663.822DC166; Mon, 15 Apr 2024 16:07:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240415070720epcas1p45992507acf479c21e31f0a42d64d5af6~GYlhxtobV1443214432epcas1p4H;
 Mon, 15 Apr 2024 07:07:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240415070720epsmtrp2b086031e9b4cfb5479051c0f2688938d~GYlhw4kxf1592115921epsmtrp2P;
 Mon, 15 Apr 2024 07:07:20 +0000 (GMT)
X-AuditID: b6c32a37-557fa700000025bf-a7-661cd228f140
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.EE.08390.822DC166; Mon, 15 Apr 2024 16:07:20 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415070720epsmtip2c5272c89632738fffbd3185c412c5419~GYlhldcIK0865708657epsmtip2j;
 Mon, 15 Apr 2024 07:07:20 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <cmax@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Maximilian Brune'" <maximilian.brune@9elements.com>, "'Peng Fan'"
 <peng.fan@nxp.com>
In-Reply-To: <20240404065839.9351-1-cmax@mailbox.org>
Subject: RE: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
Date: Mon, 15 Apr 2024 16:07:19 +0900
Message-ID: <008801da8f03$8e96c3d0$abc44b70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLPlTIcv4jGDfEyxksLUN1+0irjygEwUx3yAkPn9CevYzq8gA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTV1fjkkyawf3rShaLnr1ltPh5/xyL
 xY9VX1gt3u7tZHdg8bg+zc7j7J0djB47Z+9j8tj4bgdTAEtUtk1GamJKapFCal5yfkpmXrqt
 kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
 Rn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGyqfNzAUnRSsWPLrL2sC4V7CL
 kZNDQsBE4mDvebYuRg4OIYEdjBK3mLsYuYDMT4wSx+Y3sUE43xglFqxaywbTcOH+eaiqvUCJ
 qTOZIJyXjBIdSzrBqtgE9CT+L1rIDGKLANmbD39hBbGZBWIker8tZwSxOQVMJU4tWs4CYgsL
 uEms6X8NZrMIqErsm/od7CReAUuJ3zs4QMK8AoISJ2c+YYEYIy+x/e0cZoiDFCR+Pl3GClIu
 IuAkcfywDUSJiMTszjawOyUEfrJLLD57gRGi3kVi29YvULawxKvjW9ghbCmJz+/2skE0NDNK
 LF1ykBXC6WGU+NdwHep9Y4n9SyczgWxjFtCUWL9LH2Ibn8S7rz1gR0gI8Ep0tAlBVKtIXHr9
 kglm/t0n/1khbA+Jgx1PmCcwKs5C8tosJK/NQvLDLIRlCxhZVjGKpRYU56anFhsWGMPjOjk/
 dxMjODFqme9gnPb2g94hRiYOxkOMEhzMSiK81+Qk04R4UxIrq1KL8uOLSnNSiw8xmgLDeiKz
 lGhyPjA155XEG5pYGpiYGRmbWBiaGSqJ8565UpYqJJCeWJKanZpakFoE08fEwSnVwBTjvbyh
 T3qd56n3X08kyeXnL7FpW3UiVUvLJ9pT9MPFm0YyCv3HQ1pncm2OCC0wlXhZ8ON+zpo/T5KX
 HLrRxm3DZJC9efnnI1u2uDGyG6Z+vtKg31/dcpgz0u3HjcbWRec9+xU+W96bcaXv0E+hKYEf
 RQRf5/tq3/5658HLzJU7veq/1Mnk2VtwGcx8ZJDU/fhH8899DWIseRqvvOS3f+t4JRG3/K+T
 4Np212Rb9cNnOGc2/bgXErOru9+44FHNmvs9bw1ktIOjZ0i4JFxb9fLBWdnYTb6+Nq4Fqy6k
 Bn+/PavvZ01yf+3fbd5ta5J2tqnN6a5Lr77yeDLju7+GzhvbaqYv4/lQ6LZ25YpJP5RYijMS
 DbWYi4oTASOZV/0VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvK7GJZk0g6vPOS0WPXvLaPHz/jkW
 ix+rvrBavN3bye7A4nF9mp3H2Ts7GD12zt7H5LHx3Q6mAJYoLpuU1JzMstQifbsEroyVT5uZ
 C06KVix4dJe1gXGvYBcjJ4eEgInEhfvnmbsYuTiEBHYzSrxq38QKkZCS+Px0KlsXIweQLSxx
 +HAxRM1zRolnp1tZQGrYBPQk/i9ayAxiiwgYSDQsnA4WZxaIkVi7+BUrRMMGRonzay6ygSQ4
 BUwlTi1aDlYkLOAmsab/NZjNIqAqsW/qd7BlvAKWEr93cICEeQUEJU7OfAI1U1vi6c2nULa8
 xPa3c5gh7lSQ+Pl0GStIq4iAk8TxwzYQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ
 1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4BjR0trBuGfVB71DjEwcjIcYJTiYlUR4r8lJ
 pgnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANK1WN/Pi
 66ubbnsleKWG9LT3XD4UGzOhQPvsj6XZUdYeAv22zaInpxTVfLNmff5+8vHLCRGT+Wb9Xf2p
 8qtuodXttZtZGvvctuX3s6hdtp20Nr7Utl1HouWFEnfa/sWzJu668y5tQ/hx9x/CXdquGbNN
 UwSFcp9Zu/9Tif4cW7nEKuKvZvHR10zWarHzbp0pc//+empgmuom2fIVR16XRpzeUSSZdu7w
 f9vFs+1ssr/teNKa53di17QqZ60/Pf8TVz1u7zt2YImSv334jkPvHkhemyDwgH/Sho1zQ7j6
 zx9pPemcVWO01CqO40/aK7d7fDOi3aM99lermKxf0Of9Pq9YdYnHqVInt3mqURfYlFiKMxIN
 tZiLihMBl8qp6QADAAA=
X-CMS-MailID: 20240415070720epcas1p45992507acf479c21e31f0a42d64d5af6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240404065905epcas1p2d9f1dbe95475791a90ab34ab43707538
References: <20240227201857.25814-1-cmax@mailbox.org>
 <CGME20240404065905epcas1p2d9f1dbe95475791a90ab34ab43707538@epcas1p2.samsung.com>
 <20240404065839.9351-1-cmax@mailbox.org>
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
> From: cmax@mailbox.org <cmax@mailbox.org>
> Sent: Thursday, April 4, 2024 3:58 PM
> To: u-boot@lists.denx.de
> Cc: Maximilian Brune <maximilian.brune@9elements.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>
> Subject: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
> 
> From: Maximilian Brune <maximilian.brune@9elements.com>
> 
> Currently fetching files bigger that cause a data transfer greater than
> U16_MAX fails.
> 
> The reason is that the specification defines the datalength register
> as a 16 bit wide register, but in u-boot it is used as if it is an
> 32 bit register. Therefore values greater than U16_MAX cause an
> infinite loop inside u-boot. U-boot expects to get more data from
> interface/hardware then it will ever get and therefore inifintely waits
> for more data that will never come.
> 
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/arm_pl180_mmci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index 5cf5502ed5..cad73ea106 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -231,6 +231,7 @@ static int do_data_transfer(struct mmc *dev,
>  	u32 blksz = 0;
>  	u32 data_ctrl = 0;
>  	u32 data_len = (u32) (data->blocks * data->blocksize);
> +	assert(data_len < U16_MAX); /* should be ensured by arm_pl180_get_b_max */
> 
>  	if (!host->version2) {
>  		blksz = (ffs(data->blocksize) - 1);
> @@ -358,6 +359,14 @@ static int  host_set_ios(struct mmc *dev)
>  	return 0;
>  }
> 
> +static int arm_pl180_get_b_max(struct udevice *dev, void *dst, lbaint_t blkcnt)
> +{
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> +	struct mmc *mmc = upriv->mmc;
> +
> +	return U16_MAX / mmc->read_bl_len;
> +}
> +
>  #ifndef CONFIG_DM_MMC
>  /* MMC uses open drain drivers in the enumeration phase */
>  static int mmc_host_reset(struct mmc *dev)
> @@ -373,6 +382,7 @@ static const struct mmc_ops arm_pl180_mmci_ops = {
>  	.send_cmd = host_request,
>  	.set_ios = host_set_ios,
>  	.init = mmc_host_reset,
> +	.get_b_max = arm_pl180_get_b_max,
>  };
> 
>  /*
> @@ -531,6 +541,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops = {
>  	.send_cmd = dm_host_request,
>  	.set_ios = dm_host_set_ios,
>  	.get_cd = dm_mmc_getcd,
> +	.get_b_max = arm_pl180_get_b_max,
>  };
> 
>  static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
> --
> 2.44.0


