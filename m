Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F9DC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 07:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA72F82E35;
	Fri, 27 Jun 2025 09:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p3OggJ+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E805E82E67; Fri, 27 Jun 2025 09:26:31 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785AA82B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 09:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DE7964354B;
 Fri, 27 Jun 2025 07:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52FBC4CEE3;
 Fri, 27 Jun 2025 07:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751009187;
 bh=+nJ0sqJuO9pfLvfaKAVxszSXE7S/30A6+FXGs/AE7mY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=p3OggJ+z3eFzUkNu33T8rPQb7kZzSqqfaxkHPzOkHSi4lsk+7lHl/CaHyGSy0C8HP
 CFi+tFGv14oK1LBNAEWck+wPyzGoK5vrcze+1gXBfHDGwS4tovUEArMKd8o9mW6es0
 iUABizuglwggppjw6C6ywASmZk1yL53+PqdUzfJMQ4vW4mNl/yjTe4JiBS8SSW3IMD
 +siwT2Rnfa1IrVLsD/nZVxh81CgLxDB61BS3GFixOEm1hQY3+9Iyt3PxU6hgTibpKb
 bvLLAqlv5DYugBPwiTpgyNzXE3YN6o6SkiduhQLgidnl2YGWa5P9kRAs25MKpcJ7hR
 e9tfEEJQedXCw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, marex@denx.de,
 trini@konsulko.com, s-vadapalli@ti.com, patrice.chotard@foss.st.com,
 jan.kiszka@siemens.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: dwc3: qcom: Add delays in UTMI clock selection
 for Qscratch
In-Reply-To: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 09:26:23 +0200
Message-ID: <871pr5y7a8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Balaji,

Thank you for the patch.

On Fri, Jun 27, 2025 at 10:22, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Added delays before and after setting the PIPE_UTMI_CLK_SEL and
> PIPE3_PHYSTATUS_SW bits in the Qscratch GENERAL_CFG register
> during UTMI clock selection for DWC3 on Qualcomm platforms.
>
> These delays help ensure proper timing and stability of the UTMI
> clock switching sequence, potentially avoiding race conditions or
> unstable PHY behavior during initialization.
>
> Tested on platforms using Qscratch-based DWC3 PHY configuration.
>
> This change is taken from this Linux kernel implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/dwc3-qcom.c?id=a4333c3a6ba9ca9cff50a3c1d1bf193dc5489e1c

Thank you for mentioning this link, it's very helpful for the review.

>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - Corrected typo in email id in Signed-off (in v1)
> - Link to v1: https://lore.kernel.org/u-boot/20250627044304.2223767-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 21452ad1569..4800eb64484 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -460,9 +460,13 @@ static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>  	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>  			  PIPE_UTMI_CLK_DIS);
>  
> +	udelay(100);
> +
>  	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>  			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
>  
> +	udelay(100);
> +
>  	clrbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>  			  PIPE_UTMI_CLK_DIS);
>  }
> -- 
> 2.34.1
