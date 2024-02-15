Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F411BC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436D387E01;
	Thu, 15 Feb 2024 14:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gJvV6b81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D9A87DD0; Thu, 15 Feb 2024 13:06:11 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47EAC87DC5
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0047961.ppops.net [127.0.0.1])
 by m0047961.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41FATObk030181
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 07:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=R+58aMapmge26Ks1efdvEpT+yjN2Y+LFh2AxtDSpgTo=; b=gJvV6b81HY3Z
 VMmcY1qFo3e6SQHCx76a5yfyBxztO5OklFkbIpZ/oHRJEwCTIgLAh92Aj9nhV0lN
 vWoWUwyjh5UZSMVpqzrr9mkIXl6ityu3da9N8L1PWsK3fRT14geaZ9Apd6PSVaeZ
 ajw1IUgE6xaXOxSLe/pbJG4IcZ9TmLOgtiAJsQl65knziqosoDyV6HndiPpVqsy/
 tMdr0XLBZr2v4Ap+5K7nHYNCMvv6yvs+2bsyTVqMiChRQsgZpOutU+3fj8Cp5XLK
 2yspNFQFh2AuAfgpG4eKkuAp5qLVDYRrvXeCxah0bEWCo6XzblXnCz8DREs1oBO1
 BBQ4x83XgA==
Date: Thu, 15 Feb 2024 14:05:51 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: EXT: [PATCH 4/5] msc_sm2s_imx8mp: Add redundant environment
 support
Message-ID: <Zc3-H0ATlxQan_i4@de2cfed78370>
References: <20240213114342.2728075-1-festevam@gmail.com>
 <20240213114342.2728075-4-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114342.2728075-4-festevam@gmail.com>
X-Proofpoint-GUID: snqNGFrkPr7IuF7RscjKxweObZ1LinxU
X-Proofpoint-ORIG-GUID: snqNGFrkPr7IuF7RscjKxweObZ1LinxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Tue, Feb 13, 2024 at 08:43:41AM -0300, Fabio Estevam wrote:
> 
> From: Fabio Estevam <festevam@denx.de>
> 
> Redundant environment support is required for software updates.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  configs/msc_sm2s_imx8mp_defconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
> index a190c1ea22..3a49b7d55c 100644
> --- a/configs/msc_sm2s_imx8mp_defconfig
> +++ b/configs/msc_sm2s_imx8mp_defconfig
> @@ -5,7 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
> -CONFIG_ENV_SIZE=0x1000
> +CONFIG_ENV_SIZE=0x4000
> +CONFIG_ENV_OFFSET=0x200000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="imx8mp-msc-sm2s"
>  CONFIG_SPL_TEXT_BASE=0x920000
> @@ -16,6 +17,7 @@ CONFIG_SPL_SERIAL=y
>  CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_SPL_STACK=0x960000
>  CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x204000
>  CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
>  CONFIG_SYS_LOAD_ADDR=0x40480000
>  CONFIG_SYS_BOOT_GET_CMDLINE=y
> @@ -62,6 +64,8 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>  CONFIG_USE_ETHPRIME=y
> -- 
> 2.34.1
> 
> 
