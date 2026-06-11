Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AADFCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0668498B;
	Thu, 11 Jun 2026 14:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="opsFg8Qb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSTIdC9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6B18407D; Thu, 11 Jun 2026 13:35:43 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36D9838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1SV7168127
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LF234YK9iPh4RxAo9pyBBfaE
 jHlH47t6T0Ymzo73gAQ=; b=opsFg8QbTBMsciRybB5o/bVLwYDlAnKaXUasTsVQ
 YrSUVUS01oP0ub1SpQTnjKuO/4hpwS+gqIQdREv6FzmQapsZ5+OoRyL4SOwWSy5p
 sSpsXss9oygdEUjy+L8o/5Xo9buBvt4GErdVdgHacR7ie/IwLNqvsofrEkKVxoj4
 yVb8KbaOq8huIr9Ei888FNebEHtNNfHav25T/VAtajLbrs1tc4RoDLbrnHhRlrQn
 47qqArJLQKCNA6CH5mh+IHmvkuYeQQfOE60enBQwwOJ/WZaWizLjw5ZaXIZad2pr
 YXXwXuPw49VY5nLdxvxGQs6hz+8fibmgIPSbUz8RIkniCw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ub623-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:35:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-842688fa7b8so908669b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177738; x=1781782538; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LF234YK9iPh4RxAo9pyBBfaEjHlH47t6T0Ymzo73gAQ=;
 b=FSTIdC9oVIatd2eifP9WKTnSNEj4knr7Pr/t14ZXYIRfDP3aKYgu43C1Ahmg6DZhC2
 6QeVM/BEqy+x0lYl0DFlyaYVKHlzbU6m9SaBOgFhgzE6cYlkdaXOfbsCRHtr2xcLRWHn
 W8WlVlxFgSIo2U0wRKpfd17P4mn1AV/Uq87885FQ3YNMqLjyYGxm6mxlWUk3uD9F6gay
 EsW+m8VmU8oF07aW+ZFjYhcwexPkIXOA1vq5KiMc66M9H8UFnmB1y1Cbwe3gqHiRF0z9
 j/6305ZmDUCAaqi2oojLmowMqox+8gtDw9tVSMIYWcSdFKcKiPg/8E22hXjgGPPicbnn
 DJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177738; x=1781782538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LF234YK9iPh4RxAo9pyBBfaEjHlH47t6T0Ymzo73gAQ=;
 b=pTD61NDO0G0Dttfv1kWZOKSCTWR0TMiMpZzXE+LxUIPcbTfGz8MvEklS35IuLILs1k
 +YL6s55xPrSnJmvXVnW6shzNKVHlOJpW/cF5bRt/pZrRKXKWYiioGe4HAf0CO+ds8lJa
 1FWAQezl2yvPzqWI4ucFX5kovzMiYVbPxu+nAGaFSdxnfOOXIl9WDfGa+3iCx4L6m+iz
 3pWYNB6CS/9uvZBgYPlulmLKO0lIkvgNPltePumgTUu0Uz8byRqV6FJeMXBq2Ob9rCwW
 utOhSiDY4x9Y+zDOBzonADlO9XeZo7RZsH/ML6X/YOoj47NYPlTJ1gY5LWi0aZbLO4XD
 q07A==
X-Gm-Message-State: AOJu0YydZfbL/mISd5zG4SNthMINSWjN66OXIxOz6cQoFk5NHOpf0aD8
 gLI7Q7T06uf9Srhk3JkUF9gqdjzwQ7E7wPWyHpjLUlzPFdwUVZfeINhmo/yrTmCFnD5utK4T7gI
 za9gO9qH+00bw8IPr7DhDb5rvzLxZPHlaDbpBB1PbIr/9K3TFgwp/bYG9reHHbtB9
X-Gm-Gg: Acq92OGxCfxSg7GB21Aotr0ywMxew0ZLrTiycMw5aTnySyC99TROk8qkAJXjXOEixuw
 kGCTjRoIReFzDNmZqijEtwFRhDphyrX4J+atB/xc9+IIau9llOCaLlLC944ziyG10PORTbyTAd9
 djx78llOd/WL++FbBDA9tNFnf+XL2jXN6Mpwp8i+X8i4T6VXgkJBTGF7cO+paMVJrc9DDkjJA4z
 ELUdQfhxrZynG2a0WLZU6BzKtPi9U8sfcTC619PyFlp8hzFYXlS+7g7SHnyJXTq5HoRzJednCF+
 vHY91j8nfkHzZNj+iGDz+g+O5uP4/4wVfGEC5uDoCE4nzJJkL0DnYPYhTtlm/4lfleMtp58nHFK
 RiQU2pAb26gsmfk3E1b0ASTOi1Rmp/yoTfIdVJGNKr5UkPuWrpWIfoeZZaDsqHuoji5C/sLOoIs
 vrmz9/+qkCJJzyWVHwaPs67rlkVr//dMhipiSm+jgTSf7jqGBP2Nx7HIhKnLqwww==
X-Received: by 2002:a05:6a00:1395:b0:842:6344:f33a with SMTP id
 d2e1a72fcca58-84336305a0amr2392666b3a.3.1781177737819; 
 Thu, 11 Jun 2026 04:35:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:1395:b0:842:6344:f33a with SMTP id
 d2e1a72fcca58-84336305a0amr2392638b3a.3.1781177737349; 
 Thu, 11 Jun 2026 04:35:37 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337bba740sm1836702b3a.23.2026.06.11.04.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:35:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:05:16 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2 07/14] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL
 build support
Message-ID: <aiqddHG5cJP8xXg1@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-7-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-7-72fed24ef01b@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfXyZqKbE/4poPm
 9JqWF4EBz6SURWCCLSfuHZlnCT/ujFt7Mol035SLZNXi34rMqXfR8iA2GLiL5wfItWg37dJY0SC
 f+lRF+nvQtOKj8/s2VMj9gqsTi54jmE=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a9d8a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=-JHaEULF_RrlGKziaLMA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX9OKjBQzhtZMX
 WOi1PeMTHY8ZMhfI2U1IA300h80zsGRoTePquXtjshHsfIyZZSGr8qJ+GRBBvrjeFawpIyrbhSZ
 n0qJrzD5rvi+3GUWRnPwNz764Sb7WV8jUb8/H3LwXR02H6UygdZvArx1TXZGOUgMRBzsFbXYAOc
 q4AVmAV5UlR3Zh0eXZdUbOGp8m1NPNyoKdTj9E2uOUYoA15GAfUVakA0XbQs6VxR9lRUSWTBPT8
 6rQYIXyyJQDlTD0G1Lc4ZPCLRCmknv3RsuSa0UxSdaKSXSQIhNf2hMqEHXQwvGRQ+bZ3bghOYWt
 KSxew9MqJZzF1UG7MIl9SC5j47YcGHJ0XO+forlKWFr3hbqzI/ALS2/Rm1+mnERM/90BcHzd41A
 XoOIYM9s7+ou2heiOa88GQOR/26keS5lpQeVQRy0XAaB/8kZzpc1yR2XmvEvulsoAtFNF5UmGgZ
 GEzuhmTxPa/0YZvtxzw==
X-Proofpoint-GUID: z_sYDs81nKD47MyXkCMHSeOUdOhrIsId
X-Proofpoint-ORIG-GUID: z_sYDs81nKD47MyXkCMHSeOUdOhrIsId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110116
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On Sat, Jun 06, 2026 at 03:48:38PM +0530, Balaji Selvanathan wrote:
> Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
> host controller driver to be built for SPL on Snapdragon platforms.
> 
> Switch the ufs-uclass.o and ufs-qcom.o Makefile rules to use the
> $(PHASE_) prefix macro so that the correct config symbol
> (UFS/SPL_UFS and UFS_QCOM/SPL_UFS_QCOM) is selected automatically
> depending on whether SPL or U-Boot proper is being compiled.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Modified the Makefiles rules to use $(PHASE_) prefix instead of
>   using SPL_UFS_SUPPORT config
> ---
> ---
>  drivers/ufs/Kconfig  | 8 ++++++++
>  drivers/ufs/Makefile | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 64172454bc6..0e03d7ef438 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -55,6 +55,14 @@ config UFS_QCOM
>  	  This selects the platform driver for the UFS host
>  	  controller present on Qualcomm Snapdragon SoCs.
>  
> +config SPL_UFS_QCOM
> +	bool "Qualcomm Host Controller driver for UFS in SPL"
> +	depends on SPL_UFS && ARCH_SNAPDRAGON
> +	help
> +	  This selects the platform driver for the UFS host
> +	  controller present on Qualcomm Snapdragon SoCs for use in SPL.
> +	  Enable this to use UFS as a boot device in SPL on Qualcomm platforms.

Line wrapping seems to be off. Please fix that.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> +
>  config UFS_RENESAS
>  	bool "Renesas R-Car S4 UFS Controller support"
>  	depends on UFS
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..c15635c01bc 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -3,13 +3,14 @@
>  # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>  #
>  
> -obj-$(CONFIG_UFS) += ufs-uclass.o
> +obj-$(CONFIG_$(PHASE_)UFS) += ufs-uclass.o
>  obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>  obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>  obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
>  obj-$(CONFIG_UFS_PCI) += ufs-pci.o
> -obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
> +obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
>  obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>  obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>  obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
>  obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
> +
> 
> -- 
> 2.34.1
> 
