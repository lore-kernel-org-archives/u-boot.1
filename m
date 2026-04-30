Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC52FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 05:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D803C83693;
	Thu, 30 Apr 2026 07:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPk78EoI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iyssahVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F195683FB5; Thu, 30 Apr 2026 07:08:34 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27FF80433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TMFBYq3885246
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 05:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TihfNXbUuC5IeIOJTDBPOPqB
 HFNnjmWJIfIoo0b+IFg=; b=nPk78EoIr0+bqmsIZkZe0EIL/nAOGFCRbvF7N0vK
 C7/t9iaIdR1mssfE4t8MFoTQTU/lzZQwZcKrHl1bP6nzmzWX/W1C8LQFEo6GMXj3
 Trn4oFdT117/GWGNGY1HA8XWlydXhWVlin4MG+X1Zf3D9hGbgbOhFiJZUMDQcM7U
 DcKQcugp9z8wnK+hSxJI5o64UMPqYE+Fezrg8fJ1Zb7sMUT4uMUP+bmlWVIQwE5O
 joVSN0mT6bbX/T2U3s/MOlTaHimZdXxOMwpYFEKzFpT1tBy2dRPZND9PhJ7Guhsc
 xgWW5073NWV/b0TeRkoaXGaUY+rGH0TZiaf772xHo9GCQQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmah2d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 05:08:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso972836a91.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777525710; x=1778130510; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TihfNXbUuC5IeIOJTDBPOPqBHFNnjmWJIfIoo0b+IFg=;
 b=iyssahVL+NDoJ2VRR1KVhIJTvpMTZHioIw2OKLv7+028LLg3J3SiKQslNixohW6Rkc
 C7X+OmsmqF+Lv8hGeajAQl1LN7UIUved1AphpAVrwlhASmGu9TWznLJKpa1YjqLEhHQz
 V4NE2l4jQv9i95Gj37gWEbrkddLSdMTZtSCZmL7w8Hgf+ABGvhaUK91k8SyGGb2vaRO4
 UThf+t9++7Cayh9KSCDc3Zs6N6o3PnFwA+SA+D0pZPWy18M7YCEtEHXV7yOHHdpWbuDu
 8K8UKMaWu5tLWHEvfnM/y8zsS+qGoSzETKVJRGhWKnS88poFkab0VFJEd5ILVyPV5Nbp
 vFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525710; x=1778130510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TihfNXbUuC5IeIOJTDBPOPqBHFNnjmWJIfIoo0b+IFg=;
 b=kGWw/EiW/FtMTFT9SIZFY0fl7VlGeg+5X06k31KmegHi+FuUG+kzPApuIdopQWb0Qi
 +JGgJ0hdjzrDYv5DiOMTc15932QW7BVqR08cFCbdbtUjtfWM8SZ3gypcK/DVOsI/aYYe
 wSPwqPcsrKitLW9UGsoaHmVdE/QFDja7rUo7N5j0KnZY+Ce6lFbfscK6QXbwtplwkGXu
 BBWahbNPR5nM1a1ijw4BDUGYkF7Ywr49Mtidj2WGgirJnEjQ74XgWOGrQd+J6jztEl1x
 71syky+L1vo8chcnxD5558Y3fOYnC/nDT74WLZAcEd51CpmjXfgR9sMrHu/tQfs2yMlT
 vQGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5+lLXuOXbNSd7RZ49zpVxXYG5qyFh71DahxjqXtPG9fXbJgSOd5bdyqXdAqYaU2ZWuhqbluM=@lists.denx.de
X-Gm-Message-State: AOJu0YzAvmH4R3jZ887TY/hwRw6fpJzPlCi7HriWTMnZ3C85bGKti8i2
 Z0JdYL6dD4hvDvENHHOSLf3Nkk6pQMJg2uEF/OmnjctU/mdcHCmHboO919n4iNEm+1Ri08juepC
 hW+LqIwNtDC6T01ImkWqHySt1OHEFJcL7i5K9KSkEcXMa1sr4Ok7UBUHF
X-Gm-Gg: AeBDiesyXHp9w+S3hut77JyWpNsxzK0AK/s4b+YZCHbDSORH9lcug+JRqz79gTHmqJT
 X0nDgCF+86eOITI/7F5dMmNcbhcwMNEzmpv0DBU/3xp84GEI3jCIBo+lyi74zbhgAUrhOEMv+5A
 mIiD39uy1QwwUz3EF2mpik70HZUcCVqaVA+hVNiBtZmfUaHdc4+2Y3TsrAEEwx5oUaIxa4vgIEn
 JA5/+lWYNVGOR3GxTTqH1+vlZjKfY4xKrPJDevOULl41V8Fw5bv25/3CDDbTawLn51qukYT8p3k
 ve7YCiJKpzAitHEP974nV2eVMnTVWVfh5Ur4HMsq8610um7qBjV06wBRa8CcFIh+fWdFk4T/xr8
 35xeox/ibaYX1rYDeTznyMrTuW6l8hrRrcG8rGJUTGktv45IZuGm0i5h3WJHSiY1dtpJBSeWurr
 B8hObD2MmzuucjBKoocEcW3riFwQNAsH/WMCYgrsBiraTP4D+C1c7nKnYuxYoAAg==
X-Received: by 2002:a17:90b:4ac7:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-364c2f14e9emr1292608a91.1.1777525710045; 
 Wed, 29 Apr 2026 22:08:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac7:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-364c2f14e9emr1292572a91.1.1777525709518; 
 Wed, 29 Apr 2026 22:08:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf2aa41sm1644516a91.4.2026.04.29.22.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:08:29 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:38:24 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] doc: usage: cmd: reset: specify when the -edl option is
 available
Message-ID: <afLjyE2dNZSi/NGy@hu-varada-blr.qualcomm.com>
References: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
X-Proofpoint-ORIG-GUID: OtZVZvMCEIA-VVnebHP6i2qY5Za-EGG7
X-Proofpoint-GUID: OtZVZvMCEIA-VVnebHP6i2qY5Za-EGG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0OSBTYWx0ZWRfX/xy1b3OJLTHl
 N3o2OmBbzuzUKk6jrfDEgxHzIlfB2ma+3FxcZD3qGrlaFV9holKI7E7eUjezpxGoyRzInsblLM4
 jiDoC797ZQqxhvt2Sgi+8hGBBdeDy+f41mayPlO4JMk8ejCHQoiDE4Msx69BTECAxMaU69Z21II
 EusxX4nf+ESMd4LBIjJv8PiKzAMPRpX2xZt216Ic5JDNob4b2e/5WeBuLOsESiahSC9QSZplmr1
 X6Wg93YbCkrao+HkLUNGc7ED+l8XBeX9xvmWZSnXSIGUYUJPwWCfa9LG163i0U9msF7GiJTM2MB
 D9VSWPDkwASXsvYrjMrVMKPDrRKJtOKsGj5rQzVfNBygwn7+pu+hIHImZeSdYBhn6PTn02Q3HmA
 kQ8l3iRv94FODNT7L42w8TzhbgQugU09UUOW1969Z/aY3nLvFgEM5lKtR6nXvvAXYkF5xvVjbj/
 t/S2v9vn2ehyWGLgv2g==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f2e3ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=AieNkoFbs6YUqXfQS_YA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300049
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

On Tue, Apr 28, 2026 at 12:26:08PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
> so let's make that explicit in the boot cmd documentation.
>
> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/usage/cmd/reset.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> index 366b17eea16..54767fea241 100644
> --- a/doc/usage/cmd/reset.rst
> +++ b/doc/usage/cmd/reset.rst
> @@ -23,7 +23,8 @@ DDR and peripherals, on some boards also resets external PMIC.
>      Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
>
>  -edl
> -    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms and only
> +    when CONFIG_SYSRESET_QCOM_PSCI=y.
>
>  Return value
>  ------------
>
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-doc-sysreset-qcom-f5d21aa84142
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

Thanks for posting the patch. Somehow missed your comment.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
