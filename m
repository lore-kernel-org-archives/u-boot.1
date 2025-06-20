Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92D8C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB1282D7C;
	Fri, 20 Jun 2025 10:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hFB0zDtz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0993482CBC; Fri, 20 Jun 2025 10:56:01 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9C982DF2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so1517335f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409758; x=1751014558; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eKhGMV0BWuzvaVUk5bk7TLsSYr+DEUNN7r6cqIyIDTs=;
 b=hFB0zDtzX88xOtm4OoN5kk09Y7JLh799DrA14Ur/3XimyM2LUzvn5PcEGkS9H0ySyd
 Qh2UGyzDBkGGwTGM8rgwezm7HAchettsaFua1SSRzI474SPY/swh2o+ulZ9JSNGLZiF9
 qCwXHY6oMXGM6snvWqKGTEjHHIpFtVulI2eRqcDYjiPWj7HAN+OP7g8cZCSzF+g+uZES
 9+TjvyYbSilfXAdzp1VjXL/Yxsd6eswc+Wb+YTFnizTGgTN/Li/vgHp1VaL0NThaKqRV
 t2rwbYBMdKlsDahDuEBlAQMiS7l5jcTvL2+cohxos5OZ/ZY9itL+DeYocnENUZV6PRQ2
 Fb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409758; x=1751014558;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eKhGMV0BWuzvaVUk5bk7TLsSYr+DEUNN7r6cqIyIDTs=;
 b=f++w2GhWBlbK6fP3bcSGzP/5T7LqvbTImbChPHEj0o76s9JlkfW4FeOMpyvm5gnck1
 mx32VzeX/TLzcEyAIPRtZJrxvvF6SPPiUfT02TZbfRh5YFf6Q7ayqXL8THC3QHiNJqTl
 4PtpGvAsigm+8bTygzOvWtlpKRFSVsEPHIE5CQU3bqzHIW9Tab8qx3EDWUxaOiVLh1xv
 ionmnYHFMFWQbRb2pnZOrM4/Rtav7PVhBbOu8bdIbn23D2ZLq/pnXViP1UQMZCaiyLsK
 YpQKeZGK6NCP/sHyxfRPzIaBl6kAbm+YMIcvirdP3NHRBSvUjEey0DjekU38rAj602i5
 ss5g==
X-Gm-Message-State: AOJu0YwVgmekwXG3LMR1r9hLbp7M/7pM07QroNqm8S3cL93Ryf3Sgc44
 A3eveSuu2QoEC6l/TDoIexbEyliSYQ9Eayzz2FrlYCngIEvxluNBZ6pJYF8xoN1AJsM=
X-Gm-Gg: ASbGncsjbVGb9vowUq35ruKHiobl+TwRN9jSOcF2e+zqZQuc379Tt2x/ScTpzb8rzO5
 6Tf4LaMg59gRp2BlS3qsMMPcrN7TucyUinsFh+mda2bNB2OjN5Ut/eFgz98lbJmJd/ocNWAvxtg
 ljU35zGYOqPI6d6QfOjdypO2Bwd6N/n1KaxdvzJPy+iPpzWCZGVnTTd1bq0vG3c3+gz+deBQ8hN
 4R7Dr8sHw/XS4ozD1BsUn1NjgchAT6yJBrMZ1xm/2xhaGw10BopuMImHaebENHyMabhjW/oTtlO
 EnxJI6l7ih9eo4kv41YB820O26mMbtYZjQMGhEjWe4AViyAusvV5xXPMcX+wqNqaWel4Cgr1XbV
 IhekKz8BsqWNQzVUOe2C918KhS++nFYQV3CF9Plw=
X-Google-Smtp-Source: AGHT+IF8WE/VK6TdXf5gGs0ZaFiAVDX0UzzaTKepXMtGjNAS2flgi1N6B8J0i4F0EExWg2ut93nQOQ==
X-Received: by 2002:a05:6000:1acc:b0:3a4:e10f:4a54 with SMTP id
 ffacd0b85a97d-3a6d12d9de9mr1525968f8f.22.1750409758523; 
 Fri, 20 Jun 2025 01:55:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11887ebsm1454144f8f.80.2025.06.20.01.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:55:58 -0700 (PDT)
Message-ID: <aeb1deff-0829-43f3-b5f2-20987aa6423f@linaro.org>
Date: Fri, 20 Jun 2025 10:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/8] iommu: qcom-smmu: Add qcom, sm6350-smmu-500 compatible
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-4-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-4-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> This SoC doesn't have the generic compatible.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/iommu/qcom-hyp-smmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index c1b95bc8b8ca7463399c9cb801e7a9a6d004af53..3c0db9404584a2f54f8b44b13031df40bd1c2312 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -387,8 +387,9 @@ static struct iommu_ops qcom_smmu_ops = {
>   };
>   
>   static const struct udevice_id qcom_smmu500_ids[] = {
> -	{ .compatible = "qcom,sdm845-smmu-500" },
>   	{ .compatible = "qcom,sc7280-smmu-500" },
> +	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sm6350-smmu-500" },
>   	{ .compatible = "qcom,smmu-500", },
>   	{ /* sentinel */ }
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
