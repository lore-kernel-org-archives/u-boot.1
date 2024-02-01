Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B66C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 11:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1852887C68;
	Thu,  1 Feb 2024 12:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372B187C32; Thu,  1 Feb 2024 12:40:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 965A787C68
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 12:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77EECDA7;
 Thu,  1 Feb 2024 03:41:23 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.91.83])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49FC53F762;
 Thu,  1 Feb 2024 03:40:38 -0800 (PST)
Date: Thu, 1 Feb 2024 11:40:30 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/3] firmware: psci: Fix bind_smccc_features psci check
Message-ID: <20240201114030.GA112745@e130802.arm.com>
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-2-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131141426.34926-2-o451686892@gmail.com>
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

> -	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) ==
> +	if (request_psci_features(ARM_SMCCC_VERSION) ==
>  	    PSCI_RET_NOT_SUPPORTED)
>  		return 0;
>  
> +	if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSION_1_1)
> +		return 0;

It makes sense to me, thanks.

> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f44e9e8f93..da3d29aabe 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -55,8 +55,14 @@
>  #define ARM_SMCCC_QUIRK_NONE		0
>  #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
>  
> +#define ARM_SMCCC_VERSION		0x80000000
>  #define ARM_SMCCC_ARCH_FEATURES		0x80000001
>  
> +#define ARM_SMCCC_VERSION_1_0		0x10000
> +#define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
> +#define ARM_SMCCC_VERSION_1_3		0x10003

Apart from ARM_SMCCC_VERSION_1_1, are the other ARM_SMCCC_VERSION_1_x defines needed ?

Cheers,
Abdellatif
