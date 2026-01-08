Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2CFD1489F
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 05:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2784D83A26;
	Thu,  8 Jan 2026 06:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENjSst+O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W97eSrCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E566383B21; Thu,  8 Jan 2026 06:42:51 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A220E83A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 06:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 607LrZHi2239468
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 05:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yAXx05eITjL7oubPrb4EZRnc
 7LaAiNca4IKtNbYBoOc=; b=ENjSst+OiVsUA5bakMA9hHtdXkVQC99jSMxf5I9o
 +OIuXf1YwF4a/Ax8w8JrZhoyz/lW5SyGsx2MFHG2F7VbGoW7MZDWm4uAH55vGdmQ
 6zogrsrn6KduwcE2YNadUicgcnt7tcRfUKWFQD+ElPdKHS4I7AaFs9jM0rwJ0K6h
 LjGJRwmfO0QO5ZZ/wRhxZEdtLTuspzGTwaZCKXFrkUIFQMFYLJQd7EFyDg02JHeP
 e9zYQCer6waikV88BfKaJ0hxfTSrCBmOhW328KMXX3REFjBlJ0out/0H1LkgRci/
 LqiRcSXicvGWRNJcEB0VOyCc86ZRqnKc1ajlQ8yAkjiXWA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg2ru6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 05:42:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c1290abb178so2722761a12.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767850967; x=1768455767; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yAXx05eITjL7oubPrb4EZRnc7LaAiNca4IKtNbYBoOc=;
 b=W97eSrCiBswJ/6F7PyuP7cub5jQSuocwnVn7m/9nUG2x9WossdDe+bIso1xBzZdF9P
 Vzz5yPzSXAt5MMTNMJLD9UecGGik9CJvdCafuKhXza5YAr14hpPG/38v4xmqXUj6Gc/9
 89YZefM2tJ6qqBWaoDQHTl6jlz9LHIzQwA6q0UxKOALrMr97Yw8loOvBw4cw9GNq4ejv
 EvPGxpGLZH65EISYodKvF6dw9qtXJsLsceeO3DjYC7dbRu99Wv8340g/EO4DtV6gBUja
 90AKo8YeXZ9w4zgm10yoqfB/4s7cFIoqZAQ4SOMlu6avE5Uu8xHJf2FFMd8pe0WJ1mS4
 ywCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850967; x=1768455767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAXx05eITjL7oubPrb4EZRnc7LaAiNca4IKtNbYBoOc=;
 b=IEbFXIXuDQBCggrceVluzddcpkh1A/xjldoC7RFdO8kWat+P8aqqZibsDuVJ0LRMLe
 2HVVNgDWPc496mUsznAvEGGh8Ars9MK4QTfsU5n2XoPwDE1nojToi1UhEvEQ/X+LpXTm
 kHLHR/yPYrHDj99zuKsIuRUWSIrJPVfWfCVz+/Cfjw8sG0jFE+N6OxH6JxDP0DogHQea
 z3r9U6hgo7JRbWi5iOLEZOUsO/JEKnL1lQEOce4VLyu7OceQq+aIoCDEUa5fGg4j0s6Z
 tfIyHCIJ21b0VRwBrncNltfzpghc2ydLewxkUKiPq/dFKpYIaikNR2TVPu7+obGPP0hs
 LZdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ4qEUDbMi4gWDf/guUFxQvk7MTY05BLbMBBU9hIDYbMOkzLEUIsHWGSaitCvxAAavtb+kTSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxiMJbaKc23F7f0CEDryMaMgyOb4U1JBYucgnwAQZPvFNgOwsFk
 3dE+DO4jaQ2PT6Pn2EFZmxl+sb8qotdcWu0NnghcR/dGmpxXT39Kv+sQTzu4sBov3rE0qsntn9Y
 gbpvK4rwcFc3jiSL8AOmExnNIgY2+Dw1xlOI++uD/oNb9pK7HrBpZQeUU
X-Gm-Gg: AY/fxX7zPsiKgtHfvIPwm2Mc9GSVzs5Ku5yhroU9ZYbVriw4MkNKN0GldkuPyLkV4PB
 rAWBYxZyM5J9XYPJsrNPYvVfsQCoq4g9HwSYfPxnydnfEmmCn0S4KWg8LMT7PaZlomfXxM2rKyD
 +YDrxkrBFAiy33ESWrDsptaAv3aLzXnt8zmmJNgEOHzstFbabnzQXnIDDiOGodxrGJWIbDbELq8
 eHptFrHDVkhuVABTXNcI4RcdYjosvYah7ef2yc3+3RFz5Du3eVmsopRj90N/T+rtAvyPqAhycO9
 YLXfPuqtidvdlYxB7fTY26ptUEz08gdNf+UZWZBU2PgUyUnWWv/BhIbu4Ovh5y+yVqxM9ctaIbI
 nLEPBM7eYCrljeFiFckpxMfW4pvUZ8eWwqx6KY2zpMg37R3+Wm7gqmdg4yLjjRQx8amGnQPjWuV
 arklwpAuUR0/w/m6tB+cMdYvaLxYgqC3xX8mzg+Rk=
X-Received: by 2002:a05:6a20:7d9d:b0:350:b8e:f9a9 with SMTP id
 adf61e73a8af0-3898f9b9aecmr4461638637.42.1767850966711; 
 Wed, 07 Jan 2026 21:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6W4ecFL6lqy6ADsE+ZQW9eKzVDzok64hlS6ApS+FEzCqZ4arLL8NnHrwzxvrGRKwECciirA==
X-Received: by 2002:a05:6a20:7d9d:b0:350:b8e:f9a9 with SMTP id
 adf61e73a8af0-3898f9b9aecmr4461611637.42.1767850966231; 
 Wed, 07 Jan 2026 21:42:46 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc95d5dbfsm6608546a12.27.2026.01.07.21.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:42:45 -0800 (PST)
Date: Thu, 8 Jan 2026 11:12:40 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: Fix fastboot buffer address for QCS615 and
 QCM6490 boards
Message-ID: <aV9D0OooxeEw6msn@hu-varada-blr.qualcomm.com>
References: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-GUID: JksJYWuKLl2L-h-MsCtE1bn7tcCCPJfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAzNCBTYWx0ZWRfX/j5b2+lLvVGt
 4p18S9ogPqLS6GrdPBIdq/xEW0TMpgKtHJrrIgVZIvPkp4Hi47AxeMAc5PRi6inkA/Y7pOcvu2H
 DG3ckVeT5vzdbScOp0WEM/qwvjue41W87CjqXv9YYyO1TbhVmwNWrYpX8cPmlkDF/4/K6h85ZVa
 /GaE8Bq1At87+S9IRMw6unV6aiD/7aWxgaqpihG0tcsCbi5Bn+6K98Mt3skJLOF/L02Q1mS9pmX
 xVsM0npbLQN3dKI5Zes/L/AjY4gwMiRoiSdMiUBrYRrjuoOlhot4zPwgU+E0CtP9Wi33pUELgmE
 KrnSRWIbPwtJZT/G/VSIz4WBbyn6yBT8cajeEiFrhh4P9eocg1/0PlNheMhelr5FtVlzrpcVWNv
 KFLBWIYWRu6QWvQCHbXK9z+iiTmeCOJg9Zj/SeWJsL50jVeMAhMpE891Bqp5Gy/UIgBszkJM+Ai
 m6NM/liywlfTkW0VphA==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695f43d7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8ZUhOTMT-iWY_zsi3uYA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: JksJYWuKLl2L-h-MsCtE1bn7tcCCPJfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080034
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

On Wed, Jan 07, 2026 at 03:20:38PM +0530, Balaji Selvanathan wrote:
> The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
> NULL pointer dereference during fastboot commands when users dont
> provide "-l" option in fastboot usb command.
>
> Set it to safe and sufficiently large region in RAM
> of the QCS615 and QCM6490 boards, to prevent crashes.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcm6490_defconfig     | 2 ++
>  configs/qcom_qcs615_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 54eb5dedaec..618098c8860 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -13,3 +13,5 @@ CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 2468267b955..14043b4f23d 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -20,3 +20,5 @@ CONFIG_REMAKE_ELF=y
>
>  # Address where U-Boot will be loaded
>  CONFIG_TEXT_BASE=0x9fc00000
> +
> +CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> --
> 2.34.1
>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
