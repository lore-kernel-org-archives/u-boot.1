Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AFFCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBB28490B;
	Thu,  4 Jun 2026 14:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AV2arfSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877C48490E; Thu,  4 Jun 2026 14:46:44 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EE9848DF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so5909585e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577202; x=1781182002; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gMXcQwhQAAA7+dLs/CPK6D8EmbK2g6i+fztMboCR5XE=;
 b=AV2arfSkOYTFW9a8YRb1cBTn97DD8SXziLtespgFw/VwDoBmvzhJ3Q4CjgPu7ORA39
 NQCYTkHOg3axzGno+AdBuTONhFX/o16sTISrtZ2nmVdwPy7T9ePXz/5jViOLgCek8fPL
 NISifrXy3Qlg0BS843Gl/0/EhyJjnNPFF6b8dRPzcnRgYw/6SWlzH7wCeM1dKE+QjaNC
 DwseN39WTu+3bAQtO0SWiRpLtjARhB8Y98WlStOBgSWalNpyT0RGrCR4dnhSJ+PgB5Oy
 +2hQtcjExUeG6xrtnEBxPF+YqbgeiU5J0u/egTTX+m1ZQoO0EaUaFRH0BrlXOaDDt7f5
 dAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577202; x=1781182002;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMXcQwhQAAA7+dLs/CPK6D8EmbK2g6i+fztMboCR5XE=;
 b=WEe9XJj6g0PPYMAcrjdHcBh8R85bJbhIiV/dUS2K2NiYtxIB0oHYqh3nQpbolxslaM
 7tdgg7EY58NDVOXnZYGmHIEQKEac1kc+elWtVAzvCVVPwJ0KIomzJbEtr+9BRMlkwOPc
 NvnQT7L17x6OHF71smRkWid9rvoL43lgUWMgP5bapxrc0GIpn01yE2yV5RJKor4XKKsI
 Q/vRS+OKBJ2b7PFE9lOiotwPN4cNrpqZUZKo+rnxehJdllvr3rBQwjsDpd6GIAFNOcDA
 bIxpxzOi4tt/xltC0WuxNkRGVlLeanzj/8kaYDT5Qf5nwQrdkJeEDCZk0uf6KYcD6L0y
 /YXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aw3f54qdB7E206iJ7v6989LcOjaXlstllVPFtp1BQ0irpk+vpQECRjUwk+ihxtL3VvNP7pEU=@lists.denx.de
X-Gm-Message-State: AOJu0YyYHlQefezWGhJm6NAle/knuXVZJluSlVnIEb+UCbaNHpXl1Nny
 2fBa+VM2xUgLa8CnbU9UTW8ojDaX4xFr580pR6lqH56PgRwf0yKMsVBNrmTreKORn5I=
X-Gm-Gg: Acq92OH7hn59OAbS0CQnpcKC62FtsVN54DTBRSNLvjeBqNfU5UI33I1TDN3rRd5SDEn
 DErRCVS4XIRX9sT6OTjlXoNv1VHOe4UKl7+5n5LqKECQVaO6qu7uDz6Cz/5aYaC9DOnaN0t1fV4
 zwR91jzSdKYH8WNskJWY4CoK9iko71hepj7l2/V04gkO0f5cgADG2LmkTNaUkc78WdNeq54kEs1
 7GhFYXMhLJKJj54gujfsIZK3HjdFkh/mkVtTxebX7RQHPBzX6anS72zF5NhTkCGKASo9xT5bzWQ
 /WIgEsRKvKsiq6JgC3d2qbNeLvJu+4C8LgD+RBcZ/yA0782nabeszFVxneduS0T8wiJbcapcil3
 IO0H4CD1pMQvIWEeMFJMCxoXut4RmVPwOPXSGoDU12yJ1p3lbWfq/bbkRA7P6SVnIQbkEvFJ91J
 WjcgNh9gZ0zsmmOy9//LMGg6ddMiZf3IopdvF0B7ygAqxLJnKpm1Rw4eyibDMfEDEQxwoYhgdPz
 NbA3ubf1HqV6Pl/FLebJ++hZg==
X-Received: by 2002:a05:600c:859b:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490b5e95fccmr102152635e9.12.1780577201906; 
 Thu, 04 Jun 2026 05:46:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39def5sm64837715e9.5.2026.06.04.05.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:46:41 -0700 (PDT)
Message-ID: <0fb6de0d-7c50-4eba-b899-867d65ebefba@linaro.org>
Date: Thu, 4 Jun 2026 14:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH PATCHSET 1/6] MAINTAINERS: Add myself to the list of UFS
 maintainers
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
 <20260604-ufs_tool-v1-1-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-1-741ed00232c0@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
>      Adding myself to ufs.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af196465..0cb8c3e144b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1920,8 +1920,13 @@ UFS
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   M:	Neha Malcom Francis <n-francis@ti.com>
> +M:	Raz Ben Yehuda <raz.benyehuda@mobileye.com>

I don't think we need more UFS maintainers, but we definitely need more
reviewers.

Please set R:

Thanks,
Neil

>   S:	Maintained
> +F:	cmd/ufs.c
>   F:	common/spl/spl_ufs.c
> +F:	doc/usage/cmd/ufs.rst
> +F:	drivers/ufs/ufs_tool.c
> +F:	drivers/ufs/ufs_tool.h
>   F:	drivers/ufs/
>   
>   UPL
> 

