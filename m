Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4E1C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 18:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93AAC82103;
	Wed,  2 Jul 2025 20:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZNAiwF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0184E82A76; Wed,  2 Jul 2025 20:56:35 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90F881FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 20:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d442192c67so63340985a.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751482591; x=1752087391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fX57ZbdDjENsAnXRTS2mlyq9Hib3Iaa3sX/7lXYsNF0=;
 b=PZNAiwF1uphCI4fDSjvC7I8qph9D+ebx8yXlZ4/WxYvFlrm8+HXKJ7glZMDDgGEYob
 mZYNLnaaNd6dEzRsI6ayydiRhhuWL2+C8qrkLYPiKy9rv5tW5dlHwOItOqLPXZSW19mU
 nJQQj3kbOcnpDaR4TOIcbYNYuZsGBijWFRciX1hYb/FCAXrppLes1IsSKDFQDbLVz5O7
 2tZE9VcWM8LCQMFPjMxkLetOHgtBosxq8WdLn9azvvfagRCR98pGz0crBvbY20ZUZxbi
 z8GNwm+fY0Z4tMYxbcl+RWQg+lWoIPhbNLGlfrjb2H1+MX7vKSvBA/20Qg3DRvFsLCt1
 nEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482591; x=1752087391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fX57ZbdDjENsAnXRTS2mlyq9Hib3Iaa3sX/7lXYsNF0=;
 b=nS4KG26s3JMwS3WodA7qGN2KoROxFxKRPhDxa86p/JbaRao41UWOjaXpNWq8xp+z9/
 AjVzKIqccZ9OIPyvo0wIypnmVHADyEpWJHNndG7rWFmpzY1IY9vZii6r5Wx0BvJ8rIk5
 X1qwQZZ444ocEB9tcxQol4t2hoicHRfjTxyRwWJIuiiRFLYmjQwflsOaneSrxSlkf+bv
 KfpAh4s14dC1IdAUFrpjH2e/atusArtzaUSZbCl5JmWB2Bf5KMQPEIbP14YbFFz6bFkE
 jwO03uEcGXNewTFn3o/s8PIdlAvpQ77U2HDrlca4VJa7AUcCwg0xOOB5Lm6XG5VqJgHd
 TIeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsUeJ5tC4sRExlWEcY5WHqtiWaQDma8F5cX94S0SCVDdmNdxilH9/+EONTiYrBWOIhHR0M/jM=@lists.denx.de
X-Gm-Message-State: AOJu0YylfaQPpSsrfCxAx+7lwCiZk3ulPIdb6hXgZFvz4ddeXSo50Pxp
 NybmYENnzfvBxATsYjl+oWrgmzIwjnHQzBMlax114TaNrHc/lIcKxnqJ
X-Gm-Gg: ASbGncsDD0oihc6y0IalAdG9CpTfXtIf0Yb/nlRMgdQiv697xa4U1wuqUGeb2rzPfE7
 C8PjEyL+JkRByC5xRumYdZJSnCimYfA3mRqOObCoE06upC6HTnf6hyV5Lcv65+wpt6bcXQ30lFS
 pJTA6U1/0SVSj/ePCSYKSZivOn7QDgS5sXnfPAOP9I9uBDt3X7T17pRvFbdefBz33PwVua2drqN
 ltMA5SiEjmP/iiPKlCZ3t7zFgTBk7aBGqQlPqaKqyJi+IwDb+lSKkmdiAN8SL71ozy7XLwj92td
 dgPlQNGKBIGIFMlivFQ4KazXkjmEJqhEl/bf7jkC1qa0WUtiWmDKGI1C5ZpSOIpDcUOP5jpXiFD
 wQor5HKLakez7oaFOms67GnowRyGKZfikvR5aLg==
X-Google-Smtp-Source: AGHT+IH+QIoKqgi3rPQT2/swXz+GiwRPNDVwyF9+/V8IXj2QQ3LZrkLDso7OtB+cb6Li95MyT9RJbQ==
X-Received: by 2002:a05:620a:404c:b0:7c0:be0e:cb09 with SMTP id
 af79cd13be357-7d5c469ea56mr189480185a.7.1751482591255; 
 Wed, 02 Jul 2025 11:56:31 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net.
 [108.48.176.137]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204d45sm987211385a.60.2025.07.02.11.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 11:56:30 -0700 (PDT)
Message-ID: <03c84e50-1383-f71c-7163-794ff15f1e8a@gmail.com>
Date: Wed, 2 Jul 2025 14:56:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: cadence_qspi: Fix odd byte write issue in STIG mode
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: tudor.ambarus@linaro.org, j-humphreys@ti.com, marex@denx.de,
 michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20250702045951.637071-1-venkatesh.abbarapu@amd.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250702045951.637071-1-venkatesh.abbarapu@amd.com>
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

On 7/2/25 00:59, Venkatesh Yadav Abbarapu wrote:
> Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
> mode for all ops with small payload") the utilization of STIG mode
> has been implemented for read and write operations involving less
> than 8 bytes of data.
> 
> However, following this commit, encountering timeout issues occurs when
> writing odd bytes of data in DDR mode, as indicated below:
> "jedec_spi_nor flash@0: flash operation timed out
> SF: 3 bytes @ 0x0 Written: ERROR -110"
> 
> To resolve this issue, the number of bytes to write has been updated
> specifically for DDR mode.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_qspi_apb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index b579699d2eb..c38bb523806 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>   	void *reg_base = priv->regbase;
>   	u8 opcode;
>   
> +	if (priv->dtr)
> +		txlen = ((txlen % 2) != 0) ? (txlen + 1) : txlen;
> +

txlen += txlen & 1;

>   	if (priv->dtr)
>   		opcode = op->cmd.opcode >> 8;
>   	else

