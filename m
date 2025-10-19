Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7144CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 22:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218028206E;
	Mon, 20 Oct 2025 00:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D198582991; Mon, 20 Oct 2025 00:03:23 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75231807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 00:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.25.82]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 029C9B2200F3;
 Mon, 20 Oct 2025 00:03:17 +0200 (CEST)
Message-ID: <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
Date: Sun, 19 Oct 2025 15:03:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Michal,

On 10/9/25 03:34, Michal Simek wrote:
> Remove cdns,is-dma DT property handling. Property is not the part of DT
> binding and it is also hardcoded to value 1 in all DTs that's why remove it
> because none is also testing value 0.
> If there is any use case when this configuration should be supported this
> patch can be reverted.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Remove other functions which are reported as unused by gitlab CI.
> 
> v1: https://lore.kernel.org/r/c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com
> ---
>  arch/arm/dts/versal-mini-ospi.dtsi     |   1 -
>  arch/arm/dts/versal-net-mini-ospi.dtsi |   1 -
>  drivers/spi/cadence_qspi.c             |   8 +-
>  drivers/spi/cadence_qspi.h             |   5 --
>  drivers/spi/cadence_qspi_apb.c         | 119 -------------------------
>  5 files changed, 1 insertion(+), 133 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
> index eec2a08e7c70..6991f6a51db0 100644
> --- a/arch/arm/dts/versal-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
> @@ -38,7 +38,6 @@
>  		num-cs = <1>;
>  		cdns,fifo-depth = <256>;
>  		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>  		cdns,trigger-address = <0xc0000000>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index 1c94b352dc97..d2d5ec8e5cbf 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -52,7 +52,6 @@
>  		num-cs = <1>;
>  		cdns,fifo-depth = <256>;
>  		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>  		cdns,is-stig-pgm = <1>;
>  		cdns,trigger-address = <0xc0000000>;
>  		#address-cells = <1>;
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 599596f9f087..849bd930edf0 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>  
>  	priv->regbase		= plat->regbase;
>  	priv->ahbbase		= plat->ahbbase;
> -	priv->is_dma		= plat->is_dma;
>  	priv->is_decoded_cs	= plat->is_decoded_cs;
>  	priv->fifo_depth	= plat->fifo_depth;
>  	priv->fifo_width	= plat->fifo_width;
> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  	case CQSPI_READ:
>  		err = cadence_qspi_apb_read_setup(priv, op);
>  		if (!err) {
> -			if (priv->is_dma)
> -				err = cadence_qspi_apb_dma_read(priv, op);
> -			else
> -				err = cadence_qspi_apb_read_execute(priv, op);
> +			err = cadence_qspi_apb_dma_read(priv, op);
>  		}
>  		break;
>  	case CQSPI_WRITE:
> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
>  	if (plat->ahbsize >= SZ_8M)
>  		priv->use_dac_mode = true;
>  
> -	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
> -
>  	/* All other parameters are embedded in the child node */
>  	subnode = cadence_qspi_get_subnode(bus);
>  	if (!ofnode_valid(subnode)) {
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 879e7f8dbfb8..10c4ad14cc05 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>  	u32		tchsh_ns;
>  	u32		tslch_ns;
>  	u32		quirks;
> -
> -	bool            is_dma;
>  };
>  
>  struct cadence_spi_priv {
> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>  	bool		ddr_init;
>  	bool		is_decoded_cs;
>  	bool		use_dac_mode;
> -	bool		is_dma;
>  
>  	/* Transaction protocol parameters. */
>  	u8		inst_width;
> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>  
>  int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>  				const struct spi_mem_op *op);
> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
> -				  const struct spi_mem_op *op);
>  int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>  				 const struct spi_mem_op *op);
>  int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 4696c09f754b..58be017720bc 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>  	return 0;
>  }
>  
> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv *priv)
> -{
> -	u32 reg = readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
> -	reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
> -	return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
> -}
> -
> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
> -{
> -	unsigned int timeout = 10000;
> -	u32 reg;
> -
> -	while (timeout--) {
> -		reg = cadence_qspi_get_rd_sram_level(priv);
> -		if (reg)
> -			return reg;
> -		udelay(1);
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static int
> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
> -				       unsigned int n_rx, u8 *rxbuf)
> -{
> -	unsigned int remaining = n_rx;
> -	unsigned int bytes_to_read = 0;
> -	int ret;
> -
> -	writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
> -
> -	/* Start the indirect read transfer */
> -	writel(CQSPI_REG_INDIRECTRD_START,
> -	       priv->regbase + CQSPI_REG_INDIRECTRD);
> -
> -	while (remaining > 0) {
> -		ret = cadence_qspi_wait_for_data(priv);
> -		if (ret < 0) {
> -			printf("Indirect write timed out (%i)\n", ret);
> -			goto failrd;
> -		}
> -
> -		bytes_to_read = ret;
> -
> -		while (bytes_to_read != 0) {
> -			bytes_to_read *= priv->fifo_width;
> -			bytes_to_read = bytes_to_read > remaining ?
> -					remaining : bytes_to_read;
> -			/*
> -			 * Handle non-4-byte aligned access to avoid
> -			 * data abort.
> -			 */
> -			if (((uintptr_t)rxbuf % 4) || (bytes_to_read % 4))
> -				readsb(priv->ahbbase, rxbuf, bytes_to_read);
> -			else
> -				readsl(priv->ahbbase, rxbuf,
> -				       bytes_to_read >> 2);
> -			rxbuf += bytes_to_read;
> -			remaining -= bytes_to_read;
> -			bytes_to_read = cadence_qspi_get_rd_sram_level(priv);
> -		}
> -	}
> -
> -	/* Check indirect done status */
> -	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
> -				CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
> -	if (ret) {
> -		printf("Indirect read completion error (%i)\n", ret);
> -		goto failrd;
> -	}
> -
> -	/* Clear indirect completion status */
> -	writel(CQSPI_REG_INDIRECTRD_DONE,
> -	       priv->regbase + CQSPI_REG_INDIRECTRD);
> -
> -	/* Check indirect done status */
> -	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
> -				CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
> -	if (ret) {
> -		printf("Indirect read clear completion error (%i)\n", ret);
> -		goto failrd;
> -	}
> -
> -	/* Wait til QSPI is idle */
> -	if (!cadence_qspi_wait_idle(priv->regbase))
> -		return -EIO;
> -
> -	return 0;
> -
> -failrd:
> -	/* Cancel the indirect read */
> -	writel(CQSPI_REG_INDIRECTRD_CANCEL,
> -	       priv->regbase + CQSPI_REG_INDIRECTRD);
> -	return ret;
> -}
> -
> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
> -				  const struct spi_mem_op *op)
> -{
> -	u64 from = op->addr.val;
> -	void *buf = op->data.buf.in;
> -	size_t len = op->data.nbytes;
> -
> -	cadence_qspi_apb_enable_linear_mode(true);
> -
> -	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
> -		if (len < 256 ||
> -		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
> -			memcpy_fromio(buf, priv->ahbbase + from, len);
> -		}
> -		if (!cadence_qspi_wait_idle(priv->regbase))
> -			return -EIO;
> -		return 0;
> -	}
> -
> -	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
> -}
> -
>  /* Opcode + Address (3/4 bytes) */
>  int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>  				 const struct spi_mem_op *op)

Your patch results in corrupted SPI NOR flash writing from U-Boot on
starfive_visionfive2_defconfig target board Pine64 Star64:

a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
commit a040578d8270ed8788d7663808ea63ce5ffd7840
Author: Michal Simek <michal.simek@amd.com>
Date:   Thu Oct 9 12:34:48 2025 +0200

    spi: cadence-qspi: Remove cdns,is-dma property handling

Steps to reproduce with Star64:

1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` or
similar for serving U-Boot SPL and U-Boot Main to save some time with
UART transfer:
4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out && sf
update $loadaddr 0 $filesize
4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadaddr
100000 $filesize

Repeat steps 4a and 4b, note that each time all bytes are written and no
bytes are skipped. Written data is wrong and device unsuccessfully boots
in SPI NOR flash BootROM loader configuration showing wrong information
to output.

Please follow up with your analysis of why these changes have this effect.

-E Shattow
