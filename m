Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF09C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E95187DC5;
	Thu, 15 Feb 2024 14:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Gfv47k3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B7B87DC7; Thu, 15 Feb 2024 13:05:46 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41A787D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
 by m0048205.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41FAEJTU039906
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 07:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=HXNpArFhGpg/8bU0sMdi+KiAKks/bzkEgKfkYdalTvw=; b=Gfv47k3tf0jV
 keZt+hsC/Gb9aAlIkwNTZgj/sd7d7rIpW7i5qh5g5TSSrefLsCOidbgPUcLe0kgA
 ud7T6irl0v8W4F4LednxAZZmbE23rLCYdoYmmZVJtxku/CefkaV2ZiALZ7s8VZ8d
 HAUorEE45ncwajuhdxPQp3trwMHLV+ZykUIXH8Q9CqfoTzxBpPRle0TVGoZQ3v9W
 Xem6KmMPFtFLoPulfwMoSerdinCWWtP9osU2PnT9TdcKkDnd6vKZirkDexLv3TLG
 7deLlVU5JalL3JM7hnjuHVfPdwsiFI6N3fFfxYyw6hayQ4teQLpo8IAJMG5iyGx8
 g8LvezCs2Q==
Date: Thu, 15 Feb 2024 14:05:34 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: EXT: [PATCH 2/5] msc_sm2s_imx8mp: Make Ethernet functional
Message-ID: <Zc3-DhdhLk9PxcPH@de2cfed78370>
References: <20240213114342.2728075-1-festevam@gmail.com>
 <20240213114342.2728075-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114342.2728075-2-festevam@gmail.com>
X-Proofpoint-GUID: UB8EBlMbn92TwvhEUnp0iaZaXHxp1OAG
X-Proofpoint-ORIG-GUID: UB8EBlMbn92TwvhEUnp0iaZaXHxp1OAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxlogscore=901 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150096
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

On Tue, Feb 13, 2024 at 08:43:39AM -0300, Fabio Estevam wrote:
> 
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, the Ethernet ports are not working.
> 
> The Ethernet PHY reset lines are controlled by the TCA6424 I2C GPIO
> expander.
> 
> The TCA6424 I2C GPIO expander is supported by the CONFIG_DM_PCA953X
> driver.
> 
> Select the CONFIG_DM_PCA953X option so that the Ethernet PHYs can
> go through a proper reset making Ethernet to be functional.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  configs/msc_sm2s_imx8mp_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
> index 9c27a72f8a..a190c1ea22 100644
> --- a/configs/msc_sm2s_imx8mp_defconfig
> +++ b/configs/msc_sm2s_imx8mp_defconfig
> @@ -72,6 +72,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
>  CONFIG_SPL_CLK_IMX8MP=y
>  CONFIG_CLK_IMX8MP=y
>  CONFIG_MXC_GPIO=y
> +CONFIG_DM_PCA953X=y
>  CONFIG_DM_I2C=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> -- 
> 2.34.1
> 
> 
