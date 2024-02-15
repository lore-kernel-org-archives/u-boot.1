Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FCFC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BC287E12;
	Thu, 15 Feb 2024 14:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="IoCSxgiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EB387DD0; Thu, 15 Feb 2024 13:06:14 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EE587D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
 by m0047963.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41F9UfZE013000
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 07:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=d1dlfLHOj2RwzEIFERtM9fDJoLEuyRVO7vM8DtBeA6s=; b=IoCSxgiHgkmL
 uNLw9WfRvSpBl/9zdhCfBtekGGNMnWTKYETg7g5LML8Tw3Htf+ghE0Y/O4lSngQA
 Z3fsgRVjw+SxcuBfV8EiqORbFxstmRuG2pncNnIGB3Fr0khyDVsRtD3BTdKz3zNQ
 F8o8PfV8ECKX09fXo9Kz5Fr0z4TNcvSNKARCn1gf2qsQIOz1dU5z7sGVzvGdpHQL
 3dsbOhSv+VF8pnfo/grcFXxalOI1Q/397fKXjyOwd/AEejguYfeR+wR5JZhGo4Xy
 EeKg1t5CG9eDlqatPB4boc5km8l0Rup3SRBCXE9F+MvBjtzhM99Jtd/hTN1v/l6m
 z9l/OQ/KeQ==
Date: Thu, 15 Feb 2024 14:05:43 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: EXT: [PATCH 3/5] imx8mp-msc-sm2s: Add mmc aliases
Message-ID: <Zc3-F2VObpvCYaB2@de2cfed78370>
References: <20240213114342.2728075-1-festevam@gmail.com>
 <20240213114342.2728075-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114342.2728075-3-festevam@gmail.com>
X-Proofpoint-GUID: d5aPde3eAIuAD3lzAUpEq6yp4DXbPKeq
X-Proofpoint-ORIG-GUID: d5aPde3eAIuAD3lzAUpEq6yp4DXbPKeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150097
X-Mailman-Approved-At: Thu, 15 Feb 2024 14:28:40 +0100
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

On Tue, Feb 13, 2024 at 08:43:40AM -0300, Fabio Estevam wrote:
> 
> From: Fabio Estevam <festevam@denx.de>
> 
> Add mmc alias so that the eMMC is mmc0 and the SD card
> is mmc1 to have a well defined device numbering scheme.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> index 1a7b530d9f..ce61ca6671 100644
> --- a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> @@ -9,6 +9,11 @@
>  	model = "MSC SM2S-IMX8MPLUS";
>  	compatible = "avnet,sm2s-imx8mp", "fsl,imx8mp";
>  
> +	aliases {
> +		mmc0 = &usdhc3;
> +		mmc1 = &usdhc2;
> +	};
> +
>  	wdt-reboot {
>  		compatible = "wdt-reboot";
>  		wdt = <&wdog1>;
> -- 
> 2.34.1
> 
> 
