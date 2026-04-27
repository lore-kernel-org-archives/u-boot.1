Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27966FF8864
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A3E83693;
	Mon, 27 Apr 2026 09:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YMuypD9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB5E84120; Mon, 27 Apr 2026 09:56:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9DF80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so49062325e9.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276587; x=1777881387; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joKczF6XzP6rdLXJu4qd29R7Zp1AGpXpKmNbVYO6K/Y=;
 b=YMuypD9spuSjif3MBVBNi/Y2SEABu9Z1wGWcXQS7wkHFRFq3lceXOG0DvcYK7KNn/Z
 7WOA/PfmTdmThSsFQLdJxY6E17vX+Hy+ucezNJvCFbIbfJcVqM51o4qqmNMEGpzOZb7f
 feI+HGvEdS8hCJ/Kg5Wbu9iwU2Q5uEzywEM3HagqHBWKS2E0qVTomWigV3b2Lnjz3loY
 wzxOU9YhblUlGNbK0wHYgbF8BL9NbW+k0oaz7RnWcMM9bqd2dx2wxzFP6De9XEGtlaq8
 Ou0apCLs6tglrZ6sfdZpVektWSzMLBBIvP1QwvR08BvYv+UdifNRhy1V6L4xSPIaG+dv
 xkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276587; x=1777881387;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joKczF6XzP6rdLXJu4qd29R7Zp1AGpXpKmNbVYO6K/Y=;
 b=mGTlZ6pcxN13wzSL5mcaQ0s5NFGvWKI/kHgOgMG7IT/aP0uQ54gY15OvMLGjv83ISv
 AVzyfsfJE4lMxBg7ChS41/kGcc1gRlo0gMEbjsPUoj7v3u7oIWpzfMEEqxNecd7Y7AMa
 v5Ta6MtLbsC0miXFXP5QBpSDeTIFiLJeHHnnOY5VP/VUKRa+wCoVsY1KfpSP60wBsc2x
 EfDdt/dyGkBt6iRUWIviXPokU7MWCJonGgHQ/2C8yt8iS+L2Jd6wh0rI3rBRkLd/PiFB
 7AtzwajlWIJusAdEoneeEPWJiZa5ao+w8uYPNxOYoqKmYoEr41Rauz14BWmgdPgyQSKu
 Fehg==
X-Gm-Message-State: AOJu0YzcxoMIKAPeZC2eENPgYV9bMerLdO/GZzDbqKp8Zg5fom9TetCg
 tErzfiwEQlusotMBIw6QzVDhK24fgm7syJbvc5FE/QMNa4sKYncMSxiJk+nvomqtek0=
X-Gm-Gg: AeBDiesaE0GznMDBSy3GkwsBJnwZrI5ZXz5cWyaBOJRr3/ZoYdn0GZJrGtpkG8uQTDo
 4miEKCuzTLZKvSic2EqDUIq/wBq0pU1ddWrwFpjNwtGcaK+whNzzc7ZYyi4sbpFSYu97lOGnlJE
 aU5s6oBh1I9gC4PHeTam8/osuJ/A5XGOuZb4KcCzi+KyTzBNhTdKXnQNe4cD2P8IknS9jB7B2WF
 g5gfr1oupo7xC2oLjVHn3o+E8f9qYNV2TCOXLUcPEnCk1l2Wgno+598e2SOXftrim2Q3wfIBTTH
 PeS74kG1L0CTjIbo9d4Gh0pnfoTL8OLjtSzgQ88K1n0dcAUMOiNxOIs58+z6244o53aHq0QjOFF
 7wm+RyQD9d9qXdPPr6ZsNJk6Iz/7W6PTS3jDjodLdRsI9D9p7Sdjuv7MjuFuEHmK3OwU38FhXVj
 t825mivuUbPUR5x6HL6gREGYigayEpcIjC8ukBcp9AjSwCsLroHjKpowg0tzI+3zv3RIEmgHggq
 /jK0XP9zgdydrq2gw==
X-Received: by 2002:a05:600c:3b2a:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48a534af0ffmr378685935e9.1.1777276586747; 
 Mon, 27 Apr 2026 00:56:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440?
 ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm939134475e9.4.2026.04.27.00.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:56:26 -0700 (PDT)
Message-ID: <c5ebc13e-50f0-4341-b8e3-0e0d797a0125@linaro.org>
Date: Mon, 27 Apr 2026 09:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-20260313
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
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

Hi Tom,

This is small set of UFS changes for next release, Reset fixes for Renesas Gen5 & rockchip,
and possible corruption fix.

Thanks,
Neil

The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:

   Merge patch series "Linux compat improvements and CCF prep" (2026-04-21 11:21:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20260427

for you to fetch changes up to 1089ed95f54e43ddbbe19712b69d9ace374e572c:

   ufs: rcar-gen5: Update line reset configuration (2026-04-22 10:09:40 +0200)

----------------------------------------------------------------
- Update line reset configuration for rcar-gen5
- core: Fix heap corruption due to out of bounds write
- rockchip: Make use of controller resets

----------------------------------------------------------------
Alexey Charkov (1):
       ufs: rockchip: Make use of controller resets

Marek Vasut (2):
       ufs: core: Fix heap corruption due to out of bounds write
       ufs: rcar-gen5: Update line reset configuration

  drivers/ufs/ufs-renesas-rcar-gen5.c | 16 ++++++++--------
  drivers/ufs/ufs-rockchip.c          | 13 ++++++++++++-
  drivers/ufs/ufs-uclass.c            | 10 +++++++++-
  3 files changed, 29 insertions(+), 10 deletions(-)
