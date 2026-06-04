Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAED1CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248D5848D8;
	Thu,  4 Jun 2026 18:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLb7hXQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24A684928; Thu,  4 Jun 2026 18:00:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F9C84879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso465385f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780588804; x=1781193604; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPkrPQ7n6xYQPRFabO5zUpoI9hnyBSPxoMwRdTkRceo=;
 b=VLb7hXQ76c7iZBbFwKGlsXAp43g0KjimqCMjbqKBws+PjxbdSDTyOCpOv6mT1jZOn7
 KWSGyYDwVP/j1R1PtGlUEuva6wugNg0CXq/jK5cw5uBIEPoWxYt/oazLDQ+igX4cFMgU
 Rm2Rtl8z+qxFYahUqX0R4BVX9bbx/hgV0wD0u4O073qwfuH1uwQm/2+ljruzcst5lL8X
 3o1d5M9zhKBmouNZpwnMe2weXzTFcDah8EBrlBAp/N5wF9RoxfldVLQ9NcgDnDQBUwwb
 ifsUGtUDIE2aJHiUSiCyYmBt5LSnQX2pCLnlhin1PJD7fBikQpPO8ViIaz747xI+InLx
 vIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780588804; x=1781193604;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPkrPQ7n6xYQPRFabO5zUpoI9hnyBSPxoMwRdTkRceo=;
 b=JRrQKzdGBknlEunH5cC6y4UsHRIJogzyAN8DhYgbxOi8GjpBJnZK0s02ScRUdL/c+s
 CPHvtRpx+1qGgYAHLCoGbsxX7IjimdyqeYYdh0XjEY/9mY9H26ya0x8imoH1NFWTqNlm
 RctDryWJrGNWnxbDXiIEY8OxRJndfWhzSYes79jjg+Eh44PeyNoo4jPOtqzeWKSsB6L8
 +cXdCOR2hQGP2stFaWZWem0X79sGJPu8H/ER1aCvWOjfC7vLwgjzn7jtwoGcW9iTf85k
 75yzXX+dUddrEOVZERKb9CWy1+DDxLMGx3gdS6pVFJ9jiiCYIq1AGr1Mq6GLoLq6Ov+C
 1eSw==
X-Gm-Message-State: AOJu0YyYeWd8D2trQmJuy6Agk6t/jdh2UZ2lWB89w9H7BrMX4A8EEHKi
 4a+xGUagg6dK0bAVE83zRgLaX9q2c7R+zIvjxGsWtbl6teqdvqHFJB5xD+2LtY1GNyQ=
X-Gm-Gg: Acq92OGu35vKljIatjKvfH8Wxlr/qszLBH2cyZGMnjHgbSHU3rbufoPd/vSCxyQn1FU
 BL7Pjyp00u65rArZnHNmvWTeDEdMzv1miRl2NflBWNvdpvENJcc6iEx2j8FquZNCqF5DkCjtz0k
 2DfValWJrOP9Z16izmwDtIW7lRdNJwWIY7iVxQg1ZIwK4x+AcHIs8YElJZpcK6Io8UGwYpuDcnE
 GiMrey91bwKGGRIMz0OBjFPr/BLVJDvZ/H4jvUDsIWPo3KjHeOzZX917EGqkmBdNV1T4cJpapK4
 +lv4qyt6eObqVbeVaqu2SjDpqlfDyArlDtYpU3m/mzo2iKl+PxWrwM88A7meFiZUNUU0ZOVmGQw
 s+XEeTFwkLHnoJvjZfMeSu4aZffyFe9VDtrCPn+whdYxo6M3h3G9tt87kJp9Foy9foYl1d5dWbs
 qFJZa53bBb2lE5d3KmRVv2FGMiWfnIL4ZObzQ8YicDIQDJozJbYo/5Wq/3tfg7BExMz3ik8Jpcq
 tYWUNtPd+cF15E=
X-Received: by 2002:a05:6000:2809:b0:460:1492:4f0d with SMTP id
 ffacd0b85a97d-460218617damr9443548f8f.34.1780588803264; 
 Thu, 04 Jun 2026 09:00:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344541sm15730230f8f.22.2026.06.04.09.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 09:00:02 -0700 (PDT)
Message-ID: <069a3957-458b-48bf-b34e-d5566281cd29@linaro.org>
Date: Thu, 4 Jun 2026 18:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-nvme-fixes-20260604
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

This a second NVMe fixes PR, with a few fixes and LOG enable on timeouts.

Thanks,
Neil

The following changes since commit 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa:

   Merge tag 'u-boot-stm32-20260526' of https://source.denx.de/u-boot/custodians/u-boot-stm (2026-05-26 08:22:05 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-nvme-fixes-20260604

for you to fetch changes up to 389363d287585d8135a554c4419a4f580346b9f8:

   drivers: nvme: Log I/O timeouts (2026-06-03 18:22:18 +0200)

----------------------------------------------------------------
- fix dcache invalidation range in identify command
- avoid deleting uncreated queues
- free prp_pool on nvme_init() failure paths
- Log I/O timeouts

----------------------------------------------------------------
Denis Mukhin (1):
       drivers: nvme: Log I/O timeouts

Prashant Kamble (3):
       nvme: fix dcache invalidation range in identify command
       nvme: avoid deleting uncreated queues
       nvme: free prp_pool on nvme_init() failure paths

  drivers/nvme/nvme.c | 50 +++++++++++++++++++++++++++++++++-----------------
  1 file changed, 33 insertions(+), 17 deletions(-)
