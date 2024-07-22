Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 10:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A87387EDC;
	Mon, 22 Jul 2024 12:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="p1jvCl2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E23881BA; Mon, 22 Jul 2024 12:10:59 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1126387E50
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a728f74c23dso425961166b.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721643056; x=1722247856;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWZogHHW7C2djClTaBNEChCRXsmmHuQw0kI0b/LDwZQ=;
 b=p1jvCl2IzHnr9tQQXcZBMJ6t1Mf416FLErulXtm7FN8cBN6Ag3BWAiUiS2fqg4jYpP
 x0d1tJoQ1VwrCrxcAsU3hXwTpfXsM3L08xxJ3jLo2W9VDl5kvqBS8wKJWs2qipPJyZgh
 zltBw+OHebWz5DgvPVezd9iXvL2MGDYB2SHA6ySwLqDkGm9Qy2yoHsnFU1cCHhsA7CR8
 U6VWKDYxPGkgvMVBEk85Yr5GA5SqwB7FxogP3U1V/js3KI6JLEUxLEvRxoSjZNPPJ5ac
 9ijAHgIF9iV5bbCjm7nvO+gxbE6IOo9fsI7edYu4ITfErrVOHq4xro4Q6Ae7ngwYdWb5
 kvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721643056; x=1722247856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWZogHHW7C2djClTaBNEChCRXsmmHuQw0kI0b/LDwZQ=;
 b=CJJvJ3OEC6QWoLYWiZEjfdarvSDFTJ+DAjFLzgh82f+hdd3uSe0B+L8/QtYFeW4Ypw
 sD/cYcVbsjr4Wr1oght/iSSvvrtZk6nilq+136aKm44gzovWaIbifgnuFg6H3QHNqeBN
 HCmdoNcrHpn88hi9XDWyAGAYH40nwgs4AIQRwr+SEesHuoHgbfhAwSrdIHoYISU2B/dl
 cOg76X9f+tjl78tx2aa3tma4xYH1zvvhcLw/doKcS35X8QCO1xTkjJCUKN2S7RI3wtEH
 fTAXm8cfEiObQVY1P9UsOW/qZty2ag3bi2nMNx4L0U1xXBK3jRmYIY+Injie5bPLFUNi
 GsdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRVBRlkNY7HehoiUSUMx6g1VG6ieqXBzsMYJ3r9v45YUBaQUU6/gSGAj3TWHL/kL6b1tfEH2ga8lzFZhhQoxG9EVq+Jg==
X-Gm-Message-State: AOJu0YzdqbYDlsSlXFb2y0U7N8iGwAN1MaVAvWHN8e1OvcQbffBgeLpo
 L43Sqq5qBI8UYeDl7aB7XYZGG/76P8xe1QgPOz+8UOUUNDkTQ+4H5HQbfuqseg==
X-Google-Smtp-Source: AGHT+IGJBKCYZDX+XTptE5MPP5VCUPg+VEUJqFoOia6au8wH+BO0K9vywu2PDv8T7zEHsBc5o/2LPA==
X-Received: by 2002:a17:907:980d:b0:a77:cf9d:f49b with SMTP id
 a640c23a62f3a-a7a4c449037mr374340966b.54.1721643056589; 
 Mon, 22 Jul 2024 03:10:56 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c951169sm404006266b.213.2024.07.22.03.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:10:56 -0700 (PDT)
Message-ID: <ec6b68c0-99fc-40c6-8faa-8b5f97680c8a@monstr.eu>
Date: Mon, 22 Jul 2024 12:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/40] drivers: spi: Remove duplicate newlines
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
 <20240720124239.7553-33-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20240720124239.7553-33-marek.vasut+renesas@mailbox.org>
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



On 7/20/24 14:40, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   drivers/spi/atcspi200_spi.c  | 1 -
>   drivers/spi/ath79_spi.c      | 1 -
>   drivers/spi/davinci_spi.c    | 1 -
>   drivers/spi/mxc_spi.c        | 1 -
>   drivers/spi/spi-aspeed-smc.c | 1 -
>   drivers/spi/zynq_spi.c       | 1 -
>   6 files changed, 6 deletions(-)
> 
> diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
> index 929bf90458c..2178534baf0 100644
> --- a/drivers/spi/atcspi200_spi.c
> +++ b/drivers/spi/atcspi200_spi.c
> @@ -186,7 +186,6 @@ static int __nspi_espi_rx(struct nds_spi_slave *ns, void *din, unsigned int byte
>   	return bytes;
>   }
>   
> -
>   static int __atcspi200_spi_xfer(struct nds_spi_slave *ns,
>   		unsigned int bitlen,  const void *data_out, void *data_in,
>   		unsigned long flags)
> diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
> index faefac71260..fb2d77d7d4a 100644
> --- a/drivers/spi/ath79_spi.c
> +++ b/drivers/spi/ath79_spi.c
> @@ -133,7 +133,6 @@ static int ath79_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   	return 0;
>   }
>   
> -
>   static int ath79_spi_set_speed(struct udevice *bus, uint speed)
>   {
>   	struct ath79_spi_priv *priv = dev_get_priv(bus);
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 04c134be9ed..82049872d05 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -207,7 +207,6 @@ static int davinci_spi_read_write(struct davinci_spi_slave *ds, unsigned
>   	return 0;
>   }
>   
> -
>   static int __davinci_spi_claim_bus(struct davinci_spi_slave *ds, int cs)
>   {
>   	unsigned int mode = 0, scalar;
> diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
> index ff61a14f095..e7c393ae188 100644
> --- a/drivers/spi/mxc_spi.c
> +++ b/drivers/spi/mxc_spi.c
> @@ -622,7 +622,6 @@ static int mxc_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   {
>   	struct mxc_spi_slave *mxcs = dev_get_plat(dev->parent);
>   
> -
>   	return mxc_spi_xfer_internal(mxcs, bitlen, dout, din, flags);
>   }
>   
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index d91d58da459..12320367e97 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -960,7 +960,6 @@ static int aspeed_spi_ctrl_init(struct udevice *bus)
>   		return 0;
>   	}
>   
> -
>   	ret = aspeed_spi_read_fixed_decoded_ranges(bus);
>   	if (ret != 0)
>   		return ret;
> diff --git a/drivers/spi/zynq_spi.c b/drivers/spi/zynq_spi.c
> index ebcb5b6cc88..d15d91a1d24 100644
> --- a/drivers/spi/zynq_spi.c
> +++ b/drivers/spi/zynq_spi.c
> @@ -53,7 +53,6 @@ struct zynq_spi_regs {
>   	u32 rxdr;	/* 0x20 */
>   };
>   
> -
>   /* zynq spi platform data */
>   struct zynq_spi_plat {
>   	struct zynq_spi_regs *regs;

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

