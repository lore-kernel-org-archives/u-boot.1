Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB452606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mec3X9BH;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xOTc71t7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93EE0405EE;
	Mon, 23 Nov 2026 17:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vg8LwTXjcaAb; Mon, 23 Nov 2026 17:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC8DD4059E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795454149;
	b=MSc2usdxJWkMCY2DXyh1H5kxFYSF4rGZF0xENT0iO/ERCW2YB5tG3PGBQpXBbV0Tgzhx
	 WciMcEPGjdCBOEg/q98NP9Z4wO7N3fFR9JzJxYWodUafRShAh0CmKBJO5tWpQKb0Ayo35
	 oRcweEbmoOsYvgA0JfceXG3DYgPX1M1SHyI+IS6IYiDqg7n/EtlLs/2FccOUI6EEOg9Vm
	 7CP8JZq2dGx8RCm5SZJvbbzt512Fq0IpHaA6P8JlxgYsSKjyilgR2tPgOge7Mj4MTJF0/
	 eQx+iYOmiL57NSDIii9vyVKBL9NdW0x1Gm49JRY5oheUZiCIGN393GeXf5hA3Y05mWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795454149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=WwqubJtEEFZPAt1QdX43LzpF7sdhe6JsrebZvtJ9YNI=;
	b=CQw8VBrEy7Gd/f/lkh8J4AV+uAG3014xcK26XYuLUDX0G5CuE7PotGefeGx/7UqQp43g
	 Y+Aw91EAlmcUtM2gZl0J/cS0+be/auDavGW6UnIkHpFt8uVXFPB1aJNy5MkxFD6uAzhll
	 aeHbX2HNdk3q6EB9mX4t0HO1uwZl1QjjvCvlzMu8R+EIxIN/xgH3dJnW7x9P2lmGNQl+1
	 qt5zjFxKRfSUPuTZYN5Ll9WAVVhj8POiIraVWZLsXZUsZWY6kCt0Iftox1gQgEITT3xR2
	 R+L2geLlezRu/yeJ6XTe4G5V5We01BiD6gUc+1eTcpE3XWscJUkEpgi0+vvIKW8Ukgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795454148;
	bh=WwqubJtEEFZPAt1QdX43LzpF7sdhe6JsrebZvtJ9YNI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Mec3X9BH0mNPCVO1x+tIgolWtHYgbEfCW+zdJCqzY9wOhBv9gm2Nfz6RPYlYsbnkj
	 b1wRmBI8W4ltz5KzaobuROjrcgTR5MCPME4lOxF+zzWDaLk/5RVXIdT5sKDB5y4i9S
	 RL+5Tfe9p52lGCmq4wepECvTwWT36+feOinks4g3EUY/eBlzyninTe8RM70Wr/TH5V
	 fI2kunLLN02KPm4nhyv1oxOlIk4/q7b4QocEPby8EX0SEoipMzdvfDSblOEaH4vfM6
	 51FH+KA+NAVQwGTroud0bOv6wVlSct/u/QgFPdxFnRYGSxP0oJNqSh/aTMeTyBjMF0
	 jG4TPO/upC27w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC8DD4059E;
	Mon, 23 Nov 2026 17:15:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B4FA759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2200240093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJPia3expmWP for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 02F74400E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xOTc71t7
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02F74400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:15:45 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso35065785e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795454144; x=1796058944;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WwqubJtEEFZPAt1QdX43LzpF7sdhe6JsrebZvtJ9YNI=;
 b=xOTc71t7THeVgwBNDgoQD0OD3i/3JqFLXS7ZbJ9hLpM3Du4kQ2mWkrH0c6+49IoVSJ
 +s0JL69tqX39tgC7ji8rZ8rP6OmqsqaIHdnArrk6qZxhqbgkfbtjxRJa1ZltEQmiOnu2
 k7iUoCoT0Nq/bjkw3QkhdVblCtZytppgL811GF7iMq/T6iVFcrR/lAwY9FpVJ44SGcrI
 Ah6o1y8ij+d1oZBKfntMi6WJEKxj6QdAkWj3gQerZSxlSsbpldRtE8wDwRQXyOObOaet
 IHaFZJXLjsFfvYf72H6C5MkQG5W4qR1eDoewgMg95XL9KYcieG0j3gTpB2Dv8+QsEitK
 bBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795454144; x=1796058944;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WwqubJtEEFZPAt1QdX43LzpF7sdhe6JsrebZvtJ9YNI=;
 b=0KnxObngWJWOjqXD99Qe6msE3zIyl91ScdurhSVazqdmRhk+oy+MTEtg+LwVTD9B+6
 ciGS7kkBTnJebEvTKqBv1zZQhX9BsAQ4dW/Cmxh4370tadQ0IbMcB1qP/cLdJ3fRij1D
 uCw62xa8SXenWM/TckRDxuzSqv4MNzYP+gYD01CnyHkisHrfr1MXdWuPNQBakxWJ6DdH
 LjeqBFWcNYj1jkvF09987YAKRvRoMfxP5DoO+qh5PI6FcawVLjpaiNSOWvHM/QV49gYl
 9ojtGx2OOGQcLCkGfogWMMhlHDAF36TQ6bCUBCP54/Carl2PEDLBlMCJiJBV+lU9n+Z0
 O2Lg==
X-Forwarded-Encrypted: i=1;
 AL+hErF8wyj49YwcGN69GcFqiQ7SakJn/iqjSiR0c4GNCbR+0uyAo0t3AoYBYbS4j46NGWGWSTHoCYA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8qc+TFCARz+KhufefT4H8LdpS7Z8Tqwzj+d9ORdB93h3KZZZ+A
 bAxWGduiplmjei/cDvl183ror/47mST5eZaACeRZ8LZDvm0OqUdxFmO0azH7xOcDXVI=
X-Gm-Gg: AZFdTZcDpbD1bxCILCCRnDTeM47rMdM7yKJK1UmUEh2DJIKDPvVAk5rZiKnnQ3G7P/U
 +AB6HUwdfwD4wmOci+CpHvcp6+Bg0pkPMjogvhXl9kqi67M6rs8fQ+UYDb1TtTNBwexLZfKiwjk
 PFFQy7Ut2HHWKFwzV6+ynBDmcb6+hJNoilKW2CLK5cx4j8rmV9vg/LHL88gLYSxrIs1X0fxepDt
 ABW2+iBTbiCmGG4/B2u+aXd0++qxjJidqcYNFhH890hLICyDpj8GlV3T9oNCTY85WUCce44SPbO
 xfSwu9Y9gpI3kDSxJUiWzFBeNL/aMlLIsb9oMzZMwIDXfJ37/hLACOUDJo3hNs6j/fPjhBIMpln
 YCE7b7uDiZ3IctArhMjI2VOhAyrq4YaQx/FsN5FNXTpbgWIt0oU49U+WyJODLGKIZtiX3OdJkvY
 AwDHbGveUkjqPtAbywPvw3zj/0f51Jkf3zox2GsTRVMpOQD5nv418/rleKEVfXj/ROyQ0bGU0TY
 sF8Tbg54r4iUc2lUZo0vmdhJFcOyYNPi8JNMPQ9eGvBcxomAZ8utkwErUFZv68oL20w7LG5yFKA
 KOrSpogAXEXTyLtVYKbpPQgp2J4W5ECilfZL6dJC2CkUJ/R2LjJ6NeyepLY1Su4TKLE7rFS+utW
 87GzciNRU
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb88786c81mr248632285e9.0.1795454143317; 
 Mon, 23 Nov 2026 09:15:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:f4dc:7806:c7b4:be9c?
 ([2a01:e0a:106d:1080:f4dc:7806:c7b4:be9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c43563esm24504565f8f.57.2026.11.23.09.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:15:42 -0800 (PST)
Message-ID: <0ac388f4-07d6-4dbc-b2ae-adf9179912a5@linaro.org>
Date: Mon, 23 Nov 2026 18:15:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/7] ufs: rpmb: validate requests before issuing
 commands
To: Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
 <20261116-genio720-ufs-rpmb-minimal-v2-1-b64eefcfb0f6@baylibre.com>
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
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-1-b64eefcfb0f6@baylibre.com>
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

On 11/16/26 21:45, Carlo Caione wrote:
> Check frame counts and response space before issuing any commands. A
> malformed request must not program a key or write data and then fail on
> response validation. Use Linux's request shapes so surplus frames cannot
> be sent or silently discarded.
> 
> Fixes: b3cd7ddbbdd5 ("ufs: add RPMB transport over SCSI SECURITY PROTOCOL")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/ufs/ufs-rpmb.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index d9d35a06439..508eb74d976 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -157,16 +157,25 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
>   	int ret;
>   
>   	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
> -	    rsplen % RPMB_FRAME_SIZE || !n_req)
> +	    rsplen % RPMB_FRAME_SIZE || !n_req || !n_rsp)
>   		return -EINVAL;
>   
>   	request = get_unaligned_be16((u8 *)req + RPMB_FRAME_REQ_OFFSET);
>   
> +	/*
> +	 * Enforce Linux's frame counts before any I/O: a key-programming
> +	 * request and a write counter read are a single frame answered by a
> +	 * single frame, a data write may span several frames but returns one
> +	 * result, and a data read is one request returning several frames.
> +	 */
>   	switch (request) {
>   	case RPMB_REQ_KEY:
>   	case RPMB_REQ_WRITE_DATA: {
>   		u8 status_frame[RPMB_FRAME_SIZE];
>   
> +		if (n_rsp != 1 || (request == RPMB_REQ_KEY && n_req != 1))
> +			return -EINVAL;
> +
>   		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
>   		if (ret)
>   			return ret;
> @@ -178,20 +187,17 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
>   		if (ret)
>   			return ret;
>   
> -		if (n_rsp < 1)
> -			return -EINVAL;
> -
>   		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
>   	}
>   	case RPMB_REQ_WCOUNTER:
>   	case RPMB_REQ_READ_DATA:
> +		if (n_req != 1 || (request == RPMB_REQ_WCOUNTER && n_rsp != 1))
> +			return -EINVAL;
> +
>   		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
>   		if (ret)
>   			return ret;
>   
> -		if (n_rsp < 1)
> -			return -EINVAL;
> -
>   		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
>   	default:
>   		debug("ufs-rpmb: unsupported request 0x%x\n", request);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
