Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D2C54FCC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D71D83DBF;
	Fri, 20 Feb 2026 10:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kmb9IlB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCD183E13; Fri, 20 Feb 2026 10:03:33 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2E983DAE
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8340A43D3C;
 Fri, 20 Feb 2026 09:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D186C116C6;
 Fri, 20 Feb 2026 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771578209;
 bh=N+JyPdw6KdSYUGMDwDeYoZcuIsYxrA21SRCA7fklYF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kmb9IlB9wO4x1jWlT8oKysnjTSCExH/8S+5Uz7dcokXu2bjFV+gUUy+BncqlN9wis
 En+J1FXt+6h2qSrAlFTUKHPeLNgbPaXyoVHupSeCYRyfH/PviVLpwy7HatXyOYpb30
 kCp1O8m8MbdxU6wr/3PBG3crZ9zarTOAEFjRY6njMHAqrDLqeClZdBPfdbU+x+T8ia
 OCYP3F8PeF4/1b9fJ4pYCdAaYoaO2WPHSGjD4FtIZtL+PsaUbKjtBEBnskeJkN/EKW
 8YpKXgPAME6fgx4VsHRi0OjGyc2WTaDjaxVaTXQXQQazI1SLSMdE/iSyjYLoPck6Ir
 Enj7tV1Vi5qjw==
Date: Fri, 20 Feb 2026 14:33:20 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 varadarajan.narayanan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v8 4/4] qcom_defconfig: Add QCOM_RPMH_POWER_DOMAIN config
Message-ID: <aZgjWDdagPDRvD42@sumit-xelite>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
 <20260213111009.1254360-5-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213111009.1254360-5-aswin.murugan@oss.qualcomm.com>
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

On Fri, Feb 13, 2026 at 04:40:09PM +0530, Aswin Murugan wrote:
> Enable QCOM_RPMH_POWER_DOMAIN config for qualcomm devices
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v8:
> - No changes to this patch in v8

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> v7:
> - No changes to this patch in v7
> 
> v6:
> - No changes to this patch in v6
> 
> v5:
> - No changes to this patch in v5
> 
> v4:
> - No changes to this patch in v4
> 
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done
> 
> v2:
> - No changes to this patch in v2
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index fe5880de1fd..bced5d6eb0f 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -126,6 +126,7 @@ CONFIG_MSM_SERIAL=y
>  CONFIG_MSM_GENI_SERIAL=y
>  CONFIG_SOC_QCOM=y
>  CONFIG_QCOM_COMMAND_DB=y
> +CONFIG_QCOM_RPMH_POWER_DOMAIN=y
>  CONFIG_QCOM_RPMH=y
>  CONFIG_SPMI_MSM=y
>  CONFIG_SYSINFO=y
> -- 
> 2.34.1
> 
