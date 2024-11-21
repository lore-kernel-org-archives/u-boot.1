Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF06E64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9335896C5;
	Thu, 21 Nov 2024 23:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="EP3rkZN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF587896C5; Thu, 21 Nov 2024 23:38:15 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2D1896C2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241121223808epoutp01eb061e64ec8b90c1e1779b2abc16193f~KHNBwRDpy2049720497epoutp01e
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:38:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241121223808epoutp01eb061e64ec8b90c1e1779b2abc16193f~KHNBwRDpy2049720497epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1732228688;
 bh=j/N9OqhypVL0GOhKSJprHqqGW3EVJI6YqRcJcbd9lqY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=EP3rkZN2vh++RpwPZguia91NU9IUqEUijFSNHrQmWNHks6+m1z7JkfO0IMENDgZ7O
 VFDyuI5YBGtrKA5ppRLOX+uReposy4xVmpNnb2Vedtn73mCFqfsD3EoWes79tOYIsA
 aB6kL8HZWjdahrQvn/BoYyYiCpW7FB2S5f6WuuQQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241121223807epcas1p2b85895b3f7d3f6880ab885cc6d786520~KHNA4L61h1655716557epcas1p2G;
 Thu, 21 Nov 2024 22:38:07 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.144]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4XvY662lRGz4x9Pq; Thu, 21 Nov
 2024 22:38:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.99.16307.E46BF376; Fri, 22 Nov 2024 07:38:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241121223805epcas1p4c6b32558267ab38842e1665aa13e7916~KHM-iEPYU0879308793epcas1p4o;
 Thu, 21 Nov 2024 22:38:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241121223805epsmtrp2e6a1cd9f90ee591eb3d4ea7fdf82959a~KHM-fm0v10487704877epsmtrp2l;
 Thu, 21 Nov 2024 22:38:05 +0000 (GMT)
X-AuditID: b6c32a35-6c7ff70000023fb3-4f-673fb64e1f3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 AF.CC.18937.D46BF376; Fri, 22 Nov 2024 07:38:05 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241121223805epsmtip2e21aa4663798263aed8c467cb73a9c94~KHM-OfB9B0749007490epsmtip2h;
 Thu, 21 Nov 2024 22:38:05 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Heiko Stuebner'" <heiko@sntech.de>, <sjg@chromium.org>,
 <philipp.tomsich@vrull.eu>, <kever.yang@rock-chips.com>
Cc: <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <jonas@kwiboo.se>,
 <quentin.schulz@cherry.de>, <detlev.casanova@collabora.com>,
 <u-boot@lists.denx.de>, <sebastian.reichel@collabora.com>
In-Reply-To: <20241121142731.1202209-19-heiko@sntech.de>
Subject: RE: [PATCH 18/20] mmc: rockchip_dw_mmc: Add support for rk3576
Date: Fri, 22 Nov 2024 07:38:05 +0900
Message-ID: <000301db3c66$07ff3c60$17fdb520$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJUeDCn5J2CwOuZwyaxWoAdnWczjwCRlKRnAbU5UOixvaUUoA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRy/5333k5P1NtCelsV8DzuRG264wTsOUorsPVPjTs2y7mDH3tto
 P28bRPFHOzXlhwrCLhKIS25qrrsshLHxIxQjR2JnEK6uDUJYBJOpgCQBrf0A67/P9/l+fjzP
 93keFsrtYPBYhVoTZdDK1Dgjhma/niQQ7LPvUAhH/36aGAlOAyJ4108nZp3jdKL/3jCNsNct
 MojJwBBCPLbN04nKS6XE5SE7k7g+d4tJtI1UI4TXv49YaLUDYqa7nLmTQ874LIBsMP9EIx1e
 KyCb6l000lnvZZKu6kGEvOVxANI90I6Q3wQcCLlS30Mj2+80oaTztzEkd91hVaaSkskpA5/S
 FujkhVpFFv76/rxX8iRpQpFAJCXScb5WpqGy8Jw9uYJdherQWXB+sUxdFFrKlRmN+LaXMg26
 IhPFV+qMpiyc0svVeok+xSjTGIu0ihQtZcoQCYWpkhAxX6Ucqetk6JvXlXjO/YiYgS2mArBZ
 EBPD/q4qRhhzMQeATWXJFSAmhGcBvFI7Rn9SPHbP09cUS780rjacALqHK5CofApAi1cUxgws
 BQabz6FhHI+9D2v+/AEJC1AsCGBN82SkwcYI6O+rBGEch70Gl9oWI0Y0bDO03OyKcGIxKRy+
 2bOazIeLvgsRjGLxsKH8+GrAy/BsYxstHAAxFwv+OmoJGbFCRQ6cuLI3qo2D0zdamVHMg3OB
 bkaUfxTA89Zr9GhxEsB/zG5GlLUd9pyvjRihWBK83LEtGsyBgUcn6VH/WFh2nBtlJ8JB/xSy
 5u+dCK7umYR/tNbRotMKzbelfAKpBgn1/ztD/X8JnwPEBjZQeqNGQRlFetGTqyzQaVpA5BFv
 lTjAmZkHKb0AYYFeAFkoHh+7E9+h4MbKZR98SBl0eYYiNWXsBZLQJM+gvPUFutAv0JryRGKp
 UJyWul1MiNJE+DOxAz8XU1xMITNRKorSU4Y1HcJi88yIOBF/D2bM3YO+gy3+LfnJk5+WJHPe
 fETfPe2VXDUXC695rI72WW6f59uNR5aShZxB9kL887j/1JeqZ1UJrR+/vcK7ePt3ru6vcQ/q
 VpzYZC/LsVnsmwuZTz3XO3tY8TD9q6rUvg0PDvnNpQNJb93f1Hl6/Z3drsyYFfa7AxNziu+O
 LPs6sx+it6dqGy92+w7a+0u7XhwC9/GsbGWL8+yluo6qBL7+C6VPHtB9VJwhMI1zpZ9hF270
 Cw5sPDR0bMvdvGMuxdjVo/n7OdpF76vpqHfX97pKa4nUtzCis1A1iZ5l23iR5MDo/AvLy5/E
 jZ3qOdGQfXrQ+vUbGto7ek57Ww5OMyploq2owSj7F26/cEhNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvK7vNvt0gxcftC3u/X/FaPH/0WtW
 i087H7NanHxzlcVi2/SfbBbP311msvix6gurRffKaov1l7exWxz+fJbdYuu9CUwWd1/7WXzb
 so3R4u3eTnYHPo+3T6cwesxuuMjisePuEkaPebNOsHjsnHWX3ePEhEtMHmfv7GD0uH5mO5PH
 xnc7mDz+ztrP4rH92jxmj523HzIF8ERx2aSk5mSWpRbp2yVwZdybvputYBFPxZ2F55gaGFdx
 dTFyckgImEj8vjGHtYuRi0NIYDujRM/rPawQCSmJz0+nsnUxcgDZwhKHDxdD1DxnlPh6/A0T
 SA2bgJ7E/0ULmUFsEYFqiR/znrKBFDELdDNJPH22AWrqFkaJDU9uM4JUcQpYSLw+2g1mCwu4
 S/ze+hNsEouAqsSU03vAJvEKWEpcPb0f6goFiZ9Pl4HZzAIiErM726C2OUnMnLOVZQKjwCwk
 qQWMjKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgmNIK2gH47L1f/UOMTJxMB5ilOBgVhLh
 dVCyTxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgMir0
 0Xt9dOLthknWfwUfzdGJ4uKOidSXevXebpl1KePjaEf7Tba6powd+YtvLHaaw8V4jiWII0lH
 Z1/8l95Hzics0vbKxdV7TNkUe3PlKXaD4NT1p9sjp3s8epB8vj4rypfd62rS62LTBpejYRdC
 ih9bBggmfqtN3Mu9gHPaiwSDtZuUOOSeqfyoeHVSzO14n9x5hX+FO3YunCK+WS80q/GbwhrG
 jl3R6e6NVRGP003/pG19Fu9vJD9d9Qlj2F/Hww8mOWhy6C7vsXxdvMxHMJdv4v/nU+rY2lqs
 d1nqKKduaPFtDO9/sMqjvOH9oocFQtO2K80Ie7W1Pd7p8KTF5+/MsVQ1erPdID3RZZ4SS3FG
 oqEWc1FxIgCv5fDbEAMAAA==
X-CMS-MailID: 20241121223805epcas1p4c6b32558267ab38842e1665aa13e7916
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241121142959epcas1p3b51d11ffebe6915a811a30d1357886cd
References: <20241121142731.1202209-1-heiko@sntech.de>
 <CGME20241121142959epcas1p3b51d11ffebe6915a811a30d1357886cd@epcas1p3.samsung.com>
 <20241121142731.1202209-19-heiko@sntech.de>
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
> Subject: [PATCH 18/20] mmc: rockchip_dw_mmc: Add support for rk3576
>
> The rk3576 uses a different base-compatible, as starting with this
> generation, the clock phase tuning is done via registers inside
> the mmc controller and not from inside the CRU.
>
> In U-Boot we do not tune at all, so no other code changes are
> necessary.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/rockchip_dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 422b8f7e4c8..7a72abaa38a 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -171,6 +171,7 @@ static int rockchip_dwmmc_bind(struct udevice *dev)
>  static const struct udevice_id rockchip_dwmmc_ids[] = {
>  	{ .compatible = "rockchip,rk2928-dw-mshc" },
>  	{ .compatible = "rockchip,rk3288-dw-mshc" },
> +	{ .compatible = "rockchip,rk3576-dw-mshc" },
>  	{ }
>  };
>
> --
> 2.45.2



