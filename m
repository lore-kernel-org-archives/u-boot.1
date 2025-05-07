Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26342C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2204822D7;
	Wed,  7 May 2025 14:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b9tJ2FoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EE68211F; Wed,  7 May 2025 13:57:17 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3D38059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso12420575e9.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746619035; x=1747223835; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTw2hgu+AMP1M2nG3BP077ELiQiq/KrRmaXEHpJACK8=;
 b=b9tJ2FoMmGqxgiu3+yJthJlEiHOgZiSi+JZaWX+jsHcugMJiVDm1/wrX742I14o2Ki
 i2Yd7Qwuk3BiFWccCiKDHcc5JkohnsIyWB/0JHJBzZ7VMcgy45fzU+AgSaZ4UfYHUoBh
 zIXx3QDGIf6zVSWoROKtzFutA5sCkiZthUHGeCf9gG9xgKCdGy0OWnHgt54VIt4LWdfp
 SWgAMLPjAoEFmvpZSlA2N/mftgfmzrUxg1sVB4i0X9FClt9qcFheZTGafERds8Adq8N2
 Pkbt1V+D0ihIPSZHb8knmXP8T6F6MLGITX+VNywdp3h6JT1sf+UFZqPFATK1ltUDW+gP
 T3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746619035; x=1747223835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTw2hgu+AMP1M2nG3BP077ELiQiq/KrRmaXEHpJACK8=;
 b=w3WLVTOUlC93UxC9tvdIdzA+7rUIZB5cVgd15gTjfYoFWYhOWygovqnqpaU085/LSx
 nm8L2tSkp4cVaP3fU2mQTxSd59UGLAvAl8fpdxjEP08z70EZ1xF0sk16JoVheRBlRS03
 atiwxY0RWsz1NQv9j0rUr5x9/B2I4bXYYDmaZI0GGJhB2S2wpXJmQLzX7KJE9ZTBAJ0J
 IFtTjct5Eg5k6byqcBsQsvas+mtssN0koDT9S6ZD+lrpXGhjaPHdI7o3HaJ8uNT5x1RE
 1SuT9jWWg488rEkRNcNg7no5Dwq/TSWVxwlWmFgIHQVrKeacLwOuREv+0BMNIurislm4
 NZmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXExTHagJcs4abbsVvQbmFd9TAnsEEXfFVl+lsUPU80cigDTrxSk/2rdyqaQcLju4zgls9cK9o=@lists.denx.de
X-Gm-Message-State: AOJu0YyC0pIOjwNaze0kva2Pk589nvqwjTlLTEUxaG+EeO+rnUoVydWI
 mjVLKAWq0+L7sKySXudE1E3G6KUJxxI8v8DZGUmkKKSQ2E5U2mmBl/q+emR9wmI=
X-Gm-Gg: ASbGncshzM9ccZdojN8eyGsjCj6BpsBQ1mi5BxqburCPaAgFJY4iFR6dUcB+VRjIng3
 TLR+Lw8Xsu7mYbumPjtARucKnAJukxHPmFesxiVKmxV/CcBk8/pJDagKc8O0gYTTAPSJo3ggZJJ
 3jW3wI5orVUVhHbeV+06C/ebeknPmDuE7WepuqilC9WvIovd0lhWTtk2jU8I/Pxx+VGWJpjgsNz
 FeiNI3FdjYM0kjUaPJ9mswogvvH+pabroQNIzD5Yh0R4X1++RvHcokuRDKz4gL+B0lVuSPSHDC7
 9G88ZMA+zEf4AcZw9xgf10/OpYVdL39xjATAKNzb4qogn23JPRQoTHSaE9NOGGC1mTLK5ZuH5k7
 7VdcYeng=
X-Google-Smtp-Source: AGHT+IEvMbWM6GSOQycXmA3NTOlQvS6lEbUUMRAQhIx0t3X9aRainGb4clveWURCbD0lm43jPrtcfQ==
X-Received: by 2002:a05:600c:4e89:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-441d44c3811mr24050605e9.12.1746619034766; 
 Wed, 07 May 2025 04:57:14 -0700 (PDT)
Received: from [192.168.1.47] (234-60-142-46.pool.kielnet.net. [46.142.60.234])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d434dc66sm30324625e9.18.2025.05.07.04.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:57:12 -0700 (PDT)
Message-ID: <7d3936e0-a01c-4231-90ce-a66cf944a837@linaro.org>
Date: Wed, 7 May 2025 13:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] scsi: Implement get_blk() function
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, hs@denx.de, sjg@chromium.org,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, xypron.glpk@gmx.de,
 cniedermaier@dh-electronics.com, ansuelsmth@gmail.com,
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250507112812.3066301-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 May 2025 14:39:00 +0200
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



On 5/7/25 13:28, Varadarajan Narayanan wrote:
> Add a function to obtain the block device for SCSI.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: * s/scsi_get_blk/scsi_get_blk_by_uuid
>      * s/partition_name/uuid
> ---
>   drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
>   include/scsi.h             | 10 ++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 1ee8236c05c..3eb6069649f 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -10,7 +10,9 @@
>   
>   #define LOG_CATEGORY UCLASS_SCSI
>   
> +#include <blk.h>
>   #include <dm.h>
> +#include <part.h>
>   #include <scsi.h>
>   
>   int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> @@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
>   	return ops->exec(dev, pccb);
>   }
>   
> +int scsi_get_blk_by_uuid(const char *uuid,
> +			 struct blk_desc **blk_desc_ptr,
> +			 struct disk_partition *part_info_ptr)
> +{
> +	static int is_scsi_scanned;
> +	struct blk_desc *blk;
> +	int i, ret;
> +
> +	if (!is_scsi_scanned) {
> +		scsi_scan(false /* no verbose */);
> +		is_scsi_scanned = 1;

At this point I think we should just unconditionally scsi_scan() like we 
do with MMC... Tom (others?) any thoughts on this? Anyhow this is 
probably fine.

One thing to be extremely wary of is that we don't call scsi_scan() 
after initialising EFI driver handles because that will cause big issues 
(ran into this one before), since scsi_scan() will unbind and rebind 
drivers if it was already called. I don't think that's a problem with 
the current ordering of things.

> +	}
> +
> +	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> +		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> +		if (ret)
> +			continue;

As before, please check for the end of the list and break here (-ENODEV 
is the magic value). Really it's bad practise to ignore ret, we should 
only ever continue if ret is -ENOENT, otherwise we should return the 
errorcode (and probably translate a -ENODEV to -ENOENT since that makes 
more sense here)

Kind regards,

> +
> +		ret = part_get_info_by_uuid(blk, uuid, part_info_ptr);
> +		if (ret > 0) {
> +			*blk_desc_ptr = blk;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;

	return -ENOENT;

Kind regards,> +}
> +
>   int scsi_bus_reset(struct udevice *dev)
>   {
>   	struct scsi_ops *ops = scsi_get_ops(dev);
> diff --git a/include/scsi.h b/include/scsi.h
> index ab53b47b58f..8d6c5116419 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -351,6 +351,16 @@ int scsi_scan(bool verbose);
>    */
>   int scsi_scan_dev(struct udevice *dev, bool verbose);
>   
> +/**
> + * scsi_get_blk_by_uuid() - Provides SCSI partition information.
> + *
> + * @uuid:		UUID of the partition for fetching its info
> + * @blk_desc_ptr:	Provides the blk descriptor
> + * @part_info_ptr:	Provides partition info
> + */
> +int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
> +			 struct disk_partition *part_info_ptr);
> +
>   #define SCSI_IDENTIFY					0xC0  /* not used */
>   
>   /* Hardware errors  */
-- 
Casey (she/they)

