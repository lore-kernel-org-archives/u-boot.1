Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEB1C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 08:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F1387B82;
	Wed, 13 Mar 2024 09:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mXuyQ42L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D20E87DAF; Wed, 13 Mar 2024 09:57:42 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7122E875FA
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d3b93e992aso63191521fa.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710320260; x=1710925060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oSgDM5iWEqUFPEycvppmipfrg/7b3jDpBcC5kjWnvIM=;
 b=mXuyQ42L9jArqQWA50potgjQG+g8fdN2lafk0zIuy5bBWrq8l87OKLRTe28Ni7d6dh
 tPaeU06xgjSo/w/mu93OZ0RfjMOQAKOnjpvH7zrxh6ZhwzreuDlBr6pIGMkTRBxyg9kY
 XHN5rrdmy3H8z6hmorqU3ilQPQvmoTTzLzIFHgyy+jQOX388W6qSOPG/YHancKcU6SxB
 9Be0zoQz8OUacF9VFeKSynCqsSNCZ8gL8Kh+WoAwrfTKevjGAM4UZXPprQCHnVbnB+Wi
 Z11pdpoFHnmHWHDU4fFSqQo3thl7LpdfzwmFkTstfTTx8P6uLyMjyvTg7WS6U1qNrEWB
 u3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710320260; x=1710925060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSgDM5iWEqUFPEycvppmipfrg/7b3jDpBcC5kjWnvIM=;
 b=DnHkbPIk67XTnxaDAcfd2W8OQMXOOgjI2uYPzJnIUkVb910wFS4InvnMgJlz7WHC69
 fhbeIbZnYmNghCkKZSLu8IZUn7PqCeS6JPJkr6B+A63YsqmF4/eNWj+dyH9F8fYJBMFB
 LLf5S1Rt6kB0NS41uDq8YJplj56w8eHqjzT4eGvXJazSVUtPNgRBv3W8Np7jT+YPI0hD
 CqI/6WaiThdyozCDMknF/TFep+Ikf+VMQF6S3iQ0ez65UxFNdJpMJsz6abMMMQpmwShD
 M9sVLFrWl9Su+5Mu5FGlhcn3HJ3ZubmmHeozblSlzK/dnyCWV/QyExoi2ZhSB2H+YfMo
 GmHg==
X-Gm-Message-State: AOJu0YyKQBxqjEjxGnydUe/NgjLVAQtD82qVm5TlfPdnRqW9MMgiYvjx
 8tmLKt9Hp9oSFRYFmkF1aga5HZ0DbveJK+mrV0I2WCoob6Ii21NOBASrGpZUJYc=
X-Google-Smtp-Source: AGHT+IHr1ZMowIiZC/vz7ee16WvGXWOLI0tGfD+opSN9hX8h2pqQ37TtwVxrnB9CiTYI2/6NYffLUg==
X-Received: by 2002:a2e:bb97:0:b0:2d4:5cff:fc60 with SMTP id
 y23-20020a2ebb97000000b002d45cfffc60mr2201551lje.39.1710320259319; 
 Wed, 13 Mar 2024 01:57:39 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 f21-20020a50d555000000b0056835320f76sm5050616edj.8.2024.03.13.01.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 01:57:39 -0700 (PDT)
Date: Wed, 13 Mar 2024 11:57:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, n-francis@ti.com,
 michal.simek@amd.com, venkatesh.abbarapu@amd.com, git@amd.com,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mode
Message-ID: <7f71d88b-2f9d-4ddf-8253-7f020bcbf376@moroto.mountain>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
 <fc520c7b6ed4d84e28e2eb807f2e57b1847d3c93.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc520c7b6ed4d84e28e2eb807f2e57b1847d3c93.1710098033.git.tejas.arvind.bhumkar@amd.com>
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

> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index faf02c7778..5895b5de09 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1511,8 +1511,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  	info = spi_nor_ids;
>  	for (; info->name; info++) {
>  		if (info->id_len) {
> -			if (!memcmp(info->id, id, info->id_len))
> +			if ((!memcmp(info->id, id, info->id_len)) &&
> +			    memcpy(nor->spi->device_id, id, SPI_NOR_MAX_ID_LEN)) {

Please, don't put a memcpy() into a condition.  It looks like a memcmp()
to the eye.

>  				return info;
> +			}

		if (!memcmp(info->id, id, info->id_len)) {
			memcpy(nor->spi->device_id, id, SPI_NOR_MAX_ID_LEN);
			return info;
		}

>  		}
>  	}
>  

[ snip ]

>  static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  				   const struct spi_mem_op *op)
>  {
> @@ -353,6 +649,9 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  		break;
>  	}
>  
> +	if (op->cmd.dtr)
> +		err = cadence_spi_setup_ddrmode(spi, op);
> +
>  	return err;


I think there should be another if (err) return err after the end of the
switch statement.

>  }
>  

regards,
dan carpenter
