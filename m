Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D006C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 06:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752E984118;
	Wed,  8 Jul 2026 08:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jIENDB12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF38D8497A; Wed,  8 Jul 2026 08:02:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66615838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 08:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783490564; x=1784095364; i=xypron.glpk@gmx.de;
 bh=sZC8RE5qnJvTZOn0a/dasSNukKYtoAEIwFUzTV/2ob8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jIENDB12GMKVxkQOmBUSgs6NlhzUfV95nS1RuOUzikK6R2/Sos9Qb0DBBXxKun0k
 i74VpBBysNHE+MdACXnUaIiW6rpAmA5nXIiuDnW6LH5MkmMJBHfmCyDUPwi+yhyah
 ayf6FNJqebe2o5DG31Pe2Frk+uxvndj5LZmivNM4581hBcmXNc+LnvLGUuyCGCfdg
 4zv92xm4hTmK3LyjDLfq1MCxIlW5MDRSAVPs9ddxmx9DaSraJfyKnNHVXtw+0IbSx
 25p+XgPrlsAszSI1Z+ZzDUL0KGtes5/0gR2FhfMLjgeHUaox8YCwwE2f5BslCxiJY
 eO7+eQhsMv48Q236/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1wOa3s2GP6-00OF2q; Wed, 08
 Jul 2026 08:02:44 +0200
Message-ID: <29f1cc24-a94e-4482-9298-4ffeec568422@gmx.de>
Date: Wed, 8 Jul 2026 08:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: esp32: add driver for esp32 series chips
To: hehongbo918@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Johan Jonker <jbx6244@gmail.com>,
 Daniel Palmer <daniel@0x0f.com>, Angelo Dureghello
 <angelo@kernel-space.org>, u-boot@lists.denx.de
References: <20260708053911.55985-1-hehongbo918@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260708053911.55985-1-hehongbo918@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jle96pWulKn5QdsrSy0wH06O+aOAk9Uf5Fh7KEhubFJMpXSkfAj
 uhkqAej+kx38CTmhSVm8Ap462fHta+jLP+8/sE+Q+cSflG1Y0Kh0hbZc+WpWFm6Ymb5bmSf
 PX+6CmcD/d/iYISR/1NMhzjclyav29vs+dhYrDUttrQ7P0X4QKnsu+dDRfcQcsCgraCDfeu
 QQv624/yFMiQcKUvTMa7A==
UI-OutboundReport: notjunk:1;M01:P0:n+DFN6+v2tI=;Z9E5hkeQ5U4C0fubcIa3J0fipWO
 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
 idRjDglfk=
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

On 7/8/26 07:39, hehongbo918@gmail.com wrote:
> From: Honbo He <hehongbo918@gmail.com>
>=20
> Add a driver model serial driver for Espressif ESP32 UART
> controllers. The driver supports ESP32, ESP32-S3 and ESP32-S31 UART
> register variants, including baud-rate setup, FIFO access and basic
> port initialization.
>=20
> Signed-off-by: Honbo He <hehongbo918@gmail.com>

Would it make sense to also define a debug UART in the driver?
With a debug UART you can get very early print output.
If you need a template, have a look at drivers/serial/serial_sifive.c

Best regards

Heinrich


> ---
>   drivers/serial/Kconfig        |   7 +
>   drivers/serial/Makefile       |   1 +
>   drivers/serial/serial_esp32.c | 312 ++++++++++++++++++++++++++++++++++
>   3 files changed, 320 insertions(+)
>   create mode 100644 drivers/serial/serial_esp32.c
>=20
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index e221800d5d0..f0e8a0b8026 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1069,6 +1069,13 @@ config HTIF_CONSOLE
>   	  console. The HTIF device is quite common in RISC-V emulators and
>   	  RISC-V ISS so this driver allows using U-Boot on such platforms.
>  =20
> +config ESP32_SERIAL
> +	bool "Espressif ESP32 UART support"
> +	depends on DM_SERIAL
> +	help
> +	  Select this to enable UART support for Espressif ESP32 family
> +	  devices using the U-Boot driver model.
> +
>   config SIFIVE_SERIAL
>   	bool "SiFive UART support"
>   	depends on DM_SERIAL
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 66088b44eb6..44fb2170f9a 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_COREBOOT_SERIAL) +=3D serial_coreboot.o
>   obj-$(CONFIG_CORTINA_UART) +=3D serial_cortina.o
>   obj-$(CONFIG_DEBUG_SBI_CONSOLE) +=3D serial_sbi.o
>   obj-$(CONFIG_EFI_APP) +=3D serial_efi.o
> +obj-$(CONFIG_ESP32_SERIAL) +=3D serial_esp32.o
>   obj-$(CONFIG_MCFUART) +=3D serial_mcf.o
>   obj-$(CONFIG_SYS_NS16550) +=3D ns16550.o
>   obj-$(CONFIG_S5P_SERIAL) +=3D serial_s5p.o
> diff --git a/drivers/serial/serial_esp32.c b/drivers/serial/serial_esp32=
.c
> new file mode 100644
> index 00000000000..16b687fb5c1
> --- /dev/null
> +++ b/drivers/serial/serial_esp32.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Honbo He <hehongbo918@gmail.com>
> + */
> +
> +#define LOG_CATEGORY UCLASS_SERIAL
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <fdtdec.h>
> +#include <serial.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/err.h>
> +#include <linux/bitops.h>
> +
> +#define UART_FIFO			0x00
> +#define UART_INT_ENA		0x0c
> +#define UART_INT_CLR		0x10
> +#define UART_CLKDIV			0x14
> +#define UART_STATUS			0x1c
> +#define UART_CONF0			0x20
> +
> +#define UART_CLKDIV_FRAG_SHIFT	20
> +#define UART_CLKDIV_FRAG_MASK	0xf
> +
> +#define UART_TX_FLOW_EN		BIT(13)
> +#define UART_LOOPBACK		BIT(12)
> +#define UART_STOP_BIT_1		BIT(4)
> +#define UART_PARITY_EN		BIT(1)
> +#define UART_PARITY			BIT(0)
> +
> +#define UART_BIT_NUM_8		(3 << 2)
> +
> +#define UART_BIT_NUM_MASK	GENMASK(3, 2)
> +#define UART_STOP_BIT_MASK	GENMASK(5, 4)
> +
> +#define UART_RXFIFO_CNT_SHIFT	0
> +#define UART_TXFIFO_CNT_SHIFT	16
> +#define UART_FIFO_LEN		128
> +
> +#define UART_UPDATE_TIMEOUT 10000
> +
> +struct esp32_uart_soc_data {
> +	u32 reg_update;		/* UART_ID_REG */
> +	u32 reg_update_bit; /* UART_REG_UPDATE */
> +	u32 clkdiv_mask;
> +	u32 fifo_cnt_mask;
> +	u32 rx_fifo_rst;	/* UART_RXFIFO_RST */
> +	u32 tx_fifo_rst;	/* UART_TXFIFO_RST */
> +
> +	bool broken_fifo_rst; /* true for ESP32, false otherwise */
> +};
> +
> +/* Information about a serial port */
> +struct esp32_uart_plat {
> +	void __iomem *base; /* address of registers in physical memory */
> +	const struct esp32_uart_soc_data *data;
> +	u32 clock_rate;
> +};
> +
> +static const struct esp32_uart_soc_data esp32_uart_data =3D {
> +	.clkdiv_mask =3D 0xfffff,
> +	.fifo_cnt_mask =3D 0xff,
> +	.rx_fifo_rst =3D BIT(17),
> +	.tx_fifo_rst =3D BIT(18),
> +
> +	.broken_fifo_rst =3D true,
> +};
> +
> +static const struct esp32_uart_soc_data esp32s3_uart_data =3D {
> +	.reg_update =3D 0x80,
> +	.reg_update_bit =3D BIT(31),
> +	.clkdiv_mask =3D 0xfff,
> +	.fifo_cnt_mask =3D 0x3ff,
> +	.rx_fifo_rst =3D BIT(17),
> +	.tx_fifo_rst =3D BIT(18),
> +};
> +
> +static const struct esp32_uart_soc_data esp32s31_uart_data =3D {
> +	.reg_update =3D 0x98,
> +	.reg_update_bit =3D BIT(0),
> +	.clkdiv_mask =3D 0xfff,
> +	.fifo_cnt_mask =3D 0xff,
> +	.rx_fifo_rst =3D BIT(22),
> +	.tx_fifo_rst =3D BIT(23),
> +};
> +
> +static u32 esp32_uart_read(struct esp32_uart_plat *plat, u32 offset)
> +{
> +	return readl(plat->base + offset);
> +}
> +
> +static void esp32_uart_write(struct esp32_uart_plat *plat, u32 offset, =
u32 val)
> +{
> +	writel(val, plat->base + offset);
> +}
> +
> +static u32 esp32_uart_field(u32 val, u32 mask, u32 shift)
> +{
> +	return (val >> shift) & mask;
> +}
> +
> +static u32 esp32_uart_rx_fifo_count(struct esp32_uart_plat *plat)
> +{
> +	const struct esp32_uart_soc_data *data =3D plat->data;
> +	u32 status =3D esp32_uart_read(plat, UART_STATUS);
> +
> +	return esp32_uart_field(status, data->fifo_cnt_mask,
> +				UART_RXFIFO_CNT_SHIFT);
> +}
> +
> +static u32 esp32_uart_tx_fifo_count(struct esp32_uart_plat *plat)
> +{
> +	const struct esp32_uart_soc_data *data =3D plat->data;
> +	u32 status =3D esp32_uart_read(plat, UART_STATUS);
> +
> +	return esp32_uart_field(status, data->fifo_cnt_mask,
> +				UART_TXFIFO_CNT_SHIFT);
> +}
> +
> +static int esp32_uart_update(struct esp32_uart_plat *plat)
> +{
> +	const struct esp32_uart_soc_data *data =3D plat->data;
> +	int timeout =3D UART_UPDATE_TIMEOUT;
> +
> +	if (!data->reg_update_bit)
> +		return 0;
> +
> +	setbits_le32(plat->base + data->reg_update, data->reg_update_bit);
> +	while ((esp32_uart_read(plat, data->reg_update) & data->reg_update_bit=
) &&
> +	       timeout--)
> +		;
> +
> +	return timeout < 0 ? -ETIMEDOUT : 0;
> +}
> +
> +static int esp32_uart_reset_fifo(struct esp32_uart_plat *plat)
> +{
> +	const struct esp32_uart_soc_data *data =3D plat->data;
> +	u32 mask =3D data->tx_fifo_rst;
> +	int ret;
> +
> +	/*
> +	 * uart2 of ESP32 doesn't have any register to reset Tx_FIFO or Rx_FIF=
O,
> +	 * and the FIFO_RST of uart1 may impact the functioning of uart2
> +	 * so use soft reset instead
> +	 */
> +	if (data->broken_fifo_rst) {
> +		while (esp32_uart_rx_fifo_count(plat))
> +			esp32_uart_read(plat, UART_FIFO);
> +		return 0;
> +	}
> +	mask |=3D data->rx_fifo_rst;
> +
> +	setbits_le32(plat->base + UART_CONF0, mask);
> +	ret =3D esp32_uart_update(plat);
> +	if (ret)
> +		return ret;
> +
> +	clrbits_le32(plat->base + UART_CONF0, mask);
> +	return esp32_uart_update(plat);
> +}
> +
> +/*
> + * div =3D clkdiv_int + clkdiv_frag / 16
> + * baudrate =3D uart_clk / div
> + */
> +static int esp32_serial_setbrg(struct udevice *dev, int baudrate)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +	const struct esp32_uart_soc_data *data =3D plat->data;
> +	u32 div, int_div, frag;
> +
> +	if (!plat->clock_rate || baudrate <=3D 0)
> +		return -EINVAL;
> +	if (plat->clock_rate > (UINT_MAX >> 4))
> +		return -EINVAL;
> +
> +	/* shifting left by 4 bits to preserve frag field */
> +	div =3D (plat->clock_rate << 4) / baudrate;
> +	int_div =3D div >> 4;
> +	frag =3D div & UART_CLKDIV_FRAG_MASK;
> +
> +	if (!int_div || int_div > data->clkdiv_mask)
> +		return -EINVAL;
> +
> +	esp32_uart_write(plat, UART_CLKDIV,
> +			 int_div | (frag << UART_CLKDIV_FRAG_SHIFT));
> +
> +	return esp32_uart_update(plat);
> +}
> +
> +static int esp32_serial_getc(struct udevice *dev)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +
> +	if (!esp32_uart_rx_fifo_count(plat))
> +		return -EAGAIN;
> +
> +	return esp32_uart_read(plat, UART_FIFO) & 0xff;
> +}
> +
> +static int esp32_serial_putc(struct udevice *dev, const char ch)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +
> +	if (esp32_uart_tx_fifo_count(plat) >=3D UART_FIFO_LEN)
> +		return -EAGAIN;
> +
> +	esp32_uart_write(plat, UART_FIFO, ch);
> +
> +	return 0;
> +}
> +
> +static int esp32_serial_pending(struct udevice *dev, bool input)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +
> +	if (input)
> +		return esp32_uart_rx_fifo_count(plat);
> +
> +	return esp32_uart_tx_fifo_count(plat) ? 1 : 0;
> +}
> +
> +static int esp32_serial_probe(struct udevice *dev)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +	const struct esp32_uart_soc_data *data;
> +	u32 conf0;
> +
> +	data =3D (const struct esp32_uart_soc_data *)dev_get_driver_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +	plat->data =3D data;
> +
> +	esp32_uart_write(plat, UART_INT_ENA, 0);
> +	esp32_uart_write(plat, UART_INT_CLR, 0xffffffff);
> +
> +	conf0 =3D esp32_uart_read(plat, UART_CONF0);
> +	conf0 &=3D ~(UART_PARITY | UART_PARITY_EN |
> +		   UART_BIT_NUM_MASK | UART_STOP_BIT_MASK |
> +		   UART_LOOPBACK | UART_TX_FLOW_EN);
> +	conf0 |=3D UART_BIT_NUM_8 | UART_STOP_BIT_1;
> +	esp32_uart_write(plat, UART_CONF0, conf0);
> +
> +	return esp32_uart_reset_fifo(plat);
> +}
> +
> +static int esp32_serial_of_to_plat(struct udevice *dev)
> +{
> +	struct esp32_uart_plat *plat =3D dev_get_plat(dev);
> +	fdt_addr_t addr;
> +	struct clk clk;
> +	int ret;
> +
> +	addr =3D dev_read_addr(dev);
> +	if (addr =3D=3D FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	plat->base =3D (void __iomem *)(uintptr_t)addr;
> +	ret =3D clk_get_by_index(dev, 0, &clk);
> +	if (!ret) {
> +		ret =3D clk_get_rate(&clk);
> +		if (!IS_ERR_VALUE(ret))
> +			plat->clock_rate =3D ret;
> +	} else if (ret !=3D -ENOENT && ret !=3D -ENODEV && ret !=3D -ENOSYS) {
> +		dev_err(dev, "failed to get clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!plat->clock_rate)
> +		plat->clock_rate =3D dev_read_u32_default(dev, "clock-frequency", 0);
> +
> +	if (!plat->clock_rate) {
> +		dev_err(dev, "missing clock\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dm_serial_ops esp32_serial_ops =3D {
> +	.putc =3D esp32_serial_putc,
> +	.pending =3D esp32_serial_pending,
> +	.getc =3D esp32_serial_getc,
> +	.setbrg =3D esp32_serial_setbrg,
> +};
> +
> +static const struct udevice_id esp32_serial_ids[] =3D {
> +	{ .compatible =3D "esp,esp32-uart",
> +	  .data =3D (ulong)&esp32_uart_data },
> +	{ .compatible =3D "esp,esp32s3-uart",
> +	  .data =3D (ulong)&esp32s3_uart_data },
> +	{ .compatible =3D "esp,esp32s31-uart",
> +	  .data =3D (ulong)&esp32s31_uart_data },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(serial_esp32) =3D {
> +	.name =3D "serial_esp32",
> +	.id =3D UCLASS_SERIAL,
> +	.of_match =3D of_match_ptr(esp32_serial_ids),
> +	.of_to_plat =3D of_match_ptr(esp32_serial_of_to_plat),
> +	.plat_auto =3D sizeof(struct esp32_uart_plat),
> +	.probe =3D esp32_serial_probe,
> +	.ops =3D &esp32_serial_ops,
> +#if !CONFIG_IS_ENABLED(OF_CONTROL)
> +	.flags =3D DM_FLAG_PRE_RELOC,
> +#endif
> +};

