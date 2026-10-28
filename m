Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03A606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o3FGurs6;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=HQraOIwo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97B756067D;
	Wed, 28 Oct 2026 07:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8FHT6b-1djF; Wed, 28 Oct 2026 07:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2D68605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793173767;
	b=PS7SPhtIlC/uhO8ZDHbid5YDOlWOOBq2ykGNm92uSZrejiD66l+WgsCpAejjG84FWml7
	 bJferW/nXlNAvzS+pg7dlaIxaoI1SRt6qqfhUJstQt879TCLl04hkK1aNaD1bLRLcpIEv
	 vFUctOo3N1PfIu7SrrnVBALdyFqoFBShXSnxMjpUC0tzJL4P+5wFrTgOCo/hBdxkdXE8R
	 d6S8CeJfuO0f/fPJ/6GY3nrn2FQio5CoVAOD4lDYmGoT+vMz5ejz/LLQdwwVdrJz7P7gY
	 iZNLwr/z7IVUimkvc4OAcdfVnHzy6SroxOf+xCfIo5d/ZOOrfaREErfqFC+WrhNEuXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793173767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XhGGcAMMvn/BASOTSHm4W9LtoOHhqgvKNsN67it7JuI=;
	b=Z01Q4Mltj2YUre0+q690WfUzBWuwgBu45gmTi88GZkwr1FtJ2dMLSXx5MNC6JR8vtkLV
	 Tle3dbQspdd5tx+PP2q6mCUO4Q+5ripsjKt0jaut4zDzC75YKDVdGIfyMtqBxEqT/cQ2k
	 0PsHXsP/Th9gxJF/3sHxXZkgN6VJRdysZrZ19LnCr/HvgoAsUF/s3QG64xoUVhGw2Oa35
	 PpgQ2VCd8zFwb2a2oDB3f91pkKVjNwwKhUAoKKYhXsUZeyBdfm3sqQ48imHlRLj0+v6oH
	 l55rIz+6SidXHY/QTevhn1XERx1hOSwO72m8mDWiMTP07XVV/CQC3wbwXLraEbddcvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=HQraOIwo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793173767;
	bh=XhGGcAMMvn/BASOTSHm4W9LtoOHhqgvKNsN67it7JuI=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3FGurs6ZFcg4RrQLTaeI5DzgafFaNM4VNF1NTV9LiUvO+xV9+NahUI1RjhuWQCMG
	 l47qK0Z3GRohxzVtc7sbLG7aOR3gwU86PWIhWzSjmJijTDXT7TQZRvopGe7jbEK+xy
	 qCPjM0+TYtoxKiLO7/KZqizQ2RGi6wHIvtuhQRmIBuggttx51QNZBE2ObBQQgZqFJk
	 huWIj0L8wcBw2N7wS/pUbAgn1PFc4G+b7nNwAPaNAF16/IQfU5fwVQRLCfjqQ/9NwG
	 INHvUMVuDR0t57WOaDOuCNVyhD6gErt3UH7V2IVoLGLDR1w5NVr4oZxu33sIk/nsoJ
	 LCZwekOyDQ+KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2D68605EB;
	Wed, 28 Oct 2026 07:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD6234D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF5C2605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSwHB7Yro2iC for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3AD7605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793173763;
 b=QMdOXjPxMQLhEPfXz55YhPUgaD9W/4S+u8Khtm/8LK9TpxBnS+0rTK0ekaFdT8zkGna7
 XB0uWBTqRUUbWdUuFDFRr5qtrrgZ18UfmT3v0gtrxwn/2/8oEKA2SitGqu9yY9rijOlUe
 1tkIWRJDtgAejBEGVyDCTf2zxoGScnfUlyYcdZnF73Fx5aKgYI1dRqmTO4HAdhmTcvM/V
 0m7lEidjxAtZi+tuzGmKK2cMrl9P96Go2SZteuK+WfHuvz3fLPd/BBPyBgqC1TXBKQG+U
 DAH6Awp071GnBaQPX2knMsrxgO6M7FPvtWEy1PQ/85noQ4sOZvGsdPrRehP1EMnn2Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793173763;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=XhGGcAMMvn/BASOTSHm4W9LtoOHhqgvKNsN67it7JuI=;
 b=FNdlmUBnSmB9XvU7NIY1onEfot6u/T2IVN3RA/tUACA4G3Pd1Lxbrm7pU0rA4tr5CzYt
 Uh15u6cLy8MzGstsIuFoQihbOF4dmJdEBYcagOzKVY9Gjy/SvTG1IoXj5Zj+OKX+Jduj5
 Wm/c+JEECLVIfbKAakdbNGnRZyk2HRCvLDY8nXIDK8eDVIjx+i+UswUuae05SMT7GqUZf
 9yZYqrvN4nkX73qeyGnnFcHzwsUTbhkLOaVGdjBhthUzLJ9HORj6ZIP7v0Cp1Xiqb5VrU
 DvvSRDt28ZPfLdpf/EkQvZWNaY4tRudIHZSDnFnwc8It+KvC9HHDqD+zCXsrAdmCovA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HQraOIwo; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HQraOIwo
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3AD7605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C807210B941; Wed, 28 Oct 2026 08:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793173756;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XhGGcAMMvn/BASOTSHm4W9LtoOHhqgvKNsN67it7JuI=;
 b=HQraOIwoxE76zV21FmHrMQErUjFMSk+Z526OUYg64SYmw+47etJJk9hwefFcwaRRyvNd2g
 1yUKzirNoqKLhs6gomCFKe/KNAPc1w5UuS4KMEr/+NG0L/ta6hf9Gg6kj8a7YzH7BSMmeT
 sFDLrurakU61nCK3tRwuGo+o3HxGy4KPD/e9wLfU9hu2ZRJl6vcbGBMD+5Gs1h2gaZWVyr
 SrItfxLA3CthdON2dUASq1xtX62jYVHz+/o8AJBYibRZ1puScWBqY7cHXOlb28CwNzYXL9
 pKBoOVYOp+vFoV7327Ot067bevoNT6//e3SPSZ+oeAguwgg98Gn9hfVKCoj/qA==
Message-ID: <0a36eb46-539f-8e47-02db-5dfe91a9bab2@nabladev.com>
Date: Wed, 28 Oct 2026 08:48:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Giau Nguyen <nguyenanhgiau1008@gmail.com>, u-boot@lists.u-boot-project.org
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com
References: <20261028050441.380764-1-nguyenanhgiau1008@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: bcm283x: Refactor driver to support BCM2711
 (Raspberry Pi 4)
In-Reply-To: <20261028050441.380764-1-nguyenanhgiau1008@gmail.com>
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

I find DOS line endings, please remove them

please also run checkpatch script, as it finds some CHECKS,
after removing the DOS line endings.

On 28.10.26 06:04, Giau Nguyen wrote:
> The existing bcm283x I2C driver relies on a hardcoded clock rate
> which breaks I2C communication on the BCM2711 (Raspberry Pi 4),
> where the VPU core clock is dynamically scaled by the firmware.

Where do I find this existing driver in u-boot code?
(Sorry if dummy question)

> 
> This patch completely refactors the driver (based on Linux kernel's
> i2c-bcm2835.c) to bring it up to standard:
> - Queries the actual core clock via BCM2835 Mailbox property tags.
> - Calculates the CDIV divider dynamically based on the firmware clock.
> - Adds the "brcm,bcm2711-i2c" compatible string.
> - Improves FIFO drain/fill and hardware timeout polling.
> 
> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> ---
>   MAINTAINERS               |   1 +
>   drivers/i2c/Kconfig       |  10 +
>   drivers/i2c/Makefile      |   1 +
>   drivers/i2c/i2c-bcm2835.c | 411 ++++++++++++++++++++++++++++++++++++++

Thats, why I ask... I do not see deleted lines, so I wonder about
"refactor"... for me it looks like it is a new driver...

>   4 files changed, 423 insertions(+)
>   create mode 100644 drivers/i2c/i2c-bcm2835.c

I miss here some user of the driver, do you miss some change in a defconfig?

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c6c0c2a4bc..3260024a736 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -215,6 +215,7 @@ F:	arch/arm/dts/bcm283*
>   F:	arch/arm/mach-bcm283x/
>   F:	board/raspberrypi/
>   F:	drivers/gpio/bcm2835_gpio.c
> +F:	drivers/i2c/i2c-bcm2835.c
>   F:	drivers/mmc/bcm2835_sdhci.c
>   F:	drivers/mmc/bcm2835_sdhost.c
>   F:	drivers/serial/serial_bcm283x_mu.c
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 52067fa7c1f..19bd60ecdac 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -782,6 +782,16 @@ config SYS_I2C_XILINX_XIIC
>   	help
>   	  Support for Xilinx AXI I2C controller.
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
>   config SYS_I2C_IHS
>           bool "gdsys IHS I2C driver"
>           depends on DM_I2C
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index bebd728e7da..e2c252cf16c 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_SYS_I2C_UNIPHIER) += i2c-uniphier.o
>   obj-$(CONFIG_SYS_I2C_UNIPHIER_F) += i2c-uniphier-f.o
>   obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
>   obj-$(CONFIG_SYS_I2C_XILINX_XIIC) += xilinx_xiic.o
> +obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o

Nitpick, please sort alphabetical.

>   obj-$(CONFIG_TEGRA186_BPMP_I2C) += tegra186_bpmp_i2c.o
>   
>   obj-$(CONFIG_$(XPL_)I2C_MUX) += muxes/
> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> new file mode 100644
> index 00000000000..93d19cb8e5a
> --- /dev/null
> +++ b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM2835 I2C controller driver
> + * (C) Copyright 2026
> + *
> + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> + * Assisted by AI

Please drop this here, and add instead

Assisted-by: AGENT:MODEL

after your Signed-off-by tag, or follow the current kernel standard
of not mention this at all... I am unsure here...

> + */
> +
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch/mbox.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <i2c.h>
> +#include <memalign.h>
> +#include <time.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +#define BCM2835_I2C_C		0x0
> +#define BCM2835_I2C_S		0x4
> +#define BCM2835_I2C_DLEN	0x8
> +#define BCM2835_I2C_A		0xc
> +#define BCM2835_I2C_FIFO	0x10
> +#define BCM2835_I2C_DIV		0x14
> +#define BCM2835_I2C_DEL		0x18
> +/*
> + * 16-bit field for the number of SCL cycles to wait after rising SCL
> + * before deciding the slave is not responding. 0 disables the
> + * timeout detection.
> + */
> +#define BCM2835_I2C_CLKT	0x1c
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
> +struct bcm2835_i2c_priv {
> +	void __iomem *regs;
> +	ulong input_rate;
> +	size_t msg_buf_remaining;
> +	u8 *msg_buf;
> +	struct i2c_msg *curr_msg;
> +	int msg_err;
> +	int num_msgs;
> +};
> +
> +struct bcm2835_i2c_clock_msg {
> +	struct bcm2835_mbox_hdr hdr;
> +	struct bcm2835_mbox_tag_get_clock_rate get_clock_rate;
> +	u32 end_tag;
> +};
> +
> +static int bcm2835_i2c_get_input_rate(ulong *rate)
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(struct bcm2835_i2c_clock_msg, msg, 1);
> +	int ret;
> +
> +	BCM2835_MBOX_INIT_HDR(msg);
> +	BCM2835_MBOX_INIT_TAG(&msg->get_clock_rate, GET_CLOCK_RATE);
> +	msg->get_clock_rate.body.req.clock_id = BCM2835_MBOX_CLOCK_ID_CORE;
> +
> +	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg->hdr);
> +	if (ret)
> +		return ret;
> +
> +	*rate = msg->get_clock_rate.body.resp.rate_hz;
> +	return *rate ? 0 : -EINVAL;
> +}

This function looks to me, that it should be somehow in the clock subsystem.
I have no idea how much of this has already been implemented for the Raspberry Pi.

Ah, there is already a similiar function bcm2835_get_mmc_clock()

May you move at least your function to arch/arm/mach-bcm283x/msg.c ?

May I ask, if you try to implement a common bcm2835_get_clock(clock_id) and
use that instead?

Thanks!

> +
> +static inline void bcm2835_i2c_writel(struct bcm2835_i2c_priv *i2c_dev,
> +				      u32 reg, u32 val)
> +{
> +	writel(val, i2c_dev->regs + reg);
> +}
> +
> +static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_priv *i2c_dev, u32 reg)
> +{
> +	return readl(i2c_dev->regs + reg);
> +}

I think about that ... I do not like this wrappers... instead you could
use readl()/writel() ... ?

May you can rework this to (just an idea, not tried!), add

struct bcm2835_i2c_regs {
       u32 c;
       u32 s;
       u32 dlen;
       u32 a;
       u32 fifo;
       u32 div;
       u32 del;
       u32 clkt;
}

and drop the offset defines, add

       struct bcm2835_i2c_regs __iomem *regs;

to bcm2835_i2c_priv and access the registers for example with

"""
struct bcm2835_i2c_regs *reg = i2c_dev->regs;

val = readl(&regs->s);
"""

look for an example in drivers/i2c/npcm_i2c.c

> +
> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	u32 val;
> +
> +	while (i2c_dev->msg_buf_remaining) {
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
> +		if (!(val & BCM2835_I2C_S_TXD))
> +			break;

please add an empty line.

> +		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_FIFO,
> +				   *i2c_dev->msg_buf);

if you rework to writel(), this line should be shorter and fit into one line...

> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}
> +}
> +
> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	u32 val;
> +
> +	while (i2c_dev->msg_buf_remaining) {
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
> +		if (!(val & BCM2835_I2C_S_RXD))
> +			break;

please add an empty line.


> +		*i2c_dev->msg_buf = bcm2835_i2c_readl(i2c_dev,
> +						      BCM2835_I2C_FIFO);
> +		i2c_dev->msg_buf++;
> +		i2c_dev->msg_buf_remaining--;
> +	}
> +}
> +
> +static int bcm2835_i2c_calc_divider(unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	int divider = DIV_ROUND_UP(parent_rate, rate);

Please add the include for this:

<linux/kernel.h>

> +
> +	/*
> +	 * Per the datasheet, the register is always interpreted as an even
> +	 * number, by rounding down. In other words, the LSB is ignored. So,
> +	 * if the LSB is set, increment the divider to avoid any issue.
> +	 */
> +	if (divider & 1)
> +		divider++;

please add a empty line.

> +	if ((divider < BCM2835_I2C_CDIV_MIN) ||
> +	    (divider > BCM2835_I2C_CDIV_MAX))
> +		return -EINVAL;
> +
> +	return divider;
> +}
> +
> +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
> +{
> +	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(bus);
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
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
> +
> +	/*
> +	 * Number of core clocks to wait after falling edge before
> +	 * outputting the next data bit.  Note that both FEDL and REDL
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
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
> +			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
> +			   (redl << BCM2835_I2C_REDL_SHIFT));
> +
> +	/*
> +	 * Set the clock stretch timeout.
> +	 */
> +	if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> +		clk_tout = 0xffff;
> +	else
> +		clk_tout = BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> +
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, clk_tout);
> +
> +	return 0;
> +}
> +
> +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
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
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
> +}
> +
> +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +	i2c_dev->curr_msg = NULL;
> +	i2c_dev->num_msgs = 0;
> +

please remove this empty line.

> +	i2c_dev->msg_buf = NULL;
> +	i2c_dev->msg_buf_remaining = 0;
> +}
> +
> +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
> +{
> +	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(dev);
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
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S,
> +			   BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |
> +			   BCM2835_I2C_S_DONE);
> +
> +	i2c_dev->curr_msg = msgs;
> +	i2c_dev->num_msgs = count;
> +	i2c_dev->msg_err = 0;
> +
> +	bcm2835_i2c_start_transfer(i2c_dev);
> +	start = get_timer(0);
> +	while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
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
> +				val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
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
> +		val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
> +		dev_err(dev, "transfer timeout: status=%08x remaining=%zu\n",
> +			val, i2c_dev->msg_buf_remaining);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	/* Always abort/reset the controller and clear W1C status bits. */
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
> +			   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
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
> +	unsigned int bus_clk_rate;
> +	int ret;
> +
> +	priv->regs = dev_read_addr_ptr(bus);
> +	if (!priv->regs) {
> +		printf("bcm2835_i2c: cannot get base address\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = bcm2835_i2c_get_input_rate(&priv->input_rate);
> +	if (ret)
> +		return ret;
> +
> +	bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
> +					   I2C_SPEED_STANDARD_RATE);
> +	ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
> +	if (ret)
> +		return ret;
> +
> +	/* clear FIFO + status */
> +	bcm2835_i2c_writel(priv,
> +			   BCM2835_I2C_C,
> +			   BCM2835_I2C_C_CLEAR);
> +
> +	bcm2835_i2c_writel(priv,
> +			   BCM2835_I2C_S,
> +			   BCM2835_I2C_S_CLKT |
> +			   BCM2835_I2C_S_ERR |
> +			   BCM2835_I2C_S_DONE);
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

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
