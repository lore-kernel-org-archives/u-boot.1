Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44820CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833A284704;
	Tue, 16 Jun 2026 14:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hCwiWuut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD488484C; Tue, 16 Jun 2026 14:55:40 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D003846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68c3421b009so8400667a12.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614538; x=1782219338; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vX8SXtMSPoXV9W194BmtY9MECNwS8erDc+M4lW+4KYE=;
 b=hCwiWuut/utCgOM/lhtBTHYqQLsnWatf6MpHGwZBg2KFAV42psuSaDkvGCiJ0eyL3y
 mmTdKuwg8/QybqNXmyLf3t3vm+KT6D3btIj7R3auFXUX8o6uE8R2UYjQ4hKTi5+of6n1
 VubLMNPNNR6s7qp5asQxWjEsGgs0yoWPON6rrcb/3WlkIwREsDczIaebDScQIcXFR4oP
 +bQ2LRI0vMr7KBmbqI2Yav/f2IX514/pa9AJFjdgxexl5+5wYzFZV3d3XD+p3XTQZOsO
 bp3V70NB2wO4+KVVyF3s/NxgP30lnC0BdQyLbx7/ApqhUougVSf1n7xsPOHSDJAltSFl
 7ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614538; x=1782219338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vX8SXtMSPoXV9W194BmtY9MECNwS8erDc+M4lW+4KYE=;
 b=iOeArFvbjBcxSSRJjzTRHxvkLSDpZt7hYUU+atDwFtQwnAXH1v8lhiuj837FROcjyc
 sbDJgfPhdan50D/U5/XwmUOqg+b3g02ymbBECIdqgO6EeBStV1LJqDkzAr13Ni0bxmU1
 8IeGIig6nmodRhPL/ZYiKV/abuzudeuCPRj/F+NariSx2+MsXrHqt1FC9m8fhgzhLArb
 Mf2+PLnUlghPShnOlj6DQyrnI1kh9t5+GilAQDZ/4/PuDAZi7Qn38RWPZPsSE5B4YD0+
 UQ242OQJ29LcuVgC1hTV8XN0hCX3D7bw015gFoj4PHUzoo0H7LnhIhhZPi1FwT1o9rUF
 PPkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lZdyRP3DJAnwe18LckZWfcIIXczQIDa60DB7Jzf71/rPluGJSlaKwiRuem1z4TX7sxFDFwzA=@lists.denx.de
X-Gm-Message-State: AOJu0YzUlCWWIuMR/8NIB2OSrKO5L9qYtwO2RRGJgL5q+gaUgQjjSn9F
 rXFDPHAz6ikXbG52owvt+VnKwqe0zCNcwPvTPwndi/QO3R+dFzMGqLAWUc5uI3JA3mA=
X-Gm-Gg: Acq92OEs042Td0KaoLBdSxai1B1Pwy+5qhzdwMl2yXht7U4qo8zqtG8/BKPHVRvdB04
 k6dDOCJ/VLTOLQKk4BWG8hW1/blSxm+B3+khzlfm1e5HK3B6io4bQO6Bc2QsnLl+Xvn92bcJ90n
 BFllClJK9evkeZpFfofyaWxgI+wXfGJUyItCfRarKF1eSGRT84dlIcAWIBXsghTZ1Em/4YIorQI
 yZf643vMA0YiJQdkLPIWtRUSdk0Pb6w81WNXUY8EmdIetEyAtMVGnQhnL1funw7X55wBDYy2Oxr
 kuzFa8abbctTXLlUu2PnCfj4kHkg5+Q1B8Sr31mLBrbIeN9gECsiHOFdtSauS7NY8MXaeR4/ZI/
 QhhFlC8bULYOUfQMD+iH5Yu7pC5WVZ842b53pWKGzA3+IlrPKCl/2VCM3mLJjMe4NZO3KsdATtx
 80mFYcsl7U4DV/SFjM1EjwqMiytJ2B4YfHHrFISW1V/vXvjYQfSeY6vUS7kmMKDPZDIy8VPLuyC
 g==
X-Received: by 2002:a17:907:75d2:b0:bf2:cd2b:dc47 with SMTP id
 a640c23a62f3a-c04175ab7a4mr152470066b.21.1781614538010; 
 Tue, 16 Jun 2026 05:55:38 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4b22136sm660244066b.15.2026.06.16.05.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:55:37 -0700 (PDT)
Message-ID: <e52af51c-1f2e-4855-8d94-2d370ad757a0@linaro.org>
Date: Tue, 16 Jun 2026 14:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] soc: qcom: cmd-db: Allow boot without CMD DB data
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <20260616-sngboot-v3-5-6fb0dee8125c@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616-sngboot-v3-5-6fb0dee8125c@oss.qualcomm.com>
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

Hi Balaji,

On 16/06/2026 11:22, Balaji Selvanathan wrote:
> In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
> The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
> boot even when CMD DB is not strictly required.
> 
> Add QCOM_COMMAND_DB_OPTIONAL config to allow the driver to bind
> successfully when CMD DB data is absent. When enabled, a warning is
> logged and cmd_db_header is set to NULL, so consumer drivers receive
> errors on resource queries rather than preventing boot entirely.

Since we know we're in snagboot mode, as I mentioned before we don't
need this additional option, just check for CONFIG_QCOM_SNAGBOOT_MODE
instead rather than introduce another footgun.


> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
>   of #ifdef
> 
> Changes in v2:
> - No changes
> ---
>  drivers/soc/qcom/Kconfig  | 18 ++++++++++++++++++
>  drivers/soc/qcom/cmd-db.c | 14 ++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8243805e46a..7f4cf1b9a98 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -18,6 +18,24 @@ config QCOM_COMMAND_DB
>  	  resource on a RPM-hardened platform must use this database to get
>  	  SoC specific identifier and information for the shared resources.
>  
> +config QCOM_COMMAND_DB_OPTIONAL
> +	bool "Allow operation without Command DB data"
> +	depends on QCOM_COMMAND_DB
> +	help
> +	  Allow the Command DB driver to bind successfully even when CMD DB
> +	  data is not populated or has an invalid magic number.
> +
> +	  This is useful for platforms where CMD DB is not populated by the
> +	  previous bootloader (e.g., snagboot mode where XBL loads U-Boot
> +	  directly without initializing CMD DB).
> +
> +	  When enabled, missing CMD DB will generate warnings but allow boot
> +	  to continue. Consumer drivers must handle cmd_db API failures
> +	  gracefully by checking return values.
> +
> +	  If unsure, say N. Most production Qualcomm platforms require
> +	  valid CMD DB data.
> +
>  config QCOM_RPMH
>  	bool "Qualcomm RPMh support"
>  	depends on QCOM_COMMAND_DB
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index d0a6047b8a6..9b5091f5b5a 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
>  
>  	cmd_db_header = base;
>  	if (!cmd_db_magic_matches(cmd_db_header)) {
> -		log_err("%s: Invalid Command DB Magic\n", __func__);
> -		return -EINVAL;
> +		if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL)) {
> +			log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
> +				    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
> +				    cmd_db_header->magic[2], cmd_db_header->magic[3]);
> +			log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
> +				    __func__);

You can drop these warnings if snagboot mode is enabled since that's the
expected case. I think it would be more appropriate to log a warning if
snagboot is enabled and we DO have a valid cmd-db, since that isn't an
expected usecase right?

Kind regards,

> +			cmd_db_header = NULL;
> +			return 0;
> +		} else {
> +			log_err("%s: Invalid Command DB Magic\n", __func__);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return 0;
> 

-- 
// Casey (she/her)

