Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F35C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C548804C;
	Fri, 15 Mar 2024 18:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bQUJLqBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6588802B; Fri, 15 Mar 2024 18:03:29 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B5B88077
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e99b62e01so1862515f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710522198; x=1711126998; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OFfwMD8eXcNKmpuGTQAH0Om8KoWon75RFD6sj/KRgEg=;
 b=bQUJLqBTYMlBo4gqdQ+VvzeDh0gLOTRkhMhxainZqe06l+caXMBKNyrWFs93HMeKx1
 rPmB5+EfgMlnBnMWMxoN0L1Nr4du4gO9EZ7/kyirnstQkqhyovf0q6254dDG/d/mogFM
 3YZda26M6GK/ojpGBNlRK6rmoKcYckTWjUB3lCAe8iNccL8qLQGrqy6htumAeBWD3Byu
 qU4cS1IVb8bbU47c2IgC025ZkHxNg9A1LN0eQE5EPbnWhqvtJYCaBQHEw4W1SeH8qg9f
 l5H9ePO77sxdw6TQwFjhnRc3vaHTx0kyisNVnzmdqk87dEsu+IbgbEhVxJIAzum7jR+U
 nQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710522198; x=1711126998;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OFfwMD8eXcNKmpuGTQAH0Om8KoWon75RFD6sj/KRgEg=;
 b=fDdVjCdhmBiJHcuc7t/i/pmn5jdSBrz9IJbMKsaeNDR87ffcyABzzMsYQwIiJrgCSR
 ZcdQYWU6Z+ktC+mdIb2CeLdLezIpfh82dgFg2D2Jemut251suS49dXFfY9m55Xhbs4D/
 DI1tpffeu3p7ir2+f69+a6OvrT0Ll6LBi1D4cedr6UNdhKJFW1icWDCLQ8AbHdS5QAiy
 ko3GpWRPXzLJKIa2xBadrcbKMAX5hqkLx0XIS/b+d9SyakSrOwLv1O8o/ElbKjebAvbq
 8WpyHfgkvpPqvvfpZ5GonY9CzEAdYyJL3k3aXcGo77HnK+p18bKQjxdoBotpLG/IMmzL
 RPug==
X-Gm-Message-State: AOJu0YzuZJwgg5C/UTrXCHIA3YWYJaiGgimJOyDpcUezDSnNfeNJUPs7
 xS/lkH/PlZd4WIbLvXjGbF7l6v0gy5qYnMHaLzrBs2ODoeWkkas52L9dN+MAiBQ=
X-Google-Smtp-Source: AGHT+IHIYTtKbNbGURmyDfNWxPfbCJbF5s4q4DXcylUNWr2YDAFk4/Rhk8+zhLjs6U9O7rQlQVFJ2w==
X-Received: by 2002:adf:f607:0:b0:33e:c4a6:8cc7 with SMTP id
 t7-20020adff607000000b0033ec4a68cc7mr4052585wrp.37.1710522197931; 
 Fri, 15 Mar 2024 10:03:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a05600001c700b0033e239040d8sm3589283wrx.84.2024.03.15.10.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:03:17 -0700 (PDT)
Message-ID: <323dab12-a25c-4418-a7ea-300a94db308c@linaro.org>
Date: Fri, 15 Mar 2024 18:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 01/14] mailmap: update Bhupesh's email address
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
 <20240315-b4-qcom-livetree-v2-1-ab635774b2dc@linaro.org>
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
In-Reply-To: <20240315-b4-qcom-livetree-v2-1-ab635774b2dc@linaro.org>
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

On 15/03/2024 16:10, Caleb Connolly wrote:
> Update Bhupesh's email to his new one.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index d1f08f3eca8a..f6e0847b2168 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
>   Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
>   Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
>   Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
>   Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
> +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
>   Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
>   Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
>   Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
>   Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
