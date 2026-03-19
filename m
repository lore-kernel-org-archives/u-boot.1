Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4E1090220
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 13:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC46C83E36;
	Thu, 19 Mar 2026 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6BA83EEF; Thu, 19 Mar 2026 14:01:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5CBF883DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7091A25;
 Thu, 19 Mar 2026 06:01:21 -0700 (PDT)
Received: from [192.168.178.23] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EF7423F778; Thu, 19 Mar 2026 06:01:25 -0700 (PDT)
Message-ID: <ee16f509-5757-47ba-bca2-7ed910e946b1@arm.com>
Date: Thu, 19 Mar 2026 14:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] virtio: rng: Handle oversized return buffers
To: Meet Patel <meet.patel2@arm.com>, kavin.gunasekara@arm.com
Cc: bmeng.cn@gmail.com, sjg@chromium.org, sughosh.ganu@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de
References: <20260309165505.4001705-1-meet.patel2@arm.com>
 <20260309165505.4001705-3-meet.patel2@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260309165505.4001705-3-meet.patel2@arm.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

looks like I gave my Reviewed-by tag already on v1, please remember to 
carry that over in a subsequent submission.
For the records:

On 3/9/26 17:55, Meet Patel wrote:
> From: Kavin Gunasekara <kavin.gunasekara@arm.com>
> 
> If extra random bytes are returned, truncate and use the requested number
> instead of returning an error.
> 
> Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>
> Signed-off-by: Meet Patel <meet.patel2@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/virtio/virtio_rng.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
> index 90a371a59cc..c6de62142bb 100644
> --- a/drivers/virtio/virtio_rng.c
> +++ b/drivers/virtio/virtio_rng.c
> @@ -46,7 +46,7 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
>   			;
>   
>   		if (rsize > sg.length)
> -			return -EIO;
> +			rsize = sg.length;
>   
>   		memcpy(ptr, buf, rsize);
>   		len -= rsize;

