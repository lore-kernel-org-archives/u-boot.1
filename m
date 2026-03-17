Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD34FED9E1
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD0A84390;
	Tue, 17 Mar 2026 15:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aW8E7g6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F93843FB; Tue, 17 Mar 2026 15:56:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10BB843F9
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso52469985e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759380; x=1774364180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CDkfnWJg5VmJvnTR4V71drmlWyOHgoCw42/OlWLdhDg=;
 b=aW8E7g6/kFUTSxyGm/7THPdLBtIvfcBdME/ThA8iZsQ8kk6/y8n8k2D1ssMzffF4Lb
 A2qBgxKn8ngoLUZmU8MTnwNc2OmYBLPqchGfjBtCPrK3bjdAtkmfvnog/bH6HsQd+sqj
 zgtSlyi2LaHLykFoJMa5IupC9GZNItFc7TSPW/pKhh7v/ruB7LlpWCoXIegGPGMq3YCX
 TKXaY6nW6stjVpLvWdcx5hrmu4UaHG4h6jBRiqio2HO9HwnD/Wmj5SjEdU8UtC7HdYg0
 AW2hS+VBpOdc2EizQ61KcYE0EAwnuzDcwzMcokY1XRI4dUqTF3CWRUDV3ZOtGH2Vjqrq
 yURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759380; x=1774364180;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDkfnWJg5VmJvnTR4V71drmlWyOHgoCw42/OlWLdhDg=;
 b=ToXXFfvET+xY0ErHbRn/j1YSZnJeed5daL1LN7V2wt1oqyDPalALszZYkK7E6YZzjW
 jWuJHMeAhEewcIG2oUSMIJhgAPLb2fYHMKEJeTnFe4fYDG9ELjW096m+TfIQ07RBycX0
 u6KiBJKzybtxkmN9LpEHfQ6ZiIiQcB+69ZD2nmJ0S7PdQH+RybFqNPak13/JJM4RxNxu
 Arbkk+FVd8u9dQLw/xFkKs0fCbGed09+yZcqLdB/I8hu0vyjm0qVrs8GghLQzVnSCRSg
 B7gg2tfb70E9Jhu15lmQA+k9kTc/HfH51bCWUxank9vc/MBgwcXhRMzKjHmA/gjgzGy0
 rn0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXDQ0kPdstt7U01HIABQhiQ4NxX0ln2+MyyikPbeb4xupSC7+w3p1W4L7VE45mGwJukorb4WQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7FTikxqec40FNWNFmK/U1bQKHx13geGS3KYyykcsAERNPAf2/
 uGEX5wWYOXrNsU20PEU+hn49FyX0UZmLeHmbjLktL0bIt4y4slgKBnp8GZSp9paVaBpsw+IEKyJ
 7H9VVmLU=
X-Gm-Gg: ATEYQzxT7iU7fwVPKNPUgBnZ/+8tEYknlYY/b43vHG9kdTvOXhdSY3ZCZ3Y+Yezz4qT
 6Gm4N/hqSY6vA+TNM4ytpGGtBobxH5RIOjfag8b8nMbxPR6BvLkCWJsnWZK3KTxaFK4AcxCf/CB
 LVj4YQh+WY4Iti2Q70XFXDh4NalPsLZkaYloHBh12d4FUPVcLsOGjk2Wm42f19LZ6ovFbhgJdG6
 yG30nTR+NhZPoGpWPSrBAuUto4JQcioXDc0/4uiTSMWrvzQY6b2Shdwo1r7zPyvsTT5Pnei4T98
 r0Qy9oXdDNmHIdFvwUjdpVSjAtp8k+D7jAwb7BDeAdIMkw+cuwvY+w+KHvSwoc4c6OPk9Mo2PL0
 DlbJIo5/xj2Vw5QrYj0cWdcP5KHDukmZN4BKFpkIkvOEqWWV0qTvqq1ky8nGxs1m9hfnhi42pNo
 iu+ffjE4FvH3xSGq9QzjS+9A9UsHZx7q4fZhZBmVdImJ8tHlmo6d5FkABJ/U2ahexMimEGiaIUd
 1wc+7k=
X-Received: by 2002:a05:600c:3b14:b0:485:410c:119b with SMTP id
 5b1f17b1804b1-485566d6f93mr308414175e9.13.1773759380098; 
 Tue, 17 Mar 2026 07:56:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5189221dsm18030f8f.23.2026.03.17.07.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:56:19 -0700 (PDT)
Message-ID: <dee74302-7404-4aac-a117-8ce93383eafe@linaro.org>
Date: Tue, 17 Mar 2026 15:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 10/11] drivers: ufs: ufs-mediatek: add MT8195 compatible
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-10-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-10-7d731ec438ae@baylibre.com>
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

On 3/17/26 15:24, Julien Stephan wrote:
> Add MT8195 compatible string.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/ufs-mediatek.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index 31916f72c86..3380783e8b1 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -395,6 +395,8 @@ static int ufs_mtk_probe(struct udevice *dev)
>   
>   static const struct udevice_id ufs_mtk_ids[] = {
>   	{ .compatible = "mediatek,mt6878-ufshci" },
> +	{ .compatible = "mediatek,mt8195-ufshci" },
> +
>   	{},
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
