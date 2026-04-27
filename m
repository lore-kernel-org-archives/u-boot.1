Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8061FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1D083693;
	Mon, 27 Apr 2026 09:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pn3Z64sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F3483693; Mon, 27 Apr 2026 09:53:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A120480433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso138271905e9.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276433; x=1777881233; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBdzZxS33oTsi3JXiSoA1A8tpFKlShXs59Ic8lkNYfo=;
 b=pn3Z64sB/vBEel5sswf3N5YufGjoDXOqDFIajjI3kTzylzOdo+kMX6gA/43eSh7wlP
 +0Nou64l0VGNok9Uoo/8fj5sPjfB0HOVOD73Xq5d5q6w1Z98KZ5/FUTqMQEFWUNxltk+
 wLWITWLzQIOV7KNMecdULT0v2uOPoRPOG4S8fZoWs++816t59kVPJZj5dzB5/pKHiZfk
 4RV7gxjFW/5BMyqmHuRwLyJdZLihwrnl4yDYKH7SZoDxRBOJicvCSVjMa+Jn8DYTU1EB
 zd1de7XMTiqJ+kLiqSTk7vYdVzLcAtRvLXuRkm/QnqfcG3gLbjnwt1Ts26RN0YRUr1s+
 cGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276433; x=1777881233;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBdzZxS33oTsi3JXiSoA1A8tpFKlShXs59Ic8lkNYfo=;
 b=Kkwltji+sHXycK1L2c53ty92roseb3ugUUHAyd/IKvK5+nzdmlQPgCc+TYbBcCAFiy
 OQbCZOO8JlefY6r59zZqqKrX3v97JFt9aGzw2ys/ktbnGhPYHmBDvL24E9XbMIzRqmDR
 4g1MP/pwPOUGDGNczIlP01uYxMSPdGPvJRqLyMC5hvRk/KFIIEtFm/7AVCmqwHPYmsii
 oDBEmAWFNv46tEE2QX9WgNoqWOIKxnAb4yfmvp+Z0JM9GdlekMsARmeX8sMVHgBi+Wvt
 ZHGev9kGx61OTpyn2K0G/SDa2dm3IncUSJrqA8wvKaVHAAZho/2gPlZGkG2Hwbvgo+Pf
 cZSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dXgryDqEyqTTIXAOmpp8yDa62pALiQmf6/NC3sajxErLy4FKuWlPImNrFFzq0G7kC9XGxb2A=@lists.denx.de
X-Gm-Message-State: AOJu0YyfEFQsFoNImoRkZeJSXcJE7OCiZ5ArUDRHbWNm4RZAFP+BdDbT
 DwNdR5OA+e+DbfN8OgrWdeCsTop/Iw4a2rvMeA1y0yKJ42pOstBWl3S/5yVI7AC3G0M=
X-Gm-Gg: AeBDietM1mEQf8rDK2waP4YWU8CbpNzM8AbuyJ/BuPDMmVuJzWppjJnPfVz+Akcqjwp
 X39NuUgnOljtzQqBwcCF4wE63oPVRtHCMqHe0+6WElV0kSbOyh1tMmY11Y24OOd2p4WRkb4YKrf
 8o5wMmE4RVrrYqSKJnO2xTU6MnyjiqP+WwMXCsLAKT/n3b6+5zNguSaTqB+xnAHXFluFOBqO4W4
 y25ac5QAepVBbAOUsabEPZmlFV4hE4hy2M9DFZ++alU0x2fG+PX0zXVfA1tqnmyBK/Uvtme/cr/
 aONlqZAs6iNcEQawu3b5h749DVUwTDwfOS26K1K72mOszbWxSsdbm6a2xdQP96IewihDcIfvkEJ
 AkKZoJ6BTKN1O/i3r3WbVqRLVN6rPtEtiI+lhxw+G4ZVLU87OmwS8DdP5o/bLgYutZsV4h/FzkD
 Qbc6Fy9r0vsk8bC33jIfCnxl5jQb41Ndz+Q1wYf+H+Q89kuHCBdh4SmRooy0+tVYLctCZ73Z1se
 MeHmPULDjx2d9LVsTyoRuyvioZ3
X-Received: by 2002:a05:600c:3053:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a53ea1526mr236261285e9.28.1777276432550; 
 Mon, 27 Apr 2026 00:53:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440?
 ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a682588f8sm162693215e9.10.2026.04.27.00.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:53:52 -0700 (PDT)
Message-ID: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
Date: Mon, 27 Apr 2026 09:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20260427
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

Here's a short set of Amlogic changes, first fixing MMC init when switched
to Linux 7.0 DT, and adding support for EFI capsule on disk on Libre Computer
boards.

Thanks,
Neil

The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:

   Merge patch series "Linux compat improvements and CCF prep" (2026-04-21 11:21:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20260427

for you to fetch changes up to e07cc9e7fdcc35780f539ee1d452ffd3da0fbd1f:

   configs: libretech-cc_defconfig: enable EFI Capsule on Disk (2026-04-22 18:27:26 +0200)

----------------------------------------------------------------
- enable EFI Capsule on Disk (+ sysreset fixup/cleanup)
- do not fail when setting SD_EMMC_x_CLK0 on GX/G12

----------------------------------------------------------------
Ferass El Hafidi (4):
       arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
       arm: meson: enable SYSRESET_PSCI
       configs: libretech-ac_defconfig: enable EFI Capsule on Disk
       configs: libretech-cc_defconfig: enable EFI Capsule on Disk

Neil Armstrong (1):
       clk: meson: do not fail when setting SD_EMMC_x_CLK0

  arch/arm/mach-meson/Kconfig        | 2 ++
  arch/arm/mach-meson/board-common.c | 6 ++----
  configs/libretech-ac_defconfig     | 1 +
  configs/libretech-cc_defconfig     | 4 ++++
  drivers/clk/meson/g12a.c           | 5 +++++
  drivers/clk/meson/gxbb.c           | 5 +++++
  6 files changed, 19 insertions(+), 4 deletions(-)
