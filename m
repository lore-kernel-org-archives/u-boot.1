Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA30C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37641808AF;
	Tue, 25 Mar 2025 14:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NPPasBOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F3480EEF; Tue, 25 Mar 2025 14:25:06 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33CC806FC
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4636529f8f.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742909104; x=1743513904; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fg6ihMC/4tUhTPkG9BkNMpkbMu4h2vx9C84/8+QYCZQ=;
 b=NPPasBOXzwkDKa5bxxgbuXsvsNJuSdMlsxz/n47XJkN0kVZDRUeE1oBtbCJpWp03lb
 WzXQrKyyQbQHriyrlxnJyFol7sERrZF4W92O/yjvixl8/fDfqGurcctAamQiicEwuaGM
 rqA4AyBSYJRVoBbmfGNztpGQqm43v0pkftxodPz83Mvqr2k5761yKU3WRjJgi2u/g+VQ
 15hOhzNy+ublPy1QKreA63Bjn3UbKEmIMyQRAUeiBU9RP+XElaelmsHF55mLCQcRKrIR
 Be2eRUHiQYL5PWMw0/snpLnF84n+GAQNUDKALYhi7XtnnAItguE7YaU9ENpFsx8j4zYd
 py+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742909104; x=1743513904;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fg6ihMC/4tUhTPkG9BkNMpkbMu4h2vx9C84/8+QYCZQ=;
 b=RlVehSTXBtjNAiVXoLATblYZYkdxY8hwTCj0G6MzYCh3056zXU+V4vJkyjeMWYvlfQ
 0metCxbpJxmFPf8+WjZIQDQaGT0d+xe9oglkmeTV8GqO3v7ZmYzVPnLZDoMS8uYH0fFw
 DfEtpIem4MRhe9NTbZP3+uKGucU1ak7scIu7h0CKAVeThT+ukw1i1P26thYs7oZ3crAM
 bbRK+Z5+00sYQ77AIBC1yVWNQtU8nt+thVwhJTEiCKDcWhv2dC0yh/Cl6oGsSiF6VlwC
 HUPFq+xxIEbCsjxc1LF6c9HqBEcU7PXRUaZa/3mB/sVk6QxQZP65GvVfvP7MbNXNcMSw
 WmSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ntKE7r/+OacylZmO/IEGfdsYNNtaD+uX2MXKUEKppsujNUKASvzZuc3qL7Eeut8LR626Mik=@lists.denx.de
X-Gm-Message-State: AOJu0YwHk1dw4izIGvAuH6nk3YbvmLfe3ldzjfG6UWHk4OKU/AFghXEe
 9DDx71vKhtMQAPST+5dql1ajJaKVp/75M1IgzTPR1vtc6fgLdbvEg29qkRCSLDo=
X-Gm-Gg: ASbGncugAGIaC0G2/M3s2lOIG9gu+rDyFmevUtM39p2yuvW8iduSSLvC7e2EFwVKVvi
 UCGW8v0i3sXuL9X9Io0+dUVjonNp6k/pGechSNGhsz+OGz+qsEYVwngl8ArVOytfQ8XEdf8ZufI
 hpR7X3JLGDZtlVnKsSo5y+Ovf2gbu3qYM5F2/3YNMPCaEWpY8O0vWDlqEAxDlmufE2G47SPmcg8
 aPFYJMvSjmoJyEQoIqx4veRzpixUPJX9Cz8nSE6vCaAwESjCnOWfJamMPcf50Y1CPqvd06YlBpU
 z8CJaRaHQ8ZCaJNp0fZIfQ6/STy/5gZ3RpKepF4TfopRQ88Em2uvfBDGpXUI3PYkwC/HDRWNY9d
 wQFFKj49B0XK2ZkPe
X-Google-Smtp-Source: AGHT+IHMkt8Eq7av+K2f1gpI3cWOWpavgl1qpvV5tlUcqtbJD3BBU5SzlkvS1AbYKK97aUR3o+szVA==
X-Received: by 2002:a05:6000:1f86:b0:390:ebae:6c18 with SMTP id
 ffacd0b85a97d-3997f900da2mr15226891f8f.12.1742909104115; 
 Tue, 25 Mar 2025 06:25:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdaca8sm204722125e9.28.2025.03.25.06.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:25:03 -0700 (PDT)
Message-ID: <a3c1663f-ffec-4015-8ed7-ebdfe169aec7@linaro.org>
Date: Tue, 25 Mar 2025 14:25:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] scsi: fix typo in setup_read_ext()
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-1-3575aa1342e0@linaro.org>
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
In-Reply-To: <20250325-scsi-sync-on-write-v1-1-3575aa1342e0@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 25/03/2025 14:02, Caleb Connolly wrote:
> This clears the 6th byte of cmd twice rather than setting the 9th byte
> to 0. Fix it.
> 
> The only other command that sets the 9th byte is the 64-bit read, so
> this likely never caused issues in practise.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/scsi/scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index cd0b84c062252118d250b9305728e03f61736600..34ac47c03ab397ca999abf130d84ccbd3be4c419 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -89,9 +89,9 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
>   	pccb->cmd[5] = (unsigned char)start & 0xff;
>   	pccb->cmd[6] = 0;
>   	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
>   	pccb->cmd[8] = (unsigned char)blocks & 0xff;
> -	pccb->cmd[6] = 0;
> +	pccb->cmd[9] = 0;
>   	pccb->cmdlen = 10;
>   	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>   	debug("scsi_setup_read_ext: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
>   	      pccb->cmd[0], pccb->cmd[1],
> 

Good catch


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
