Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB877C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1933B88A54;
	Wed, 21 Aug 2024 16:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OXJNNCPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A30188DB7; Wed, 21 Aug 2024 16:00:08 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2675188B4C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf75ed0e0eso34825936d6.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248805; x=1724853605; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bTICd6c+Q/+qwgMttQdqpbYqSoqmrioPgtJXwy6Axog=;
 b=OXJNNCPQ91yLmq6nv7dhvof+aZ/Uj3ZmmP8QNfgbm2CMhU+RC0HngFtCl6Zr1TnFyx
 OFseHUkY7tgtsKrMJ6b6oIIqBXBGyL1e/jnpnWEvIRL8ZNkLVwvhimqmKglf3q4YYENx
 XOCovispEMMPqpPgJKr+jxHs+SSANwyBZDx/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248805; x=1724853605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTICd6c+Q/+qwgMttQdqpbYqSoqmrioPgtJXwy6Axog=;
 b=NnER++w8tudwzExJalOfd0Skd95DeMQD8ZIpCtGcg39vn5KxKK/z/LSEDTiPqhFK+y
 xSYD6IV+vWksxhkiPhPn/1mPBlOrgueZ0iTPMHka+HaPXFOnF6D31kbDowFNu9fvHoIs
 XoevhetGdUmcAEjU1RfhAABDQU6rhPG3i1CfhgXPIIM5IZL1KgGteYpTUS3cqZlh3tJR
 uBX0B1D3k3HLRKB/AGocuizGiCOeKvl/Dgh4pJWBnY0JphFHLD/RF1B9pl2BWYQFGwOy
 SOPccJ3qJE9pPj8ZTbAX+FJCmoNHnFBYYnSO7Tv0QyMKQ1sU0Q2aVWiw99pshKvT1CEW
 6TXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4zJ/5Dtxx0TmXkSti/LzURp9fPswXkM5qBq8byINetnaGztLQEGcpXkd7PVHzxzmV2+sA4LA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjf6Z1nnDZnTFuZnNtbD3kycjsaO1Ryp/6uDWUkOfAfI4vNu1/
 Bsm3Uoc8MG8ZhVXvDinzJYazIPI57dhm+Be9I/qvXOrZbiUlsFNzzhnFhFRONClPSQrCjMtvacg
 lcFW4pDC7L3zqaij56ckh87FbsL0nvmOHG300
X-Google-Smtp-Source: AGHT+IHNgw+qDYPOCUHDgwKQVoAVRlwqcw5yGCeyooA6V4a/z9eCoaBH+2Rm7iOnQmBElsw0taFKOrgaoZJPTVvqytk=
X-Received: by 2002:a05:6214:4a87:b0:6bf:8186:be29 with SMTP id
 6a1803df08f44-6c15686d9cfmr30965466d6.43.1724248805032; Wed, 21 Aug 2024
 07:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-4-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-4-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:54 -0600
Message-ID: <CAFLszTg38B4H_bOX21HD8rXuWWdRH33=MXVj3UwrEdiya_-c=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iommu: qcom-smmu: add sc7280-smmu-500 compatible
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 21 Aug 2024 at 07:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This soc doesn't have the generic compatible.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/iommu/qcom-hyp-smmu.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 7b646d840dd4..1b5a09bb7b39 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -380,8 +380,9 @@ static struct iommu_ops qcom_smmu_ops = {
>  };
>
>  static const struct udevice_id qcom_smmu500_ids[] = {
>         { .compatible = "qcom,sdm845-smmu-500" },
> +       { .compatible = "qcom,sc7280-smmu-500" },
>         { .compatible = "qcom,smmu-500", },
>         { /* sentinel */ }
>  };
>
>
> --
> 2.46.0
>
