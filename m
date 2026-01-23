Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56567D6CFC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 04:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE91839DF;
	Fri, 23 Jan 2026 05:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wsnkp4wc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TVL68uof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C524D83B03; Fri, 23 Jan 2026 05:51:46 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FA0839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 05:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60MK7eku4008978
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tsAkq469c6sNLAvPXMXHCCYR
 WL8GEWa2gHfgZkigCro=; b=Wsnkp4wc9vjLq0gpCGZ6LSGzzfpN7jCs4xk/bIgm
 7hUzawa0Ur/xT5ciwUx2SWBxdwWY4OZwBtfJZm+f1WqUjVVhEeoDJeeidarSopiU
 OPeboomMhfSgepfyaXYIjTo9RonJpCzL7Sg+evEQpOIHMeNih0jcDdews7rlCwkk
 oUfv/BuF2Aw/kpn893euBwRvSsK/xjfhNDMTjSLgiGQdQ4qZdc8FKEFi+MuGAXXj
 9lY9IzhBOeLyK8mknGaM8X6/gm0EFxyKMB4kx2vXSoUL8kti6ijEg0rJPD7VkbNr
 tOaA/WyK5sUPe0IlTPzB/UeYbFvlJZdp6rThDQPPCsifPA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4but2csh9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:51:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-352e195f662so1487638a91.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769143901; x=1769748701; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tsAkq469c6sNLAvPXMXHCCYRWL8GEWa2gHfgZkigCro=;
 b=TVL68uofoGf38Xfvu4tAnKkPryuuBXCdcmyVuZc3gwowjhwwcDQTloaPT0XWmAZXpR
 4hPqFnOfzK6NBjMcroiopNlNhVNVsPSL5mfb6WR+ed/NKmqrarkl3H2jRzkvpcWdVQQA
 z8N25pG4qkZ7W1gBnhN71i+pxBeZUxOLT32eCYuxpM1J7owDy3VuvGSXcUw6PcunFiUN
 2MWkR36AGRT0lqgkfJQ42GjiYyAzLP8l078FNOpUVDN/QmJdeRjKRweqLpFsSFblakOD
 kWTc9afhbda4PX7JA70i6W7vig/HB/W5tAkRsvVKdKFeLs08vDd/v+Qg7K5i/FdQXc/s
 Q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769143901; x=1769748701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsAkq469c6sNLAvPXMXHCCYRWL8GEWa2gHfgZkigCro=;
 b=bqHAXhgyW96wo1wjOuM/wRm7+qTh8zeKZ00fCIEdJbvN+HlmJdGIG56faVI2KZWopp
 6GLj1I/KEuqtMjmyfpcwrWzwn2gYEQcr/phXy+MEtWl2Ifrwc7Gf05YwdwaQNsF+Mcjh
 Y39P3P8Bx9Xh+yWIiaJyKKdCODu3N+rcvQwEiGtt5QH/P7C6TfPMU/BCUOaoT4h8+i+/
 ihmcNSWlC3PZe5o7qSwclvpzJ2u/L3edwJ/p+y+LUt5Z/W59M/s6akWad/r7YYBcTT/Q
 2wGMmHLueAn5EgP6EJ6XlSdxMkbQVDn1j8/j0jKY3u8dnAaU8i/xCSviVPekJPRlEkAl
 9c+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPRXiekOdygUIK+5/gTi+81t6uYTiFPnYDwGSyoXUWjXM5D0SjKgEWRoBqk9DWJA0yekiqzbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzPWJ3sqYtQE6VZ1DTuPTenDkQljC+rarejLBOJNM6d7/6VH+nt
 WPhVSxYMjg76GZFCrXfrP7DXYyvxuS2iVciucoMMLZ/TRw8qXBUchS2FKoEEY7Ze12gKSfamDTb
 fymReYbfbJyKSBvIZmis5dShxESLo8dGToDQMCAjqqXNwmmFD0IL4LxbLJJTX7tez
X-Gm-Gg: AZuq6aLBLJDaf39vY247U+klyDByKclL/zv0kxMT8vk1NkNLqZBqgBNsUdxnw+AmtyC
 a4XwqoX8GWof+TqfCW4o21EVm2WPSHlRPtzHUXnAWMQh7LEXp4Dv9ZA7VqqPJYp6lNPMTNx3rT0
 h3HWydXxOrwuoBQfyUzzmqr63fkMwwXaCrpB836i1Uq46uhwq0A316Ga3zTEDXDX2uVYCBkvqYC
 9ZtlA+cssEj23/tXxn9/M4pfiGUuFAbK7ceVPgTiLWULNtfLyo3zDUxgH3c5eb1yyU3Em6xvsye
 Co1ucwuTqlOd18xbEu0qfNPwwKc1t7gctpRmwD8gHQGC9Iz5SmqfvlM/G0o7c/ulDFJwK9+edEQ
 e8yV4aI3OTWuW1Xc2aNOURJ5z9B45XQj4wukzcAI2tueyS0BmugTjckWkSpyYNCPCPotgcCuri5
 vkq/RbQFgpqO5h6ex+hyWYwZz/VcqZET3W8WQdOmE=
X-Received: by 2002:a17:90b:224b:b0:34c:aba2:dd95 with SMTP id
 98e67ed59e1d1-35368b44712mr1821151a91.26.1769143901462; 
 Thu, 22 Jan 2026 20:51:41 -0800 (PST)
X-Received: by 2002:a17:90b:224b:b0:34c:aba2:dd95 with SMTP id
 98e67ed59e1d1-35368b44712mr1821123a91.26.1769143900919; 
 Thu, 22 Jan 2026 20:51:40 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353354a6902sm3815217a91.11.2026.01.22.20.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:51:40 -0800 (PST)
Date: Fri, 23 Jan 2026 10:21:35 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup
 support
Message-ID: <aXL+V2+1qMlae/wa@hu-varada-blr.qualcomm.com>
References: <20260122085806.542149-1-sumit.garg@kernel.org>
 <20260122085806.542149-3-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122085806.542149-3-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAzMiBTYWx0ZWRfX8Kih0wRVqJpc
 jJhAn3zXBikFpCss+VtSBz0VMgl9DWiRuBKtmu/fSIZtLwmoYehbM764QAn5dGCOHwXtkhg6nQH
 euheJjBcrlpbZlUNF7thatg2PJWHNEZY594bynGMP3SQ3Re90cqSqjk3rzSqYQXnAk0FYo08iZi
 4zpSgAygPa3hKu64oV3nSYmRz5+YW+j05LLo1gOsd+1jh6J9orKm8vlH6U9aq22msbJDlqAgL6E
 4SqTs89+VRgAuAdGnRO6xegRnDFdzERMfTLPl6zeZtBRn4A3/cx5Ct23IpaTyDsgdw3y4aqbtlm
 bjTaeBHZGJLayjLKM0QBfAV7MK9ls9Fi2F8aXfSAtzvsW19vpuFkQStP/Kls8jBnhzKjN0HXJeF
 6WFJUbAGMhEDRaQ/oVVNH+c8CNBr+w5hn4IWfuz61s3rRo7092U5cdGfP8XC6awETFhbgFFoYT/
 5eVNpUIOj8KEjQfN2IA==
X-Proofpoint-ORIG-GUID: -ckBQbtlIrNy2sRa-3Zz8qAq7Ewey_4e
X-Proofpoint-GUID: -ckBQbtlIrNy2sRa-3Zz8qAq7Ewey_4e
X-Authority-Analysis: v=2.4 cv=YuYChoYX c=1 sm=1 tr=0 ts=6972fe5e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xq1JerYxUDbtpw6urM8A:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230032
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

On Thu, Jan 22, 2026 at 02:28:05PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> Add support for OP-TEE live tree DT fixup support which enables U-Boot
> OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> the live tree fixup to be carried over to the OS for the OP-TEE driver
> in the OS to probe as well.
>
> Note that this fixup only gets applied if OP-TEE support is detected via
> checking for OP-TEE message UID.
>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 5b6076ea8e5..3d19449f133 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -25,6 +25,7 @@
>  #include <fdt_support.h>
>  #include <linux/errno.h>
>  #include <stdlib.h>
> +#include <tee/optee.h>
>  #include <time.h>
>
>  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> @@ -164,6 +165,37 @@ static void fixup_power_domains(struct device_node *root)
>  	}
>  }
>
> +static void add_optee_node(struct device_node *root)
> +{
> +	struct device_node *fw = NULL, *optee = NULL;
> +	int ret;
> +
> +	fw = of_find_node_by_path("/firmware");
> +	if (!fw) {
> +		log_err("Failed to find /firmware node\n");
> +		return;
> +	}
> +
> +	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
> +	if (ret) {
> +		log_err("Failed to add 'maximum-speed' property: %d\n", ret);

Failed to add 'optee' subnode??

> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
> +			    "linaro,optee-tz");
> +	if (ret) {
> +		log_err("Failed to optee 'compatible' property: %d\n", ret);

s/to optee/to add/

> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
> +	if (ret) {
> +		log_err("Failed to optee 'method' property: %d\n", ret);

s/to optee/to add/

> +		return;
> +	}
> +}

Not sure if add_optee_node() should be wrapped within #ifdef CONFIG_OPTEE,
due to size concerns.

-Varada

> +
>  #define time_call(func, ...) \
>  	do { \
>  		u64 start = timer_get_us(); \
> @@ -178,6 +210,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  	time_call(fixup_usb_nodes, root);
>  	time_call(fixup_power_domains, root);
>
> +	if (is_optee_smc_api())
> +		time_call(add_optee_node, root);
> +
>  	return 0;
>  }
>
> --
> 2.51.0
>
