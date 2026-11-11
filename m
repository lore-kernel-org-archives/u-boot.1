Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C52606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NJL2Ufrr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jg3jRR46
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12B19812A0;
	Wed, 11 Nov 2026 08:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IB1oIyHMBhFi; Wed, 11 Nov 2026 08:14:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3506981277
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794384884;
	b=oWi2GvzsYBT+XWGNxJiny5z4vwMcXZw2qEW3SuqDOg29c81mnA0KxQJgjFGcUVPl8x9S
	 N680QTRG2zzWe+Z8+PR8UaMzFTzGg17n05BfymUcYC3Kcqg6v0guNtfaBRQX/Dg6iRXzs
	 qhc6P7sF6O2v8rFoB7hf56GscxDHqwHktft/RmMLnzzUySvI/NxE1kXIrsW0xL/wnC4pT
	 vh0n/1i2YtMV7TWEwLg39Rsvz+WMoPyIQpdQKxdJWGAr+GKrA6J3Mn2EpWgg/3ceRwA9c
	 4lSmarrFAvaP/yvp3aWhXMnyuZ2FwlozlUpwaee7L1fCzQLmGLqCmV83gt9YIoyiHKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794384884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=wLezFHTnNBTDeZNySwYb/Oi5Ie150kYiNQgWSyy3x4E=;
	b=aflLWMQ6Wga1K3JyYnAaV2FMZqvi8URih5QZl1CCxAEXR9O4vScQRpskZrDsnpvdd9PB
	 rAEWDDoUeykialNfi8WwRicQpi1O4rNzrgmSVPNoAFMu0NrqXSwJgXBGVc1oDinZuqcQ/
	 Ihu3Aho/aAGIn56q5iPwwNDxpSNb2SNmW15fO5/FIHBj3FZ79qMuSlHQkTXkzMESBRKRl
	 HTWaJOzde4UVx5lyM2NMARtjhEKhKsazZMIlColVgQU4sNnKBAFWueLxpBf3RNys4dvl1
	 +wGWDmi3tujQaJzZLHVm/jEODpE0YImVHqUPaS0j16VRiOxM+PNAIo6YN/Nvr/8E6Kw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794384884;
	bh=wLezFHTnNBTDeZNySwYb/Oi5Ie150kYiNQgWSyy3x4E=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NJL2UfrroCWrfgHszTm93eKPru6sW3d5+H0lspVwVJOSZavuv3z0AQoHc/aWIymkI
	 fbY6uq/vBMg33FgdJG/5v+kQtxlWkS4n5RF3HSHUlnNeyDHZCHAN7xK1vta5Jp76h5
	 VAYp9d5C57KDMX4Lfb/HJyFECh0EAWRUc6wEe2PnM0X9GGv+DWsIoU1SS5qElTwnjx
	 6RHKw70Ga2pOeLJh8R17AdWM6B2ufaLFwAmxgDsIy5EVD+/7/4f2kJPKo1pxomICwG
	 /X2SrYXmrWHa8V3IuGw38U4R3jQ3P6Fn//7WMFUoE6A/JJHT7QTRQHxLSB7H5sPdeg
	 SYqNGIjyIR/7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3506981277;
	Wed, 11 Nov 2026 08:14:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9241A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDABA40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_hKy_8VZq34 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C5A19400B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jg3jRR46
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5A19400B0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:14:41 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2229515f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794384879; x=1794989679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wLezFHTnNBTDeZNySwYb/Oi5Ie150kYiNQgWSyy3x4E=;
 b=jg3jRR46tWiKdtbs+f2XoETkGkNlA/cewmiTenK4vCHG/A7D4ARW8t5XarnyCTSOEH
 sNegnNPDWhvgo+R2PaX0L3jEZoEbSgTrWPoNmhNpVYiNu+NA3GQDjbH6Hcn7cK3AMokI
 gG8/eMaH8/tNo51WN4IvkC4kxhWSFHRuWP3gI35K56W9++LxbPciZOJ9Vlg936TGj5Qi
 nQbhj0sSNioAtk/9+WoCU6TjMWSvnvbr6cSk5pRj5bI51vNOmgEoKkc0+EwML9sUhA5A
 u2BmZJmD/1v7ygoV8v7rTZbGCDKyMHahSD4J9b422PfzsNwC2B2K5NxE0Tzg9HW1kb9M
 JAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384879; x=1794989679;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wLezFHTnNBTDeZNySwYb/Oi5Ie150kYiNQgWSyy3x4E=;
 b=v62XzX9gtyVUoGApM0/I0N1uw5guNrCfU3jJFEZy6IcXa73WjlJt8XmIsfPXjBqaKl
 4A7gcmfBweoUD1sgMX4KaWBN3UkfbGZRsn6R7ry5e8oBIuuWUmWJmLk5pa9AWOI1c07/
 xQJulnvpbDkyjDBlG3zXc5pFhVRnyH1gzeQlmqDglFG3uiH3tWLZSiHnmWhNMqA+S50C
 PPcUUF7fK63FT2CcCf1ErJjGF2V0l7VeCGp547VGa9yyrUyobExeCOW611o+N/Ocs3xW
 voEIkIlAiBfRt6VGzX97DmXjNweeU8Kk8T6upZlmKP1+4vLhwkzDK0eXvnzPiDhyHCwC
 B8YQ==
X-Gm-Message-State: APuU4Z8KpeB1RV1W6zkJ7RZuHFj+wcO4BtdV+ckiLOtSHuVZyPM40OWb
 TTnmMAy2w07/4VRFCKLx4sO+BBk0oRQJev1WDqujdV47yheWmpjoU8rlGhXkyovGsYk=
X-Gm-Gg: AYBFou1yKmLrnwkt2u1yjS/v7prqCHC4+G3K1sOSIx+4DeVo6wu3SZdN4W5Y7ibg4lR
 kN/qla2ehw8qa7jwpUbASHBCZdgwE/glTUyhpglGb2n0zAAT9JEQlfcgg9lKtpF0jssJOIgCMmB
 IID82pBdTAN81JwPjhJrdjd/0uYimDUH5ubRyaDoQO6gjj310B3dZv1ULJBLek6BPZMvW8LKgBI
 +QP7Oo0wB4EzkX2eUJ/jfhvLnvkOorDbz4MRbjDcCHcv3j7m+gEX3Gom8/K+inS3QPHoOT/du0f
 jiJWLvdH8SQbyOfMnf7CPr5WfbxyrtKZtL8T6ZlzXEhf0nI0hxDNqjZ+ZDrASRk0rc8wl80UtsL
 BqGvdCUpnfiPaYmwQcBIVDgRQa+mCgAcUMZRxWhhl/ocZthIhPzaRNcbcoMKDyODFv+HoOOXgJ3
 SZ/532zTwrLDXZyB9YMrtpisUAvkWXAzjQB2GMxSCqc1yZcJ0UMidO9ACHGkVxoMvhaNHi+4VnB
 A7AZIbQY6ni0YOFFVr2qSmN5jHMlR+aqVMArqZxy5ARYo4kSo7RIUR8NVkqAiHprcrGj5truKxN
 p5JvDjjEvJx4jP3F9bDvAhBdsNOXJpu/51Db6A64+7UbPVQcuans1O8RFcq6Cw5AhHMdWrlITGm
 UbYc+lUrM
X-Received: by 2002:a05:6000:240b:b0:48e:3bc4:a367 with SMTP id
 ffacd0b85a97d-499c95ffea9mr2616902f8f.33.1794384878095; 
 Wed, 11 Nov 2026 00:14:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:3969:bc96:edc1:c5dd?
 ([2a01:e0a:106d:1080:3969:bc96:edc1:c5dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc8fsm8992498f8f.30.2026.11.11.00.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:14:37 -0800 (PST)
Message-ID: <392c3dfc-b12e-4037-b3a1-ed9b88d598fb@linaro.org>
Date: Wed, 11 Nov 2026 09:14:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 07/14] nvme: Skip a namespace with an unsupported LBA
 data size
To: Ana Bobillo <anabobillo3@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
 <71443b69-e5d3-40e8-bf9f-d3075168752d@gmail.com>
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
In-Reply-To: <71443b69-e5d3-40e8-bf9f-d3075168752d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 13:51, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> nvme_blk_probe() takes the LBA data size (log2 of the block size) of the
> namespace's current LBA format as the device reports it, and shifts by
> it: 1 << ns->lba_shift is undefined for a value of 31 or more, and
> nvme_blk_rw() sizes each transfer with
> 1 << (dev->max_transfer_shift - ns->lba_shift), a negative shift for a
> block larger than the maximum transfer size of the controller.
> 
> Check it, through a new nvme_lba_shift(), against the block sizes
> blk_valid_blksz() accepts and the maximum transfer size. nvme_init()
> skips a namespace with an unsupported LBA data size, as it skips an
> inactive one, rather than create a block device for it that then fails
> to probe, failing nvme_init() and leaving the namespaces it has already
> probed on a controller that failed to probe. nvme_blk_probe() checks the
> value it uses again.
> 
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> (no changes since v1)
> 
>   drivers/nvme/nvme.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index c815a967137..3df9b531bfd 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -15,6 +15,7 @@
>   #include <time.h>
>   #include <dm/device-internal.h>
>   #include <linux/compat.h>
> +#include <linux/log2.h>
>   #include "nvme.h"
>   
>   #define NVME_Q_DEPTH		2
> @@ -701,6 +702,26 @@ int nvme_scan_namespace(void)
>   	return 0;
>   }
>   
> +/**
> + * nvme_lba_shift() - Get the LBA data size of a namespace
> + *
> + * @dev: NVMe controller
> + * @id: Identify Namespace data of the namespace
> + * Return: log2 of its block size, or -EINVAL if that size is not supported
> + */
> +static int nvme_lba_shift(struct nvme_dev *dev, struct nvme_id_ns *id)
> +{
> +	u8 ds = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
> +
> +	if (ds < ilog2(DEFAULT_BLKSZ) || ds > ilog2(BLK_MAX_BLKSZ) ||
> +	    ds > dev->max_transfer_shift) {
> +		log_err("Unsupported LBA data size 2^%d\n", ds);
> +		return -EINVAL;
> +	}
> +
> +	return ds;
> +}
> +
>   static int nvme_blk_probe(struct udevice *udev)
>   {
>   	struct nvme_dev *ndev = dev_get_priv(udev->parent);
> @@ -708,6 +729,7 @@ static int nvme_blk_probe(struct udevice *udev)
>   	struct nvme_ns *ns = dev_get_priv(udev);
>   	u8 flbas;
>   	struct nvme_id_ns *id;
> +	int ret;
>   
>   	id = memalign(ndev->page_size, sizeof(struct nvme_id_ns));
>   	if (!id)
> @@ -724,7 +746,12 @@ static int nvme_blk_probe(struct udevice *udev)
>   	memcpy(&ns->eui64, &id->eui64, sizeof(id->eui64));
>   	flbas = id->flbas & NVME_NS_FLBAS_LBA_MASK;
>   	ns->flbas = flbas;
> -	ns->lba_shift = id->lbaf[flbas].ds;
> +	ret = nvme_lba_shift(ndev, id);
> +	if (ret < 0) {
> +		free(id);
> +		return ret;
> +	}
> +	ns->lba_shift = ret;
>   	list_add(&ns->list, &ndev->namespaces);
>   
>   	desc->lba = le64_to_cpu(id->nsze);
> @@ -899,6 +926,10 @@ int nvme_init(struct udevice *udev)
>   		if (!id->nsze)
>   			continue;
>   
> +		/* skip a namespace whose block size is not supported */
> +		if (nvme_lba_shift(ndev, id) < 0)
> +			continue;
> +
>   		/*
>   		 * Encode the namespace id to the device name so that
>   		 * we can extract it when doing the probe.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
