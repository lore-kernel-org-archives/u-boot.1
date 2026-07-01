Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB85CC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4E284B74;
	Wed,  1 Jul 2026 11:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yI2ZJKzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A96884B7E; Wed,  1 Jul 2026 11:54:15 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D443584B72
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-471eee9b7d5so99760f8f.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782899652; x=1783504452; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nq+ae0pJ7MN9ahenFlWw3sWP6JtIgMgFpfGHb0Z5koA=;
 b=yI2ZJKzZjjK9CCjF2SplklBddGAnNo+EM0BtDdR7qrmj1JFRN7YTNKdo5BCHjrN48B
 v3XER3A2eKaLsKrSDGiTctPhKeA6sIhDnOKjD7zBp7dKpPq3fuuuZJGe93vGeZyw3VQV
 R5do/KMiWFV6S5OlXE/W6Mv3zOgkxPGfnkiJz3czqMoir3WXeHU6Vh4EvbpS3WIwPNBY
 dtoz8pRUFYO6IUcoSdoQaxr3tN4t0vBVwLHBQ5j+7QpetSD+p6FsLJ+ol12UaK2EBgbz
 8XANrir81U8KKQJ4zEYHgA9oO5TYv2dIL+CadBTe1vqa3keiAsyT2KUNWOP4Kj+8gOgE
 n1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899652; x=1783504452;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nq+ae0pJ7MN9ahenFlWw3sWP6JtIgMgFpfGHb0Z5koA=;
 b=OKHVODzE1gYvmm06WZ8UhZwN71/gZ/tcqhN7gJff+vO8vwvAICJS1TzOSk5GTH/fNN
 62W7arcdTqTZ46Grgt6REaFhAqIR/AwGrMxcsTtvifx9qHR95nrwG4WNDIk7yhlRs8BL
 K6RQfVcxRIapoKXkJOY3YcVBxr4cByO8Mh9kvDFlYbpMdAZhLuljGpZjgHkqGMl3UK+G
 wVJcVDuuYBrefh66DRQa2v5eudv0Iwe8bAqPENyaoQT68wPdcxWWJoE1M8SEQTGN1a3+
 c1y8JGaqQ9f92tiwjUz3ewvE6J/OO/bzvH1VXkordRY/r6PgNAoT9XzewpExcfIv9mGM
 Rjvg==
X-Gm-Message-State: AOJu0Yw6Go23uXOeIXkQ41YS08hFRVIVUx9y9DnFwSCr2gKMNKmosiCj
 zXzDRWLRz+drDpiFAOoOQIKgV2YPMvpleDO60+6LiXUuI9HifKBmtg2ZuNJnyLnWBaoAQIwaWZw
 Rhpvy
X-Gm-Gg: AfdE7cnwYTgc+isR7ck3qtyP+82MsbdxPVoJkpPss9LYWWv5gKfMzW5AwB6lMz0snp4
 puOkT8r0xjKDPrbj13Q0ANrZEpFaFYhZNCGfHyKol631PwdD0Vkoglu5WvIGRFUqL/MJYWLSFNa
 xBagLi+XJiqeLyM5YJJp/+e/7lo+aMTsF9g5JdgKQBQ4Y7IV26fY8LYY0EwCH5GWwv2bQeojfHu
 F/xQ7/ZWxnQV0Avwxu4LC0SFOTl212RHZnK63w0zCxtEJW5QY06u3Ov9lIbb6nqjHUqFDqjUNb5
 EPBfDcQOw3LWZmXZ7RlEtAxuW1QOvnzDKXwn8ErtPLo1wyHWa5hlgN7B60orW0YKWNACsXO1rKc
 MNka8ZLCm/RRKsJc6N86ryTgbO6lvYqvqpOXzzzM1PZQDDArnOfai740mMxYAmbGanrK7/Tv3qs
 g0o9Zr/NADFMWEJx9LYNFCrIeZdBfWawxeCIB6h8RJ7TY0yKJj8/vbpUSouCBNR6a2+MZg
X-Received: by 2002:a05:6000:220b:b0:473:975c:4fc7 with SMTP id
 ffacd0b85a97d-4775928680emr1504807f8f.27.1782899652082; 
 Wed, 01 Jul 2026 02:54:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:f765:66fd:83bc:9e66?
 ([2a01:e0a:106d:1080:f765:66fd:83bc:9e66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4542sm16599413f8f.10.2026.07.01.02.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 02:54:11 -0700 (PDT)
Message-ID: <ffd467e0-491a-458c-91c7-7d2a6403083b@linaro.org>
Date: Wed, 1 Jul 2026 11:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-pci-next-20260701
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
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

This my first PCI next PR, updating MAINTAINERS and switching to dev_read/dev_remap APIs.

Thanks,
Neil

The following changes since commit 5602e89a834ccbedc686053b14206c062a144107:

   rockchip: sdram: Fix initialization of DRAM banks (2026-06-30 13:38:12 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-pci-next-20260701

for you to fetch changes up to 57abbbcc945079404ba8e3d4a68c991e3cd92a65:

   pci: layerscape: ep: Use dev APIs (2026-07-01 11:42:52 +0200)

----------------------------------------------------------------
- Add myself as PCI core maintainer
- Use dev_read/dev_remap APIs

----------------------------------------------------------------
Neil Armstrong (1):
       MAINTAINERS: Add myself as core PCI maintainer

Peng Fan (5):
       pci: rcar: Use dev_read_addr_index()
       pci: mpc85xx: Simplfy code with dev_remap_addr()
       pci: dw_mvebu: Use dev_read_addr_x APIs
       pci: imx: Use dev_read_addr_index_ptr()
       pci: layerscape: ep: Use dev APIs

  MAINTAINERS                      | 10 ++++++++++
  drivers/pci/pci-rcar-gen2.c      |  7 ++++---
  drivers/pci/pci-rcar-gen3.c      |  5 +++--
  drivers/pci/pci_mpc85xx.c        | 11 ++++++-----
  drivers/pci/pcie_dw_mvebu.c      |  5 ++---
  drivers/pci/pcie_imx.c           |  4 ++--
  drivers/pci/pcie_layerscape.h    |  3 ++-
  drivers/pci/pcie_layerscape_ep.c | 24 +++++++-----------------
  8 files changed, 36 insertions(+), 33 deletions(-)
