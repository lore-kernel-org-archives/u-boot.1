Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9256AC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C9482E35;
	Fri, 27 Jun 2025 10:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v/939o5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D786982E9A; Fri, 27 Jun 2025 10:38:11 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F55582E27
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1344952f8f.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751013482; x=1751618282; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=m/5VrrJd/Z604z1BeaCvDztRFUJaJI1F7Udq/Hgl9Ag=;
 b=v/939o5Z9X4B2a+um5KCueJrrA10YcbYTVcGLpqkr26HZTTnfPGsXe6yNNZw7Hk4w3
 MPnUnhZhQRPAyJdvsL4gqJNb4VnX97ugZqZCvCle8NECE0PA2boNx9YhKVTILIWhbMu9
 V8vP9W3TpHYfYUhdz6Wrcm8eUESZNuO3XDEyq1xfHNK+SZJjQRXl3UGlPki9DnfaTb3g
 2SMcP1CgX4uPIWkteILkT/zdiHO8DU3Q38qmiBY9IPBhSBjoHaKhfcJznOahaNiw9h5A
 d5N1ZOM/PkVflz+pEYOpw+G9r3UKdTgSnc+8B0OIM0KX1JyRoxGb8TOKEJwHBQn3RVZS
 UtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751013482; x=1751618282;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m/5VrrJd/Z604z1BeaCvDztRFUJaJI1F7Udq/Hgl9Ag=;
 b=YdeChEn/NRGFy1qwzAKJdyrsXYXPMwHweLEMmwzSkFyoj0W+ZvZpVu1hnqvzPsEC8S
 +EqkPSxdkEClQafhjxiV6epY2yt1iLtRycxKXt8D/VXCz+rB/CVuzszOLDxl8oyZBB5i
 HDZsNBLZHI+cvNXRz6P3Z+vTAwTYbfV0h2vMLoQkhxOV5z8YDgv/GzBv4xMuV6TlLo6R
 fI5n1HM4QoAkYOvmSNKGq4nfNtZnZxNrHJcfSLtk/zoH5tEDFQ3bycPUIgrjFZ2FM5dm
 u49WrVvJYvPHEqodD8qXvvbAGzms6OjoSO56Wu921OSgMRcmhPy0BwNCAvaq5g81GMG8
 qkFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOo/paSghO+YPvh4oTOKChLeZp2pexpgXu71tZOJDmH/x5vpDeG0xjzzQn1kQWAYwserC7IFg=@lists.denx.de
X-Gm-Message-State: AOJu0YwmZwGP9Kl/WsZobWvE8wA6k3SWAhRA3dXRFiI0+kBDKc/dUtGe
 ldnQsV/xrtYep52elPWIQ9kyuEcvWJqjOKNB9l7iOOIkobn4l4iDucfl9RWJEIFNfGY=
X-Gm-Gg: ASbGnctkWFupHwXepaEyeaEVq8+R6BM+tAHVrjBtp6fqFe0hP+W6nG3ekn8i3jhgo+o
 iy+ZSDO4rZL9n/yGTWw9MKXliJ1x64fLB1cLij2FpRppGoY7hl4/lmy/WOCqo4NbWH04wlHQxTG
 HDuleW6VGdlyHzuECluXAbyXG8prMb0bG1OphDviKdpxMzBCAdIt8e+sth9H20vKSBhSXH+ll0W
 wOvlv151X9xefsWlrQ0gP9WIYFQtYvehGOZcpUfDVQbm0OMaaUZd4rSyso83WCKX/uopKTaU0d3
 TJjkf64PRDOXCDlX7L4WegZF4wZeqx6kPpAaFTxVa03qhnJVNMYaVZIiwoIM6HtSjyILR87xxmO
 NfRfwUvarPcp19Cwa/bV4Fo/EIcuK7gNiCsxzVQg=
X-Google-Smtp-Source: AGHT+IGiwRZldE8lViEynymBmk1EWUwyGVNrZne4Due9+E26umrTt6IM5h+w250F4nahZUHA0+MjfQ==
X-Received: by 2002:a5d:6a05:0:b0:3a6:d2ae:1503 with SMTP id
 ffacd0b85a97d-3a91760379fmr1567446f8f.34.1751013482385; 
 Fri, 27 Jun 2025 01:38:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:30eb:78d0:2bd1:5cd4?
 ([2a01:e0a:3d9:2080:30eb:78d0:2bd1:5cd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa8aasm2031720f8f.27.2025.06.27.01.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 01:37:57 -0700 (PDT)
Message-ID: <98a8f79b-310a-4058-8054-274832439267@linaro.org>
Date: Fri, 27 Jun 2025 10:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: Add delays in UTMI clock selection
 for Qscratch
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, marex@denx.de,
 trini@konsulko.com, mkorpershoek@kernel.org, s-vadapalli@ti.com,
 patrice.chotard@foss.st.com, jan.kiszka@siemens.com, u-boot@lists.denx.de
References: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20250627045244.2225303-1-balaji.selvanathan@oss.qualcomm.com>
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

On 27/06/2025 06:52, Balaji Selvanathan wrote:
> Added delays before and after setting the PIPE_UTMI_CLK_SEL and
> PIPE3_PHYSTATUS_SW bits in the Qscratch GENERAL_CFG register
> during UTMI clock selection for DWC3 on Qualcomm platforms.
> 
> These delays help ensure proper timing and stability of the UTMI
> clock switching sequence, potentially avoiding race conditions or
> unstable PHY behavior during initialization.
> 
> Tested on platforms using Qscratch-based DWC3 PHY configuration.
> 
> This change is taken from this Linux kernel implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/dwc3-qcom.c?id=a4333c3a6ba9ca9cff50a3c1d1bf193dc5489e1c
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Corrected typo in email id in Signed-off (in v1)
> - Link to v1: https://lore.kernel.org/u-boot/20250627044304.2223767-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 21452ad1569..4800eb64484 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -460,9 +460,13 @@ static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>   	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>   			  PIPE_UTMI_CLK_DIS);
>   
> +	udelay(100);
> +
>   	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>   			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
>   
> +	udelay(100);
> +
>   	clrbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
>   			  PIPE_UTMI_CLK_DIS);
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
