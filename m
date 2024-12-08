Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2DE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF08C89500;
	Mon,  9 Dec 2024 00:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Ul2x2Pan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD0B8953F; Mon,  9 Dec 2024 00:56:51 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F1A893AE
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241208235644epoutp04e9e9d19c273949df31b56721e1255773~PWPhAUveF0992909929epoutp04G
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241208235644epoutp04e9e9d19c273949df31b56721e1255773~PWPhAUveF0992909929epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733702204;
 bh=N3Zw31KC/ECBA9q2oWPJ8iRwxDbbY5xW80BKRuCcRtI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Ul2x2PansfM1rejokPtkXjcvL8vtTMNUogWTN1VjRDIAYhP1N8Mzl6HxOKucGj7HM
 QNJpKGnG4IA7vWh3TW3KUk5wGgU2WtAt+wrWqke/JiE9h2K9RnwUQCE3B+oaoG2yeV
 amTe5MwjS59dXU4a1z671S83e4CwNp0xshWMBqUM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241208235644epcas1p3e2611d254c70517da88a9734063db559~PWPgpJyj32473624736epcas1p35;
 Sun,  8 Dec 2024 23:56:44 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.231]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y622z0Dfhz4x9Q0; Sun,  8 Dec
 2024 23:56:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 4D.B8.23253.A3236576; Mon,  9 Dec 2024 08:56:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241208235642epcas1p1f0a915078a17f169345cfa67fc204ab7~PWPfC02xq0672306723epcas1p1y;
 Sun,  8 Dec 2024 23:56:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241208235642epsmtrp18e258ca7c04aa48fe00ac553d24398a1~PWPfCBe3Q1789517895epsmtrp1X;
 Sun,  8 Dec 2024 23:56:42 +0000 (GMT)
X-AuditID: b6c32a33-5a18170000005ad5-92-6756323afea7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D9.28.18949.A3236576; Mon,  9 Dec 2024 08:56:42 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241208235642epsmtip2c9b99fac202187bdbd1b764151ad2a20~PWPe3-eIJ2788527885epsmtip2g;
 Sun,  8 Dec 2024 23:56:42 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20241208220551.204743-6-marek.vasut+renesas@mailbox.org>
Subject: RE: [PATCH 06/13] mmc: renesas: Fix R-Car spelling
Date: Mon, 9 Dec 2024 08:56:42 +0900
Message-ID: <082001db49cc$d47931b0$7d6b9510$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG7SSyzAYIHjYUOd1obIOVJ/X+H+ALSfQXBAi8ZUAuy9PqMwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmnq6VUVi6QethK4vWlXfYLKZO2sxu
 8XZvJ7sDs8erA6vYPc7e2cHosXP2PqYA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zBygTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
 AtMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iyrb9eyFlyWqtjZcpa1gfGBaBcjJ4eEgIlEy8b9
 jF2MXBxCAjsYJW5ff84C4XxilLi4q5EVpEpI4BujxIvZFjAdHVdWsEDE9zJKtL9SgLBfMkqc
 OxsMYrMJ6En8X7SQGcQWEfCXaH+7GKieg4NZQFVi1YEIkDCngJvE2knLwMYIC1hLHNl+nQ3E
 ZhFQkdh/YgNYK6+ApcTsc8tYIdYqSPx8CmGLCDhJPFowCcxmFhCRmN3Zxgxys4TAPnaJpdc2
 MkM0uEis2LQSqllY4tXxLewQtpTEy/42doiGZkaJpUsOskI4PYwS/xogzpAQMJbYv3QyE8TV
 mhLrd+lDbOOTePe1hxUkLCHAK9HRJgRRrSJx6fVLJpj5d5/8hyrxkGjvdIeE51VGif7/c1gm
 MMrPQnL3LIQFCxiZVjGKpRYU56anJhsWGMLjMTk/dxMjOH1pGe9gvDz/n94hRiYOxkOMEhzM
 SiK8HN6h6UK8KYmVValF+fFFpTmpxYcYTYEhOZFZSjQ5H5hA80riDU0sDUzMjIxNLAzNDJXE
 ec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYOJ5/see2ahhjg6nrYTGdmmD6RfPPJXUeGf0pnk6
 m+Q8vz3rnFv0BGwX379qtTzCY53zHb1y6Z2cfeduzrTdlHXw5/3WxIWtt2ecYPC5nnYqc2ur
 bm3aobZ1Moxsig9z1k2Y2fzmgdjRF/9mOEwIfbU6kpXrQ6BexsytDAVzO/kTAtqWhObkaisJ
 77P3O8Nkzc+pVn9QrPbLynVGrp/Czj/LMJ16r/ZTx1nujolXl0iHfZw/XfDnDJ+EC7d1ODa/
 Ovi5I+vhuaBX4QnJE86vanl298s55U0eGTKf74g2bFxW0Zf16fJfJcMj5U+W2VxapGCgMFuw
 zmZmT37MG+fPb+7Vfy44wb9drz5Z9rHBuh1KLMUZiYZazEXFiQDJ4X/O6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvK6VUVi6wd9VahatK++wWUydtJnd
 4u3eTnYHZo9XB1axe5y9s4PRY+fsfUwBzFFcNimpOZllqUX6dglcGVffrmUtuCxVsbPlLGsD
 4wPRLkZODgkBE4mOKytYuhi5OIQEdjNKTLrXwwiRkJL4/HQqWxcjB5AtLHH4cDFIWEjgOaPE
 iSY9EJtNQE/i/6KFzCC2iIC/RPvbxSwg5cwCqhKrDkRAjLzIKNHytIsNpIZTwE1i7aRlLCC2
 sIC1xJHt18HiLAIqEvtPbACbwytgKTH73DJWiBMUJH4+hbBFBJwkHi2YBGYzC4hIzO5sY57A
 KDALibuAkXEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwAGpp7WDcs+qD3iFGJg7G
 Q4wSHMxKIrwc3qHpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgsky
 cXBKNTB1Kqqen+V47KLh/q5Z9UtnlD5+mfF5pcQ6qUla73QuFm1JdP7/mf3QMf5bcu+nT1q4
 Ya1CmeGZaSWR+ZZB1zl+nyzZF6CmFlpg/UixZ+vnOuNZZ/SrV5jvVyxpn7uL7ejLouBJhzuf
 mAdt+1i53sl515xrK4X3hnHe7nt2oy9sVqPS6R+m5/4fa+L4OYtrutL8izu72M55LfvVtkdj
 +8v/n/N/eKS+Tj37cM6qetePpz94XTnzMLuBX6x4tvsCvquReSkpYqUfl0tc+aP2blJBzGtz
 xVflHAWcqpsEPs8OD3RIfpjLrbpG1PJEx1uVd62RV1z/F2494XWGe0PlCsPtPI+e3eJcLuQy
 /9Bx0UuizkosxRmJhlrMRcWJAKrpPASvAgAA
X-CMS-MailID: 20241208235642epcas1p1f0a915078a17f169345cfa67fc204ab7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208220704epcas1p1ae117a90d00f7067505266712f1e6dcc
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
 <CGME20241208220704epcas1p1ae117a90d00f7067505266712f1e6dcc@epcas1p1.samsung.com>
 <20241208220551.204743-6-marek.vasut+renesas@mailbox.org>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Marek Vasut
> Sent: Monday, December 9, 2024 7:04 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH 06/13] mmc: renesas: Fix R-Car spelling
>
> The correct spelling is R-Car, including the dash, update the usage.
> Kconfig strings and comment changes only, no functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mmc/renesas-sdhi.c |  2 +-
>  drivers/mmc/tmio-common.h  | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 92afa6adcda..556f07eaf8f 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -571,7 +571,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
>  	int i, ret = 0, sret;
>  	u32 caps, reg;
>
> -	/* Only supported on Renesas RCar */
> +	/* Only supported on Renesas R-Car */
>  	if (!(priv->caps & TMIO_SD_CAP_RCAR_UHS))
>  		return -EINVAL;
>
> diff --git a/drivers/mmc/tmio-common.h b/drivers/mmc/tmio-common.h
> index f489fb70766..657aba75148 100644
> --- a/drivers/mmc/tmio-common.h
> +++ b/drivers/mmc/tmio-common.h
> @@ -64,7 +64,7 @@
>  #define   TMIO_SD_CLKCTL_DIV4		BIT(0)	/* SDCLK = CLK / 4 */
>  #define   TMIO_SD_CLKCTL_DIV2		0	/* SDCLK = CLK / 2 */
>  #define   TMIO_SD_CLKCTL_DIV1		BIT(10)	/* SDCLK = CLK */
> -#define   TMIO_SD_CLKCTL_RCAR_DIV1	0xff	/* SDCLK = CLK (RCar ver.) */
> +#define   TMIO_SD_CLKCTL_RCAR_DIV1	0xff	/* SDCLK = CLK (R-Car ver.) */
>  #define   TMIO_SD_CLKCTL_OFFEN		BIT(9)	/* stop SDCLK when unused */
>  #define   TMIO_SD_CLKCTL_SCLKEN	BIT(8)	/* SDCLK output enable */
>  #define TMIO_SD_SIZE			0x04c	/* block size */
> @@ -90,7 +90,7 @@
>  #define   TMIO_SD_VOLT_180		(2 << 0)/* 1.8V signal */
>  #define TMIO_SD_DMA_MODE		0x410
>  #define   TMIO_SD_DMA_MODE_DIR_RD	BIT(16)	/* 1: from device, 0: to dev */
> -#define   TMIO_SD_DMA_MODE_BUS_WIDTH	(BIT(5) | BIT(4)) /* RCar, 64bit */
> +#define   TMIO_SD_DMA_MODE_BUS_WIDTH	(BIT(5) | BIT(4)) /* R-Car, 64bit */
>  #define   TMIO_SD_DMA_MODE_ADDR_INC	BIT(0)	/* 1: address inc, 0: fixed */
>  #define TMIO_SD_DMA_CTL		0x414
>  #define   TMIO_SD_DMA_CTL_START	BIT(0)	/* start DMA (auto cleared) */
> @@ -128,9 +128,9 @@ struct tmio_sd_priv {
>  #define TMIO_SD_CAP_DIV1024		BIT(2)	/* divisor 1024 is available */
>  #define TMIO_SD_CAP_64BIT		BIT(3)	/* Controller is 64bit */
>  #define TMIO_SD_CAP_16BIT		BIT(4)	/* Controller is 16bit */
> -#define TMIO_SD_CAP_RCAR_GEN2		BIT(5)	/* Renesas RCar version of IP */
> -#define TMIO_SD_CAP_RCAR_GEN3		BIT(6)	/* Renesas RCar version of IP */
> -#define TMIO_SD_CAP_RCAR_UHS		BIT(7)	/* Renesas RCar UHS/SDR modes */
> +#define TMIO_SD_CAP_RCAR_GEN2		BIT(5)	/* Renesas R-Car version of IP */
> +#define TMIO_SD_CAP_RCAR_GEN3		BIT(6)	/* Renesas R-Car version of IP */
> +#define TMIO_SD_CAP_RCAR_UHS		BIT(7)	/* Renesas R-Car UHS/SDR modes */
>  #define TMIO_SD_CAP_RCAR		\
>  	(TMIO_SD_CAP_RCAR_GEN2 | TMIO_SD_CAP_RCAR_GEN3)
>  	struct udevice *vqmmc_dev;
> --
> 2.45.2



