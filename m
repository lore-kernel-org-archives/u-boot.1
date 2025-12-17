Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA79D65C43
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C68483979;
	Wed, 17 Dec 2025 13:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkKNfHHY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3ynB/O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A378183AB0; Wed, 17 Dec 2025 12:00:24 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D6283979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 12:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BHA8fGl1500904
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 11:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xSwQA24fh/0p8toF1HI5X/kj
 pZm0eDKYS86lErHMvC0=; b=kkKNfHHY2TRSXT8PdWOn8ea8ilc/27N1ce6ULJ30
 6XlzbfmyLlD0GsgCqPUy0fWhTOXFnqSy3pKmkwXof8+aFmhH2yAv40oY1zf1dDEm
 F3RAyoSdH1AIruYKcDRqhtFVpcfYXOxGJF5P/r7eACz39JnuoXPvKWe4qN6YQgz0
 zEaLgf5tdpqsF22ziHauZi7FCaMbQNE0eBpzL8JkeM/5EIWKOQIJZ3VBAeic0Daw
 Jls6N0HjkljqfgzbDXUiCg9lbx8Nbss4T+a8xNPxcqUSODtrYxLQt0EGwjhv45Xl
 CWZQibKs0i5PGJXGQDNEAF6W0b2IiNJ8cJckoptOKy33kA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3kkeshss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 11:00:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7ba92341f38so6454989b3a.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765969219; x=1766574019; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xSwQA24fh/0p8toF1HI5X/kjpZm0eDKYS86lErHMvC0=;
 b=g3ynB/O5xu+h6RPYLDDPAH3bKflDbb6oC5sTsjKnHIBGJRG6h6yBVys39a67/hd9K9
 TFgMNSKhM3PGSAvUT7ScX45cvkPBzqlKZOyi77S+B0fP0xs5aEzZarGh4xX76xICKNb5
 jVqVEIRNjVwCl94hnlkiwbkbWejvYPr9TkiCm95+vcDbYL88pI8NdAfgiXJXa5c7Q9y5
 XiM10aspAizm/MWyJVArPhyQhgL3tojMVFMj0FQc7PX7oBkj1/JHsrQifbTcWDYpnkd+
 +anlXggzXKoEjhojZIpVFoYQczxiFI0ZCXiwuqU9ybXRriOyrIVDqp/+kib7siSFPO1L
 GIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765969219; x=1766574019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSwQA24fh/0p8toF1HI5X/kjpZm0eDKYS86lErHMvC0=;
 b=uUPlMQ5gPFxMMgB9yhh9fZ7Hpe9jO1NZ88eOEXrHwBLW5hdPxKYhYmNQ0CmyNYGCO4
 6+fJN+hCu5mA2q2kUoNeLPkflzxRHDdnoFDwgpqzIoqTCR9fuILunTQCCNmhXlDEd9T0
 WcKeXnL2hfOYhfAyiTWcsVQmZc1AEyFt+F9P7KDHd+BZZyFFITbeNgT6HKn6z7ilDbMG
 MiDl4a6yoJ1WrwSKQSbb04G7/gkX7xeOiJEsayL92dYxG/VjgXXkdZ4Y30j7C+DCY8mL
 ayZN5N+m3tXJNKSW9orDKHKxfSINF6u2yu71F4HIJFwKSckSBo1TPdrC6Ee1LLeYcX3o
 EUGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8Ik6wNXnv4zj007AGQypF5QdjrHFIigvH9n9sPAlSZrELAtgTIzzrJ1AIZhg4OV9wU50Kjo=@lists.denx.de
X-Gm-Message-State: AOJu0YxmhmRbZe30g9zL7eDgWUqATTstR4YfPfWAcLSrrq+/aILiEP+v
 g5ADy9Dw/9q7pTgYDQlce3Ujr/S6WhxHoyQKP/PjKeU0hQb6kjGHN4KbQ9Ztwb+CoO7XIZ1p/yI
 4AaDlC07UokUuVuhZ2C116rh2qZRMl0uJB0ZaqYbz88Z4vzoRHOU91I1T
X-Gm-Gg: AY/fxX78b8tBR/OXFbD8KNIL3FQTovLvfsilwEceaPHE1JvwaMZs9UYOgW+c0+ODmoq
 d6P1QVnq5ToSuxI4Z4aGLKq+CHsmwYWXwKGGBZEbcMFBk2stbOi9uyzEs9WIldS4k6VbR6H7u5G
 zPfRd3Kvi+7Gf+KrRpjGlhZ7/V7IamDhtI8b+oZ19avfrPL4FOlpQ5XFxT49AdPwVqCpSWXwILe
 PHtB4B+R1VDx7MSMLWyUZjJynRGDkhEbTMV6HLhxGOzk6oC3z2Y5clL9IZaTi3FRXjxN9EKcsZm
 vrcl1cs4QynGgAycSOLKQPQaPBoQvteqF/dB12jty0flEnKo8FUrNNhd+RScE+UuBPO9ADDMyp+
 NNEIuZ1B14kPuNILPns5MTYsggPfHQfuEj12Luuq1Q/PywJtOEQjJTgVpCejO2w4NnwZU3ulQ84
 khl9djMwl+AjTmJvRCuBJmMOBrVmgbAYdsBpmm9jY=
X-Received: by 2002:a05:6a00:429b:b0:7e8:43f5:bd55 with SMTP id
 d2e1a72fcca58-7f669c8ba28mr14226046b3a.65.1765969219378; 
 Wed, 17 Dec 2025 03:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/LH9iqv6/XkJszcCIqPJ4b9erCz4EUXOS2crBk+4Dc8cx4t5rnRbVPcUXhYnSVj00CcGpJw==
X-Received: by 2002:a05:6a00:429b:b0:7e8:43f5:bd55 with SMTP id
 d2e1a72fcca58-7f669c8ba28mr14226009b3a.65.1765969218704; 
 Wed, 17 Dec 2025 03:00:18 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbbbd89a1sm2367158b3a.52.2025.12.17.03.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 03:00:18 -0800 (PST)
Date: Wed, 17 Dec 2025 16:30:13 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] smem: msm: Fix memory-region lookup, direct <reg>
 mapping and update SMEM host count
Message-ID: <aUKNPZU9NHcD9EvL@hu-varada-blr.qualcomm.com>
References: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4NiBTYWx0ZWRfX9LpD8ci0FAGN
 gg85rWGJsfSox2VpfVX6XQxqIZ3R4sUIllXUoKr7Dp0m54seY3+Nie9wYoHSty/HAznUZiG1Cj6
 EjUu6il5vXgxXFfbutE9X23ICF1cp3PaCYYPxzn/LXKSpR0OBxDZzwCDjTCEH/loWFFM1LfaiD/
 R5XQcMv/Up2kTFy4qtTIgw6gjBBaVFRJxQ0pe4lSVkIh+V+A1tEHvz7A+Epju10TEOZjC8pJUy0
 DYHjZR2L8x9OJLqbg7STYcv5YlyDUfZN+5cDOEb9Ptcp4/g86ICfrNo3kSvldyVNzaq9uvGNPqK
 j9ZFQcq4ey6iUCkssZOvuaJb5f8uJ9Z3/qrZnlq3NkihQpyPf3XPfpjOFmRSmvMGhPHFxS/EaHL
 l8Z1hSCO6gfUC5z4afW6rkv28S53wg==
X-Proofpoint-GUID: lCrmNxnNlsgyJLaSnr0wLu6zd9ByIj3U
X-Authority-Analysis: v=2.4 cv=Fcw6BZ+6 c=1 sm=1 tr=0 ts=69428d44 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Fj4oBCRoZbI8LasV2noA:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: lCrmNxnNlsgyJLaSnr0wLu6zd9ByIj3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170086
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

On Wed, Nov 12, 2025 at 10:28:51PM +0530, Aswin Murugan wrote:
> The SMEM driver was failing to resolve memory regions on some boards
> because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
> valid DT node. Modernize the code to use driver-model/ofnode accessors
> and make the probe robust for both DT styles (direct `reg` vs
> `memory-region` phandle).
>
> - qcom_smem_map_memory():
>   * Drop fdtdec path; use dev_read_phandle_with_args() +
>     ofnode_read_resource().
>   * Use dev_read_phandle_with_args() +
>     fnode_read_resource().
>
> - qcom_smem_probe():
>   * Try dev_read_addr_size() first (map via <reg>), else fall back to
>     qcom_smem_map_memory() with "memory-region".
>   * Check "qcom,rpm-msg-ram" presence to add second region.
>
> - Additionally, SMEM_HOST_COUNT is increased to support newer SMEM
>   versions that include more remote processors. This avoids failures
>   during processor ID checks.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/smem/msm_smem.c | 56 +++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
> index ccd145f9afb..b6b92d3530d 100644
> --- a/drivers/smem/msm_smem.c
> +++ b/drivers/smem/msm_smem.c
> @@ -88,7 +88,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define SMEM_GLOBAL_HOST	0xfffe
>
>  /* Max number of processors/hosts in a system */
> -#define SMEM_HOST_COUNT		10
> +#define SMEM_HOST_COUNT		25
>
>  /**
>   * struct smem_proc_comm - proc_comm communication struct (legacy)
> @@ -821,23 +821,34 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
>  static int qcom_smem_map_memory(struct qcom_smem *smem, struct udevice *dev,
>  				const char *name, int i)
>  {
> -	struct fdt_resource r;
>  	int ret;
> -	int node = dev_of_offset(dev);
> +	struct ofnode_phandle_args args;
> +	struct resource r;
>
> -	ret = fdtdec_lookup_phandle(gd->fdt_blob, node, name);
> -	if (ret < 0) {
> -		dev_err(dev, "No %s specified\n", name);
> +	if (!dev_read_prop(dev, name, NULL)) {
> +		dev_err(dev, "%s prop not found\n", name);
>  		return -EINVAL;
>  	}
>
> -	ret = fdt_get_resource(gd->fdt_blob, ret, "reg", 0, &r);
> -	if (ret)
> -		return ret;
> +	ret = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "%s phandle read failed\n", name);
> +		return -EINVAL;
> +	}
>
> +	if (!ofnode_valid(args.node)) {
> +		dev_err(dev, "Invalid node from phandle args\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_read_resource(args.node, 0, &r);
> +	if (ret) {
> +		dev_err(dev, "Can't get mmap base address(%d)\n", ret);
> +		return ret;
> +	}
>  	smem->regions[i].aux_base = (u32)r.start;
> -	smem->regions[i].size = fdt_resource_size(&r);
> -	smem->regions[i].virt_base = devm_ioremap(dev, r.start, fdt_resource_size(&r));
> +	smem->regions[i].size = resource_size(&r);
> +	smem->regions[i].virt_base = devm_ioremap(dev, r.start, resource_size(&r));
>  	if (!smem->regions[i].virt_base)
>  		return -ENOMEM;
>
> @@ -852,10 +863,14 @@ static int qcom_smem_probe(struct udevice *dev)
>  	int num_regions;
>  	u32 version;
>  	int ret;
> -	int node = dev_of_offset(dev);
> +	fdt_addr_t addr;
> +	fdt_size_t size;
> +
> +	if (__smem)
> +		return 0;
>
>  	num_regions = 1;
> -	if (fdtdec_lookup_phandle(gd->fdt_blob, node, "qcomrpm-msg-ram") >= 0)
> +	if (dev_read_prop(dev, "qcom,rpm-msg-ram", NULL))
>  		num_regions++;
>
>  	array_size = num_regions * sizeof(struct smem_region);
> @@ -866,9 +881,18 @@ static int qcom_smem_probe(struct udevice *dev)
>  	smem->dev = dev;
>  	smem->num_regions = num_regions;
>
> -	ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
> -	if (ret)
> -		return ret;
> +	addr = dev_read_addr_size(dev, &size);
> +	if (addr == FDT_ADDR_T_NONE) {
> +		ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
> +		if (ret)
> +			return ret;
> +	} else {
> +		smem->regions[0].aux_base = (u32)addr;
> +		smem->regions[0].size = size;
> +		smem->regions[0].virt_base = devm_ioremap(dev, addr, size);
> +		if (!smem->regions[0].virt_base)
> +			return -ENOMEM;
> +	}
>
>  	if (num_regions > 1) {
>  		ret = qcom_smem_map_memory(smem, dev,
>
> --
> 2.34.1
>
