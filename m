Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DC606D802
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DTt+6W10;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dZPQYhXF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E96D605D2;
	Thu,  5 Nov 2026 10:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmWFughiiOLp; Thu,  5 Nov 2026 10:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0AA76080C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793876246;
	b=EMRnPRpra6mK+N5ljPLtU4tWHa03FbCUhLkkaBUnEz+8kEh7grmGxYEWw8BRIUr1NzCb
	 IhSEfxV70m8PSURs4YYjuWKoQv7gfKIMihq64dfECIr0EqLm4RKp/Hs0e24+VJWmzJEjr
	 XUJnvM8Fa+hzhbWnozg/Qgy1cxdCHXe7gkATpMMIRcvX8YDdBOVXBiJEtFmMwlBnATk1y
	 qHz6eqo6yOcokZGiJkBILQ5jaw0sCnsHXU57m9asKZQYNb6iPVtT7g93qXJzRgJ+BzFAX
	 Ru8gXs+hzVQAQkgqbhEAhN2O/wk4GxndkCzVwJjobYIhfc2Gkf8+5ErcultK8MWHXIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876246;
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
	bh=JNpPGFb3+T1KVoeSAxhIuPeeoEbYpzeZGdxO2hbdM0M=;
	b=gb8GTQh94Z8bvonE6sWfoaS6rqehGZe7Riq5HIXy6FSiHWrLKmw+CSlQZTqo889tTJsM
	 XhgEjGq9yqGUV5lVPp4wIf4NtUyyC0z9029a0hNt3vcGuaPxc1jF1PiHSBXQ+iK8f9nC6
	 uBreZ8FwbiYh9GUolkljGWIpWITPGc9RG6bvctgY1rPomX8JrNEU+3s68rVN6vCmxmYpZ
	 DOodenGaixo0XjXGE1TVJ50LJfUoP/Dhy4el63xR2bB7yWzTkVRbqn95WeIMjkHw7ckoO
	 jTWWIONQE2l7e0UzZuQkDmpYMDWRQC0Ed1ubbQZYb3gSa/yqVGBb8PO6KyvgXDhmzDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793876246;
	bh=JNpPGFb3+T1KVoeSAxhIuPeeoEbYpzeZGdxO2hbdM0M=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DTt+6W101JC42mtZo/kN/nb7aS1YWC0Fw2O+q6iOywDIe5VJzzFz5YLd1egW4gNIx
	 OT7MPyUmjip7pa7AHXIVscQaBaI++NLrOu9LSBSXAB0Qdm14FDILqaPv/7o2YndDTq
	 aiFVdaL+aerhe1PFOk04ID+y+gO6wDDra30V2Ae/Ag+qx8Ym88CRQ1KAgFf64LO2oO
	 QO6ytHqTmOM58dboB4NYM+WPkrIwvS6TdmfJWzEYMkRoNZvRD6nc5FnKRs9Eby4hwM
	 iE1hPhgC7gdfWuTF7DiI/H69OJvQB22zZBhpq1kbiOpHEs3/prvm9RlpbddE/dGKbe
	 YynTv0mqH52EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0AA76080C;
	Thu,  5 Nov 2026 10:57:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2608952B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16CD180AED
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsGbVPoGA1hD for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE83980AEC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dZPQYhXF
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE83980AEC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:57:21 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so13335895e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793876239; x=1794481039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JNpPGFb3+T1KVoeSAxhIuPeeoEbYpzeZGdxO2hbdM0M=;
 b=dZPQYhXFlc5Pnt8BWfN6OakFTJzvDdDWnSvy+tPkzd9RQaSuHcP0gSZJUGkE2aUdi9
 qtwzN6Mc0265W+tBVV68jiQQE8TDKHsbz18apYvsqWvVafkFQ12O24G/xO/2poHKMzUf
 V91nMb0ukk26yUR/Ugg6Nc1AJ7Vi/QqHBrwxbYAFpeQUhez9rHoKgbovJN7Vy5HlnYUH
 WXGLK900p/WqcxeKChV6bGsYogXlS9musgIR/z3UqCTZDIm/xC/DEATZStA+pR59/aHu
 ho2OZghMfS4S2GSVjouvw/AZoD1TqGU0McyKuFKTfD4TFJjmvo/Ya+LxRuc6M6npqcO+
 rlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793876239; x=1794481039;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JNpPGFb3+T1KVoeSAxhIuPeeoEbYpzeZGdxO2hbdM0M=;
 b=zSUXlkN+2cREU0BgSt03CcikYJNG3wXhfhxPJcPBn4twj51GXgPAUvS8A740mBG8dk
 tlxblm9+fRyL6nmu5k6r+Pee806oG0hgHua2VMR4YwFbKerb2Ov+/fYCG/x+0OwckjiC
 +jEt44bUuxr2s2dC5vrqhz3ZrlToLwT8xeAasEBd7PJm7WqvlLUlWvUGLDXLkOnLLRTj
 7tnokkAwuPmEo4HTdyhUIKAowgmVpExFuhwxPHEoEEH8qR2MsBFo2FVmGuBKFDCIlaer
 aMFoVESL002B5aioGME8pVwYo1W2FXDobcmHQopXjACrHlzQ+RjYY58EhwZOECMRrTeY
 RRVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSnu8IsjoClTb7q218fjBPvzBtnW7Pi9b2fhAEYtjrMePYckgyt4PgIDiDcjuk2sFb9nJnRDI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+FIn1DNTqX+vDmAwW8LZtypSZAHNYh5SwL3Cy9muwSMwoAEDdm
 R9CQYgHX3B/yRYcMohpWeTLjdCKV9S/gxnJw+5iaa6Qn42WYB/GWH083GVi6yWV2MHM=
X-Gm-Gg: AYBFou1SU+Zfk3hieSmq4xofEGpTCsHB4NY90bAp0N+3rUPbIf6m3YCutVoCTPnp7CQ
 m287OUUx5vtRSJIuU+Fe3Lh3bStj7z/NSqqVPl1xZyYyOo/FrjtW2UReQgdznc9PiHfdRlnbnep
 3P2UBZ/sIKLcTMXL3jTAZBH/7yoRqO+UgHvLKXYMXYkZDK1rofeXAtuyDwpzj65EIS54YDwLKIa
 RmRKdSwonhFLtv9/aFapJ8TfWzapORefhWLEMCQvPLwEbtGzCYqEBp5ytmyNqohatTkxDy3O9SW
 ycT1QuT9XeNKBCBDw7Xoj0bw0HkzE+ikMvMflMUWD9vW6vYwoeCp5ZsA4NiJDiZnItkUfvLBDCr
 t0VY5i9udDgyTTbQCaXUN4yN/c9dbXiJ8oBAVeyUokuV3Ibu9plxhmFjkb74Az1shSXdhpInvM4
 KaqklMFhn7qdBrzgDN+8B7NA6qAVWW24PZTJ0krD1dvgNzaUB6hPedAhHgblmYevdDNZrj/Irom
 Mvjbuooh+a0+FjEmPw/X0k1ggyHlv5FqUfJ0InFmtdhmiUGPrVIRGTYi/NTVlHKy6Z3JOX2EH/n
 NVL7tDTT7UUcZXoilcXdm7OJvNwMbgFRft3r/G9p8Dq53DxanbYxBCcxNwtKHzfwzB/xST/yyIW
 JhLBl/tXy
X-Received: by 2002:a05:600c:a012:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4ac17b2bc4dmr410219015e9.6.1793876239474; 
 Thu, 05 Nov 2026 02:57:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20935sm8918755f8f.54.2026.11.05.02.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:57:19 -0800 (PST)
Message-ID: <7baed8bd-c328-42f7-a2be-0d05af46a025@linaro.org>
Date: Thu, 5 Nov 2026 11:57:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/9] clk: qcom: sc7280: add GCC_PCIE_1_PIPE_CLK_SRC
 no-op gate
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-5-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-5-sumit.dhami@oss.qualcomm.com>
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
> GCC_PCIE_1_PIPE_CLK_SRC (ID 56) has no gate entry, so
> clk_get_bulk()/clk_enable_bulk() fail with "unknown clock ID 56"
> for any consumer listing it in "clocks".
> 
> The mux it represents is actually configured by
> clk_phy_mux_enable() as a side effect of enabling
> GCC_PCIE_1_PIPE_CLK, so register it as a no-op gate.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index eddeecfd9b7..fb2a017674f 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -206,6 +206,11 @@ static const struct gate_clk sc7280_clks[] = {
>   	GATE_CLK_POLLED(GCC_PCIE_CLKREF_EN, 0x8c004, BIT(0), 0x8c004),
>   
>   	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
> +	/*
> +	 * No-op gate: actual mux config is done by clk_phy_mux_enable()
> +	 * when GCC_PCIE_1_PIPE_CLK is enabled.
> +	 */
> +	GATE_CLK(GCC_PCIE_1_PIPE_CLK_SRC, PCIE_1_PIPE_CLK_PHY_MUX, 0),
>   	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
>   	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
>   	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK, 0x52000, BIT(27)),

Instead add early check in sc7280_enable for GCC_PCIE_1_PIPE_CLK_SRC which just returns 0.

Neil
