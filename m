Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E40C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 08:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109AD87BF8;
	Wed, 24 Jan 2024 09:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706085468;
	bh=66dlI/v0gOkOwnZHyVL8OyWKzYMbalVJYNa/GgDgQm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ln/R+YfYy+7egOryN8TolqM+J+3aDzjVw6wY3KuQTN6MNPzVhRvoKwoeiW0Lsi6dk
	 72I8dnlQbSZpG6KzMYwLYbNyU6l4/ljF8HwbitaRWu+ynNYlVy8pI87NWA+yMF9k+Y
	 Kbvw/9Rsn0fyYdHNMRrHCnU0iADUPuzodixZoc4I9n1BVbCk+nLW42xGj3eu90CS4O
	 NGBt3eNlPBL/1WAkELd9gBJUwidiRYV6SjeqIVjVZ8wsZjLG0QMzvbeNH1qmSyreoo
	 jLVdzpcS27X/krygGjjQbLCHmr24T2YQKybXZTBTdwHV01vXaJbxSyU018PYToE7ki
	 vYX+uSAjDdqrA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BA187C0A; Wed, 24 Jan 2024 09:37:47 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E971987BF8
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 09:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4TKclp461pz9sl3;
 Wed, 24 Jan 2024 09:37:42 +0100 (CET)
Message-ID: <5a7375c1-1b3d-4085-847e-1be68b049423@denx.de>
Date: Wed, 24 Jan 2024 09:37:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V4 2/2] configs: andes: add watchdog support fot andes
 ae350
Content-Language: en-US
To: Randolph <randolph@andestech.com>, u-boot@lists.denx.de
Cc: randolph.sklin@gmail.com, CL Wang <cl634@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
References: <20240124062133.439469-1-randolph@andestech.com>
 <20240124062133.439469-2-randolph@andestech.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240124062133.439469-2-randolph@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TKclp461pz9sl3
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

Hi Randolph,

On 1/24/24 07:21, Randolph wrote:
> It adds the ATCWDT200 support for Andes AE350 platform.
> It also enables wdt command support.
> 
> Signed-off-by: CL Wang <cl634@andestech.com>
> Signed-off-by: Randolph <randolph@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

This fails in world CI build in "test.py for sandbox":

https://dev.azure.com/sr0718/0cded7c3-6e6a-4b57-8d0f-65c99496c42f/_apis/build/builds/338/logs/181

Not sure how this is related. Could you please take a look?

Thanks,
Stefan

> ---
>   configs/ae350_rv32_defconfig         | 4 ++++
>   configs/ae350_rv32_spl_defconfig     | 4 ++++
>   configs/ae350_rv32_spl_xip_defconfig | 4 ++++
>   configs/ae350_rv32_xip_defconfig     | 4 ++++
>   configs/ae350_rv64_defconfig         | 4 ++++
>   configs/ae350_rv64_spl_defconfig     | 4 ++++
>   configs/ae350_rv64_spl_xip_defconfig | 4 ++++
>   configs/ae350_rv64_xip_defconfig     | 4 ++++
>   8 files changed, 32 insertions(+)
> 
> diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
> index 3bfa3e9f8e..35ad62c845 100644
> --- a/configs/ae350_rv32_defconfig
> +++ b/configs/ae350_rv32_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -49,3 +50,6 @@ CONFIG_BAUDRATE=38400
>   CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
> index aeb50206d2..41cd457bc3 100644
> --- a/configs/ae350_rv32_spl_defconfig
> +++ b/configs/ae350_rv32_spl_defconfig
> @@ -33,6 +33,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -58,3 +59,6 @@ CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
>   # CONFIG_BINMAN_FDT is not set
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
> index f15ec301ce..954e2f2de7 100644
> --- a/configs/ae350_rv32_spl_xip_defconfig
> +++ b/configs/ae350_rv32_spl_xip_defconfig
> @@ -34,6 +34,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -59,3 +60,6 @@ CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
>   # CONFIG_BINMAN_FDT is not set
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
> index c40eb043c5..95863595d2 100644
> --- a/configs/ae350_rv32_xip_defconfig
> +++ b/configs/ae350_rv32_xip_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -50,3 +51,6 @@ CONFIG_BAUDRATE=38400
>   CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
> index 7ae938aeb2..988214285a 100644
> --- a/configs/ae350_rv64_defconfig
> +++ b/configs/ae350_rv64_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -49,3 +50,6 @@ CONFIG_BAUDRATE=38400
>   CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
> index 68ac4325ab..e929320433 100644
> --- a/configs/ae350_rv64_spl_defconfig
> +++ b/configs/ae350_rv64_spl_defconfig
> @@ -33,6 +33,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -58,3 +59,6 @@ CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
>   # CONFIG_BINMAN_FDT is not set
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
> index 839ca335d4..3f92643b07 100644
> --- a/configs/ae350_rv64_spl_xip_defconfig
> +++ b/configs/ae350_rv64_spl_xip_defconfig
> @@ -34,6 +34,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -59,3 +60,6 @@ CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
>   # CONFIG_BINMAN_FDT is not set
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y
> diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
> index 5432b6d6d7..835f020990 100644
> --- a/configs/ae350_rv64_xip_defconfig
> +++ b/configs/ae350_rv64_xip_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
>   CONFIG_CMD_IMLS=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_WDT=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_BOOTP_PREFER_SERVERIP=y
>   CONFIG_CMD_CACHE=y
> @@ -50,3 +51,6 @@ CONFIG_BAUDRATE=38400
>   CONFIG_SYS_NS16550=y
>   CONFIG_SPI=y
>   CONFIG_ATCSPI200_SPI=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ATCWDT200=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
