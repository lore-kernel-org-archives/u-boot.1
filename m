Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB97CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473DD849A1;
	Wed, 17 Jun 2026 15:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FdkBiYnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF28849A3; Wed, 17 Jun 2026 15:54:24 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5018460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so39897575e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704461; x=1782309261; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3jfGdPfO2h7OJi7nYmJzMTVky5PoWrFvcTnw5HMW20=;
 b=FdkBiYnxkBgg0vzU8Y9k1GLxbOtACP25Iou9j3vZ12QKSvmiW8QWCFUI4zOIT0SkfD
 8FIYmQ6PlcF5RWqlDaVfQ5lqqU5ntaxZBZTN72S/cRrNHgqh9jAQ8K3RayqCq1Dcsv8h
 GKb49zzKROwk41wtKITaEBOgEOdFQOhfCufSJcOAFkidvDfGrDdFn6ByHXUs0J1IUCxO
 JNjfrk8hnYwENroZbir6JBYZFPz0riumjffBaZ0IDy5UpTagy2uVwtQdwsMKR1+w3vST
 V8cEFddx3dCmYyNGxUknsXZYieUZi7b9Qo/HcxAelGu7T0KPGLT/UJXF0iVD323EXIR+
 w26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704461; x=1782309261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3jfGdPfO2h7OJi7nYmJzMTVky5PoWrFvcTnw5HMW20=;
 b=Smpa/safth0qbOpy2WZE0zmorPB+X2jqTLeMu3aNbBSWvIzfG3FlgtSc+prlBuQZ33
 IX7LLE6AD6JkbkhI1LtvFMg+AbCewTTlPaMnAS2wJzzx7BxyUyGJdZQ/m63n5cB1aecW
 RzTm+rnU+nNCB+Vv0REP8jjO1UamIjewdbVchmkl6901HY1ekKOSEI9LulflKXjW3V3h
 ydylJx3Lca0d4Le4GwgdTCg5QDgEpOsktLmfMjdvFvNonEl7nTLJhB19lZMlPKOt7s68
 zCtjm9QB52nydCdsWaZMvAeQ/KEqBTPTCXw/w/MSm3HnsENsLmAfAMojSOMZFD29YSNA
 ZBqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AR+Q79bmtuLZOetWlqMWjoYpbQsgHfWLoaWEtPMHu9B79ninylea8lxF9lfsBeM1+Tl2hWM8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfv4eS6Txmfs5RuPIjmyD5glsTk/+tKApEVP/qx8Jsr0BL9mLE
 /t+LDDv5JoM1p6nqlcb4y1YeDT+ovCpT1nkdT2HMNOt/On/MxwEzPtXthV0HEeDU4Zk=
X-Gm-Gg: Acq92OFDpFnpse41fIbzHZFvSV0N+1t9HwGJxQ9DtMUUn2EaG/NgimOk6Dva6MT82CA
 WA0Q0dGYm6as5sPYLwyAxez6/afv8rq/PwOR8wPpHIeA+HFh3Zn3G/eltQ5J/Wvzb6RodWi39pQ
 Fdi4iiBf3S6q3Us88iqvAOnPcz31zzOOsI7y0860nsuw/hQhPNIISpPWUT8CsrQwhQ3ESsICkBX
 bRNQsTc1g6Re+cGmJefFRrKkUKO8oJyVi39npGNlWBUHC9qK8erfk4dmCnsU2CiwhFtpk2Hdyzo
 xKKWhi/EfAqzkD/OdB84MaSeePslsDgq1SuNqurle+mXqpuGAsBVcbW6ff8e7UHIwDUwa9r9mU6
 b24LMDN2yM9SEcj+T5I/BW6MfkLsLUG/7maO61a4ajkvdgnn0dllPiH8dGXULxTkodwRkhKfT6Q
 3MYo3jOEqk+YPpx6BdUK67G7y5B9HsROqCl4jwF9zaep2qAQSwfXHa
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id
 5b1f17b1804b1-49234141d98mr38640875e9.33.1781704461329; 
 Wed, 17 Jun 2026 06:54:21 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923685fe90sm12233495e9.1.2026.06.17.06.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:54:20 -0700 (PDT)
Message-ID: <cde1560d-48d3-4e60-8836-79e9d2a74ef8@linaro.org>
Date: Wed, 17 Jun 2026 15:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] button: qcom-pmic: introduce exported setup method
Content-Language: en-US
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-1-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-1-170c9cbe5099@samcday.com>
Content-Type: text/plain; charset=UTF-8
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



On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> The qcom_pwrkey driver is currently binding to both the individual
> pwrkey/resin nodes, as well as the parent pon node.
> 
> In the next commit, a new glue driver will be introduced for pm8916_pon,
> which will continue binding these buttons, as well as additional
> drivers.
> 
> button_qcom_pmic_bind was renamed to button_qcom_pmic_setup and exported
> in a shared header, which the new pm8916_pon driver will call.
> 
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/button/button-qcom-pmic.c |  6 +++---
>  include/button/qcom-pmic.h        | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index b823490d6d5..d9ac6a51df5 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -13,9 +13,9 @@
>  #include <dm/lists.h>
>  #include <log.h>
>  #include <power/pmic.h>
> -#include <spmi/spmi.h>
>  #include <linux/bitops.h>
>  #include <time.h>
> +#include "button/qcom-pmic.h"
>  
>  #define REG_TYPE		0x4
>  #define REG_SUBTYPE		0x5
> @@ -174,7 +174,7 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static int button_qcom_pmic_bind(struct udevice *parent)
> +int button_qcom_pmic_setup(struct udevice *parent)
>  {
>  	struct udevice *dev;
>  	ofnode node;
> @@ -227,7 +227,7 @@ U_BOOT_DRIVER(qcom_pwrkey) = {
>  	.name = "qcom_pwrkey",
>  	.id = UCLASS_BUTTON,
>  	.of_match = qcom_pwrkey_ids,
> -	.bind = button_qcom_pmic_bind,
> +	.bind = button_qcom_pmic_setup,
>  	.probe = qcom_pwrkey_probe,
>  	.ops = &button_qcom_pmic_ops,
>  	.priv_auto = sizeof(struct qcom_pmic_btn_priv),
> diff --git a/include/button/qcom-pmic.h b/include/button/qcom-pmic.h
> new file mode 100644
> index 00000000000..d321bbab460
> --- /dev/null
> +++ b/include/button/qcom-pmic.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include <dm/device.h>
> +#include <linux/errno.h>
> +
> +#if CONFIG_IS_ENABLED(BUTTON_QCOM_PMIC)
> +/**
> + * Binds the qcom_pwrkey driver to compatible pwrkey/resin child nodes
> + * belonging to @parent
> + */
> +int button_qcom_pmic_setup(struct udevice *parent);
> +#else
> +static int button_qcom_pmic_setup(struct udevice *parent)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> 

-- 
// Casey (she/her)

