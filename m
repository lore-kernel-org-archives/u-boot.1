Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0139DD37480
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9FD88E9F;
	Thu, 17 Oct 2024 14:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729168272;
	bh=Z5a/TJoMs/fEaeMqT8T3EyPap/uu6YvRQ4j2UpAH+AU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AM84r7qAfJ/R0PLdGNZU4K5E7PMlhGnCh+ZLRHCuvbL7w8NoPODedt9ZEntPTiu82
	 c5PeK6P/BdNPHJm7MeM98HJkEqtq7ImDv66W+JSpRc4VarKCz07NXXokleNUEoKox8
	 LzCIgsua692miRrf1qZsKH5JlzfrOTlxjoPEShbaz0OG7bGL214sKbjCcVFFyim0wj
	 ycBRFx6FeK6CMwuS71YI2Jh/YeCZsFixdRLlRxZk3Zwsvp4Y0BtqwbaCH4q0qgb3cm
	 BEbInKnZX0RTLLkTEoUvJv4jsBNESisGTV/3zgx3NJoW8QgBEo6q6PqZm+LHuMOvNy
	 NS8Nuh8kuj86A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A218788D1B;
 Thu, 17 Oct 2024 14:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729168271;
 bh=Z5a/TJoMs/fEaeMqT8T3EyPap/uu6YvRQ4j2UpAH+AU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N0s/tD0tLj9XE3+fEIodXzdg9fj4lfgop6biKiaL2lL8wgh4OXLBCE/h7RcB6LP7c
 u1JmrDJZPwN/PuoCurOIY+ypEGspmJk74Pmk2ajidSCvIiW/EzL3b514AJ7BihGrgD
 hKh1KOvDf8cVgJXoYPZzkvuRrrvuseSK+ue13vW3/+DG6HUy8tQOIdRU2eJ9REvsU+
 g7wWzN8VOzRmLG7Uc6ysdVOHFHIB2M4ilaa/EQD5jQRvSGZtP1mqVOamr/5qeQPgmu
 5h7tnmc0tNwSWWoTJIIfPwXGZ8TSOVSFtlAg5dXyCWfCmjpXY/59lANQWiIgodwQ0K
 zKTQW6HQeLY0g==
Message-ID: <75c97fa4-393f-4a9a-8638-81522bcef4f7@denx.de>
Date: Thu, 17 Oct 2024 14:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] imx: hab: rename imx_sec_config_fuse_t to
 imx_fuse_t
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, sbabic@denx.de,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, eduard@lionizers.com, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, u-boot@lists.denx.de
Cc: martijn.de.gouw@prodrive-technologies.com
References: <20241017075049.3959440-1-paul.geurts@prodrive-technologies.com>
 <20241017075049.3959440-2-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241017075049.3959440-2-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/17/24 9:50 AM, Paul Geurts wrote:
> The imx_sec_config_fuse_t structure is not specific to the sec_config
> fuse, but can be used for all fuse words.
> 
> Rename the structure to a more generic name to be reused for other
> fuses.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>   arch/arm/include/asm/mach-imx/hab.h | 4 ++--
>   arch/arm/mach-imx/hab.c             | 4 ++--
>   arch/arm/mach-imx/imx8m/soc.c       | 2 +-
>   arch/arm/mach-imx/mx6/soc.c         | 2 +-
>   arch/arm/mach-imx/mx7/soc.c         | 2 +-
>   arch/arm/mach-imx/mx7ulp/soc.c      | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach-imx/hab.h b/arch/arm/include/asm/mach-imx/hab.h
> index 2abf28ea45bc..52cd8aff87e1 100644
> --- a/arch/arm/include/asm/mach-imx/hab.h
> +++ b/arch/arm/include/asm/mach-imx/hab.h
> @@ -132,13 +132,13 @@ enum hab_target {
>   	HAB_TGT_ANY		= 0x55,
>   };
>   
> -struct imx_sec_config_fuse_t {
> +struct imx_fuse_t {
Please drop the _t suffix from it, otherwise it resembles all those 
downstream typedef struct {} stuff_t; constructs.

Thanks !
