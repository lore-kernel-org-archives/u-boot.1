Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D74CCD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379488394E;
	Tue, 12 May 2026 14:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FnjUIzYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DE683C2B; Tue, 12 May 2026 14:47:00 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4682836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so4228254f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778590017; x=1779194817; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=47dFW1YWOSVBHH+JzFSTcL2sJxTa+Ix4aw1c35Fenz8=;
 b=FnjUIzYPczZUJEGRjC8cNBZYf1iqwnxuiL+X7v/wERj/CUVB98CZECrKKwkQmYRpmk
 Sbz2Pki3vRXfQavnuU4lCG1puEdVjMlRwbbu5+9sB0LDm7uBxWj37HwVhYe3PZDpmfoa
 E80aJY3YyInOMacyr/c+aRMU5IUtPTRptNiWaRkRrXMg8Fepq/J4fRz20zP5snLbhOoS
 ddzHAD2SB6RQ+7emIiuK96ILmbTxtGKL8IMoMwDMi72sSm12rxlGmKiTo1y/a81AkIta
 KHserD8mgvJC3z+GqgRGyaHvx6bFq52i8E/IbRiV6REvxpYVhuhLuP6rb/nIQSRmUqQY
 jWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778590017; x=1779194817;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47dFW1YWOSVBHH+JzFSTcL2sJxTa+Ix4aw1c35Fenz8=;
 b=pj6wWtL3tpl00kWSh0SkgwEqOpoEowDDoeGn6mCg7uJhoaqEwNXI3rcnaNiXuPkOdS
 k/PGTTdh1l5RYZGzpfK4nstTpoEoOLl3p2jmUXQY4iG9Gdf/1lw7LsuipjfxM5l6rvjf
 k6PdFhez9gpRKp1Nxzk/+8rOQH6R3zepfzzA7BPTOwkIrgz8aPAA8ucqhmwFD/Ez7wQV
 VJWyxSxHYSCDtz6lQjKgS1aXGFWPeDNiCU5UrA9sKV59olayOr5szFZK6J5iQh7Mf6CD
 PGv7YbEWrPM5uslbdEzrjKK2lojTsYZqJxOZBxqPrIXvG/J1JZn+NiNt7rfkMlAnzvgW
 y92A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BJ/Fpmu/U6L7EQ8JC8pnC+snztvUEMwvJs16UXuuEGX0fetJZBCS/SFxsqw8V4b1vL5WvC+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzkUbpf6ravwQ08TZvZv/1XFDoLELcNFG8PwP/1JORRkiG1s+OC
 zo2UR5BHpn4xBcsLaK6qbkAMcxsyXX601/7nacyI8v/Ykc9I8VQ+t9orWISCmi1BXx8=
X-Gm-Gg: Acq92OEd50KVQmlGPMXIhehF09ZbTBvjcmDWWBlJ2SgHzksrMOp+5HxVgwup5ZCOMhT
 9H5pDBtMF437fIRKIN5ISq0p+5YPjOBeqeXKY/BzW3+G+ytuJrSbjVVu9QavhfrHt5kY/cFd63M
 tcPbOlXOgPNg4x7YX8SUSN2x6j5nQU2jGG3GmoY/ULRU5Q8uI3+wdJVYzVEhpDDE2EVVkvDjC9f
 HfIpXngYO8ThXBlVRf3DNcP7o2mBsLR+b+Hkjb+EUNyJMxjwoLNdIBrgWBSrhdVFlvglx5paJiv
 dCBRao1l45BwnR1AzJPpICX4F+gkTELCAF7Cs1SrQquLnWo6z+tSnCotqrzgbETtpDmDaPgnQh4
 gLZsRqRNzMkV1BDv9X/r+Mvti+T0bd0Aa2mrSUKQ1RVQLR/Rm9aW3GxUFTpbTGaNbEDdqlXd6/X
 UhzGRMdLkNzYlva8nyUAqlDh8USUYZVHeHTOEv6t5a94NvYnhbk5PmD+3MWSwu5JrjqJCm6Y/Iy
 hlDZXsOUqjio/CAlg==
X-Received: by 2002:a05:600c:3b99:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-48e906c4525mr39042705e9.12.1778590016690; 
 Tue, 12 May 2026 05:46:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7b25:be71:cc9e:5d64?
 ([2a01:e0a:106d:1080:7b25:be71:cc9e:5d64])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e913469besm11229185e9.14.2026.05.12.05.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 05:46:56 -0700 (PDT)
Message-ID: <49e041dc-f78e-4b37-9d7e-790d52cfbd1f@linaro.org>
Date: Tue, 12 May 2026 14:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
References: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
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

On 5/8/26 14:21, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/pcie_dw_qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index 10c45aaba20..ce6b4d97d1d 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -22,7 +22,7 @@
>   
>   struct qcom_pcie;
>   
> -struct qcom_pcie_ops {
> +static const struct qcom_pcie_ops {
>   	int (*config_sid)(struct qcom_pcie *priv);
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
