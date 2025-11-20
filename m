Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF9CF64AB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969E98405B;
	Thu, 20 Nov 2025 10:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SxqvrglL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3DA84099; Thu, 20 Nov 2025 10:52:37 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3875A84057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477770019e4so6579885e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763632355; x=1764237155; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/7d4gB46VhQliBHB9+TdbjQrd2gqf+NTSljXxEsKdc=;
 b=SxqvrglL1WuRRzNWLNYN5EOlOFrKzPhaLtRw2UXhctAKAemttWBNQg05bSAzQ950QH
 2uZgbSRdsN4Mr5LVZtLgs1aiLGuumYEuD0bnMRiEXj3PB37eg8jmthW54NXKHAYtparT
 FBdz63bv16P8tZ/5mi+7TscYc1ChJ6BQOx/0zfCYmJHtPUmqCIIE5MAsQJQO2A7Di8FS
 8NURNtJBctMUWVsS9pnYkD7N182SuCID58MH9lhTExkXy1uFRN1L4q2+GCljpjErlQJZ
 MxAMOZKWFdDupM2Ldy9jFr7oHOcx+u03FpPZqff1Yi23lYux0wSsGVqpvEiqAv7J1WnA
 I1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763632355; x=1764237155;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/7d4gB46VhQliBHB9+TdbjQrd2gqf+NTSljXxEsKdc=;
 b=M2hdVpN2WTqEJpnAtl4Gxqb3jlL8lUUPd4wmATOb+Sr7qBnW8woXJtgOLbKLwbu4Br
 CHjz7BGq1JrCKvjnY3dUBcFzJJvPHc1hZVo8POzjc86M93YvR7VIEJCzkrsj/ljbzZF4
 m3uPShdWYkLoauwNpoGsQxUciCfw/3T6NO1dZ7x/kIFe6uiyD6BfvAhuOvnM10z28SA7
 pCRZbdSzuH+cQuHGfqLhm4AZ/UWaFXMrLdH5gxMLFl0iaslOj3y9VRSFqgKycw/kZEki
 U0Zygi6rQvBrQlv+gtLvV78PvPPZ4JmVSqmmGDQTBrEIA+K66Yh7TufUQfRY+wvpAVK+
 LJRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOJ0HMCEJ84Zl9f7elXy70plekyDHQiaes2J3WgQR2eLzc4hnk+5wo/7D9sycl8xr/r+aCOVo=@lists.denx.de
X-Gm-Message-State: AOJu0YyF7LgRrvHVYjmp8RDiQf1D6hyQOGW/P9O5Et8+8fszBwQpt3li
 QX08d+J+L21MKO6KmTJbo2T+dLXn+EIGj93obytKdzsh3Q15yrPVrupOXzCjTibLjyY=
X-Gm-Gg: ASbGncuET072Nq9QGBWOGChefcavWZ1H0+WT0Wcf5zbJsWpKtf8sqL2Ts1grIiK+wfS
 9b2MXsvUANuUJjhTTEdHGwumvmkPQugDTIZQ4YNG/ENnFPsAiOMZ0DhxrWRxiUGXmjWwUq0QK/P
 qd35/fgoEckgcBjZGZLJCwsrvtCjXeGag7JC5Wt3mCPRwUjuuwNn0d5y8ehEAE99XCcFHfyX+M9
 SlbI16IoWwA8uvUk0f2ZELWjuDFAVT1z8ibVn+fcd/wjXDKlHqqlSkJ4Tli1xFTRLV/lr4xH4XT
 3I3gobDa0SSDbz6Xot78FWYKCEKA1HcW5E+G8wQuMHozpJlC/GvynJ2LP/7fBxWieVaVsII2GOt
 eNiLCNz3FcFQuvVdiUnIaAnnCqKTRBn5IOP+TnY/sbTsnNSCjKkO/7sMEP0eH1sEFWfPmRJI2eV
 6fZrEAp/Fv930sZA5NlnNG6nAFJLWSl9dpN7OkocAiD3ViVuliquD1kthiOOErgbE=
X-Google-Smtp-Source: AGHT+IECCxOYIvsXh1OlX8yOyfbk2k8myBD1xdbpuhHgOaPCEgbW65SVfMKHCIYWdjIbiv9xPMHDqw==
X-Received: by 2002:a05:600c:4e8f:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-477b8a511d8mr21067875e9.8.1763632354541; 
 Thu, 20 Nov 2025 01:52:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:f6e4:d897:2b4d:1bc7?
 ([2a01:e0a:3d9:2080:f6e4:d897:2b4d:1bc7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831ad9dsm38507955e9.13.2025.11.20.01.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 01:52:34 -0800 (PST)
Message-ID: <6bc0403d-cf6e-4955-839d-7a9751c03ff3@linaro.org>
Date: Thu, 20 Nov 2025 10:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PULL] Please pull interconnect-next-20251120
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
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

+ U-Boot ML

Hi Tom,

Please pull this into next to support the Generic System Interconnect Subsystem
for Qualcomm SoCs as first users. The remaining CI failures were fixed in the v5
version. Also pulled the dependency patch with Casey's agreement.

Thanks,
Neil

The following changes since commit 96edadab5476c37f3c0b0b99877db16e3e58d5e1:

   Merge patch series "ti: add speed grades support for AM62a" (2025-11-12 09:42:50 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/interconnect-next-20251120

for you to fetch changes up to fb3db4aa8df2ae5093a5c1580b9cd5789c248de4:

   qcom_defconfig: enable interconnect for SM8650 (2025-11-20 09:17:58 +0100)

----------------------------------------------------------------
- Qualcomm RPMh cmd_db_read_slave_id() & cmd_db_read_aux_data()
- Initial Interconnect implementation + Qualcomm RPMh support

----------------------------------------------------------------
Aswin Murugan (1):
       soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data() functions

Neil Armstrong (7):
       Introduce the Generic System Interconnect Subsystem
       interconnect: add DM test suite
       MAINTAINERS: add myself as Maintainer of the Generic System Interconnect Subsystem
       interconnect: add support for the Qualcomm RPMh helpers
       interconnect: add support for the SM8650 SoC
       ufs: qcom: vote for interconnect bandwidth on probe
       qcom_defconfig: enable interconnect for SM8650

  MAINTAINERS                                      |   11 +
  arch/sandbox/dts/test.dts                        |   36 +
  arch/sandbox/include/asm/interconnect.h          |   19 +
  configs/qcom_defconfig                           |    3 +
  configs/sandbox64_defconfig                      |    2 +
  configs/sandbox_defconfig                        |    2 +
  doc/api/index.rst                                |    1 +
  doc/api/interconnect.rst                         |  117 ++
  drivers/Kconfig                                  |    2 +
  drivers/Makefile                                 |    1 +
  drivers/interconnect/Kconfig                     |   22 +
  drivers/interconnect/Makefile                    |    8 +
  drivers/interconnect/interconnect-uclass.c       |  545 +++++++
  drivers/interconnect/qcom/Kconfig                |   12 +
  drivers/interconnect/qcom/Makefile               |    7 +
  drivers/interconnect/qcom/bcm-voter.c            |  340 +++++
  drivers/interconnect/qcom/bcm-voter.h            |   19 +
  drivers/interconnect/qcom/icc-rpmh.c             |  224 +++
  drivers/interconnect/qcom/icc-rpmh.h             |  130 ++
  drivers/interconnect/qcom/sm8650.c               | 1665 ++++++++++++++++++++++
  drivers/interconnect/qcom/sm8650.h               |  144 ++
  drivers/interconnect/sandbox-interconnect-test.c |   89 ++
  drivers/interconnect/sandbox-interconnect.c      |  303 ++++
  drivers/soc/qcom/cmd-db.c                        |   45 +
  drivers/ufs/ufs-qcom.c                           |   13 +
  include/dm/uclass-id.h                           |    2 +
  include/interconnect-uclass.h                    |  136 ++
  include/interconnect.h                           |  155 ++
  include/soc/qcom/cmd-db.h                        |    2 +
  test/dm/Makefile                                 |    1 +
  test/dm/interconnect.c                           |  195 +++
  31 files changed, 4251 insertions(+)
  create mode 100644 arch/sandbox/include/asm/interconnect.h
  create mode 100644 doc/api/interconnect.rst
  create mode 100644 drivers/interconnect/Kconfig
  create mode 100644 drivers/interconnect/Makefile
  create mode 100644 drivers/interconnect/interconnect-uclass.c
  create mode 100644 drivers/interconnect/qcom/Kconfig
  create mode 100644 drivers/interconnect/qcom/Makefile
  create mode 100644 drivers/interconnect/qcom/bcm-voter.c
  create mode 100644 drivers/interconnect/qcom/bcm-voter.h
  create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
  create mode 100644 drivers/interconnect/qcom/icc-rpmh.h
  create mode 100644 drivers/interconnect/qcom/sm8650.c
  create mode 100644 drivers/interconnect/qcom/sm8650.h
  create mode 100644 drivers/interconnect/sandbox-interconnect-test.c
  create mode 100644 drivers/interconnect/sandbox-interconnect.c
  create mode 100644 include/interconnect-uclass.h
  create mode 100644 include/interconnect.h
  create mode 100644 test/dm/interconnect.c
