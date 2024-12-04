Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D99E77166
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB26893FD;
	Wed,  4 Dec 2024 01:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="La0KtXQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130DA8966C; Wed,  4 Dec 2024 01:27:06 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5041388F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241204002659epoutp048d58f470514a9e65c9af542b8743c463~N0bfqvoY10686506865epoutp04u
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:26:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241204002659epoutp048d58f470514a9e65c9af542b8743c463~N0bfqvoY10686506865epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733272019;
 bh=19zrkMeuhatGFXOQDQWEEHZKgNXNIWq1nAZV/I8p2KE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=La0KtXQrzbpqd1b2Mh+toliXW0rUPXF6Le9q0DPtzQdAzS2aR1Tyo7RES4GRbH0pj
 ZwKSOZa1WxMWVNDILMJwrZeRBaXm8tioNcjrFsRoz6NzEOaz48HPZiLHAGIHdJEDVV
 x3hlivg70nM9AC0LJLhHHOfwC5ls4STh3ksQmfBo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241204002658epcas1p3804e7f93ec7a0d0b7fe390f9ae36acc5~N0beoibCN2660826608epcas1p3_;
 Wed,  4 Dec 2024 00:26:58 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y2yy92hxVz4x9Q0; Wed,  4 Dec
 2024 00:26:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 69.2E.23869.1D1AF476; Wed,  4 Dec 2024 09:26:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241204002656epcas1p4a3a278c0a1e5ddb4ef3792652c453ad2~N0bdMPMVT2936429364epcas1p4X;
 Wed,  4 Dec 2024 00:26:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241204002656epsmtrp1ff384f5bf744495ae0b8a387e2c49bc6~N0bdLLgro0865408654epsmtrp1b;
 Wed,  4 Dec 2024 00:26:56 +0000 (GMT)
X-AuditID: b6c32a36-6e9e870000005d3d-eb-674fa1d18b2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 64.FD.18729.0D1AF476; Wed,  4 Dec 2024 09:26:56 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241204002656epsmtip24efb2ebf87e9063d01badd5be974d20d~N0bc13hzt3134031340epsmtip2S;
 Wed,  4 Dec 2024 00:26:56 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <bigunclemax@gmail.com>
Cc: "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 "'Tom Rini'" <trini@konsulko.com>, "'Wei Fu'" <wefu@redhat.com>, "'Yixun
 Lan'" <dlan@gentoo.org>, "'Peng Fan'" <peng.fan@nxp.com>, "'Ilias
 Apalodimas'" <ilias.apalodimas@linaro.org>, "'Sughosh Ganu'"
 <sughosh.ganu@linaro.org>, "'Jerome Forissier'"
 <jerome.forissier@linaro.org>, "'Neil Armstrong'"
 <neil.armstrong@linaro.org>, "'Linus Walleij'" <linus.walleij@linaro.org>,
 "'Jonas	Karlman'" <jonas@kwiboo.se>, "'Nathan Barrett-Morrison'"
 <nathan.morrison@timesys.com>, "'Marek Vasut'"
 <marek.vasut+renesas@mailbox.org>, "'Greg Malysa'"
 <greg.malysa@timesys.com>, "'Kongyang Liu'" <seashell11234455@gmail.com>,
 "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, "'Kuan Lim Lee'" <kuanlim.lee@starfivetech.com>,
 "'Ferass El Hafidi'" <vitali64pmemail@protonmail.com>, "'Kever Yang'"
 <kever.yang@rock-chips.com>, <u-boot@lists.denx.de>
In-Reply-To: <20241201150704.44462-4-bigunclemax@gmail.com>
Subject: RE: [PATCH v1 3/3] configs: th1520_lpi4a: enable mmc controller
 support
Date: Wed, 4 Dec 2024 09:26:56 +0900
Message-ID: <000801db45e3$39ad8f10$ad08ad30$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKWNLOKvs2bV1RfzKy+BBIXkYaGAKdG5t9AZ5uXmS0VThXQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTfd9ve3hIrNxXlCyysaXQEFkqLPD4cEOLzOnQjjrmFRLsGroXQ
 l21BN/8YG48JMi2MaoREeUpEpoKulFnaAVO3STGWgeCKw0e3AcorDJRRHOXCtv9+v3N+v3PO
 d74cgiWYxwOITLWB1qnlShHuwzZ3hUjC7lW/p5D0jfHRz4vf4mjI9Q2G7kwPsNFX+X+z0N2C
 Wi766VkfG5nPvMRRccsEhsoXGjBUcNGFo97qXoAm2h4A9KJxhoOe/+kA6NblKS6avW4G6GF/
 EDKVXeOi5+1FXNTx1MFG+fZyNuoyTQL0pHMMS/SnrHcqWFRl7j021Tv3jEW1VQxxqcmpg9To
 941c6kejE6Nc/VaccrgsgGqrtGFU87gFo0oKWzBqwtaHU54KO5v61cGn2ltfYMlkalZcBi1P
 p3VCWp2mSc9UK+JFSe/LtsmioiXSMGksihEJ1XIVHS/avic5bGemcmkXImGOXJm9FEqW6/Wi
 8IQ4nSbbQAszNHpDvIjWpiu1UVqxXq7SZ6sVYjVt2CKVSCKiloQfZ2VMFeZojWuOdrstWC74
 3KcY8AhIRkK3e45VDHwIAWkB8IS7h82QaQDLXNdWyCyAD20lrFXL7apzGJNoB/BirW2FjAA4
 2/yE7VXhpBi+qqledviRgfC0pwV4RSyyiwvPtjZzvAke+TY05R7nFgOCWEfugw3n4rxhNrkR
 fjFRv+zlk7Ewb9i00lkIX7ovcJiaW6HZbcO9mEX6wcqiwuVHQLKBBwctvwHGsB02P76JMXgd
 HL19ncvgADhyqpDLGPIArK/r4DCkBMDF3Ps4o9oM7fVfY97pWGQIvPJdONNtLRz/q4TjDUOS
 D48XChj1RugcG8FW6w89fcVhMAUbzQXLSxGQdgCtX+43gjcq/jd3xX8NqgDWCDbQWr1KQeul
 2oh/vzJNo2oBy0cQGm0BZc8nxZ0AI0AngARL5MdvuJKkEPDT5Z98Sus0Ml22ktZ3gqilTZay
 AtanaZauSG2QSSNjJZHREZsjkTRaKvLnd/+SQwtIhdxAZ9G0ltat+jCCF5CLKaaDdg6oo6U7
 PKkH3p3q4+Z/mOCQ38o8vDf1/EJVypHfFwT7tzQlzhBb56brHu167Y/QXS3H7GFF2kHV2I28
 A5WLqr71MRtcw/VVJ8vsxhzO1cXPyh+lEMThIx8Mhb7entfvs69UsGmtadhZ3bzpZoDJU6Tw
 M3reCcyvmfwBp47hPUZ37eUI39E1lDOeV+Av3hF4qfPC0dPi83s/GlPissbHJ07ttu6RJoab
 3jwkPbhgvh8U4ycKb/UN3u0s9klqO+kKl0WcqQO8+aazCk7K1cGmRavnrYQQRUb3pQXbXXt+
 5baatBnrwPyDNGNwq7CD8A32vxFXWt4TXGxyTI87Ow6J2PoMuTSUpdPL/wH+k+2VjQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvO6Fhf7pBj8Xalic+reVzeLunbVM
 Fqc/3WCx6G35zWxxvnUxu8XJN1dZLLZN/8lm0bXpPZPFlD/LmSxaV95hs7i88DKjxfudtxgt
 fqz6wmrx9sVZRotj6z6yW3zbso3R4t41OYupkzazW7zd28lucfDJWRaLlv1TWCwOT/3AaPH4
 0GsmB3GPPadnMXvMbrjI4nH5+xtmj52z7rJ7fPgY5/HqwCp2jxMTLjF53Lm2h83j7J0djB47
 Z+9j8tj4bgeTR0/bJiaP9/uusnn8nbWfxeP2WV6Pvdt/MAUIRHHZpKTmZJalFunbJXBlfGwr
 K5jAU3Hm6Q6mBsZGri5GTg4JAROJ4wvmMXUxcnEICexmlGj8P50NIiEl8fnpVCCbA8gWljh8
 uBii5jmjxNq17xhBatgE9CT+L1rIDGKLCEhLTPu7iRGkiFngIrvElr1z2OGmTtv5FKyDU8Ba
 YmpDBzuILSwQIPHr3GFWEJtFQEWi6f1SsEm8ApYSzQ+mMkNcoSDx8+kyVogNThLbnu4Du45Z
 QERidmcb8wRGgVlI3AWMjKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjWUtzB+P2
 VR/0DjEycTAeYpTgYFYS4V2+3jtdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU
 7NTUgtQimCwTB6dUA9Oyb9Gv+zPMrWsVf8+2+rQ1S6yh52yUrxP7//JfE51EFNrijPe4u8Uw
 fHgnf4sp6Xz5jl6xmyt1DlgevJX1sqFgof28X3f++dqmfits2HnXacli274Z2vtj2O4GJyor
 rrn84ECJ+qf4is1NTHVNSm5a/inh+zqWi/47sfvghlfdDt96OXO+1j7uaWF6ouOkO1OaX5Q9
 X1ZG8zN/2dT1M5e+FnZKV542NULJ0WzGHatfEinfdSutCix4GWrCg3buk1mj7unL26wjmbQ8
 LW3Oo2MzK692WrG22Z2QzGQXyd6t/f/LNHVgrujNOHt0wXTp3bM2PlbKelfbLsp0cUbeOguL
 yFqep3eKfnRuP79SiaU4I9FQi7moOBEAErAbPFMDAAA=
X-CMS-MailID: 20241204002656epcas1p4a3a278c0a1e5ddb4ef3792652c453ad2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241201150735epcas1p3e08def23cf7f9189d79d8bfd39484b37
References: <20241201150704.44462-1-bigunclemax@gmail.com>
 <CGME20241201150735epcas1p3e08def23cf7f9189d79d8bfd39484b37@epcas1p3.samsung.com>
 <20241201150704.44462-4-bigunclemax@gmail.com>
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
> From: bigunclemax@gmail.com <bigunclemax@gmail.com>
> Sent: Monday, December 2, 2024 12:07 AM
>
> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> Enable driver for DesignWare MSHC. TH1520 supports all
> speed modes up to HS400ES and UHS SDR105.
>
> Also enable ADMA and mmc command.
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  configs/th1520_lpi4a_defconfig | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
> index 3b6ff62ee1..d13c97463a 100644
> --- a/configs/th1520_lpi4a_defconfig
> +++ b/configs/th1520_lpi4a_defconfig
> @@ -54,6 +54,8 @@ CONFIG_CMD_BOOTMENU=y
>  CONFIG_CMD_GPIO=y
>  # CONFIG_CMD_LOADB is not set
>  # CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>  # CONFIG_CMD_ITEST is not set
>  # CONFIG_CMD_SOURCE is not set
>  # CONFIG_CMD_SETEXPR is not set
> @@ -66,7 +68,14 @@ CONFIG_NO_NET=y
>  CONFIG_DWAPB_GPIO=y
>  # CONFIG_I2C is not set
>  # CONFIG_INPUT is not set
> -# CONFIG_DM_MMC is not set
> +CONFIG_MMC=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_SNPS=y
>  # CONFIG_MTD is not set
>  # CONFIG_POWER is not set
>  CONFIG_SYS_NS16550=y
> --
> 2.45.2



