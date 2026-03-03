Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7E5EC1431
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632EC838BB;
	Tue,  3 Mar 2026 12:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42CB83F2D; Tue,  3 Mar 2026 12:48:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E0B178063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF8B497;
 Tue,  3 Mar 2026 03:48:33 -0800 (PST)
Received: from [10.57.58.1] (unknown [10.57.58.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 355563F73B;
 Tue,  3 Mar 2026 03:48:39 -0800 (PST)
Message-ID: <a4cee7cd-9f84-4ee4-8bad-aed2f7d66e08@arm.com>
Date: Tue, 3 Mar 2026 12:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio: rng: Handle oversized return buffers
To: Kavin Gunasekara <kavin.gunasekara@arm.com>, u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 trini@konsulko.com, sjg@chromium.org
References: <20260217132936.2736916-1-kavin.gunasekara@arm.com>
 <20260217132936.2736916-3-kavin.gunasekara@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260217132936.2736916-3-kavin.gunasekara@arm.com>
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

On 2/17/26 14:29, Kavin Gunasekara wrote:
> If extra random bytes are returned, truncate and use the requested number
> instead of returning an error.
> 
> Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>

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

