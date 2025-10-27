Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3934FCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5710836EE;
	Mon, 27 Oct 2025 17:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s4bxG1Pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD59836F0; Mon, 27 Oct 2025 17:18:12 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F8E800B1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C6A0F41A69;
 Mon, 27 Oct 2025 16:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BDFC4CEF1;
 Mon, 27 Oct 2025 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761581888;
 bh=shaPfImCZzWrs+HqjI4oh1eqn6HnE1WW4nXac4ao2hY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=s4bxG1PavVAIorVjhUA/FHxCLiwFHhrH+OckYAQbaSUiP3Jx+tzZe7LTXRrsadxSm
 wq8YgzW9EAg9JWmLwsst+1k393JhLF22EQ8woYQw8Y4ehMdpg0uUvwxZ9gCD09zR+e
 HBntfHPRmyVyb8NaPwyNZB4lGazGLu5Hmt1eZmtqXmOCwDy+lzB2hTV0TIKmvCNNta
 OjzMxvoYeSc0022rTB2+5bo3whYiDCXALb9Pch3K1Xp89FgmGHkgEHQ95tq1z+5SYo
 tH0bt2OCOOUPoqx9URFRwDE9otVo76iFZirvnwoUNygXNrS2XVp+GRqejwlrJ2NHeT
 3LHVXxPD4jdng==
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
Subject: Re: [PATCH v2 4/4] board: am65x: Use generic AM6x board detection
 function
In-Reply-To: <20251024-am62xeeprom-v2-4-0e372347e7d4@baylibre.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
 <20251024-am62xeeprom-v2-4-0e372347e7d4@baylibre.com>
Date: Mon, 27 Oct 2025 17:18:05 +0100
Message-ID: <87pla8jp36.fsf@kernel.org>
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

> Replace the board-specific implementation of do_board_detect()
> with a call to the generic do_board_detect_am6() function to
> avoid code duplication across AM6x family boards.
>
> The generic function provides the same functionality with
> additional fallback logic to try alternate EEPROM addresses.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  board/ti/am65x/evm.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
> index 5c45a33eac9..68606746d5f 100644
> --- a/board/ti/am65x/evm.c
> +++ b/board/ti/am65x/evm.c
> @@ -72,24 +72,11 @@ int board_fit_config_name_match(const char *name)
>  #endif
>  
>  #ifdef CONFIG_TI_I2C_BOARD_DETECT
> -int do_board_detect(void)
> -{
> -	int ret;
> -
> -	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> -					 CONFIG_EEPROM_CHIP_ADDRESS);
> -	if (ret)
> -		pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
> -		       CONFIG_EEPROM_CHIP_ADDRESS, ret);
> -
> -	return ret;
> -}
> -
>  int checkboard(void)
>  {
>  	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>  
> -	if (do_board_detect())
> +	if (do_board_detect_am6())
>  		/* EEPROM not populated */
>  		printf("Board: %s rev %s\n", "AM6-COMPROCEVM", "E3");
>  	else
> @@ -102,7 +89,7 @@ static void setup_board_eeprom_env(void)
>  {
>  	char *name = "am65x";
>  
> -	if (do_board_detect())
> +	if (do_board_detect_am6())
>  		goto invalid_eeprom;
>  
>  	if (board_is_am65x_base_board())
>
> -- 
> 2.34.1
