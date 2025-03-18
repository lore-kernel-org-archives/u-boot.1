Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0D5C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 16:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8384081026;
	Tue, 18 Mar 2025 17:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dKi/+Gsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D232810F4; Tue, 18 Mar 2025 17:20:49 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E5C800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so23661005e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742314846; x=1742919646; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1lzdPyZmkij68K+y+Kgia110zVtysvaRRf1WEjxr+Q=;
 b=dKi/+Gsgki3IZ90OESoQLT7q6EUISSK6MNnwDmnccgNo59t9/WAnQGpI0ET1SOhkCS
 xQtdRj5uF/zeo57Mf8zM3oBHjHV96kbk40BfNj3qPUuy51VGtwrBM5DV5aFwUd7zVD1i
 8LXXFsqyOktw9Rb+U5tjsHqdwFTUJE0UpH2fJquGX/Gk/UUpG+e/+O+qkaiHe2hR2Y5n
 ZcgGQJqnNTOJLTINhYbuermk5BkuLjxgrhT16c8uBuwredHpdOr8f9nKhpwZROXZMaPQ
 hYbt9Kq+RECGDQKDSW3KTcJ6Ng8j2G/5mNfpfximzp8jbIeND6fI+bUAtvf7USxQa/mB
 lPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742314846; x=1742919646;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1lzdPyZmkij68K+y+Kgia110zVtysvaRRf1WEjxr+Q=;
 b=vDPafqKIfCz5+ZAH8ObmiURHr9zYQfg5glJKq1MfAj3mWhcyG+ODAxZA9EbEgzGL8a
 Xo1ik0cN0m0UAF32ypCgvIHShH6lzYF50mw0qTsrlghbANaA03vZ+OOzaDQHSZNbG5WV
 3HJrxGoEeqL3DEUfLmP+aTYEGCrqXKbj0t/Yf5Z3UbXUGbcW3gClF+HGne8GxxBpAPQk
 HembXpCUMQzB/4XAZsIrGv2MXUMU3ze4yiu2Eqinth19YbYRP/dPNayz1PYNPEkR/KeQ
 gjLknmcBDZjA0XSR1CGK9Vay+ooQutXSGBPXsyA4LCK/faSFbjw9BS0lf6+SdEaSd1I7
 9Vlw==
X-Gm-Message-State: AOJu0YxtGNkd9vQWQ2Nr1uV0ovPM3fYGD/wBocjKGhhr8irE9y6tEyiW
 8GU247ycPYr2hDp8m6ysY6Oa5jnQWHF5IGZAL5iEC+ddUxa3ws5n4YV6I4622Hg=
X-Gm-Gg: ASbGncvHFTW3HQdC21skCd0ofRl59261Ko0JhI0aR6rHFHLodpfewNqdWCbQbn3nMgn
 5CFrCElZBWgzC3p2uJFcgy28G/lApcHb2r4xm6nYlguEN2UBpRjLLF0FD8TXySkhpBNbQ7+Np+s
 0/5AfT6zwS6Imtl+Gh7JTRLnmOqI+hMMdWPZ7cnGW3lKISg4D/5rmmotu3dmmr5u6zF1bLxChIv
 sabGRZmp7DiDl+XdjNP5oEOB7pjNnETirl5R+HPNgof3rCXn2GWR1n1FhoLl8SW5Zfyri64pVSB
 PA7MjYl/hxctVGUC7/qP6W+J4nwmsUpuodcQoqgsTpjRM1JJt6CzFIl/tGMDMJG8j4jzANfE3TT
 mtfyniTeKh+WPZwZ89xSgpg==
X-Google-Smtp-Source: AGHT+IGrz/7QjoKyMi1l8kSVH/VTSc7aSucLd6sRg7soTwINuVNr5lOy88shjNAV56ocMhIWLO0lDQ==
X-Received: by 2002:a05:600c:310e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43d3b7c9e1bmr28639285e9.0.1742314846380; 
 Tue, 18 Mar 2025 09:20:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff?
 ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60b46sm136977245e9.32.2025.03.18.09.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 09:20:46 -0700 (PDT)
Message-ID: <5ac73ad3-d718-45d5-8578-a37f6fd25d4b@linaro.org>
Date: Tue, 18 Mar 2025 17:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-next-20250318
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

This is a welcome cleanup and sync with the v6.12 UFS headers to ease
code sync from Linux.

Thanks,
Neil

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-next-20250318

for you to fetch changes up to d232d7fdbf6f86e11f2dda2211132fdcffa8b5aa:

   ufs: core: sync ufshci.h with Linux v6.12 (2025-03-18 15:55:08 +0100)

----------------------------------------------------------------
- initial cleanup and defines sync with Linux v6.12

----------------------------------------------------------------
Neil Armstrong (6):
       ufs: core: include missing include/ufs.h
       ufs: core: mark unexported functions as static
       ufs: core: cosmetic fixups
       ufs: core: move ufshci defines in a separate header
       ufs: core: sync unipro.h with Linux v6.12
       ufs: core: sync ufshci.h with Linux v6.12

  drivers/ufs/ufs.c    |  44 +++--
  drivers/ufs/ufs.h    | 335 +-----------------------------------
  drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/ufs/unipro.h | 128 ++++++++------
  4 files changed, 571 insertions(+), 405 deletions(-)
  create mode 100644 drivers/ufs/ufshci.h
