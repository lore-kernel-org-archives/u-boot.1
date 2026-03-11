Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80BFD0623
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 06:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B5283F93;
	Wed, 11 Mar 2026 07:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="IRwptQLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FF983F9A; Wed, 11 Mar 2026 07:35:03 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649F983F6D
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-38-208-15.ip72.fastwebnet.it [93.38.208.15])
 by mail11.truemail.it (Postfix) with ESMTPA id EEFC61FFF4;
 Wed, 11 Mar 2026 07:34:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1773210899;
 bh=xLIyIIeh3W15ex4zhbNz8ylut6e1FeFrLcPyqBYOJA0=; h=From:To:Subject;
 b=IRwptQLsMFZG5GrtvmtpUcjqq6JGIJ570MQqHsokFhf4ubLvmd1q72plBH6yaJoNu
 yHAdYSjJZX1kh9f2OhW/imbY0va26QdjETT2PKVpmyCgEETi4W2wWsFQql2OC0xp14
 iXWblUM3kRRA4fG2yLXU15gxgU+qQMz1WWr3ba0OpUVwwn3yiJEMiZiwbls2pef85F
 rIdRKwSWzt3+zvZT/IaDZzpUZq941zPGz7ATAHLyiKNPsEOZtoyftKdo/kAwv8L6lU
 iSqqMpKz9DiDcJYTrESv8yacFwapaRxj/A1hltBcmp3gr404wl1bhBNiB3dpCjEZWR
 x9ru5oipd1RiA==
Date: Wed, 11 Mar 2026 07:34:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Suhaas Joshi <s-joshi@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
Message-ID: <20260311063454.GA9300@francesco-nb>
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
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

On Tue, Mar 10, 2026 at 02:36:27PM +0530, Anshul Dalal wrote:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

...

> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb96..ba1130a7996 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
>  	  The load address for the ATF image. This value is used to build the
>  	  FIT image header that places ATF in memory where it will run.
>  
> +config K3_ATF_RESERVED_SIZE
> +	hex "Reserved DDR size for ATF"
> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> +	default 0x20000

This means that J784S4 has 0x20000? Is this wanted?

Francesco

