Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E70C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 09:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD212879FC;
	Mon, 25 Mar 2024 10:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vPOxo4MD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A1A87BC9; Mon, 25 Mar 2024 10:45:47 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F2D87061
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 10:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4141156f245so28586735e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711359945; x=1711964745; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UcrEtD3QKqez7BRwuFAL5gLLM1Hprt+fJgIRbNpXL88=;
 b=vPOxo4MDrqZOA2QhySel2Q2A0g850SRTLWk6PumgXXBHPNYTltIg+uTI9AQLuS+r8l
 79PavSKHS2Ld/udxJuRSHZaEWQM5+1UH7dHeTULO3bJvQwpz2ns74Cf5i5GOYR0ffBTD
 +De+5NP0Zwv4mYsgq9kLm+wbXyj1J+D7FffpXco1I5phuRZGlrB+9LCULyjpw1I4PfSv
 WttTKfNSL2jP70FLWxwXqmyV0cY8Xi1BxuE3xSDXdlmH0B0rPdKSg4tpvd5bXIUbt6M3
 ukioBiQnCqQPYrhQSrDYsuTvbsMWPmvZ/hYeqbaVmBgxFvndIRm8y+JBzwPK5Hh2Whf3
 XBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711359945; x=1711964745;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcrEtD3QKqez7BRwuFAL5gLLM1Hprt+fJgIRbNpXL88=;
 b=SzrogKPGF2SgB98/DjL7VHW1HmcWdVr6BU3satzxx6PaQYqBc0RCGCAY2A8e8IZyXa
 hnQnPYmN3zZqjCnUXCWd8KPOYVIXBTWChiiVTqDeN7PhnEZ9EYdEwtOvMI4DvWLPpG1E
 YrKh5IYaOMj1iPww0wMtfXywOvR5JvKAiwTL8fvQUUrmTlmi3Nc3el/xBRdhwltdJv5s
 LnuTsD6qD1mrzPqiaNTh+OhF/NWtE/68qm1+dnRptCiRtHsxpzXE2SO3x5lTnyhO+iSF
 PlfTXhOqVd+nKPIbo4ityDTAdPlh/jdVpJXP7Fo63kzRUrEbZ91UmhoYyxEpbHvllGUB
 YHSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWASwqVAllobygAMrxcJNh0p0+VWMMgiKiMSX8LaCZyY6B7jH95+obj8mh3k1PfYqMNLDWNJ22FS4ZZ1iWdf+n7Mea/LA==
X-Gm-Message-State: AOJu0YwK0S+xIk+yWmSzO+AQhfGNQI9HnQ1y1q4MLzNJYc9eYl/qjtQP
 SHOG+3kJoTjGBV4Xyqj5xxYhGuIb/aAOLFlA9xQN2kWeCmYYSnBRdzhhNd+QlP0=
X-Google-Smtp-Source: AGHT+IH/clFILcuiKEU0XbYV4mUD/qtU0/Lj8AUkPNq59Cp5nj9iYsxhP6EXxR5fDirP44O8L79fQg==
X-Received: by 2002:a05:600c:a02:b0:413:1ae3:8dd2 with SMTP id
 z2-20020a05600c0a0200b004131ae38dd2mr4515304wmp.37.1711359944691; 
 Mon, 25 Mar 2024 02:45:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:32cb:35f3:5930:592a?
 ([2a01:e0a:982:cbb0:32cb:35f3:5930:592a])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c190600b0041480a98bb3sm7239828wmq.15.2024.03.25.02.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:45:44 -0700 (PDT)
Message-ID: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
Date: Mon, 25 Mar 2024 10:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-fixes-20240325
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

Please pull this set of last minute fixes

Thanks,
Neil

The following changes since commit bd0aedde3ea3691616c17c720e2d25351308c0a1:

   board: toradex: verdin-am62_r5: Increase SPL_STACK_R_MALLOC_SIMPLE_LEN (2024-03-22 11:10:51 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-fixes-20240325

for you to fetch changes up to d54f87f09a36ac20154955297b7c999b368b0443:

   board: amlogic: fix buffler overflow in seria, mac & usid read (2024-03-25 09:16:19 +0100)

----------------------------------------------------------------
- fix Ethernet and random MAC's on WeTek Hub/Play2
- fix buffer overflow in serial, mac & usid read

----------------------------------------------------------------
Christian Hewitt (2):
       ARM: dts: fix Ethernet on WeTek Hub/Play2
       board: amlogic: add meson_generate_serial_ethaddr fallback to p200

Neil Armstrong (1):
       board: amlogic: fix buffler overflow in seria, mac & usid read

  ...b-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
  arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi             | 13 +++++++++++++
  board/amlogic/beelink-s922x/beelink-s922x.c                 |  3 ++-
  board/amlogic/jethub-j100/jethub-j100.c                     |  3 ++-
  board/amlogic/jethub-j80/jethub-j80.c                       |  9 ++++++---
  board/amlogic/odroid-n2/odroid-n2.c                         |  3 ++-
  board/amlogic/p200/p200.c                                   |  8 ++++++--
  board/amlogic/p201/p201.c                                   |  6 ++++--
  board/amlogic/p212/p212.c                                   |  6 ++++--
  board/amlogic/q200/q200.c                                   |  6 ++++--
  board/amlogic/vim3/vim3.c                                   |  3 ++-
  11 files changed, 45 insertions(+), 15 deletions(-)
  rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
  create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
