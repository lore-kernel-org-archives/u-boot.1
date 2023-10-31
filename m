Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C08C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 127128751F;
	Tue, 31 Oct 2023 06:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="n5F3c+Oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F23A87535; Tue, 31 Oct 2023 06:02:02 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6690C8709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031050153epoutp027722b0f3b0f635459ba8ca27e3f4f7ee~TGJUqXIQ71928519285epoutp02-
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:01:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031050153epoutp027722b0f3b0f635459ba8ca27e3f4f7ee~TGJUqXIQ71928519285epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728513;
 bh=xp49M/p13Tfdff4Yuu4egs6NHRL7itl7x92hKgAcSTQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=n5F3c+OcpHCMhhmS1+Kkr4342uG4MYyr+gie0pcQBzoaVMTHN2H1vz+c2TlM+2qIS
 Yi9O5enDF0zqSpOn+MgBIDr5WJBQBBfGcxGLFFAJQuqWia5kgJU2V+vT05fY/MMDxf
 8ltshDai9kHOqEkQieOyilw4NEKwOFAKT8YSvIJc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231031050153epcas1p31be5e5937cf4a2a55990f4e46df60280~TGJUcbVVX2431624316epcas1p3C;
 Tue, 31 Oct 2023 05:01:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKJ0019L4z4x9QC; Tue, 31 Oct
 2023 05:01:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 E0.CA.10211.04A80456; Tue, 31 Oct 2023 14:01:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031050151epcas1p3ba08b05031441a86c6cd02eebd6e9b84~TGJTN8t0h1677316773epcas1p3M;
 Tue, 31 Oct 2023 05:01:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031050151epsmtrp1e42fae5b8ae1e106333d5e9550fca3dd~TGJTNMYAB2336823368epsmtrp1h;
 Tue, 31 Oct 2023 05:01:51 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-7a-65408a40a847
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AF.58.08817.F3A80456; Tue, 31 Oct 2023 14:01:51 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050151epsmtip13b9f1ea5e3fab1008fe370df93f39c57~TGJSv91Wz0892608926epsmtip1H;
 Tue, 31 Oct 2023 05:01:51 +0000 (GMT)
Message-ID: <2f24cef3-d9fd-4f8e-b419-db1e13ea0ebe@samsung.com>
Date: Tue, 31 Oct 2023 14:01:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: Add quirk to disable PWREN for dw_mmc
To: David Hewitt <davidmhewitt@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Peng Fan
 <peng.fan@nxp.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230710130030.69085-1-davidmhewitt@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmga5Dl0OqwbcVbBa/HzWxWGyb/pPN
 4seqL6wW3SurLb5t2cZo8XZvJ7sDm8fshossHjtn3WX3OHtnB6PHxnc7mDz+ztoPFLv9kCmA
 LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoDCWF
 ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
 dsbhdT2sBc+EKj49fMTWwLiWv4uRk0NCwERi5cnXjF2MXBxCAjsYJaY9vsQE4XxilJjw+TEz
 SJWQwDdGiburFLsYOcA6lr3lhqjZyyjRMPUfC0TNe0aJeQ1uIDavgJ1E/+pv7CA2i4CqxKWm
 f8wQcUGJkzOfgNWLCshL3L81A6xGWMBN4mzbLTBbRMBe4smFd2BHMAtMZ5T4vuAFK0iCWUBc
 4taT+UwgNpuAjsT2b8fBbE4BG4kT7c/YIWrkJba/ncMM0iwhMJFD4u3uVnaIP10kNh38ywph
 C0u8Or4FKi4l8bK/jR2ioZlRYumSg6wQTg+jxL+G62wQVcYS+5dOZgL5n1lAU2L9Ln2IsKLE
 zt9zGSE280m8+9rDCgkiXomONiGIEhWJS69fMsHsuvvkP9QNHhInfu9lnMCoOAspYGYh+XMW
 kn9mISxewMiyilEstaA4Nz212LDABB7byfm5mxjBSVTLYgfj3Lcf9A4xMnEwHmKU4GBWEuE9
 bOqQKsSbklhZlVqUH19UmpNafIjRFBg9E5mlRJPzgWk8ryTe0MTSwMTMyNjEwtDMUEmc99ir
 3hQhgfTEktTs1NSC1CKYPiYOTqkGpv7ND6ZcP/jTc+6+VP0tjb7iYUYnlp09LR34cd5/B4Fm
 uWSBpmPXPwn9q7la42KmvsJ4y3WOrHZF7U971XMdTU2lWoz3bT0vemqrkLn+ndv7Mv8G950S
 3/7p7XLpjORonSfi9zSO7O2O7c+5Ei7A90fkwIqZH6KfvfZ/HO3DdoF7M4PYKs+yTwvyala9
 qzS/oRKnepptQub/E3tUIwTXrDgcvehSYJOJUtNTz59np5iey5v0X+g222sp9mP+8ZvrWeL3
 7+39uGHBdLu5c/Lehn5M4ciMf1ltyMeypfBQqPTdN9XXZy6slUzqPMNSv2vjz/sF3/e0yxjZ
 3z8R/GilQvNyS7PLLdEPsoXqXOtbrZVYijMSDbWYi4oTAUOjXmErBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK59l0OqQc90XYvfj5pYLLZN/8lm
 8WPVF1aL7pXVFt+2bGO0eLu3k92BzWN2w0UWj52z7rJ7nL2zg9Fj47sdTB5/Z+0Hit1+yBTA
 FsVlk5Kak1mWWqRvl8CVcXhdD2vBM6GKTw8fsTUwruXvYuTgkBAwkVj2lruLkYtDSGA3o8Tn
 LddZuhg5geJSEp+fTmWDqBGWOHy4GKLmLaPE9vs32UBqeAXsJPpXf2MHsVkEVCUuNf1jhogL
 Spyc+QRsjqiAvMT9WzPAaoQF3CTOtt0Cs0UE7CWeXHjHBDKUWWA6o8TU9UuYQBJCAtYSH6ad
 YAWxmQXEJW49mQ8WZxPQkdj+7TiYzSlgI3Gi/Rk7yHHMAuoS6+cJQZTLS2x/O4d5AqPQLCRn
 zEIyaRZCxywkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHjJbWDsY9qz7o
 HWJk4mA8xCjBwawkwnvY1CFViDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2amp
 BalFMFkmDk6pBqYEhxj3ExZlvlxhgbEmU1+ul9H49+HFr1PKsxtuhbnIbaqOF7k02/939dQl
 fdqzdAQnsp9aszX+Y/Kkl5tum2xKT+vc6q7k+ItFwOuaQnOqgA63zYb96zf8eM+6lr/Cz4vp
 94RZWYH/ij6c+a4vFDvjSxf732r/rRk7Hl/RNhWSm2HqwPVGR9vXfEeT9P+8v0lViaczejcK
 xJ9+uOmL95cnlafzvKqzN4X88BQ7MjeSpfSMX+Acn8VNy4UnuvTnBkVJF091lt59983hiCPb
 Lu4/9oun+cCuYv3C/YaNP4VsMhk6dx3Z/lk9ePXdjkCvhpVzcy9evX7C6umHyeWZwmwFMUqR
 27983MHl9U901QMlluKMREMt5qLiRAAtqTJMBwMAAA==
X-CMS-MailID: 20231031050151epcas1p3ba08b05031441a86c6cd02eebd6e9b84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050151epcas1p3ba08b05031441a86c6cd02eebd6e9b84
References: <20230710130030.69085-1-davidmhewitt@gmail.com>
 <CGME20231031050151epcas1p3ba08b05031441a86c6cd02eebd6e9b84@epcas1p3.samsung.com>
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

On 7/10/23 22:00, David Hewitt wrote:
> This is required for correct booting of the PINE64 PineTab2. If
> PWREN is pulled high on this device, the SD card cannot be detected.
> 
> This is required in other PINE64 devices (e.g. Quartz64 Model A) too.
> 
> See commit ba33172a36f298641f51a5e6b855c3e89e3f5d3e in
> https://github.com/CounterPillow/u-boot-quartz64
> 
> Signed-off-by: David Hewitt <davidmhewitt@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Changes for v2:
> - Removed an unrelated change
> 
>  drivers/mmc/dw_mmc.c          | 3 ++-
>  drivers/mmc/rockchip_dw_mmc.c | 3 +++
>  include/dwmmc.h               | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 5085a3b491..cb1d99132f 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -530,7 +530,8 @@ static int dwmci_init(struct mmc *mmc)
>  	if (host->board_init)
>  		host->board_init(host);
>  
> -	dwmci_writel(host, DWMCI_PWREN, 1);
> +	if (!(host->quirks & DWMCI_QUIRK_DISABLE_PWREN))
> +		dwmci_writel(host, DWMCI_PWREN, 1);
>  
>  	if (!dwmci_wait_reset(host, DWMCI_RESET_ALL)) {
>  		debug("%s[%d] Fail-reset!!\n", __func__, __LINE__);
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 72c820ee63..af6ac59a46 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -78,6 +78,9 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
>  	else
>  		host->dev_index = 1;
>  
> +	if (dev_read_bool(dev, "rockchip,disable-pwren-quirk"))
> +		host->quirks |= DWMCI_QUIRK_DISABLE_PWREN;
> +
>  	priv->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
>  
>  	if (priv->fifo_depth < 0)
> diff --git a/include/dwmmc.h b/include/dwmmc.h
> index 136a95b8cd..98aebb46f1 100644
> --- a/include/dwmmc.h
> +++ b/include/dwmmc.h
> @@ -141,6 +141,7 @@
>  
>  /* quirks */
>  #define DWMCI_QUIRK_DISABLE_SMU		(1 << 0)
> +#define DWMCI_QUIRK_DISABLE_PWREN	(1 << 1)
>  
>  /**
>   * struct dwmci_host - Information about a designware MMC host

