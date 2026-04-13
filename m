Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5A8F34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 12:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D74839DF;
	Mon, 13 Apr 2026 14:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IVlY2tct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7518684181; Mon, 13 Apr 2026 14:28:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7B1839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso68612845e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776083302; x=1776688102; darn=lists.denx.de;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLBkVwAa3ER+VRbnt8pN7qOBWpFwXtONCQy+zUroaw8=;
 b=IVlY2tctmNXA0TgrpwG3uRcz5fYByqxVpsMDObw4A3g5o+0u1h1A8JDVKLVmiPkkj9
 XZ+kNdxo3aHlXZagPgXkgmVQ1eZ7/btxI3xl4llmkdJD5UFUG8TAzsLau5CxAw5XEFjT
 D7dmVq/2+Wa/3x4QkBcPqKcHgo5FvDXKl6ZTPItl9ykP5GZJuJBvqy/G45HTxGKs1tFS
 idvMxQk+ITP8kzaIuvfvRNsDfRwgxDdYTkqht834WZAdSDE+1O81X95i3T8wsAdSM7pu
 QE5+eoBrjzJsaXgJNnBjElQbQgmnh2jNEilH4p+UMMWWxqxH+fgLwDJ1ObeDDd7TGJrH
 ZPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776083302; x=1776688102;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vLBkVwAa3ER+VRbnt8pN7qOBWpFwXtONCQy+zUroaw8=;
 b=CuPKDC5ORAf63IKpcQ8nHwpeFQxPHFG3FY+ABVCDeeO4mlzpZTljyv64MhXWv8g26W
 RYutalWMsvkBQjgzHnO3Y/66lUcC4c7Aoi0u9UFdaqTDhS1h73SIcFFZg1AaCUCiF0eE
 H31Tf1DQAxl9be6p4lGoAt2kDVKnCmVJctGzPT01QiBSFCpICIO6c/5IFIVAX7o4RoYT
 mimZk7Apbjf9EZvRyTaYVPxRJrGMzkyC20kvqgaQOYxuYHeMJImp9zxv2IRLv6TM5gZB
 Kq13htW8T/8YTGzNpOQ9kHWd7eVw/nQehXurKgM1hWpF19eCm6dXqsAkhew/0f/gbhsG
 iKJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MMHtmqZ0kPw2+ipph7CYxzQ+VhBJq9ox0sOTwKvrFHyNqgZe+q9Fur0eMGE6ucomVPGYgXkc=@lists.denx.de
X-Gm-Message-State: AOJu0YwmbxEJYM40sWEHNvj60CcsH83YV/1JdBOpr796ACuSjAKO75vS
 CUGTJNKnE1xiCE4KKNbw1D12E8EZctSc23D0IA1c+ze2m2ngs9khaExMwQB2UxECWzY=
X-Gm-Gg: AeBDietpPpAvqfmDzuJ+6Abxd++xYjZbkKdr9eWrifOv+ylA28cbEHHKFbm84VveFYW
 nqVUb4HX/oGGclIu3wjyj0hwycpwqCHUuIljI/dQ0F5mcTkqZebJX7wOnHEbnkzvtOMSBv0WBgu
 gyLdqinmXi8WjFqrnPjyMiR0R8RimGFeURB3n8Tb4hqkBpQxzTj/3+rILb45768ecihpCsz2n1m
 p9CB5yj0nKqMpCAJiVyuzO5JhAzef2Cm+1i0MnSdtob1OpwfSp3RYOyFhCCYefrYHmdCYOoA3Oq
 ERC6pfRV95AtzocsFTo4FJleGmxQr8knY8rWZXQmVG9LvmYxIxVcs4dBGlzVbHFS2qdXuVHLMLb
 OLBlHm/nYafmSXtupVTdatWbbtT69a4MUkWcM/YiufhggXF9pW8RFzQLJq+SzP/T2yjjsSYCdPD
 PKoU9R63iv0m9EDyVLlSYsB8bCyiIhYqjgvjmgrhV1zpVADnCf17Un8kM/X/q20546m8cU/FiHs
 EFVPfg=
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488d68769f9mr163542475e9.26.1776083302060; 
 Mon, 13 Apr 2026 05:28:22 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d538c03esm295004595e9.13.2026.04.13.05.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:28:21 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] soc: qcom: cmd-db: Add optional support for device
 programmer flows
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com>
References: <20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:28:20 +0200
Message-Id: <177608330028.1177412.9846637830549940803.b4-reply@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=KGk6RtEkKc+kYr9S1+Fc7cquB4S8pxOgZalpeyNFycM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw7D1PWrfOXyqwRVTi33/HGL16FJ28/NjPlXHvhEFXM4
 mzyS3hlRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIDE6G/5HrqliUPv/nfv7l
 3/IjXx+wXov4OUeq+RlD8+6axBMtF58z/BU6krq+pn4FZ+mOSX+jz3ts/Xf758Z81dfKqirvlQ2
 YuaYDAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

On 2026-04-09 21:15 +0530, Balaji Selvanathan wrote:
> Add QCOM_COMMAND_DB_OPTIONAL Kconfig option to allow the Command DB
> driver to bind successfully even when CMD DB data is missing or has
> an invalid magic number.
> 
> This is required for device programmer flows where U-Boot runs
> without AOP (Always On Processor) being invoked. Since AOP is
> responsible for populating CMD DB data, device programmer scenarios
> lack valid CMD DB and would otherwise fail to boot.
> 
> Normal boot flows should keep this disabled
> as they require valid CMD DB data populated by AOP.

Presumably this is only used for development and isn't meant to be a supported setup right? In that
case how about just using a normal macro rather than a whole kconfig option, then you can just
build with make CCFLAGS=-DQCOM_CMD_DB_OPTIONAL=1 or something?

Kind regards,

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
>  drivers/soc/qcom/cmd-db.c | 10 ++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8243805e46a..239d87e044f 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
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
> +	  This is useful for platforms where CMD DB is not populated by
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
> index d0a6047b8a6..b4682d811f7 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
>  
>  	cmd_db_header = base;
>  	if (!cmd_db_magic_matches(cmd_db_header)) {
> +#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL
> +		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
> +			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
> +			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
> +		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
> +			    __func__);
> +		cmd_db_header = NULL;
> +		return 0;
> +#else
>  		log_err("%s: Invalid Command DB Magic\n", __func__);
>  		return -EINVAL;
> +#endif
>  	}
>  
>  	return 0;
> 
> ---
> base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
> change-id: 20260409-cmddb-394afa003818
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


