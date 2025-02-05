Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD911C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A05A807A7;
	Wed,  5 Feb 2025 18:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="as+TctxB";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="TBmWG8k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D3A807C0; Wed,  5 Feb 2025 18:24:03 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A569480104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=as+TctxBn4gRWaq0RW+brfiYbNNrmwVJLIWP6YroUj43f1OLGyQRoQnPdyJSgtTyiNG3tL41yNhMeR7xOaGZzBwp+mv0q+gUllqkB028T5bG2LWgKc/+aeVso5FYpe/WVCSTssk2TnsK8nfT0vbjEoVeVoq3YQz2QoH+/jEdXaK7MrBYaUUonde6kQCX+qEoy+BtcYBeb/pTb/2hvodt21+1PbiUUYNfemYARKJp2gm6wrqG9YWMXXq2iLrEgEjgmbi3mTGe61WUW1++tkB9aeeeIOdDLBXTV9a3bXqEK8ZRtw3o44q8+fbam0qGrdwPne+C9vKbAsBVJZVCiL8g3g==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=eoXZT3sjAIKSLIhkzFxR0vFw9gJODi2HBesK0OtfuT0=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=TBmWG8k9qEr+yQQxdbLDAgDCMVhrMwZbho7ED4iYCzz43x1H66mMaIiURGQofrQHCAdzSztoAm4nr6CHoUcJMXSftbDNwg2F5oKf/jDaKsfrmSYOqGfg1BuGq1UFuiGVqkyoAEk/mAR7c/wLA3fpAsHqhYzQmwVggy0GN9SBx54AAMK3AOrN6oDK7TooZsrgPlDeIXjKyGabCfiyOLeA5kuwf0DTyZNtt9AEE2YFZwZBuZxUKijAlEEfFMa8YqofTxbplwr+F4cvNJUfTAJvAsW77RAxVPmHSys0gLyzri2mVGeor78Ku1M2eBRNtIGn0BO1MbPFyXJdCBvYrlcU3g==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=eoXZT3sjAIKSLIhkzFxR0vFw9gJODi2HBesK0OtfuT0=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1069561944
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:23:58 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so9571228a91.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:23:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXEIClFP8TCGnF1jvdYGGlHCUYvk38whPKzNDrwJCXyFMrmmS8NxBAIg/4phlcPlTrJIdc13Y4=@lists.denx.de
X-Gm-Message-State: AOJu0YyKqu5YnSroX8dfo9U8qYbP17wKk1/BPVcm5kQGW/zUhdlbQSaA
 KByjANGnUIrGV5U/IjaDC/hZMxiXX7ureRrJClZ0WFE3hYBBc/Qzpd6ZW6mMCQ2i8Kcu4VAu28J
 nJw7Hfx0MPiWvbfuA8o6lxBBaDIM=
X-Google-Smtp-Source: AGHT+IHXEBxiplJ4zUTtK+picI++YMxmLGtj/UprCYIDln8vakNNUi2+RkDauWOONQn6+rCqKUV8AlCl3XcIW111YsY=
X-Received: by 2002:a17:90a:d605:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2f9e08625d2mr4835158a91.32.1738776238069; Wed, 05 Feb 2025
 09:23:58 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:23:57 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Feb 2025 17:23:53 +0000
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-4-justin@tidylabs.net>
 <fd8e76dd-f26d-40e4-b16e-893e670e217d@cherry.de>
In-Reply-To: <fd8e76dd-f26d-40e4-b16e-893e670e217d@cherry.de>
From: Justin Klaassen <justin@tidylabs.net>
Date: Wed, 5 Feb 2025 17:23:57 +0000
X-Gmail-Original-Message-ID: <CAK2wXt=O=XTe6S3OaEhGGoXnO7LFUFSOnnpyYOd4aXt0DQXYJQ@mail.gmail.com>
X-Gm-Features: AWEUYZm30WPX7PfUA-tUupCR_KLHfsn_qX2ZtyHb7nD-Flvk-n3g982akKPVUBc
Message-ID: <CAK2wXt=O=XTe6S3OaEhGGoXnO7LFUFSOnnpyYOd4aXt0DQXYJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Keerthy <j-keerthy@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 William Wu <william.wu@rock-chips.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Hi Quentin,

On Feb 4, 2025 at 09:30:33, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Justin,
>
> On 1/28/25 10:37 PM, Justin Klaassen wrote:
>
> Allows use of the regulator functions of the RK8XX PMIC in SPL, which is
>
> necessary to support the functionality of the Rockchip IO-domain driver
>
> on relevant platforms.
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
> ---
>
>
> Changes in v2:
>
> - Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig
>
>
>   drivers/power/regulator/Kconfig | 9 +++++++++
>
>   drivers/power/regulator/rk8xx.c | 8 ++------
>
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
>
> diff --git a/drivers/power/regulator/Kconfig
> b/drivers/power/regulator/Kconfig
>
> index 958f337c7e7..9b50128f859 100644
>
> --- a/drivers/power/regulator/Kconfig
>
> +++ b/drivers/power/regulator/Kconfig
>
> @@ -241,6 +241,15 @@ config REGULATOR_RK8XX
>
>    by the PMIC device. This driver is controlled by a device tree node
>
>    which includes voltage limits.
>
>
>
> +config SPL_REGULATOR_RK8XX
>
> + bool "Enable driver for RK8XX regulators in SPL"
>
> + depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
>
> + help
>
> +  Enable support for the regulator functions of the RK8XX PMIC in SPL.
> The
>
> +  driver implements get/set api for the various BUCKS and LDOs supported
>
> +  by the PMIC device. This driver is controlled by a device tree node
>
> +  which includes voltage limits.
>
> +
>
>   config DM_REGULATOR_S2MPS11
>
>    bool "Enable driver for S2MPS11 regulator"
>
>    depends on DM_REGULATOR && PMIC_S2MPS11
>
> diff --git a/drivers/power/regulator/rk8xx.c
> b/drivers/power/regulator/rk8xx.c
>
> index 368675ebb9f..88453bb7bdb 100644
>
> --- a/drivers/power/regulator/rk8xx.c
>
> +++ b/drivers/power/regulator/rk8xx.c
>
> @@ -16,10 +16,6 @@
>
>   #include <power/pmic.h>
>
>   #include <power/regulator.h>
>
>
>
> -#ifndef CONFIG_XPL_BUILD
>
> -#define ENABLE_DRIVER
>
> -#endif
>
> -
>
>   /* Not used or exisit register and configure */
>
>   #define NA 0xff
>
>
>
> @@ -202,7 +198,7 @@ static const struct rk8xx_reg_info rk818_buck[] = {
>
>    { 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL,
> REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>
>   };
>
>
>
> -#ifdef ENABLE_DRIVER
>
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>
>   static const struct rk8xx_reg_info rk806_nldo[] = {
>
>    /* nldo 1 */
>
>    {  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA,
> RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
>
> @@ -454,7 +450,7 @@ static int _buck_set_enable(struct udevice *pmic, int
> buck, bool enable)
>
>    return ret;
>
>   }
>
>
>
> -#ifdef ENABLE_DRIVER
>
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>
>   static int _buck_set_suspend_value(struct udevice *pmic, int buck, int
> uvolt)
>
>   {
>
>    const struct rk8xx_reg_info *info = get_buck_reg(pmic, buck, uvolt);
>
>
> I would split the modification of the c file into a separate patch as
> the addition of the symbol and the modification of the C file aren't per
> se co-dependent.
>
> Their order wouldn't even matter in that case.
>

My preference was to keep these changes together. Without the modification
to the C file, enabling CONFIG_SPL_REGULATOR_RK8XX would not have the
expected behavior since most of the driver code would still be disabled. If
you feel strongly otherwise, I am happy to split into separate patches.


> In any case, looks good to me so:
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
>
>
Thanks,
Justin
