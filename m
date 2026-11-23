Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QFeuWKcQ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AtvtpwjS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 704F94064E;
	Mon, 23 Nov 2026 09:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJrEhJWvXZte; Mon, 23 Nov 2026 09:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CFEA40654
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795425191;
	b=o9UuHWjkChzn9Cc90sCyIsYMLqJ+Vm53Z/9t2emc/eOhHmT0fdsYlMlbDlFHSiALnEB8
	 Yd5hZkWq53rarAxK3M+++iND4GPDa0PhA3Jv23lFJbyyFZwCUy1qsQ+l+gl7JC53B2BE1
	 6omLqwH7VAIvXTCR9Bs+84G8CjqbuRv9y/cpMq5DIiPF5kp4WG9MGJHUvOlzTybCITihC
	 D1fn1+Isq/vIDBzOfIKbv7hKTyJ9gz13+y0LDC8JGeyvtPozhxsBuO58reGLLCbuqg7Qc
	 MahwRHy6Nsj/8FyPf8BXey6ZTe4KCtutm9ED9Qm11w393hUjCAUlkSnV894p5FdYmHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795425191;
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
	bh=yJJSRTdr71xgzStwHfae4xBZUj5oKdjSnFDEdrW4+wE=;
	b=pLEbem+/BDyTgDc6VW/8oXHFpm3nsC+Nt6q9v9tPFSUfIcj5ULXYHzqukfffY7BRgeaq
	 ZCUgDfJwtFCefFr6WV3/gCLryIQdamjDwOJwX6/Rh+YRC/Cv0GKWb3D9gW5lBDbagrAkq
	 wUNW4ptFSJo2brLf063Wm3ZNthaA3cmO2oCafIC5+5Ieyl6nRDpt8SFWf9hC70h6/l/dS
	 BL0mNCEMn54rVqe/RY3Tw9rpxiugojT5rsx+8Qj2Ac9xtOFSc7D9cv78gSs9VAgCgE/ei
	 MwBEb4U01knrkH13XnuqMppriFSEvzzD5TZb73Q7PM328FlD6lqwrx7FAInu9rke5iA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795425191;
	bh=yJJSRTdr71xgzStwHfae4xBZUj5oKdjSnFDEdrW4+wE=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QFeuWKcQkTUp7bJkenWIzHhz65fZejUZqLN02clZmB4ssgjIU8XsdG4Nn8Fyf3B9c
	 8BMmwS28SiXhTnTA79IVqVpqd+r4/TeLHpwIc8MDp+4lRBl5YLOal45/NRRAKZuz0w
	 /mJCxD8vO/k37MskCsaAl5H+wbwOFsKdGML6n1x5xSjwuQ6WdeKUQp3mDz+1EBSqlU
	 Q8aGm5/28Yzz9WLDBTiuJ0ILZBxoDBKDNSDeBnTBOD1rXVwaYHmvhZalmOdxe7CPG7
	 7k3wWrOj2UBJTF6yoaedKqSnl/PE0myqJzaEQuZ6/l1ntbc4QcP4O96puHH4luOosj
	 XXGh94VXkSSLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CFEA40654;
	Mon, 23 Nov 2026 09:13:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 161B479D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00DB4606E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JGV2Ux0fX0O for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCFB0605EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AtvtpwjS
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCFB0605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:13:08 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so28443935e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795425186; x=1796029986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJJSRTdr71xgzStwHfae4xBZUj5oKdjSnFDEdrW4+wE=;
 b=AtvtpwjSddgt2zQbTI+Bd0BC1z9iyrE44OHWwpPkJk39m5jAfLSQHTTYcqvQuiC+Jk
 JwvX8rg0s+IvC7tkIL13INXV4Dwt8vTdRfgwLYhL3dvGu40h5B6ZTYjYd550mTWC150D
 dV1v7V2YAl1/psdaNSnGWItgm26gtGeVNUs6YWSmWWdcJht/n1YOatRrqaY6B4qW3yx3
 KT9FSUmci+jaaXWiypYPL1oEon0k4Q6gxIorgva6QVwKJCsocjCKIYPbOYYa53B5IN56
 NnQNc7ynSmaFoKHeHMbFR98UJEEUIpwg19m0cmTu04k9D8gWWBfsZt7ZlagZUd/eXQ78
 k77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795425186; x=1796029986;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yJJSRTdr71xgzStwHfae4xBZUj5oKdjSnFDEdrW4+wE=;
 b=arIscPq64/PkNrmIB+rJ4QLeVr4D/TPFt8oEZmB7LIJNxdyL5hQUU9QobDahMR8N9i
 vTHMcu6jxx4u8AOEOe1dqvbTEsW4BudNG39J01BxLZ6T2aOvGZhPKExyIEQAZqWK95sJ
 mfgIVUYks6XO1+TLPCHeo/xMPXH5j3GgTpsUxkRKvurvjxrhmLupr+lW+YjlOBstbHFi
 4AOM6eYCoXHyX9YoGV6eCaR+kG2vNyUKqpABDaewq2AG0tfOXJjnCkmpm0cTvEGsZ+kV
 XSwax1L904Vd5/sdyfMQYhPoNgSeltBdUJFhJ2nNY8oDTkJZNTeJyM+soILoZaD0fLHe
 vUkw==
X-Forwarded-Encrypted: i=1;
 AL+hErFIwOGT3kWTjNp6LG6GDCxKj6wGGIW+YgIf1mZbKOOdZXFXAzvhW7/XCWQlUGPRJnc2jBsNaOA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9z76pN7FZs5yMYluJN6oLkFeyt475MFQ23+WrgRffKRDbkXYZj
 ypmGw0X2RRie0Xp6vbARstzS7yfZ2F8ppiattmLwSLoEbqrZUHSUDibLIsq/bXOYQ7A=
X-Gm-Gg: AZFdTZeRpdhFS/zEuKZaz54Uxdi5oZJn2e2xKjam4UvYSuCqUEOmkuvCFjVLqYqIBVt
 3vvQ7iL2kirfCdNm5QbTgPvxdRX5uZ3NOuv4BukIE2w+QKl6KsntCsfYwveaa3m+ZPDbYu0mTNZ
 x7N5+GzfKxUzOU7gomxgvx//sbqr62lw/LrG0GFrkOqllZZr1rYvzNEJv8EUT8M1KJkjm49dDY5
 DuuzDUiSdkpvXdGp+tYHj/JLh/oML6JfKQwJs8xad9bbex2N5OuFsbacyierIN8SksmD+EUvYDs
 /Y0sibg0UOTR19vfGUXi+bByv6Z5/oXHv5kfbWGE+yAsHDljBdoSmNVbDfWn0Wp+BCGmBnzGXEC
 ijFayyLW/cXDdYkMa76SjONrqZ9YFMfo0lFM5D7K42ETJFdPWUlTf/GqIgOUcfVyeYUfxuFkomw
 zHl/bTbV14KaPblxisJkh+RKdj3ZgEJeS1FJ9TH+G5ylw5wOX5jdQH1Oip1d8V6zexRFEU1+w4s
 Wiy/5Qc09Wf47PWAAZUrtxAc3WwODxm80V1QNSlBG6Z7u/+xcWKtSTEZybzjL7d1YRti2RiN1ID
 wpb5SDV8tQR42EnKJ1TZpnyz3uUKGY6rUSohRHGrZcpUGDZOghz9QxvHNxHH4BLFO94KBgOxh73
 ZD9OELOle
X-Received: by 2002:a05:600c:828e:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4bb88786ddemr204962325e9.0.1795425186207; 
 Mon, 23 Nov 2026 01:13:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:121b:474b:8d1f:a239?
 ([2a01:e0a:106d:1080:121b:474b:8d1f:a239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm165931255e9.2.2026.11.23.01.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 01:13:05 -0800 (PST)
Message-ID: <ca5adaf5-4135-4a4e-add1-bc27947f8caa@linaro.org>
Date: Mon, 23 Nov 2026 10:13:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] PCI: qcom: support PHY and reset GPIO in Root Port node
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261123084937.3936584-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20261123084937.3936584-1-aswin.murugan@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 09:49, Aswin Murugan wrote:
> The Qualcomm PCIe DT binding moved the PHY and PERST# definitions
> from the controller node to the Root Port child node, renaming
> perst-gpios to reset-gpios.
> 
> Look for phys and reset-gpios in the Root Port node
> (device_type = "pci") and fall back to the legacy controller-node
> properties when they are not present.
> 
> Also add a remove() callback to release the PHY and reset GPIO
> resources acquired during probe, allowing the controller to be
> cleanly removed and re-probed.
> 
> Based on Linux commit a2fbecdbbb9d7 ("PCI: qcom: Add support for
> parsing the new Root Port binding") in drivers/pci/controller/
> dwc/pcie-qcom.c.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_qcom.c | 74 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 66 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index ce6b4d97d1d..b6546d43164 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -415,6 +415,7 @@ static const char *qcom_pcie_vregs[NUM_SUPPLIES] = {
>   static int qcom_pcie_parse_dt(struct udevice *dev)
>   {
>   	struct qcom_pcie *priv = dev_get_priv(dev);
> +	ofnode port_node;
>   	int vreg, ret;
>   
>   	priv->dw.dbi_base = dev_read_addr_name_ptr(dev, "dbi");
> @@ -435,11 +436,43 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
>   
>   	dev_dbg(dev, "PARF address is 0x%p\n", priv->parf);
>   
> -	ret = gpio_request_by_name(dev, "perst-gpios", 0,
> -				   &priv->rst_gpio, GPIOD_IS_OUT);
> +	/*
> +	 * Newer DTs carry 'reset-gpios'/'phys' on the Root Port child node
> +	 * rather than on the controller node. Only -ENOENT means the DT uses
> +	 * the legacy layout; any other error is real and must not fall back.
> +	 */
> +	ret = -ENOENT;
> +	ofnode_for_each_subnode(port_node, dev_ofnode(dev)) {
> +		const char *type = ofnode_read_string(port_node, "device_type");
> +
> +		if (!type || strcmp(type, "pci"))
> +			continue;
> +
> +		ret = gpio_request_by_name_nodev(port_node, "reset-gpios", 0,
> +						 &priv->rst_gpio, GPIOD_IS_OUT);
> +		if (!ret) {
> +			ret = generic_phy_get_by_index_nodev(port_node, 0,
> +							     &priv->phy);
> +			if (ret)
> +				dm_gpio_free(dev, &priv->rst_gpio);
> +		}
> +
> +		break;
> +	}
> +
>   	if (ret) {
> -		dev_err(dev, "failed to find reset-gpios property\n");
> -		return ret;
> +		if (ret != -ENOENT) {
> +			dev_err(dev, "failed to parse root port binding (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = gpio_request_by_name(dev, "perst-gpios", 0,
> +					   &priv->rst_gpio, GPIOD_IS_OUT);
> +		if (ret) {
> +			dev_err(dev, "failed to find reset-gpios property\n");
> +			return ret;
> +		}
>   	}
>   
>   	ret = reset_get_bulk(dev, &priv->rsts);
> @@ -454,10 +487,12 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	ret = generic_phy_get_by_index(dev, 0, &priv->phy);
> -	if (ret) {
> -		dev_err(dev, "failed to get pcie phy (%d)\n", ret);
> -		return ret;
> +	if (!generic_phy_valid(&priv->phy)) {
> +		ret = generic_phy_get_by_index(dev, 0, &priv->phy);
> +		if (ret) {
> +			dev_err(dev, "failed to get pcie phy (%d)\n", ret);
> +			return ret;
> +		}
>   	}
>   
>   	for (vreg = 0; vreg < NUM_SUPPLIES; ++vreg) {
> @@ -515,6 +550,28 @@ static int qcom_pcie_probe(struct udevice *dev)
>   						priv->dw.mem.size);
>   }
>   
> +/**
> + * qcom_pcie_remove() - Release the resources acquired by qcom_pcie_probe()
> + *
> + * @dev: A pointer to the device being operated on
> + *
> + * The GPIO and PHY would otherwise stay held across a device_remove() and
> + * make a later re-probe fail to re-request them.
> + *
> + * Return: 0 on success
> + */
> +static int qcom_pcie_remove(struct udevice *dev)
> +{
> +	struct qcom_pcie *priv = dev_get_priv(dev);
> +
> +	dm_gpio_set_value(&priv->rst_gpio, 1);
> +	generic_phy_power_off(&priv->phy);
> +	generic_phy_exit(&priv->phy);
> +	dm_gpio_free(dev, &priv->rst_gpio);
> +
> +	return 0;
> +}
> +
>   static const struct dm_pci_ops qcom_pcie_ops = {
>   	.read_config	= pcie_dw_read_config,
>   	.write_config	= pcie_dw_write_config,
> @@ -547,5 +604,6 @@ U_BOOT_DRIVER(qcom_dw_pcie) = {
>   	.of_match		= qcom_pcie_ids,
>   	.ops			= &qcom_pcie_ops,
>   	.probe			= qcom_pcie_probe,
> +	.remove			= qcom_pcie_remove,
>   	.priv_auto		= sizeof(struct qcom_pcie),
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
