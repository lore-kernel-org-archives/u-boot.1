Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DC0CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87DF849D8;
	Tue, 23 Jun 2026 08:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eGYFZv62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AAB6849D2; Tue, 23 Jun 2026 08:56:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A014A848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2253600f8f.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782197794; x=1782802594; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=d1tXsfHu5AZQDzRwCEMOm2QPJhILCHNbjErRXcwHLSw=;
 b=eGYFZv62803d0fWLQET2VS/igFxt0joQqUswiUd9cgpTUkqC7clEVNxOtFTcxaE9tj
 wUaDHdYJ9LCXljOQJXDKCTTlj0NpzFtlMkhVVHhbuY9OOmYQvM6hbeyHf2Op9YAvndJU
 6OoXpQC+XhPBncvtPbra8FTcLUhXZunhYSyu4gVMI5sVZC/3TkveCUX1JwU1BIIxI4Z3
 nxUQpDADQhilg1H7dPfPYbgPCGP+P/5fz3CC998sBmfekEVhmQSFFqF/f/GteZr7BNIM
 j37VshUs4+Ou43KOCAf3W/Wp610ZTZ2GTAMbe+G8SNY8hRXF6mnE0XuWHuv2UI7ilqiH
 /rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197794; x=1782802594;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1tXsfHu5AZQDzRwCEMOm2QPJhILCHNbjErRXcwHLSw=;
 b=kbJax7uGZ/ZiQdU7iw7aMq/aVZDa14uVHMoY1+hVW7WkZVbCN1wbdYSfyyv32z+WWF
 ElY48iK9hbStWC3BitJO0eLPe6qR9LGZSaQiCqzYpvfDOqF5SnTQuVPplo4QaHT8AMLw
 9nnA8F8iy/F/CAa4YT2aHTO7uQHjYmxgvlp2e1c4JKedIQbCVqjJhM8ZqtOGc1XgTNte
 RS4in9vtwO6rojHnzBo08kuhIk1GrNeQ3lTVBXIrM7t7EH3mebatkpM9SfVdCdcrh7t9
 RvQecZfSZXR7ve0RGlQT9clDMBtdmwQcSFt6MsNstp8vBscSSxIoi6yUULwuosuA597E
 RbfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/W43r+PFTI/K6daGJgabLgU0eAIxUmlBKhf0wuhnpcqBBH9slEqWMv2uGdimVTxw9NA+FmipE=@lists.denx.de
X-Gm-Message-State: AOJu0YyYVVBU5A9iASj+dWpXDl+iym7e1RZSj8vInRoofOzwTy4ThLnn
 0Z0RVhJ2DfKz3PRSwFa45VFouvGNH230IbFAmBMNdT4+PZELVge5m6ZbI13pgXxCcZQ=
X-Gm-Gg: AfdE7ckuRma4kFHjVOhf3inuaaC+XLNK14zY+3f+Y2+wciKr91i147qXWNhv0vBmbQb
 7/2vyC7IzQ+Y7JHzO2+1ErQpU/nGYj+GzUDbnU0HrylbVcjH8CeXagqx6mWeP9i6HoHamenT9He
 WRO/80Z1UuCJV4nWTgkkbMpntXnY2xKD8hfDurk1sbPR4mx8vTmvnN3G7NwXFKi2VR8aIqV7qSy
 UliDhO3loNCuzhj4PQdiU5Y98r3uD+1enEPc9O3wPko5Ivt8sj9mVd6iNF/EIIZ0RkbF8C2K5Cz
 ofG6K0vfjCfWRYg8TGNjZTf2IlP3ccAqzhu5JjI3uuKkbXfRfBaMlnaw9AXzeLX/lNS8tGTDYSS
 r4J9qjmDLyWDqNJcNR5xHnWbUaOq/VS5wbFeeL9ewvpHPU9itq2qSkngVH2S/w6DjzYCKXW2VJI
 01uMnyvCU2oalTztgP0lI2wp8oG+JN0D2K1CW9JXCMyRYv6acU8O0AeWou0tAvlcV8pyDw
X-Received: by 2002:a05:600c:698d:b0:490:d354:bd00 with SMTP id
 5b1f17b1804b1-492490ae3a4mr193741315e9.25.1782197793984; 
 Mon, 22 Jun 2026 23:56:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1ad1:3e6d:c980:680b?
 ([2a01:e0a:106d:1080:1ad1:3e6d:c980:680b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238bfbsm288419115e9.5.2026.06.22.23.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 23:56:33 -0700 (PDT)
Message-ID: <70a9a7b0-b6dc-4b55-97ee-9c0551ceb4a7@linaro.org>
Date: Tue, 23 Jun 2026 08:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] phy: qcom-qmp-ufs: Add SC7180 support
To: Erikas Bitovtas <xerikasxx@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
 <20260621-sm7125-support-v1-4-5ad69a39781a@gmail.com>
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
In-Reply-To: <20260621-sm7125-support-v1-4-5ad69a39781a@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/21/26 18:46, Erikas Bitovtas wrote:
> From: Vitalii Skorkin <nikroks@mainlining.org>
> 
> The SC7180 UFS PHY is identical to the one found on SM7150. Add support
> for SC7180 UFS PHY by reusing configuration for SM7150.
> 
> Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 3df88189a90..35fa38a5b37 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1750,6 +1750,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
> +	{ .compatible = "qcom,sc7180-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg, },
>   	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
>   	{ .compatible = "qcom,qcs615-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
>   	{ }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
