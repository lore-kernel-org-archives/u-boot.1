Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DB3C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5AE830E4;
	Mon, 21 Jul 2025 13:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZYVzRDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B630830EA; Mon, 21 Jul 2025 13:04:23 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09ECA8309A
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso43750105e9.3
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753095860; x=1753700660; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W8Jm8NmvSBdXJIzEX8gUh66o3zwq3KuE0HNfOYTqEk0=;
 b=dZYVzRDHcQUoZexd2DlXO4xe3A9/0QPqa67LkKVsyloWllySthGi4K+eVb6+x5ILW+
 SOTowXEYMf/W6uG1N312hrX02mNn+XP0WKPCPxKIng2YLFgr2PgfYbBULVYxQ9wA54f3
 eheeqXQxF4bPuY46klUsmfqX2yP1cWVD4UnnJAEpxLyjm6hiJrfLxqcK4mLEY0uPEhoM
 Cy0Bg8bevL8MmB6lcnv2Ch4WXgX/A+bkCU4gP7Cplte71G4yVnt3cOT7Kp4VSjL0KIz6
 l0pGuPDu/kO8kz0EL+sXAkkJvLBN8WGcIMFs696rDcorQS9eR+U53q7O0YC4q9pRab+s
 nTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753095860; x=1753700660;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W8Jm8NmvSBdXJIzEX8gUh66o3zwq3KuE0HNfOYTqEk0=;
 b=c3qTOJv76MMJ592l32p84Bgk/MgexNTlbQWZD0oZv1hgFZBcn2p8HdFu6+RA8EIubb
 YfSnVaXcSx8ch1asp/x8DuyQuK60j6zYBtIqbo/pmfRE4JIVdtkjNmJhsvIwq8hGLwdu
 skj0khTinb1wfcI7wpfecENCQUbb+cc8Gamj9B0s471NN+2674Nz2cOraYD1Z/KK/F/m
 Mf6CWJbqfCttIdFLH8ivH4C+MTnI+bHUnfi62+pf00JxOQPv6P5BxO0ODqqTcBtm0Q44
 pWG5vywNBt0ErAip6UQoC9/Q3NNbbhwYczK6+x/j38svFABQs/lwBTMIVJOLw8e6WZsk
 LDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfFnGj6WokBDD9yA2och4Ymamz+6zQd7p+dSs3BJTFd1NjPmrqdAxynsb0Md/I6V9KYHtx8f0=@lists.denx.de
X-Gm-Message-State: AOJu0YxGp2oQ91vx7l3L0dksYz5fLZ445LKHty/MH3ivkaGDBW0JePw7
 OR1Yd55edc2vB7CAp89ls+F6OOvFADXhSi7qaJEvduM6deGDpl0/arIyIIDSev+k0ec=
X-Gm-Gg: ASbGncsSjKSumLqYtb0eHwdF5VSi+yTPp3C8/pwHkklWMDrVJCbQDR1Vt16fCrirNgI
 DqGGn3VUNVQFrMfd/ASDmEyLEUnwEPWZ7CA2YNEVz812wccKaZ1rfVp/bsVGdQ1WytnTyaPjs2+
 UyJQApongQXvd+XCri6/7y0dMkqAxO14RJJKd1zbBKPZqYQO2cNb+26AuW/WQG2xpXhpvE/QMtj
 cMsdAFs/6IjclpllJ2ZL7V2a9LNueqFKsIjLKTAtl7nRi8TZJoMmFez9lDMU2I+mZkFUOi6Imgj
 ixMeVgJrz8zdi3ReDJ9U8FGrKczpDlCYN2hg2gQNWcJ0ehALuhyeZmSe+anozPf0yZQ/lp+9Ok6
 Ivi+Mg5jeeuGQzUwxutMgzvJxZk1ucAMytYVEl524JsMhSBb4CFe0mSfEGv21pgdA6oAdZ5x319
 M=
X-Google-Smtp-Source: AGHT+IHj7kbE7XmrkeIfi1wv+vYboIw4ESzTNe063JNmkbeS048BGx7ugVuJmzV8bKuVr9W1jxuO0A==
X-Received: by 2002:a5d:5f86:0:b0:3a4:f7e6:2b29 with SMTP id
 ffacd0b85a97d-3b60dd4aa83mr15599006f8f.5.1753095860340; 
 Mon, 21 Jul 2025 04:04:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2cc06sm10072647f8f.35.2025.07.21.04.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 04:04:20 -0700 (PDT)
Message-ID: <1154f736-14b0-4225-9230-9d93178274eb@linaro.org>
Date: Mon, 21 Jul 2025 13:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v6 1/3] fastboot: blk: introduce fastboot block
 flashing support
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
 <20250630-topic-fastboot-blk-v6-1-7cdfd3a24786@linaro.org>
 <20250702045934.15bc47ab@karo-electronics.de>
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
In-Reply-To: <20250702045934.15bc47ab@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 02/07/2025 04:59, Lothar Waßmann wrote:
> Hi,
> 
> On Mon, 30 Jun 2025 17:19:57 +0200 Neil Armstrong wrote:
>> From: Dmitrii Merkurev <dimorinny@google.com>
>>
>> Introduce fastboot block flashing functions and helpers
>> to be shared with the MMC implementation.
>>
>> The write logic comes from the mmc implementation, while
>> the partition lookup is much simpler and could be extended.
>>
>> For the erase logic, allmost no block drivers exposes the
>> erase operation, except mmc & virtio, so in order to allow
>> erasiong any partition a soft-erase logic has been added
>> to write zero-ed buffers in a loop.
>>
>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/fastboot/fb_block.c | 323 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/fb_block.h          | 105 ++++++++++++++
>>   2 files changed, 428 insertions(+)
>>
>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b725397c91af2717812e69e2b624076eb30f781d
>> --- /dev/null
>> +++ b/drivers/fastboot/fb_block.c
>> @@ -0,0 +1,323 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 The Android Open Source Project
>> + */
>> +
>> +#include <blk.h>
>> +#include <div64.h>
>> +#include <fastboot-internal.h>
>> +#include <fastboot.h>
>> +#include <fb_block.h>
>> +#include <image-sparse.h>
>> +#include <part.h>
>> +#include <malloc.h>
>>
> The alphabet seems to be a difficult concept for programmers to
> grasp... ;-)

...

> 
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
>> + *
>> + * in the ERASE case we can have much larger buffer size since
>> + * we're not transferring an actual buffer
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at once
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
>> +
> Why invent an arbitrary number here, when there is already
> CONFIG_FASTBOOT_BUF_SIZE which could be used for this purpose?

Those are completely different purposes, this define is related to the
image-sparse.h FASTBOOT_MAX_BLK_WRITE, but for a generic block write.

Note this is an initial implementation, any optimization could be done later.

> 
>> +struct fb_block_sparse {
>> +	struct blk_desc	*dev_desc;
>> +};
>> +
>> +/* Write 0s instead of using erase operation, inefficient but functional */
>> +static lbaint_t fb_block_soft_erase(struct blk_desc *block_dev, lbaint_t blk,
>> +				    lbaint_t cur_blkcnt, lbaint_t erase_buf_blks,
>> +				    void *erase_buffer)
>> +{
>> +	lbaint_t blks_written = 0;
>> +	int j;
>>
> lbaint_t to match the type of cur_blkcnt and prevent integer overflow
> on 32bit systems!

Ack, will fix

> 
>> +
>> +	memset(erase_buffer, 0, erase_buf_blks * block_dev->blksz);
>> +
>> +	for (j = 0; j < cur_blkcnt; j += erase_buf_blks) {
>> +		lbaint_t remain = min_t(lbaint_t, cur_blkcnt - j,
>> +				erase_buf_blks);
>> +
> No need for min_t() here (see above).

Ok

> 
>> +		blks_written += blk_dwrite(block_dev, blk + j,
>> +				remain, erase_buffer);
>> +		printf(".");
>> +	}
>> +
>> +	return blks_written;
>> +}
>> +
>> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t start,
>> +			       lbaint_t blkcnt, const void *buffer)
>> +{
>> +	lbaint_t blk = start;
>> +	lbaint_t blks_written = 0;
>> +	lbaint_t cur_blkcnt = 0;
>>
> useless initialization of cur_blkcnt; definition could be moved inside
> the for loop.

OK

>> +	lbaint_t blks = 0;
>> +	void *erase_buf = NULL;
>> +	int erase_buf_blks = 0;
>> +	int step = buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_ERASE;
>> +	int i;
>>
> lbaint_t for 'step' an 'i' to match the type of blkcnt!

Indeed

> 
>> +
>> +	for (i = 0; i < blkcnt; i += step) {
>> +		cur_blkcnt = min((int)blkcnt - i, step);
>>
> No type cast needed.

OK will fix those.

Thank,
Neil


> 
> Lothar Waßmann

