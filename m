Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B0606A32C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tQ29GxoT;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H84WVMCW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC81A40770;
	Thu,  5 Nov 2026 10:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SCO-bZImUS7; Thu,  5 Nov 2026 10:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14BA740824
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875163;
	b=G3H3XeHhxeMsrhtLwEmQ9w0wDelcE1lFczHpWuK8A5e+PaPL/IWHpB/4/78KKvJO+1+h
	 9JMrlsc+nFyZBhRtHXg/ox3q94JYzuYhnvI30gbCnEhRkqTWoIiMaw6pg0qIV7xh0ZO1R
	 a2lDumC6iN2L1O8VTqKj+wwIYj55tlxAaDc5ONKKtClFgY1M5Z4p2sPXaKgbMadAOEKDQ
	 MBDuGeIrXluBcTo2HLTLbxXO9XeFE1PFYvUmVIvIhiusTLxfrOqvRhMhqUcXibCM/BJPV
	 I8f3T6AqTlWYr7HyWl776tAzE58yYhQuu1ZjZGN84p0fBpVnd+VBXDbYjKU2SNEbUfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=6wxGnrIUEchuRZSptEaZ2tSsLDJUFQe4uj6Ec3ebyg0=;
	b=kP8JgyvDyYN0k8q9xX0BZ6mqSnSuGLdaUr/EKKu6aKj97Epz/PJF4IgLTLaCGNAdrttf
	 cmpm6s0mO2+zNpYS82lblsytcFJ9BNQ0JfNlfr+oF/fGM64U9Ae6yQhXVx83Md39b+FNO
	 +7XslRT9NZ7PfRA79PBd2/npsd0lUc3cm/0WV2iQGKJa7bk9fKKrKG8yZ8Mox7RD5B9po
	 Hfqi1smkjcRl3SsdjlKORAcE1sDTgekBGR6H8PE4dU/uqEf9eIGmfFxIZ3C7VShm7dQBj
	 QPYclxJltHCvtscX1KvLU5C10M+7I+cg953CrYDpHB2WE9OdX3QnHV29Z8C2NiiwfWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875163;
	bh=6wxGnrIUEchuRZSptEaZ2tSsLDJUFQe4uj6Ec3ebyg0=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=tQ29GxoTqO9H7mb5/B095uWbatm/ecBBxAq444AoXdgAt46fL8p9hQ6XGIipomksz
	 eZCYO2mhHH8X/BOq3DhQJTOgVruN3IbySMbF6Hl8+Vd4meh37ccLBb2PUmOWxflMRZ
	 ZL/FxSjbVxYKHRoS5IFZlAg/01Iv6BW9c88+hL76925/3MS6r88FRwgDUyr/MHRMU0
	 reT2F0KDRzr8z6YSrBzEP8aijVlJLIILQfhgAIAG3FVkTyZIlWZRIkbISf7QkAGr1c
	 iAABqDi0goP72e9alBeZdWDEen+MTPxuHqBlQ0dr2MFMqFe7DQzIRgYU8zTUMj8Dae
	 J0RJ916DUP2iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14BA740824;
	Thu,  5 Nov 2026 10:39:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F7502AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0473E6078E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5OWKbmYfj_O for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A204606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=H84WVMCW
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A204606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:20 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1372835f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875158; x=1794479958;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6wxGnrIUEchuRZSptEaZ2tSsLDJUFQe4uj6Ec3ebyg0=;
 b=H84WVMCWo8oNKjnF+y+AY+iDuNT0IxW5r4iPs0ovSVGXd81FapG6X5+CDPvQJDJgyD
 KTuFKpqHIN123l8nxFJBJyU1DTLevQZtKNdB/TFwBlibIowekh8RrghslpPARJe+M88n
 M+2wm0McLDbBiFpxc/iHX/l8CdTM9fot21uYjRDdwa3pbYtAiKYgN+Hvhn3O8FjiqLpb
 /1XRMEN6Vab4vFDoB4i9jeL5bzmcSy0P9EVXlB8xOu86v7RAhweqhsZ6/V7B17Xe//4w
 Y40xcYgSluSacd6nXZTF1WWgZ7twMtLLQLuAd/lfZxa9xJlkwCwGIUdDSaPbHDL1iYQ7
 KmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875158; x=1794479958;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6wxGnrIUEchuRZSptEaZ2tSsLDJUFQe4uj6Ec3ebyg0=;
 b=RGaQqpU0J0Lo6adWtYrVJ8n0eXJS4gyjhhdT/wRrWEBJHO1UvNDgq9RpKX4L7ccHI7
 9g76TGhC4sxMV+A98WMpTEdsOz3Jxe0rCY0tpj35kadTpKOkMbS9E8X8U/NEVxismTkz
 95rJpGLGPP/LC9Sug579oQQgFTBh/sB+L3EPICcT7gtzkJ7/8EaDcE/ClMMGGdkWXH36
 GByDxaxvqJH7vJ7IpwbnmvoCZ9MCp8jFDuxgD+VoFpXcdQLVfMzHCLnPTxVtKfFOJ8QL
 xWSTLVvp+ht3OAO9xJvkEgdX/DtXhAui4N7GaP5YzE2AV0vLzfHQCjoyxlP4jddGSr+u
 bBiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8s0sspVv9Nwknxj9NgKH1dzG7U8gJQRcHoe+9sJoUOyCPmrjDE3SpzHOEUFOqbpJZ3ECFFoU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9yofvQsnWE4Hj2OYWKnUT7L3Jaed+rf3515r8kjD6wN+KcA5nh
 Ei7ZbHJmsY+DFE7bBtawOBSwpgtcXDxDkuWInWNzMooMKGZiZ8N7rMXl4Gd14rdVTdE=
X-Gm-Gg: AYBFou0ejxPgMLrF0fVh2yuLpPGjQpC6VlLbLoz6GoJZVTXnHVcEnyZP3xMJSLgj9aE
 cTFbQN8M+o4XrQGsrr4KA03wZiXZYejL8H93qGJd4QN+JIWSYBmnzkEvSJ65R5UGb/Ld5B62bRR
 ommBmCUUiYRb8AswtO+s8ngQa2aSoK8sEuwJ2gTssviptUsLvPNKrTXkxpRCIN3k/WqnE/dyY3t
 S9u1fsZiNatiKFRmhJnXYVoQTnOKe5ONc3Q7KLk8tS/oddmc7dl34MXxAhM5mSV/fGqOSBv/L8V
 yIFFHYgOMUc4g8AySRxzH5FaNyZ5NTOEctEvSa0/E7AXD+dq/5DVljwENkARh0x7V1tyD2P/gBU
 xhfHjfD4W/4vVpYtXd6sXWMMnwKafFQpXjJh6KSDb67sdGq2jLn9j48WUTM2+am7PhhHJC0QaHo
 X4zCyDiKDl8I3yhbjxoiIOvsiZ7rtbKPctiLwe3I88zcRx4b/X647oJwKQ9cq1l4mbYemBTdO/u
 LBS7ZNaVUuYoCyMX8zDSI6XwsRmf7rwFWYpmFIYXK9CdXdTyOuw6kN1d4e+Ss9P/h6dbur0jGts
 ZLDiWcuCm4OULHmZkOe0gCJBmVFrCFQ30UAmGP7dbSLTGDQqN5K7rFZyKII5dbDURmX52X7xvqA
 Cx9Ucot4k
X-Received: by 2002:a05:6000:4a07:b0:48e:2108:4d28 with SMTP id
 ffacd0b85a97d-48e6e303c5cmr38485955f8f.13.1793875158377; 
 Thu, 05 Nov 2026 02:39:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8648sm9828059f8f.9.2026.11.05.02.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:39:17 -0800 (PST)
Message-ID: <68f07d9c-cef5-47a2-8679-b20c805509e4@linaro.org>
Date: Thu, 5 Nov 2026 11:39:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/9] pci: pcie_dw_qcom: configure an inbound iATU window
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-3-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-3-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> The RC leaves every inbound window disabled, so inbound Memory
> Read/Write TLPs from endpoints are dropped, resulting in a
> Completion Timeout.
> 
> Configure an inbound iATU window via pcie_dw_prog_inbound_atu_unroll(),
> sized from "dma-ranges" (via dev_get_dma_range(), which also picks
> up an ancestor node's dma-ranges). Fall back to a conservative 4GB
> identity window with a warning if no dma-ranges is found.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_qcom.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index ce6b4d97d1d..1215346bcb4 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -17,6 +17,7 @@
>   #include <linux/delay.h>
>   #include <linux/log2.h>
>   #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>   
>   #include "pcie_dw_common.h"
>   
> @@ -484,6 +485,9 @@ static int qcom_pcie_probe(struct udevice *dev)
>   	struct qcom_pcie *priv = dev_get_priv(dev);
>   	struct udevice *ctlr = pci_get_controller(dev);
>   	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
> +	phys_addr_t cpu_addr;
> +	dma_addr_t bus_addr;
> +	u64 size;
>   	int ret = 0;
>   
>   	priv->dw.first_busno = dev_seq(dev);
> @@ -507,12 +511,32 @@ static int qcom_pcie_probe(struct udevice *dev)
>   	else
>   		printf("PCIE-%d: Link up timeout\n", dev_seq(dev));
>   
> -	return pcie_dw_prog_outbound_atu_unroll(&priv->dw,
> -						PCIE_ATU_REGION_INDEX0,
> -						PCIE_ATU_TYPE_MEM,
> -						priv->dw.mem.phys_start,
> -						priv->dw.mem.bus_start,
> -						priv->dw.mem.size);
> +	ret = pcie_dw_prog_outbound_atu_unroll(&priv->dw,
> +					       PCIE_ATU_REGION_INDEX0,
> +					       PCIE_ATU_TYPE_MEM,
> +					       priv->dw.mem.phys_start,
> +					       priv->dw.mem.bus_start,
> +					       priv->dw.mem.size);
> +	if (ret)
> +		return ret;
> +
> +	/* Size the inbound window from "dma-ranges" so PCIe endpoints can DMA to host memory */
> +	ret = dev_get_dma_range(dev, &cpu_addr, &bus_addr, &size);
> +	if (ret) {
> +		dev_warn(dev, "no dma-ranges found, assuming identity map over 4GB\n");
> +		cpu_addr = 0;
> +		bus_addr = 0;
> +		size = SZ_4G;
> +	}
> +
> +	ret = pcie_dw_prog_inbound_atu_unroll(&priv->dw,
> +					      PCIE_ATU_REGION_INDEX0,
> +					      PCIE_ATU_TYPE_MEM,
> +					      bus_addr, cpu_addr, size);
> +	if (ret)
> +		dev_warn(dev, "failed to configure inbound iATU (%d)\n", ret);
> +
> +	return 0;
>   }
>   
>   static const struct dm_pci_ops qcom_pcie_ops = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
