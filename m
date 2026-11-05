Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133F606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yROFYeh0;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u1PYsxBl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05547810BC;
	Thu,  5 Nov 2026 10:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjAAl7LdliRm; Thu,  5 Nov 2026 10:39:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36C94810D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875141;
	b=lTevL0VS/8jET7MPfOSn+GpvrrgZCX1WbU1SFFbdJSqxfbwplXWOQOb7gdnoBxs2KULM
	 X3OUXFdxZMGd19/tHL3fdgQaUlm6HraKuciVqVLZWjzQ2byN4k+E+pGUYpsEV+yvhYVe+
	 uuMXL5osBKl7HbwGENp5Bi8fDOB/1b4BvH8iuAF0irWXSTrUJzFNNwgouS9LJc5m+ZItj
	 xAfp/Q4TNgiGa2/Q6+qxfuvSsv/zg/QOCZwzd9q3L6R+CTpFCME+TLXMAtrV+ZG1n96ly
	 jW4t6nih/HIUDydKhIP/dHHAtMjNyHHTco3nYx5S40sU2fuLXCvjcH1QoSpqt5Wr15g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875141;
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
	bh=BHynYFE6YK8+ELuv3ey4KjCEGiI3jbW4iQOVVPxBl2k=;
	b=sCL2u78UxRa178DIDWNFAMjFSTwMpbcufdQrL9BNvlNb81Kp0jFMyvk5b1UtxOgcnwDd
	 bp5QXF4XkaBX58iSefV2TCrLreN+moBeLbxH1bL6ef5UZtV0NP+wVI18za2QsYPdMRntq
	 giBxfZ6IIWOZ/Th9ZlATbtqgOWJLsXuy4O4Elhu5phtq0ni1MiqzvjXaKxT2O82FbeMhk
	 wDeTVrNz/acyI4R+y8GcVFQBPB25QNYO7BCKDfknvDW8UOmAiAi2GBXbMP74KADA7fURC
	 L0bEGZB3PlqnHhXqqee3NywGGvz8JOMHRAfyYLgZueU5nkkA8Isa1Bw1goRtqfa5K8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875141;
	bh=BHynYFE6YK8+ELuv3ey4KjCEGiI3jbW4iQOVVPxBl2k=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=yROFYeh0KO2gWLX7JLVgE3RhWCJ+ZquTwCzl+XWSlGNI+1cG01bbQzuex85jtfqav
	 w746wlTjACff2h4JmqUjJnoTJvKXZ3K/wyHWWoIEU1u/LspMJjIztdvuwziS+zNDMZ
	 EVaiwgw7OsesHHhqRCzPmViOADwbS/fEwMoMNUsEIWhecAb961XP35kwKnYgO1XAxZ
	 YJbonCT+B97db8Gxb6z79ib3ikYgLgGBM9TIxU8L1FMu7JiewROUv9gMt9ILFp+kgU
	 mJyN24qZ3o1n10BG2j54SlNFJPpIT1V6/V4F4AFSjBmzaunKxdjqMZL9CGqdbL4H89
	 w9Tutp0P7lCvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36C94810D6;
	Thu,  5 Nov 2026 10:39:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7922A2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EE566078E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hq6C6_kSNup for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38565606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=u1PYsxBl
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38565606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:38:57 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so5237365e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875136; x=1794479936;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHynYFE6YK8+ELuv3ey4KjCEGiI3jbW4iQOVVPxBl2k=;
 b=u1PYsxBlT69luCmS7BCsKicXArKNadtuo7p7LUhLEMk555NOg3bCJ3C77VVmQ7v980
 MvbXmM7qxeQFvEpmvzcYWRq/+sXcrpyD2By6n1aJE4yO4dAvMi5NdURnKPG2XK8g7WmK
 qpiZqOkrQPuoX1TMp6oMtEUYlLG7+FIK7se/TcZKyMh+a2t3Bc0pfWfmOaUd9k6wEVgt
 vaoWk6P9afVLOVsbZi7+VhkV36d4hRzsoVcNId9m6JSXs3ILz9/gdEMbrLxadLGs22VZ
 L6wOy11wfmhZXI/ZA6IrCZyX+ghkJMRk52DL6UMwFVQx7oQm/DLHKPA1mf17NDfzWVRg
 3PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875136; x=1794479936;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BHynYFE6YK8+ELuv3ey4KjCEGiI3jbW4iQOVVPxBl2k=;
 b=bgGnzj3fyeWcpBK3vUvMGptA7T3NBH5G23pC1iu+fE0pBDJumLsZ3fpGSsSB6M6GKP
 8pRsFOzi7onIL0yrW/uzzOeAmM2ju09uSVCIULC1mkc5bpFZFPY/3uPyYBAq4IOJyXHm
 CsUsI/5gElKunI+4WUeKy6hUQmwVEAvuCqxwtLA4+k6IPibKSmg5nlssNM45Rvcs7ZF4
 MjE9RiBLRewEC8vvqhBWSZlzVjIiz0AalSH6OPS+bDnJuDWKl5WKDQTXeen9kUsAejDG
 gp+M5L7dLBS/aKfgwj/UfqPHGFGR0i1nSRwrfZ4tllM0fV3j36KZzXF93AGhj36zCxiE
 X86A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKRlfX82UFpbqzUIu5UJXVAUjap/g6CwDpPGmAMQW9e0jIAZpwBe12YyDOricfeU28AmslVE8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9IFyIXje5fEWdGNdXBM07T4T1cN0Tw0XXNmzMm5T+Wpofoq78Z
 zyid8RAfgMKOvjRMz5syPCarXL6xGIYz/qnULHncqVG4gqYS0c9Du/+Q059cgCgApyo=
X-Gm-Gg: AYBFou3C3jIyM24yR32orI+p4/Ro9Kg6+ZgOHF3tF5nkuEkHYTo8IEGJ9cCYdoFvkDt
 r0n49YLB+bZemcxW1TU+zCJvposixvHXN/Xmn30rKSClSK8pJkz0XFUx+A2+jTFLG/ZrGAxrlyr
 JUjXShyiRKYidLGNGyl/Hf1NtcReCapo6e+NavyGZtVhEJHv4SgF8C42taecwQNoAdeXpwH7cB9
 ZQzmox6r4vdPRiORHH3Hyv5ZPfMrleAxUa8eGSK94Gy3tahtAR3McehQxXhxJCtOSKYzMOlhwaQ
 +IN5bAxvYFkacSsQIx8u+Yl/gwvBIY+bsZfcEMy22LSZIdubgoIncBRX1YidtNpZkWuVG13LNrQ
 So/pkn/MbIto/1kkQ6VebrQrdUEUItCUWvF/5hPA4XfGAoAzfyXC4GYMrZ2Il0dmCAHart1dC/o
 XJKYix8Roiz8Yf/eZcRzIEvlBJRA9ZlzQwMXfAd6GLblJjjewIN8fdPsOw4+EQ5zkXwlh/g5xob
 421HuACXPYayZ3J3B1F/eCUkBCZL3M4AZj6S7izKM+PfTx0pwtGHvlasy9Vc8OrEv+VVFRLV/gN
 Sms1yPCS3eXo92WJSvbGVXf/723iydBVW6UgwBSVeMMOwKj3DjlBgey5PWtEo86BoM1Jo410NyO
 Z9toVe2M+
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4b55dbb09dfmr38555695e9.13.1793875135519; 
 Thu, 05 Nov 2026 02:38:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm59747615e9.0.2026.11.05.02.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:38:55 -0800 (PST)
Message-ID: <c366941c-be59-41ac-9c17-0f77ada4c534@linaro.org>
Date: Thu, 5 Nov 2026 11:38:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/9] pci: dwc: add inbound ATU window support
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-2-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-2-sumit.dhami@oss.qualcomm.com>
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
> Only outbound ATU window programming is supported. Without an
> enabled inbound window covering an endpoint's DMA range, the RC
> drops incoming Memory Read/Write TLPs, which surfaces as a
> Completion Timeout at the requester with no error logged at the RC.
> 
> Add pcie_dw_prog_inbound_atu_unroll() to configure an inbound ATU
> window, mapping a PCIe bus address range to an AXI/host target
> address.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_common.c | 59 ++++++++++++++++++++++++++++++++++++
>   drivers/pci/pcie_dw_common.h | 23 ++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
> index 4113a9f03cf..cdaad0960fa 100644
> --- a/drivers/pci/pcie_dw_common.c
> +++ b/drivers/pci/pcie_dw_common.c
> @@ -144,6 +144,65 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
>   	return -1;
>   }
>   
> +static void dw_pcie_writel_ib_unroll(struct pcie_dw *pci, u32 index, u32 reg,
> +				     u32 val)
> +{
> +	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
> +	void __iomem *base = pci->atu_base;
> +
> +	writel(val, base + offset + reg);
> +}
> +
> +static u32 dw_pcie_readl_ib_unroll(struct pcie_dw *pci, u32 index, u32 reg)
> +{
> +	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
> +	void __iomem *base = pci->atu_base;
> +
> +	return readl(base + offset + reg);
> +}
> +
> +int pcie_dw_prog_inbound_atu_unroll(struct pcie_dw *pci, int index, int type,
> +				    u64 pci_addr, u64 cpu_addr, u64 size)
> +{
> +	u32 retries, val;
> +
> +	dev_dbg(pci->dev,
> +		"inbound ATU: index=%d type=%d pci_addr=%#llx cpu_addr=%#llx size=%#llx\n",
> +		index, type, pci_addr, cpu_addr, size);
> +
> +	/* PCIe bus address range that this window matches on */
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
> +				 lower_32_bits(pci_addr));
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
> +				 upper_32_bits(pci_addr));
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
> +				 lower_32_bits(pci_addr + size - 1));
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
> +				 upper_32_bits(pci_addr + size - 1));
> +
> +	/* AXI/host target address to translate matching accesses to */
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
> +				 lower_32_bits(cpu_addr));
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> +				 upper_32_bits(cpu_addr));
> +
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type);
> +	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> +				 PCIE_ATU_ENABLE);
> +
> +	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> +		val = dw_pcie_readl_ib_unroll(pci, index,
> +					      PCIE_ATU_UNR_REGION_CTRL2);
> +		if (val & PCIE_ATU_ENABLE)
> +			return 0;
> +
> +		udelay(LINK_WAIT_IATU);
> +	}
> +	dev_err(pci->dev, "inbound iATU is not being enabled\n");
> +
> +	return -1;
> +}
> +
>   /**
>    * set_cfg_address() - Configure the PCIe controller config space access
>    *
> diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
> index 5fa50f3dc3a..6384dac6f0a 100644
> --- a/drivers/pci/pcie_dw_common.h
> +++ b/drivers/pci/pcie_dw_common.h
> @@ -48,6 +48,8 @@
>   
>   /* Register address builder */
>   #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
> +/* Inbound iATU region n is at outbound offset | 0x100 */
> +#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)	(((region) << 9) | 0x100)
>   
>   /* Parameters for the waiting for iATU enabled routine */
>   #define LINK_WAIT_MAX_IATU_RETRIES	5
> @@ -142,6 +144,27 @@ void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes);
>   int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index, int type, u64 cpu_addr,
>   				     u64 pci_addr, u32 size);
>   
> +/**
> + * pcie_dw_prog_inbound_atu_unroll() - Configure inbound ATU window
> + *
> + * @pci:      Pointer to the PCI controller state
> + * @index:    ATU region index
> + * @type:     ATU access type (PCIE_ATU_TYPE_MEM for memory)
> + * @pci_addr: PCIe bus address (what the endpoint sends as the DMA address)
> + * @cpu_addr: AXI/host address to translate to
> + * @size:     Size of the translation window in bytes
> + *
> + * Configure an inbound ATU window so that DMA reads/writes from PCIe
> + * endpoints to host memory are forwarded to the AXI fabric. Without at
> + * least one enabled inbound window covering the endpoint's DMA address
> + * range, the RC drops incoming Memory Read/Write TLPs silently, which
> + * shows up as a Completion Timeout at the requester.
> + *
> + * Return: 0 on success, -1 on timeout waiting for enable
> + */
> +int pcie_dw_prog_inbound_atu_unroll(struct pcie_dw *pci, int index, int type,
> +				    u64 pci_addr, u64 cpu_addr, u64 size);
> +
>   int pcie_dw_read_config(const struct udevice *bus, pci_dev_t bdf, uint offset, ulong *valuep,
>   			enum pci_size_t size);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
