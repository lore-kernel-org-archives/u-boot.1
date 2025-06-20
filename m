Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF68C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A218282E20;
	Fri, 20 Jun 2025 10:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AZTYy4PV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639A982E0A; Fri, 20 Jun 2025 10:56:09 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7336C82CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so18476675e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409767; x=1751014567; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+XjhYyWllbyQQA0AbEeLsSUsXzvkA+h9jLRS1FIfcXg=;
 b=AZTYy4PVXBHQ/pw8e8ufRKFyLwKiQ4D4cjnWzBvt9qaq7eVadCR/Yw5ourdqthYcj0
 snHffFHdHVE4DjCOTlNM/mpODhxlA4ZKLPCtcjwWCVJrI3hgyjNmIWMXBYWdplztm57R
 mlNxjjhS+JpM6llXTbn4r+xyulepCJn4BlrhFztMPs7ek9P1HpBxX9ZB0QGR5uC4AHOI
 hmkSCFOkmbUbzSOul03L7dr04i4piMg2D7YJfkSxBm1n0KTALsT3/jpXDCtpcL8kvvBR
 TQWWN9DrtnEfBFmcKUbtdMViqL5N5+xScFHvtNzd54S4mobodQXCZ0WpMGALqU5OtJ6F
 6DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409767; x=1751014567;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+XjhYyWllbyQQA0AbEeLsSUsXzvkA+h9jLRS1FIfcXg=;
 b=ve7+J9JWAqmQ5u+fJkqM6NNH8aXeHore0iNjA/Hci9TTWMget68DFUu/ArYI/HgicS
 OrksEnv5T+kLCjpCKYQoY/of5NDP+qXUVq719xlK5oqheHSv7wR7zswQzIfaS5Pxs+my
 SLTJwQCf0IByoDgyu4gCGO4etD4zsU7+HsIBUbrgdTrRCjGOcoGVH5iuPLTFSd37yy+N
 bXVeQqmBSLDqk0wygKGgd59DSNuGIAw1QRH65mFNzDgoJTImwOBJrpiEwvHxxKnW1UWU
 WlC4aj2IkV0GvjSKabNXI8jwQOYoKSBBUSJaXnFOGiXGp7kmelHadxcBgLN22aBby2Vi
 3zZg==
X-Gm-Message-State: AOJu0Yzkq1Gq4h7+fVc4XCuYBKahG4SQ5IfZdYVIRQpMVzTrMaKk0aMZ
 ukkNSLgQl9BL6JtpyX4qI4PqeQva8HvHvBNApeK3VcxDlZNo//IglsLCIdx0T16HcIs=
X-Gm-Gg: ASbGnct78xXEp30kTpm5BjKSEQ3vCGcJr8tP07wv5CuCcoyLTMVLJME64+ccFr5i/4h
 y4kb2tvSzdAR61MM65X4eq5NcfV/PNO7KAdBgnY1hjgCq3ksL+SWA/fjyK3FFwhD8e6iKXdwG7O
 X3qTeBbDA/cvtc1o5OBKN+Q+QVrnajy4MwV1BewnLzaODyDL2Vs7EMVxDTnePXdjfwRhriZM1bN
 eekngbHZSMMVCsBHGL18pbY25drpD06M08lqRXQP4NfXh8HAA+LmmLoq2Ns1Sbz/mF9BiKSRjG8
 /yHDUN+Ybr2VJhrl8R33fspMZk2WygE0E23vdtEbAi9nvh5t/2xxm9qndOzHigOGaqL0jce5pry
 J1KRRBzQaU6nr3wZBNyrhq8qsSAInntRJfWSr0tc=
X-Google-Smtp-Source: AGHT+IFW1ZkOXwXFnmAQulg4qX5RBV6q0oPnGtmPHXVE8qY84qZvpK3vh0+QzLV5u0l3HtoHyzWrdA==
X-Received: by 2002:a05:6000:4185:b0:3a5:2923:8006 with SMTP id
 ffacd0b85a97d-3a6d12daab6mr1477652f8f.25.1750409766852; 
 Fri, 20 Jun 2025 01:56:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536366326fsm25729475e9.38.2025.06.20.01.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:56:06 -0700 (PDT)
Message-ID: <aa1916b3-804e-4701-b209-b2ae73131bcb@linaro.org>
Date: Fri, 20 Jun 2025 10:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/8] phy: qcom: Add SM6350 to QMP UFS PHY driver
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-5-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-5-3cc22aab7a7a@fairphone.com>
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
> The UFS on SM6350 can reuse the SDM845 configuration, just like in
> Linux.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 449b97677788132dd6b9eb654732896756a3ff47..b536517f93a3a41a05b20d811033fc62c05169ec 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1467,6 +1467,7 @@ static struct phy_ops qmp_ufs_ops = {
>   static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
> +	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
