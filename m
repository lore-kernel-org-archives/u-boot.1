Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F7EC1432
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2753B838BB;
	Tue,  3 Mar 2026 12:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D179F83E7F; Tue,  3 Mar 2026 12:46:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2849F8063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6158497;
 Tue,  3 Mar 2026 03:45:54 -0800 (PST)
Received: from [10.57.58.1] (unknown [10.57.58.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 368523F73B;
 Tue,  3 Mar 2026 03:46:00 -0800 (PST)
Message-ID: <48bf3242-86f1-404b-9e2b-b10151908932@arm.com>
Date: Tue, 3 Mar 2026 12:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] test: dm: virtio_rng: Update virtio-rng test
To: Kavin Gunasekara <kavin.gunasekara@arm.com>, u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 trini@konsulko.com, sjg@chromium.org
References: <20260217132936.2736916-1-kavin.gunasekara@arm.com>
 <20260217132936.2736916-2-kavin.gunasekara@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260217132936.2736916-2-kavin.gunasekara@arm.com>
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

Hi Kavin,

On 2/17/26 14:29, Kavin Gunasekara wrote:
> The virtio-rng test to verify effective handling of oversized return
> buffers checks that an (undocumented) error is raised, instead of the
> real concern, which is the surrounding buffer integrity following a rng
> function call.
> Update the test to check that the other contents of a buffer remain
> unchanged instead of looking for an error code.
> 
> Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>
> ---
>   test/dm/virtio_rng.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/test/dm/virtio_rng.c b/test/dm/virtio_rng.c
> index e404b08484e..7c3dd50ef3e 100644
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
> +	memset(buffer, 0xaa, sizeof(buffer));

I don't think it makes much sense to fill the whole buffer here, only to 
overwrite the last part in the next line. We should not be that paranoid ;-)

The rest looks alright.

Cheers,
Andre

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

