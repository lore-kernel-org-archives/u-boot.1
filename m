Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F217EC4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A111F407BC;
	Wed, 22 Jul 2026 08:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wsR3kIa9Lvwu; Wed, 22 Jul 2026 08:59:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB89C407CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784710743;
	bh=OS+ZdQB5gC2IKu7TEO7MKkfjEbS5v8nvzFvK5hKbKds=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lV2+3EJT58AKp7crvKJZ+p3zea4o63F5wm8DmwyNk89QwvnVL60LcytWcB7Orwjds
	 oAAB8FNGJ4JA1Q6IkPdKneNrrNNUloGdvyo8OVCM94jZTJkPQpMipdvxyjEtxDDnI5
	 9py/uR+5btfnMxa/X4XhrQ7FLoyUEMBpNE3ZuF1TsBhK0f4X725QRTmAZmKvSJDcPh
	 bo0M+XpajnolFsr2Utex7jrPvwLmSAIsHCJyUZwAERQNNVHxMCbgNm5f5wE0ja9mYb
	 R+qqAV0PWwUvG/OnhPj/im/nuECBaucOviispQSo6Z8lIRWomTA9WeO+Pzd9BfaLT5
	 ZVUxa8bJHl1Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB89C407CA;
	Wed, 22 Jul 2026 08:59:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8CFBDF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E974607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLCDw0g1vcUR for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 08:59:01 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 36EF0605DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36EF0605DE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36EF0605DE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:59:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916D7848BA; Wed, 22 Jul 2026 10:58:57 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AEE803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:58:54 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so32458765e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784710733; x=1785315533;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OS+ZdQB5gC2IKu7TEO7MKkfjEbS5v8nvzFvK5hKbKds=;
 b=CnRFPWLQadMilMj7lHVjLCqncIcepPyjx2WblUkiXuOA42PMJ+PXdmGF7i/Y3cAGRO
 T8ysBKb/+M34VGIG+DHd6WuTgj1uyqvKiq+g7ZfA9DEDaabUdyRJq1UhFc9YuH6fZPdj
 5/EqWK2/bpAgQkgiVDxneYSyHQ9PaDCXa7iZoY4SZVMCCWTM/MusL5TvY7WRx/GjvOrY
 z9h9+UbiQ3x1ITvhWacvlPNHXcoIVHlG/Y+5iy+nR7wxGkQG2/dD7q7Nog7cZeGFsod1
 ycGLe1fSXejNc7vKJ9OlUIBaO/U6b3v/fAl4XLXTEKEHAoBMPWrbf/PKHYi42zjbuZJc
 pKnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpb4V9PDKBmIocx4RPSi0T8kSAHh5haAlp44QbBh2crVuoJjlt02iJD244jg+rO/7FTugLwPAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4KfODzu/ivdqMpm80Cl47X8nDALGfKe2TMjyFw9odBAudKpNH
 3rCwD+9EGL1sqcH7mta5MSd+cz3Yd+qcJ5o7/k7tFjUlgzFzcQ31iXm7uWNNW+8zZvU=
X-Gm-Gg: AR+sD13ig02KZM58aOFOUUHtacLGY7ZBW76Yf433NB6Idlq2rPbuOIcQqrkv0anThQM
 nHpwKnc4PtuPhLE9WboCrGbpMfQlNohNJtTEkaLHcUORdCGvFcUtqaUear5ncvTM4sRjABoF3f2
 +ac1770DK+XPzXyiAku/tXHotAdXCph+Xb9Vc4L0Kx2QqfzfOJjnA4xfMlAnA8cu+MCsCBIsN2p
 P8OdD7d9sGjyfyyLkADKn+CkKpz8f4Zjkxs56hGuBuGd0q6MxlKNGsrzAPVbHy0960YcwAbAPEY
 XxY5XPKd/nPLTTgXGKLAccs2h/sjMAY3ETAiW6Ot1qP7bvJTpl2Ok6MIBMSwanGcakafL39Bk4s
 KPTNr0PhCTq0y1NJjaIZhQ/4WcbFDBPW2pNZKOGaz/5/MC+qU466G7lslAkbMB5HZEZu9Qk2dWE
 cvRjFTx0s0tmHoGVV1EmlUxKgiRGloiST4EwkZYBbiYDXyuv8tVxR+zqR2QQ==
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-4954a402f91mr272466085e9.20.1784710733199; 
 Wed, 22 Jul 2026 01:58:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd?
 ([2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm4339179f8f.6.2026.07.22.01.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:58:52 -0700 (PDT)
Message-ID: <eaca1530-4212-4cbd-8402-7a35c1acf282@linaro.org>
Date: Wed, 22 Jul 2026 10:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: sm8550: Add GCC_CFG_NOC_USB3_PRIM_AXI_CLK support
To: William Bright <william.bright@imd-tec.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260721-sm8550-fastboot-clk-v1-1-657a239e3ccc@imd-tec.com>
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
In-Reply-To: <20260721-sm8550-fastboot-clk-v1-1-657a239e3ccc@imd-tec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784710733; x=1785315533; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OS+ZdQB5gC2IKu7TEO7MKkfjEbS5v8nvzFvK5hKbKds=;
 b=WSDc9XfdgDzJT/mlDm8FwjZ3a5RZIfC9ARf7iyS2uCXl/q28GHl+JtqV/N20moNQjt
 UBMo9iJftOrIS78b356ms3ahR+Zc6mM5h/RUt2yNlpNQ0xrKnPEJEn6MxwdDRp4/c209
 Wx8+5NuCAbZFrbRDB4hdZvS8dmiPUqlZQ40ppRzVUEE7RHLGM9dITBzST3H3yoiyEgTy
 EG/kxOi/IqDN9CMIaXGJ8Qkcc6F2si1mGedvuVkpY9GdqhYx6G3ax2LdL/fWUCbOU9kD
 v2uEFP2Vl4iryddBD4AwHLLeJjtW2gEW4JoF7okMrxysjQcHP07QuBkGKGRKDvSXD4sO
 MNJw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WSDc9Xfd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="WSDc9Xfd"; 
 dkim-atps=neutral
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 10:28, William Bright wrote:
> GCC_CFG_NOC_USB3_PRIM_AXI_CLK is missing and is required for usb_1. The
> missing clock entry was ported from the upstream Linux sm8550 clock
> driver.
> 
> Link: https://github.com/torvalds/linux/blob/b95f03f04d475aa6719d15a636ddf32222d55657/drivers/clk/qcom/gcc-sm8550.c#L1346
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
> The following warning logs were being printed when starting fastboot on
> the sm8550-hdk:
>    fastboot 0
>    gcc@0x100000: unknown clock ID 11!
>    gcc@0x100000: unknown clock ID 11!
>    No USB device found
>    USB init failed: -19
> 
> I found that there was a missing clock entry for
> GCC_CFG_NOC_USB3_PRIM_AXI_CLK which I have ported from upstream linux.
> ---
>   drivers/clk/qcom/clock-sm8550.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
> index 7c06489b9c4..3d5a410ba33 100644
> --- a/drivers/clk/qcom/clock-sm8550.c
> +++ b/drivers/clk/qcom/clock-sm8550.c
> @@ -122,6 +122,7 @@ static const struct gate_clk sm8550_clks[] = {
>   	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
>   	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK,	0x770e4, BIT(1)),
>   	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x39088, BIT(0)),
>   	GATE_CLK(GCC_CNOC_PCIE_SF_AXI_CLK,		0x52008, BIT(6)),
>   	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,			0x71154, BIT(0)),
>   	GATE_CLK(GCC_DDRSS_PCIE_SF_QTB_CLK,		0x52000, BIT(19)),
> 
> ---
> base-commit: 8a905a58e3b4832c4cd7dc0e8a596a6d7ce19562
> change-id: 20260720-sm8550-fastboot-clk-86ef12e532de
> 
> Best regards,
> --
> William Bright <william.bright@imd-tec.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
