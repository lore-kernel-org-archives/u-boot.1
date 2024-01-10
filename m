Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83B2C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5454E87AEC;
	Wed, 10 Jan 2024 15:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704896000;
	bh=T9Pzonwf+GIww8cGozCfeOwxT4z20GSmJO57WG1zu80=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZgctX+UHNWhuz76mR1PzdTv/IzfM2k/9aeZWm6UMF51CUhU1d5noZYNE1ZnRe8HAy
	 FEJ/a5/v+Q7IhPuyvaFcTxzNf1N1i6qxBB4enPRM7rj7McSLxzEfl85knO0gEklRPN
	 SeaCQjfLq1/57ik1YloTxxngVOzgRQN1jgMDKNKIUCetMQw2x/AlBjWWEONmJDMFfk
	 hYjmesavYODV2cFUwteP6GUwFs+cL5JbzxaEE82jaO5alduhah7a+LVGVbYhBOcTGo
	 cRdAJMDkMaIkBs9xIfGlzOwDsFEwAHptdvPBdTc4KvjQwBxaMsghoI86Ahi+WEHcJc
	 t0YJEV4WeI1Fw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4624687AF8; Wed, 10 Jan 2024 15:13:18 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5960887A79
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4T98sQ2JZ5z9spQ;
 Wed, 10 Jan 2024 15:13:14 +0100 (CET)
Message-ID: <8f7b08b6-87bb-4fea-81b2-c70bb2be1397@denx.de>
Date: Wed, 10 Jan 2024 15:13:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231129101117.60177-1-robert.marko@sartura.hr>
 <20231129101117.60177-2-robert.marko@sartura.hr>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231129101117.60177-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/29/23 11:11, Robert Marko wrote:
> Currently, Esspresobin switch is being setup directly in last_stage_init()
> which makes it hard to add support for any other board to be setup.
> 
> So, lets just move the switch setup code to a separate function and call it
> if compatible matches, there should be no functional change.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Changes in v2:
> * Rebase on top of current master and resolve conflicts
> 
>   board/Marvell/mvebu_armada-37xx/board.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
> index 1471caa9a6..f532486b70 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -301,14 +301,12 @@ static int mii_multi_chip_mode_write(struct udevice *bus, int dev_smi_addr,
>   	return 0;
>   }
>   
> -/* Bring-up board-specific network stuff */
> -static int last_stage_init(void)
> +static int espressobin_last_stage_init(void)
>   {
>   	struct udevice *bus;
>   	ofnode node;
>   
> -	if (!CONFIG_IS_ENABLED(DM_MDIO) ||
> -	    !of_machine_is_compatible("globalscale,espressobin"))
> +	if (!CONFIG_IS_ENABLED(DM_MDIO))
>   		return 0;
>   
>   	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
> @@ -358,8 +356,17 @@ static int last_stage_init(void)
>   
>   	return 0;
>   }
> -EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
>   
> +/* Bring-up board-specific network stuff */
> +static int last_stage_init(void)
> +{
> +
> +	if (of_machine_is_compatible("globalscale,espressobin"))
> +		return espressobin_last_stage_init();
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
>   #endif
>   
>   #ifdef CONFIG_OF_BOARD_SETUP

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
