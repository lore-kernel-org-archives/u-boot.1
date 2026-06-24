Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC47CDB47C
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 10:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1EC847C8;
	Wed, 24 Jun 2026 12:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqKOdJ7L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FuO1iYMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A969A848DC; Wed, 24 Jun 2026 12:55:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF385846E1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 12:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANcO11148196
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YhzYDa1QbY1iFzr9wax75+0GVXk6S3Gppz5f+BC191M=; b=pqKOdJ7LgyOccUbd
 WWXeX3q5Ml7yOTahlpbTllE3ovdQshycjVbw2USyAPSaCH8KFBFANobIV2vFX+8I
 W0zoD7BTYq5NQEjFr+4jfo20jZFd8mqpLCNWSILhc5RYiHVhw4tXJdwW2knBRaj/
 h7+FGNc5wvPQ7FjyHMeIKa0NCiJlkkKvgTDCpUWFyzvyeKYB7mBbZpVvDHcZRuQS
 CchhoeydOi9E4KMRM0Fh/SyWV99P2+JcxXps8//lkHU4rceAg/J+ZPLrnwSEzLv5
 K1ickwbrnpeL4yXiUF96i0pNjh4hRj3GLmzoxenttxq8PXHtjFxSiCNxTXvJnAzG
 XSZ/+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r31q3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:55:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf11699875so11851835ad.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 03:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782298508; x=1782903308; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YhzYDa1QbY1iFzr9wax75+0GVXk6S3Gppz5f+BC191M=;
 b=FuO1iYMm6+d8lyr919Tf2QR7gyGZB1cgNMhtLiJCnfMv/B0NWRWbVB9KTNNZPBqWQB
 xA//TvxOB5T1ajUWNviMAiHVluAC5jIVK7ONUdxoJWHVk/k2YBqt0TBT6fNLepkTpB8C
 wLOCJeK3CQ9O0JxjFw9yGFABy+LNmz6Z87a2m3wn5l8RD0BNuttwgZ/FS8OoNCYIHuEa
 MyX1qQCX6zbq6ZqoquFNLqiVgciPmgwkDPnKVnLuQFnfzzBXFAgJGuOuodhC0WduOL+z
 hrwDyHyfl73vDJ8xDPSgYOhlXonslOC6d7A2acaE+9QpZaU8ErCXtqjHdqQTsz1AFvn3
 /elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782298508; x=1782903308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhzYDa1QbY1iFzr9wax75+0GVXk6S3Gppz5f+BC191M=;
 b=Wwsm3+G9SZjzWzoenXMumsELMERNeh+siVLiTQyIMwUkCl6GqtOITY261w49qbTjn7
 Ot5a37tnczIBVOLYoHQeCosvKAYrA+X+LDTrls7dI2NBNQ1GHvdt5UMlhoeHefFI6mHw
 rbFhm4dI0M6w6ijriRJpz73PG1DoFG5tgCYC2j2JwbkJW7UilXHdukk0CU9TTqvSOKR3
 D5+3RJMovcNlu6mt762BtKNpTvV3LlNewjZEysZjEyhsf9MWU20e0jcL5ijU+paNriuo
 aj0i4lEkEoIA3fQD3nNM/tTyKNNJ3i2eepXEoXCMI/XCqDc6YLuZ3HlBJmPqTojaUOhJ
 l3Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKsAibDFmtJFikxaeq9jDHw3OAO4jdwubm2rZtjpTSU8Xoo7O1ZlL9vP+Q8dhpsjgNx8IE3j8=@lists.denx.de
X-Gm-Message-State: AOJu0YyFQg3YnsDRpUkBDzxuQhR18CJTH/Qe3/ZiDEqe5MRRjnLrUKGg
 kd5cE7SPyaj3A5L/y9wjYAk0vuJ5flVhZnp6zmd855fpKf3fRKjI951j6X/bzqlPrZT2GTqM/W0
 Onf6WPQrS2pMxhNdvQNVFhaSSYBZ1S2znOwTYraMPIDy0+XOqMHbbKXkC
X-Gm-Gg: AfdE7cmtEzO2GdKoGAZbfQIF5Jpv6cMQUCEuivp15lIHSRnePq5fTsjkqMebJNYL+sM
 AYIZBhaRAR5qvNk0xFEgzbGzRo8ULLxXS+cKTgUZ8SlFWzjXt8oPR4tlo15TECW7LaFhTWZ36Y2
 JZ/ZHnsrDSgb9cAt0YH/cf1u5qHk4N9GjSiKuI3niFCjlOxmNvHhTyYbW7Jgau1furrsUniSGTV
 nYzpS3XTWZ5TxrBC51XbUWfK2HkZpCtxPipj05e+9KXt5+IjDiZWu/OxJN1tWVx/j5Xt5sPzu55
 7w754/06E/7TdcVtpQCP7ngsbW97yDsP9jAxGiGaSAu2uILmsVc/GkM9U0mPv+W4FT2rwNXkbuA
 nfng58Y1Bng2JkkYfYf+U5TOXQLr4Zqoe4BI+Rpt3UTbInN5T
X-Received: by 2002:a17:903:2441:b0:2c0:d29b:34ff with SMTP id
 d9443c01a7336-2c7c3d5fe99mr63879695ad.10.1782298508245; 
 Wed, 24 Jun 2026 03:55:08 -0700 (PDT)
X-Received: by 2002:a17:903:2441:b0:2c0:d29b:34ff with SMTP id
 d9443c01a7336-2c7c3d5fe99mr63879395ad.10.1782298507757; 
 Wed, 24 Jun 2026 03:55:07 -0700 (PDT)
Received: from [10.151.40.144] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7c7411f85sm45093945ad.22.2026.06.24.03.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 03:55:07 -0700 (PDT)
Message-ID: <95fb2056-aa96-47db-bd58-3faa870071e2@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 16:25:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: qcm6490_defconfig: Enable SCSI as the Fastboot
 flash block interface
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, mani@kernel.org
References: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5MSBTYWx0ZWRfX9bFxkHMYK8Fw
 Tptbx2kVERPe0eYB19ragzuuNoG/HOjeXFfcMMA9x2dpRri1UHNPrOMqbfKhRWAFEKRQ11sfEmR
 uEdWDkx4sqqKBc2ttieoJyGdA164QpWWVPvvyXJFjq9VgxAhVesemtecPRacHcM0FPPwXGlVnOk
 lkajIFn3U8b/5Hgu5QixaB6zPx6d3kCiFNUWwOs2VAKbNWgsIu/WiwNeZSecJz/0D03Oc+J6PYi
 kSHUiByjVbmBN/ioA9GSWtaeJrHJmMdOEswnBHNKLXVHHjfJ5QTX3Vljo2/FfRNEAK/C7Tr6b58
 37D/HZKhnoJbjOgM1pjJ75yVoC8UmQPIvlfKYuORrhQefrJz4Z0uhvqTytjD5vZFHebDBTotAf9
 8uTh4L2ccSFcMdk059srU2dnSWVRDw==
X-Proofpoint-ORIG-GUID: UEvImVJYlwGYSioxPu8I04Lb9ee6it6Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5MSBTYWx0ZWRfXy6shb4jB82uq
 8JRhmmQKH2migZpeoAyQhSBoKdjk14QBt48gmEa9Bd7oaayunG4wWMk6MzlqvCOYaOhRhIJXGw0
 r2IiqCl7e68xkIOMr4jPqkggc6LHV80=
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3bb78c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KWi98b1VZoOImPBiGIIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: UEvImVJYlwGYSioxPu8I04Lb9ee6it6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240091
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

Hi Manivannan, Casey,

On 6/19/2026 1:04 PM, Manivannan Sadhasivam wrote:
> qcom_defconfig uses EMMC as the flash interface for Fasboot, but QCS6490
> RB3Gen2 has no on-board eMMC. So override the config to use UFS as the
> flash medium by selecting 'scsi' interface.
>
> This enables flashing the images over Fastboot on this board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   configs/qcm6490_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index b088367f86c..d599e7611c1 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>   
>   CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
>   CONFIG_PHY_QCOM_QMP_COMBO=y
> +
> +CONFIG_FASTBOOT_FLASH_BLOCK=y
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0

Similar patch is submitted and under review: 
https://lore.kernel.org/u-boot/20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com/ 
<https://lore.kernel.org/u-boot/20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com/>

Since most of the Dragonwing boards has UFS as default, we wanted to 
change default to UFS in qcom_defconfig itself and then for eMMC boards, 
we can modify in their board specific defconfigs.

Thanks,

Balaji

