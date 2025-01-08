Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3F9E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61B880690;
	Wed,  8 Jan 2025 16:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KQ5GvBPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115A7800D7; Wed,  8 Jan 2025 10:38:34 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7FD8001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 10:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso349627a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736329111; x=1736933911; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lz9xvSxThgtM7p/6v7lAx/92NCSHM760vRRrIv/jOzo=;
 b=KQ5GvBPHAiist0zB5XoivWG2ykWMOtBcVcMM1783+EzVgJzn0jrS4c/j8B0I0qhRx2
 nlaPLXifCT4OqBb6vgNm7JcO01zCoYq2VEuOxhcmz96a+PjJ70aG6+QFS92lsfKeClBg
 MrJrJn6LOqjZhA3Pa2rG4HaaGHmPsP1tAovUbtqmVxg8yPTaEQhXV+hE5rW3q6Me1J5D
 McgLgtsRzUEBTYMMAZz6P+uE7jSKwYmnBYAjyOXjOfFlR9yYttFZbCkzb71cln6dktZC
 dRyx0LBbyDMVDLdjsWhHUA6Gqva0y3JlEqJpFgY2ssgoJ3JPCfTdhXDtC6IzL6jtFJWC
 o2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736329111; x=1736933911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lz9xvSxThgtM7p/6v7lAx/92NCSHM760vRRrIv/jOzo=;
 b=qGOX4o/4SBaehBr2Fmmnnjgk8gTHRkvzi3tnK3uUosj+aC+Q2va+DYDJle+H1z7zh1
 jqb0K61rr94dGHlzAYn2c4XbhejDo+VX3dBGeskr+ETtPy8XT279zMN/6X/0h5VfxgkB
 DtSck4BE53r1g5dapaBFpezd34/DlhtzOBz5s2lCinuCV4FD2rXjjR/QRUcbAhn7XkKf
 zul5tg5ID5E7uLfLCYT9rp8IAmEPR+z4fyMl8OXq7Q8rv1Bm+UbSmf8bBglUMEhF83zz
 I6ISsf6N4JIkhQHUMLj/mHJ/kdiC9YGnEk7Ar1v9LV99DxTtIy80cjWQKp1CY/B5iMrV
 2Hdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfwNlLvDSUoRyi+rTd28Bgbb/bk0brcJqcYit+0hQ1rGQe3S7HK3sl2Nai/+KB+7omfN5kwT4=@lists.denx.de
X-Gm-Message-State: AOJu0YxmP86aa0CrafLcNdkPvOcCHFDcUHY7ObG6XquT1WI4yqyK+f+7
 395aI1l5qzamEJijL59/o15NCXMibVCVoJ8qMQvL3WjR0GqVJN0M0jeukphD7/M=
X-Gm-Gg: ASbGncsVo+1i1fDGhlgx5etCGsbvKDbWq7KTx6p3NlbJJ4AboyZeqtt43Quzge4dVro
 krKNsot3Ri9K9JYRVAp4O4W2HhwB4O3pOg20ZLAenDLRf7IcU6naI658YeZsXVZj6gK0j/p8DRU
 J02K8bPOqfYIZLioRGIHGK0fk9eHm2ieM4z86qgLBBTr0UcnvOrjQyGb88kx0SMNBJxz6XTwoEY
 X43wp9WI5N83E8zMB4xkqA+R7818iLBsmsyC21YphT5wey7TMHGp74/Gk5xj1OsgHnB
X-Google-Smtp-Source: AGHT+IGSd6efZNYCkVI4jKovB+5s2raCXjzPz25XcBNQxIiMurVe9gALpk2DPoySmsZqb9R1VMVojQ==
X-Received: by 2002:a05:6402:278f:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d972e085d7mr1655668a12.14.1736329110873; 
 Wed, 08 Jan 2025 01:38:30 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:7505:d47e:5219:b65a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80676f192sm25814825a12.35.2025.01.08.01.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:38:30 -0800 (PST)
Date: Wed, 8 Jan 2025 10:38:24 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 08/15] soc: qcom: smem: get serial number from socinfo
Message-ID: <Z35HkLAVL5QF4O5-@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-8-b7852c11b67c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-b4-modernise-smem-v1-8-b7852c11b67c@linaro.org>
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

On Sun, Nov 24, 2024 at 08:17:50PM +0100, Caleb Connolly wrote:
> Implement socinfo support to fetch the serial number if available.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 25 +++++++++++++++++++++++++
>  include/soc/qcom/smem.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 5166f289dfb6..5570c5c907ad 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -13,8 +13,10 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/sizes.h>
>  #include <soc/qcom/smem.h>
> +#include <soc/qcom/socinfo.h>
> +#include <env.h>
>  
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
> @@ -982,8 +984,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
>  
>  	return 0;
>  }
>  
> +int qcom_socinfo_init(void)
> +{
> +	struct socinfo *info;
> +	size_t item_size;
> +	char buf[32] = { 0 };
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
> +			     &item_size);
> +	if (IS_ERR(info)) {
> +		log_err("Couldn't find socinfo: %ld\n", PTR_ERR(info));
> +		return PTR_ERR(info);
> +	}
> +
> +	if (offsetof(struct socinfo, serial_num) <= item_size) {
> +		snprintf(buf, sizeof(buf), "%u", le32_to_cpu(info->serial_num));
> +		env_set("serial#", buf);

Hm, this conflicts with qcom_late_init() setting the serial# in
board/qualcomm/dragonboard410c/dragonboard410c.c:

## Error: Can't overwrite "serial#"
## Error inserting "serial#" variable, errno=1

DB410c doesn't have a proper serial number in socinfo. Turns out using
offsetof() in this check is wrong, I sent a patch for this on Linux that
was applied upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=22cf4fae6660b6e1a583a41cbf84e3046ca9ccd0

Can you add that fix here? offsetofend() doesn't exist in U-Boot. Might
be cleanest to just copy that over to U-Boot's linux/stddef.h.

Thanks,
Stephan
