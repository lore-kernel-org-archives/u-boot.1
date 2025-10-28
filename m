Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A52DCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0977B839F1;
	Tue, 28 Oct 2025 09:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4ISosrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62760839D6; Tue, 28 Oct 2025 09:15:12 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4096C83A1E
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso70010815e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639310; x=1762244110; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DT8arGlM7OwrH4NcZl595W976MPWL1+ZssoWPXxZtTM=;
 b=U4ISosrq5pIJW04C56mjvywS0mIFvh5efHN4IHMYaFLAd8wx+e1VgG/Q+S1kYggKQi
 HHQfVpNOa1T3mPvYStIohIvkcYMXX96sJAeydUdQs336XrQY8z7x0xiGmgCvyoSUkQTI
 1BAFLo+MgH3IE5i4q54wGfuhrXbLBAF4bRpsA02D8DCWo78j1YbeiOOMZnFHBor601w5
 7a+qrii2Ru+ZnmtWBJrW+STsAFBbZKUFQfxDXco8ixqIFMwzFMKZH9u/FsxfZfzI4mnu
 33e2i5n9OY0YOX/iH6HMF4nG1YnXzkJ92p33FIlwwcmRBtmmSs1alcNg7YMIXGVyQ53D
 9o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639310; x=1762244110;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DT8arGlM7OwrH4NcZl595W976MPWL1+ZssoWPXxZtTM=;
 b=PjsIQDPOihqd12LBYicjkvkQU2rMXB65FFX9LRDwZqhkcBZVES8P4ajOHGUXVALLkw
 BpozbT9Y55dBD7prSJEzp2nQ1eRpThnAKb9eqZxkbvs8mKVHuPtr4qsUjhaKfXqREnSZ
 OHa51ISQ7qkq8YJsWR7opujZiH7iRBuV7h01mu743JrY9UjgIia/KFnmY08egnA6tlrE
 OxiMLVO5Agu2M5NFESf4+T2flo6TjJi/fhhGf1lwHFsF/955Q0NmmNaMbJ+/dIXsu7e9
 7hq3ETD5chDrVdm7EvElIhsRG+pee4Bb1rVrDSYNmi1Sc4G0UOGRNMbpVN5C8gHzpC98
 5IoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViypESrj71wrn9VWER8+hNOkNloOplKFMd0Rd3jIx3SZ4EEOiYNgFcNnhhzQgHLR+rSWK5RAg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzkf+nQZ3oLHneQGIxuP0lLLCXLhK7c/zB9Mh6tRTX8ZQm82/zs
 iW030jfYer1pyDyGF8eNwo+MhTiMtdU8g3SG4YdfABYZ1DUtfEMkcjpx8JUuoECl8pHzxzJv61g
 7pRuJnng=
X-Gm-Gg: ASbGncssKOvI3a17DIVtxVzGSiwN4Cm//ANSqZZ2FAQGYWlpMBc4NcSEilrFekuaUfV
 fYTKRT0nu9GL2/32u9jaaKn1Sh2rZcpnUOeCRVWZacHN6ymP4IXUPCKgTxPo5Fmb7K0VeCG2tn7
 v3u8zDFw4LJz+Umfi9dAR2eszSdCouVhpV4jFFlVIm7xBRMf1kscg+imOuMsFX0c3FKDtHrt++A
 PuQeBXBX/NXfUq2NebeoFHugyv4nnHTefJafG31B2PKWjN6CItzUENfYcapx53W/d/JCkWW/EBb
 at1B0V3h2Fn6DvCsSG7GurwD5wNG8+SZL55LlmJ/N0mMOHXbzHNbC5EKCRVop1GKJ9O0KQQ6DlI
 mWo0nWNfLYJLYVQLTgpCxZ4H0ncBhcRG4JI1s4wum2m5mG/t3RLhPZkzvkhIhtC7/gaOTfa9cO4
 gBvPmYsBY8fnHp3UifkK6uljcjFdNPZS5+4V1jEPNIqZrmfdBgqA==
X-Google-Smtp-Source: AGHT+IFc64l6y+hHmsJ1hDU5u63HqE9KROAO20JNiTuKFoDs9RppTMMNKn8CnHBubCBNXInMgfErdg==
X-Received: by 2002:a05:600c:3b14:b0:475:dd59:d8ba with SMTP id
 5b1f17b1804b1-47717df66f6mr21161395e9.3.1761639309598; 
 Tue, 28 Oct 2025 01:15:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771904b26esm13123095e9.10.2025.10.28.01.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:15:09 -0700 (PDT)
Message-ID: <603d8e53-7393-418e-8139-87547be28bdb@linaro.org>
Date: Tue, 28 Oct 2025 09:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/6] ufs: Call ufs_scsi_bind() from uclass .post_bind
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-4-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20251027170706.29302-4-marek.vasut+renesas@mailbox.org>
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

On 10/27/25 18:06, Marek Vasut wrote:
> Instead of duplicating the ufs_scsi_bind() call in every driver,
> call it from UFS uclass .post_bind callback for every driver in
> one place. While doing so, inline ufs_scsi_bind() directly into
> ufs_post_bind() as trivial device_bind_driver() call.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/cdns-platform.c   |  8 --------
>   drivers/ufs/ufs-amd-versal2.c |  8 --------
>   drivers/ufs/ufs-pci.c         |  8 --------
>   drivers/ufs/ufs-qcom.c        |  8 --------
>   drivers/ufs/ufs-renesas.c     |  8 --------
>   drivers/ufs/ufs.c             | 14 ++++++--------
>   6 files changed, 6 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
> index 510a6a6aa5d..87d9c5bad79 100644
> --- a/drivers/ufs/cdns-platform.c
> +++ b/drivers/ufs/cdns-platform.c
> @@ -101,13 +101,6 @@ static int cdns_ufs_pltfm_probe(struct udevice *dev)
>   	return err;
>   }
>   
> -static int cdns_ufs_pltfm_bind(struct udevice *dev)
> -{
> -	struct udevice *scsi_dev;
> -
> -	return ufs_scsi_bind(dev, &scsi_dev);
> -}
> -
>   static const struct udevice_id cdns_ufs_pltfm_ids[] = {
>   	{
>   		.compatible = "cdns,ufshc-m31-16nm",
> @@ -120,5 +113,4 @@ U_BOOT_DRIVER(cdns_ufs_pltfm) = {
>   	.id		= UCLASS_UFS,
>   	.of_match	= cdns_ufs_pltfm_ids,
>   	.probe		= cdns_ufs_pltfm_probe,
> -	.bind		= cdns_ufs_pltfm_bind,
>   };
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 89931921ff9..bf23439e59d 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -552,13 +552,6 @@ static int ufs_versal2_probe(struct udevice *dev)
>   	return ret;
>   }
>   
> -static int ufs_versal2_bind(struct udevice *dev)
> -{
> -	struct udevice *scsi_dev;
> -
> -	return ufs_scsi_bind(dev, &scsi_dev);
> -}
> -
>   static const struct udevice_id ufs_versal2_ids[] = {
>   	{
>   		.compatible = "amd,versal2-ufs",
> @@ -571,5 +564,4 @@ U_BOOT_DRIVER(ufs_versal2_pltfm) = {
>   	.id		= UCLASS_UFS,
>   	.of_match	= ufs_versal2_ids,
>   	.probe		= ufs_versal2_probe,
> -	.bind		= ufs_versal2_bind,
>   };
> diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
> index 871f3f50f5c..5b9c72a695d 100644
> --- a/drivers/ufs/ufs-pci.c
> +++ b/drivers/ufs/ufs-pci.c
> @@ -11,13 +11,6 @@
>   #include <dm/device_compat.h>
>   #include "ufs.h"
>   
> -static int ufs_pci_bind(struct udevice *dev)
> -{
> -	struct udevice *scsi_dev;
> -
> -	return ufs_scsi_bind(dev, &scsi_dev);
> -}
> -
>   static int ufs_pci_probe(struct udevice *dev)
>   {
>   	int err;
> @@ -32,7 +25,6 @@ static int ufs_pci_probe(struct udevice *dev)
>   U_BOOT_DRIVER(ufs_pci) = {
>   	.name	= "ufs_pci",
>   	.id	= UCLASS_UFS,
> -	.bind	= ufs_pci_bind,
>   	.probe	= ufs_pci_probe,
>   };
>   
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index 843585726c7..9f0a6940d98 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -648,13 +648,6 @@ static int ufs_qcom_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static int ufs_qcom_bind(struct udevice *dev)
> -{
> -	struct udevice *scsi_dev;
> -
> -	return ufs_scsi_bind(dev, &scsi_dev);
> -}
> -
>   static const struct udevice_id ufs_qcom_ids[] = {
>   	{ .compatible = "qcom,ufshc" },
>   	{},
> @@ -665,6 +658,5 @@ U_BOOT_DRIVER(qcom_ufshcd) = {
>   	.id		= UCLASS_UFS,
>   	.of_match	= ufs_qcom_ids,
>   	.probe		= ufs_qcom_probe,
> -	.bind		= ufs_qcom_bind,
>   	.priv_auto	= sizeof(struct ufs_qcom_priv),
>   };
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index ae05bdc8102..0b74b39dc2a 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -351,13 +351,6 @@ static struct ufs_hba_ops ufs_renesas_vops = {
>   	.hce_enable_notify = ufs_renesas_hce_enable_notify,
>   };
>   
> -static int ufs_renesas_pltfm_bind(struct udevice *dev)
> -{
> -	struct udevice *scsi_dev;
> -
> -	return ufs_scsi_bind(dev, &scsi_dev);
> -}
> -
>   static int ufs_renesas_pltfm_probe(struct udevice *dev)
>   {
>   	struct ufs_renesas_priv *priv = dev_get_priv(dev);
> @@ -405,7 +398,6 @@ U_BOOT_DRIVER(ufs_renesas) = {
>   	.name		= "ufs-renesas",
>   	.id		= UCLASS_UFS,
>   	.of_match	= ufs_renesas_pltfm_ids,
> -	.bind		= ufs_renesas_pltfm_bind,
>   	.probe		= ufs_renesas_pltfm_probe,
>   	.remove		= ufs_renesas_pltfm_remove,
>   	.priv_auto	= sizeof(struct ufs_renesas_priv),
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index c1f3301b37e..5dff5c3aaec 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -2030,14 +2030,6 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	return 0;
>   }
>   
> -int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp)
> -{
> -	int ret = device_bind_driver(ufs_dev, "ufs_scsi", "ufs_scsi",
> -				     scsi_devp);
> -
> -	return ret;
> -}
> -
>   #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>   static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
>   {
> @@ -2092,8 +2084,14 @@ U_BOOT_DRIVER(ufs_scsi) = {
>   	.ops = &ufs_ops,
>   };
>   
> +static int ufs_post_bind(struct udevice *dev)
> +{
> +	return device_bind_driver(dev, "ufs_scsi", "ufs_scsi", NULL);
> +}
> +
>   UCLASS_DRIVER(ufs) = {
>   	.id			= UCLASS_UFS,
>   	.name			= "ufs",
> +	.post_bind		= ufs_post_bind,
>   	.per_device_auto	= sizeof(struct ufs_hba),
>   };

Nice change !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
