Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DDACCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AE982A9E;
	Mon, 27 Oct 2025 17:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PTaR1uRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3437C82E34; Mon, 27 Oct 2025 17:11:05 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1929800B1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EBF8603C3;
 Mon, 27 Oct 2025 16:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61C6C4CEFD;
 Mon, 27 Oct 2025 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761581461;
 bh=AoAv7+rqmASApiz0/5MUPLsVTt4XLi9fuDO78pNDzQk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PTaR1uRACE1JB0m0h3YBNOe2wzyLO954g4z3U6l3goex5lWHcMyMMVYaGWHivZd+X
 jBbuhRzFQzPg/2T9dui6p5rwb5k7O7P7H3rhohhElBcK7rgZEtwJW475Y/5GanOnZa
 TDaILp4MAYWBRRyTFz6eHq6bPE9ZH0bHasGZRcqVcF/PExm1HxYwnIWl2CsYweMAnF
 vDE3DKxoGKf+TvZ+z7/8esInUTtCG1OXCWmBa7JOxPs3po1Z/QpUbEgDrV/skq5qfQ
 Ni14VmJqez9JcSkP2foDy8PPM2tZvFnqTtcn9M6mCxxyxmOc4Z+tZ8Vi0qV6auDK2n
 SdCUZOoLrkH9A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, Bryan Brattlof
 <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>, Prasanth
 Babu Mantena <p-mantena@ti.com>, Judith Mendez <jm@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Dhruva Gole <d-gole@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Aashvij Shenai <a-shenai@ti.com>, Peng Fan
 <peng.fan@nxp.com>, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: Re: [PATCH v2 1/4] board: ti: common: Add generic AM6x board
 detection functions
In-Reply-To: <20251024-am62xeeprom-v2-1-0e372347e7d4@baylibre.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
 <20251024-am62xeeprom-v2-1-0e372347e7d4@baylibre.com>
Date: Mon, 27 Oct 2025 17:10:58 +0100
Message-ID: <87y0owjpf1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 24, 2025 at 16:17, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> Add two new generic functions for AM6x family boards to simplify
> board-specific implementations:
>
> - do_board_detect_am6(): Generic board detection function that reads
>   the on-board EEPROM. It first attempts to read at the configured
>   address, and if that fails, tries the alternate address
>   (CONFIG_EEPROM_CHIP_ADDRESS + 1). This provides a common
>   implementation that can be used across different AM6x boards.
>
> - setup_serial_am6(): Sets up the serial number environment variable
>   from the EEPROM data. The serial number is converted from
>   hexadecimal string format to a 16-character hexadecimal
>   representation and stored in the "serial#" environment variable.
>
> Both functions are protected by CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
> and are designed to be used by AM62x, AM64x, AM65x, and other AM6x
> family boards.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  board/ti/common/board_detect.c | 43 ++++++++++++++++++++++++++++++++++++++++++
>  board/ti/common/board_detect.h | 22 +++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> index a43cc075b92..d49e26fa453 100644
> --- a/board/ti/common/board_detect.c
> +++ b/board/ti/common/board_detect.c
> @@ -824,3 +824,46 @@ bool __maybe_unused board_ti_was_eeprom_read(void)
>  	else
>  		return false;
>  }
> +
> +#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
> +int do_board_detect_am6(void)
> +{
> +	int ret;
> +
> +	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> +					 CONFIG_EEPROM_CHIP_ADDRESS);
> +	if (ret) {
> +		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
> +		       CONFIG_EEPROM_CHIP_ADDRESS,
> +		       CONFIG_EEPROM_CHIP_ADDRESS + 1);
> +		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> +						 CONFIG_EEPROM_CHIP_ADDRESS +
> +							 1);
> +		if (ret)
> +			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
> +			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +void setup_serial_am6(void)
> +{
> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> +	unsigned long board_serial;
> +	char *endp;
> +	char serial_string[17] = { 0 };
> +
> +	if (env_get("serial#"))
> +		return;
> +
> +	board_serial = simple_strtoul(ep->serial, &endp, 16);
> +	if (*endp != '\0') {
> +		pr_err("Error: Can't set serial# to %s\n", ep->serial);
> +		return;
> +	}
> +
> +	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
> +	env_set("serial#", serial_string);
> +}
> +#endif
> diff --git a/board/ti/common/board_detect.h b/board/ti/common/board_detect.h
> index b057f3b2269..26ada2a449c 100644
> --- a/board/ti/common/board_detect.h
> +++ b/board/ti/common/board_detect.h
> @@ -313,6 +313,28 @@ int __maybe_unused ti_i2c_eeprom_am6_get(int bus_addr, int dev_addr,
>   */
>  int __maybe_unused ti_i2c_eeprom_am6_get_base(int bus_addr, int dev_addr);
>  
> +/**
> + * do_board_detect_am6() - Detect AM6x board and read EEPROM data
> + *
> + * This is a generic board detection function for AM6x family boards.
> + * It attempts to read the on-board EEPROM at the configured address,
> + * and if that fails, tries the alternate address (CONFIG_EEPROM_CHIP_ADDRESS + 1).
> + *
> + * Return: 0 on success or corresponding error on failure.
> + */
> +int do_board_detect_am6(void);
> +
> +/**
> + * setup_serial_am6() - Setup serial number environment variable for AM6x boards
> + *
> + * This function reads the serial number from the AM6x EEPROM data and
> + * sets the "serial#" environment variable. The serial number is converted
> + * from hexadecimal string format to a 16-character hexadecimal representation.
> + *
> + * EEPROM should be already read before calling this function.
> + */
> +void setup_serial_am6(void);
> +
>  #ifdef CONFIG_TI_I2C_BOARD_DETECT
>  /**
>   * board_ti_is() - Board detection logic for TI EVMs
>
> -- 
> 2.34.1
