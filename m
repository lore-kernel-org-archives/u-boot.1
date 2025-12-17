Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B496FD6407A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0A683B4F;
	Wed, 17 Dec 2025 13:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxrDwE21";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGHp42Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF81E83AB0; Wed, 17 Dec 2025 11:43:03 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E9283979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 11:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BH9pHPK008920
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9CGGQcH2angmwwEYwUnzigY6
 LK6LQs7mZlU3tOpX0YU=; b=jxrDwE21XBTvWmwL4fGgZR4ceqDL1qA2FRTAyvYs
 uOrWFUlLHCF8LGFL8OF6vr6/mGO7JnbLyt1TqmFTZWZ1+cR5jOXZJyaZI7IYs4Mz
 Ado7YoGVV/gRbQ18LziE172UBBbq4A1G0BwCM0NpQsdFalpQUzibdnhrFkq7CV2G
 a1AOAFjaFKupzfA2OHgpJu5s6mMZ57i01xUNBynnfpkQxHueI9NN058bnAh977uT
 p0riycemP/2fVCxL3JWiR67fmVjYVR4CPgU4NZj768S1QwK7AiEGk/PyKBK69GmA
 3mxI3SAcjabE750TIYlAPyxGDcTs+pZF70YPr8elO+fz5w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3t8e05em-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:42:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c704d5d15so7716037a91.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765968177; x=1766572977; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9CGGQcH2angmwwEYwUnzigY6LK6LQs7mZlU3tOpX0YU=;
 b=OGHp42Yb7yPI5RtvcvZm06kaKGXlnyiGFovypEyOBbstPuBJaZ2N3ppSW7hXXkvoRL
 0lqpxVPILOl+x6CcXa/Zi7RJ/gYIQpLX21WMx1WeMWJNyxLv+f8OSOgPm/n7PHAKb+j4
 +56RjnIeio1rYoCu+zhnUx8+lbNM3XzeDZWzPR8HB2sbXabtU+CsDq+DlgrvS0ZN8YOZ
 5I6m4EpB1irpEXaOjXNnWHK4VMTWFvNtPCUplCFnoGsQkhmU9kQICrz6cli0Sxg1GoFp
 3prLGP2+VXhYJSxcjwpvuLesaBoc3FxCxFOTm9TRodrsnzXsZ1jML0ZQ4/pCl86PY4kz
 SCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765968177; x=1766572977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CGGQcH2angmwwEYwUnzigY6LK6LQs7mZlU3tOpX0YU=;
 b=vXbNFVXkZcrsWTepezTWPsWFX4Yniye9+H55fPrzFR3KIPvjjIISI9+nQTI0aQOR9a
 0igpwfOh+2w4opaq/e4wD37HJMNNLCsrhiYYaaxDNPdvnOOZ8Ym+t8/KeZ/5bJiGJ3aW
 LJiO4B3Grny48l4Ornjfovhj4PerqsTb41AEYYeBEbLBjCnV/CbmMR326oJqZYsT1VOU
 00SIyG+RLkYmSZ49m5d+5AS7S24Cw4IcpZwQQU4BG1vhtuIBAkPJktRcgAQkMG85c/wR
 c+0xnoJO9h1kmFwlMUB7zoiLOdudjeSsYl70/BVaECTTzOGA8w6ux05LCwnAIowyiH6K
 Yzjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnB7xsUSstXvqd5BTrnhTLIJ9N/vfqcFDY1T9lVCT3YYS5u+y+RzXYEjMOnNu0+LALk8s+BkI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7aQX+O7djUkcROXVExT7SeQ8OPfRR3+eqNk8+KoNXH52Qp2NU
 nay8yZ1lWImd4ZQVPqsdSkvPHVBVUJy5vSke3+lpobsCnRG2vJjXJUpWJRf7IJqJgGsL2UvXhIn
 0OXcLH8qnMqAmsymfpFj7lPvhGSHB3khBRNVGIrsiJkdBTbObDXg5xLT6
X-Gm-Gg: AY/fxX73wFIT3iuZJ6VvNfjueOYRdAXUspt17fzffXCMdq20nC0MPxhShYXvL6B+RK3
 ptTdLwAmk6+GZwv1FzsPsLPZSNR9KwCZ6b2KGvW8/7khoBDc7mqFSHBRvRYp/SoS2byTffbki75
 Azz0NW1T+le8Uda3elKZzVIUzHczvFuz8iqwCE4/oJYJ8VKjk+YFOfgROT9QZtWwjOBNycnq1+D
 BO2G5oHVgepElb3SfPS1qK/XNxyYUFcNa4jsIcrlD8B42/YeVbDgg3I3iiADZquzsaUHvGqKx6n
 Pd65caVD/H4jMYRv/txWtqEyZbj/PXiIvF4NpTjgaaxheLtZ5l3SzXUdRBNgKs/Nou32+KBRv34
 8kUQKUoypRo7LaB3KBYAoXdsoKHSnq48Ucc+XutukOk+WkcN1PvyXKG3v4duRJXjZTcGHSIohll
 Y22rUkj7vP7nLNp84fkAzfKqVcipYxjvjbSAk0R28=
X-Received: by 2002:a05:6a21:6da6:b0:34e:8864:793c with SMTP id
 adf61e73a8af0-369adad40famr17234903637.8.1765968176875; 
 Wed, 17 Dec 2025 02:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZfhSHLrmxZDEFGkfqW1PixG308y6XXQFDFAEyYq+4ysfBTpMgSfl3BxqZa2iPystnFKuAdg==
X-Received: by 2002:a05:6a21:6da6:b0:34e:8864:793c with SMTP id
 adf61e73a8af0-369adad40famr17234868637.8.1765968176341; 
 Wed, 17 Dec 2025 02:42:56 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2c963b53sm18015514a12.36.2025.12.17.02.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 02:42:56 -0800 (PST)
Date: Wed, 17 Dec 2025 16:12:48 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v6 3/5] power-domain: Add warning when power-domain
 driver is missing
Message-ID: <aUKJKNgBz8YkHDKI@hu-varada-blr.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
 <20251113113427.2218045-4-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113113427.2218045-4-aswin.murugan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4NCBTYWx0ZWRfX3gg9nGhlZodm
 wBiZTaxgC0ELxSIKciJ1vOSVapVnBHYJnssTvTXa8s4517mS899MvE2d4oUxyhv8cqn8LmbrIx5
 E6tvSkiyMnoBqAas7NAgUj9pb+RdywAcVNYlVdRBPjOciRRaNsOXSBRahuuPfiKgqtSL+bR/13E
 4+rC3l6/2Ah+4DYJJzDMKmgVqSCot2q/qakpwPGO7n7sa+fNK0WaMMbIAb8dA+tga6W5a2Ah4HJ
 JvgtxYs0JOV+R/CbiYiHhwHQAVBP9x0K+8Kmw7wQ/QWPjM4wVqHiHny0F8HYGgGzsCbmMg8adBH
 qVvQ6sD5rLDEkLh+NVVAeQ+BGUULo02PIsGRo1DoN0mxIMtYpssomUEJqo6B2Da4/0EW5EAENMi
 x/zOtlg3R/WbC8LCt7zt2lZmlXMtfA==
X-Proofpoint-GUID: kTQrJYLsdFCxs9tKBaifqmfWRJ_gpeEv
X-Proofpoint-ORIG-GUID: kTQrJYLsdFCxs9tKBaifqmfWRJ_gpeEv
X-Authority-Analysis: v=2.4 cv=EsHfbCcA c=1 sm=1 tr=0 ts=69428931 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-WCB9TnYaejT2uKtaZUA:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170084
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
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

On Thu, Nov 13, 2025 at 05:04:25PM +0530, Aswin Murugan wrote:
> Update dev_power_domain_ctrl() to log a warning if the power-domain
> driver is not found (-ENODEV). Return 0 in this case to allow continued
> execution, while preserving error handling for other failures.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v6:
> - Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
>   when power-domain driver is missing
> ---
>  drivers/power/domain/power-domain-uclass.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index d9fa8ad4bd2..b5d9b08b150 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -10,6 +10,7 @@
>  #include <malloc.h>
>  #include <power-domain.h>
>  #include <power-domain-uclass.h>
> +#include <dm/device_compat.h>
>  #include <dm/device-internal.h>
>
>  struct power_domain_priv {
> @@ -184,6 +185,13 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
>  					    "#power-domain-cells", 0);
>  	for (i = 0; i < count; i++) {
>  		ret = power_domain_get_by_index(dev, &pd, i);
> +
> +		if (ret) {
> +			if (ret == -ENODEV)
> +				dev_warn(dev, "power-domain driver not found\n");
> +			return (ret == -ENODEV) ? 0 : ret;
> +		}
> +
>  		if (ret)
>  			return ret;

The above can be simplified

	if (ret == -ENODEV) {
		dev_warn(dev, "power-domain driver not found\n");
		return 0;
	}

	if (ret)
		return ret;

-Varada

>  		if (on)
>
> --
> 2.34.1
>
