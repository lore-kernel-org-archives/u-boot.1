Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2F5C9EC94
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BCE83935;
	Mon, 12 Jan 2026 15:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h6CkkXAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883D38397D; Mon, 12 Jan 2026 15:56:27 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A108388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b87108066c3so177005166b.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768229785; x=1768834585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Yc/MOGDIGMM9AFn8L/N69rnvdWpfx5NDgQ7WYIctVI=;
 b=h6CkkXAcqF+fBXjMPnpnhNyloDPq/AEce5Z9Fe7xJNSQ5+ew53VufHEEyR1bYyvBYu
 FVTHQkQC1W+kbUGw/Cl9Nv3qBpveJEMnuWg1ZFrEkQwjotjIWva9gbQwgAev+yj7p2r/
 IH6fH5QdJ4/07r0BZhbZGy4idQVww6oHFREJpCGBKCPRM52ittidzEhUTbuMyKPWSP9S
 0H9mqCC662YPjZv288AvdxnNA9nYpWDxgMra5Y+v38vcnQyJLfWs4Qc03kqA/VR/4t0l
 zqX2zUPVZXcFSZ37cXi6B21PmMAbAnZgvODWCB8+JqA+s27YqMsOGVQAcUL05X6EEz5A
 rEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229785; x=1768834585;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Yc/MOGDIGMM9AFn8L/N69rnvdWpfx5NDgQ7WYIctVI=;
 b=CWOY+PaaNwvenSTB+fDYHa4w6htyhkSdvI+otz01ENbbIqUy3txizRbxX11xFm7U4D
 R6QRVxTzwPKbEZz8FCIRQ6YwG6Z6HhsA4ifdF6d2DUViDZDijSyr7++LZs/S2M7djGvf
 z6EKpNvYNgw4xDqXrPvbT65Xyzfx9qrU3ytHM3dcRumA+HWXhKDpV1tiUfX/lI6M9ohi
 jPHrr96sYKhWjeYO+b6uwjCBsGWtAMv9rUmllsDNCa6nU6FCMRvb7hSJeno3dq+u19eI
 1eW+Ddh+wsHc/1epahml1nLZC6nLhBB0lm5aAmDPMiz2AcBau6yRukc8eUnnuSSXR5Bh
 JHMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG2YlpPG5UAas/RLLWMqZIrJD2As/VkVZK9lmBrd7XiXqFCovSEo+IdYv3cZHG815t1qSs3zg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7OTk0EyQrqRCyxNFsdeGyw7H6fLqFj1ttavfntpRBEHpB3ScC
 5jJ45d0u5S8KdJPROZ5cNguod9w73qZqc+hRF9gKVGtHB3sA0x1uoCS2QwsPwzaNMcezknYnZ3M
 oT/1blFs=
X-Gm-Gg: AY/fxX42Adf9pBHIOYLqWc2hkmEupmkoAyil+ZtNAu9MuNoEOeA9u2nfZgRsLt9qCrZ
 zEGuNDeKAssjx2JXKulklxNESDdEGtszTpBFyncXpe47znkLIlIPpzoofDlauP2L1B6WZx13STx
 DUXHNAhY23A5zugBBaqcyuPTakoUM6BcAx47hJkX0Pfw4ZgDlSDl0HTJlEMIpkO4rnTK/c3GSYO
 KHYjis69xYvaQN35umDe9gDtniMVcQyZ73lIi7npqdeEl4P6i8EL2taEXcBZa2u8SECBhu6Pybf
 MbOXIS9Cwcw8I6V/8Z69+6ZEu8jKJnpKlQH1r2jYBjMeU7ZE9fHqD0/0em80+l46iurcBSJeZ73
 GZEOgeM67WWjLt6dxRVC7WoFP0Q7IupLlJ2+vSk4tIM6D7eYw4ePBxCJcRm/3LUKP4gzXTPrQz0
 a6fSrC3Ij/nVau73ZZp9WRRiSiqvKdE30XaaXB1uWhqFmgNv0fFfs=
X-Google-Smtp-Source: AGHT+IE46FiX4TxYbK194LhwysPVFA7kEaWyHjREedAigYOPt3yitvEgX/wh3ZaLYTMFD2bE5mmerA==
X-Received: by 2002:a17:907:7b8c:b0:b87:14b3:7d6a with SMTP id
 a640c23a62f3a-b8714b37f5fmr394182666b.11.1768229784705; 
 Mon, 12 Jan 2026 06:56:24 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86ee5287e4sm733694766b.52.2026.01.12.06.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:56:24 -0800 (PST)
Message-ID: <22a44c3d-5a1c-4882-b02d-865763cab411@linaro.org>
Date: Mon, 12 Jan 2026 15:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 1/6] clk/qcom: Add USB related clocks for IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-2-varadarajan.narayanan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251218061557.1999367-2-varadarajan.narayanan@oss.qualcomm.com>
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



On 18/12/2025 07:15, Varadarajan Narayanan wrote:
> Add the USB controller and phy related clocks.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/clk/qcom/clock-ipq9574.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
> index b0af4036059..1f5146b29a1 100644
> --- a/drivers/clk/qcom/clock-ipq9574.c
> +++ b/drivers/clk/qcom/clock-ipq9574.c
> @@ -25,6 +25,9 @@
>  #define GCC_SDCC1_AHB_CBCR			0x33034
>  #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
>  #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
> +#define GCC_USB0_MASTER_CMD_RCGR		0x2c004
> +#define GCC_USB0_MOCK_UTMI_CMD_RCGR		0x2c02c
> +#define GCC_USB0_AUX_CMD_RCGR			0x2C018
>  
>  static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
>  {
> @@ -39,6 +42,17 @@ static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
>  		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
>  				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
>  		return rate;
> +	case GCC_USB0_MASTER_CLK:
> +		clk_rcg_set_rate(priv->base, GCC_USB0_MASTER_CMD_RCGR,
> +				 4, CFG_CLK_SRC_GPLL0);
> +		return rate;
> +	case GCC_USB0_MOCK_UTMI_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_MOCK_UTMI_CMD_RCGR,
> +				     0, 0, 0, CFG_CLK_SRC_CXO, 8);
> +		return rate;
> +	case GCC_USB0_AUX_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_AUX_CMD_RCGR, 0, 0, 0,
> +				     CFG_CLK_SRC_CXO, 8);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -50,6 +64,14 @@ static const struct gate_clk ipq9574_clks[] = {
>  	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
>  	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
>  	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
> +	GATE_CLK(GCC_SNOC_USB_CLK,		0x2e058, 0x00000001),
> +	GATE_CLK(GCC_USB0_MASTER_CLK,		0x2c044, 0x00000001),
> +	GATE_CLK(GCC_ANOC_USB_AXI_CLK,		0x2e084, 0x00000001),
> +	GATE_CLK(GCC_USB0_SLEEP_CLK,		0x2c058, 0x00000001),
> +	GATE_CLK(GCC_USB0_MOCK_UTMI_CLK,	0x2c04c, 0x00000001),
> +	GATE_CLK(GCC_USB0_PHY_CFG_AHB_CLK,	0x2c05c, 0x00000001),
> +	GATE_CLK(GCC_USB0_AUX_CLK,		0x2c048, 0x00000001),
> +	GATE_CLK(GCC_USB0_PIPE_CLK,		0x2c054, 0x00000001),
>  };
>  
>  static int ipq9574_enable(struct clk *clk)
> @@ -67,6 +89,10 @@ static int ipq9574_enable(struct clk *clk)
>  }
>  
>  static const struct qcom_reset_map ipq9574_gcc_resets[] = {
> +	[GCC_USB_BCR] = { 0x2c000 },
> +	[GCC_QUSB2_0_PHY_BCR] = { 0x2c068 },
> +	[GCC_USB0_PHY_BCR] = {0x2c06c, 0},
> +	[GCC_USB3PHY_0_PHY_BCR] = {0x2c070, 0},
>  	[GCC_SDCC_BCR] = { 0x33000 },
>  };
>  
> @@ -75,6 +101,8 @@ static struct msm_clk_data ipq9574_gcc_data = {
>  	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
>  	.enable = ipq9574_enable,
>  	.set_rate = ipq9574_set_rate,
> +	.clks = ipq9574_clks,
> +	.num_clks = ARRAY_SIZE(ipq9574_clks),
>  };
>  
>  static const struct udevice_id gcc_ipq9574_of_match[] = {

-- 
// Casey (she/her)

