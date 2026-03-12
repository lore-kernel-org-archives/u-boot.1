Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E3FED2DD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95A984119;
	Thu, 12 Mar 2026 08:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="scmtXMwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82B88410C; Thu, 12 Mar 2026 08:50:24 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDCA83F8A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5192243EBB;
 Thu, 12 Mar 2026 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04443C4CEF7;
 Thu, 12 Mar 2026 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301821;
 bh=WTLc2XEFfEbpd0DhhNJra+0n0YJopANftWgx8GonSMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=scmtXMwyuyt1Rv7baOsMiaWlBrBPYljH9ByvTkpFMaFWBVnR6xcqsirwZXjlxtyr3
 yOhLIAJzP9eA3CEY7nNVsHLt2+NL5H7Axo4PE6F+9B13WhsXqfUSuY9jGZOEzn6le0
 REtdiIXm/92WyMYSFKYEboJYaqDxMW1N9G5wAZypnz58VrSj88WFnAoWPQo/7rTpql
 EU8JaSZOFHvqyp34IiJLrn/xBCRpMf0hgHm263OJnmnzS1tm48MuUY8pqoJQglf5LC
 9JQDQnS7TrMNFXDtp1zUu9n64VmBZLMhs0Vs0m6YJwK/bHdLRrKOM+CygooWduSTjH
 yQkwRbwf/g0GA==
Date: Thu, 12 Mar 2026 13:20:12 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 6/7] qcom_defconfig: Enable Milos clock driver
Message-ID: <abJwNFz1Ul1PTZXS@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-6-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-6-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:46PM +0100, Luca Weiss wrote:
> Enable the driver so that Milos devices can boot with qcom_defconfig.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index fe5880de1fd..44c1cef725c 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -56,6 +56,7 @@ CONFIG_CLK=y
>  CONFIG_CLK_STUB=y
>  CONFIG_CLK_QCOM_APQ8016=y
>  CONFIG_CLK_QCOM_APQ8096=y
> +CONFIG_CLK_QCOM_MILOS=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_QCS615=y
> 
> -- 
> 2.53.0
> 
