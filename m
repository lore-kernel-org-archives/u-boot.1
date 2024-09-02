Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E1CCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348C388875;
	Mon,  2 Sep 2024 18:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yvGscgla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5990088C39; Mon,  2 Sep 2024 18:26:24 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F6988363
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c962e5adso708128f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725294381; x=1725899181; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U0IRX6WpW/9MmbP4RjtAoTzg2pR3yhtmDYoE75t5k3c=;
 b=yvGscglaEYZis+JAuD5nBkiy/G/YVcAFbLOrNLSH7OqE04JNNUkgjGwW0YyN4Fcmdd
 Ac9BlqqcTs64YDtdRTZ1C7cZMalXdzs7bfpdmiejA8BsT/O5YTVw70uPjCKZHJWPFXP0
 N9qLXUH7dwFGY780ri6Fd4qv+dAVvpndLPAg2vRX65vPVkrzp/fpYGmo6TAptm/oStWM
 H9oQHvJvndmZT3ATcZqoQNMhbLZvhKdr/b/oAsMctw/yWjGKr7VNkp03YtAl1hOdG0Lp
 F08vkOMpZ2fQqIxpa0oIzURVQT3frtzYUAw00CuGBE2hUwfbOc90pKSdPTjm2juvJ99m
 Pi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725294381; x=1725899181;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0IRX6WpW/9MmbP4RjtAoTzg2pR3yhtmDYoE75t5k3c=;
 b=u+st4pziQ3/x8ROSt+hXphKt2l2XMQTkw5zzm5mTiSLrigzDsfaKF+s0H7qPLG/7fq
 KkNqP4bYBGMALZ5bwJV5I3vf9sd/iV8W5S4duiO2oZJeEMK5fTR39iXGBB4DKAFuB3UA
 uKDe+yKoIxt9YRyv15X5O9r+qn0Q+LrkcyeHRrA6boqbPecwDNXYiU6EvmmoCO7iRtRp
 6UdcTG2KQyvScVeM+dtJ6IxkGTihMjJ7Hf6EogNVIaSXbfB/ZEmPEbBWUwO8gUs7zn4l
 uZIbEAMWYpRluLyhqonMywCEoLYDpvYN1vtzmTAmeRpM2yFQiT/miZVqE1tanVlj9X7F
 n9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdkESUt2Jh0RBqVu6xuebYR318xaXlHsvBJ/IttMMt8YVtdDXgisRg/Og7ex+IQ6KazJKV2+c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy41gMOyj5VI7CwdXhaZArBzoKTiFWUB447uEL82xeC1azeMLKO
 +THDGxGoGP5vdbyAORBHA2T9E9qIVSVVVw727NGtVuph3f/mrHZRrSkxsDC8Bks=
X-Google-Smtp-Source: AGHT+IEkQ86FRaqwu3nwXwwIeuSM10p8VSHHU3bEodYOQhl1hwK0nUiYLrTGt/Tm3krPQg1BhW0fRQ==
X-Received: by 2002:a5d:47cb:0:b0:363:ac4d:c44f with SMTP id
 ffacd0b85a97d-374a91a4118mr7694892f8f.17.1725294380976; 
 Mon, 02 Sep 2024 09:26:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa?
 ([2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bfbfc7b7sm6898110f8f.88.2024.09.02.09.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 09:26:20 -0700 (PDT)
Message-ID: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
Date: Mon, 2 Sep 2024 18:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20240902
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

A simple set of changes to allow using the bootrom NAND pages, ported from Linux.

Thanks,
Neil

The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb4074:

   Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-08-24 14:03:28 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20240902

for you to fetch changes up to 35ff967a99e97b523732096628bdbc78758922f6:

   mtd: rawnand: meson: read/write access for boot ROM pages (2024-08-28 16:05:45 +0200)

----------------------------------------------------------------
- meson_nand: R/W support for pages used by boot ROM

----------------------------------------------------------------
Arseniy Krasnov (3):
       mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
       mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
       mtd: rawnand: meson: read/write access for boot ROM pages

  drivers/mtd/nand/raw/meson_nand.c | 84 ++++++++++++++++++++++++++-------------
  drivers/mtd/nand/raw/nand_base.c  |  3 ++
  include/linux/mtd/rawnand.h       |  5 +++
  3 files changed, 65 insertions(+), 27 deletions(-)
