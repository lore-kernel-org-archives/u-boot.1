Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705FCFC503
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 08:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B24489046;
	Mon, 14 Oct 2024 10:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qTXu/CL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8046688FD1; Mon, 14 Oct 2024 10:51:36 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC5E88ACB
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43118c9a955so32553995e9.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728895894; x=1729500694; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+tU/2S3wG7D+dofvyjg2L4uO1D+QPhKtwi5+LDEJX6E=;
 b=qTXu/CL56YETEkFKMoty/jCWE44rFBwHxn184AHKODeUmXch+P3cqMzDmRoj0Ocq1b
 JlCQ7cNe0VeNAZ+PGl2njzPYaROyiHkKl7qZT6nIDMxj1qz2CjY1rr0T/Hn1/mXu/rei
 4C5ybs082b+5jKPo7+OMLS+06oDc7eWPu3zB3CgR3eKw/mda9GUphlH4mJLz669tQcFA
 RWwHR5yYrvu5d3N30DedZfytMXqL/6po9ygpjuO8slOR2N6lEpBVlNB2nEn5cEGPg0i3
 f5rrPnFGA+tcK5K9IsZae1xLCFfuA9UCtrgbF06QXyENOopvmHrUhVcBO6KMlX2mmXjA
 c11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728895894; x=1729500694;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+tU/2S3wG7D+dofvyjg2L4uO1D+QPhKtwi5+LDEJX6E=;
 b=Zo1nkt/YNd68Yd2s3uFQGPKIBQlRLbcYGLLO3iZAejg4+vwt8rDMyo3fcJ42rlR6ot
 NsijsYzwAkltM/spmJnEPGSp9lmrAWT6XJtUuqVAh8I/A6JnJ9o/uAvO/wqks59JSkap
 B/XkvFpbAgvfi22tdYXZNTzb9mwkiv66cdgWmtu4ZKytrCsPHRElTI557GJQskERp1Q+
 bUClE2E2R0XR8pz6WXcUGiS2EmhI/kl7G5Kswp9+3e+X7XdHTJMj0OLNpUCXykluDDMi
 qUnRLZDiipWA9EamIETClzbL0mU5631I0X/bjCXhn5X/3qysNecJ3JNHn0nEJXNK1+Ag
 Wotw==
X-Gm-Message-State: AOJu0YyY3OtIfEPZNKZXGdgLcPyRxOR7A7yZlAyu0r6HeVCML0CYP92+
 fqaaks4kT+CjGeHgTxC1nCLY4RWwn78xtsRCIGa7uMFUhUV6tY5l/MLv3u5nLw4=
X-Google-Smtp-Source: AGHT+IHpEdHGISpc3iZITk4qEz8v4tTLKAvW8CIb3zQZpEpaA5LrT11iD3drWTlJtlNiE1hLnJY+ng==
X-Received: by 2002:a05:600c:1e07:b0:42c:acfa:9cae with SMTP id
 5b1f17b1804b1-4311df563ffmr79850925e9.35.1728895893636; 
 Mon, 14 Oct 2024 01:51:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f?
 ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b79f9b4sm10817912f8f.86.2024.10.14.01.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 01:51:33 -0700 (PDT)
Message-ID: <b40c18be-9ca8-4ed6-9121-df9f4f1a5058@linaro.org>
Date: Mon, 14 Oct 2024 10:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-next-20241014
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

This is my first UFS PR with:
- Set of fixes/updates on UFS core for dcache, quirks, memory barriers and startup logic
- Add myself to UFS maintainers
- Add UFS DesignWare Controller for AMD versal2 platforms
- Add UFS Qualcomm controller driver

Thanks,
Neil

The following changes since commit 580fb5773634c4a01f907a164b2a05961840b4c0:

   Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-13 16:25:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-next-20241014

for you to fetch changes up to 0c9c501a87e0070b944ffcd8f0d9942353048f41:

   ufs: Add Support for Qualcomm UFS HC driver (2024-10-14 08:56:03 +0200)

----------------------------------------------------------------
- Set of fixes/updated on UFS core
  - Fix dcache/flush
  - Update & Sync Quirks
  - Backport fixes from Linux
  - Add missing memory barriers
  - Remove link_startup_again logic
  - Add Neil to UFS maintainers
- Add UFS DesignWare Controller for AMD vers2 platforms
- Add UFS Qualcomm controller driver

----------------------------------------------------------------
Bhupesh Sharma (6):
       ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
       ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
       ufs: Sync possible UFS Quirks with Linux UFS driver
       ufs: Add missing memory barriers
       ufs: Fix debug message in 'ufs_start'
       ufs: Add Support for Qualcomm UFS HC driver

Marek Vasut (2):
       ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
       ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO

Neil Armstrong (9):
       ufs: allocate descriptors with size aligned with DMA_MINALIGN
       ufs: fix dcache flush and invalidate range calculation
       ufs: split flush and invalidate to only invalidate when required
       ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
       ufs: core: remove link_startup_again logic
       MAINTAINERS: Add myself to the list of UFS maintainers
       ufs: add device_reset callback
       ufs: add get_max_pwr_mode callback
       ufs: allow UFSHCI version 4.0

Venkatesh Yadav Abbarapu (3):
       ufs: add support for DesignWare Controller
       ufs: ufs-amd-versal2: Add support for AMD UFS controller
       configs: versal2: Add support for AMD UFS platform driver

  MAINTAINERS                        |   1 +
  configs/amd_versal2_virt_defconfig |   2 +-
  drivers/ufs/Kconfig                |  15 +
  drivers/ufs/Makefile               |   2 +
  drivers/ufs/ufs-amd-versal2.c      | 501 +++++++++++++++++++++++++++
  drivers/ufs/ufs-qcom.c             | 670 +++++++++++++++++++++++++++++++++++++
  drivers/ufs/ufs-qcom.h             | 147 ++++++++
  drivers/ufs/ufs.c                  | 111 +++---
  drivers/ufs/ufs.h                  | 224 +++++++++++--
  drivers/ufs/ufshcd-dwc.c           | 133 ++++++++
  drivers/ufs/ufshcd-dwc.h           |  69 ++++
  drivers/ufs/ufshci-dwc.h           |  32 ++
  drivers/ufs/unipro.h               |   7 +
  13 files changed, 1850 insertions(+), 64 deletions(-)
  create mode 100644 drivers/ufs/ufs-amd-versal2.c
  create mode 100644 drivers/ufs/ufs-qcom.c
  create mode 100644 drivers/ufs/ufs-qcom.h
  create mode 100644 drivers/ufs/ufshcd-dwc.c
  create mode 100644 drivers/ufs/ufshcd-dwc.h
  create mode 100644 drivers/ufs/ufshci-dwc.h
