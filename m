Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAE7D148BE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 08:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC58383B0D;
	Thu,  8 Jan 2026 09:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2TXruQU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UBh07Nr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9051683B87; Thu,  8 Jan 2026 08:59:58 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B71839DE
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 08:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6087Q6PN1258448
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 07:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EbPPhp29zliopHcUq8rLzr1s
 S4za2OraB7V4XcyfAs4=; b=m2TXruQUbssdyk5eHZ+m5kfmWMKTZVpDUedCNS4o
 mS+Ek5wzbIbaGHaW7iWiGPVUeQkOGQOUn7LTLIQcN+nI8cSXOPdgdAOFRzkUBO4G
 v2ooK00kUG34chsPET3QCdeKKh1XZ4vPKqGCgXS/FulZlWIppnRkeV8Ftw7MdvLJ
 /LFA0LpjuX8iJPYPmQ2j/FKQrQaqCBlvEhtiERv8rTEqgx5VOEKcXtl6zDO7e4qz
 4hb47aFzmvXbRIPDKGlfEgpoHwcRfp41RMjMtfMZKTK9qXGUqY9UbT5E6EWk7fIy
 gew40nNIgDA4EvvAZDEaUzqahRwBH7eOeGD8O1cA2bxP5w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj86gr2vq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 07:59:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso4747823a12.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 23:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767859194; x=1768463994; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EbPPhp29zliopHcUq8rLzr1sS4za2OraB7V4XcyfAs4=;
 b=UBh07Nr10aKQ5wvL1/Z8yzpWxjUXvqq+FNcq5irOr5j9+u/iWZikPrYL0Z320nzKn5
 U3v8kSYFgevEFk6Aj67xzgblj5fkea1/BlGOcjoNuBkmeGLyDP5c44tbUwUPCC+wHpZ7
 BJoNxW+RjR/dwpuB+XO2SB2iYQq+KE3rDJCino0cDJ12za31tYJMN8cH7/IVEQm//1ND
 5v1G1C59R4dUQXiWyYIwViNI2RCkqaUbs181s3ky7xSAWKNLZaN/P+cG2xnzBVhNr7LT
 2rQafgb72TVo0fiSPwWTHAUh1rkjy70liRvqdHn4eICu37zJb93ubAYki2dnc5snHP56
 opRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767859194; x=1768463994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbPPhp29zliopHcUq8rLzr1sS4za2OraB7V4XcyfAs4=;
 b=khg0xNuKtmlFltrlnEpwe1dqLEVJQePWmgqHKNWkAWK49bO2sGZb43h9AGZ2i9r08X
 VuBcz24W5iCqt6SzYzq513s2EYxzEJi7DPVzCxIoGPm6KXhf6SlrYS3NRNfOA5/l1Lky
 ACD8X7gZJ7KvM3opxGL44k0Mc9tmBdopis1lOtol3y2x41Jz7WuWdtuMBVygYRzH4dL/
 rUQ+SuVoKTdsxUZ1s3RjUfMtqU36ZVertX06nQz70eYJPnvIcikSfDFlZrdEviMIgf63
 zFgNiUNH9baeE4futP3rSXfpyYHZp+Eg1pRZ+6YdS6VUzZFKbkgUdTwkyTOUBmqfqIFM
 I+cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ+/2MyL67hC3RyGvGrY13rC862xRYq03i37CilvjaSfyjZH9lV5CnCYFY1sxjYLdvU+dmUmk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1fq+G9k5wsBAXfyP7DEIbF9gYgiD2maJxSpSkEUNqEFlbf6ut
 SPrNseDC2f5HYFw/AGTmlmDW3vjTspxx99Yw7DHgeX0biLPt2vYJ2a4PGQuaGN7V+tI1l1iZN/Q
 Zieh+dhrfPw7t52m9GEGuJLeJDGaMemHUiXKyAYUDUEcP1nMcUDHZ061g
X-Gm-Gg: AY/fxX6j7D5r3+d5gxoP439cNMTwGT+o1b/Q1ziHMHSkxbDfeACNHYiIABFZNs2xaNR
 Px5DbFfX1w+3/wuIs9BWsckS6wcEIoO0v8nq+8SYUu+hFODC5LCYsDFqjUkFKI+XzdRCw/YDluZ
 ybHXfQEjdFtgM1F2Vqh5JrBA6q5ufy7efEb9PbqJoBVJhbFGMuFkA8TwkvZfcyZTudnZPiYPbDq
 +keQ4LGtQfDIoAC4B98havc6JzCGsVPBQzONpdgOk1g90xmAbw/RE4CRSv+axsAEWTD8N+tXPJ6
 C0YM6Br6DBsnAv7HKEjobusUbc7188BFTsbVWp/MVECTt8EfKg4Kpi4s2rroGUsPej+r/V80hYU
 02ofIOud8uleuV57AXIF2BFn9eaEuF5B/+jwpLOjJVtsFTTcOQ+JZ5atvqMrT1vAxsRXKJfse+E
 eLMcNLzVSlxy9hSpx3x5IafyTqyAKZfTfosLgQPvA=
X-Received: by 2002:a05:6a00:4c13:b0:77c:6621:6168 with SMTP id
 d2e1a72fcca58-81b7e53eb41mr4708290b3a.30.1767859193578; 
 Wed, 07 Jan 2026 23:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDhvIuI8eKLilH8BgLeMHf29cXavmn1XsY/rhBvXPW0pyrwbEQSnKNTJwCBFlFWoKg2BGcWA==
X-Received: by 2002:a05:6a00:4c13:b0:77c:6621:6168 with SMTP id
 d2e1a72fcca58-81b7e53eb41mr4708270b3a.30.1767859193071; 
 Wed, 07 Jan 2026 23:59:53 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819baa1969dsm6913440b3a.5.2026.01.07.23.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 23:59:52 -0800 (PST)
Date: Thu, 8 Jan 2026 13:29:47 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] mach-snapdragon:: Add support for fastboot reboot
 reason detection
Message-ID: <aV9j82/JfzFMn2X3@hu-varada-blr.qualcomm.com>
References: <20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZNjaWH7b c=1 sm=1 tr=0 ts=695f63fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ELy4k7POSWYNcTnjWosA:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: jQsSCFspWg9iT_ZPOHYE_BHHOMOkACgj
X-Proofpoint-GUID: jQsSCFspWg9iT_ZPOHYE_BHHOMOkACgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1MyBTYWx0ZWRfX3Pfvq/p2tyhq
 Z+zXhOn3GXR9XVVJ65+Oqj/1s7+/63ozcw0b27fM5cyXzLVAqwEiq02AXCayfZDpc1O8lupIPMc
 QUukq09jpPaGxfrKf2fHND/+0EaTfODEu/EJbbZDvh1jpKsKfnm2moGLi7zpCgXsaslAiRhmDvQ
 Cg4Q7ij4HtROhAx1xNP4V6fck4R6M//wHMjMRFbwlBO2u/Auf16UGRyZ6FIP8zPFH9LJDymXmo6
 B3C7uNHAvoh4rwMe9zGERBe5bvVWnuRWIAEccwXmk7zhjN0+IwL9e2B0GR84Ol20LfbDSfZ8y6w
 jIAahIks94xbST5DLioyy0qHY2gxWphucBuHk0uvdwMnPPFoAxVNdM0MadHlXKl3MunG80mxi8l
 uCIKes3xX8i29TXWyCfyVktpCwKr+1znkci7+YmqOHVP7Gj4ZWD1Q54pg+2pTlw7wy4mn6GkkH9
 OTkIO/qYBGc4DlkHK4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080053
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

On Thu, Jan 08, 2026 at 12:25:33PM +0530, Aswin Murugan wrote:
> Add functionality to detect and handle reboot-to-bootloader requests
> by reading PMIC PON (Power On) registers. When the device is rebooted
> with the bootloader flag set, U-Boot will automatically enter fastboot
> mode.
>
> This implementation supports multiple PMIC generations:
> - Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register (0x88F)
> - Newer PMICs: Uses SDAM-based PON_REBOOT_REASON register (0x7148)
>
> The PMIC model is automatically detected via revision ID registers to
> determine the correct register addresses. After detecting a fastboot
> reboot reason, the register is cleared and fastboot mode is entered
> via the "run fastboot" command.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 146 +++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..02b84297e05 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -19,6 +19,7 @@
>  #include <dm/uclass-internal.h>
>  #include <dm/read.h>
>  #include <power/regulator.h>
> +#include <power/pmic.h>
>  #include <env.h>
>  #include <fdt_support.h>
>  #include <init.h>
> @@ -32,9 +33,32 @@
>  #include <usb.h>
>  #include <sort.h>
>  #include <time.h>
> +#include <command.h>
>
>  #include "qcom-priv.h"
>
> +/* Reboot mode definitions */
> +#define QCOM_REBOOT_MODE_FASTBOOT	0x2
> +#define QCOM_REBOOT_MODE_MASK		0xFE
> +
> +/* PON (Power On) register addresses - Gen 4 PMICs */
> +#define QCOM_PON_BASE_ADDR		0x800
> +#define QCOM_PON_PERPH_SUBTYPE		(QCOM_PON_BASE_ADDR + 0x5)
> +#define QCOM_PON_SOFT_RB_SPARE		(QCOM_PON_BASE_ADDR + 0x8F)
> +
> +/* PON register addresses - Newer PMICs (SDAM-based) */
> +#define QCOM_PON_REBOOT_REASON_SDAM	0x7148
> +
> +/* PMIC Revision ID registers */
> +#define QCOM_PMIC_REVID_BASE		0x0100
> +#define QCOM_PMIC_METAL_REV		(QCOM_PMIC_REVID_BASE + 0x02)
> +
> +/* PMIC identification values */
> +#define QCOM_PMIC_TYPE_QC		0x51
> +#define QCOM_PMIC_SUBTYPE_GEN4		0x4
> +#define QCOM_PMIC_MODEL_PM855		30
> +#define QCOM_PMIC_MODEL_INVALID		0x00
> +
>  DECLARE_GLOBAL_DATA_PTR;
>
>  enum qcom_boot_source qcom_boot_source __section(".data") = 0;
> @@ -489,6 +513,125 @@ static void configure_env(void)
>  	qcom_set_serialno();
>  }
>
> +/**
> + * detect_pmic_model() - Detect PMIC model from revision ID registers
> + * @dev: PMIC device
> + *
> + * Reads the PMIC revision ID registers to identify the PMIC model.
> + * This is used to determine which register addresses to use for
> + * reading the reboot reason.
> + *
> + * Return: PMIC model number or QCOM_PMIC_MODEL_INVALID on error
> + */
> +static int detect_pmic_model(struct udevice *dev)

return type u8?

> +{
> +	u8 rev_id[4] = {0};
> +	int ret, i;
> +	u8 pmic_model;
> +
> +	/* Read 4 bytes from PMIC REVID registers */
> +	for (i = 0; i < 4; i++) {
> +		ret = pmic_reg_read(dev, QCOM_PMIC_METAL_REV + i);
> +		if (ret < 0) {
> +			log_debug("Failed to read PMIC REVID reg 0x%X: %d\n",
> +				  QCOM_PMIC_METAL_REV + i, ret);
> +			return QCOM_PMIC_MODEL_INVALID;
> +		}
> +		rev_id[i] = (u8)ret;
> +	}
> +
> +	/* Verify this is a Qualcomm PMIC device */
> +	if (rev_id[2] != QCOM_PMIC_TYPE_QC) {
> +		log_debug("Not a Qualcomm PMIC (type=0x%02X)\n",
> +			  rev_id[2]);
> +		return QCOM_PMIC_MODEL_INVALID;
> +	}
> +
> +	pmic_model = rev_id[3];
> +	log_debug("PMIC Model: 0x%02X (Metal=0x%02X, Layer=0x%02X)\n",
> +		  pmic_model, rev_id[0], rev_id[1]);
> +
> +	return pmic_model;
> +}
> +
> +/**
> + * check_fastboot_mode() - Check if device should enter fastboot mode
> + *
> + * Reads the PMIC PON (Power On) register to check if the reboot reason
> + * indicates that fastboot mode should be entered. The register address
> + * varies depending on the PMIC generation.
> + *
> + * For Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register
> + * For newer PMICs: Uses SDAM-based PON_REBOOT_REASON register
> + *
> + * If fastboot mode is detected, clears the reboot reason and enters
> + * fastboot mode via the "run fastboot" command.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int check_fastboot_mode(void)
> +{
> +	struct udevice *dev;
> +	int ret, reboot_reason, reg_val;
> +	u32 pon_reset_addr;
> +	u8 peripheral_subtype;
> +	int pmic_model;

u8?

> +
> +	if (!IS_ENABLED(CONFIG_DM_PMIC))
> +		return 0;
> +
> +	ret = pmic_get("pmic@0", &dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Detect PMIC model for address resolution */
> +	pmic_model = detect_pmic_model(dev);
> +	if (pmic_model == QCOM_PMIC_MODEL_INVALID)
> +		return -1;
> +
> +	peripheral_subtype = pmic_reg_read(dev, QCOM_PON_PERPH_SUBTYPE);
> +
> +	/* Select register address based on PMIC generation */
> +	if (peripheral_subtype == QCOM_PMIC_SUBTYPE_GEN4)
> +		pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;
> +	else
> +		pon_reset_addr = QCOM_PON_REBOOT_REASON_SDAM;
> +
> +	log_debug("PON reg: 0x%X (subtype=0x%X, model=0x%X)\n",
> +		  pon_reset_addr, peripheral_subtype, pmic_model);
> +
> +	/* Read reboot reason */
> +	reg_val = pmic_reg_read(dev, pon_reset_addr);
> +	if (reg_val < 0) {
> +		log_debug("Failed to read reboot reason: %d\n", reg_val);
> +		return reg_val;
> +	}
> +
> +	reboot_reason = (reg_val & QCOM_REBOOT_MODE_MASK) >> 1;
> +	log_debug("Reboot reason: 0x%02X (raw=0x%02X)\n",
> +		  reboot_reason, reg_val);
> +
> +	if (reboot_reason == QCOM_REBOOT_MODE_FASTBOOT) {
> +		log_info("Fastboot mode detected, entering fastboot...\n");
> +
> +		/* Clear reboot reason */
> +		reg_val &= (~QCOM_REBOOT_MODE_MASK);
> +
> +		if (pmic_model == QCOM_PMIC_MODEL_PM855)
> +			pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;

Why the pon_reset_addr identified in the 'if (peripheral_subtype ==
QCOM_PMIC_SUBTYPE_GEN4)' check can't be used here? Is there a
possibility of reading from one register and clearing another register?

-Varada

> +		ret = pmic_reg_write(dev, pon_reset_addr, reg_val);
> +		if (ret != 0)
> +			log_warning("Failed to clear reboot reason (%d)\n",
> +				    ret);
> +
> +		/* Enter fastboot mode */
> +		ret = run_command("run fastboot", 0);
> +	}
> +
> +	return ret;
> +}
> +
>  void qcom_show_boot_source(void)
>  {
>  	const char *name = "UNKNOWN";
> @@ -573,6 +716,9 @@ int board_late_init(void)
>  	/* Configure the dfu_string for capsule updates */
>  	qcom_configure_capsule_updates();
>
> +	/* Check reboot reason for fastboot */
> +	check_fastboot_mode();
> +
>  	return 0;
>  }
>
> --
> 2.34.1
>
