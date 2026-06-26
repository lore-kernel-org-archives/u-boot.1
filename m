Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B582CC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043D084704;
	Fri, 26 Jun 2026 17:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gtv9X3Wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECC384894; Fri, 26 Jun 2026 17:42:26 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE3B8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-46db1eb3100so188372f8f.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782488543; x=1783093343; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKqoUSJ9S4aExHC4v7AwC6Gq2KFqvVDX3ULZxr75wdc=;
 b=Gtv9X3WcGGb+3jYJt/4cemctOZCF/3S4iVDgYLWXBfVWil7eUaZhKuw2rr+Yp9yO/F
 N+bilIAZYSlc/xnobXpWDC+uF4FxWPeRcwbwZp+mLYjIEs+v0v6Y+lUAiABvM+B5jk/i
 oxruTRzRf9/I7wOXtCDaWGCu7a+21G1l8tZyRnlt5CQr4c3LX1Cx9QENmM64yLZ8z+wf
 8ykI4zmvya/x2Ewlxqmv7RWtTqoeg+bMkU7cCfmx9uvf4vj+O6ClsKBzBXO4RnpXQMI+
 PFEZJibO8cQvQnQ53DH9Ttd4DrLI0ByG55VOGUAPS+xBoWKUx7/PaR6OUv0Vk/0Ot/5O
 8ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782488543; x=1783093343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OKqoUSJ9S4aExHC4v7AwC6Gq2KFqvVDX3ULZxr75wdc=;
 b=cdcYfqTsxXhABr8O1/m34GuI2PJA0dY9ANQF/JQMyL3Q+j1SZipmAAkXvZPBKhiBms
 a0Wtp9nrZkjrnAeb/AE0v9f5m1lVcmfsFguRwZ/xNyUWtVWDj3b+bUI4O0qTweGmGUK4
 GdSxB3H8MNpyAOTrccuhPxSrLepipKTIuiOTgIE+j4Ee30krhjuQLeHpNDcUErOoN6/u
 KUFmjNdki9AIzxrit8sV7ZQeKFC2ZdVVT+0MoFo1B6r1lHEWd0GNSSH8bBXNSFfzXsYa
 lxF5Sa1OpguElPPxMjSfv/+ilwAf6BWMkdaVY5UIBzBGbCfrak6+bvnhQTJGpQwHJLX0
 MnPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUGG2PcH/4ow3k9I1qcq69OkwOiPQ/YdVB4QcZCuuhUMbsGrC5Zn6012p3rLNV5q4+lRIuymY=@lists.denx.de
X-Gm-Message-State: AOJu0YxdYHMYmy97689KjW6+ACB+6L/+jHhE5xu3rNTF56F1iMp0zekV
 10JxuUNCBhzwdN3PqRrBsqnXDSxL5kaTeWVB/YjxfH4vg+b1EuKuTXK47MAb3HprCnQ=
X-Gm-Gg: AfdE7ckVF9jikhllYDJYSBXbozwpyufiDv7gFo/CuB8Us0/CYg3gVmrneoywf4d0bAX
 K6gYW/TKR5giyPuTu68HDogU8EH5g9l0yd0/jAVvoouW3Ja8YYVUjuZwGHFPQpHYYjroiLW3P+q
 BTxH4TjmCFD+ivfZfL1A88nBfckB4Ht9vYGap3/IhAJGYpqqBtyEp8ChKP/12jbs1pwIrIH73RR
 A3FQvqRYjV+EUhTOTjDsysRe/YogsQwcxoTyiKKqHugNYpTpPJZo2eD+ZGKPDUdIVZDuH24REr8
 D5RDdZtLHjHHMqvF+wFJm21zM0FFqY1ai7AgbHa/NxUi0G+f+PZqgND9jGNjo5nstrMsfSkXhBq
 XWlumN+DxlogiGYrmUutfI8PzizSev7oCztrPiWq1ewsU6bU7DZd9YFE9z0zW7pDd8TBWqyV+w1
 Pa29X4jPNN2Mr4o3TaewKiMn4bboc4MdLPWbjHiY8tm2DsSVwJYzz/CiSXqw==
X-Received: by 2002:a5d:5d0b:0:b0:460:1223:a044 with SMTP id
 ffacd0b85a97d-46dbc3abd1amr11643393f8f.0.1782488543555; 
 Fri, 26 Jun 2026 08:42:23 -0700 (PDT)
Received: from [192.168.1.39] (159.89.222.87.dynamic.jazztel.es.
 [87.222.89.159]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm8884933f8f.14.2026.06.26.08.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:42:22 -0700 (PDT)
Message-ID: <b187c8fa-1667-47ed-abda-b63a579b68c5@linaro.org>
Date: Fri, 26 Jun 2026 17:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk/qcom: milos: Add remaining UFS clocks
To: Luca Weiss <luca.weiss@fairphone.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
 <20260625-milos-ufs-fix-v1-1-b0923dabc35f@fairphone.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260625-milos-ufs-fix-v1-1-b0923dabc35f@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 6/25/26 15:14, Luca Weiss wrote:
> With a recent change to the UFS driver, now all clocks need to be
> available. Add them.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/clk/qcom/clock-milos.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
> index afe59108559..571cd134f1c 100644
> --- a/drivers/clk/qcom/clock-milos.c
> +++ b/drivers/clk/qcom/clock-milos.c
> @@ -98,6 +98,13 @@ static const struct gate_clk milos_clks[] = {
>   	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
>   	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
>   	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x77018, BIT(0)),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77024, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77068, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77028, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x7702c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770cc, BIT(0)),
>   };
>   
>   static int milos_enable(struct clk *clk)
> 

