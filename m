Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AF2C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED6B87638;
	Thu, 23 Nov 2023 14:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RqwmTkWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707568760A; Thu, 23 Nov 2023 14:54:18 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290398763D
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-332cb136335so581609f8f.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700747655; x=1701352455; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XJpr3+fyAGRTUefeZpsurulP9PoXpduP7/N5jSc43zU=;
 b=RqwmTkWDcy8I5fYhfih9DfJVgTOk/l7cDnzsZY8nZcnrbf12XnO3RDDG4iz+KiFjS2
 7g3NigKVUyVtxOTy0rY5WgRi7Puu1cBILXltPnnDRekzsKJ9K9yKAQnURZqkvncT3DOi
 pnjLoX/DIVkMJumAqZOh6ho+Ciy+X+IJIUd+QErpW4cPaCsjiVpihtz5JnqOJhTFUdW0
 w4vt+N+Vld01ZGYwpCIhGmDapv8/+eT04xt3haYTz6H++OdB+WCuiMp9ZY6blBZKviIb
 SdCLx2GjyFYuuwSMEOTpjpC/AFF8Tq2MSh7YI+Vjm8kkzI3nencyLr8aarv0c4LKv4/U
 BNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700747655; x=1701352455;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XJpr3+fyAGRTUefeZpsurulP9PoXpduP7/N5jSc43zU=;
 b=tQRmLelAjFmuXEc1rTUTLZ37bSVdL4GJxmrqgqU5TXMJrY61pHcWQXBNu9w8uV1pUW
 Hz9LSynV+jV8UFH9BOiecG/2b+EJDa70lO0GY0T87QhTeHrS+0Hd1G5Amtp32+OzkZEd
 N6pALHg6Xp8TNcCijByEtvNVLneuZLMrM0U2MKmhquBXNnJLH0cC80OrG3LhedaHVyu7
 HTaPcGHWrk8GBBgc7c7CFzyWnqpB4zMvYlBeOC65fA8mebsT9Lvefe1JSqMST6jRT7qQ
 O7sVaZ30J9gOgIKOwpS3NylqH759Karx9kk9iFyTtrRDBLI+L+LsELjBwd2ouB0Aa1Bj
 Lwjg==
X-Gm-Message-State: AOJu0YwBcFyvnS9b5meIg5Jw6SrCAhEZJO/az7Mvz3hUHKsGOTBMeX2x
 HqIba2zVRhohSudFTXxV4d4jOg==
X-Google-Smtp-Source: AGHT+IFedjVasmmSr3GdW7tD49jLTlTMZYYam6Gdk+Zgj/3yTerdS4q/XnFyjLpQ54WBaDuvOk5LVQ==
X-Received: by 2002:a5d:5f8e:0:b0:32f:7734:a0fa with SMTP id
 dr14-20020a5d5f8e000000b0032f7734a0famr4997414wrb.2.1700747655531; 
 Thu, 23 Nov 2023 05:54:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba?
 ([2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba])
 by smtp.gmail.com with ESMTPSA id
 v10-20020adff68a000000b003316db2d48dsm1700397wrp.34.2023.11.23.05.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 05:54:15 -0800 (PST)
Message-ID: <c7704004-3ce5-44da-8010-99157eb7b0a1@linaro.org>
Date: Thu, 23 Nov 2023 14:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Content-Language: en-US, fr
To: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20230915160130.352099-1-jbrunet@baylibre.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
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

On 15/09/2023 18:01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 

I got a regression with this patchset on the BPI M5 (SM1) SDCard, u-boot pytest results:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5603936884
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5603936884/artifacts/test-log.html
Same device but without the patch:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5601899556
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5601899556/artifacts/test-log.html
Same branch but on A311D gives expected results:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5603932746
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5603932746/artifacts/test-log.html


eMMC devices gets 26MHz speed instead of 52MHz, and SD reads and writes gives random errors:

=> mmc info
Device: mmc@ffe07000
Manufacturer ID: 15
OEM: 0
Name: AJTD4R
Bus Speed: 26000000
Mode: MMC High Speed (26MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 4 MiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 14.6 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

=> mmc dev 0
  ** fs_devread read error - block
switch to partitions #0, OK
mmc0 is current device
=> mmc read 0x00200000 0 1000
MMC read: dev # 0, block # 0, count 4096 ... 0 blocks read: ERROR
=> mmc write 0x00200000 200000 3e8
MMC write: dev # 0, block # 2097152, count 1000 ... 0 blocks written: ERROR


I ran the test twice to be sure.

Neil
