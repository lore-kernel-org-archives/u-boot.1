Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0E6C25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 06:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F468801A;
	Thu, 16 May 2024 08:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715841911;
	bh=RmzJqcge3pXMHB6F0YJdhDKUjXIVzJ6HzAqkltT9+9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pLwDdsuhsjEdW3ATaDBVXzp2nwoSMffFiI0L2qieOOOz0dF8BEmFUd6Go7ksqetA5
	 Jfsi9vmz8/Mbv2lnFUI4OGGZCATI1QIFSHn7UiK2taNcr+Jmq+WqqQAWVUIEKJqINy
	 iAxMicY1K7J9LvqoFsMDw97azeY4Z+Kz6DeWN2xrcq2uUUCXNkRh1tYI6wdLAeai66
	 i72rtAe03NZbLG1YJfRSNEhkRKvtZFnrxi3yDcy1heoMtA9e5waA3vxxoJPaYs5tAC
	 dHyFUGSpobOTXyU7dYO4Z3Fuf97cDqBiB+NpoxPa4MYPIOLkynx5F7MlzbhxB2qNGl
	 08DYGkbnoXXuA==
Received: from [192.168.1.107] (82-131-204-184.pool.digikabel.hu
 [82.131.204.184])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D1F3287ED1;
 Thu, 16 May 2024 08:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715841910;
 bh=RmzJqcge3pXMHB6F0YJdhDKUjXIVzJ6HzAqkltT9+9w=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=kmXmf7sh+MEb6ye5+SdkOfFBSDQfIKPOG4T6SNTh/q/0qaLF8XWv9dHDf8T2jDue5
 RZS6gqSaFRMS80FJtbpfyuSwxVQX6i9CmmlxC+D9Czl37TIke1uTRXus4MfqBXXti6
 RcmBez97U311YCEy8hGC75ZDzC6x33Oz41BplAgUWKzxHW8GNP/lW8W23Bi9fYyNwL
 10lmo8YpNAtZ5Tae+HYWwdMtxll4n2VEXB7hfVE9kAp9auo/6ndOqyeCwu0Y7vmJav
 XOzO9tmLzEse9l18tIdGJugkUC9DvsG00UtA1JyKaFmbz4Gpr7iBFRrPwIFoF9lraQ
 xzVNfVo2iKUuw==
Message-ID: <cdf126e8-b1d4-653f-0f10-17afd1851d73@denx.de>
Date: Thu, 16 May 2024 08:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/11] i2c: Add support for ADI SC5XX-family I2C peripheral
Content-Language: en-US
To: Greg Malysa <greg.malysa@timesys.com>, u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
 <20240515215837.14028-6-greg.malysa@timesys.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240515215837.14028-6-greg.malysa@timesys.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Greg,

On 15.05.24 23:57, Greg Malysa wrote:
> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Co-developed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
> 
>   MAINTAINERS           |   1 +
>   drivers/i2c/Kconfig   |   7 +
>   drivers/i2c/Makefile  |   1 +
>   drivers/i2c/adi_i2c.c | 393 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 402 insertions(+)
>   create mode 100644 drivers/i2c/adi_i2c.c

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
