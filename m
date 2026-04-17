Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FC7F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3E9843C7;
	Fri, 17 Apr 2026 14:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="xTYdPXFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBFA83EEF; Fri, 17 Apr 2026 14:07:01 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2176383B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:06:57 +0200 (CEST)
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
 bh=Mv1rMWnFpt33w77KvbOJH9Rr39oRAOylkm0xXwzgvD4=; b=xTYdPXFEuDWJWjN2hZhhG+Cx1u
 DGJ80Xw2+V57ypfpVmEIVGxg3hCfqZOvVSvNr7bRlExdb+1GJT+4VfItMmYcUDdOPdCCAhgIcEWn4
 Rtf1Z4zZ6eP5VLjglRkNdaE/RV73GgNK2uy/jIrEuFSoubH26Ppuyjm+jIPkUN6iDfyFmg0PXQIgz
 PdTidMPrflW1wdVQQwubHbZTL8bCeMXpp+Xv1hGczWaIExalg337YNd98kS9qnQvWEpGZi6rbNwhQ
 SeYE4eyL8VKeeccEZ3VbcHgfKE9Cb/m/QYf2DLgIVruNdNlPF4QKWD2IBXufGjcCnWIIeuPB8Op97
 az8WTC0Q==;
Received: from [115.246.246.98] (port=10849 helo=zimbra.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <parvathi@couthit.com>)
 id 1wDhyI-00000005xNI-43r8; Fri, 17 Apr 2026 08:06:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id 4B6BC1A04A7E;
 Fri, 17 Apr 2026 17:36:48 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k3wzODksgMvu; Fri, 17 Apr 2026 17:36:47 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id 4EFF51A04B9E;
 Fri, 17 Apr 2026 17:36:47 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id CE_JmD0IjDYi; Fri, 17 Apr 2026 17:36:47 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
 by zimbra.couthit.local (Postfix) with ESMTP id 30D781A04B9D;
 Fri, 17 Apr 2026 17:36:47 +0530 (IST)
Date: Fri, 17 Apr 2026 17:36:47 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, u-boot@lists.denx.de, 
 trini@konsulko.com, Maarten Brock <Maarten.Brock@sttls.nl>, 
 kory maincent <kory.maincent@bootlin.com>, sbellary@baylibre.com, 
 romain gantois <romain.gantois@bootlin.com>, 
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
 praneeth <praneeth@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
 danishanwar <danishanwar@ti.com>, m-malladi <m-malladi@ti.com>, 
 krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
 pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>
Message-ID: <1738882833.949820.1776427607139.JavaMail.zimbra@couthit.local>
In-Reply-To: <DHUF0R06L66I.OSJLU3XXXRAJ@baylibre.com>
References: <20260407082402.2311644-1-parvathi@couthit.com>
 <DHUF0R06L66I.OSJLU3XXXRAJ@baylibre.com>
Subject: Re: [PATCH] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.10.233]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: board: ti: am335x: Conditional MDIO PAD configuration instead of
 static for AM335_ICE
Thread-Index: dSCI1eyIW/SRmMzfXVbkFXJA4RrbnQ==
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
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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
 
> On Tue Apr 7, 2026 at 10:22 AM CEST, Parvathi Pudi wrote:
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
> 
> Do you have a specific use case here?
> 

We have an ICSSM PRUETH Ethernet use case. The existing static MDIO pinmux
configuration has been hard-coded for CPSW. Based on the hardware jumper
setting we configure the MDIO either for CPSW or for the ICSSM PRUETH use case.

>>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>  board/ti/am335x/board.c | 22 ++++++++++++++++++++++
>>  board/ti/am335x/mux.c   |  2 --
>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
>> index 90e37a8d913..abeab809387 100644
>> --- a/board/ti/am335x/board.c
>> +++ b/board/ti/am335x/board.c
>> @@ -61,6 +61,18 @@ DECLARE_GLOBAL_DATA_PTR;
>>  #define GPIO_ETH0_MODE		GPIO_TO_PIN(0, 11)
>>  #define GPIO_ETH1_MODE		GPIO_TO_PIN(1, 26)
>>  
>> +#define AM335X_PIN_MDIO	0x948
>> +#define AM335X_PIN_MDC		0x94c
> 
> These two are not aligned when applied.
> 

We will fix this in the next version.

>> +
>> +#define GPIO_MDIO_DATA		CTRL_BASE + AM335X_PIN_MDIO
>> +#define GPIO_MDIO_CLK		CTRL_BASE + AM335X_PIN_MDC
>> +
>> +/* Enabling MDIO_DATA by setting MUX_MODE to 0, RXACTIVE, PULLUP_EN bits */
>> +#define PAD_CONFIG_MDIO_DATA	0x30
>> +
>> +/* Enabling MDIO_CLK by setting MUX_MODE to 0, PULLUP_EN bit */
>> +#define PAD_CONFIG_MDIO_CLK	0x10
>> +
>>  static struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
>>  
>>  #define GPIO0_RISINGDETECT	(AM33XX_GPIO0_BASE + OMAP_GPIO_RISINGDETECT)
>> @@ -779,6 +791,16 @@ int board_init(void)
>>  			hang();
>>  		}
>>  
>> +		if (!eth0_is_mii || !eth1_is_mii) {
> 
> eth0_is_mii and eth1_is_mii is the same, as it was checked in the
> if condition above this one. You could make this an else if as well if
> you like.
> 

Sure, we will clean it up in the next version.

>> +			/* Set the Mux Mode to MDIO_DATA */
>> +			reg = readl(GPIO_MDIO_DATA);
>> +			writel(reg & PAD_CONFIG_MDIO_DATA, GPIO_MDIO_DATA);
>> +
>> +			/* Set the Mux Mode to MDIO_CLK */
> 
> Please remove comments for code that shows the same thing.
> 

We will fix this in the next version.

>> +			reg = readl(GPIO_MDIO_CLK);
>> +			writel(reg & PAD_CONFIG_MDIO_CLK, GPIO_MDIO_CLK);
> 
> Could you do the same thing in enable_board_pin_mux()? Or would it be
> possible to reuse mux.h here to avoid redefining values etc.?
> 
> Why do you use reg & PAD_CONFIG_MDIO_CLK instead of writing
> PAD_CONFIG_MDIO_CLK directly and skip the read?
> 

enable_board_pin_mux() runs before the jumper state is known, so we can't
use it here. We'll reuse the existing macros from mux.h instead to avoid
the redefinition's.

>> +		}
>> +
> 
> This snippet is in the section guarded by these:
> 
>  #if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
>    (defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
>    if (board_is_icev2()) {
> 
> Is this the same as for the original pinmux setup?
> 

We have not changed the original pinmux setup.
Can you please elaborate bit more on this?

Thanks and Regards,
Parvathi
