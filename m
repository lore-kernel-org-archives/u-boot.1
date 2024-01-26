Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A55C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 11:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4529787B6C;
	Fri, 26 Jan 2024 12:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143C687B8C; Fri, 26 Jan 2024 12:20:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CA45A87866
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 12:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C8E1FB;
 Fri, 26 Jan 2024 03:21:23 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.87.248])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7463F762;
 Fri, 26 Jan 2024 03:20:36 -0800 (PST)
Date: Fri, 26 Jan 2024 11:20:28 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 u-boot@lists.denx.de, nd@arm.com
Subject: Re: [PATCH 1/3] firmware: psci: Fix bind_smccc_features psci check
Message-ID: <20240126112028.GA62785@e130802.arm.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-2-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125140502.22400-2-o451686892@gmail.com>
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

Hi Weizhao,

On Thu, Jan 25, 2024 at 02:05:00PM +0000, Weizhao Ouyang wrote:
> According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
> whether the SMCCC is implemented by discovering SMCCC_VERSION.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  drivers/firmware/psci.c   | 2 +-
>  include/linux/arm-smccc.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c6b9efab41..894be8128d 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
>  	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) == 0)
>  		return 0;
>  
> -	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) ==
> +	if (request_psci_features(ARM_SMCCC_VERSION) ==
>  	    PSCI_RET_NOT_SUPPORTED)
>  		return 0;

I suggest we add checks on the SMCCC version like this:

    if SMCCC_VERSION >= 1.1
       assume SMCCC_ARCH_FEATURES is supported
       discover arch features and bind drivers/devices
    else
       error


For more details [1][2].


[1]: SMC Calling Convention 1.5 (https://developer.arm.com/documentation/den0028/latest/)

SMCCC_ARCH_FEATURES MANDATORY from SMCCC v1.1

The implementation of this function can be detected by checking the SMCCC version. This function is mandatory
if SMCCC_VERSION indicates that version 1.1 or later is implemented.

[2]: Linux checks SMCCC v1.1: https://elixir.bootlin.com/linux/latest/source/drivers/firmware/psci/psci.c#L597

Cheers,
Abdellatif
