Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F65606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IijS1bGc;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=en7mmdtz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78C4A605EC;
	Fri, 30 Oct 2026 08:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48XU0FvI1VZD; Fri, 30 Oct 2026 08:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D95E606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350758;
	b=qsM9kkcNHManfKjo3BbgF1bqugBgoawMEOjOJIiU0UZbJgq2NflA3iOK/j0ILE8becR0
	 jgMoJkI60e6ROivU5qJWqPtbJjRAk46azdF2VDIcbzjkxDZAmhOo3wWeLo2lkg2gNij8/
	 u3SlhilubgdMQicPINSq1lZyBewyc5Kx/IE8IN+IUOhtKiMsjvzKNZm0eYRbTJxxL4fH1
	 qXqx2JnDMGXe8rfktq95QABlkYUoQiHGPNDYkxg/f0yV9kBmRyBL8DgXT8WNr69lri6GG
	 zJ3ptpusbTuI9kdVQ1puaitaPvhrBk1PssLsqGGyrfSxsdv1qm247fUZCJSEh5l9URQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZFbZD1si1VunTn3V9HMtO9sbHcgWbNfkVP3dNwanMwc=;
	b=iBO2fWgcwGLvX2aQsWUIjQeQHQyz1JlQmsmfGx+E+PWqUPU0FhmcrcQbDov7KVrwwAID
	 OtZU5w8pUhrgHqWHe30P7VAlPNqYSg1k3WDETph6gk8+nZb5bswhWidkJK8NccZRXAmA3
	 8Ycdup2DTGm2MAaXemNVbKCKS6uWb+wZZuopQMVjwoyEJzj2YaRch+++WtK0j6fPSk2W1
	 OoNh8NYqAH4xiUXh3bNxqXKMH7ZkOP/+NWtvuRpDy2ekia3EEaFpcHBLQA+F3F5hg1oGW
	 alLg31bOQVOmJ5O9holJ298EmDGYlFPVGLi+muly0Yv2NTHv23SZu+7dJvXSg1Q8VLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793350758;
	bh=ZFbZD1si1VunTn3V9HMtO9sbHcgWbNfkVP3dNwanMwc=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IijS1bGcPJm2N0OPmylqiet2QDIB03Pe0krSFMdPM7vJx7OpJvyxGWytzd2w4bYVA
	 dZL4N2PBEbDsEskM/BmB+IyZfbqYBN/kEb/Cj1JX/EOhoccycK/NS0FjxhvM6krmPv
	 Zcn0vabz7Z/gM5bUFAU+4DRbkT2r225JkDrRbermysDLy6njnOYN7OyN+dXpi1lcMs
	 7GK7tI9GoWkpAJZ2vOfyYVN3vDe3kWQpHLD2/2Yn0/JKsHcXY8r48tDhHd9xvfXwmB
	 60/wJTB6T2xyjACiVKpoPPzVxuW++5Dm7mHEK6jbEPUS6zgfXeZtL21oUbX7/PljIx
	 C6Vj8G6rz4/Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D95E606A7;
	Fri, 30 Oct 2026 08:59:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFFE0473
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A12E780981
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3-KlKqLIxjG for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EFEB68096E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350755;
 b=G7o7tRM88fle/NamB6DTRhe/w3KhKEb+kzkrI80tW3d5IeKn3FWGyYnbCP7vD1gR6hPJ
 cCy7DbExiw/+e6J2X8luwFx2ycbq6qoI3aF5EIcL/kihBNrlhVMh/F/rhU4w6TBm3G+WD
 RhXP5iwhDdW06wtmXIsn91uFE9mwxjS+sDXsyiv1t2SOMN9LjnRK/pbayCDhWtrd5zW6n
 k4CazvK0q1pdrXlaoLyuTzdWdlw3oNem3Ff+aOgCwObPkWW4qA+IQAk8SUwfXwPFO20zw
 N1k9rzdMFPvMwmF8iv2mNNek6QEHT0FhBT9K69gzBu3yQLyHSPouL3g7X5KyPes2VWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350755;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=ZFbZD1si1VunTn3V9HMtO9sbHcgWbNfkVP3dNwanMwc=;
 b=XvelkOhjetswF0JRsne+X2OIb8+f9LCVZCGawIEWdHYtmZWk2KBBGUPJMzbXpzMMgw9I
 HwvCeoQVV9bncvq5tIEAWFVNvwM/pM2571Qibh8GyThT52/ngOp60yVoiMmPCYZ3E7ZiS
 x9HgnrBarmdpeowgGw8JqhX+bB7d77Fkw2r0KIOp+v92Arqu5zLSEIWo0PMEbJkbAKqjr
 AHnKw45qrIMJ8Kf+QqvkRai9LRim9jTeN6wu6/58J7x0vVqxZOl46GbDicGnlTWrnfWpG
 sI6yrUtpSctGhqt7ho+4rHeiPkp3apxpxA/tX+CkQ+gKZ2vUcOFRBYRmanjZM/3m2LQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=en7mmdtz; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=en7mmdtz
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFEB68096E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:59:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4254610A05F; Fri, 30 Oct 2026 09:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793350747;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZFbZD1si1VunTn3V9HMtO9sbHcgWbNfkVP3dNwanMwc=;
 b=en7mmdtz6O/pNv6r50qhAhfgfPCFz8RMyPK7Ft5WFRe5JDDqHlPIe9E4rQ+MhgUda9pPL9
 dhYHKwbBdMNGextiRFEUxW9PQq2nR4i8BrWx+al+L5KWnA5+R7XLvrjzoiBuPSHmoyVJ+7
 tf6a5qUyHi1w+gw4Rq9QluSE6qvXtP+XPRApeC+5WB5W0WAItXZV61o4F2CEV9ZnCbGzdq
 V68o21YHJkEM4i0Mdu7aCGJs3q5BMt6zp9wabeban6bd+u+HHRdF7WOgC5Zlswb1hWgpkP
 o6uGEuylVTVwbb26aS3iuxEBUYHa2ImzeeY4lZZT8NaZ0tgHuXKiw3TCpN4XHg==
Message-ID: <b11efa7b-e027-76d4-8f13-0efac5fdf315@nabladev.com>
Date: Fri, 30 Oct 2026 09:57:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Giau Nguyen <nguyenanhgiau1008@gmail.com>, u-boot@lists.u-boot-project.org
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com
References: <0a36eb46-539f-8e47-02db-5dfe91a9bab2@nabladev.com>
 <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
In-Reply-To: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Giau,

On 28.10.26 12:30, Giau Nguyen wrote:
> Mainline U-Boot currently lacks an I2C controller driver for the
> Broadcom BCM2711 SoC (Raspberry Pi 4).
> 
> This commit adds a new DM-compliant I2C driver for Broadcom
> BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.

May you add here the linux commit ID which was the base for this port?

> 
> The driver dynamically queries the actual VPU core clock rate from
> the VideoCore firmware via mailbox property messages to calculate
> the CDIV clock divider, ensuring accurate I2C timing and baud rates
> on BCM2711.
> 
> Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
> 
> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> ---
> v2:
>   - Clarified commit message: U-Boot mainline currently lacks BCM2711 I2C driver.
>   - Fixed line endings and code formatting per checkpatch.pl.
>   - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction.
>   - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard readl/writel.
>   - Moved mailbox clock querying to bcm2835_get_clock_rate() in mach-bcm283x.
>   - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>   - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
>   - Removed 'Assisted by AI' tag.
> 
>   MAINTAINERS                              |   1 +
>   arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>   arch/arm/mach-bcm283x/msg.c              |  22 ++

For this parts, it would be nice to get some comment from Peter or Matthias,
just some dummy question below.

>   configs/rpi_4_defconfig                  |   4 +
>   drivers/i2c/Kconfig                      |  10 +
>   drivers/i2c/Makefile                     |   1 +
>   drivers/i2c/i2c-bcm2835.c                | 370 +++++++++++++++++++++++
>   7 files changed, 417 insertions(+)
>   create mode 100644 drivers/i2c/i2c-bcm2835.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d273603ac64..53bf76964de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -277,6 +277,7 @@ S:	Maintained
>   F:	arch/arm/mach-bcm283x/
>   F:	board/raspberrypi/
>   F:	drivers/gpio/bcm2835_gpio.c
> +F:	drivers/i2c/i2c-bcm2835.c
>   F:	drivers/mmc/bcm2835_sdhci.c
>   F:	drivers/mmc/bcm2835_sdhost.c
>   F:	drivers/serial/serial_bcm283x_mu.c
> diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bcm283x/include/mach/msg.h
> index e54da86e353..d6adec07ae2 100644
> --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
>    */
>   int bcm2835_get_mmc_clock(u32 clock_id);
>   
> +/**
> + * bcm2835_get_clock_rate() - get the current rate of a clock
> + *
> + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_...)
> + * @rate: Returns the clock rate in Hz
> + * Return: 0 if OK, -EIO or -EINVAL on error
> + */
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
> +
>   /**
>    * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost cdiv
>    *
> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> index 05e1a02e80f..b8917662b31 100644
> --- a/arch/arm/mach-bcm283x/msg.c
> +++ b/arch/arm/mach-bcm283x/msg.c
> @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
>   	return clock_rate;
>   }
>   
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> +	int ret;
> +
> +	BCM2835_MBOX_INIT_HDR(msg_clk);
> +	BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> +	msg_clk->get_clock_rate.body.req.clock_id = clock_id;
> +
> +	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_clk->hdr);
> +	if (ret) {
> +		printf("bcm2835: Could not query clock rate for %u\n", clock_id);
> +		return -EIO;
> +	}
> +
> +	*rate = msg_clk->get_clock_rate.body.resp.rate_hz;
> +	if (!*rate)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +

maybe bcm2835_get_mmc_clock() can use above function?

And for me the question raises, if i2c part does not also need such a
bcm2835_power_on_module() call as it is in bcm2835_get_mmc_clock() ?

But I have no glue about this SoC...

>   int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock, msg_sdhost_clk, 1);
> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> index 850f8c7d1c6..b6f97d8635b 100644
> --- a/configs/rpi_4_defconfig
> +++ b/configs/rpi_4_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="U-Boot> "
>   CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
> @@ -37,6 +38,9 @@ CONFIG_DM_DMA=y
>   CONFIG_DFU_MMC=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
>   CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +CONFIG_I2C=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_BCM2835=y
>   CONFIG_BCM2835_GPIO=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 0b5225fd3f5..191083c9184 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -171,6 +171,16 @@ config SYS_I2C_AT91
>   	  i2c-gpio driver unless your system can cope with this limitation.
>   	  Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
>   
> +config SYS_I2C_BCM2835
> +	bool "BCM2835 I2C controller"
> +	depends on DM_I2C
> +	help
> +	  Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
> +	  This driver provides standard I2C support for Raspberry Pi
> +	  devices, including the newer Raspberry Pi 4. It dynamically
> +	  calculates the clock divider based on the VPU core clock
> +	  queried via the firmware mailbox.
> +
>   config SYS_I2C_IPROC
>   	bool "Broadcom I2C driver"
>   	depends on DM_I2C
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index 79e6a298808..41378a71d1d 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) += sun6i_p2wi.o
>   obj-$(CONFIG_SYS_I2C_SUN8I_RSB) += sun8i_rsb.o
>   obj-$(CONFIG_SYS_I2C_SYNQUACER) += synquacer_i2c.o
>   obj-$(CONFIG_SYS_I2C_TEGRA) += tegra_i2c.o
> +obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o

For me this look not in alphabetical order... may I was unclear,
the CONFIG symbols are sorted, not the filenames, sorry.


>   obj-$(CONFIG_SYS_I2C_UNIPHIER) += i2c-uniphier.o
>   obj-$(CONFIG_SYS_I2C_UNIPHIER_F) += i2c-uniphier-f.o
>   obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> new file mode 100644
> index 00000000000..e6abb076bdb
> --- /dev/null
> +++ b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM2835 I2C controller driver
> + * (C) Copyright 2026
> + *
> + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> + */
> +
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch/mbox.h>
> +#include <asm/arch/msg.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <i2c.h>
> +#include <time.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#define BCM2835_I2C_C_READ	BIT(0)
> +#define BCM2835_I2C_C_CLEAR	BIT(4) /* bits 4 and 5 both clear */
> +#define BCM2835_I2C_C_ST	BIT(7)
> +#define BCM2835_I2C_C_INTD	BIT(8)
> +#define BCM2835_I2C_C_INTT	BIT(9)
> +#define BCM2835_I2C_C_INTR	BIT(10)
> +#define BCM2835_I2C_C_I2CEN	BIT(15)
> +
> +#define BCM2835_I2C_S_TA	BIT(0)
> +#define BCM2835_I2C_S_DONE	BIT(1)
> +#define BCM2835_I2C_S_TXW	BIT(2)
> +#define BCM2835_I2C_S_RXR	BIT(3)
> +#define BCM2835_I2C_S_TXD	BIT(4)
> +#define BCM2835_I2C_S_RXD	BIT(5)
> +#define BCM2835_I2C_S_TXE	BIT(6)
> +#define BCM2835_I2C_S_RXF	BIT(7)
> +#define BCM2835_I2C_S_ERR	BIT(8)
> +#define BCM2835_I2C_S_CLKT	BIT(9)
> +#define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
> +
> +#define BCM2835_I2C_FEDL_SHIFT	16
> +#define BCM2835_I2C_REDL_SHIFT	0
> +
> +#define BCM2835_I2C_CDIV_MIN	0x0002
> +#define BCM2835_I2C_CDIV_MAX	0xFFFE
> +
> +#define BCM2835_I2C_CLKT_TOUT_MS 35
> +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
> +
> +struct bcm2835_i2c_regs {
> +	u32 c;
> +	u32 s;
> +	u32 dlen;
> +	u32 a;
> +	u32 fifo;
> +	u32 div;
> +	u32 del;
> +	u32 clkt;
> +};
> +
> +struct bcm2835_i2c_priv {
> +	struct bcm2835_i2c_regs __iomem *regs;
> +	ulong input_rate;
> +	size_t msg_buf_remaining;
> +	u8 *msg_buf;
> +	struct i2c_msg *curr_msg;
> +	int msg_err;
> +	int num_msgs;
> +};
> +
> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +
> +	while (i2c_dev->msg_buf_remaining) {
> +		if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
> +			break;
> +
> +		writel(*i2c_dev->msg_buf, &regs->fifo);
> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}
> +}
> +
> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +
> +	while (i2c_dev->msg_buf_remaining) {
> +		if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
> +			break;
> +
> +		*i2c_dev->msg_buf = readl(&regs->fifo);
> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}
> +}
> +
> +static int bcm2835_i2c_calc_divider(unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	int divider = DIV_ROUND_UP(parent_rate, rate);
> +
> +	/*
> +	 * Per the datasheet, the register is always interpreted as an even
> +	 * number, by rounding down. In other words, the LSB is ignored. So,
> +	 * if the LSB is set, increment the divider to avoid any issue.
> +	 */
> +	if (divider & 1)
> +		divider++;
> +
> +	if (divider < BCM2835_I2C_CDIV_MIN ||
> +	    divider > BCM2835_I2C_CDIV_MAX)
> +		return -EINVAL;
> +
> +	return divider;
> +}
> +
> +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
> +{
> +	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(bus);
> +	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +	ulong parent_rate = i2c_dev->input_rate;
> +	u32 redl, fedl;
> +	u32 clk_tout;
> +	int divider;
> +
> +	if (!rate || !parent_rate)
> +		return -EINVAL;
> +
> +	divider = bcm2835_i2c_calc_divider(rate, parent_rate);
> +	if (divider < 0)
> +		return divider;
> +
> +	writel(divider, &regs->div);
> +
> +	/*
> +	 * Number of core clocks to wait after falling edge before
> +	 * outputting the next data bit. Note that both FEDL and REDL
> +	 * can't be greater than CDIV/2.
> +	 */
> +	fedl = max_t(u32, divider / 16, 1);
> +
> +	/*
> +	 * Number of core clocks to wait after rising edge before
> +	 * sampling the next incoming data bit.
> +	 */
> +	redl = max_t(u32, divider / 4, 1);
> +
> +	writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
> +	       (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
> +
> +	/*
> +	 * Set the clock stretch timeout.
> +	 */
> +	if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> +		clk_tout = 0xffff;
> +	else
> +		clk_tout = BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> +
> +	writel(clk_tout, &regs->clkt);
> +
> +	return 0;
> +}
> +
> +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +	u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> +	struct i2c_msg *msg = i2c_dev->curr_msg;
> +	bool last_msg = (i2c_dev->num_msgs == 1);
> +
> +	if (!i2c_dev->num_msgs)
> +		return;
> +
> +	i2c_dev->num_msgs--;
> +	i2c_dev->msg_buf = msg->buf;
> +	i2c_dev->msg_buf_remaining = msg->len;
> +
> +	if (msg->flags & I2C_M_RD)
> +		c |= BCM2835_I2C_C_READ;
> +	else
> +		c |= BCM2835_I2C_C_INTT;
> +
> +	if (last_msg)
> +		c |= BCM2835_I2C_C_INTD;
> +
> +	writel(msg->addr, &regs->a);
> +	writel(msg->len, &regs->dlen);
> +	writel(c, &regs->c);
> +}
> +
> +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	i2c_dev->curr_msg = NULL;
> +	i2c_dev->num_msgs = 0;
> +	i2c_dev->msg_buf = NULL;
> +	i2c_dev->msg_buf_remaining = 0;
> +}
> +
> +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
> +{
> +	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(dev);
> +	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +	bool ignore_nak = false;
> +	bool done = false;
> +	ulong start;
> +	int i;
> +	u32 val, err;
> +	int ret = 0;
> +
> +	if (!msgs || count <= 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < count; i++) {
> +		if (msgs[i].flags & I2C_M_TEN)
> +			return -EOPNOTSUPP;
> +		if (msgs[i].flags & I2C_M_RD) {
> +			if (i < count - 1) {
> +				dev_err(dev, "read message must be last\n");
> +				return -EOPNOTSUPP;
> +			}
> +		}
> +		if (msgs[i].len > 0xffff)
> +			return -EINVAL;
> +		if (msgs[i].flags & I2C_M_IGNORE_NAK)
> +			ignore_nak = true;
> +	}
> +
> +	/* Clear stale status and FIFO state before starting a new transaction. */
> +	writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +	       &regs->s);
> +
> +	i2c_dev->curr_msg = msgs;
> +	i2c_dev->num_msgs = count;
> +	i2c_dev->msg_err = 0;
> +
> +	bcm2835_i2c_start_transfer(i2c_dev);
> +	start = get_timer(0);
> +	while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> +		val = readl(&regs->s);
> +
> +		err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
> +		if (err && !(val & BCM2835_I2C_S_TA))
> +			i2c_dev->msg_err = err;
> +
> +		if (val & BCM2835_I2C_S_DONE) {
> +			if (!i2c_dev->curr_msg) {
> +				dev_err(dev, "unexpected completion status\n");
> +			} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
> +				bcm2835_drain_rxfifo(i2c_dev);
> +				val = readl(&regs->s);
> +			}
> +
> +			if ((val & BCM2835_I2C_S_RXD) ||
> +			    i2c_dev->msg_buf_remaining)
> +				i2c_dev->msg_err = BCM2835_I2C_S_LEN;
> +			done = true;
> +			break;
> +		}
> +
> +		if (val & BCM2835_I2C_S_TXW) {
> +			if (!i2c_dev->msg_buf_remaining) {
> +				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
> +				break;
> +			}
> +
> +			bcm2835_fill_txfifo(i2c_dev);
> +
> +			if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf_remaining) {
> +				i2c_dev->curr_msg++;
> +				bcm2835_i2c_start_transfer(i2c_dev);
> +			}
> +		}
> +
> +		if (val & BCM2835_I2C_S_RXR) {
> +			if (!i2c_dev->msg_buf_remaining) {
> +				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
> +				break;
> +			}
> +
> +			bcm2835_drain_rxfifo(i2c_dev);
> +		}
> +		udelay(1);
> +	}
> +
> +	if (!done) {
> +		val = readl(&regs->s);
> +		dev_err(dev, "transfer timeout: status=%08x remaining=%zu\n",
> +			val, i2c_dev->msg_buf_remaining);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	/* Always abort/reset the controller and clear W1C status bits. */
> +	writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +	       &regs->s);
> +
> +	bcm2835_i2c_finish_transfer(i2c_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (ignore_nak)
> +		i2c_dev->msg_err &= ~BCM2835_I2C_S_ERR;
> +
> +	if (!i2c_dev->msg_err)
> +		return 0;
> +
> +	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
> +		return -EREMOTEIO;
> +
> +	return -EIO;
> +}
> +
> +static const struct dm_i2c_ops bcm2835_i2c_ops = {
> +	.xfer          = bcm2835_i2c_xfer,
> +	.set_bus_speed = bcm2835_i2c_set_rate,
> +};
> +
> +static const struct udevice_id bcm2835_i2c_ids[] = {
> +	{.compatible = "brcm,bcm2711-i2c"},
> +	{.compatible = "brcm,bcm2835-i2c"},
> +	{}
> +};
> +
> +static int bcm2835_i2c_probe(struct udevice *bus)
> +{
> +	struct bcm2835_i2c_priv *priv = dev_get_priv(bus);
> +	struct bcm2835_i2c_regs __iomem *regs;
> +	unsigned int bus_clk_rate;
> +	int ret;
> +
> +	priv->regs = dev_read_addr_ptr(bus);
> +	if (!priv->regs) {
> +		printf("bcm2835_i2c: cannot get base address\n");
> +		return -EINVAL;
> +	}
> +
> +	regs = priv->regs;
> +
> +	ret = bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &priv->input_rate);
> +	if (ret)
> +		return ret;
> +
> +	bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
> +					    I2C_SPEED_STANDARD_RATE);
> +	ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
> +	if (ret)
> +		return ret;
> +
> +	/* clear FIFO + status */
> +	writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +	       &regs->s);
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(bcm2835_i2c) = {
> +	.name       = "bcm2835_i2c",
> +	.id         = UCLASS_I2C,
> +	.of_match   = bcm2835_i2c_ids,
> +	.probe      = bcm2835_i2c_probe,
> +	.priv_auto  = sizeof(struct bcm2835_i2c_priv),
> +	.ops        = &bcm2835_i2c_ops,
> +};
> 

The i2c driver part looks good to me now, thanks!

If my nitpick is in, you can add my:

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
