Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85276CD4F48
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA9D8466F;
	Mon, 18 May 2026 10:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLJ6bcqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF0C683AA9; Mon, 18 May 2026 10:03:29 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D7384676
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso12161665e9.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091407; x=1779696207; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4+CZYpWAIhk0zvMQtb5Ki7/PYFSuvO6vqKlIn4wU25s=;
 b=QLJ6bcqz3NrQBqXJU2LmMedwv5b3uNQMtfSgrQobuokNod/osHdCZT/yXtc4ArIloT
 2Ciu8C3wlF48zHc4swqSOvSA8/mgUWSIHJ5fPzFLSaS6oPmiax2nIJsMGUzx+GwfOSDu
 i7a94x5k4HlomvA3Zqx4B+ptPTHtKE6JHcyNdSPUTTbIlhYyDmRUJcvsX/++sJ8IMOrp
 VHjnZVWovU/a0AIE+Hux5FZGvsVUeSbm0qyb46VHF8edm9jVusYpv3pE1wQ43TVCTguK
 iwsgostDMOyaqzAka4t2fPjdIJoX2Ezmsak0brtKA8KHlzc8kjcltBWHjTWd1OSRdaDp
 by7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091407; x=1779696207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+CZYpWAIhk0zvMQtb5Ki7/PYFSuvO6vqKlIn4wU25s=;
 b=MuSEWtE1gjOo2IAWVm7v0USTQ54pEP5SXRRUL3yMGVQWkXER7Bd0m1oJVNzCgO8g73
 4tAds6NGW2zm3j2nLA7R+F1jDqmv/C+lVFamim/iw1Mto13VPucP08XxIFmuqMdmZEfa
 85eLceRs/U8KpxKXCUoOoG92sFD3UKG9VbQVYRpftarsDQZzbkp1Q7q1eFxfLtd05CSp
 pklAv0mG8KvMY6PJbE5J4a3yPVIJ0AVVJGxo5ceX36+9g0WFZebX7bP1kCIjTAmQp9L5
 swSTFD19wVnYDuE+dzh0GKUv9DcWZYb+apwCfFlFUrdjnJRnQtjCCbRWq1s+cSYVAmyX
 Q7uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l0J56B7CDYJ/OcDp/ktqJvDMO7IwJu/89meZVeFYn/zypxFUW5Zon3sSgUyNBJ6Fp9C/L6BI=@lists.denx.de
X-Gm-Message-State: AOJu0YwY9sIrRLzdT6xvpumoW4Rvdqsy0om7H9IIH/oTQSHEp2mrv4oH
 GHOlOdkv6kzInAEhbzXZWU4HuieNP9u031e+vTS6Px7b78J4Tow4vrx6dvQFQ6Yk0N0=
X-Gm-Gg: Acq92OGZUq+bvsAnaHElD4cHiBZ/iQ8rnJEOUCQBsjh0gKj1ePpEENtoK/Q6TH2hQnJ
 EDmSjliOiuRM9A7EF6ACA9wUQJPsG8LCyxEkWWsjEq3MQId+XV/+PPZz6TvfDXXCRuLRUzleIgd
 xN2xmm1umb+7y5se8UOWeCJhwEM215Copq9ZV7gwFdNT2ck/VpUH+lpUdqew/zBbx8etI84Hm+z
 2SGQfT0X3UPNUrlB/tR1wJOr4xFjLi0jJhDtHu616FLw74lzTxKkvFHhlEFXC6E2vah3Qy88DFY
 pkCA7FAAia6S7xQCpjKX5x8nXoU9VIbmyg1b3RjJU0/FgAXcW/+JuwuF454DVrvAIE7df5n4Ge4
 r4UxKlO0UmAeU8475Nb/n8X7LpNTwkJCEbRyQg8ci9BjdhH7Gtnc3LGRBrqW5nx1sHqNKpW7o+T
 uckH2rYw/yDKXtDZnY9riLMe2Zp+44NStUpm1/y81PGjYDlZUAGnUGjh5/PeCbvii+nw==
X-Received: by 2002:a05:600d:8496:10b0:48f:eb8b:997e with SMTP id
 5b1f17b1804b1-48feb8b9ab1mr125127825e9.26.1779091407214; 
 Mon, 18 May 2026 01:03:27 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm235281855e9.10.2026.05.18.01.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:03:26 -0700 (PDT)
Message-ID: <decf7916-e31c-4f9f-accb-73ffc1af48a1@linaro.org>
Date: Mon, 18 May 2026 10:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
 <20260512-ufs-sm61x5-v1-1-c022cf988e89@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260512-ufs-sm61x5-v1-1-c022cf988e89@gmail.com>
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



On 12/05/2026 16:44, Biswapriyo Nath wrote:
> The UFS on SM6125 can reuse SM6115 configuration, just like Linux.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 80eba734a633..3df88189a907 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1741,6 +1741,8 @@ static const struct udevice_id qmp_ufs_ids[] = {
>  	{ .compatible = "qcom,milos-qmp-ufs-phy", .data = (ulong)&milos_ufsphy_cfg, },
>  	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
>  	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
> +	{ .compatible = "qcom,sm6115-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
> +	{ .compatible = "qcom,sm6125-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
>  	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
>  	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
>  	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
> 

-- 
// Casey (she/her)

