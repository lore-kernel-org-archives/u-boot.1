Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48017C4725D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 01:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6706878FF;
	Thu, 18 Jan 2024 02:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="HqcZe+co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40F487A18; Thu, 18 Jan 2024 02:21:19 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9D087887
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 02:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240118012103epoutp02758ee3785ce43336b04d655d6f6a5529~rTGELVBJ51609616096epoutp02a
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:21:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240118012103epoutp02758ee3785ce43336b04d655d6f6a5529~rTGELVBJ51609616096epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1705540863;
 bh=UOUUi4JBQB4eWW9Obrh0Z8nHlhiI4WJpA5B+lCciXNQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=HqcZe+co3xk1MJ5I2Mq7CncmK0PNAsRdS3geKOfDYERYHzZ4UgjjHPgfE6i0juxBv
 Zl1XqNKFo4woYyl53wvDjYkmlID2/NYj+IYXHI0Df4kIfi7h1qewf1afljFPQf933d
 YEPbDf6fx785dXKYx4hXyOsE/jGjYhRkUO9L1x9o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240118012103epcas1p4bbf62131a0aa543145554de0a441f665~rTGD5PQQw0255702557epcas1p4S;
 Thu, 18 Jan 2024 01:21:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.231]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4TFlLk2Qybz4x9Px; Thu, 18 Jan
 2024 01:21:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 A6.D6.10025.EFC78A56; Thu, 18 Jan 2024 10:21:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240118012101epcas1p39d0acb470cccf53b64549ddd6e3ae636~rTGCsjRA72853728537epcas1p37;
 Thu, 18 Jan 2024 01:21:01 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240118012101epsmtrp2d5700c655f903fd93c589404804bddcc~rTGCqv4ce1202412024epsmtrp2q;
 Thu, 18 Jan 2024 01:21:01 +0000 (GMT)
X-AuditID: b6c32a39-24b00a8000002729-98-65a87cfea8ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.FA.07368.DFC78A56; Thu, 18 Jan 2024 10:21:01 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240118012101epsmtip1807454a52c5de46da8b71224e5a53b04~rTGCN5Gt51380813808epsmtip1j;
 Thu, 18 Jan 2024 01:21:01 +0000 (GMT)
Message-ID: <338a9a58-4742-42a9-babb-1e32f7056970@samsung.com>
Date: Thu, 18 Jan 2024 10:21:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
To: Eugen Hristev <eugen.hristev@collabora.com>, peng.fan@nxp.com,
 u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, Ziyuan Xu <xzy.xu@rock-chips.com>, Jason Zhu
 <jason.zhu@rock-chips.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230619103347.278004-1-eugen.hristev@collabora.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX/dfzYpUg6b5Qhati24zWuyfN4XF
 Ytv0n2wWP1Z9YbV4u7eT3WLJ/FAHNo8dd5cwepy9s4PRY+O7HUwef2ftZwlgicq2yUhNTEkt
 UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
 VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzmiaep6p4KtA
 xdy+/8wNjAd5uxg5OSQETCTmTprJ3sXIxSEksINR4vz5LUwQzidGiadP3jFCON8YJQ62rGGG
 aWme38sKkdjLKNH+7Q5Uy3tGiSW31gM5HBy8AnYSB7fagTSwCKhKnFjZxg5i8woISpyc+YQF
 xBYVkJe4f2sGWFxYwF9i5/orTCC2iECkxO25k1lBxjALZEjsbZAFCTMLiEvcejIfrIRNQEdi
 +7fjYDangJPEvreNbBA18hLb385hBjlHQqCRQ+L7noVgcyQEXCSWf8+GuF9Y4tXxLewQtpTE
 53d72SDqmxklli45yArh9DBK/Gu4zgZRZSyxf+lkJoiDNCXW79KHWMYn8e5rD9R8XomONiGI
 ahWJS69fMsHMv/vkPyuE7SHx5OkUFkhQTWWU2PRzDssERoVZSMEyC8mfs5D8Mwth8wJGllWM
 YqkFxbnpqcWGBabw2E7Oz93ECE6YWpY7GKe//aB3iJGJg/EQowQHs5IIr7/BslQh3pTEyqrU
 ovz4otKc1OJDjKbAyJnILCWanA9M2Xkl8YYmlgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqem
 FqQWwfQxcXBKNTBNiBCMqFL9/MNfWJlRnUfo//4zfodOr334d2161tTKS1e3sORqRJef36x6
 9oT6dpHIz9PMQxr3teX/VN1z8MOismKvy002924zHf8mIZHnZN+lavjr1Yer3yYc1FpS+PAY
 l/8/nXNRjCuPXF3aw1p9zv6idCv7f/G52/b7BsZq7SnPtJ3P9ORDu6xm3KSm2zf5QmYKbroW
 uVdEaNY3nsN6/aKbz87K8/n9ouPkhTu3W+7Om/fZVd8ge1PelyCWNLalkdcW3PsY0WDIp84l
 K3E2mPVPbuXF58EXshsOfvP8staqT1DETuJ3pEZ1RJ7J6/fe/We+TUyKWhO2bFZ99yvlCtOX
 T0omCe3gi3qUmOqgxFKckWioxVxUnAgAZ+xnJyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO7fmhWpBhdXmFm0LrrNaLF/3hQW
 i23Tf7JZ/Fj1hdXi7d5Odosl80Md2Dx23F3C6HH2zg5Gj43vdjB5/J21nyWAJYrLJiU1J7Ms
 tUjfLoEro2nqeaaCrwIVc/v+MzcwHuTtYuTkkBAwkWie38vaxcjFISSwm1Hi89mZrBAJKYnP
 T6eydTFyANnCEocPF4OEhQTeMkqcvVsHEuYVsJM4uNUOJMwioCpxYmUbO4jNKyAocXLmExYQ
 W1RAXuL+rRlgcWEBX4mGRb/BposIREocvf6SDcRmFsiQ+DD/GjPEeEeJKRM6mSHi4hK3nsxn
 ArHZBHQktn87DmZzCjhJ7HvbCHYZs4C6xPp5QhDl8hLb385hnsAoNAvJFbOQTJqF0DELSccC
 RpZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBkaGlsYPx3vx/eocYmTgYDzFKcDAr
 ifD6GyxLFeJNSaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBAemJJanZqakFqEUyWiYNTqoHJ
 /W+eyKKjzA/jUmQ3VW1YNjl46v4svstiMgriDKVTU1acCPsyRWX+nnVXHZPs2tZYp2vdVcw3
 mZJ8vz/tQd7Z7hueOtGvr2csXmi4KeVz5aqmTdb3deWOqezS3xh52vPz5YOlGwzkvkxtmS9r
 ecqga/G6vtnZFiv22TgELH042/L5uT82Hcvqcjglg6IOTzig2dj8Y7fTKp/lf8/y5ry/sUJI
 0+nR69nPP5zNVuua+2Gvq9iBB2tWb6uYF6v/QGnehEOLY3+rL+HONubl1Nq+O1442cXu2KmT
 XB0nLu2OsdXSmCdrllxt56BjUPlg2S17vTjTRTNmb/4R9PmN3XxzE6latTVdf4LeB1vIXn3/
 XomlOCPRUIu5qDgRADh+zgT7AgAA
X-CMS-MailID: 20240118012101epcas1p39d0acb470cccf53b64549ddd6e3ae636
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240118012101epcas1p39d0acb470cccf53b64549ddd6e3ae636
References: <20230619103347.278004-1-eugen.hristev@collabora.com>
 <CGME20240118012101epcas1p39d0acb470cccf53b64549ddd6e3ae636@epcas1p3.samsung.com>
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

On 6/19/23 19:33, Eugen Hristev wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> Per dw_mmc databook, it's recommended to reset the host controller if
> some data-related error occurred.
> Implement a reset mechanism.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Co-developed-by: Jason Zhu <jason.zhu@rock-chips.com>
> Signed-off-by: Jason Zhu <jason.zhu@rock-chips.com>
> [eugen.hristev@collabora.com: modified a bit the variables initialization]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/dw_mmc.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 5085a3b491da..d6cad998b0cd 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -138,7 +138,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
>  {
>  	struct mmc *mmc = host->mmc;
>  	int ret = 0;
> -	u32 timeout, mask, size, i, len = 0;
> +	u32 timeout, reset_timeout = 100, status, ctrl, mask, size, i, len = 0;
>  	u32 *buf = NULL;
>  	ulong start = get_timer(0);
>  	u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
> @@ -159,6 +159,24 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
>  		/* Error during data transfer. */
>  		if (mask & (DWMCI_DATA_ERR | DWMCI_DATA_TOUT)) {
>  			debug("%s: DATA ERROR!\n", __func__);
> +
> +			dwmci_wait_reset(host, DWMCI_RESET_ALL);
> +			dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
> +				     DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
> +
> +			do {
> +				status = dwmci_readl(host, DWMCI_CMD);
> +				if (!reset_timeout--)
> +					break;
> +				udelay(100);
> +			} while (status & DWMCI_CMD_START);
> +
> +			if (!host->fifo_mode) {
> +				ctrl = dwmci_readl(host, DWMCI_BMOD);
> +				ctrl |= DWMCI_BMOD_IDMAC_RESET;
> +				dwmci_writel(host, DWMCI_BMOD, ctrl);
> +			}
> +
>  			ret = -EINVAL;
>  			break;
>  		}

