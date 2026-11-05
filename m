Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C3606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zABPbmiY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iKFP+/VK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B670D40856;
	Thu,  5 Nov 2026 10:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5B-8_jgf00W; Thu,  5 Nov 2026 10:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FBBF40820
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875106;
	b=ed7/BmM+IGl4YImX6gUtW8fzWi5qpjlm8e22jfSDDcHBuVDcuj5kb5Ksw8pwPkqBnasa
	 khZ8EweEVrkHhifB64Q2+Nl2Nkp+igCE23qGR5D8D0O+c3z6to3JyIhQZgimkmHg9Fn6a
	 Bo5q9mqozUAJQ5tuT5sBcnloC62HeC/8Qr+vrS7XJMvXxid8tY87/YxaA5ppCsjC0b8Bd
	 Hc9TgsQp0Hyizg25UgY98y07pSdsyFnfBEmmYyP59Zt7bW2Z8BmsjGv0Z1rnFhpDW7Vxy
	 l21OVw/FD1SxiDoAHmwaNm1jZAgiEV5mZfaI7bkGVQAKBqC08gQ2MS+2X3iKg1zMNXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875106;
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
	bh=lXWl+9BWaZUrLqn5WdMvFaQtgv+H5gglaqmqyn4QReQ=;
	b=siG2vecrbrHtnS5Ix4/sZW/h1+PoHyRrFTa+g5bNvNuVMkyxrvfyraXSS520UqMJE/GF
	 uyKYnatGMNeHnuJsjuTuwqRFR03LFwRif7fM/bPsDTDObclVi1OlXKPWCInBMEN99E3m3
	 4NAdrnBrC/ChIyo3x4wqLdGKW3Uro2lWGL62yKS74oxMfTQvV0C/kXF1KfiQ3gyw/CyiC
	 gS1nWsEj3HS+T65K3gYyoVFDittIIonNwLCLN7ROOPliBOVm3dxNhnnQCPC3Wi250bbA1
	 l5A7WemsXSnyomkE6x15GWpN30fIYx1l9AEPUb8ZzXDbs9OWUdVzYUlr9t+wHRgKjAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="iKFP+/VK";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875106;
	bh=lXWl+9BWaZUrLqn5WdMvFaQtgv+H5gglaqmqyn4QReQ=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zABPbmiYYmWi2T7unfa71f7nvqSbjzgq9BG+izOV2qGbpRm64sA5Ji8uV4v9XvYY1
	 O+Xteoj13eI/TV8Gjb1Nqf1O13ZxnsMQ5m6gseUl9Sf2Jpk97xim7laI1blMancu3n
	 MbJ4v8vH2SZUpCyqvMcOMEPSQ+QIXfrO3VQhg6pZwTvLEsaRjh/xFT+ZF/2bVQtsHH
	 3yacb81VpT4sqs8r4X2GziofPftqShTEl/hBFIbA8q7AasVgaNKD7oJClTlmcJPXTx
	 p0abr7VvzutvBpWmjKb6TlH2emlsGEuM2U+OveDvwtKm0jJI4RbCXyE3zz929uTYmX
	 Gf0o90Yk4QgHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FBBF40820;
	Thu,  5 Nov 2026 10:38:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6B1031F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC4C740820
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Nak9g8A-dYW for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3804540770
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iKFP+/VK
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3804540770
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:23 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so710980f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875101; x=1794479901;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lXWl+9BWaZUrLqn5WdMvFaQtgv+H5gglaqmqyn4QReQ=;
 b=iKFP+/VKdAErqI2a+DyOgAYkak3D7YXKPyKPNFsZNl3tHmY2AbTUpfOmeEj8GD60Tk
 O2UpuSIJczsb4iLYqhzbNSUI4gep+ByPZYhImN07XY9VDZx4Tcr+NVEitSF7ZFJN867V
 7Z6dZt3lgwSeGvj9vWPHiKrKMTW4P81M3r73h5U4iKyOIZtTZpSeAai/xgLvFNEaVODC
 WNhPk9MppovOPSvGXWTx4NUnY76KsUt9PN909n2Vtc74/BFgMDOu1Ols5eCL94NufNbO
 J4FSHFv89Yipa5vU4S0glTwiDHBjcL8vwS6dlGg+RjMAKfo1oEdqMbg1Yg8QW4+Z7q8j
 selg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875101; x=1794479901;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lXWl+9BWaZUrLqn5WdMvFaQtgv+H5gglaqmqyn4QReQ=;
 b=0lZmuur8tDl27t0pf9UMVvRSFUqykUFbHtQXum0ntHaWIiA1tJPwyJROuMq/2o7vrr
 z64bSSuirQaCMMDaCFq54eGLCwzeAiqSB9PAltFiQQeJOUF0jl7Hhy1Kjm10UMOQfcGW
 dXcXbtYoz7u+uEoav69mMZfI+cRinIBwqDWsVEuCMzXKZqW8Aqz+YSwrLQqCSCjnikiQ
 1AeVH/aTNpJRRFfQfMpVVrpU6TSHMgW6iEbfw8lWbPD3Oqo+wynL/BND95KP0Cu73kjG
 PJcd7LxZXTHD7HaarmzR//+Z9Cern4rk9+oFy/5Iga6301ohrWs/Keb7xLK3/gp+LjMU
 zQ8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBySii55JwSx7zIquE+XYVSzxFVkf1P7U/nl299toqWLuh/anTFZ+zWkWLADc54zhQHCRiYRfhs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9vf1TnV2N5eYL3oWNp/0u3miceIG5VDMx8jl01vtf4pzp70gGx
 OsEm0ev0mTfdBtDTplvSAaTjqDaqJKdebkO4HIxUwzUFtgwMtrMup3WEeQbGntRtoFk=
X-Gm-Gg: AYBFou2zFjEl821/3DMT5shOEoCLEWo4RFdjDeUERQzGg8FneyzNXF5BbqpvZzyVQlG
 28t2Y/pBO5StTP8uqDoHHiC4SyPhMDBZDV5uMhRxAj8DxvIs0zVn5hU2UuktujGLaQNxGkpdHfr
 UGw6vqBhBtildeBmurmplrKpXsFdMQicuRmR6btIl8DFXGCnD5zNXDRFPkgunckhQSQ2vBmFOeE
 EkZ01xLLd8K1yY6ZOrj0R5yMeaqrs023qHeVveYs2uPlUSeSNPNQqLsUW0MHK3fFTSzb4dCmYXo
 WZPf4CaTQySGd6aVMAs72u1Ep5PLmPwtcHZD7mKaiAHY2DWb8o19+AZgPO6wj5FRvxvDaICrht7
 OipACKLsXdYfATrLOGaHJT99o3XCV57bq3pEOhV9O8fW0Lo2palTXeQEs03GrfL3BITnmzv6OwO
 tcrgK63rc7r8OKxDy8e6wAtXVUm4aortWW2KstyujcwzqQKOWjstJt2Z/C445f9lK/7dlI597BL
 Msyo+5yt+3H82AXdlB8KdZClklGs98TQFUjrIz7l48k2STWNX2XM6tztyFvt5UlP47Jt2MVStPT
 +07Vk+iShr8TGSCmjcUYHLn+OVp5yiFDgAMYvpTHgkqeklGMDj8c2cJpBxvoEX2Rm/ZMONwrAJ7
 mXBBrHs92eocbcT9YiNe6jjVsRYzZ
X-Received: by 2002:a5d:5f89:0:b0:490:2033:1477 with SMTP id
 ffacd0b85a97d-49020331482mr7289812f8f.56.1793875101265; 
 Thu, 05 Nov 2026 02:38:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180e7csm9349547f8f.5.2026.11.05.02.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:38:20 -0800 (PST)
Message-ID: <2b46fb47-182d-41d8-873b-96d07d575172@linaro.org>
Date: Thu, 5 Nov 2026 11:38:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 8/9] iommu: add PCI stream-ID resolution for devices
 without an ofnode
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-9-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-9-sumit.dhami@oss.qualcomm.com>
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> dev_iommu_enable() returns early for any device without an ofnode,
> making the dev_pci_iommu_enable() PCI iommu-map fallback unreachable.
> That fallback also only resolve which IOMMU a device belongs to, not
> its stream ID, so ops->connect() has no ID to classify the device with.
> Separately, qcom-hyp-smmu.c disables stream classification at EL2,
> but firmware converts an unclaimed stream to a FAULT stream regardless
> of the CPU's exception level, blocking DMA for downstream PCIe/UFS masters.
> 
> Restructure dev_iommu_enable() to fall through to the PCI iommu-map
> path when there is no ofnode. Extend dev_pci_iommu_enable() to
> resolve and store the stream ID in the new pci_iommu_sid field and
> call ops->connect(). Wire this field to get_stream_id(), and drop
> the EL2 self-disable.

I think it would be preferable to either:
- add the sid as a parameter of ops->connect()
or
- add a new ops->connect_pci(u32 sid) dedicated to PCIe endpoints
if you don't want to touch the other IOMMU controller drivers.

I don't think it's a good idea to polute struct udevice with the pci sid.

And then please split out the qcom-hyp-smmu into a separate change,
first adding the connect_pci() and then enabling for EL2.

FYI I have a similar changeset in dev:
https://gitlab.com/superna9999/u-boot/-/commit/f08275fa955106deb3a03eac8f735919a824dc15
https://gitlab.com/superna9999/u-boot/-/commit/6b381f8a17e75c19044eb52a4e6b29fcde4e9a43
https://gitlab.com/superna9999/u-boot/-/commit/5b248f5d32cd742029d5eda9cea07de98d153a0a
which is functionally similar.

Thanks,
Neil

> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/iommu/iommu-uclass.c  | 78 +++++++++++++++++++++--------------
>   drivers/iommu/qcom-hyp-smmu.c | 27 +++++++-----
>   include/dm/device.h           |  7 ++++
>   3 files changed, 70 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
> index 31b40e5713a..2299bbbdd37 100644
> --- a/drivers/iommu/iommu-uclass.c
> +++ b/drivers/iommu/iommu-uclass.c
> @@ -18,8 +18,9 @@ static int dev_pci_iommu_enable(struct udevice *dev)
>   {
>   	struct udevice *parent = dev->parent;
>   	struct udevice *dev_iommu;
> +	const struct iommu_ops *ops;
>   	u32 *iommu_map;
> -	u32 iommu_map_mask, length, phandle, rid, rid_base;
> +	u32 iommu_map_mask, length, phandle, rid, rid_base, iommu_base;
>   	int i, count, len, ret;
>   
>   	while (parent) {
> @@ -50,6 +51,7 @@ static int dev_pci_iommu_enable(struct udevice *dev)
>   	for (i = 0; i < count; i += 4) {
>   		rid_base = iommu_map[i];
>   		phandle = iommu_map[i + 1];
> +		iommu_base = iommu_map[i + 2];
>   		length = iommu_map[i + 3];
>   
>   		if (rid < rid_base || rid >= rid_base + length)
> @@ -64,6 +66,18 @@ static int dev_pci_iommu_enable(struct udevice *dev)
>   			return ret;
>   		}
>   		dev->iommu = dev_iommu;
> +		dev->pci_iommu_sid = iommu_base + (rid - rid_base);
> +
> +		ops = device_get_ops(dev->iommu);
> +		if (ops && ops->connect) {
> +			ret = ops->connect(dev);
> +			if (ret) {
> +				log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
> +					__func__, dev->name, dev->iommu->name, ret);
> +				free(iommu_map);
> +				return ret;
> +			}
> +		}
>   		break;
>   	}
>   
> @@ -79,41 +93,43 @@ int dev_iommu_enable(struct udevice *dev)
>   	const struct iommu_ops *ops;
>   	int i, count, ret = 0;
>   
> -	if (!dev_has_ofnode(dev))
> -		return 0;
> -
> -	count = dev_count_phandle_with_args(dev, "iommus",
> -					    "#iommu-cells", 0);
> -	for (i = 0; i < count; i++) {
> -		ret = dev_read_phandle_with_args(dev, "iommus",
> -						 "#iommu-cells", 0, i, &args);
> -		if (ret) {
> -			log_err("%s: Failed to parse 'iommus' property for '%s': %d\n",
> -				__func__, dev->name, ret);
> -			return ret;
> -		}
> -
> -		ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
> -						  &dev_iommu);
> -		if (ret) {
> -			log_err("%s: Failed to find IOMMU device for '%s': %d\n",
> -				__func__, dev->name, ret);
> -			return ret;
> -		}
> -		dev->iommu = dev_iommu;
> -
> -		if (dev->parent && dev->parent->iommu == dev_iommu)
> -			continue;
> +	if (dev_has_ofnode(dev)) {
> +		count = dev_count_phandle_with_args(dev, "iommus",
> +						    "#iommu-cells", 0);
> +		for (i = 0; i < count; i++) {
> +			ret = dev_read_phandle_with_args(dev, "iommus",
> +							 "#iommu-cells", 0, i,
> +							 &args);
> +			if (ret) {
> +				log_err("%s: Failed to parse 'iommus' property for '%s': %d\n",
> +					__func__, dev->name, ret);
> +				return ret;
> +			}
>   
> -		ops = device_get_ops(dev->iommu);
> -		if (ops && ops->connect) {
> -			ret = ops->connect(dev);
> +			ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
> +							  &dev_iommu);
>   			if (ret) {
> -				log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
> -					__func__, dev->name, dev->iommu->name, ret);
> +				log_err("%s: Failed to find IOMMU device for '%s': %d\n",
> +					__func__, dev->name, ret);
>   				return ret;
>   			}
> +			dev->iommu = dev_iommu;
> +
> +			if (dev->parent && dev->parent->iommu == dev_iommu)
> +				continue;
> +
> +			ops = device_get_ops(dev->iommu);
> +			if (ops && ops->connect) {
> +				ret = ops->connect(dev);
> +				if (ret) {
> +					log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
> +						__func__, dev->name, dev->iommu->name, ret);
> +					return ret;
> +				}
> +			}
>   		}
> +	} else {
> +		count = -1;
>   	}
>   
>   #if CONFIG_IS_ENABLED(PCI)
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 5b37c21f66c..3fc3e1211a9 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <log.h>
> -#include <cpu_func.h>
>   #include <dm.h>
>   #include <iommu.h>
>   #include <linux/bitfield.h>
> @@ -92,8 +91,6 @@ struct qcom_smmu_priv {
>   	phys_addr_t base;
>   	struct list_head devices;
>   	struct udevice *dev;
> -	/* SMMU is not needed when running in EL2 */
> -	bool disable;
>   
>   	/* Read-once config */
>   	int num_cb;
> @@ -132,12 +129,25 @@ struct mmu_dev {
>   
>   static int get_stream_id(struct udevice *dev)
>   {
> -	ofnode node = dev_ofnode(dev);
> +	ofnode node;
>   	struct ofnode_phandle_args args;
> -	int count = ofnode_parse_phandle_with_args(node, "iommus",
> -						   "#iommu-cells", 0, 0, &args);
> +	int count;
> +
> +	if (!dev_has_ofnode(dev))
> +		return dev->pci_iommu_sid;
> +
> +	node = dev_ofnode(dev);
> +	count = ofnode_parse_phandle_with_args(node, "iommus",
> +					       "#iommu-cells", 0, 0, &args);
>   
>   	if (count < 0) {
> +		/*
> +		 * No "iommus" property of its own: PCI endpoint resolved
> +		 * via an ancestor's iommu-map property instead.
> +		 */
> +		if (device_is_on_pci_bus(dev))
> +			return dev->pci_iommu_sid;
> +
>   		printf("Error: %s: iommus property not found or wrong number of cells\n",
>   		       __func__);
>   		return -EINVAL;
> @@ -280,9 +290,6 @@ static int qcom_smmu_connect(struct udevice *dev)
>   	if (WARN_ON(!priv))
>   		return -EINVAL;
>   
> -	if (priv->disable)
> -		return 0;
> -
>   	mdev = alloc_dev(dev);
>   	if (IS_ERR(mdev) && PTR_ERR(mdev) != -EEXIST) {
>   		printf("%s: %s Couldn't create mmu context\n", __func__,
> @@ -354,8 +361,6 @@ static int qcom_smmu_probe(struct udevice *dev)
>   	priv->base = dev_read_addr(dev);
>   	INIT_LIST_HEAD(&priv->devices);
>   
> -	priv->disable = current_el() > 1;
> -
>   	/* Read SMMU config */
>   	val = gr0_readl(priv, ARM_SMMU_GR0_ID0);
>   	priv->num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG, val);
> diff --git a/include/dm/device.h b/include/dm/device.h
> index 5d700888503..f8777aead83 100644
> --- a/include/dm/device.h
> +++ b/include/dm/device.h
> @@ -203,6 +203,13 @@ struct udevice {
>   #endif
>   #if CONFIG_IS_ENABLED(IOMMU)
>   	struct udevice *iommu;
> +	/*
> +	 * Stream ID resolved from a PCI iommu-map property, for devices
> +	 * that have no ofnode of their own to carry an "iommus" property
> +	 * (e.g. dynamically enumerated PCI endpoints). Valid only when
> +	 * iommu is set and the device has no "iommus" property of its own.
> +	 */
> +	u32 pci_iommu_sid;
>   #endif
>   };
>   

