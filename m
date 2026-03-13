Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A0105F79A
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 11:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7B184246;
	Fri, 13 Mar 2026 12:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V34vamie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA7084246; Fri, 13 Mar 2026 12:11:29 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCE784253
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 12:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso18799625e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773400285; x=1774005085; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cyxDn9TXVBSeG2pT3Tfn1KJC0tuwax+2OrU4x+mqp98=;
 b=V34vamielJlqMOXnJVmsTuW6RPcqRZ87z2pKQkDc15v8V+ScCutauz9zKNK4/08ii3
 ZoDzzzXv25PlAwOnH8ULIV4KpWXlLxMJ0KMfexbr5I95bcGvdPCdSYsB5WLKkK0poTpA
 bPY87O0olHezbWgoLYxVKp3dneOJYuwNUUPwPrzCwDODpK8CyPPJVIL+S7noaGIYD5gG
 8uTl3yQuBkWG6Dvf6ZcLu5L2MQH4cm+cYI1UYsl/7oQ8YdJdIp1VWFplQNy9yqlosPSI
 WOTYM5CabLD0DAITp1/aAUoFpZJ2vhJ42mFqIGUL9AGaUHimQfnRaAtjJZdSHTtvdTCq
 i5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773400285; x=1774005085;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cyxDn9TXVBSeG2pT3Tfn1KJC0tuwax+2OrU4x+mqp98=;
 b=dOnYJwm602jYtoLCvjxvYEPRc/rxAw/6Lbwiwsqnn6ubhGYV3jpZJZUJb5hi92J1mG
 dXT2vb5tbm2dCYxbp36ApOL4LKPfdos68CuOZy9GSYWfHEzKXykk/AiASuIj97xn23+8
 kxCqaCe/RhfW1xdTKLb6k1/B/rMUi4n39iaYN8uV46XpKr3JTIkTTr92pl+ehvDmz8jR
 qJdFfxyfBOxbPn4wj1LVs6EphH1uSryhM9SPT3ZyKmhieclLqSqatDXx1YjIjQuLOgMM
 EiPp8eETDsF8EzJdtE2WWfDmZ6E0tJsXnEdp5TKjHfEbecInb/i3Zqusr/YPAg8FM0MF
 D3xw==
X-Gm-Message-State: AOJu0YxLHGae6jqpzvQN/H5EDUwxSYyGaDrJ8jHEmTmEWtEcZMo6niWQ
 ilNN+cNOwZioYA/PUIcmLBsj5Iw0OJaNXcirfszrn6QDyGt8PyEIDH/e2551seF5xtg=
X-Gm-Gg: ATEYQzxVQGpSfcEsAcscJxuh9qoS0m4rj9bSdrl9n+tjaRJ9Uz7siidMpAqx7yJUdxm
 WHbMdBduTDazio1l9b5A6awLFuV8R5wKzi3wxNhOVislnZKyqINuKPUYTShRtlOAr7R7weMaili
 6BxTGSNjmWcXaN5P88LQD/CGPV4xwnfVXbJGZg5C2DVcHyFOezHeuFjdWm1Lp6jGy9wvpY9OEj+
 YKoA/HFsWeVYrZUC5F7MAJKmL+nlD53vEo08cAkHT6mI1TUp7GHLNBI3xokEoETZgYVdX/1XCZR
 viw2p+gvshjifEw8R/ffHOQDrE1OOoyxLI1CylVmQSricRPCi5Wd/E73pnZyc2ttAjOFJddHFO+
 oercV5/zlDH6ZeeZkcC7f6wF9mmQZ/n0w2TsRtYP8qBPUd3Ki/HHzkLHSDISW9X1yS5RXGRHQnw
 9EozWrtR8QC+Na46UB4U+iUF/3/fGnPCjyE98TTyq3ai4kRxDmMC6Fb1QCW5/I5/jRKKElFdyKS
 33z
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-4855672ada8mr41002435e9.32.1773400284913; 
 Fri, 13 Mar 2026 04:11:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d:5fd1:42d3:c84c?
 ([2a01:e0a:106d:1080:70d:5fd1:42d3:c84c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c6c69fsm18833245e9.26.2026.03.13.04.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 04:11:24 -0700 (PDT)
Message-ID: <9808f640-2c8f-4da7-9276-95ab5448d701@linaro.org>
Date: Fri, 13 Mar 2026 12:11:23 +0100
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

This is small set of UFS changes for next release, UFS SPL support + reset
support for Rockchip platforms, and a small callbacks ops cleanup for a future
mediatek UFS driver.

Thanks,
Neil

The following changes since commit c0ca147ac6228949a6d6497531c9f2f4a0dc6c67:

   Merge tag 'u-boot-imx-next-20260228' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2026-03-02 13:44:46 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20260313

for you to fetch changes up to 67d8731d4aad25be00e27eeef3602c519619405e:

   ufs: rockchip: Add device reset support (2026-03-12 09:30:44 +0100)

----------------------------------------------------------------
- ufs_hba_ops callbacks cleanup
- Rockchip UFS reset support
- UFS support in SPL

----------------------------------------------------------------
Alexey Charkov (2):
       spl: Make UFS available for SPL builds
       ufs: rockchip: Add device reset support

Julien Stephan (3):
       drivers: ufs: handle return values of ufs_hba_ops callbacks
       drivers: ufs: add helper for phy_initialization callback
       drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc

  MAINTAINERS                |  1 +
  arch/arm/include/asm/spl.h |  1 +
  common/spl/Kconfig         | 30 ++++++++++++++++++++++++++++
  common/spl/Makefile        |  1 +
  common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
  drivers/Makefile           |  1 +
  drivers/scsi/Makefile      |  3 +++
  drivers/ufs/Kconfig        |  4 ++++
  drivers/ufs/ufs-rockchip.c | 31 +++++++++++++++++++++++------
  drivers/ufs/ufs-rockchip.h |  1 +
  drivers/ufs/ufs-uclass.c   | 36 ++++++++++++++++++++++++----------
  drivers/ufs/ufs.h          | 10 +++++++++-
  lib/Makefile               |  1 +
  13 files changed, 152 insertions(+), 17 deletions(-)
  create mode 100644 common/spl/spl_ufs.c
