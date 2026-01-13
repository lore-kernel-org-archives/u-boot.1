Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE58ED29DE6
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 07:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E47836A3;
	Tue, 13 Jan 2026 08:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozre0kVz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBJew96P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4ACF83655; Tue, 13 Jan 2026 08:54:39 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F39783015
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60CN5CNr3300067
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/E3z7dEIzTQY3oQQZz3lFDAr
 ZngxqNk8IfIEYrBXge0=; b=ozre0kVzMNj0HZWhGu9BMW+iwZV2724c3alJuu/L
 6Hn5uvgyk+YZSTVTVfcfPzxndQwT3o6yeOzs0xbLw6vpfGBCpd+K1KCnn32u379p
 im9RGuTVsODWpwi9Prc0Nzbtr1T3gF4to8c6n4O6o51EpyI4vHsedS9LuP3Pwk5V
 qoCBU1koY2A9ksO3vCopp618Jzo+W8NGQdD/JQfkrPxWppdTvpN05yfMehN9npOC
 DAQ9+RXk1b27tiHe4/dEwneJzvXkUfXvlBDhf2AifZ6xpVZTKwvFO0LQ5MAgxpfr
 tb9YSRQt9/5cDEbBwyypPpM/Me3GRySLgVEdRDV0FaLiaw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jm9vd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:54:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f1f69eec6so75183235ad.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768290875; x=1768895675; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/E3z7dEIzTQY3oQQZz3lFDArZngxqNk8IfIEYrBXge0=;
 b=LBJew96PTFASYOgSZIRL/6uYo7VppQ3Pa9V0+Tq9691iIdrt3XPmntSuruTorVn/1v
 UV7iFHbg7mnRkMG+4hZoRRLUd1Vv5zJh/iu+WyED2xTex0k5NsAYNQdIN9YsmPhA528Z
 hEVfrGdA1RNhu4snZh5ySXheZ2FJpcZHS2P47tqOIS7GoEQVUXsVaH+35CF2rSmsVOoH
 ooDvk0SXGpimm7XcowU3vw37tzQ+xxZXfdVdJjM8cAOvEtQZahpkuD88XFE3aHFe/lGm
 s3o+Yg90XGHlzZuJ+Gco7a5xBQQb5okGsvuNJEQEsgtWvlhlMvVcoW2NJ51Ih0hkZprs
 QxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768290875; x=1768895675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/E3z7dEIzTQY3oQQZz3lFDArZngxqNk8IfIEYrBXge0=;
 b=CwAiMSd2aRLVnNIekk6VjIgTwzr0L00sKxSNkQa/UZptIE2Q5A/eyGoECXPB5veGrn
 vu51EmIe0KuRAGD2fIUZWyxNmnfeVlYThTKsc4aITzzlOP4D7x761jHL9uGHi9AlIoOM
 rUvfNzRXZ3NGwI2yKfA2MlR31ivV2EBr+lt/VbhvmJNDdNY51UJFKY/mxISia2d5Z4a3
 b6rKqsgPZ7iPoxelM0xBvwMAogrAMq8+Bg8KQNLAY/lFrx9OKQr/THM53G0WiplXXPdc
 ZfeiI+CBdcdvTSf7EzIxeiVFyYG5c3qu/X+8fORqh8Ol3nA9g/YthMXczD9spVlJ7169
 OIpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYEmx/QO6DGdQaCo96mK9FtxFTLGaM7+3QC/H68Ss7CS5wioBzaOZkllpEhwL6PFUw/OmTCcM=@lists.denx.de
X-Gm-Message-State: AOJu0YxNeVrXI0y+8y6+eXvMvoL2RuXmiSZ2A0HOyqOWB+cEX0f05UGf
 MNr8JTKwwWV7gU1aumxsLlmHy+Cu4qqfDgx1LO9ooQ8wXYYgLnj4RaV66LtPSpPY6cz+5MvLrGm
 YDhnMvbnanSCFowyj46xrrpplCre042JhwjJoO7Gw7txDOdyJthJ8KWTj
X-Gm-Gg: AY/fxX4aEpIFaKeigQFqQ1IAPbBWE2ooqYDuap14iYQNgkKRZKtvve+MfBxkzKSYk2P
 dr3Mhw2CyXlZdiBPGlp5vkYhzRl6xjarBR2Gw3+XLM1HdwgYQ5rowOZTQ3mYdTzZQDjwv6nU+3r
 0T5liHmEwI78NmLPI+jcs43/AIWviT0SW1rNuUMPxSODYdwTMYxRaD3Y/jZ1wnpBb9RqfADHB5g
 SS1mvrjJVMUEjMORhCkYqOg7fUN7+wM4OztekMu4VQExq5gpj6dz9dk/i/TkQGSN9sWYKNnERXd
 3tDC9XqwK8DZeDQJSDLX8M/6RGZPOmH58LVG318h1aY4WE5YElaHtp/GN+q832SSWF4fbtjMs0/
 iy0bZoj45Ioh9orIqJyG6UK7C1rJQNIE3GDoxBxVY2Lwg8t8PJT5L0GyEcE7glaK29g3EG0ozxq
 KMIuEfGbx7b6zgxqBsjuwlsslXqLAKnd7sHm2EYvw=
X-Received: by 2002:a17:902:f544:b0:295:570d:116e with SMTP id
 d9443c01a7336-2a3ee48fb8fmr189442915ad.41.1768290874760; 
 Mon, 12 Jan 2026 23:54:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGja3NM3Q+/IE8SlvqKIIbnhOy5AexQ1kc78NgFZ43qcKeFKymfgRVdTTbs4oY3gwYhEEYgtg==
X-Received: by 2002:a17:902:f544:b0:295:570d:116e with SMTP id
 d9443c01a7336-2a3ee48fb8fmr189442675ad.41.1768290874220; 
 Mon, 12 Jan 2026 23:54:34 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47221sm192008095ad.23.2026.01.12.23.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 23:54:33 -0800 (PST)
Date: Tue, 13 Jan 2026 13:24:28 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 swathi.tamilselvan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] clk: qcom: sa8775p: Fix USB clock configuration and
 add resets
Message-ID: <aWX6NFQoGKB1ToYt@hu-varada-blr.qualcomm.com>
References: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-GUID: gZf-XEhsUhzRS1-dZinjL0_JOpuNgGSd
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=6965fa3b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XqitaqP_XcENPeB0qWwA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: gZf-XEhsUhzRS1-dZinjL0_JOpuNgGSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA2NSBTYWx0ZWRfX12vjKcK5avcP
 MWoO2Cn18fNAqV7dLICxpg3gx3tgsB5/en9V/pyxFzE+xBVEg+uG2zTazyfDjFfkds9pk/Zrjo2
 2Uvnpw9zPeICMBBJTJ7hYWxKzs/tYvp82sla+37E89YHSU1XswPP0eXquO6zNZVIoy/xwkTxXew
 u9s0B/5Gj1qkclJdF6/Pu45L1X8+F6PvXrbp/PvyGQfPedTpxVlka+KU8PvyCopT4olCLtbZZYZ
 UddHFz6LDspzY9Uk3qnepkd1A1nquYvZCS+dvHmaXcoXOyEcQqeYTAcRoNadq9lZniFmTrlhxUC
 BvRFTreo4cnb4yafkRcXks/cGdk/Nk7l+KeLFYdLhRfPSsxJ4fYZiP5R86yl0g6R3W6wiWGMBRl
 bQ6IH/+6DcheNNMZsgJT4tlZtFFLh52JLxfbpwIGHPDrnmRqmEEM3S/7LwbzAKli6TpsW1yoWlH
 RAImt/6IxSrEpP26RLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130065
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

On Tue, Jan 13, 2026 at 12:28:55PM +0530, Balaji Selvanathan wrote:
> Correct USB30 primary clock RCG configuration and add missing
> USB3_PRIM_PHY_AUX_CMD_RCGR RCG configuration.
> Above taken from Linux commit 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
>
> Add missing USB3_PRIM_PHY_PIPE_CLK gate clock definition.
> Extend reset map with USB-related BCR entries and video BCR
> for comprehensive reset control support.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-sa8775p.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 5a6fbd417ff..25c8cd4af9a 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -15,8 +15,9 @@
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>  #include "clock-qcom.h"
>
> -#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> -#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
> +#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
>
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> @@ -59,8 +60,8 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  	case GCC_USB30_PRIM_MASTER_CLK:
>  		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
>  		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> -				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> -		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> +			5, 0, 0, CFG_CLK_SRC_GPLL0, 8);

Indentation seems to be off.

-Varada

> +		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
>  	default:
>  		return 0;
> @@ -75,6 +76,7 @@ static const struct gate_clk sa8775p_clks[] = {
>  	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, 1),
>
>  	/* QUP Wrapper 0 clocks */
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
> @@ -157,6 +159,24 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
>  	[GCC_TSCSS_BCR] = { 0x21000 },
>  	[GCC_UFS_CARD_BCR] = { 0x81000 },
>  	[GCC_UFS_PHY_BCR] = { 0x83000 },
> +	[GCC_USB20_PRIM_BCR] = {0x1c000},
> +	[GCC_USB2_PHY_PRIM_BCR] = {0x5c028},
> +	[GCC_USB2_PHY_SEC_BCR] = {0x5c02c},
> +	[GCC_USB30_PRIM_BCR] = {0x1b000},
> +	[GCC_USB30_SEC_BCR] = {0x2f000},
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = {0x5c008},
> +	[GCC_USB3_DP_PHY_SEC_BCR] = {0x5c014},
> +	[GCC_USB3_PHY_PRIM_BCR] = {0x5c000},
> +	[GCC_USB3_PHY_SEC_BCR] = {0x5c00c},
> +	[GCC_USB3_PHY_TERT_BCR] = {0x5c030},
> +	[GCC_USB3_UNIPHY_MP0_BCR] = {0x5c018},
> +	[GCC_USB3_UNIPHY_MP1_BCR] = {0x5c01c},
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = {0x5c004},
> +	[GCC_USB3PHY_PHY_SEC_BCR] = {0x5c010},
> +	[GCC_USB3UNIPHY_PHY_MP0_BCR] = {0x5c020},
> +	[GCC_USB3UNIPHY_PHY_MP1_BCR] = {0x5c024},
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = {0x76000},
> +	[GCC_VIDEO_BCR] = {0x34000}
>  };
>
>  static const struct qcom_power_map sa8775p_gdscs[] = {
> --
> 2.34.1
>
