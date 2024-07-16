Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DBAC3DA49
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 02:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D0D8880F;
	Wed, 17 Jul 2024 04:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="C+sTG0f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8B588768; Wed, 17 Jul 2024 01:43:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D057987EB4
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_jjohnson@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHf5TC027012;
 Tue, 16 Jul 2024 23:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N3QJ5/o/wDR3TZtIE94AfbmLbVWg1q+EHZ/P1r1AiVg=; b=C+sTG0f2IMrnTAlx
 4lk2QaJ4v/CcGvT5+BB4BGpLGPxpFumq8mOwZ8gnPNZInGHl+N6YXUaLmbKzDLHj
 2K7veyXTejKeunE66CPV9GkvVW4D2OGsK3W7xkpAf9hFrmAr+7eMDLDSMOuk7C5F
 4q0u2R2TYxypbZW1hi/eQMdk2YRi99/EQfzNwIO/fOCoT/bRKwkD1tyJm9IrZ5iq
 qf8w0m1c/zcyLLh7Ejuu2P/X/E3PhZyUkRXC78ctdGuN3o4vAB/mzO4Rj5ky2O/f
 9WskK7p8+NlIZgiGcwRgyczAVyL4JBR8p8c7KBE715OiYWbcWfSPPUteyC7z9Ull
 NFaZVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs0m4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 23:43:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46GNhZE5003908
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 23:43:35 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 16:43:34 -0700
Message-ID: <7145cd8e-590a-4260-a738-dc1a386e7787@quicinc.com>
Date: Tue, 16 Jul 2024 16:43:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmem: layouts: add U-Boot env layout
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>,
 <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <u-boot@lists.denx.de>,
 <linux-kernel@vger.kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240715135434.24992-1-zajec5@gmail.com>
 <20240715135434.24992-2-zajec5@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715135434.24992-2-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: HjDUvP7cKZSBjai9_qJv7ION5Anjs5h9
X-Proofpoint-GUID: HjDUvP7cKZSBjai9_qJv7ION5Anjs5h9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=956
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160174
X-Mailman-Approved-At: Wed, 17 Jul 2024 04:38:39 +0200
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

On 7/15/24 06:54, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables are stored in a specific format. Actual
> data can be placed in various storage sources (MTD, UBI volume, EEPROM,
> NVRAM, etc.).
> 
> Move all generic (NVMEM device independent) code from NVMEM device
> driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
> top of it.
> 
> This allows using NVMEM layout for parsing U-Boot env data stored in any
> kind of NVMEM device.
> 
> The old NVMEM glue driver stays in place for handling bindings in the
> MTD context. To avoid code duplication it uses exported layout parsing
> function. Please note that handling MTD & NVMEM layout bindings may be
> refactored in the future.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> This change was originally sent (and approved by Miquel) as a
> [PATCH V3 6/6] nvmem: layouts: add U-Boot env layout
> 
> I just adjusted it to the approved binding and updated commit message.
> I kept Miquel's Reviewed-by tag due to minimal changes.
> 
> I've successfully tested this code using it in both ways: as NVMEM
> device driver & NVMEM layout.
> 
>   MAINTAINERS                        |   1 +
>   drivers/nvmem/Kconfig              |   3 +-
>   drivers/nvmem/layouts/Kconfig      |  11 ++
>   drivers/nvmem/layouts/Makefile     |   1 +
>   drivers/nvmem/layouts/u-boot-env.c | 203 +++++++++++++++++++++++++++++
>   drivers/nvmem/layouts/u-boot-env.h |  15 +++
>   drivers/nvmem/u-boot-env.c         | 158 +---------------------
>   7 files changed, 234 insertions(+), 158 deletions(-)
>   create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>   create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> 
...

> +module_nvmem_layout_driver(u_boot_env_layout);
> +
> +MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);

Is this missing a MODULE_DESCRIPTION()?

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the 
description is missing") a module without a MODULE_DESCRIPTION() will 
result in a warning with make W=1.

I'll hopefully have all existing warnings fixed in 6.11 so please avoid 
adding new ones :)

/jeff
