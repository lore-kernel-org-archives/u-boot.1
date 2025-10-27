Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B248FCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443C1836C8;
	Mon, 27 Oct 2025 17:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HD+KVXJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40398836D1; Mon, 27 Oct 2025 17:15:31 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030FC800B1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DEA743A30;
 Mon, 27 Oct 2025 16:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C382C116B1;
 Mon, 27 Oct 2025 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761581727;
 bh=82sdCja0yB+6dntEpbQgZQ36IHo5FipKFpjke0H3eso=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HD+KVXJN6AkNmCGUn8wOYwNwH5JbVhm/71Y2Y+p9sW09K6xOb1ywyHWsqLD5Gayrh
 kkNt5jZTCbk6i8lRY76lT+RbP5oRwJRYtBu/n2vJcYSHKvfdklb3+y4fNw4zpd1KEd
 Qkm7Ww/j6yc34iObOv+1KASGrOkDFs3ZANKyx5loftgk7Yl1BHkhrKsygWG1lcIEhg
 AnOV9rMcYvmQS+JJnTNjOFmTwqE/HSuRURQ+kVHVHMczcDItUN5GbTs3fVP6m4KCJs
 K50YNLbvXjzAw8ZpncMPKJb7LwDakD3wHHf7qZe/ol2hHUae4ocGe0twuQ69I2GPdN
 2YRevSvHkB/lQ==
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
Subject: Re: [PATCH v2 3/4] board: am64x: Use generic AM6x board detection
 functions
In-Reply-To: <20251024-am62xeeprom-v2-3-0e372347e7d4@baylibre.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
 <20251024-am62xeeprom-v2-3-0e372347e7d4@baylibre.com>
Date: Mon, 27 Oct 2025 17:15:24 +0100
Message-ID: <87sef4jp7n.fsf@kernel.org>
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

> Replace the board-specific implementation of do_board_detect() and
> setup_serial() with calls to the generic do_board_detect_am6() and
> setup_serial_am6() functions.
>
> The generic function provides the same functionality with
> additional fallback logic to try alternate EEPROM addresses.

The am64x board-specific one also has the fallback logic.

Since that's a minor commit message nitpick:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  board/ti/am64x/evm.c | 45 +++------------------------------------------
>  1 file changed, 3 insertions(+), 42 deletions(-)
>
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index f9bb593e4c6..3688cf2ca25 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -114,30 +114,11 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
>  #endif
>  
>  #ifdef CONFIG_TI_I2C_BOARD_DETECT
> -int do_board_detect(void)
> -{
> -	int ret;
> -
> -	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> -					 CONFIG_EEPROM_CHIP_ADDRESS);
> -	if (ret) {
> -		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
> -			CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
> -		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> -						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
> -		if (ret)
> -			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
> -			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
> -	}
> -
> -	return ret;
> -}
> -
>  int checkboard(void)
>  {
>  	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>  
> -	if (!do_board_detect())
> +	if (!do_board_detect_am6())
>  		printf("Board: %s rev %s\n", ep->name, ep->version);
>  
>  	return 0;
> @@ -154,7 +135,7 @@ static void setup_board_eeprom_env(void)
>  {
>  	char *name = "am64x_gpevm";
>  
> -	if (do_board_detect())
> +	if (do_board_detect_am6())
>  		goto invalid_eeprom;
>  
>  	if (board_is_am64x_gpevm())
> @@ -169,26 +150,6 @@ invalid_eeprom:
>  	set_board_info_env_am6(name);
>  	ti_set_fdt_env(name, ti_am64_evm_fdt_map);
>  }
> -
> -static void setup_serial(void)
> -{
> -	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> -	unsigned long board_serial;
> -	char *endp;
> -	char serial_string[17] = { 0 };
> -
> -	if (env_get("serial#"))
> -		return;
> -
> -	board_serial = hextoul(ep->serial, &endp);
> -	if (*endp != '\0') {
> -		pr_err("Error: Can't set serial# to %s\n", ep->serial);
> -		return;
> -	}
> -
> -	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
> -	env_set("serial#", serial_string);
> -}
>  #endif
>  #endif
>  
> @@ -199,7 +160,7 @@ int board_late_init(void)
>  		struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>  
>  		setup_board_eeprom_env();
> -		setup_serial();
> +		setup_serial_am6();
>  		/*
>  		 * The first MAC address for ethernet a.k.a. ethernet0 comes from
>  		 * efuse populated via the am654 gigabit eth switch subsystem driver.
>
> -- 
> 2.34.1
