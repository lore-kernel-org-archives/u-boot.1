Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53CC5320E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 04:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7039488481;
	Tue, 27 Aug 2024 06:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724733062;
	bh=i527yAAQwTU/ixvLeT2c2CNB4PHqMtV5Qp/tKlYnzeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wVNF4dp/GZdvHw8iVDBzuXm1pii8m63jFmbKNpN3M2ghUD1VAIlBrNS28X8p+8YsO
	 oLBWl2qFUDwvfe+b8zcAPKhVLmNb6N9zswq+0SEashXnCLODfILZzYR84AMyAKq2VC
	 WNU73sNqFLcwq/j6djo2aMBalghIIxqAIdKkCByjWjvsI7pbVlQpro+yq0xuw9PeG0
	 ft/pWXMaSSaRtfs8R2cAPIhC3DBkKw58L31ASfbYyXy9/Q8hHW0kydQNImwNG8V2My
	 2IFsrvllXPgA5VgODd+dBQYf5JWj0adYIpw5BAmjg222m4bMvgFDOcSaEtnjlZwauA
	 bOUZHssujfFjA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 90BD988418;
 Tue, 27 Aug 2024 06:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724733059;
 bh=i527yAAQwTU/ixvLeT2c2CNB4PHqMtV5Qp/tKlYnzeQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=szw8+Fue6//K6Z4groo79IM9JSfhq7f2iJO5O2bk2TIoc1MeUKjWAaJKiVqJ9osHR
 K0T2TfkCMNw5650CusLf5cWXc9L9iBA7SyN0eXz9EVVRSG0akc511HSeAle20eAI2+
 Upn4+0ITjGdfWOMiCeXEwqLSbttLey1V6+f+3CFgWHoPe/TDs1XmA6kPZ+9+zjYr2s
 RLjWppe9zhDZHTBfgHqbwmkbHrSYto5qpZS1SXD4+9rtS6xIT9vf53aZ04LyIrHhM3
 9iDWqhXy0vEP14XBgog+G6YSDK/14feTY5A8/jkZG+WLWEMrZDLqthRYsZ+yPJGimK
 XVKJlsgi0l60w==
Message-ID: <e6a495cc-e4bd-4b74-8c5c-3810b3b6846c@denx.de>
Date: Tue, 27 Aug 2024 06:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
References: <20240827005826.2831478-1-festevam@gmail.com>
 <20240827005826.2831478-2-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240827005826.2831478-2-festevam@gmail.com>
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

On 8/27/24 2:58 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Just like drivers/usb/host/ehci-mx6.c, add a default for
> drivers/usb/host/ehci-mx5.c.
> 
> The motivation for doing this is to remove CFG_MXC_USB_PORTSC
> from board config files.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   drivers/usb/host/ehci-mx5.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
> index 44912de7787d..d8f521befe14 100644
> --- a/drivers/usb/host/ehci-mx5.c
> +++ b/drivers/usb/host/ehci-mx5.c
> @@ -79,6 +79,10 @@
>   /* USB_CTRL_1 */
>   #define MXC_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
>   
> +#ifndef CFG_MXC_USB_PORTSC
> +#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)

Why this specific value ? (this should be in the commit message)
