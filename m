Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84632E64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE91896ED;
	Thu, 21 Nov 2024 23:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WUKuSsJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D678B89776; Thu, 21 Nov 2024 23:38:31 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADE6896D4
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241121223824epoutp0387bc1dfd59089daadacf640635aba3e8~KHNRLc0T82046220462epoutp03t
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:38:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241121223824epoutp0387bc1dfd59089daadacf640635aba3e8~KHNRLc0T82046220462epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1732228704;
 bh=3qLVJh0w0umtX5axOHpjRWlOKxOKVwzKn+4A3C/twek=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WUKuSsJtzG3dhdMHb/A2td0m2YK2xBBw0ieLCevaO/C8zoK3tIYNblJoT7cWHqTCt
 0/SE9TFBgYHGQ3yyHs30TAE83KNQnIZOFbS1Xwirk6Rr2cAaITehTdQzh3putRI2fi
 JjsS5KleCi6PcopI8Al+bDkK/D35uhqyZqOkrkgI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241121223824epcas1p41c1d40575ce4fbecfe5b9293fa5459a1~KHNQespOx0083700837epcas1p4e;
 Thu, 21 Nov 2024 22:38:24 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XvY6R1Jgkz4x9Pp; Thu, 21 Nov
 2024 22:38:23 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.10.41722.F56BF376; Fri, 22 Nov 2024 07:38:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241121223821epcas1p4da43f25dd75dc7c5d57874378406e5f8~KHNOglGsF1467814678epcas1p4Q;
 Thu, 21 Nov 2024 22:38:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241121223821epsmtrp260518811fdc9f37ada8e1c8198bc37a5~KHNOf2zsn0500705007epsmtrp2S;
 Thu, 21 Nov 2024 22:38:21 +0000 (GMT)
X-AuditID: b6c32a33-11bfb7000001a2fa-3b-673fb65f0a2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C3.DC.18937.D56BF376; Fri, 22 Nov 2024 07:38:21 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241121223821epsmtip2ab0093236c14d3fbbc1cf3cf892d9f9f~KHNONoVEL0681206812epsmtip2G;
 Thu, 21 Nov 2024 22:38:21 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Heiko Stuebner'" <heiko@sntech.de>, <sjg@chromium.org>,
 <philipp.tomsich@vrull.eu>, <kever.yang@rock-chips.com>
Cc: <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <jonas@kwiboo.se>,
 <quentin.schulz@cherry.de>, <detlev.casanova@collabora.com>,
 <u-boot@lists.denx.de>, <sebastian.reichel@collabora.com>
In-Reply-To: <20241121142731.1202209-18-heiko@sntech.de>
Subject: RE: [PATCH 17/20] mmc: rockchip_sdhci: Add support for RK3576
Date: Fri, 22 Nov 2024 07:38:21 +0900
Message-ID: <000401db3c66$11974a60$34c5df20$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJUeDCn5J2CwOuZwyaxWoAdnWczjwKPMoj3AT0SU+OxsXmS0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmnm78Nvt0g1WbWSzu/X/FaPH/0WtW
 i087H7NanHxzlcVi2/SfbBbP311msvix6gurRffKaov1l7exWxz+fJbdYuu9CUwWd1/7WXzb
 so3R4u3eTnYHPo+3T6cwesxuuMjisePuEkaPebNOsHjsnHWX3ePEhEtMHmfv7GD0uH5mO5PH
 xnc7mDz+ztrP4rH92jxmj523HzIF8ERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
 WpgrKeQl5qbaKrn4BOi6ZeYA/aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt
 0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54dnYrS8FqgYq286eZGhgv8nYxcnJICJhI9DU/Zu1i
 5OIQEtjBKPHt+AMWCOcTo8TFvlMIzt+tc1hhWrbPfcgMkdjJKPH5eSMbhPOSUWLL9eNMIFVs
 AnoS/xctZAaxRQTKJSa9OMUEUsQs8J9RYtKi52AJTgELiW3zvjKC2MICbhKHdx8Ca2YRUJXo
 3bCIHcTmFbCU2H2nnRFitYLEz6fLwM5gFhCRmN3ZBrXASWL/3rdgX0gInOCQ+LB/NgtEg4tE
 4/rfULawxKvjW9ghbCmJz+/2skE0NDNKLF1yEKq7h1HiX8N1NogqY4n9SycDncQBtE5TYv0u
 fYjNfBLvvvawgoQlBHglOtqEIKpVJC69fskEM//uk//Q8PKQ+L7hCCKIm/c9ZZ7AKD8LyROz
 EDYsYGRaxSiWWlCcm56abFhgCI/N5PzcTYzgdKxlvIPx8vx/eocYmTgYDzFKcDArifA6KNmn
 C/GmJFZWpRblxxeV5qQWH2I0BQblRGYp0eR8YEbIK4k3NLE0MDEzMjaxMDQzVBLnPXOlLFVI
 ID2xJDU7NbUgtQimj4mDU6qByf/86xv3JrrL9jTdUj3J+093rcSNbwc2vzxvKZ+re1I/MbFk
 R7nxQ6XG2Rl32Lj2c38qnSD4VbQs+vL6Zhf5Wp4uEUuPaT07HrNbe3WUWufqSe6qVJsnFDDX
 IcF4u1/X/Clv3Yq9O6/FLPAw/c8jNvHMMfZ9inN4vXfn+6f/VkqKuSW8L/O72o+6fxeVs7nq
 XzH3dPvPts3z+p2TprIsOU+W+1KQ6P4ve9Zuv/dJuLT4AWvmVotA3bvOQbyrjkYK560rvD6z
 eeHnjwsvS6z65xgqvOSH43rTbOVNe78fyaraVpp3NqdTLCwt1mb3jQ07PDl7DUrjt2v1l4bV
 zOG+EzXJXmP1zfbZPy6EmWoqsRRnJBpqMRcVJwIAMts82VAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvG7sNvt0g50bDS3u/X/FaPH/0WtW
 i087H7NanHxzlcVi2/SfbBbP311msvix6gurRffKaov1l7exWxz+fJbdYuu9CUwWd1/7WXzb
 so3R4u3eTnYHPo+3T6cwesxuuMjisePuEkaPebNOsHjsnHWX3ePEhEtMHmfv7GD0uH5mO5PH
 xnc7mDz+ztrP4rH92jxmj523HzIF8ERx2aSk5mSWpRbp2yVwZTw7u5WlYLVARdv500wNjBd5
 uxg5OSQETCS2z33I3MXIxSEksJ1RYv/B24wQCSmJz0+nsnUxcgDZwhKHDxdD1DxnlOhomcUM
 UsMmoCfxf9FCMFtEoFrix7ynbCBFzALdTBJPn21ghejYwihx4G4f2FROAQuJbfO+gtnCAm4S
 h3cfYgKxWQRUJXo3LGIHsXkFLCV232mHukJB4ufTZawgNrOAiMTszjaobU4S+/e+ZZ3AKDAL
 SWoBI+MqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOAY0grawbhs/V+9Q4xMHIyHGCU4mJVE
 eB2U7NOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamJJq
 vz0wKl978HRv8o/HyXayWn/WZ3W2uuvdmW4k37ZGyzxA49CsdbNkMhjy1bQTgm9+2F9UtOOt
 9cWCMMOakk/y699/8ZshHtFfIcS1LGhP8TzxxDijnLtSz8xljD/NLWVK+HKoJqNWYfpm7xa1
 0sMvQhc9aPrXkag0P1VB/cL7MFWx5oVCemxvtr4Jru3rqNy4qTZ2t/+UKRcb/H/ed7Y40WQ9
 +3/sZa9y1zsLl67pO5psJDLFR3h7RePKIw67ylepPblj18DDw76gsnZ9l6FjQ15a2C/hf3fX
 3Zr4pnjOslnmp9Kqrnhs81a4Xbzt+yythboVf2fyxr1esrJOp5SL7a/V3vcLMzYasjvbK7EU
 ZyQaajEXFScCAHIxItAQAwAA
X-CMS-MailID: 20241121223821epcas1p4da43f25dd75dc7c5d57874378406e5f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241121143117epcas1p16bfa5e48951ade1050b4958bfd8f24f1
References: <20241121142731.1202209-1-heiko@sntech.de>
 <CGME20241121143117epcas1p16bfa5e48951ade1050b4958bfd8f24f1@epcas1p1.samsung.com>
 <20241121142731.1202209-18-heiko@sntech.de>
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
> From: Heiko Stuebner <heiko@sntech.de>
> Sent: Thursday, November 21, 2024 11:27 PM
> To: sjg@chromium.org; philipp.tomsich@vrull.eu; kever.yang@rock-chips.com
> Cc: heiko@sntech.de; lukma@denx.de; seanga2@gmail.com; peng.fan@nxp.com; jh80.chung@samsung.com;
> joe.hershberger@ni.com; rfried.dev@gmail.com; jonas@kwiboo.se; quentin.schulz@cherry.de;
> detlev.casanova@collabora.com; u-boot@lists.denx.de; sebastian.reichel@collabora.com
> Subject: [PATCH 17/20] mmc: rockchip_sdhci: Add support for RK3576
>
> Add support for RK3576 to the rockchip sdhci driver.
>
> It's pretty similar to its cousins found in the RK3568 and RK3588 and the
> specific hs400-tx-tap number was taken from the vendor-u-boot.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/rockchip_sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index da630b9d97a..9571e7d66c9 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -656,6 +656,14 @@ static const struct sdhci_data rk3568_data = {
>  	.hs400_txclk_tapnum = 0x8,
>  };
>
> +static const struct sdhci_data rk3576_data = {
> +	.set_ios_post = rk3568_sdhci_set_ios_post,
> +	.set_clock = rk3568_sdhci_set_clock,
> +	.config_dll = rk3568_sdhci_config_dll,
> +	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> +	.hs400_txclk_tapnum = 0x7,
> +};
> +
>  static const struct sdhci_data rk3588_data = {
>  	.set_ios_post = rk3568_sdhci_set_ios_post,
>  	.set_clock = rk3568_sdhci_set_clock,
> @@ -673,6 +681,10 @@ static const struct udevice_id sdhci_ids[] = {
>  		.compatible = "rockchip,rk3568-dwcmshc",
>  		.data = (ulong)&rk3568_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3576-dwcmshc",
> +		.data = (ulong)&rk3576_data,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = (ulong)&rk3588_data,
> --
> 2.45.2



