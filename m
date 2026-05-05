Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0766FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 610FD8487C;
	Tue,  5 May 2026 12:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3prvawr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6A584885; Tue,  5 May 2026 12:27:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E47B8486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E93AB43675;
 Tue,  5 May 2026 10:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14EFC2BCB4;
 Tue,  5 May 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777976819;
 bh=8r9kBMhNzlsNgWaoAdLp0az3Fsa/V5ibR4qadUsoYKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F3prvawrIRmhfbqVIr5rTyPGFPJrGxuWpnEJrIZCqcdNg5UwoKlAok/ZdYJxp7GSX
 wpGGYJDm2Ee6uBQFhfDHOXthjgVVSnXGRazFiUb1RB8t/m4+HAUO0TDdVc+7deFhdj
 0jYC2/9ToXqEtfImM1277iu6qIu9Lx8FExOl/BlMyiXihBRpdXGcYRhxXJXzb9Twij
 T2GUoBD4ipKw2SGUe7UTZA5mWp7m8Ult2VCNysGZyCrUXEKheyoRkl9xASJ0W/xM95
 2qsaQ/0ClVcG6r5w2tNYGqt8s22GlXTAVI3dMjuT9J1SaxTxHTNMnhTuIwYaLOEWnR
 z0DVGuN4jQsCA==
Date: Tue, 5 May 2026 15:56:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/15] Revert "drivers: smem: sandbox"
Message-ID: <afnF6YenyJ5__WV4@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:32PM +0200, Casey Connolly wrote:
> This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/sandbox/dts/test.dts   | 4 ----
>  configs/sandbox64_defconfig | 2 --
>  configs/sandbox_defconfig   | 2 --
>  3 files changed, 8 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index ac92ebf1afd7..50201ad61ccd 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1521,12 +1521,8 @@
>  		compatible = "sandbox,scsi";
>  		sandbox,filepath = "scsi.img";
>  	};
>  
> -	smem@0 {
> -		compatible = "sandbox,smem";
> -	};
> -
>  	sound {
>  		compatible = "sandbox,sound";
>  		cpu {
>  			sound-dai = <&i2s 0>;
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 60a30d048750..53f7af4270af 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -240,10 +240,8 @@ CONFIG_SANDBOX_RESET=y
>  CONFIG_DM_RTC=y
>  CONFIG_RTC_RV8803=y
>  CONFIG_SCSI=y
>  CONFIG_SANDBOX_SERIAL=y
> -CONFIG_SMEM=y
> -CONFIG_SANDBOX_SMEM=y
>  CONFIG_SOUND=y
>  CONFIG_SOUND_SANDBOX=y
>  CONFIG_SOC_DEVICE=y
>  CONFIG_SANDBOX_SPI=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index f26295103f1c..7f26405e6ed0 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -331,10 +331,8 @@ CONFIG_RTC_RV8803=y
>  CONFIG_RTC_HT1380=y
>  CONFIG_SCSI=y
>  CONFIG_SANDBOX_SERIAL=y
>  CONFIG_SANDBOX_SM=y
> -CONFIG_SMEM=y
> -CONFIG_SANDBOX_SMEM=y
>  CONFIG_SOUND=y
>  CONFIG_SOUND_DA7219=y
>  CONFIG_SOUND_MAX98357A=y
>  CONFIG_SOUND_SANDBOX=y
> 
> -- 
> 2.53.0
> 
