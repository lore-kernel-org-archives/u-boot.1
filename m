Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60BC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 09:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC5782991;
	Mon, 20 Jul 2026 11:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a4qer5AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C98F838D7; Mon, 20 Jul 2026 11:33:06 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410B280517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49557167508so13964615e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784539984; x=1785144784; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OB2FXj2dpVippsXCFxRJlymSrKOUqZ7anW/x6wFSg2U=;
 b=a4qer5AVCs/hVPtoyNkXYKqum0M9z31OX8NGo1kfhBeP+1zBgqXuNZgISrA0JDER60
 RE2fv2/dn/uqrUEP/WyeYQxMk9xscOOPDd89jbij/qx1MnhVBNuF8MGmao542mMpyvu7
 T0sdaVQo22Ucc9s0L+5T689wI0N95rGwCVxAZIwiFYXFM0+YtJXgkx4n4gEK7M45fBj7
 ske8aVie6LkLwMN3ysKK5uDr0WCmgFYVcBBKdOwhUszdkW+YjxVXfbul2FmA1/fOJ0ms
 eE8ckCQ8k1ZZ8kto9d9rXONhYXhOjw8E7mMTY6yoIIKNK50OXkww9lLfVZi//yIzNN1h
 G4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539984; x=1785144784;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OB2FXj2dpVippsXCFxRJlymSrKOUqZ7anW/x6wFSg2U=;
 b=VI3d3qFCp4UYIWLtUND+jo5Px2r9NJxsMraDu0SKI71Qf71O0N0rqmLWJJaBu7Qi/a
 3imWdrh2XIZvl1v/t/3EGCKFADkVjio5L+KH+i6WkywB4xKEyniUuS2CUMHABUSTsc+x
 xKsxyhbrfxMssVl81wBjRZCltgHsRsvPJhRxjJZ78POEMo2AyXZYP5ta2dhFeWYqSar6
 Xqut75v1vtofP3Yy5XuOHnxxzwlzycUtBytzmrWpakkEq6FG6nLIx06hqWc39AZcyFa5
 7nBIh/Zd/yh9mbw5D/F2lAtQ/t0qX1HZhWR3yN8k3XO4gqf+SnF3eVv+0OFcAgo+7C3h
 fZow==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHvpGlcmc5lhzFsOpHpG5QMsdwuXfVu+M5yZDCM7X0GoYvZIcqhxYLyusqXqmn4UvaN645XVM=@lists.denx.de
X-Gm-Message-State: AOJu0YxnxnbbE9SPpjy6MdQ3T1wWQidPT2c6jDJD4bWA89OyOideesDU
 mE+QEvo5nEYDrFNGu46OY0XJLo1Lyt8BLIGAUrEia+B8CHpU14h0IqNx6NAw/3aLNjQ=
X-Gm-Gg: AfdE7cl5IwpCO/Gy9+Efb1rNppJ30RLD4nFVuv9fRnag+m+EzICCBqCaKKqX/A4RcUI
 zl0d03m/2BPXdjSbHZkjWhv0HjVv+TBwG4SXGJO7H8D2TrymoC3R21TWfGUw18g+89Tuz1/jUMT
 ov0hWGQl/d2/9i0qx8tZz0DVJ/kMrvOy0mqpd9VxkS9GhM6bpYGi8FUlPOcgYPNGxQrKKXjgIvj
 JhqAIQZL0HvJSaXau8+WeDlkBNtQBMaLovZISvmexsQC6apUiEGsrMGCuWN6MnVJV7A8K/Bzg/e
 7BaHa8wXI8VbaXLX9uf56M0ecALEwqaDbcpYJVwTlHH9baEXm8bk8nqM+sVV2xrHm/j7OPSVHZx
 6pcdG6WtObVQDgXR8/DguLulqrrZINIpkkM1LcB1cjwyu/KtA977U7r5GJRrz4pZOFeVQcfJ9cA
 V50ab0EbzEszL41KprrbQho3APO/QB9NCQmUvbXwQTGwSjNn0R1bC5QTuNlA==
X-Received: by 2002:a05:600c:1987:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-49552a58960mr105598315e9.11.1784539983435; 
 Mon, 20 Jul 2026 02:33:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6048:6804:bc89:a6b1?
 ([2a01:e0a:106d:1080:6048:6804:bc89:a6b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm276387055e9.3.2026.07.20.02.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:33:03 -0700 (PDT)
Message-ID: <c4cfbd8e-e596-471a-bcce-40147be5ab20@linaro.org>
Date: Mon, 20 Jul 2026 11:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/7] few fixes for NVMe and block devices
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: seanga2@gmail.com, sjg@chromium.org, trini@konsulko.com
References: <20260716223401.378989-1-dmukhin@ford.com>
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
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
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

Hi,

On 7/17/26 00:33, dmukhin@ford.com wrote:
> The series adds few fixes for NVMe subsystem and block device management.
> 
> Patch 1 adds FUA support for NVMe devices (original effort in [1]).
> Patch 2 adds plumbing for blk_flush()/blk_dflush().
> Patch 3 introduces NVMe flush command.
> Patch 4 enables `flush` subcommand to all the block-uclass front-end
>          commands (ide, nvme, pvblock, sata, scsi, usb, virtio) in one go.
> Patch 5 makes nvme_shutdown() symbol public to enable use of it from
>          board_quiesce_devices()
> Patch 6 tiny fixup for QEMU command for manual NVMe tests.
> Patch 7 updates tests for flushing block devices.

Thanks for updating, but now you enable FUA, why do you still add the
flush infrastructure ?

With FUA enabled, calling flush command would be a no-op.

Neil

> 
> [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
> [2] Link to v2: https://lore.kernel.org/u-boot/20260529034441.2075305-1-dmukhin@ford.com/
> [3] Link to CI: https://github.com/u-boot/u-boot/pull/995
> 
> Denis Mukhin (7):
>    drivers: nvme: Enable Force Unit Access (FUA)
>    drivers: block: Introduce blk_flush()/blk_dflush()
>    drivers: nvme: Implement flush command
>    cmd: Add flush support for all blk devices
>    drivers: nvme: Export nvme_shutdown()
>    docs: nvme: Update QEMU command for testing
>    tests: add blk_dflush() coverage
> 
>   arch/sandbox/cpu/os.c             |  5 ++++
>   cmd/blk_common.c                  | 17 +++++++++++++
>   cmd/blkmap.c                      |  2 ++
>   cmd/ide.c                         |  1 +
>   cmd/nvme.c                        |  1 +
>   cmd/pvblock.c                     |  1 +
>   cmd/sata.c                        |  1 +
>   cmd/scsi.c                        |  1 +
>   cmd/usb.c                         |  1 +
>   cmd/virtio.c                      |  1 +
>   disk/disk-uclass.c                |  6 +++++
>   doc/develop/driver-model/nvme.rst |  2 +-
>   drivers/block/blk-uclass.c        | 15 +++++++++++
>   drivers/block/sandbox.c           |  9 +++++++
>   drivers/nvme/nvme.c               | 42 +++++++++++++++++++++++++++++++
>   drivers/nvme/nvme.h               | 12 ++++-----
>   drivers/nvme/nvme_apple.c         |  1 +
>   include/blk.h                     | 26 +++++++++++++++++++
>   include/nvme.h                    | 11 ++++++++
>   include/os.h                      |  8 ++++++
>   include/part.h                    |  8 ++++++
>   test/dm/host.c                    |  2 ++
>   test/dm/mmc.c                     |  2 ++
>   23 files changed, 167 insertions(+), 8 deletions(-)
> 

