Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7DCCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B277C84913;
	Tue,  5 May 2026 15:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F+wCs0RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 980EF84931; Tue,  5 May 2026 15:01:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1095684910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso57187295e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777986096; x=1778590896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7mVtcmOLTCTjSdVXmJc943u+qHqw/NenXjRnRYZDPk=;
 b=F+wCs0RItj/jeEkaAFpvyl+Q5Cow0YLsEY4ZtSAXQZ0qOW+VTxnq2erU9r0L8um7f1
 t120Kvq1e9bjrGarIIhWcsUD31PQMrcfgJ4LaDKvt0umrIEpa8KjjIFrp0+bAYfhmQIl
 EqPb3WtPAO3Tau/vjHNmqiPGdEUTbWNEXK3bXOA0oupTpmrVPhjST74RyN+vWqQ5KPAP
 YOk6wOVKG/nexx8zcKKaLO8KeHanvkAHK1wyXubzn5vVgo3/8gTlN0n+m4eBzv9z335l
 hgesGlbmQjwDDDMs4O02M3gZyxfy/XFkxjfReOvyCFeC+6cx15gQcBs3XTg3VJZrIk4X
 ksaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777986096; x=1778590896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7mVtcmOLTCTjSdVXmJc943u+qHqw/NenXjRnRYZDPk=;
 b=Monp1iRHEwWHWl+JCbHxeX60IuuN8qQdy41rOUHMyJu2Q0VN+fO8dh42fBDpiahF8O
 iGPAwz5TcxoM/2+9PcqRdWxran2C9SnpqK2SOZmMlQ+1rKI4KcAzQSW2GC+FEJf0Pm1p
 vnwbiJ2MRPO+iJsNs4TLDXvhMqTGJluHSNQ5y9Qez4xg4LCXTs8oCNLvFqosY62m93Nu
 suHnmDBkVlbNemci/fdZC8OEeIorzaqL4c0Ep1aTLaqvAhRBdqX3amhXwuvXp5h3D7XQ
 NgHsFg68lVzTuI3vVDNCdJ3S8/H931dB76du7cWMZ2MykMYrWpKTjJhIPPIpTYakQh0z
 stzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YNGRLhv4Cof57jq6jkhACTtcjNgKIve0yCVXTR/P1doqdHl/Va8R4U52EtW8rPuoDz581pyI=@lists.denx.de
X-Gm-Message-State: AOJu0YwmYSHsYlxAvprlOKVmrSfsXneCr4d7cVghAT5KBWXYvs1oBclF
 8ks/1/NSfZKVUZRgl/pAwTZp5t680SNqRMMrUqbP53LOo/IvTYRTpHANAgYVDcS1rtg=
X-Gm-Gg: AeBDiesfnvw+F6Z9cbaiHzOf+PSf54M9Id0H6r32c+jyxnx8hF+v7Wk4/DR62lU/Nqy
 P/9eWoZEXlKOp/TMU+PS4OlzfmSxY8tPTO52eI2rVKhraFZMRRLgrICSwx9TrDeC3n+VuplJvny
 L4zln30RRHMQmL7yh6XMzGF5i4LzKzbCbiWxL3MbtzHEJux3eoVIFNYCFH150gLAXTErqIh2OUl
 TDNne0QiTDclAcHf31Y6HAAN740OX62CK5v5gUyUI6oxuVRPrceVUnnEh9wBmIZEDf2Dc9NIUtI
 Sj2ezy9q9igCg0c47+Q/oqFBnt4OP/4UMN7CqosHXfmEX5Fmrq6OtjSC949eHfJvrAFLC6tZTgB
 VWUIms3cGZ1CQhlIfyzKIgA8i1fAOe5al3SPy4UGR/F4GOul34wMiSIqQ3lkAwminogznpZ5pnS
 J6TnWYPZdpRWRelLraKf2c7O9vDy5YqCVpbc7UM5sppXSut9iBqgiLlAXefqGtdqyhPAhrLiaXr
 pM0
X-Received: by 2002:a05:600c:468f:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48a98635f9emr231382145e9.8.1777986096244; 
 Tue, 05 May 2026 06:01:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14e15ce9sm18821735e9.13.2026.05.05.06.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:01:35 -0700 (PDT)
Message-ID: <b55ef4ec-d501-4f9f-bf6d-65f80a36b69f@linaro.org>
Date: Tue, 5 May 2026 15:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add UFS clock support for Qualcomm SoCs
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
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



On 27/04/2026 11:26, Balaji Selvanathan wrote:
> This series adds UFS clock support for QCS615, SA8775P SoCs and
> enables U-Boot to initialize UFS clocks independently.
> 
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, preventing UFS initialization.
> This series removes that dependency by adding clock infrastructure
> and enabling U-Boot to configure UFS clocks directly.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Changes in v2:
> - Sort compatibles in drivers/clk/clk-stub.c alphabetically 
> - Remove duplicate sc7280 compatible which was already there
> - Remove ufs_qcom_init_clks function and move the clock enabling and
>   rate set codes to ufs_qcom_init
> - Remove ufs_qcom_setup_clocks POST_CHANGE duplicate call
> - Link to v1: https://lore.kernel.org/u-boot/20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com/
> 
> ---
> Balaji Selvanathan (7):
>       clk: stub: Sort compatible strings alphabetically
>       clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P
>       clk: qcom: sa8775p: Add UFS clock support
>       clk: qcom: qcs615: Add UFS clock support
>       clk: qcom: sc7280: Add UFS clock support
>       drivers: ufs: qcom: Initialize and enable clocks before hardware access
>       ufs: qcom: Remove redundant POST_CHANGE clock setup call
> 
>  drivers/clk/clk-stub.c           |  6 ++--
>  drivers/clk/qcom/clock-qcs615.c  | 63 +++++++++++++++++++++++++++++++++++++++-
>  drivers/clk/qcom/clock-sa8775p.c | 63 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clock-sc7280.c  | 52 +++++++++++++++++++++++++++++++++
>  drivers/ufs/ufs-qcom.c           | 54 ++++++++++++++++++++++------------
>  5 files changed, 217 insertions(+), 21 deletions(-)
> ---
> base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
> change-id: 20260427-ufs_clk-49c917afbc6f
> 
> Best regards,

-- 
// Casey (she/her)

