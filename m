Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25508C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB35481285;
	Fri, 18 Sep 2026 12:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNRyY_lsl7RD; Fri, 18 Sep 2026 12:16:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0B18C81288
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733809;
	b=YeeUmw/dTcCYCEWr1HKp7LWQVLxaEZpN1E3UzNeYAF/arM8I9pLN8a8pn5lDLg9ttZVY
	 Es+NDOcBmraaEsOqdNn0L+wdCq+g59blitDZM03BnQkuIyKNvAROmg0S6+0RxaTn/IdvL
	 F9rHfQc+cLA2v9jF7YtEvJZGasBrRcMuyOVwI3ZyIW8dkgkNa9/0HTbznzk5I4E/ynQTk
	 PQ4xfu8TI4czyddFKjWXNki+2bfr2OMSNZNEGbVhogcM7IYBhJWNR5OztW9Vjw0p5H9oJ
	 XaJK/k1iAKVFZNDLsLYg7bCGNuutbniJRdRR+DW91H7DX5FYcK2zrxQeoqHTnFVbU2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733809;
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
	bh=ymiNPygrm3VtPta8Nren1h3UwBzYseMj+hQ+lp6t9LA=;
	b=kTBGQ76peVqdNPRiPJJA+dfD5WBDEQ7zqgREnW9e+4VcjFAGkykNGixBINgp5zWfS+oS
	 fzM+X1P1NeDkP22/uOfxyCSadYoVvzrEoMtYMRJ6L8RMz1zMn9OzAgWOij4T5fnZ/9QN3
	 TMex5B3CTACA0sxnM62kNAoV/exnT66c60TXHgDd/e20ksKKLOmQz3v5TUoFabBCGyv1t
	 b5m2nQFJseT0MFAtWJ2jpOJ/tlvWXb+roq0cHJERYWojGvi1uASp1CSCmHDOvd9/0ltTu
	 +IEhZ/lfhPS2bRP6FD8OwcJE7r2TJoSldK3OffC3UJ1r9erLgXvke0KqzKaiediLVIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733809;
	bh=ymiNPygrm3VtPta8Nren1h3UwBzYseMj+hQ+lp6t9LA=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=FHdj1FpAkSQJdINAjM/XDFJRmoosCz79WblU4nwFFMk7afLtUtl487za+Kj1Vefkc
	 XeOha59r7ZmwZJZaY9ulpHUmr9LcXLJdI3WicMRG6GH7/ZjVZYpwkz9FTLs/5U5/tO
	 3qTS4lwUq0+D1ntvNev9kxgtCK1NpuiKN6vY3PbQnRS3+0cVxZmuctSgqeVM4ME0jx
	 FpJPGRjZCTf1FfPKNiq1WHSZe9NiOW2wHNbRaGGHIGf9I4hMhowKsDrM549cvSiAZF
	 hgu/D2PzVyNYTq6mEzz8ZWzXVYkB9uaup07ad62kgCR9b3fX/1m87sIC6UsVE4WeJc
	 0K2bi96u6PTrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B18C81288;
	Fri, 18 Sep 2026 12:16:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64E9C13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 561D040049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-GKid7DTOA2 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 320A340048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733806;
 b=dtxPDIvP9qa1e40poRia3JI6Is4zGjNv3WPmSEcLxSF5O4HVRNiNkD16K0q6XL7ESRps
 eaWsnmMC21bCjMY2ceHUXDnXTEyBDJy03fszIxdtbp8qnzZRIs90R3Un4Ui57zNX+/M+8
 rjFGO96++XkKV86dR5Fzavbbvc5kuYOFkYGaQw1kAj7uh9v8TVOb2vk4RhjZ1wf8eE1ZT
 dxRiF7yXlx0nA/Py/2s1TnNR6t6RLu8mOKwr3acaO+S4dN+BGEWj6lGgYCMbfegvyOiK3
 L/FcA0LxZvuuN3BiMgNZwebdKedvQOvr1jwQ4JuXTzz4xSk49cVy9DGpBHd+4DMvhdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733806;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=ymiNPygrm3VtPta8Nren1h3UwBzYseMj+hQ+lp6t9LA=;
 b=HaPR4l+MkwZtG0XS+92dU8hM2dNqkm7raW/PfL+1XBC4luHjh3Uf17uQR7cySZ24qKre
 mUHDEjOqmsgoyl/UcCIvkhbzcQOLSiSeaeW9AhUY4ISyowjDotLEKr1/LLG7Ls74Fxjkm
 zeT2OUmd8Zu/Nqh3xNbEKVpzr+Ncek8xDZ4lCuMgl9NPgXG4qgOeBnBF48ysLHGCZ4LLV
 kNfGrdjirXP1noKHzROqlGDbw9Mh8PpjCHnjCRbGx/4PgytI15JIzcs5KyVmaeoo9kIqL
 6TBLJCP85rLMJO5YaJyZ2IIa90tgG8nJRqvEZ0YcnOwYE5H9+RQiVKZAlivquCRNQjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kQRaWpr1; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kQRaWpr1
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 320A340048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:16:45 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so3830975e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789733804; x=1790338604;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ymiNPygrm3VtPta8Nren1h3UwBzYseMj+hQ+lp6t9LA=;
 b=kQRaWpr12WJACgAPof+iKS9ZLLJALhqrsinGfvDw1/QT/QAU78nhcIu1NtBna58e1E
 RMkLausmZlpH6NmRiBFiInKAfvWfGuNnOo4vJCOh/bjJXBQGm7TFvKO/YcNrfaKTcZ80
 ELqnx+PG4/7KNd6S0ihrxxFj0YyvQv76UUU9tb6B0m2Eb9KebQ+ybTArlIiWxxh1tyRD
 LJH7urFrYSssSfBNi4Fqy2BKcVFrAjaks+cWpRpSjucSo2WSomID5XPMTZNUzxFxNxgu
 Jmj1tMda13xpzj0ggw//1T3g3uifJtvKTB4UovIi9AuIEfwfXX4+I7LV3da/i7KbP8jd
 ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733804; x=1790338604;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ymiNPygrm3VtPta8Nren1h3UwBzYseMj+hQ+lp6t9LA=;
 b=aBspM0JbIPb8KTAUbc8zzINEiZUlLScZExc0WSFxLF1DJFeg8bznOMuZJoUj4fjhwH
 ObHgMCpytoFld80dGIsjmzuDrgf37LlGBZvKssy48MYZ/LXNRV4a+UJGAlE5ArJOpibE
 79p17jM1Dr2//PTL2ugIWSVpsp70qaO6jd8ylgz+RNM53CfVBbKlAjYBgOHmFdfwVp1X
 sB5DOI8MDpIEI2VBjQTpU5KU+wYdgpmsTMhBSinf+Wcp59jvM5PrPF2FeiUspWrC7S5X
 Ft8mGKyBdXYlEVwLvsC3rovXszuUx0h8JtPy+DKnY7AZslMFAMIkWalEluROPB4tDSYj
 Cb/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEAj3i4I80ikwj3GypwP/CS55/2KEgN5CcjuRnkhmn4HswZVIAmLH9KzAQ6gf2f6RLVQ3dwa0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mbChOUzTRuwNut8dsT9IR/u67T6rxr6/MZPq1ospXN1wFnjjGV
 rhIM3i6czD8Ntvb+YWyMrRRm+yxEEhmZA6EZ/zrp0nh/IvJb4DnULTqe8B8MMXC04zA=
X-Gm-Gg: AYBFou0Dq2XXmf/JV3r0qKhevIzfWrAo0/GRFxtqEaVcOQpOQeapJRgWcrBBVwwxDGp
 Nim6xyQxZYGnE9ngz0z5SE3Y7U2SFigpTlYaBQV6Gs75ZD0+OPNMtPSfy5y9WGTXI5hOq7GuR84
 d9edlDwvdB3znbnPE6A/ntg1mtWYOTfLtXbFRon9xb8GzmoqceNCGf/tMasGynPg5RnDNvIKhzb
 XbsDxb+2tfA00RYBQ9HjMFmT0inoViJ+0e9wa3Y50T3qIwdE0WA4wKKqVvOWrTLHKu++5L5W9CQ
 oky2TYaPIRJqDjmD/itI7rmdkfbnx9btNcYefYdgbgs+Y6YJl1hVCx+Q+SSiWc2dbBGFuc8F0hO
 /FduG/QmbzjpXQVKTADeBL8PFgCX1etE6LF/FG0DQhl07sEmLT+F40uVqjSIO4m4g9l73bqbJ5b
 /dzI45Ov6nNPsmonVAgE0inARPvMT/zdGIQZONw/Dd6tFc3NWAb+PR8enI+WGeJ/xMFkIpm4G6T
 mqnwRk1O8dYylw46qWScV3YJq9YEsULW8ebNcHRBgaXVYxulcZuUQ==
X-Received: by 2002:a05:600c:5020:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49fc56716f2mr64982715e9.5.1789733803978; 
 Fri, 18 Sep 2026 05:16:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc?
 ([2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58a1176sm38218525e9.2.2026.09.18.05.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 05:16:43 -0700 (PDT)
Message-ID: <23e7a956-3e5a-4234-bc9d-299371cab798@linaro.org>
Date: Fri, 18 Sep 2026 14:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] misc: qcom_geni: gate late firmware loading behind
 Kconfig option
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 anshuld@ti.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260918094950.1186434-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20260918094950.1186434-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

On 9/18/26 11:49, Aswin Murugan wrote:
> GENI QUP firmware loading is normally expected to be completed by a
> previous boot stage and is not required in production U-Boot builds.
> Add CONFIG_QCOM_GENI_FW_LOAD to make the late firmware loading path
> optional and disable it by default.
> 
> The option can be enabled for engineering and bring-up builds where
> loading GENI firmware from U-Boot is required.

This feature is enabled by default on Linux, why would it be disabled
by default on U-Boot ?

Neil

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig   | 1 +
>   drivers/misc/Kconfig     | 9 +++++++++
>   drivers/misc/qcom_geni.c | 2 ++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c52f619850d..9498583b97c 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -99,6 +99,7 @@ CONFIG_QCOM_HYP_SMMU=y
>   CONFIG_MISC=y
>   CONFIG_NVMEM=y
>   CONFIG_QCOM_GENI=y
> +# CONFIG_QCOM_GENI_FW_LOAD is not set
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 44415f24ae1..8320fbe28e0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -93,6 +93,15 @@ config QCOM_GENI
>   	  for providing a common interface for various peripherals like UART, I2C, SPI,
>   	  etc.
>   
> +config QCOM_GENI_FW_LOAD
> +	bool "Load Qualcomm GENI peripheral firmware at late init"
> +	depends on QCOM_GENI
> +	default y
> +	help
> +	  Load firmware for GENI peripherals from the firmware partition
> +	  at late init. Disable if no GENI peripheral needs firmware
> +	  loading.
> +
>   config ROCKCHIP_EFUSE
>   	bool "Rockchip e-fuse support"
>   	depends on MISC
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..b5c2a511ae7 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -563,7 +563,9 @@ static int qcom_geni_fw_initialise(void)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_QCOM_GENI_FW_LOAD)
>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
> +#endif
>   
>   static const struct udevice_id geni_ids[] = {
>   	{ .compatible = "qcom,geni-se-qup" },

