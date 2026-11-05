Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BC606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rsQNBBc1;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=leO751yB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 241754072B;
	Thu,  5 Nov 2026 10:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrZQQ-Vt8C1P; Thu,  5 Nov 2026 10:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71A0F4081B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793874139;
	b=O6pkW/FSxgIynbDyvaeIBcV6C8WuZRoIjnbXsovfx5S4oY0sZmxAqyFh+MiE6wSVtoZS
	 mbWY9taActZ9ZxgK7cUl4lqoyOgRlZ+eHtLA2AaYd80B3sxAS9vfZTibkYzUk9PcpxqPp
	 BZzGaNCpRKrmBqEj4yeTa12u6IIXxKhxrpT1v0f1l0U+NdrVzBhi0BVD4X1fUrjWQ1lwM
	 9txqWqeCShFoWuRMjxvr/vZkyEpIQsGm+HAlptrKwihnyRWV/YAjJJzpamRkFDF3kl0xz
	 15yNKDNAVMOqxTr3UXchku1YqidYyQJx/3wX+4O/pp6j8uL5mgndG02A0jQCMRGdbyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793874139;
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
	bh=Cq4xX5/2Mzc/zhLqJsZhsvHS/kOBrqYwFjA6Aa0QV2E=;
	b=hT01pMjgLnY68iknk1A51LXpEPScULEke4Wn48/4bQESLpkZIrLfAP39yTcsYoQE+JC+
	 XKlwA0wreiTmlNsRSO6zOhqta4Da/oQt/1++OG0GntulOKlxKRRnvLlzn8EYXD7oxJnAL
	 BBT2Fppwc/QKTLaM7ayiePYFp2GKHRQhSrMpVEt0I3bXZS38DZ3wazQ6vCiKwZqfKhXHC
	 nPruNZbCu+S1lfc7766wknLLI/jXqgegwgSE0fATs3Jl4Cq/5xCqoT/D+rw3JCTwLAGWQ
	 MoukU72xkLxuGQDQ03TvnQm9TsxKRH1+KJfX7C4Nc0+XW0di4Tg1nIz7oNupaoJHuhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=leO751yB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793874139;
	bh=Cq4xX5/2Mzc/zhLqJsZhsvHS/kOBrqYwFjA6Aa0QV2E=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rsQNBBc1CoHPS14loL8DMOdx4wRSA0T3+q3geoUu0dp2PBgJWH65+kbxpi0nLdW9x
	 VlEvpt5R0MNTKG5yXRaOJDeNsUMndRiiP3ZKqkmyEiP/R12PkrhLmOfUm4COg5m9op
	 lLt3G+NVqsnVpcBt58dalwyGa5GLgAn46pW+LwAsdEZwjO2mgkcZuPOV/Wp4x3U6gc
	 D0U7OFpbSxrECwRWBmXBHm0LgB5cqul27a7uOJ6G8RRjC1pdaBgiIfWlkAxo5Vmrs8
	 u6Q7J2G0EG7PayFGnG+tUQYulEw5l8ypmJ7IcV7FEGaUMRj8AF/WXSK+6ThstKYCrx
	 3po3CtWdadiUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71A0F4081B;
	Thu,  5 Nov 2026 10:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E66E1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4452A4081B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBF-_19Bm37s for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A3A44072B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=leO751yB
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A3A44072B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:22:15 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1395517f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793874133; x=1794478933;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cq4xX5/2Mzc/zhLqJsZhsvHS/kOBrqYwFjA6Aa0QV2E=;
 b=leO751yBdOKE6vmAZT5BwEg2M+RnLJlkOB4dkv2DwpCnyJceUfTktTVVL7Q/A6XqmB
 pghwGCKRItSL1QHWBUOTUF1aBQj+Mm++8tR0Yg7uFWD1U/icaV700NdUNZooTYCBf4+r
 cM5xK9TtALkQnOyFbN0XHD/OjsNuo7J/+HrtKMQXt96i4YjJt3IKECLBvQ7eFhr4lDTt
 1sOtN0m1sdmw49JsQ8bEfUgxGGjMaGMqhIm7xx1O73B3Z1KxddHEoIR0uqp8x4P81R/g
 949pOoLEl2FUHYioQXTxvxP6yMhxhq3DDW/1o5oPNaDCVfwHkyfBm9/NKysHD7SaiRCe
 odSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793874133; x=1794478933;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cq4xX5/2Mzc/zhLqJsZhsvHS/kOBrqYwFjA6Aa0QV2E=;
 b=y/xPWC0CQdEaulAxIwJWciPYggJgCpcYX2H5cip3CmPwOjvBhOcYAYwmwpUXI+x7TV
 SYvTLaHY2RmwiBkeLB01VkSPi0B1bxW4ZxbAop3/juvsR5vKjWgYtbNvv/7CHy2D84z2
 P3cLbRnR+GqseSpP9IkHXINORvEYhIQXHtNvNBpKFglyPt7O71c689fuuYz0yfvFmbMx
 KSJAliqhJnO2jE6r7AVqCjsVW2p3mydNnb0K/qwO2VrDb0ikRON4MDlSCuPAze2LyEEu
 r4WK3Ow2gCMGkF7AyEzzlxmi6UAxiLFkQjidK3aC4cY8s2TW8Dcl66dQE5tnhbDEqKF/
 cx/w==
X-Forwarded-Encrypted: i=1;
 AKwUvByde9/9j0rJ9lYjtgrr6LtOMaZ61xGF/Hs2z/0jzTyfirdg/xKgZTnMA6Z72fMMT9z/1bUK9A0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+B3erwTK8AWjnL45HS1R18WpZvy4Bnhuabmk8wVt9rz/+BQwya
 zMWYIsoKgnBYqalrChxC/roVVetELeNoq+4hxmOsxM+kvgBeXknxlqe/aNs4z4+GSYg=
X-Gm-Gg: AYBFou1dDZIFtioZfgK57kqSPt5TusQao9vczLTJ320gFErLnpvWMBmVRkstQ3f8HAf
 Dg2Bfi5CWHlykN9JiUToLtTUNUvJvmsm3p/o+cuTdi2sweLJ7hl/jVboK+wI/ZqPMniy4hEWL9w
 b612wU2AgNHM6JNwl+PhBQsgSepefjLfnoVGyrFBgqHgnldRK8woF/pjbNyDh3It/mXMwN08sBr
 LbA3hF0yhsvG1oCeRoWlC6L8Mrg6Abkf+Fp7u9j/I/HgNu6nNfn5AeY/1xabAt4YWsjSgzQD9w9
 sB4vht7SX2se2s7cehHBORDTvRkJo2dCMPYEx4q+zLBpqQZCPhR0oYFDwjJCtsdhsa9xeUC01dN
 w/6CGVAdGZs/leW4uOi6pr+vjxriUpUWgt5+pCSFju9Id7a5l2SOSGyq5UZssnvqU5eEYkAYTfA
 ElDc65UGwHZlIScUhoLu5xJkxOI/4n7MMrXBW87VmExzNftet24o8Tjsb1FjFeyGfqKhouRWl+U
 g8ICqoN/R6xC8PFYI8Qsqvu1es7ZElPcub9dVdhbs+tsJeO8UIbEgl+8ffsx+fEGVM3hY+xU88h
 9qm7nABKY6raImNXEFRWtNdRR6bgWi4SkKbPDGOVY6VwnTKzwX58PnQ/+C2QRoSoD5iiJXBUqx7
 UTaOhXGj5HHUkbkaw0IXnQt9pMMuq
X-Received: by 2002:a05:600c:630d:b0:4a7:a309:6b73 with SMTP id
 5b1f17b1804b1-4ac150b2896mr388564705e9.1.1793874133180; 
 Thu, 05 Nov 2026 02:22:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08536dsm8153785f8f.32.2026.11.05.02.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:22:12 -0800 (PST)
Message-ID: <6382194f-3574-4ef4-af19-03a3138ab263@linaro.org>
Date: Thu, 5 Nov 2026 11:22:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] pci: pcie_dw_qcom: fix BDF-to-SID table never getting
 programmed
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 senthilkumar.l@oss.qualcomm.com, marek.vasut+renesas@mailbox.org,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261104162419.1243471-1-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104162419.1243471-1-sumit.dhami@oss.qualcomm.com>
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

On 11/4/26 17:24, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> qcom_pcie_probe() does not set priv->ops, so the of_match table's
> per-SoC config_sid() callback is not invoked by qcom_pcie_init_port().
> As a result, the RC's BDF-to-SID table remains unprogrammed and every
> endpoint's DMA is tagged with SID 0 instead of the SID from its own
> iommu-map entry, causing intermittent DMA failures on SMMU configs
> that fault unmatched streams (USFCFG=1).
> 
> Set priv->ops from the of_match .data via dev_get_driver_data(), as
> the qcom_pcie_ids[] table already intends.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_qcom.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index ce6b4d97d1d..dd69d8b99da 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -489,6 +489,9 @@ static int qcom_pcie_probe(struct udevice *dev)
>   	priv->dw.first_busno = dev_seq(dev);
>   	priv->dw.dev = dev;
>   
> +	/* Wire up the per-SoC ops so qcom_pcie_init_port() can call config_sid() */
> +	priv->ops = (struct qcom_pcie_ops *)dev_get_driver_data(dev);
> +
>   	ret = qcom_pcie_parse_dt(dev);
>   	if (ret)
>   		return ret;
> 
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
