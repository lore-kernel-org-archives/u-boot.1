Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3978EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8547874D5;
	Thu, 21 Dec 2023 10:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MM5mlxRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C56874D5; Thu, 21 Dec 2023 10:18:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D645186DD1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso6322315e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703150287; x=1703755087; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oG5WgSC2Na4YHNxzlvsRMjPZZCILzI1hltdHWbyAWNo=;
 b=MM5mlxRpF4skSGQfql0+REZ+5I+dKSYISnX9bhzL/lTKjC+Xf4LxCjTG9afM2qCzWV
 gODhEe1a7OKhXnubpvYcsABMPBEDNGvyXiz+uW6nyo88Dl82uz9Zvj7Vg1xB9QiW5u4j
 ZBg/sQR1mw+klbtyPqGlg37iKHeVCDqoCUezb0wiZ5iZItITu0UjcB4K+6GTN8AkipFT
 2bPGkm0gxZ7rmDYyjAnPJ25JHSJX/xIKfLQgnq1NboqaX6SmZdPcVlxWZkavqWyjhrxU
 cN5oXym5THbsqdvaF7nDkXqkEDnvrKVqXWz99SK0KvVrFlTPpq5ISS4Qq2VgN39j3jfG
 pzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703150287; x=1703755087;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oG5WgSC2Na4YHNxzlvsRMjPZZCILzI1hltdHWbyAWNo=;
 b=bXfo/zEIqj5wUxagXCS1pAppuZJJkc+VCVRSG4OWNz+U0qcD/wwdsf5BG8sIjqsYzE
 yuVZtXOnf/lHmRRATFtFQAw0hjhFmmbhxpb5n2LdL2ADTbZRWojssQcGicyo137g6k//
 CA9Dk1o00ae8ueKVK9KRDjwoiNmVK2t1/zKnA9hdN9Cs/V1ZRjQpD2LR1MLIHrfcmFr6
 xXXC2TS0r506z5AwXl7pmzutCdLMFQl93BzdSgVLcWtEY88gzjSWu8JqblRapDIm3EEa
 2cynISL8NZjMSoyCCw0Bfp/+QdNVaK8/lypShdtVYSDu1G/6M+eyE90wuhVIgpNUwglJ
 863A==
X-Gm-Message-State: AOJu0YzR8UoFRSKU03nppS9B5COEJHJ/JD4vb2gQ8aw0/9OfZV2gH/aR
 CMoavGMDICrlK3Dz8Jv+842phA==
X-Google-Smtp-Source: AGHT+IHrNQtNu5qJBBRRzAUn/QjNhTWJc0OUuTEUSMM/lGq3TMstu/N6yxhBfPZvIEw6v+ITSy3wRg==
X-Received: by 2002:a05:600c:3b27:b0:40c:91f:506e with SMTP id
 m39-20020a05600c3b2700b0040c091f506emr422957wms.126.1703150287667; 
 Thu, 21 Dec 2023 01:18:07 -0800 (PST)
Received: from [192.168.7.29] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm10788212wmb.22.2023.12.21.01.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 01:18:06 -0800 (PST)
Message-ID: <22dc0cff-ab4c-4a07-9aa5-da30eec4877d@linaro.org>
Date: Thu, 21 Dec 2023 10:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2 v2] Provide a fallback to smbios tables
Content-Language: en-US, fr
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: sean.anderson@seco.com, sjg@chromium.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
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

On 27/11/2023 18:10, Ilias Apalodimas wrote:
> Hi,
> Tom asked me to clean up and resend [0].
> I've made some adjustments -- The DT nodes are tokenized and a single
> string is used. The DT node 'model' is used to fill the SMBIOS
> 'Product Name' and 'compatible' is used for 'Manufacturer'.
> 
> The reason is explained in patch#2 but the tl;dr is that model doesn't
> always include the manufacturer despite the suggestions of the DT spec.
> 
> [0] https://lore.kernel.org/u-boot/20220906134426.53748-1-ilias.apalodimas@linaro.org/
> 
> Ilias Apalodimas (2):
>    smbios: Simplify reporting of unknown values
>    smbios: Fallback to the default DT if sysinfo nodes are missing
> 
>   lib/smbios.c | 109 +++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 92 insertions(+), 17 deletions(-)
> 
> --
> 2.40.1
> 

I did it already offline, but:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on libretech-cc

Thanks,
Neil
