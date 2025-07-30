Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C2DC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164B082BA1;
	Wed, 30 Jul 2025 13:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OcOJIDxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D62882F00; Wed, 30 Jul 2025 13:23:04 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402EC80050
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-55b847a061dso24642e87.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753874581; x=1754479381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3E9sFfueVAsS11t+PQO/HJOUJXY0tBTK6GUDlpLFo4=;
 b=OcOJIDxC9wBHIbbilVLG8846vmOPR8EWNVDiiRauMURRDfbr1yGRLqpHYNhX/7Rqu4
 Bb4FHdWMzmma9AQrybIkmsLM4Ws/qZ1SHKUpvxgZNxBFK1U1S2VfTjCJuHb/yBkPChG7
 duD3AZvG1hEbE/WG7VsApKWQbhlXpER2NNQ5rTe1L6PnUpSbU/pUahBHkqKmxGSlt+Ke
 ZJivcKtLOqCfaLS+pvcFk6tCyNevdtMR6wucEyo+a6AyIefEL++Qdwd95uTO3w46sY5T
 h2cLbMnPJ2skwFF/kmD5XxO94LbOfuwrQiWOcZmZ4okrRRdVO1nBYiihQUXx4BlOLYfB
 qyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753874581; x=1754479381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3E9sFfueVAsS11t+PQO/HJOUJXY0tBTK6GUDlpLFo4=;
 b=iQpdHhxxs39ULjeaymUsU8qNDcvb002R4d9MyxGsIfXAS1hgsXk/zQ+EpgHqmk3zOO
 Fh5DFW7DhnsOzoOzDfueBpUJrlrw9ywoBwGsPAD0YrP7xjflhrjpLmYUxd+vHJTQse8x
 cFN4pXwXjv8SmBCzYXWnI4e0sm8s6CfdEE4PbwSVMDM6nOP99TXGx0KN98eeM9nE4NyQ
 nmcYxVBtKgN7ZMGQFGTm53fr7ppq8WOh9qyna7+GfJbgiq/vhGfkOfnLq0BJzgx7/nuy
 RFj+oDtJ3KB3P+UN8NWp9Jmoq3MitSi6U6oCmfmRGm+VA835muYSU1ge1rTJCLE3SXL2
 RqyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsmEZiOmBV2j6fDXyPnLAFfyRkgc8kcayzkulm8ZkMFHaubisX7buRFcqFE+4pEJUOY8GQjig=@lists.denx.de
X-Gm-Message-State: AOJu0YzHkAx92DMLSCIgc5R02TDNE6dHrz0NNZb/qyeIBbrRSZ2FYHbt
 S+RDYqF3iKZsUJ85MOTikiAXFQKD6Oou2J4joEAoSgnhKKn84OIB/pVKLSU0d227lZoQ2pYDoMj
 J0DEKnE4wdZXYeVGdPXbrOeFjBIOCy+U=
X-Gm-Gg: ASbGncvSEnsRZNxwq3OnSLFQqy7LEbkgb5MtkDAhAyd0vHi3sjUXAxSdoFs0OZB+66F
 +Ce3lhxJG2SB2iCEQ1Tj0oXGob7RZHw0b/BuS75bsvrDNi1BsSZcbLMMLPtUuP5F0LCLIoJIPWQ
 X+To8tTR3uX12NLRn3p/ipioyKbYD6BqxN+UCmcj0R+Amu9QPaoc2ai7tYtCfnqpEQyVRlQSoDD
 rdKA13PZtOuJNm2UXi+UNJccVq1yr5TxSEHQSWaqPxteey9cQ==
X-Google-Smtp-Source: AGHT+IGaETTcpaiaMBaNo+QhTPyfm8cQEF0Sald1Sih6DhcMJTqID3+jqhOvkkO+EVQk5rmhnjVVEj9oXzJnqoHuGFE=
X-Received: by 2002:a05:6512:1193:b0:55a:31ee:ee14 with SMTP id
 2adb3069b0e04-55b7c366fc3mr1106634e87.23.1753874581368; Wed, 30 Jul 2025
 04:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-4-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-4-73da75bb33d3@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jul 2025 08:22:49 -0300
X-Gm-Features: Ac12FXy2yrMsXFOC-TwmVsxmz7j8SFcpGsaqoGcYnMWWTuE1oqhvwPtr9AQEn3I
Message-ID: <CAOMZO5AN-Ju4WjRL4vK7zyy75AmsRtoOEmj9bM4S6O1NBKgHqQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] ddr: imx9: Disable dynamic refresh rate when do mr
 operation
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, "haidong.zheng" <haidong.zheng@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 27, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: "haidong.zheng" <haidong.zheng@nxp.com>


Haidong Zheng


>
> On i.MX93/91, dynamic refresh rate should be disabled before doing any
> MR read or write. Otherwise conflict may happen with read MR12/MR14 in
> ddr_init.
> We randomly meet DDR unstable with low drive mode frequencies and 1600MTS
> DDR setting on iMX91. With this fix, the issue is gone.
>
> Signed-off-by: haidong.zheng <haidong.zheng@nxp.com>

Haidong Zheng

> Tested-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/ddr/imx/imx9/ddr_init.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_i=
nit.c
> index 5a134dda78a331c21d4a75b2369c5b9314028bbc..42ba493ebca4d6efc5ee047dd=
3f049cebb24b69d 100644
> --- a/drivers/ddr/imx/imx9/ddr_init.c
> +++ b/drivers/ddr/imx/imx9/ddr_init.c
> @@ -266,6 +266,11 @@ void update_umctl2_rank_space_setting(struct dram_ti=
ming_info *dram_timing, unsi
>  u32 ddrc_mrr(u32 chip_select, u32 mode_reg_num, u32 *mode_reg_val)
>  {
>         u32 temp;
> +       u8 dyn_ref_rate_en =3D 0;
> +
> +       dyn_ref_rate_en =3D !!(readl(REG_DDR_SDRAM_CFG_3) & BIT(7));

Can you add a define for this BIT(7)?
