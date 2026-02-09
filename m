Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC851E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491C28397D;
	Mon,  9 Feb 2026 19:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yQuQW5Ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0529283C54; Mon,  9 Feb 2026 19:56:57 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAA08397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4833115090dso541305e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770663413; x=1771268213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vOSpUgrV1uwE+BhJQEEIb70iUX8WfUpDGB5Ps65ZSus=;
 b=yQuQW5CthkrtWUC5+qBMUYacjtGKuTzd98ILkSv8jCz1GADqO5MaVLX2bJ+6Fby7x2
 AgRUdirohW5FL976JibnebdkWW3Lfm8AW8rbSWTNFa2PTfY26MNiqtP28FdxHxh0fgiU
 maUURBVEGyw6DjyfEpgei6cU1qcrdChSrMUkcA6REjeD6vtkmzd0piKTmTR/uac6UQF+
 iQk+ERKoeeItIx3lKwyJXPYIz/vwFCyoLTux21KY8/BNaBK8A7tKibYu+KEulLSn+Ai2
 f+x1vmBkyBuL4OpviD1t4TaezfeAG91gV/zpewiNAhPhcXq4aIrdNfCNWCbgKw4g5H4W
 zBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663413; x=1771268213;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOSpUgrV1uwE+BhJQEEIb70iUX8WfUpDGB5Ps65ZSus=;
 b=ISU4utNCWx7/6NGVpg7k6NoRVbFkLzsaP5DhvBELu8i3rQ1Vuaf667nFYaiB7raVLi
 PVuivbECRAWbpKhHKkJkFeorAM8eaB2B+Bj5urP5WAsWbi4iVJKyp9YQWJ4x7YKW1oZ0
 E7oD28WFOL2sYN584WND6ScthRge0Na0rm2A/HUiSzSOTLE2bhy8hGmDFOykhuobVvDG
 AmW8wW8ngJA872DzgoKFwXsk60iU5456SzPJyWNHEs/cOIrZR3bw5SWolamh57hawCLk
 c88P7oSe/WEv4oliI173aRI4ma1DRutUQDXKYYuMzZYVsP8z26auo84ZnCG1+itXnwRI
 Dojw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrwnqRplcBYZVqhw9MzckTNrYvEdWBu4Mb/IJ+QzDzXgzZ0rr2DEB4vzLKuF2utNHdTPlnccw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx2K7kJMg2yqlyUWDs5DcNNBmHA4n3SyhcYZ2KfEMP+22PABNQ
 0PAcwTi3MNJA7eAcYpxwZw9BVR4gH/Ld+9T5GxRq2Vghb6Q+CHQ8dzA4EkzBezDc5Bw=
X-Gm-Gg: AZuq6aKhslgI9NTSyy7daXtmYGgvMhV4Z2OarUNOQyloie3tCiTgwHQaJb4pQJg+VlO
 SSvVrWBLgpQbufdBPWUCls2y6cyWCzApXGV4ltqGB223V30KlgGZyflj1ha0AnFMc6NuYgrliAo
 elLyPOtVQaMwjL942UI+JUf47S8kJh7lhhsdAk2pv1EDbOFrRL0peyS4q/HDU/n8pvECcmy3s1x
 qM59snYGPIGnrDxSGwlG9p72midNqB/eAfIXP3JMJdEG0yZ2kA/WX9jM7ZyiYQKsdKucWeMGDC+
 kCtTugqhuIpWFnZyhRWQoIQr/4DMVobN44mSQHYdbOmsT6Wl8wuR73VorjXOi4uurzirJ1IvWtK
 k1EPpja7OGt3XZqS5aLlx4uc5huvA7HuU5h4g9u8rkEZG+TrP/OSHWTKROcIhEMpRKiYkPE2QWO
 fIKgPNqCaGIfQQh74GnD4+Z0JKswwdI5A5ssLK6yFMpBgWlcLBMhizCgGxnCtu
X-Received: by 2002:a05:600c:8719:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-4832021b461mr196354695e9.17.1770663412597; 
 Mon, 09 Feb 2026 10:56:52 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2facsm29069841f8f.9.2026.02.09.10.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:56:51 -0800 (PST)
Message-ID: <072d9524-4cd3-4a69-831c-d5df7e3d81b2@linaro.org>
Date: Mon, 9 Feb 2026 19:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] clk: qcom: Add QCS615 SDCC clock support and
 RPMH-CLK compatibility
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-2-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260126155938.2717540-2-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 26/01/2026 16:59, Balaji Selvanathan wrote:
> Add SDCC (SD Card Controller) clock support for QCS615 platform to
> enable eMMC functionality. This includes adding SDCC1 and SDCC2 clock
> gates, implementing SDCC1 apps clock rate configuration
> and adding QCS615 RPMH clock compatibility to the stub
> driver to handle device tree clock controller references.

For the sake of clarity, could you split the clk-stub patch out to it's
own patch.

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/clk/clk-stub.c          |  2 +-
>  drivers/clk/qcom/clock-qcom.h   |  1 +
>  drivers/clk/qcom/clock-qcs615.c | 10 ++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 117266ac778..1bc749e47b3 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>  
>  static const struct udevice_id stub_clk_ids[] = {
>  	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,qcs615-rpmh-clk" },
>  	{ .compatible = "qcom,sdm670-rpmh-clk" },
>  	{ .compatible = "qcom,sdm845-rpmh-clk" },
>  	{ .compatible = "qcom,sc7180-rpmh-clk" },
> @@ -69,4 +70,3 @@ U_BOOT_DRIVER(clk_stub) = {
>  	.of_match = stub_clk_ids,
>  	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> -
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 3a4550d8536..bc7e0453cba 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -14,6 +14,7 @@
>  #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
> +#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
>  #define CFG_CLK_SRC_GPLL9 (2 << 8)
>  #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..483642531ef 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -18,6 +18,7 @@
>  #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
> +#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
>  
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> @@ -52,6 +53,10 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_rcg_set_rate(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				 1, CFG_CLK_SRC_GPLL6_OUT_MAIN);
> +		return rate;
>  	default:
>  		return 0;
>  	}
> @@ -66,6 +71,11 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),

-- 
// Casey (she/her)

