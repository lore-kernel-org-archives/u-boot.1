Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B2EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B755D8693A;
	Thu, 17 Aug 2023 10:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BPvl2VaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2826986A5F; Thu, 17 Aug 2023 10:15:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F2186933
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 912EA61EB2;
 Thu, 17 Aug 2023 08:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35533C433C7;
 Thu, 17 Aug 2023 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692260122;
 bh=iFXASFJ1s7lkvqG7pOIZ5lyOCKqCEmtmV2N20gtfs+Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BPvl2VaZh3riGEr0NYlX8PihfPDUXYGBN8xLpz1W24zmmuuQhxeYHNqEonNVNlYir
 sjZhC4qln9z1Bjs39CgbfgfVLHaZmm3InBOg1vZ7+7yQqRbysYS+fX0OsxkcE1jcH+
 barxHQLoXMK74/hdoRApw9o2+x3nTMIaN9P6OeGcWgD0rgvinhfM2KzYlb+f08a+f/
 UmiRwO3ZA3id1yWrkE0zereFtc45m0BLEnIe0NQSELEZuYRITSA1Fd3TPh4dvdei4C
 1AjRgv8krp200oBeo4EcaZ4xvAUbNLCwfGsp57vi67be3OokqD8sbzBNvJdmSigclt
 mkbVm50L2egNA==
Message-ID: <d1c121d2-35b7-5097-4a02-308541c50d29@kernel.org>
Date: Thu, 17 Aug 2023 11:15:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/12] usb: cdns3: Handle otg mode as peripheral
To: Tom Rini <trini@konsulko.com>, Julien Panis <jpanis@baylibre.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tony@atomide.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, nm@ti.com
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
 <20230814171755.GB3630934@bill-the-cat>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230814171755.GB3630934@bill-the-cat>
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

Hi Tom,

On 14/08/2023 20:17, Tom Rini wrote:
> On Thu, Jul 13, 2023 at 03:45:42PM +0200, Julien Panis wrote:
> 
>> Override 'otg' to 'peripheral' mode, since 'otg' mode
>> is not yet supported by u-boot.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/usb/cdns3/core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 644a9791b9c9..bd763fc593e1 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -149,6 +149,10 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>  
>>  	dr_mode = best_dr_mode;
>>  
>> +	/* u-boot doesn't yet support OTG so limit to PERIPHERAL */
>> +	if (dr_mode == USB_DR_MODE_OTG)
>> +		dr_mode = USB_DR_MODE_PERIPHERAL;
>> +
>>  #if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>>  	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>>  		ret = cdns3_host_init(cdns);
> 
> Julien, why don't we support otg mode here?
> 

dr_mode will never be OTG at this point as the previous if condition
would have forced it to PERIPHERAL.

My understanding was that u-boot USB framework doesn't support OTG mode
so we force it to PERIPHERAL.

-- 
cheers,
-roger
