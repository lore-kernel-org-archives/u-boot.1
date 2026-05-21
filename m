Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A95CD5BB1
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 14:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA8E8341A;
	Thu, 21 May 2026 16:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HO0T8zUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646868469F; Thu, 21 May 2026 16:02:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0F0805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso580591866b.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372169; x=1779976969; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76GLnNnwI7qH8SOHa4XfxxwJvU9IFrI2szyRnmSJHL4=;
 b=HO0T8zUgi+OSDWH11FatUWmOm8EmZcK1xAoq+jyTZbbJPEE0Lrtix1UqsA3f4lU5zQ
 9sta5j9ERTgDfnp/ELtCwql/ayrkeextnEfGR//hnxY8Ud1/pmLx7DuncoZDfbGlaIMl
 G+uwZTDna2pwTDcd1oAWFID1ZoYk0WzHiu+w8I43yKFE1H4VXzJvzgqfY8uqTsXZUK/W
 wFFveGKv9yVUzJyv785Nx3vFPL4wEDVUxrrAsoMipiKYk5dXUfx0QeDIanggkeOasfoY
 ulJ1VeILMNmivCtH0/og94KLiCzpkMQdavJTr5BrJzaKLfKD4coZ7G0MZeGWatJvJ5u6
 2e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372169; x=1779976969;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76GLnNnwI7qH8SOHa4XfxxwJvU9IFrI2szyRnmSJHL4=;
 b=jIsXtyw3lfeij2xfM3a7cPZCkTWlrOUrCW2HMDvMLS+bFOigunAUtHSyoqfZPpypSJ
 hoxepSnKLq2J7xYStTiKBb3sOhvULxsYtgo4WsLni4xx6dQaQofhbUiqXcfIcokWqJl2
 +V9fF6L6LEKQIF4KxgfzMno3rsu317SrboyQjvC+8a/MzU9/Nep3u2Q/KdIr6y2BhuV/
 ZsKdIjvoa4CBaokgk0J+oV1BOzSI1IyRAkzluMJzR80G20sqUUWnwCQBXno4zmg/kdl4
 H4/DKiUHR8ujCI9LMftV56arSWFDJXgptxkGkIB3x/ZlpgAdyO+Y1cA/Uo934aLfnhyl
 FumQ==
X-Gm-Message-State: AOJu0Yxsj+2asxoI3SwrCWwECbuj0jkGEB0SfFGcTPah0ltKZZYOM7LI
 QVOUhoQ5UAwo3qYQqBBdXVPDLh67JyjezQhJuj/hZvueYnimBAyjYn34ELsx9grAlfr2fIkuA3d
 dVV5k
X-Gm-Gg: Acq92OE0AKRHBqlA5if63ttN7MBa9cwkbzvf02PcTT0YwKQbuxfCeT/pfAs1b6dWBvK
 aqHNvFGOSj9PQlTV27ZDY2gceRBr0sUzbG1d6Zd1aRe4Ga0kriKh9DwBu1+vuqjC7lGkAaQW8O1
 YZCLxU1usHuuIfCCtMrfnHe1D64cDQn/SI77AMEBZf0MyKUuYXofvgZHeSgk8GMcCBuEnxHrug8
 CXlIiHJPnSo9172uNOhawmwhhbUM1OCZsWkVshDjH3HOmANfw38uVzAVQ9lyfU05e+odioOJLRF
 l46DX+vJKfTrHNDusplHY0jgS8haPWAhOYkQU5fxfIufeLX17y8FUU4mf8X9rOgXHghhWQAnYcC
 yW7+vijQ+9CXOMm8QFzzzlaifh/Dz9XCWH3NUaZnlYIA4t+0RpIvlUk30FQ5cSlyXVu/yf5w/ys
 gyMbsXf4ew5H43u7dAU6S57Ca5xvvfD6dLLzOLeiLN5i4aZwHhEEt/XIQKRD2GtmE62fRkal/Ih
 aPl/N8=
X-Received: by 2002:a17:907:86a4:b0:bd3:67be:b223 with SMTP id
 a640c23a62f3a-bdc17041ed7mr166292866b.44.1779372169040; 
 Thu, 21 May 2026 07:02:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7e6c:bb76:ade5:7e8b?
 ([2a01:e0a:106d:1080:7e6c:bb76:ade5:7e8b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92dbfdsm3047929f8f.18.2026.05.21.07.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 07:02:48 -0700 (PDT)
Message-ID: <764624ba-30c0-46fa-a6c3-4f2cf4b17bd5@linaro.org>
Date: Thu, 21 May 2026 16:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-nvme-fixes-20260521
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

This my first NVMe fixes PR, including a couple core fixes and a fix for
the apple NVMe driver.

Thanks,
Neil

The following changes since commit 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a:

   Merge tag 'efi-2026-07-rc3' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-05-18 09:12:11 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-nvme-fixes-20260521

for you to fetch changes up to 4f510505988928e129e109811587c4a00d28ec56:

   nvme: Fix PRP list pointer arithmetic for chained transfers (2026-05-20 09:51:44 +0200)

----------------------------------------------------------------
- Add myself as Maintainer of NVMe
- fix command ID wraparound handling
- apple: Check memalign return value
- Staticize and constify driver ops
- Fix PRP list pointer arithmetic for chained transfers

----------------------------------------------------------------
Francois Berder (1):
       nvme: apple: Check memalign return value

Marek Vasut (1):
       nvme: Staticize and constify driver ops

Neil Armstrong (1):
       MAINTAINERS: Add myself to the list of NVMe maintainers

Prashant Kamble (2):
       nvme: fix command ID wraparound handling
       nvme: Fix PRP list pointer arithmetic for chained transfers

  MAINTAINERS                | 1 +
  drivers/nvme/nvme-uclass.c | 2 +-
  drivers/nvme/nvme.c        | 7 +++++--
  drivers/nvme/nvme_apple.c  | 3 +++
  4 files changed, 10 insertions(+), 3 deletions(-)
