Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE29C27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 10:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5471D885FF;
	Fri, 31 May 2024 12:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717150627;
	bh=aHvDuoLFDMzHFvHl6tjOd4dK+4cW9WA47NmN8KA22zY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8owrFyRsY8GhYvqf81pHO6WGxm1p958khPE69Hf4HAXRaQZeLNG0mhqEWxt0nc2S
	 mg4ovoOOGTrJxOpTiozAPZ3kr9nQ+YofMIiHMh7i2JEgSJOLC5DRDGY48bWEKZdqRP
	 9mD8rn1WyvQhk6XggQcKmKOggmfrOe3iIy9cQRq81g4vAbnhIB5WeOqbdRMMfO2QTg
	 q2ThDi3Q2TaQr+Kek9+W7N9HEFs0DWBMRmnLaYrx0WRn7QHm+azBkBVV9E6tbY8b+y
	 rtGpgHLLFcXzHcernR2GwTNxxdO0+iHTl0G8XDx2Y9WFjBaGEbxwXk9OG7Zbc+2MhP
	 azHrxLfrwd1Nw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8025883A0;
 Fri, 31 May 2024 12:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717150626;
 bh=aHvDuoLFDMzHFvHl6tjOd4dK+4cW9WA47NmN8KA22zY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cPIYKtic86HVd2s48IQvSilW/y53rxXjPEgfnMrQKUE7QDrZXL5L6z0Bcg1gWHb4K
 IUsHseGk04uXtjkpOQ4fdz/EIx9WsjCzD+TsyBFA7+La4iTgsLdiZ0+qrs5RfPnmXX
 LYZBAoT3jsRUoGcHEisZNf5oABVNjZnjP6EuWGCuk5bx/evbKapHIy5jrrYMZF5WjK
 JgLIJEpTbSC/V04GiZy/43oDJ0+eHrjacqnJkjmiZlpLP95gksohaFot3g32YopdM+
 QqJIw6LkQj9wQa6dNLGmOUpBdUNG1IeJM52cAmaHkYGBvqEU/u6TOe2DFbzELoBmpO
 aJrT/FklPpcJA==
Message-ID: <9ef2b0f0-13b7-4caf-8f99-7803dffc2afb@denx.de>
Date: Fri, 31 May 2024 12:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
To: Elena Popa <elena.popa@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
 <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/28/24 1:04 PM, Elena Popa wrote:
>>> We've noticed that, at least, on the i.MX8M* platforms
>>
>> Which exact platforms, which SoC, which board ?
> 
> Currently I'm testing on the i.MX8M Plus EVK.
>>
>>> , some USB devices (especially USB2.0 sticks) fail
>>
>> Which exact sticks ? USB IDs and model would be helpful.
> 
> The stick is from EBV Generic Flash Disk, VID: 0x058f PID: 0x6387
>>
>> Which U-Boot version is this ?
> 
> The 2 errors I already listed appears using the U-Boot v2023.04.
> 
> Now I also tested on the v2024.04. These are the 3 behaviors:
> - USB device fails to init with the error: "Device not responding to set address"
> - USB device fails to init with the error: "Cannot read configuration, skipping device 058f:6387"
> - USB device succeeded to init with the following output:
> scanning bus usb@38200000 for devices... WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> 2 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> 
> The succeeded initialization is very random. Sometimes it works, sometimes not.
> 
> Looking at the commits, I saw some improvements in the xHCI driver, but still, this issue remains.
> 
> I also tried the quick fix of adding the 5ms delay for v2024.04, and it's working: the USB device succeeded to initialize every time.

Does it also work if you 'setenv usb_pgood_delay 2000' ?

Can you include the 5ms patch ?
