Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A1C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 17:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BD186384;
	Tue, 15 Aug 2023 19:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gUMUM2RX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87828863E9; Tue, 15 Aug 2023 19:14:49 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF2186366
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 19:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso4700039f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692119686; x=1692724486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DwiyWn9b8KFAG44/zXIjdEZFDSjlM9k1zxN9AJO4pts=;
 b=gUMUM2RXOpW+lFxGqy4RFW0VlI+vXEKs0gf3CZMe4iCuRzlClBD7UqLaHQ4CjnZ11X
 2H3g2kLVm23yuTKmufl2jTBeit5VEzjgS5toXJJmTXBsTXXK9MrEJADF8CV4mvsv+Mkg
 iRJ5E6bpTRzMD5msI7QtCZ2kMIBda/tU6Pr4HLrBDPpufYgQ6ZVF6rlUSKCMaifuOpgt
 /ezBHlSA+Ufg+eIqQCOaqktdkljZNlqGDtF67IEXCz4DYk12v/hhwy002WVvcF7XWcvh
 pmzuhIHMwnSoc1uJCRKSVftwfbKQ+0YkPcG/z1XWVafj9fCoRwdsYv5vzJBEMdf73lS9
 tSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692119686; x=1692724486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwiyWn9b8KFAG44/zXIjdEZFDSjlM9k1zxN9AJO4pts=;
 b=BhFi37d0sTW3ar4Se2i87Ds+96rvGRh9Wng28MA3/ai2tyEsoRzlea5h9j4xo768SJ
 JaLTEPL//EVeih9yMIBTTws3rvw8RxlcnFRmJzm71jhpXs2tVS3W5I21Cnp2sC5u7o3J
 npsbB/dx2LjEKe4KiEn/f/nSz64uozjFRapJftSJ41lK4VSrywvsLJX3lbr4ZLkcRGrr
 MLZdetluZYt8zp1CehKKTEsbLu0UzHODWufINg+E6HTMrwD4Zn+iQW3t6Pz1gPupeotA
 DUKZfCbAhzxpDH0qNYWQW8ifG47byY1+OB7L6wyTDc8fPSkAMm7V2vBtWoFcV0RdyKK8
 qXtw==
X-Gm-Message-State: AOJu0YyPClFopaUFv1PyI/m6DB1eEJs3MZC0A7w8Qgzo1lfv0bDm20vp
 ZYHsqKGOQ7T20eGO4agrN7s2P70wPh5f2rMK7HUePcPskk4IXRfklKY=
X-Google-Smtp-Source: AGHT+IE8ODX7CmfH124uDZaog+6WgthXlCejJTa9EDCLFRq6/lqIz3FQdiH25mR//LzYJh2ewXJpSxo0ufCGSE+0xX0=
X-Received: by 2002:a5d:6609:0:b0:319:80c5:486c with SMTP id
 n9-20020a5d6609000000b0031980c5486cmr3516648wru.5.1692119685864; Tue, 15 Aug
 2023 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813235231.591454-3-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Tue, 15 Aug 2023 22:44:34 +0530
Message-ID: <CAH=2NtyeiRyN1pwJ8ukXXbMiD6Yv2bUgYdoVkd4D4mM2f3Dw_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] ufs: Handle UFS 3.0 controllers
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Faiz Abbas <faiz_abbas@ti.com>
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

On Mon, 14 Aug 2023 at 05:23, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Extend the version check to handle UFS 3.0 controllers as well.
> Tested on R-Car S4 UFS 3.0 controller.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/ufs/ufs.c | 3 ++-
>  drivers/ufs/ufs.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 261ae2843c2..58830c8ddca 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>         if (hba->version != UFSHCI_VERSION_10 &&
>             hba->version != UFSHCI_VERSION_11 &&
>             hba->version != UFSHCI_VERSION_20 &&
> -           hba->version != UFSHCI_VERSION_21)
> +           hba->version != UFSHCI_VERSION_21 &&
> +           hba->version != UFSHCI_VERSION_30)
>                 dev_err(hba->dev, "invalid UFS version 0x%x\n",
>                         hba->version);
>
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 33ca5f29812..ef7728fc39e 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -781,6 +781,7 @@ enum {
>         UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
>         UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>         UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
> +       UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
>  };
>
>  /* Interrupt disable masks */
> --
> 2.40.1

SInce the Qualcomm UFS HC controllers are even newer / greater version
values, we can drop this patch in favour of my UFS patch here:
https://lists.denx.de/pipermail/u-boot/2023-August/527215.html

Thanks,
Bhupesh
