Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B80F1090220
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 13:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B04A83E36;
	Thu, 19 Mar 2026 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAF283F2D; Thu, 19 Mar 2026 14:00:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EC12483DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E325F1A25;
 Thu, 19 Mar 2026 06:00:05 -0700 (PDT)
Received: from [192.168.178.23] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 33D663F778; Thu, 19 Mar 2026 06:00:09 -0700 (PDT)
Message-ID: <e3e1c797-f27e-4b14-9f4d-26597a8cf7a1@arm.com>
Date: Thu, 19 Mar 2026 14:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] test: dm: virtio_rng: Update virtio-rng test
To: Meet Patel <meet.patel2@arm.com>, kavin.gunasekara@arm.com
Cc: bmeng.cn@gmail.com, sjg@chromium.org, sughosh.ganu@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de
References: <20260309165505.4001705-1-meet.patel2@arm.com>
 <20260309165505.4001705-2-meet.patel2@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260309165505.4001705-2-meet.patel2@arm.com>
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

Hi Meet,

On 3/9/26 17:55, Meet Patel wrote:
> From: Kavin Gunasekara <kavin.gunasekara@arm.com>
> 
> The virtio-rng test to verify effective handling of oversized return
> buffers checks that an (undocumented) error is raised, instead of the
> real concern, which is the surrounding buffer integrity following a rng
> function call.
> Update the test to check that the other contents of a buffer remain
> unchanged instead of looking for an error code.

thanks for the change, looks good now!

> Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>
> Signed-off-by: Meet Patel <meet.patel2@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   test/dm/virtio_rng.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/test/dm/virtio_rng.c b/test/dm/virtio_rng.c
> index e404b08484e..5fd56ade586 100644
> --- a/test/dm/virtio_rng.c
> +++ b/test/dm/virtio_rng.c
> @@ -19,12 +19,19 @@ struct virtio_rng_priv {
>   	struct virtqueue *rng_vq;
>   };
>   
> +#define BUFFER_SIZE 16
> +#define CANARY "CANARYCANARYCANARYCANARY"
> +
>   /* Test the virtio-rng driver validates the used size */
>   static int dm_test_virtio_rng_check_len(struct unit_test_state *uts)
>   {
>   	struct udevice *bus, *dev;
>   	struct virtio_rng_priv *priv;
> -	u8 buffer[16];
> +	u8 buffer[BUFFER_SIZE + sizeof(CANARY)];
> +
> +	/* write known data to buffer */
> +	memset(buffer, 0xaa, BUFFER_SIZE);
> +	memcpy(buffer + BUFFER_SIZE, CANARY, sizeof(CANARY));
>   
>   	/* check probe success */
>   	ut_assertok(uclass_first_device_err(UCLASS_VIRTIO, &bus));
> @@ -44,7 +51,10 @@ static int dm_test_virtio_rng_check_len(struct unit_test_state *uts)
>   	priv->rng_vq->vring.used->ring[0].len = U32_MAX;
>   
>   	/* check the driver gracefully handles the error */
> -	ut_asserteq(-EIO, dm_rng_read(dev, buffer, sizeof(buffer)));
> +	dm_rng_read(dev, buffer, BUFFER_SIZE);
> +
> +	/* check for the canary bytes behind the real buffer */
> +	ut_asserteq_mem(buffer + BUFFER_SIZE, CANARY, sizeof(CANARY));
>   
>   	return 0;
>   }

