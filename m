Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bsap/6Vw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F5YSqUFv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0715E80DA8;
	Mon, 16 Nov 2026 21:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Jxvm5gxDc9z; Mon, 16 Nov 2026 21:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EF6880E95
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864050;
	b=pMnoh8eW8YBuonKJU2ykKW4w4IIvMCzjI4mqsciZ5ou8FV7VEBmxpwgwe1i/sixlpgZp
	 1mv3jDc+FUvS4FD+F93plM8PzcpaV4w2uiS6MxE1o4/u71IOCOXxwvZVA1113OHO6dv86
	 LM8jdg29H84LBGCAIEGIDWPyHUweN4FiaJhWVXhj/sQxjUIQ779U5YklJ/KsiGocR7pEC
	 Y5lVkAgtiiGl0E8DVuErNcvDNq+pFTomeYJkl8uOj4Scr4xbLvKFovOJVxct3EB7XTt4R
	 6jmlsfdccsQ94hCR9TPRffN2yWPk/oxNjE6Iced45n9o37S02Fxi5/D6O+Bu2TPeNOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864050;
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
	bh=LXiTQqx4nDzPzpT3B7O7uP7mdN/5WiKaO3BKA0ylT8c=;
	b=eF8MFyD3Cu1H7JGqzuscvdhVeW3yRjJKh9zOYjNKuFMtZ9JVSWuhOwo8ySFSOVjdKXQX
	 ImFDtOlnVTNtlRibPIV9yKqIeH0N1akgmhrrI2JOiQ6+uOHX+ykkxcs+z2iF/9fWqILlw
	 GD+TMvmjYRIsZVCzFr2dWKGe510gHuvhZW2MaF7SFTP57IMVp8I6clnm/6LqqWVen+wvL
	 l/f1+qnN3TluRg6UZQPH9yAcq+Mp/+bBz/E074p7sO7eJJr9HyY6c2sz3ezJa61at6zBd
	 hOjEflGK5JPm1Ubbq6PlCV4BMjHrdtqpbK+DZPJdomt8ZafEEkrVn0duTH9wnWJ0Z0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864050;
	bh=LXiTQqx4nDzPzpT3B7O7uP7mdN/5WiKaO3BKA0ylT8c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bsap/6VwnnC7f57FBgIr7vzWaIbxj/chmLsIGf+sw99+0e1XyqRge/BZ0+Ma6FaRO
	 aUDo48yt0bKjqak6ucaBcUsnUqWv03KGYvgFn7iXSKu1AKpvJKSInhBYZ6j+nSBSps
	 nlG4cx9dp8fiMfYGCwTEw/hX4Avu29Sv/dOiL18ggYfr+Ct3kMnKxBL+MfWVdiDC6H
	 Qr/ffsRs0oAeKwkxvOKesndnSEjY2G/O+wsMkxVCMEQZFwMaWN0LhlyZH6RuMAh1Tj
	 6hd0KWkjI1v+zk3nuvhC6gmeseocXlMOBzHHOyLKagVlwFSlvYOfa1JnZutjNPRPd+
	 +X9J0IkSyWipA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EF6880E95;
	Mon, 16 Nov 2026 21:20:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CDC5109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 462E8402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpDmb9HkmBaE for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 18CEE402CA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=F5YSqUFv
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18CEE402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:20:47 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a358881793so192485f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794864046; x=1795468846;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LXiTQqx4nDzPzpT3B7O7uP7mdN/5WiKaO3BKA0ylT8c=;
 b=F5YSqUFvOzqDsAugWAWOTNXEqCniqbVn9+6zlY5nAqdVgcLkOkblq89i+BWNtG+C4i
 3ybvoalNZchkmj4+37casDJZo0F4GZ/94/HUsIL3EEjKNlZgLN0+fgBTC6NHLbfoAEv7
 7gaHBGDSi/ID+H5Ixws5ePehc7CoSOtAqjSrQLCCHlrlOD3bV0xLfQJJw1qfo+uNjTqH
 3RiBW5MUTl3957q5TqqGMyPeT6qKo+Ki0V0bpYxVPVOsndA+BJMzgVMqevAVMfUcwKS4
 IlUToOw0XR5426iHBBut8t2PHi8gHq/FjXexFiuQh16+EKcjC8JkA0onh3GgdN1IZn2O
 w9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864046; x=1795468846;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LXiTQqx4nDzPzpT3B7O7uP7mdN/5WiKaO3BKA0ylT8c=;
 b=CCl5126GbcgswRLu4b80Ag37/uTTxjV086u4chn0nUy3WXUnwWYxTG1lgpMmPakUGG
 1j/Za2TfCRuEO4/Lp++0q6FsGujGrKTGpwFbe0ABWDussKs3f9J5zSVCHoHBgs8MUZGh
 agumlPALlwUYey1ve4aL25hSCO638cVpWOeHUNdPd4BAGTZGIiUhPx6CuVj+pkTZLYzL
 CuTS1ROjnuZrxFCj3LRYxjD1B3sIwCCaFdj5J+dlRDQvhUNpMYCoC/W6L8WZk/HYns+O
 Xn4vqNaCV0Cy6D+fwgd2AGMbN3ziSzVQ5BoOl5OAP16+duSjNCHgR/1BcwzIX3veCv6D
 EazQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGtgNYBOX6c7405mPlWqt8dJt3vkFb8EvgB8nXVcqtmyNQtVSfes/JYG5wZ7owTEAkXVd/w22M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90syfyFDxmb+9D0dZPxC3+WzHKvZOAVNH/8RgIE/Q7iR4hIYMW
 QX4VcazYKZCVc/dX7YbE7FlZ5XIbGhO7yUUZg18/pbaAJjOoFNlze3XX3h4FsyyQmQQ=
X-Gm-Gg: AYBFou29xJzW2wpTalXhfz4IPzbPLedqZzfIjGRYRI/8nPRXQIATzdXKk0xUgAcC/ro
 717IyzyE5v+I/sNUNUmItFYH3t9GACpi2X1wiVovlU+E2iCXxrtR2F8DttRI5HECsOlBGbYGf6u
 6Z5B+rSSMW0sC9p1emFEeAwPXtVAT70oto6p/nMBn0ZJ5ms/XZJtjG6mRZUA39+pAGVQfLHPTqB
 5ZNE4ZXmpgmJJuvKO7po7oEo9DrmroC7pRj49ryFqlalEsOpzDP8pUgLrjLKoUJcxsckTPJ6VGi
 PY+vUbdPJgb1eyW8P+zFJwjJL198w3lQib3eo4FIRhns90Z/lsebfPBgL1rw4CLgLaysCJPBpcs
 Jv58yBxe7yEXq+v7pc41aCrfsclPX3h08klZBcRPdL+Xsc7YWJev1Ncfv/GEZngw3/cnmXlap5y
 27sz4ErdBN0LQc6rXTBJOEcHF2wbiZCN4lkVuenpyDWaI18nkfheual/5TsQUPKNjGslFLgiCEP
 rN5cIDhPCuusozg7yXh/8mBqbHqgBUults2QlELikVeA94BITK18/7i4ay0FZtNUWTrkJrzzHE3
 /584yeg/EKIIEOdSG6TSolxsSmszPKQEr4gBk7Uv7+fBg7hGYrBCYE9R+DHhnqPpaFk9/qoJIRJ
 E1OxKFtS7PhZcXldUm6z+REFmwRT7Fpk=
X-Received: by 2002:a05:600c:1c0e:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb68e5bb4amr173740955e9.16.1794864045359; 
 Mon, 16 Nov 2026 13:20:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:7319:1134:8f94:f341?
 ([2a01:e0a:106d:1080:7319:1134:8f94:f341])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm168686015e9.3.2026.11.16.13.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:45 -0800 (PST)
Message-ID: <7806233d-8181-40b1-a647-c7a3e2893b46@linaro.org>
Date: Mon, 16 Nov 2026 22:20:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] interconnect: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261116173713.3487997-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20261116173713.3487997-1-marek.vasut+renesas@mailbox.org>
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

On 11/16/26 18:37, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/interconnect/sandbox-interconnect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/sandbox-interconnect.c b/drivers/interconnect/sandbox-interconnect.c
> index 0fc0e3e0d49..512f902bf00 100644
> --- a/drivers/interconnect/sandbox-interconnect.c
> +++ b/drivers/interconnect/sandbox-interconnect.c
> @@ -285,7 +285,7 @@ static const struct udevice_id sandbox_interconnect_ids[] = {
>   	{ }
>   };
>   
> -static struct interconnect_ops sandbox_interconnect_ops = {
> +static const struct interconnect_ops sandbox_interconnect_ops = {
>   	.of_xlate = sandbox_interconnect_xlate,
>   	.set = sandbox_interconnect_set,
>   	.pre_aggregate = sandbox_interconnect_pre_aggregate,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
