Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6273FF8864
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 06:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7D1803C6;
	Fri,  1 May 2026 08:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kN7zbhlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8976C83A91; Fri,  1 May 2026 08:58:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EA680086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FFB340A2E;
 Fri,  1 May 2026 06:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A083C2BCB7;
 Fri,  1 May 2026 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777618724;
 bh=4g1wGcE42u4KPdptz5IiVBtrFrhL0jqt4kjFBXy0KSg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kN7zbhlIoKGCbPNbtqDzbNfTuctbLLZqcFjr8G40snkVe5LW4whPOMd8Aa/EwOOGZ
 qZJf3mUmKepJc8sAK9p5omFzIZWYuajFX6kLklFz7phTZu0V+b3UGXn+GkePYORbY6
 7e9RuqILEktm4yC+oHkULMEL5uc/kFceKfaV6fq3f6XCpIDrwLvaQp0V8pWHmq/pwK
 D+UbWq7agQDh+wDKcFco/+hClCnzrmMyYIm4zTQnNmNIXDzpt8ZkDkwLqch3l/hjTi
 qcrZPq68hkSNRhKwwWrd3Aw9gtF7zH4/qmodviSe6WVTc9hFobadNEJw2ffLNwzWw/
 5lh8F+x/4T3kQ==
Date: Fri, 1 May 2026 12:28:35 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
Subject: Re: [PATCH v2 3/3] configs: qcom_defconfig: Limit MMC transfer size
 to prevent controller timeout
Message-ID: <afRPG3rb-Dh3aTPw@sumit-xelite>
References: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
 <20260421-emmc-v2-3-0ebd3322b676@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-emmc-v2-3-0ebd3322b676@oss.qualcomm.com>
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

On Tue, Apr 21, 2026 at 06:30:10PM +0530, Balaji Selvanathan wrote:
> Set CONFIG_SYS_MMC_MAX_BLK_COUNT to 16384 blocks to limit the
> maximum transfer size per operation. This prevents controller timeouts.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Set CONFIG_SYS_MMC_MAX_BLK_COUNT to deal with controller timeout.
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index baad5f09455..315107fd279 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -96,6 +96,7 @@ CONFIG_MISC=y
>  CONFIG_NVMEM=y
>  CONFIG_QCOM_GENI=y
>  CONFIG_I2C_EEPROM=y
> +CONFIG_SYS_MMC_MAX_BLK_COUNT=16384
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ADMA=y
>  CONFIG_MMC_SDHCI_MSM=y
> 
> -- 
> 2.34.1
> 
