Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F8CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5FE847F6;
	Wed, 20 May 2026 15:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sx5+2FIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3658F84879; Wed, 20 May 2026 15:49:17 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50501846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso58969255e9.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779284953; x=1779889753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KkHIYEjtnxyoI4wW7m0nhpUHhiTsLDpXHJkwfmoZxGk=;
 b=sx5+2FIQq6icwOWNs0XuSwKeuuxxFC6zKtB2b0SX2UktsE3dZKGMGHrfbQrFXvsjbv
 Sp7g82nMq14HEWHNE1UGHnrCxgGVNHS6xj+hyaZCXhU6Q/0C5FaIICVdjRRvBhD7BseP
 TjN+Zp/+8yRKp3Q4C3gmJ9Mt1E7Wy3MMrd9OhpdlxmZYD5QMJfo7njSfnce90anrcKPu
 J0/Hwu2jyBU23CdW8rVW/TCamKeNgrnQo+EStxQGkLu8GEuXBxukc/UdBkjKMBu7SlMb
 kureUYBlGLNIxyOQg/5xlNtca306lUBPZd+jcl61i3OZ4I8vfB4oBzdVBdqeYpcKup5B
 SFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284953; x=1779889753;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkHIYEjtnxyoI4wW7m0nhpUHhiTsLDpXHJkwfmoZxGk=;
 b=CFUn2EaSAWstQ1tDJCS12rUS1+3JiiRU5syKbX0F1+xfDSt455Ggj3JRP15YvBHZvV
 noIJ13sexTCIZu1rclQ/ci0ZLK+sZmfN4AhVqeWn8BihR+DN89nm6VsmU59C6IWvZGcd
 SCG+TekDjcfLnZZ9LpcDmFhLrEB5Dv/SGoV+zWKqvqK6DJvIkUd9nO6X4pOLCrDsgDHn
 6tqhNOmxZcdCKgjFmPHn78pylqkeZe99ASe1Uy1s/CmTISimkELnpyiiGbokUuYOWHIe
 8mDufC61ErA9fBAtgX0tHZ4sroAdA0BRQUx+u2vRBGxKyRv5XECXC6k0Ht423LX7QCgn
 PBag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xVLEK8Qqdc6xti+261gZKh8eMsIUDKbgrxu94NSGx2UZNCUJa2KPyR1uGgSecTITDYBRdWzI=@lists.denx.de
X-Gm-Message-State: AOJu0YzO3WgpMG6rFQ7s/5F7egdo+0L3HJa7K9X4F4eJFiBUwNs+EP+K
 o3q7EOJntPA5g0+mjLOwONkylG3eCTonU3GVPWYRdDN5IrPDMk2Eu/FWdL4/TFzxg5U=
X-Gm-Gg: Acq92OEbrKvnjFxxvoRE0PXEQuj73XkT3MHsrRz2xa6/5bttnFAW9U+Zffm12MzXohJ
 c52eBBILasd98ARzgZsa83Cv5tiO8jbjBlqgHA5PbGGcNDghCmmiwauMS7CxeBLFvOswkbT+hyf
 xTM4nZHkkv+IB0Fmyyc9wrqhMm85xTsf8RIO2hItxEbzTrtkbk1pXsY9XT1TNRc5Emvpte0KU6p
 K6J7cysCLpLITCU/m8PPuN/jB4GHSHHKFKz36Cs/tLyuHPEG/5F+bLi+j5qZbmzONvbaZyhZ7sc
 LXb0m6sAne0ew13IChITg/VsqLLlEuuf57GZ+vBDbPubafoT3f83DxaqZsm0pP+BJc/DRh8QqD/
 oKIJt2a6o8IPPcF0hj2e+lY9hfBhUgBpqySIxRGBsVK9bS7MyDY8b6wa64hS4K40Mipehi2Ze8P
 WmuZAk97qMFKNAWOrwuOvxbTvEQJJnQSIhZKgx5IptSV9CqiqXFPwQp1/fyjwVy297gDFJFQSZR
 A==
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-48fe60eb0ebmr402642595e9.10.1779284952536; 
 Wed, 20 May 2026 06:49:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dec9:6d:b572:fe67?
 ([2a01:e0a:106d:1080:dec9:6d:b572:fe67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm54373086f8f.35.2026.05.20.06.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:49:12 -0700 (PDT)
Message-ID: <cab549be-4716-455f-80a5-866a5b3fa19d@linaro.org>
Date: Wed, 20 May 2026 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
References: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
 <177928247654.3007879.897450050126184217.b4-ty@b4>
 <f715b89e-348a-4fe9-98e7-1708c0259b4f@linaro.org>
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
In-Reply-To: <f715b89e-348a-4fe9-98e7-1708c0259b4f@linaro.org>
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

On 5/20/26 15:39, Casey Connolly wrote:
> 
> 
> On 20/05/2026 15:07, Neil Armstrong wrote:
>> Hi,
>>
>> On Fri, 08 May 2026 14:21:37 +0200, Marek Vasut wrote:
>>> Set the ops structure as static const. The structure is not accessible
>>> from outside of this driver and is not going to be modified at runtime.
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)
>>
>> [1/1] pci: pcie_dw_qcom: Staticize and constify driver ops
>>        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1f4f0f37d7567d4bad86dc42e8b04206d3c8daf9
> 
> Hi Neil, sorry I already picked this through the Qualcomm tree, should
> have checked with you first.

Don't worry, keep it in your tree

Neil

> 
>>
> 

