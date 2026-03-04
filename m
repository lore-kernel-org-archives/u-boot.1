Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2189DEFCE37
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 20:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E85A838BB;
	Wed,  4 Mar 2026 21:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QyQAqZdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0C183AA9; Wed,  4 Mar 2026 21:15:10 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D607483642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 21:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-660be63279bso2697681a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772655307; x=1773260107; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AtHyk90PFkVRS5Cm1VJyL2cjGcCEZ5vB3rOJGv6KRY=;
 b=QyQAqZdQy7y2vUE53pEShOfKZdEZOpLa/83NDmU2mIwnqKpF0Hbxxuu41ADum8g2rw
 LKlEJDtnH7KQcAPqb9XsBhXC9JURsHZlXwnN3NEQBwuH6jaSkse8kw5cLi7C1ZPCm6C9
 n6tmnGHK2l8sNgApmI8BsWwFC7GPW9vkEeu1o+fz0b9pcOtM2a15o0jxzU91G/srrfO9
 8q6PeKRMTSc1Itg8NWbrw6vCa197n+CcnD6tsnUnAWkxHEZfPUQaRufW1q2B2aOCKiTH
 umVlsn5v+gna53hF4Cm5nByzQbOwFLco1z9shzVlKehwFc7Kd5un5R+ry0FaFhzdnnJo
 jqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772655307; x=1773260107;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0AtHyk90PFkVRS5Cm1VJyL2cjGcCEZ5vB3rOJGv6KRY=;
 b=OmLWWk7x0IOSVvH4JjGqWLO9N+AFgL8uBnq69l1e7x+w50pejLgl2qrMO7mW70H15i
 MwsuG1aDjOVmiuJRpeFEDYNq9efZBbPgTlbUKbLdfNaTtxzNgB/29NRSVwat11vZ6hWx
 E5axhPLkzTa6fSnHqI3BNuMhvGxiDJIhBcwkfTTuHUDSSB2rhDK2DftP4iymiCuDuZ+/
 4oAOeEFHjLSB0yI3RMU9U4LJjli+koMTHd1+j00fY8mzgNBLkQQXMUQiKC5vlnjIcQh3
 bZqHy2iLBkpBcVx56UaUknw4PqFOoGEb9XZwdvkzgeVcV8suXoMZvGJi4YQ8/rO0k2ys
 GvCg==
X-Gm-Message-State: AOJu0Yzxzem3xuITYhQy42nDKCot4TRZOggecY2KsuV0Dfx4corhTAZG
 Nv6lRMNhtwN6BPePmHiTgZLLzrAQiHi9GbcXpcvjPzrWSN23tERrYadYLN8gvxXZNeo=
X-Gm-Gg: ATEYQzwW82tXyMDzMwFDED116ajg9p/A9JPDXqbyps4zKuqsajXMwpB6jp7kGSucMtB
 ZoPR64D7KVu5GSzANDd40GZj3utK0k12rs4U/ixALiT+M0v0WktfS+GvfDzyVJq4fazYbDeV3vu
 S65Ze85PpWBfXWeWJmDg3S/12aA0fqtN/5poiMu/4ymOgCT45cMfkIoAyrk2qv+D112gGFy5Hg3
 MjzFYhGCxvt8Mzcw3gKWoKovFJYQgqkYsdPTjKeftQ13n3d1LQMX4frTgDroD/W9gi+nQrKfZTl
 vfnx5Rs0/eiVGWkK/vtTz4TIbF8AtTC/4F4kdWTn6HtGxOJrrZsaLfZMFWwceWJlWvpRZU1cfp4
 v4Pw9ojBfbWqnjR1gch9Kz8FaFnSE1Q/HyawugWOlKBdeWxh/oRtkGKPME7BwzRiBj+LesQMgG+
 MJ9USm4kofjgFC/xmGTFaegxRjpZjYOD6SdVCK9Fe36DqjuM8KzmELDkwZSfYzWNrrqziT0Sw/Z
 Ona
X-Received: by 2002:a17:907:970c:b0:b8f:de69:b597 with SMTP id
 a640c23a62f3a-b93ef784a49mr242995866b.7.1772655307108; 
 Wed, 04 Mar 2026 12:15:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:73bc:1eca:d39e:509?
 ([2a01:e0a:106d:1080:73bc:1eca:d39e:509])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b93c8e3d060sm321786566b.56.2026.03.04.12.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 12:15:06 -0800 (PST)
Message-ID: <88393bb3-c241-4be9-8268-1ccd047ba1c9@linaro.org>
Date: Wed, 4 Mar 2026 21:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-20260304
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

This is a (very) late PR for master with a few UFS fixes and changes.

Thanks,
Neil

The following changes since commit 437ea9f8be5afaebe2d8cbab6242f1182857f21e:

   Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab (2026-02-26 09:06:33 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20260304

for you to fetch changes up to 47905f28468e3524cb5f775f52928cdcc568815a:

   drivers: ufs: remove unused ufs_post_bind() declaration (2026-03-02 15:20:02 +0100)

----------------------------------------------------------------
A few fixes/missing changes for UFS:
- remove unused ufs_post_bind() declaration
- Disable UTP command timeout in slow mode
- Missing MediaTek UFS PHY Driver to be used with the UFS driver

----------------------------------------------------------------
Igor Belwon (1):
       phy: Add MediaTek UFS PHY Driver

Julien Stephan (1):
       drivers: ufs: remove unused ufs_post_bind() declaration

Padmarao Begari (1):
       ufs: Disable UTP command timeout in slow mode

  drivers/phy/Kconfig                 |  10 ++
  drivers/phy/Makefile                |   1 +
  drivers/phy/phy-mtk-ufs.c           | 190 ++++++++++++++++++++++++++++++++++++
  drivers/ufs/cdns-platform.c         |   1 -
  drivers/ufs/ufs-amd-versal2.c       |   1 -
  drivers/ufs/ufs-pci.c               |   1 -
  drivers/ufs/ufs-qcom.c              |   1 -
  drivers/ufs/ufs-renesas-rcar-gen5.c |   1 -
  drivers/ufs/ufs-renesas.c           |   1 -
  drivers/ufs/ufs-rockchip.c          |   1 -
  drivers/ufs/ufs-uclass.c            |  12 ++-
  drivers/ufs/ufshcd-dwc.c            |   1 -
  include/ufs.h                       |   9 --
  13 files changed, 208 insertions(+), 22 deletions(-)
  create mode 100644 drivers/phy/phy-mtk-ufs.c
