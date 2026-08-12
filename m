Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37379C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 12:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD4B4608F4;
	Wed, 12 Aug 2026 12:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niW6nIq9IAAW; Wed, 12 Aug 2026 12:26:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE7BB608FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786537613;
	bh=3lBm9hn9Jc6GzJ2l9rwEBFsmIKrXeTBrYAGZzR00Oj8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bcksPpItTvvfkmK/oE/c0mVIs85f4A1+yU6JAvurHYhLfSOUSOUwqMC0tsI+mJ7BL
	 GsB3beSQuneHCHqCTfbWFvk4JAUBqv5soz87AQbeT140EB4lvoYn3rU7eChIV6OtNH
	 GLQD1emSq/zUEJ6MovZbC4b5oMCUnFoUL6Qp4WGSKssBZqOKxvg3IzSi7wkzJAy1V+
	 Qr6olDaKaxsvWL1eaci3Ak32UhCpY5ef1X9Mrk4iSnLWaawZNW3dtGqeAUVfdIX00m
	 jUOgEdsfBGFB+F0LpBSINOJ9cF355wHZ73IiQqExxnx83OmUVBF3DghyNqe69lx5Nm
	 kQC/Un1TF4W8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE7BB608FA;
	Wed, 12 Aug 2026 12:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3C2223F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CE0B403B7
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id px9aNXEjP1dE for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 12:26:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38F71400FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38F71400FF
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38F71400FF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:26:49 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so596683f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 05:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537608; x=1787142408;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3lBm9hn9Jc6GzJ2l9rwEBFsmIKrXeTBrYAGZzR00Oj8=;
 b=H1GahJ1VdMrQgHGFzre+5X64QBTSj2ajE9UNNYivTK3ckWmTtM29gvo93etdPb9Ajn
 zUOkb088rBm4auO/TmLBQZ6JVSu5rZd2KjNR1KqDfD9NHE/Fj2V+CUlPFn7nhV5/Ko1x
 aiEFCRkOoDJW5lkKoVBjlvNzcLIVlBfvv2yqcF/6dhTsZkpqWHxIy7D5i9cREe0KrVkz
 OrNguQHa5dhQ6D0Fh5S8OpKUMrQZc9zfRvYenuVhoVP1kj/k32B1D4q6JIrfsuCzqgLX
 WRW3sj7drIibFXIRDB2iHwdBEq81HzlCbFCEbkB8cBMYyIITvG7/dPdv4V2hsUG2NYbJ
 PhGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnXbUJqVbrx6YTNfM6g87VdwLRLfHfTXT01TW5exImx70b/kMDixs4XoUujsDwjF3Y/f3G4RE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzf4MJc6aRurr6x/gMTIC5k718odXoHoXVXhIrxTiXCM3lWO9D1
 00HqMyOYydGKr7eBKDCmHebMMe3CsPN7v1sgbYld8OnrOip+qry435LX631sNWwZ3D8=
X-Gm-Gg: AR+sD13arN8k8SnU4csHXFEJ+Ft2drxMIeYpdTXpAlOyGCjM5dL/NReX8SO13tDHs2P
 aZ9yfDTy1QjchAQVXwU3lukKMF+P355piH1vKBnAlrOSZj4Ka+sT56KUmvPIlP9IY15yy1XdaOm
 2VN3QM7IreR7w/367unw4IIwqZaI/4tqqhmnGorYBgkSaQ5XA4+8UCEOrEiofvj8JixlOU+yOOG
 UFv3VFMsiAc3zFoOfuHP40YjjzeYvEakQtw/ucfI3r7V/8B7Ux3VsQJwCend/jvXRYq0bja15gS
 Ga4J5uiLrorzb6RtZ/q5RB9U9ep3ZFKPdvovcI++DjySO8J3F+W+2fyy4bSCigr0fDzLnFGQgAZ
 v6hWvdpAYO2Y05HLAJwwuwe0ZRpq/KwAJAPwQGFW8bifplOvFyn3a+QT5QehksWFrDSpVD1bjVS
 G2sC8mibxzJ9VyNHOZXsCF+lg6DBsyCDigORq1HJECBu/K7QmuEM2kwEGqMyA6rEpciz5chpLd3
 mfebOgwzGl6NFAEgM27cz9Yr1/A6PXE6y1Kfh0mbZ90
X-Received: by 2002:a5d:64c3:0:b0:47f:93b6:8d06 with SMTP id
 ffacd0b85a97d-481528d2a85mr6190269f8f.0.1786537607881; 
 Wed, 12 Aug 2026 05:26:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:405d:735d:801e:de34?
 ([2a01:e0a:106d:1080:405d:735d:801e:de34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5c13sm6854368f8f.7.2026.08.12.05.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 05:26:47 -0700 (PDT)
Message-ID: <0a43aa51-1921-4693-806f-eb595fc8e2df@linaro.org>
Date: Wed, 12 Aug 2026 14:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/7] clk: qcom: Add shared RPMH clock driver for
 SM8550/SM8650/SA8775P
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
 <20260812-b4-monaco-v2-1-865d288c0be6@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260812-b4-monaco-v2-1-865d288c0be6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537608; x=1787142408;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3lBm9hn9Jc6GzJ2l9rwEBFsmIKrXeTBrYAGZzR00Oj8=;
 b=qhWgORzvV8ZpBPyibAMhAsZjafHU3D8ohud215ipnIX/ZJOH+3mYPCTUhv6Csca1Cf
 kGFYuXGEbpzSloEIQUzPSqjZX7JRJrRCMUQGG0O6rJdCvz9486Ny0e5tNsgW3RG+Jttn
 vZ388gW+zDQSygceRYnS3ubnc5R9m68RIAP/M7BG5LM633+NNRwcVv57iFq2BIZCb+A3
 7LbWqjH3h0frCqRg1W4FxGqxmbFAJo3qCO/CpgoeIr4azVPiOSCA/2xzhuBq2+/sMfbs
 Ecx7NIFv+cs0lolGJ8iH36GcxHvg6Fvi0pZQKP3+6lnwTUtw3TdUyLjruelfzmfKaKhC
 DH2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qhWgORzv
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/12/26 03:11, Balaji Selvanathan wrote:
> sa8775p was being handled by the generic clock stub, which just
> no-ops every request. The RPMH_CXO_CLK (bi_tcxo_div2) it exposes is
> identical on SM8550, SM8650 and SA8775P, so rather than bury it in the
> sa8775p GCC driver, add a dedicated standalone RPMH clock driver shared
> by all three SoCs. It reports the fixed CXO rate and accepts no-op
> enable/set_rate requests.
> 
> Monaco-evk also uses the same RPMH clock driver as sa8775p (it's
> rpmhcc DTS node has compatible "qcom,sa8775p-rpmh-clk").
> 
> Drop the sm8550/sm8650/sa8775p rpmh-clk compatibles from the generic
> clock stub now that they are handled by the real driver.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/clk-stub.c        |  3 ---
>   drivers/clk/qcom/Kconfig      | 12 +++++++++
>   drivers/clk/qcom/Makefile     |  1 +
>   drivers/clk/qcom/clock-rpmh.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 4a6c71016da..85e54841386 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -51,7 +51,6 @@ static struct clk_ops stub_clk_ops = {
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,qcs615-rpmh-clk" },
>   	{ .compatible = "qcom,rpmcc" },
> -	{ .compatible = "qcom,sa8775p-rpmh-clk" },
>   	{ .compatible = "qcom,sc7180-rpmh-clk" },
>   	{ .compatible = "qcom,sc7280-rpmh-clk" },
>   	{ .compatible = "qcom,sdm670-rpmh-clk" },
> @@ -59,8 +58,6 @@ static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,sm6350-rpmh-clk" },
>   	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
> -	{ .compatible = "qcom,sm8550-rpmh-clk" },
> -	{ .compatible = "qcom,sm8650-rpmh-clk" },
>   	{ }
>   };
>   
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9ad233c83ac..8596b93d4c4 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -87,9 +87,19 @@ config CLK_QCOM_QCS8300
>   	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_RPMH
> +	bool "Qualcomm RPMh clock driver"
> +	depends on CLK
> +	help
> +	  Say Y here to enable support for the RPMh-managed clocks found on
> +	  SoCs such as SM8550, SM8650 and SA8775P. These clocks are owned by
> +	  the always-on subsystem; the driver only reports the fixed CXO rate
> +	  (bi_tcxo_div2) and accepts no-op enable/set_rate requests.
> +
>   config CLK_QCOM_SA8775P
>   	bool "Qualcomm SA8775 GCC"
>   	select CLK_QCOM
> +	select CLK_QCOM_RPMH
>   	help
>   	  Say Y here to enable support for the Global Clock Controller
>   	  on the Snapdragon SA8775 SoC. This driver supports the clocks
> @@ -153,6 +163,7 @@ config CLK_QCOM_SM8250
>   config CLK_QCOM_SM8550
>   	bool "Qualcomm SM8550 GCC"
>   	select CLK_QCOM
> +	select CLK_QCOM_RPMH
>   	help
>   	  Say Y here to enable support for the Global Clock Controller
>   	  on the Snapdragon SM8550 SoC. This driver supports the clocks
> @@ -161,6 +172,7 @@ config CLK_QCOM_SM8550
>   config CLK_QCOM_SM8650
>   	bool "Qualcomm SM8650 GCC"
>   	select CLK_QCOM
> +	select CLK_QCOM_RPMH
>   	help
>   	  Say Y here to enable support for the Global Clock Controller
>   	  on the Snapdragon SM8650 SoC. This driver supports the clocks
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index c0d95a6300e..f5630ae0f9c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
>   obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
> +obj-$(CONFIG_CLK_QCOM_RPMH) += clock-rpmh.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> diff --git a/drivers/clk/qcom/clock-rpmh.c b/drivers/clk/qcom/clock-rpmh.c
> new file mode 100644
> index 00000000000..69f2a751441
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-rpmh.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RPMh clock driver for Qualcomm SoCs
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +/* On-board TCXO */
> +#define TCXO_RATE	38400000
> +
> +/* bi_tcxo_div2 divided after RPMh output */
> +#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
> +
> +static ulong qcom_rpmh_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	return (clk->rate = rate);
> +}
> +
> +static ulong qcom_rpmh_clk_get_rate(struct clk *clk)
> +{
> +	ulong cxo_rate = dev_get_driver_data(clk->dev);
> +
> +	switch (clk->id) {
> +	case RPMH_CXO_CLK:
> +		return cxo_rate;
> +	default:
> +		return clk->rate;
> +	}
> +}
> +
> +static int qcom_rpmh_clk_nop(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static struct clk_ops qcom_rpmh_clk_ops = {
> +	.set_rate = qcom_rpmh_clk_set_rate,
> +	.get_rate = qcom_rpmh_clk_get_rate,
> +	.enable = qcom_rpmh_clk_nop,
> +	.disable = qcom_rpmh_clk_nop,
> +};
> +
> +static const struct udevice_id qcom_rpmh_clk_ids[] = {
> +	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = TCXO_DIV2_RATE },
> +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = TCXO_DIV2_RATE },
> +	{ .compatible = "qcom,sm8650-rpmh-clk", .data = TCXO_DIV2_RATE },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qcom_rpmh_clk) = {
> +	.name		= "qcom_rpmh_clk",
> +	.id		= UCLASS_CLK,
> +	.of_match	= qcom_rpmh_clk_ids,
> +	.ops		= &qcom_rpmh_clk_ops,
> +	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> 

This looks better !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
