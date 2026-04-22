Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A197FF9EDC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964A584308;
	Wed, 22 Apr 2026 14:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="23f+/PH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96CE84198; Wed, 22 Apr 2026 14:14:03 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C3683FFA
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 14:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parvathi@couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
 References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QflfeTXZTcK5THQfpIFqDYUOKVSahcLfmD2w355EQdY=; b=23f+/PH4RQsptL1M4dljKLdWvZ
 GFXoSU5YOVXJcVL9dIYtHVoWGRcUi2o4SqB0WcPzzslMrwuQSIasqLtxiqAE18L4Et7YlK4Rc2SZg
 gr6H3qt0p4A6ONyLVxRRxw4izio/RPVo/L609ih1fvHbx58DuNTDBzgOuGOyiqXPh3kS/RZw8Qu5V
 sO6F+cf3Xn4ksRpBOWnEn6WYVrJMAxtbe/Y8+0xOoFFbv3PZ8v49jVIWVAR9MCZdpUH6F7esdiS2M
 eFTKmd/I5cT05Mp7OKthxWZNYi8yqS8aJRGVUDx9VS17lfC3GKQ7XU0ko3Vc8aYEHdj7wjXVY2+Uw
 JQbNbdIQ==;
Received: from [115.246.246.98] (port=37165 helo=zimbra.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <parvathi@couthit.com>)
 id 1wFWSl-0000000AoLH-40Aj; Wed, 22 Apr 2026 08:13:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id B17801A414CE;
 Wed, 22 Apr 2026 17:43:45 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IQE31BruTnm9; Wed, 22 Apr 2026 17:43:44 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id 4C68A1A414CA;
 Wed, 22 Apr 2026 17:43:44 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JarF3TsP3JA0; Wed, 22 Apr 2026 17:43:44 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
 by zimbra.couthit.local (Postfix) with ESMTP id 2FF211A414CE;
 Wed, 22 Apr 2026 17:43:44 +0530 (IST)
Date: Wed, 22 Apr 2026 17:43:44 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, u-boot <u-boot@lists.denx.de>, 
 trini <trini@konsulko.com>, Maarten Brock <Maarten.Brock@sttls.nl>, 
 kory maincent <kory.maincent@bootlin.com>, 
 sbellary <sbellary@baylibre.com>, 
 romain gantois <romain.gantois@bootlin.com>, 
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
 praneeth <praneeth@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
 danishanwar <danishanwar@ti.com>, m-malladi <m-malladi@ti.com>, 
 krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
 pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>
Message-ID: <2073702355.985026.1776860024162.JavaMail.zimbra@couthit.local>
In-Reply-To: <DHYUXLAXK8WY.1MYVPQJ729WGO@baylibre.com>
References: <20260421123106.2885994-1-parvathi@couthit.com>
 <DHYUXLAXK8WY.1MYVPQJ729WGO@baylibre.com>
Subject: Re: [PATCH v2] board: ti: am335x: Conditional MDIO PAD
 configuration instead of static for AM335_ICE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.10.233]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: board: ti: am335x: Conditional MDIO PAD configuration instead of
 static for AM335_ICE
Thread-Index: G83+gw8EplzvAdIGsmAsmbv5QCNmaQ==
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id:
 smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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


Hi Markus,

> On Tue Apr 21, 2026 at 2:30 PM CEST, Parvathi Pudi wrote:
>> This patch removes the static MDIO pinmux configuration from
>> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
>> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
>> were always configured for CPSW in mux.c, which could lead to
>> unnecessary pin ownership and conflicts in scenarios where CPSW
>> is not used.
>>
>> With this change, the MDIO pins are configured only when required,
>> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
>> This approach keeps Ethernet boot behavior intact and provides cleaner
>> separation between CPSW and other Ethernet use cases.
>>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 

Thanks for the review.

> Looks good to me, one nitpick inline:
> 
>> ---
>> Changes from v1 to v2 :
>> *) Adressed Markus Schneider-Pargmann's comments on this patch.
>>
>>  board/ti/am335x/board.c | 11 +++++++++++
>>  board/ti/am335x/mux.c   |  2 --
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
>> index 90e37a8d913..f0a40cb82af 100644
>> --- a/board/ti/am335x/board.c
>> +++ b/board/ti/am335x/board.c
>> @@ -28,6 +28,7 @@
>>  #include <asm/arch/mmc_host_def.h>
>>  #include <asm/arch/sys_proto.h>
>>  #include <asm/arch/mem.h>
>> +#include <asm/arch/mux.h>
>>  #include <asm/global_data.h>
>>  #include <asm/io.h>
>>  #include <asm/emif.h>
>> @@ -72,6 +73,12 @@ static struct ctrl_dev *cdev = (struct ctrl_dev
>> *)CTRL_DEVICE_BASE;
>>  #define GPIO0_IRQSTATUSRAW	(AM33XX_GPIO0_BASE + 0x024)
>>  #define GPIO1_IRQSTATUSRAW	(AM33XX_GPIO1_BASE + 0x024)
>>  
>> +static struct module_pin_mux rmii1_mdio_pin_mux[] = {
>> +	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
>> +	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
>> +	{-1},
>> +};
>> +
>>  /*
>>   * Read header information from EEPROM into global structure.
>>   */
>> @@ -779,6 +786,10 @@ int board_init(void)
>>  			hang();
>>  		}
>>  
>> +		/* Set the Mux Mode to MDIO_DATA, MDIO_CLK */
> 
> I think it is ovious by the names. Can you please remove the comment?
>

Sure, we will address this and post the next version shortly.

Thanks and Regards,
Parvathi.
