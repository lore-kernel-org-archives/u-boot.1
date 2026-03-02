Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42727EA4E07
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD7983F3F;
	Mon,  2 Mar 2026 15:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="awzw3Ug+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502D783F2A; Mon,  2 Mar 2026 15:18:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA2C83F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso626998f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772461133; x=1773065933; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=seHkhcGJo4RwIMqIZLPaGsoZAhbraRzzRxMciKT4FLA=;
 b=awzw3Ug+e+hjiUrTMBFaUYixQrL/jKF1FOH8nNDzaGofXshh6rHksAGTrALKtY7V5C
 wKabV/pZS9am7CHw4dLppL3L1IdMrtvZlC3K3VnyjTf2gwvjB6YeV9MN6HiGmsWbk3Qe
 E7sGXrH+HzdvjeVChWkk4u3e/kwnnbsH4xMqjrMxy6D95lqd4eWR2J+Fo9V7qgl8IHg4
 nqL68vODXAS1CIyGK7RHAXt/t5CDv1VbH8QPqutxF+nr3WXjaFL15+zOli3YtPO4q6HS
 u8FAiHX72ONkPS38NSty0Tu07sH5fsubLtpjgqr/BnFrfZnvzAsjWxlX28UD0OrmUAzn
 BG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461133; x=1773065933;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seHkhcGJo4RwIMqIZLPaGsoZAhbraRzzRxMciKT4FLA=;
 b=BeKhbzW6wfTS/9FsNLFa7n3oI+EYJhKYDG9Sydb4S6BTS7hSK7sxhGVIij+xSknHWL
 F78Mv2tz7Srg897UYx76klG6Uc1X3sJHNjisC5tQvQEhoafHmG4Q67pu/BnAYbxI75mz
 FB2M6INw+McSxJ783ePz1XNhmYZKM0kvar5RJ1KFrt+KtC4D+5klouxSW6Pc8eHuHKbX
 1GR4X+56lbY76LgtCM2VhH9xsUTpFMw91xlbSW7X59Ig1kQhajO7uxY/ckk3o/s0IgPs
 BSjTJbkpJdhElbE2dvMYJadOSW5hp1NBCKRK36OfLsDIuS5dg0G3woXHb/1X6DW82gaW
 DUqg==
X-Gm-Message-State: AOJu0YwBOOSkFhZKAqKuPEVcR/OzEuMBy1MlwX00EcHdvpLKS9z2v9k5
 zW46/XmhiA5uayMclDhtxG6KZf0J0kVsT9OXz71W9f2N0kvPl43CDXd18+2qWIw2dNU=
X-Gm-Gg: ATEYQzyMtaegvp+3+inuHzVb6sZrT8eYzgOu/aJMdSADBjBbGB6ytpu57uMt6NTRJ+x
 scOaOJ3UcGCvVoKPjjPR24Zfs08zUqbx8TPqAjbFtl7IqtyU5yoY2sSxTQ40KZz4HsiSKhD1ugQ
 PtwMIAyxDwZBJSlCmp+DlPp4eEktHYy53VcQIPVvbM7vRzyRGsRMAV3xtpLdAdOPZ9QcMMX9sB2
 cYAzYBssGa9XFaiq6iyXqGGaM9iR28k4dU1dH76ScMWMl0iirc8YNnNGIIiNN5QVvYka0znAtl8
 F2zy4GfMLaI5WNw3UPxL8KkXSZdc++jqWccK8RYM7UOY3vGL8HhG4IuTBqvHhUwP2yBTYIDCOKm
 8Fhvqvk3g1knjpr8ozd9UgGsSw/H7II/nspSaJgMR/30XiiVgFkiAL3oZFPGWfuQpd6n11ZM4H6
 6E4rnFOMelSd9mqRdU29TK+ra+AymwDhuPPcoebXgWRBb/kXyJhu601q9Z27kzFqyFmz4YlDF3/
 Q81vZw=
X-Received: by 2002:a05:600c:a085:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-483c9bc5b7dmr208334905e9.25.1772461133159; 
 Mon, 02 Mar 2026 06:18:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:708a:e1be:4bc3:1ed9?
 ([2a01:e0a:106d:1080:708a:e1be:4bc3:1ed9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm302646185e9.7.2026.03.02.06.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 06:18:52 -0800 (PST)
Message-ID: <3668a0b7-f3a4-4b54-8026-e5d5c1a3abfa@linaro.org>
Date: Mon, 2 Mar 2026 15:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
 <176555459951.1592278.10213529530179974819.b4-ty@linaro.org>
 <CAHTX3d+kSNa98KSMk0Sg7kKq5Dj-NXayVJgcCOSU-DptaxeNSg@mail.gmail.com>
 <7a90c0b7-b548-4129-ba4a-935104fada6f@amd.com>
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
In-Reply-To: <7a90c0b7-b548-4129-ba4a-935104fada6f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/24/26 08:11, Michal Simek wrote:
> Hi Tom,
> 
> On 2/16/26 09:03, Michal Simek wrote:
>> Hi Neil,
>>
>> pá 12. 12. 2025 v 16:50 odesílatel Neil Armstrong
>> <neil.armstrong@linaro.org> napsal:
>>>
>>> Hi,
>>>
>>> On Wed, 26 Nov 2025 16:06:41 +0100, Michal Simek wrote:
>>>> When the UFS controller is operating in slow (PWM) mode,
>>>> the driver is disabled the timeout for UTP send commands.
>>>> In high-speed mode, the timeout remains enabled to
>>>> detect stalled or failed transfers. This change ensures reliable
>>>> operation in slow mode, where command completion may take longer
>>>> and timeouts are not required.
>>>>
>>>> [...]
>>>
>>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)
>>>
>>> [1/1] ufs: Disable UTP command timeout in slow mode
>>>        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/868ec1f0cb77ecd6cd8ab1d40feb38e238c6f1d2
>>>
>>
>> Are you going to send a pull request to Tom to get this to the next branch?
> 
> Can you please take this to v2026.04 release? I didn't get any reply from Neil on this one.
> 
> Thanks,
> Michal

Sorry I was busy, I forgot to send it, rebasing, testing it in CI and sending to tom.

Neil
