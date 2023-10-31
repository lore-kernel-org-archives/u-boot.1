Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41600C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A919687AB9;
	Tue, 31 Oct 2023 07:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YE1DGBE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECB987ABB; Tue, 31 Oct 2023 07:30:03 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE551874CE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031062958epoutp02ee259499ff3c9269bc806ac2a38de7b4~THWO6vIEE0907309073epoutp02J
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:29:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031062958epoutp02ee259499ff3c9269bc806ac2a38de7b4~THWO6vIEE0907309073epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698733798;
 bh=XXGzxPbtP8sB9iZ+CAtuiAoxu7uF0+q5pCvfoHxvMCo=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=YE1DGBE2eFnOc4BLtsYvArsbQnogy9rPEvxdvbJe8k43grr7gW8FSiGtt9HFdbFC8
 LyvPihJzmMoYCCCvYBNjJORiB4LSvcxPtjRH46Ap5F3/dEesoAhJ6F7pctNhFAelsi
 eCKpaYrAYoIp8eLknvtdJ9RAy9tKY1N0zF/vUT8Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031062958epcas1p416209c3a10ba37013ff952e789cd8c8e~THWOvmDN83224332243epcas1p4-;
 Tue, 31 Oct 2023 06:29:58 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKKxd0TN4z4x9QC; Tue, 31 Oct
 2023 06:29:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 ED.6F.08572.4EE90456; Tue, 31 Oct 2023 15:29:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031062956epcas1p28f4b8418eb31297f975ff99580889697~THWMpu4ia0998309983epcas1p2f;
 Tue, 31 Oct 2023 06:29:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031062956epsmtrp120d588cb547b3c560cf398dc603cf202~THWMpLBxv0827708277epsmtrp1E;
 Tue, 31 Oct 2023 06:29:56 +0000 (GMT)
X-AuditID: b6c32a33-55c16a800000217c-01-65409ee46831
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E2.8F.08817.4EE90456; Tue, 31 Oct 2023 15:29:56 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031062955epsmtip2706ef9a17bcf9f1781e4cfb0bbbad2a8~THWMcVnNo0888108881epsmtip2S;
 Tue, 31 Oct 2023 06:29:55 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Samuel Holland'" <samuel@sholland.org>, <u-boot@lists.denx.de>,
 "'Jagan Teki'" <jagan@amarulasolutions.com>, "'Andre	Przywara'"
 <andre.przywara@arm.com>
Cc: "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20231031052246.63019-1-samuel@sholland.org>
Subject: RE: [PATCH 1/2] sunxi: mmc: Sort compatible strings numerically
Date: Tue, 31 Oct 2023 15:29:55 +0900
Message-ID: <004501da0bc3$aa012160$fe036420$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFaNw0mObrs99wWAVpz+uYspkk68gGi1+fgsVYCWFA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmru6TeQ6pBgeXy1ismPeT0eLLpgls
 Fj9WfWG1eP6ok83i7d5OdgdWj7Uf77N6rJm3htHj7J0djB4b3+1g8nj1dS5jAGtUtk1GamJK
 apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0HYlhbLEnFKgUEBi
 cbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGril7GQve
 8FRMmfmWtYHxPFcXIyeHhICJxJfZa5m7GLk4hAR2MEr86djDBJIQEvjEKDF/ehmE/Y1R4tkV
 c5iG3Zd+sEM07GWUuPl2NyOE85JRYuWNdhaQKjYBPYn/ixaCjRURWMQosfziRHaQBLOAssSB
 P7fBbE4BS4l5TXvAGoQFPCSm7rsKFmcRUJU4feUSWJwXqGbn/IPMELagxMmZT1gg5shLbH87
 hxniJAWJn0+XsYLYIgJWEo/WNDNC1IhIzO5sAztCQqCTQ+LsoXXsEA0uEiu+r4GyhSVeHd8C
 ZUtJvOxvY4doaGaUWLrkICuE08Mo8a/hOhtElbHE/qWTgaHEAbRCU2L9Ln2IsKLEzt9zoTbz
 Sbz72sMKUiIhwCvR0SYEUaIicen1SyaYXXef/GedwKg0C8lvs5D8NgvJD7MQli1gZFnFKJZa
 UJybnppsWGAIj+7k/NxNjOCkqWW8g/Hy/H96hxiZOBgPMUpwMCuJ8B42dUgV4k1JrKxKLcqP
 LyrNSS0+xGgKDO2JzFKiyfnAtJ1XEm9oYmlgYmZkbGJhaGaoJM6rOGF2ipBAemJJanZqakFq
 EUwfEwenVAOT7uwSF5Z8zYUfjdZHPnbZyP0597Gghmrr62yVNcutt3pELCsyuyhR3ht33zX1
 dJv2Wv4bNTtW5zjF6K1NX3CmvP+D1Np9M6u+9jRP/LikKjC/pHWShcyZVfVX2h+tPC2819l8
 vs56X56HiUk9Oxiylp19J3yIc9mkffs+hct1fy5NZtDk6JKT3XL5jYTL70/12T9KnE/MNlx6
 ///jJ2I3Pvs9+a95fnPbs8cyuYlc5by8nbcPM9+U6clzyGMrmtwh/CzAN7v64EH1q6rzp/bq
 Sjxjqp/ne6BM1NZ5+RLXdUUnZEpe8M9pMqpzymtX3LzYmjkka+nc05rX3HJ8rRkOP9i0MzJn
 z42j+2Q6p+spsRRnJBpqMRcVJwIAZFzXYSMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvO6TeQ6pBrNusFismPeT0eLLpgls
 Fj9WfWG1eP6ok83i7d5OdgdWj7Uf77N6rJm3htHj7J0djB4b3+1g8nj1dS5jAGsUl01Kak5m
 WWqRvl0CV8auKXsZC97wVEyZ+Za1gfE8VxcjJ4eEgInE7ks/2LsYuTiEBHYzSkza28cGkZCS
 +Px0KpDNAWQLSxw+XAxR85xRomvfAmaQGjYBPYn/ixYygyREBJYwSiw/O4ERJMEsoCxx4M9t
 qKldjBLXpkxjAklwClhKzGvawwJiCwt4SEzdd5UdxGYRUJU4feUSWJwXqGbn/IPMELagxMmZ
 T1hArmAG2ta2EWq+vMT2t3OYIQ5VkPj5dBkriC0iYCXxaE0zVI2IxOzONuYJjMKzkEyahTBp
 FpJJs5B0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERw7Wlo7GPes+qB3iJGJ
 g/EQowQHs5II72FTh1Qh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbB
 ZJk4OKUamC7+3rylTU7bJN6cj0eJ8WtixukF3x5Eh6t0LXtyZkXCIomyqemezmyLW2fd4z2u
 aC+eqnNfU6ahPOzN3Vn+PhJrGO9wCt1+JL2PrVRZReRY/JVjbL3FX/gOtDfIal/V7rkwb28P
 h6uBpvZNq9DgrkXtOZUrY5+rLy1ZWXnPJOeDPMuSZ3qsvpwhN78t+RTLVRrUV3S1NlphvYbg
 hPT5vvbzPnKpdfYvXa44aeXh7TIncl2b7D8dUunb7VeqvDDm+JrypWVLj7yZbDeZae7CbQGR
 c4zPhvmVf0+f1lX9OU7bwXk/03VJq8jbsX+eLXt75sTu8oW8kdFCXTv5er5/it97UFT1TZhQ
 gPg1rn1mSizFGYmGWsxFxYkABTes3wwDAAA=
X-CMS-MailID: 20231031062956epcas1p28f4b8418eb31297f975ff99580889697
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031052252epcas1p2427a69ef9d0d8ee856242f44e03d2c47
References: <CGME20231031052252epcas1p2427a69ef9d0d8ee856242f44e03d2c47@epcas1p2.samsung.com>
 <20231031052246.63019-1-samuel@sholland.org>
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
> From: Samuel Holland <samuel@sholland.org>
> Sent: Tuesday, October 31, 2023 2:23 PM
> To: u-boot@lists.denx.de; Jagan Teki <jagan@amarulasolutions.com>; Andre Przywara
> <andre.przywara@arm.com>
> Cc: Samuel Holland <samuel@sholland.org>; Jaehoon Chung <jh80.chung@samsung.com>; Peng Fan
> <peng.fan@nxp.com>
> Subject: [PATCH 1/2] sunxi: mmc: Sort compatible strings numerically
> 
> commit 95168d77d391 ("sunxi: add Allwinner R528/T113 SoC support") added
> the new entry out of order.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/sunxi_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 4d6351bf275..7caefa153dc 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -701,13 +701,13 @@ static const struct udevice_id sunxi_mmc_ids[] = {
>  	{ .compatible = "allwinner,sun7i-a20-mmc" },
>  	{ .compatible = "allwinner,sun8i-a83t-emmc" },
>  	{ .compatible = "allwinner,sun9i-a80-mmc" },
> +	{ .compatible = "allwinner,sun20i-d1-mmc" },
>  	{ .compatible = "allwinner,sun50i-a64-mmc" },
>  	{ .compatible = "allwinner,sun50i-a64-emmc" },
>  	{ .compatible = "allwinner,sun50i-h6-mmc" },
>  	{ .compatible = "allwinner,sun50i-h6-emmc" },
>  	{ .compatible = "allwinner,sun50i-a100-mmc" },
>  	{ .compatible = "allwinner,sun50i-a100-emmc" },
> -	{ .compatible = "allwinner,sun20i-d1-mmc" },
>  	{ /* sentinel */ }
>  };
> 
> --
> 2.41.0


