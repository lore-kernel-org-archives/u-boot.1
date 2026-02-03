Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB0BE83070
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 09:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE218405A;
	Tue,  3 Feb 2026 10:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xPsRAbuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610D68405F; Tue,  3 Feb 2026 10:34:31 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C02A8404D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 10:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso44806755e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 01:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770111266; x=1770716066; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=opsMm4nZKH0W+JQgRf/nEaLRdP9CdHOT56eYL05d38Q=;
 b=xPsRAbuNJlkBOzrs2kBA9+vzp/2AtTPvnPBrgonVDMsk6o5sRklOcx8wLFXM7m94BX
 gtRMdmBbAO4HJecGdOV8LRl4D7k9uwfMhsBckwsy/IPZmZjVdj9Jh5hdv+asm6G+I1FP
 Yh/RRKwOhAjmaCk7pQV5djbV7VnFIG9Hla1VwCNU8mS7dyRLJiOxnDztjRRI5oq3nhEs
 +CPenJhm1i7hrh1AsNcbqfnYHI9w4JFht0Gak+lAoVWlOAB+KR61gGSupP1a6JEx/o4R
 s3XIk+5b+0y3Amk5cJO95WkA1eZyk7zcVTxFKOKyLV7NQTBBq7PRF1btmo6d6EyNqZLv
 j5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770111266; x=1770716066;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opsMm4nZKH0W+JQgRf/nEaLRdP9CdHOT56eYL05d38Q=;
 b=u2DhADWzQNe5QIaPnyYG0QzEbs9GSAuN8FsPsDEId81hckuwwqJ2FxtI8lskRXgcEv
 x8FlKzH0R108hoOVUshLDpyMZWoivBnm1Ku/wi0eZSjBoBp4QrA3h7MunH2JcbJu6VM2
 qeJuVT83ZKgRGOjIk/lri9dP2A337r3X2dp/TyqlcBF+VnSFPZWp3w/4JQQR9ewYZRbC
 N+JDTJC/HKEckyPb0/PXt5wdwa6TMiFCdV94/tyfAAcNoarwUmF69klcu32BI1IKUjlO
 BD156W4IbJiWsiK8UioJKWL9h6TCPz4GNMayD78e4zToEF7cJt5tYIAXMBwsvudSAmlT
 hKXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+4LNAEmRW/W3jow+MfQmbXC3CeuACt7NxfyDhzblhPLEy5FKpaRUF9+ORmbufI2njRnutFMU=@lists.denx.de
X-Gm-Message-State: AOJu0YweKY/AvSe0/8yh+ga59LyL2yJ5SbAQ6+byW6ZazVYXyUtfZsRX
 FFBLUbRj5d5YHhm4t5AJY+a7qESlvodzsMjBXinWotztMnALr8xAcOi6d5wwEXy0jIA=
X-Gm-Gg: AZuq6aKFTdzIAiX6/JXlmSgTVBSIjIShOhe4Imuu/2ClKMRPSjN5oWNnOLeqBqOiaZL
 jNrNn+FRQc0ENl0g+ErJqFxofxbzHUemUGZ512+cShV4bKI9LCvoJ3gOTJ1EMxoDX1odBjyESKD
 jMSVvx4NFNpn5QnAQCUC0BKIIix2OrYMkmftl8uD0DxF9/8PEQGoe+h9Sbzo5xfROQkNg4EWlaD
 3vuIq0JUK+UQSO81KPHwonXk6MRoTWVCndgE18ogr3GTdL3gEApTbbamdEQpZZkxdCz5JbxSRrj
 NTHZUUhlUI//tTCK+CQz50Ijj+ZIaeLB06NWG2xzKVzNkhaXhSSpPJRbyljOdKd+jSpwojEmuCx
 A96SjtTz9AsOdEvM4drEzFoMmjkbGpmmjV02odWm7Uy0f8J73P2KWyIyhBfS9WQ2Lkud5BJMz74
 MyG4Lb2B8du4EJS0lU66yNXuIkv/UaC98D/8FO70WRL61wSQnQ4JsMCZwXZD7LcT8=
X-Received: by 2002:a05:600c:4ec7:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-482db46b38dmr194951925e9.15.1770111266438; 
 Tue, 03 Feb 2026 01:34:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830513730esm53176525e9.14.2026.02.03.01.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 01:34:25 -0800 (PST)
Message-ID: <e4a44f65-4044-4f54-9114-6fc526b5d942@linaro.org>
Date: Tue, 3 Feb 2026 10:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drivers: ufs: remove unused ufs_post_bind() declaration
To: Julien Stephan <jstephan@baylibre.com>, Sumit Garg
 <sumit.garg@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, dlechner@baylibre.com
References: <20260203-cleanup-ufs-header-v1-1-4c10424485f0@baylibre.com>
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
In-Reply-To: <20260203-cleanup-ufs-header-v1-1-4c10424485f0@baylibre.com>
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

On 2/3/26 10:21, Julien Stephan wrote:
> Commit 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
> inlined ufs_scsi_bind() into ufs_post_bind() as trivial
> device_bind_driver() call.
> 
> ufs_scsi_bind() is no longer referenced anywhere in the codebase, so
> drop its declaration from include/ufs.h.
> 
> Drivers used to include <ufs.h> to include prototype of ufs_scsi_bind()
> function, so we can now safely remove such includes.
> 
> Fixes: 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/cdns-platform.c         | 1 -
>   drivers/ufs/ufs-amd-versal2.c       | 1 -
>   drivers/ufs/ufs-pci.c               | 1 -
>   drivers/ufs/ufs-qcom.c              | 1 -
>   drivers/ufs/ufs-renesas-rcar-gen5.c | 1 -
>   drivers/ufs/ufs-renesas.c           | 1 -
>   drivers/ufs/ufs-rockchip.c          | 1 -
>   drivers/ufs/ufshcd-dwc.c            | 1 -
>   include/ufs.h                       | 9 ---------
>   9 files changed, 17 deletions(-)
> 
> diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
> index 87d9c5bad79..40883a187b0 100644
> --- a/drivers/ufs/cdns-platform.c
> +++ b/drivers/ufs/cdns-platform.c
> @@ -7,7 +7,6 @@
>   
>   #include <clk.h>
>   #include <dm.h>
> -#include <ufs.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index dd62c9819ba..6c949b2ca76 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -5,7 +5,6 @@
>   
>   #include <clk.h>
>   #include <dm.h>
> -#include <ufs.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <zynqmp_firmware.h>
> diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
> index 5b9c72a695d..e1e010d027c 100644
> --- a/drivers/ufs/ufs-pci.c
> +++ b/drivers/ufs/ufs-pci.c
> @@ -7,7 +7,6 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <pci.h>
> -#include <ufs.h>
>   #include <dm/device_compat.h>
>   #include "ufs.h"
>   
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index ee43958d5d8..dc40ee62daf 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -14,7 +14,6 @@
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <generic-phy.h>
> -#include <ufs.h>
>   #include <asm/gpio.h>
>   #include <interconnect.h>
>   
> diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
> index cc53e91449c..a21ae3f390e 100644
> --- a/drivers/ufs/ufs-renesas-rcar-gen5.c
> +++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
> @@ -7,7 +7,6 @@
>   
>   #include <clk.h>
>   #include <dm.h>
> -#include <ufs.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <linux/iopoll.h>
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index 5652309911e..a206e3c6d58 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -7,7 +7,6 @@
>   
>   #include <clk.h>
>   #include <dm.h>
> -#include <ufs.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387d..643a6ffb9bc 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -13,7 +13,6 @@
>   #include <linux/err.h>
>   #include <linux/ioport.h>
>   #include <reset.h>
> -#include <ufs.h>
>   
>   #include "ufs.h"
>   #include "unipro.h"
> diff --git a/drivers/ufs/ufshcd-dwc.c b/drivers/ufs/ufshcd-dwc.c
> index 3f62e59a060..98422d742a0 100644
> --- a/drivers/ufs/ufshcd-dwc.c
> +++ b/drivers/ufs/ufshcd-dwc.c
> @@ -7,7 +7,6 @@
>    */
>   #include <clk.h>
>   #include <dm.h>
> -#include <ufs.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
> diff --git a/include/ufs.h b/include/ufs.h
> index 702b8359dbd..f6e27d90e43 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
> @@ -20,13 +20,4 @@ int ufs_probe(void);
>    */
>   int ufs_probe_dev(int index);
>   
> -/*
> - * ufs_scsi_bind() - Create a new scsi device as a child of the UFS device and
> - *		     bind it to the ufs_scsi driver
> - * @ufs_dev: UFS device
> - * @scsi_devp: Pointer to scsi device
> - *
> - * Return: 0 if Ok, -ve on error
> - */
> -int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp);
>   #endif
> 
> ---
> base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
> change-id: 20260203-cleanup-ufs-header-e385e21fac1c
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
