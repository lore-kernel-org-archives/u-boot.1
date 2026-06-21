Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AACCD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCE084119;
	Sun, 21 Jun 2026 20:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WjK6NPzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA4A84119; Sun, 21 Jun 2026 20:24:56 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF9784105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2129418f8f.3
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782066294; x=1782671094; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+Vim3zkDFv5g4DV/erpVH2TWwh67XVgfPr58ghMev8=;
 b=WjK6NPzbp2qUu3MmYvZI/mL4kqaOMNJ6PLTrjymC/7B1DeCFUdNN/AUZjKqmJkVkgK
 zDBzGlswZ+iFwboEaAfir1JptwpaYVkm/sI1X8xYU86ydrOT/435iGnrnmk9IAWFr1wE
 6LAJ4xZ/3XSNvM0JRC7/yB/BT2KIt5MkwnEuQWyFQKG3oqSmXBsxQCh/JgigHtV2pVAN
 g9uQA5VF/xAJwFpGEV3POn8hxH4eIprjziaB2JWkFrtbHfXBXqfJhONl1F8tbKL2JX8f
 QzS4xm3b0LRD2f3MToBSv/wwRO13F89TRV6GwbU7cLR6LsA6c3RoZzytv/KrwfDEsuB4
 CO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782066294; x=1782671094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+Vim3zkDFv5g4DV/erpVH2TWwh67XVgfPr58ghMev8=;
 b=ssBiZXKn4S5cDwXKFGw8w09STWdsvDbMvZC04WoxgoL/mpmYbDEBoEN8LW/HzJx+4t
 2mlLpDGr0u0D8Cwkp/Ss/WILH+r4axc2iP9ldsoXN9o7ZG2wTH4O4xK5MQnejIdJr03B
 ECXnIOgMGXcXGA5drTYE64JcMMngTUVzsI3ki5MtmNNVMdxIY/IGqU4Ow/DEz9BbKDqZ
 +T/nRj6hKYZLFDz3TQL2jbtIf3F3fPEmlUGdBUPbFwD5Z+8MMIVxBM4a+ICMcFJl0mo7
 tnWHOXkKaxOKC8xFXXiiC1eXi8dAPSW4PWLRCPPsXoFNQZIY4KiY28kgR+ipKLQOBK2V
 ecGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RorAPAJbDmr82j8WFjeLhKpwjoS+VK3ZqkHCQETRJ/FsP7Vk9Yjz1z81IawYkLIxNiEVbCKhJM=@lists.denx.de
X-Gm-Message-State: AOJu0YxJZuQphUrYnecr5JqdANJviJw6H+v8/roH1t5IZDbU9+THWVPX
 kmTGsIDqWCsP20IbZHDYkhIOdLMBKurwOxJVJ6dncPzzZaceTho4eEZ0jrdKK0Y+gOY=
X-Gm-Gg: AfdE7clntRl9bvkEsQCfNO1LqMEpVEUgOwYZNjeyw5yFulTMXgu5l5aEwxlh3jOEx5x
 wNRB2FzmzukGOkxybN+MCpsR69wCQ95C9qdWtdgX+CUU+zUliX0e8+lZXc0NDDwss7Ok95AZFfQ
 wT2t9jvYOWcws69EIuYcUJdg7mcsP9pQDy3JCUXYkBC89RkvBGlCgqWsZ1tdyqWKXJm7KoF1Zdn
 I7SQKEgeSkzeE5JAHgQcj6gsGHizlbpuaS3LmSFevDbWP0h5QcwGDKN5EWi0C3bfx3WLgOcU24M
 fy4TntpIbrqNLr3NfukmPjzGedANaB1twusI0kmJGRHYbg63fyzCF+HmRWzPvlJt7HfAOEkf7dq
 x37XXjBD2vPvDe/PZdI5ACRPYlGlQelsMbXdMYknzHQCMdV26xOWIXIQiWIpc7cfqEZBrvYA/Cy
 u7jlYvNj8z/XKiW5eH7S3L8LjA9Q1Kjl/P+bsP7HrRS8HhsoHaAaxvIg==
X-Received: by 2002:a5d:42cf:0:b0:460:6731:6165 with SMTP id
 ffacd0b85a97d-46502bb13b7mr12538032f8f.22.1782066293583; 
 Sun, 21 Jun 2026 11:24:53 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb88.dip0.t-ipconnect.de. [91.41.235.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57b95sm17172333f8f.30.2026.06.21.11.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 11:24:52 -0700 (PDT)
Message-ID: <6e7b4040-ae86-4f40-8d62-bc1d5660e4a5@linaro.org>
Date: Sun, 21 Jun 2026 20:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: qcm6490_defconfig: Enable SCSI as the Fastboot
 flash block interface
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, mani@kernel.org
References: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hey Mani,

On 19/06/2026 09:34, Manivannan Sadhasivam wrote:
> qcom_defconfig uses EMMC as the flash interface for Fasboot, but QCS6490
> RB3Gen2 has no on-board eMMC. So override the config to use UFS as the
> flash medium by selecting 'scsi' interface.
> 
> This enables flashing the images over Fastboot on this board.

Thanks for the patch!
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  configs/qcm6490_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index b088367f86c..d599e7611c1 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>  
>  CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
>  CONFIG_PHY_QCOM_QMP_COMBO=y
> +
> +CONFIG_FASTBOOT_FLASH_BLOCK=y
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0

-- 
// Casey (she/her)

