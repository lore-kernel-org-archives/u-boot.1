Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE01C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 16:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8E581026;
	Tue, 18 Mar 2025 17:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JPIgYvl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341C9810F4; Tue, 18 Mar 2025 17:06:23 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DF8800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1904297f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742313980; x=1742918780; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWaWpeZxNvP7SpV0ZNApUVcLRnavCoScAR0tW6hGmiE=;
 b=JPIgYvl+94mOp39WltysjK5hZJW7Kq1nyb+Wi+oB8DuzH+Sj+s9bbPcRuW7zPdiyfc
 TTvo4kGoUKZ8UL+uJJefqMbyGrFBT4wLft1tbmzVmMz1ovHAmESZ6BkAhdvoxP0Brne7
 lTpnEnsWjtvLJMArvSDVmncvnPuTKLFnbez4sak93cYlp2V6DcdR+4UwfPsvunZcEaoD
 wR0MUymTXfl3VeW8c5GnI4tj677DcFdkH15wrL6GcXm/jEkEZpxnKc8BcHLigljttust
 tCstnJqY9e03ORjSptIuTX+ukausl40EubQ24K4uOIwVJlGhhTXy7+FD2R4hg7IF0TDM
 E6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742313980; x=1742918780;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWaWpeZxNvP7SpV0ZNApUVcLRnavCoScAR0tW6hGmiE=;
 b=Q86YtYHJjgI/jn1Lr14Tdh0NYUT+NEHtAgYfxwg0YrHJ4Kh1wOOkSmkYzal0KL+nNr
 GXbms0jC0krWeni1H0zfcBB2AsKuUHc/z6A9cZk5WzUjNawIHW9VH9klHqyHNMJ1gOoq
 h89K6dpJCjdR7zMphIBF/pm/zUFjW4mKgRveRFKNAVpdCiPYpZCf+4+vA0tfaOfz6JOK
 HjREbbvyiuQv9kllBe/FVtGnik2wC0cPHPyUW1VcMSU9k1U6ckEVdkoYSqLfqAaNy278
 S2+nRbBoNfzubwWA9rF2uCSh6PSHvQI1tQeBUfEXb57PtwO7XQJLrffqR/2s9Ib0vYyw
 nrsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkpXXZ96Nd8T2FcR8XTLdFyCRk+d92NnoNc6qRhtASB1cgTKrcdrYhi2wXtUlwKFDYLNRhh/I=@lists.denx.de
X-Gm-Message-State: AOJu0YwNK04NGIs/uBODhN3TlAzxA/nhCkBKGfCHsuR3FlToYPAjOaoN
 +uimjKud1DnOnsgnd30acJUjS1/3Vj4hTvKk66PMxsR5RnUBM0ObabHTzZnnRko=
X-Gm-Gg: ASbGncsfOodlGDF9/NzWDal4eQw3LRA/51DsJNl94ExdA8uuhNc/IJ8Qp3Uk2m76Xdk
 Bh7YR2PfnlUU/Dzv2slC5wh8vWa13otlMZlukpLMuC//eZiiHWg+/9k0Zy4m5gCbobF1GcNvz8o
 7pRhJddtbnJDq+I9eNOjlO2/k5DOoEEILMqW366EuVCYEeGCHylhoAdIdljtvdtRHLvZuinNgut
 r48UzI4wxaINqYQh/KEKifLTYE7z/zofqI2nPZGKPeEbCV8klqlNE53GpgUku99ZCevQn+mFAoH
 ZbNOh3uu8i790j4s6xnSFF1C0IDMxQxK1oJd2Z2FpZOBx58M9qoGUd7t1ZYJVj9cGX5cwb1dQ7B
 LbbL7oC8TQeNx2Mch7VqppA==
X-Google-Smtp-Source: AGHT+IEj4YZposyR3KNZaAB0g3jjgnXTLdusIpOcmC0illv8PLBDcW8sId2LzoAZV1GThGM7RYMccw==
X-Received: by 2002:a5d:588e:0:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-3972121b9a5mr17946264f8f.53.1742313979764; 
 Tue, 18 Mar 2025 09:06:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff?
 ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60951sm138366635e9.26.2025.03.18.09.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 09:06:19 -0700 (PDT)
Message-ID: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
Date: Tue, 18 Mar 2025 17:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20250318 into next
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

Here's a small set of changes for Amlogic SoC support.

Thanks,
Neil

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20250318

for you to fetch changes up to e80b586cfc73ee123dae42d5d85543798ff7a3c5:

   board: odroid-n2: Update docs for signing (2025-03-18 15:27:25 +0100)

----------------------------------------------------------------
- odroid-n2: Update docs for signing
- support Amlogic chip_id v1 and v2

----------------------------------------------------------------
Baltazár Radics (1):
       board: odroid-n2: Update docs for signing

Evgeny Bachinin (3):
       arm: meson: unify type being used for socinfo
       arm: meson: sm: get rid of SM_CHIP_ID_SIZE
       arch: arm: meson: support Amlogic chip_id v1 and v2

  arch/arm/include/asm/arch-meson/boot.h |  14 ++++
  arch/arm/include/asm/arch-meson/sm.h   |  48 ++++++++++++-
  arch/arm/mach-meson/board-info.c       |  13 ++--
  arch/arm/mach-meson/sm.c               | 120 ++++++++++++++++++++++++++++++---
  doc/board/amlogic/odroid-n2.rst        |  15 +----
  5 files changed, 182 insertions(+), 28 deletions(-)
