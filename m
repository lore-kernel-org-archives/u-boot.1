Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668CEC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD2582935;
	Tue,  6 May 2025 16:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746541600;
	bh=5+J++HObmHstdyU86jznY6NFibxTpCSgdTrkK0OWZdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0O4Ol4+cdsJOcMWTbcr7mClc3KU1fKub+muhDy/VHOc9JjIOwvYtK692qdhAeXE3
	 K56KAZ2zNBs++mbgfXsHHEu380f/NzpYxXid4i7D4I/q5puOlSIylKTiU5oXrFJhvS
	 hn0NE6sm1wgh7Z2kFOHeCPkmPifQzxMsxDjTV42mb5/6nCUH2IE0K9dgERPXv3L5db
	 LDrxRL+/cF+LJnADdTYPjCoinerpavg8hqqwBEWAWpKTX52XlWrh1QX/CNohkx3zDG
	 IEqH7SS0XBUmUoccQFYou7VOZFM0zcGVbNPBfMYOU79Kg4vYbg7i0yG0qJICuWRM49
	 QhDF2zF1wGlXw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7327D82A0A; Tue,  6 May 2025 16:26:38 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AE382163
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZsLLL2Wqhz9tfr;
 Tue,  6 May 2025 16:26:34 +0200 (CEST)
Message-ID: <5dbac200-997b-48b9-8028-6e73e4d4189a@denx.de>
Date: Tue, 6 May 2025 16:26:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] arm: kirkwood: Remove Synology DS109 board reset_misc
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <swwa@users.sourceforge.net>
References: <20250506025843.11019-1-mibodhi@gmail.com>
 <20250506025843.11019-3-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250506025843.11019-3-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZsLLL2Wqhz9tfr
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

On 06.05.25 04:58, Tony Dinh wrote:
> Remove DS109 board reset_misc() function. U-Boot generic reset is enough.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   board/Synology/ds109/ds109.c | 18 ------------------
>   1 file changed, 18 deletions(-)
> 
> diff --git a/board/Synology/ds109/ds109.c b/board/Synology/ds109/ds109.c
> index 4f397578182..f3a914cc515 100644
> --- a/board/Synology/ds109/ds109.c
> +++ b/board/Synology/ds109/ds109.c
> @@ -97,24 +97,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -/* Synology reset uses UART */
> -#include <ns16550.h>
> -#define SOFTWARE_SHUTDOWN   0x31
> -#define SOFTWARE_REBOOT     0x43
> -#define CFG_SYS_NS16550_COM2		KW_UART1_BASE
> -void reset_misc(void)
> -{
> -	int b_d;
> -	printf("Synology reset...");
> -	udelay(50000);
> -
> -	b_d = ns16550_calc_divisor((struct ns16550 *)CFG_SYS_NS16550_COM2,
> -				   CFG_SYS_NS16550_CLK, 9600);
> -	ns16550_init((struct ns16550 *)CFG_SYS_NS16550_COM2, b_d);
> -	ns16550_putc((struct ns16550 *)CFG_SYS_NS16550_COM2,
> -		     SOFTWARE_REBOOT);
> -}
> -
>   #ifdef CONFIG_RESET_PHY_R
>   /* Configure and enable MV88E1116 PHY */
>   void reset_phy(void)

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

