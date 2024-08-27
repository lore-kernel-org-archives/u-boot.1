Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6EBC54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 13:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75955889AE;
	Tue, 27 Aug 2024 15:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L5D2XMzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E6B889C9; Tue, 27 Aug 2024 15:04:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A679388800
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 15:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3718ca50fd7so3415786f8f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724763840; x=1725368640; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eLEfUrDSgpEiRUla6ydR1wGHKK9kPePnUXyejmP4Hdw=;
 b=L5D2XMzh84ia0im5EcY8kGotMwOBIz5YtM87z0AR3vRkodphjBq+Yu9F59NhNDXJ5m
 uj2IWS5uK+w6p2MGwmTOxlAWFlbIOoHBNAFqLgPGLk6ri9s26Kzwq2unpimaxc3sT3KJ
 hesUKvPnkhtM6ufoIHQagLb8B5aCgVhB5qEtFsigWm6aOiedLn1z4+0OooIQh5N8T3GW
 rHmJD3BFwZc9Akx3yX+eHyeZFwVhVY863Y104gjAhaEePxrdEj36xMEpXn3MQ3H1PIgg
 OIWT3kyOqpDBZj+oqQMyVTESIBW6NBEPvFtuzcvjwfCpqE/bYS+i7JraozBC0TkgexVb
 AuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724763840; x=1725368640;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eLEfUrDSgpEiRUla6ydR1wGHKK9kPePnUXyejmP4Hdw=;
 b=NbIsB/UgWgSAtRCZYPJcM9trWCR5i5MWgh24tAhcv/rmjQMogyQH7WYVO0gR8uFbSw
 /q8uQQSqki8B4koqd7sE4fkeZ1Y/DGyzrvSzMxpUyUmLMNaJEgdKL47egaXVKGmzrJrZ
 Qse3+IApU3PWuII3E47vDDAmYtAtt17Smqxf1WbmsS2jwSTR4bhzH+xcef+o88NT/vcD
 ve7ti5UYB317he/NlsUgeD7jhg/ud0ApsGgJRWqnZQLbszw3VpruzAhIwyVfucByUBtu
 ML4wZ2UubsiH9WQ1WcQQ6063Ar43jaCCWU7t0T5p3QSSH0docwKxG464Zp2FDtzR6hvl
 bccg==
X-Gm-Message-State: AOJu0YzgvQC/cDnff/J6Skm8QwNGZlZBAE/RuLmsrev3zIlFDE1Bd1D/
 lLK6foy3Dw9H5LpBaFeAfUfmVZXux/1TUgHhJ8PnG5MmTgAFLngSGv5KZlcWFYIqAf4v1r4OZIv
 W
X-Google-Smtp-Source: AGHT+IG9uD6hka3T0CMARwQa3opaI/w5iF5Fq91PClKXrIIdwnYpnCGLHHIsBjz0awtxUBofCjcR3A==
X-Received: by 2002:a05:6000:459e:b0:371:a70d:107e with SMTP id
 ffacd0b85a97d-3748c7c1681mr1759900f8f.6.1724763839344; 
 Tue, 27 Aug 2024 06:03:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cedc:30f:887e:7717?
 ([2a01:e0a:982:cbb0:cedc:30f:887e:7717])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308110436sm13100820f8f.11.2024.08.27.06.03.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 06:03:58 -0700 (PDT)
Message-ID: <49d669aa-ab8c-4cd4-b8b4-c332980a9c16@linaro.org>
Date: Tue, 27 Aug 2024 15:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Reword where our git
 tree is slightly
To: u-boot@lists.denx.de
References: <20240826163917.2786791-1-trini@konsulko.com>
 <20240826170140.2791128-1-trini@konsulko.com>
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
In-Reply-To: <20240826170140.2791128-1-trini@konsulko.com>
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

On 26/08/2024 19:01, Tom Rini wrote:
> We shouldn't have had the link to our git tree be contained within "``"
> as that meant that it did not work as a link, so remove those. And
> rather than make this a link plus text, keep this as a link within the
> text for overall clarity.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   doc/develop/sending_patches.rst | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 82efb717b179..990cb9912a92 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -76,11 +76,10 @@ General Patch Submission Rules
>     compression, no attachments. Just plain text. The best way the generate
>     patches is by using the ``git format-patch`` command. For a patch that is
>     fixing a bug or regression of some sort, please use the ``master`` branch of
> -  the mainline U-Boot git repository
> -  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new
> -  features, if the ``next`` branch has been opened (which happens with the
> -  release of ``-rc2``) that branch should be used, otherwise ``master`` is
> -  acceptable.
> +  the mainline U-Boot git repository located at
> +  https://source.denx.de/u-boot/u-boot.git as reference. For new features, if
> +  the ``next`` branch has been opened (which happens with the release of
> +  ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
>   
>   * Make sure that your mailer does not mangle the patch by automatic changes
>     like wrapping of longer lines etc.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
