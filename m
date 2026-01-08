Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4748CF6AB7
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 09:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36EA583B87;
	Thu,  8 Jan 2026 10:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZA8CLao";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMcEzWIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90649840A9; Thu,  8 Jan 2026 10:41:55 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4037083A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60896iHM4050069
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 09:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NbSi75quBp8WA89zdYtjfLyV
 8PWv7kqK9Os7BAXNJFA=; b=HZA8CLao1T5nwllp5DTqtU9fQZ06Ng2aEqYpZuHN
 nvwdM1UBDlOcGhXWHnyGZSqR/3My9P1DJIZr1EoI+x/1Vh04iVMhsJ+X7SyTVNub
 dNpBGe5mbWPujpabSjpvzLQK902RP6ruJYWpX6XJ/jFcj8LAvXAMJtSukhg4gh4C
 jRdIKvf+RGmiFb1xAcNCqKBHAG5jFZ9SDUempyxH6BnGWwSpPDtRlT6m+TP8lcFT
 WeiM5/FIC+grMq7fkSHDz2kpfNHbzW5/bkeCk4RVFrWxpXWhsd0pjbyZ0A79bupp
 hPW58VEsLZrCeM2BNzdeNFLaeI4thPf0UGgCn5al/glVng==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2n8hftt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:41:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c5d203988so5905825a91.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 01:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767865306; x=1768470106; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NbSi75quBp8WA89zdYtjfLyV8PWv7kqK9Os7BAXNJFA=;
 b=OMcEzWIUZfUbBAqkCaV9a+Xu0fGnogMokan27TPL1Xj6CCRQaDEeGH+V/AYMxGPTtw
 4T11JoK/KCSgbPzahV41jzPdyN7vP5aZwHJ/plePo7zItoEx6wStlWVcw5NeD2Cbmz3K
 STaFHvv4wAR9QXSXC5oK91SGgJrg80kZAiO8D03bBPUGhYIxhHzHMEvY4Stb/gyBQHRB
 y98or8Y/myYaHRsLIcFWjKXW+juXLNBbfuE+jA3+Icnvnv5QBiDNa8ChwguvD/UPpMIQ
 Z5vlEURn1yII0SKpaA6dFaAIpC2CddzgSNqWIm7ctqgBnMCYVayH2LmLeXaMOBCgXG4g
 w4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865306; x=1768470106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbSi75quBp8WA89zdYtjfLyV8PWv7kqK9Os7BAXNJFA=;
 b=c981q3Hcj5hXR3h5nWw85iu/jdFVIqQz11qclR2XGoRi5byMFDLAKD/1wk3uZFi62X
 wzSWlEBx21xllDiSd1SSr6KS4xt5GlFokjR3IiEpjq0krSq9JYqeB+cmMhrDVDNqavQU
 YaL79fiO9dOcsXGuWS1WEZvR3+NQEM5EOTZcGCGpsshqQk3HMAbXXCS7opHsLWFos37J
 YjBtXKv45bD5ikzzIY9Kl+DCf4boAVwCv1V0ec1FEkfv4cQS7l5jW25DWhjM7cTKZ/yw
 VXE+uXNakW3IfSNjXJsJWvViOJJqrQXt0skF1aUBqMIWUWzL7mdBvqNcGEdcpy5A6mPv
 RBcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlBfei8VPoheV3hKTYDk3ytvu106uMkL3qV0xYDrtkrDb9+R1gJ/A5TDz9CQ6RsIlfrPzzt9Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6u0Fvx+YSM3jx857fBXMzb1KOR9MJo/7yUQv69mYv8VZZbF9g
 gO9yzu7qZdoWkGqJuc5+5jTrmZbgAI5fhaRwvicCsBoDRxXPLjkMLtA1ota/7e4/IByktnxXE5i
 +qPWZOqNi6gVN99BlIEc0YMGop+tVXbtFdUbvdIzLKHCrFxCEdr1XFA1/
X-Gm-Gg: AY/fxX4yswrEBcL6aw8EcuhjFBH8TBIqJ7YOUu40ZqKnqToFj8sg5L2gAEFh5KDm23r
 8AsVt1F2/32YFOVkpu1XsxmbcqugSFKRsF816I9Ad0+wxyT9qyAQj0Nb+rs8nDmm7fndxZSm3QE
 adBlLhzEnWVLoXeZt2q6AV8dOUx2nSAtKVQFCcTKrwsfTCpGk4WOjZR88uo8Tn5JWOxm0ZYl810
 I2NFwZPZkkmvKqNFGpCkS+VqUTUZ79KcNeCnWV0SoCcu44FsZXKrfPi8p50R8dmagXnR6NCc4Af
 FkwUFuI8Z6YyKXrB9JoH2lnFTSM6Vnhu0CM7R/txso3eMmZGLanUq3qM4LtTlu8HapSDafUSLdJ
 zx0FEDxWRo4H1y1EYTp6op1fGSvTf2XXEeBrC2dbk2s4NkdROICA77aRb507oIiJjGxsCpD4uD8
 aQphstuNnO31TIGT3W3DFctdk4Iet1yugVCfFi6qM=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr5240478a91.8.1767865305616; 
 Thu, 08 Jan 2026 01:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2eXxVUQh//eW5u+5yCa8NLis71fPIpVoeay53BK5Ka245hRTV29ICIPILQmsVYpUcJ0hqqw==
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr5240449a91.8.1767865305113; 
 Thu, 08 Jan 2026 01:41:45 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f7b19ebsm7250483a91.3.2026.01.08.01.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 01:41:44 -0800 (PST)
Date: Thu, 8 Jan 2026 15:11:37 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, ravi@prevas.dk,
 javier.tia@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 ansuelsmth@gmail.com, mwalle@kernel.org, anshuld@ti.com,
 jan.kiszka@siemens.com, javierm@redhat.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
Message-ID: <aV970YfT3dkXmfxK@hu-varada-blr.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=d+j4CBjE c=1 sm=1 tr=0 ts=695f7bda cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4L6MJ1X_2v-q1V9PjrcA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: PeoXFw2caQtgdfX3c0Lbgb6Svm9t5rrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2NCBTYWx0ZWRfX3PhhbCiSAH6O
 X7czdmo6KcBqIh0PtuSzZEezz/c+p8bRPa4Cfyl77cKqnPq4QW3I/TWVvB9tNR2i2Qu3dTaETR4
 Vw+8HMXEsR0sLqTG7jf6iVTO8bamvYeOi22l3zlECTyggUnxcLUInAIlcr0AN8IrKn///FxpPGN
 wN6agmdqbfRNtG+wKdOEPkD+5kh0VxVhCSYpypSPjE3sMJsGbexRxvoeZi53gnEU1DDEhE2LVBF
 Rb4KB1G1+ZKxBQ5IwtMwDL1qgfu3DVk0gJbDIQawi+mgoV1tgocHiBBLFmvg68bVCraU+yQTFSE
 b4h6Mb3PF5hX3ts827EhbGI96zTP917Dn/74I9RJe1qw+j7fOcOqO1OAJLfUK3Y/Rdzwd4xdrhx
 tgL5NtfRelXay0/TEJn8fFQrLzLmJxnU3mN/k2HBAoNeBnSSKJGAbRKjpGmU6P4X7T8dKoE3qBZ
 cZD1LdG8p0XoGjSLirw==
X-Proofpoint-GUID: PeoXFw2caQtgdfX3c0Lbgb6Svm9t5rrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080064
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

On Thu, Jan 08, 2026 at 12:19:46PM +0530, Balaji Selvanathan wrote:
> Add support for locating SCSI environment partition using GPT type
> GUID instead of unique UUID. This enables the saveenv command to
> work with partitions identified by their type rather than unique
> identifiers, providing flexibility for systems where partition
> UUIDs may vary across devices but types remain constant.
>
> Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
> allows specifying a partition type GUID for environment storage.
> When enabled, the environment subsystem uses the new type GUID
> based lookup method via scsi_get_blk_by_type_guid() to find the
> first matching partition.
>
> This change maintains backward compatibility with the existing
> UUID-based approach.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  env/Kconfig |  7 +++++++
>  env/scsi.c  | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/env/Kconfig b/env/Kconfig
> index b312f9b5324..97cb3d05daf 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
>  	help
>  	  UUID of the SCSI partition that you want to store the environment in.
>
> +config SCSI_ENV_PART_TYPE_GUID
> +	string "SCSI partition type GUID for saving environment"
> +	depends on ENV_IS_IN_SCSI

Should we add

	depends on ENV_IS_IN_SCSI && !SCSI_ENV_PART_UUID

and similarly vice versa in SCSI_ENV_PART_UUID since the code seems to
handle them as mutually exclusive...

-Varada

> +	help
> +	  Type GUID of the SCSI partition to store the environment in.
> +	  Uses the first partition matching this type GUID.
> +
>  config ENV_USE_DEFAULT_ENV_TEXT_FILE
>  	bool "Create default environment from file"
>  	depends on !COMPILE_TEST
> diff --git a/env/scsi.c b/env/scsi.c
> index 207717e17b1..6182ae26679 100644
> --- a/env/scsi.c
> +++ b/env/scsi.c
> @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>  {
>  	struct env_scsi_info *ep = &env_part;
>
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +	if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
> +		return NULL;
> +#else
>  	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
>  		return NULL;
> +#endif
>
>  	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
>
> @@ -83,12 +88,20 @@ static int env_scsi_load(void)
>  	int ret;
>
>  	if (!ep) {
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
> +#else
>  		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
> +#endif
>  		return -ENOENT;
>  	}
>
>  	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
> +#else
>  		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
> +#endif
>  		return -EIO;
>  	}
>
> --
> 2.34.1
>
