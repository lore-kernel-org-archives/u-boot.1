Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB152C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649DB87E1A;
	Thu, 15 Feb 2024 14:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="bxkjbXGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8523B87DC1; Thu, 15 Feb 2024 13:07:04 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C44287D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
 by m0048274.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41FBkjml011067
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 07:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=XmKycvJaDqtooA2iacgyznuVMHOLz0s4ge4KDPcaxeI=; b=bxkjbXGT7RVW
 GuoNI23F2SrqfzRblm1jC5EL/GR/wNZiXqT2z7gxPTRz7P4ac/Ime47/0iN6V8on
 C1VGkf+eNF2jgXdOiYpB38CCkQh71BH4snmuP93KMRDs4eivM3GqbexF1WdYJqS5
 p/En2oAv9t7BPUFgfroOt26pcrfNYrR9AmM91TD2+UBA8dkFz2r42x23bqMVu00a
 84RLH7//AfFbvq/Qp4Nu2RepWwPY7cv6LgvdzZMNugvcn+psFLG2m2XkvAj+joxi
 3zROEFRyREN+Z6eBXM9MzLVZx/rUzjuma0o6srlrrxD9/6d5kyM/0dI0+v06dUaw
 XSPntoKmOg==
Date: Thu, 15 Feb 2024 14:06:50 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: EXT: [PATCH 5/5] msc_sm2s_imx8mp: Fix CONFIG_DEFAULT_FDT_FILE
Message-ID: <Zc3-WjyDLuJ8dROf@de2cfed78370>
References: <20240213114342.2728075-1-festevam@gmail.com>
 <20240213114342.2728075-5-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114342.2728075-5-festevam@gmail.com>
X-Proofpoint-ORIG-GUID: 7gtyo0ETnxiXlZdWa2Pz755YR7aoIJcz
X-Proofpoint-GUID: 7gtyo0ETnxiXlZdWa2Pz755YR7aoIJcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Tue, Feb 13, 2024 at 08:43:42AM -0300, Fabio Estevam wrote:
> 
> From: Fabio Estevam <festevam@denx.de>
> 
> There is no imx8mp-msc-sm2s.dtb file in upstream Linux.
> 
> Change it to imx8mp-msc-sm2s-ep1.dtb.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  configs/msc_sm2s_imx8mp_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
> index 3a49b7d55c..5688c7a64d 100644
> --- a/configs/msc_sm2s_imx8mp_defconfig
> +++ b/configs/msc_sm2s_imx8mp_defconfig
> @@ -28,7 +28,7 @@ CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SYS_BOOTM_LEN=0x2000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_DEFAULT_FDT_FILE="imx8mp-msc-sm2s.dtb"
> +CONFIG_DEFAULT_FDT_FILE="imx8mp-msc-sm2s-ep1.dtb"
>  CONFIG_SYS_CBSIZE=2048
>  CONFIG_SYS_PBSIZE=2074
>  CONFIG_SPL_MAX_SIZE=0x26000
> -- 
> 2.34.1
> 
> 
