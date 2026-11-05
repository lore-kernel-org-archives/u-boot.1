Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D128606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QUCdDY9n;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QyFRNJqw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD9A8810E8;
	Thu,  5 Nov 2026 10:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7YKNsmVz_mA; Thu,  5 Nov 2026 10:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BED62810CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793876343;
	b=Jz//aW7HCmUUcUjkAKVIEVxBe6sqNqVM9gZ0jVwKVda+/Fb97Pv+Vckhcm1nb0G0kY6l
	 xDq9mgc6V/8+k90jp1Jta/a37OPX+hkZAXY7qveoNfKTZrS1ar7eojOR/xpw/i2lOZ72P
	 e1m7P+PSDZ3tD1N74V+C4uI8+NRQvrHrZdDpUoCNV740+LbZtAf/boKxKn5rX8ydgCxFp
	 r337/1lLAqtutSqPRgrVYTQaf9rtC9+NubI5Yl+mTosqp6lk5+CT34ocqZKObKqPR2ks4
	 vHaMZ8aJZZg89OtXfM4Cs9INMe0BKILuOsvCsECY+wzxssSIlOpanZ4iCg8Lbus/ieg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876343;
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
	bh=v7506ruzbA5NEcnFC72LQjn58/MYnru0+tbDmLt5qxU=;
	b=L7/BtdUwkJ9qdeOhxOJuk74Bysna1iHWhs6EbgMtOAzukDfoNvTZcKJ02na3+CQLAybE
	 nKLFLO+MKAkTCBmge9Epy8N7h12Lpu/tAsbU+PEG12vk2FRGRSirXsjXlLUqQjSQGMfk7
	 F+EgpDsyXhqBGvz4oI/XPqJxYWw+IHPESSJ20Jy9Ag2eTlQ96aHue8pz7N31kL6v4VneK
	 TDiNePAor8+o59ULS+JrAVnwclXgOb7L/6wR99OQ0dUAPPd/dLgjnzqsxHZdIgCOAwRu8
	 /VSg4IdqGQvytRZukyF+7OhH2AkRiV1bDI1gbxH1KL+301GSmmkIp1jQw7p6CeVabZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793876342;
	bh=v7506ruzbA5NEcnFC72LQjn58/MYnru0+tbDmLt5qxU=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QUCdDY9n5mY79/PsXtvUDETsN8HN8QpmzkuvAg+BjH/nygZGABCQEC9RQ2j02XVd5
	 ILm5CW+2w13HTNOpQFZv3iQzttoCzhCyzO4aMIMRs+hJqd1zq9iGdhgT9IcqbBWXaw
	 SwnJWGb7S6q6NEs2BvicqHw/9QTRyDzXqaSq10/tw2Ui61MQug/11doM6R96IPIzIK
	 IDxa+Tx6noQLYKc2qs8V9ldZXoNA75+82GBG+Bi9USLlNb/ltkD+hs98zXdh2aZAzE
	 Lb+Z5Z9O+ygQmDMn35x+yqvsDGbmbhdOXEtPOgnul4dL2HSJJjFIdrs9tPp5tUskQy
	 e554fZkEH/OlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BED62810CF;
	Thu,  5 Nov 2026 10:59:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 30E4952B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 227146083C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xL8Y-v0nsPB5 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F14A5606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QyFRNJqw
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F14A5606CB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:58:59 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso12776385e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793876337; x=1794481137;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v7506ruzbA5NEcnFC72LQjn58/MYnru0+tbDmLt5qxU=;
 b=QyFRNJqwg2l5OQbyEs+aZlKk58MPNDuzvTbdxQhrXBJQfL8p8ANmltT5wD60TnKr3c
 mmnMHJAe/rI59l/sOUTOzleJSnHBiGDYbWUPhOg/1Id5Q9aEt4RkmQCWI662PasqaGP7
 oacxyoM/O+mjLr7YOjOYoKkOMkwC75t95MBmXBw1hjS1cgE8+AKl6RkRXWxKnlmhIIEZ
 ELy7CZRQsbDy6dkPiU9CljywmFsQEk++XKvcJ+RnaGjeB4GhnN3BSUDCOB9pqjS1zdEg
 NRpZUkSwkpc9BejtLwJnIkLZnAQ1VBEQLmu/S2+dEi/HkypPfqh36fkb1Lp7EpitSuzZ
 UzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793876337; x=1794481137;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v7506ruzbA5NEcnFC72LQjn58/MYnru0+tbDmLt5qxU=;
 b=F/wMkF9RXvCPtWoRPhFspoZLNByQhvpEEB1CcSXBivQwd3uBH4fArl4FLW42OM+NHY
 m+hg8VPN3siAqiLUizVQei4/TQw7P9ZBi0HKJK75wLHU5uMR+j72uPasTymPDeqfz2c1
 MjGLRARcAkiJL+7810LIIRB9DvHuDpGHEAv2U9fQ5NDHntIpjzhe6MlCFIfGbWuac+LS
 iwI5JlbaBXPvPK5FcHevNkGm/RPpaTgyCh7ZNKHhD/jo2IXDNB/EeX77FOnlgoqNWLOc
 dWZwqlZherABztymkK/w+E3mg4OB9anSQCw77XgM2K1AlXMkl2zkS4ZrTlkUAZTvzvuI
 m89w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlwSsP2iwDBquY1nuwSVVdzLUsqueQcUzG55ESHJaU0+xkSDKUOtoWNkXY4iNPsrntDzLUA58=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+95rPgDq+SfLuzKZgUbxwTPZnOfsgL2Spxd2RMzU2FbKDUniyU
 3wOO4DUJ9JBJI/AsXmflZ1onmpG3t154UCPz3zfVfMPR0SzY67aAZ1n61sntQeNA4/C1py+x9jL
 4FDj4
X-Gm-Gg: AYBFou2rKabWMjZY+9VJXtGU/RYUkLZFF80RprV5fmN5crZKGVBKxRnBSvOnxkDotZc
 H9xaPTLfX4Wi5kPw5KEdQdNaPvlx+WCcvsWEjk6yqGfAaToaTS4zgvtttsg6VVY+ypx0vFRrLxh
 l/F4lXk5v/xODX30o+MP51fJYw1uNAPy5A2G1DpbJkLVj7mAFMU2i1ApTOjzRF3npq/MWINF9Fb
 o/MQyc7a1QAtJIZFg3ccAcQQI9GOqPst4woXy+00ENPtS72cM8KnZNkBB0q3ZVdJpnT9XzlNMfN
 C/5R5mbz7hh3bLP8Pq9vK6T0WbkI7bSKM3bFutKZbO+F5HWOJgR34VsUsw9v3Lif50HCethPnZm
 bbdSLVbVPIFS8FlehTXXHlhRHeD2sFV9sy0fkxWVRFXjreskiR2Jlx7dD5ulYumKKP6d3/kqItK
 vaxfX477B9jLobciaysgRk99z/3Sem1dbPgdgQ47KamUhiFgfffmZ5rXXYGtLH5CJMpwRY8jfz/
 a7sIba1Yb4orwXIZnKFeRfRRQbdAsaevWj2TiP9CCzixBcGlr/mlPNt87Ed7PLtyQgJT8Sb+DLj
 BgHUrKCzqp8sn64BDcWPH3IBkXijMniuIdKXR6tZ3/bOoZ8NjqRUeiukaL3ZeUxCyb/KWDBKYcp
 gNAtHD/NE
X-Received: by 2002:a05:600c:a4e:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4ac183d1edamr411790715e9.26.1793876337039; 
 Thu, 05 Nov 2026 02:58:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4320efc7csm55377195e9.2.2026.11.05.02.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:58:56 -0800 (PST)
Message-ID: <bc83d215-e59f-4646-81ac-9016a1c60f8d@linaro.org>
Date: Thu, 5 Nov 2026 11:58:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] pci: pcie_dw_qcom: fix clock/power-domain bring-up
 ordering
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 senthilkumar.l@oss.qualcomm.com, marek.vasut+renesas@mailbox.org,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261104162626.1244225-1-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104162626.1244225-1-sumit.dhami@oss.qualcomm.com>
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

On 11/4/26 17:26, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> Two probe-ordering issues in qcom_pcie_parse_dt():
> 
> 	- clk_get_bulk() aborts and releases everything already
> 	  fetched as soon as one clock (e.g. a not-yet-registered
> 	  PHY pipe clock) fails to resolve, even clocks needed earlier
> 	  such as ones gating PARF access.
> 
> 	- The power domain may not be enabled yet via driver model
> 	  auto-enable, and PARF access while it is off aborts.
> 
> Instead, fetch each clock individually, tolerating -ENODEV/-ENOENT
> for clocks enabled later by their own provider, and explicitly turn
> the power domain on before any PARF access.

Sorry I don't understand the problem, which clock is missing ? why do you
need to ignore -ENODEV/-ENOENT ? how will you get those clocks
after the pcie controller probe ?

Split out the Power Domain change, and explain better why it should
be enabled so early.

Thanks,
Neil

> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_qcom.c | 43 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index ce6b4d97d1d..863bc601f49 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -13,6 +13,7 @@
>   #include <asm/io.h>
>   #include <asm-generic/gpio.h>
>   #include <dm/device_compat.h>
> +#include <dm/devres.h>
>   #include <linux/iopoll.h>
>   #include <linux/delay.h>
>   #include <linux/log2.h>
> @@ -415,6 +416,7 @@ static const char *qcom_pcie_vregs[NUM_SUPPLIES] = {
>   static int qcom_pcie_parse_dt(struct udevice *dev)
>   {
>   	struct qcom_pcie *priv = dev_get_priv(dev);
> +	struct power_domain pd;
>   	int vreg, ret;
>   
>   	priv->dw.dbi_base = dev_read_addr_name_ptr(dev, "dbi");
> @@ -448,10 +450,43 @@ static int qcom_pcie_parse_dt(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	ret = clk_get_bulk(dev, &priv->clks);
> -	if (ret) {
> -		dev_err(dev, "failed to get clocks (%d)\n", ret);
> -		return ret;
> +	/*
> +	 * clk_get_bulk() aborts on the first unresolved clock (e.g.
> +	 * a not-yet-registered PHY pipe clock), dropping clocks
> +	 * fetched earlier too. Instead, fetch one clock at a time,
> +	 * skipping ones not yet available (-ENODEV/-ENOENT), which
> +	 * are expected to be enabled by their own provider later.
> +	 */
> +	int count = dev_count_phandle_with_args(dev, "clocks",
> +						"#clock-cells", 0);
> +	int idx;
> +
> +	priv->clks.count = 0;
> +	if (count > 0) {
> +		priv->clks.clks = devm_kcalloc(dev, count,
> +					       sizeof(struct clk),
> +					       GFP_KERNEL);
> +		if (!priv->clks.clks)
> +			return -ENOMEM;
> +
> +		for (idx = 0; idx < count; idx++) {
> +			ret = clk_get_by_index(dev, idx,
> +					       &priv->clks.clks[priv->clks.count]);
> +			if (!ret) {
> +				priv->clks.count++;
> +			} else if (ret != -ENODEV && ret != -ENOENT) {
> +				dev_err(dev, "failed to get clock %d (%d)\n",
> +					idx, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	/* Ensure the power domain is on before any PARF register access */
> +	if (!power_domain_get_by_index(dev, &pd, 0)) {
> +		ret = power_domain_on(&pd);
> +		if (ret && ret != -ENOSYS)
> +			dev_warn(dev, "failed to enable power domain (%d)\n", ret);
>   	}
>   
>   	ret = generic_phy_get_by_index(dev, 0, &priv->phy);
> 
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32

